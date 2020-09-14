package saleats;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/favoriteFunctions")
public class favoriteFunctions extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	//arrays with 
       
    public favoriteFunctions() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//get the request type
		String requesttype = request.getParameter("request");
		//get PrintWriter for responses
		PrintWriter pw = response.getWriter();
		//get username from the session....
		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");
		if(username == null) //if you are not signed in
		{
			pw.println("You are not signed in, you cannot add this restaurant to your favorites.");
			return;
		}
		//get userID for this username from the users database
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		int userID = 0; 
		try {
			System.out.println("Am I getting into the database?");
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/saleats?user=root&password=root"); //URI to mysql
			st = conn.createStatement();
			System.out.println("I am connected to the database");
			rs = st.executeQuery("SELECT * FROM users WHERE username='" + username + "'");
			if(!rs.next()) {
				pw.println("This user does not exist");
				return;
			}
			else {
				userID = rs.getInt("userID");
				System.out.println(userID + " is my userID");
			}
		} catch (SQLException sqle){
			System.out.println("sqle: " + sqle.getMessage());
		}
		catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		if(requesttype.equals("add")) { //if we are adding to the database
			//get parameters
			String id = request.getParameter("id");
			String name = request.getParameter("name");
			System.out.println(name);
			//need to deal with special characters when adding to the database
			name = name.replaceAll("'", "''"); //escapes apostrophes for adding to the database
			String address = request.getParameter("address");
			String link = request.getParameter("link");
			String img = request.getParameter("img");
			String phone = request.getParameter("phone");
			String cuisine = request.getParameter("cuisine");
			String price = request.getParameter("price");
			String rating = request.getParameter("rating");
			System.out.println(id + " " + name + " " + address + " " + link + " " + img + " " + phone + " " + cuisine + " " + price + " " + rating);
			boolean valid = true; //used to see if this restaurant has already been favorited
			//check to see if this specific user has a favorite with this restaurant
			conn = null;
			st = null;
			rs = null;
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://localhost/saleats?user=root&password=root"); //URI to mysql
				st = conn.createStatement();
				//NEED TO CHECK TO SEE IF THIS IS THE FIRST VALUE ADDED TO FAVORITES... USERID IS NULL SINCE THERE ARE NO VALUES IN THE TABLE
				rs = st.executeQuery("SELECT * FROM favorites WHERE userID='" + userID + "'");
				if(!rs.next()) {
					//no favorites for this user... we can add this restaurant to favorites
					valid = true;
				}
				else {
					while(rs.next()) {
						String tempID = rs.getString("id");
						if(tempID.equals(id)) //if we find something with the same name as this restaurant, we cannot add
							valid = false;
					}
				}
			} catch (SQLException sqle){
				System.out.println("sqle: " + sqle.getMessage());
			}
			catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
			
			//if this is new favorite, add to database and print successful message to user
			if(valid) {
				conn = null;
				st = null;
				rs = null;
				try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					conn = DriverManager.getConnection("jdbc:mysql://localhost/saleats?user=root&password=root"); //URI to mysql
					st = conn.createStatement();
					st.executeUpdate("insert into favorites (userID, id, name, address, link, img, phone, cuisine, price, rating) values ('" + userID + "', '" + id + 
							"', '" + name + "', '" + address + "', '" + link + "', '" + img + "', '" + phone + "', '" + cuisine + "', "
									+ " '" + price + "', '" + rating + "')");
					pw.println(name + " has successfully been added to your favorites");
				} catch (SQLException sqle){
					System.out.println("sqle: " + sqle.getMessage());
				}
				catch (ClassNotFoundException e) {
					e.printStackTrace();
				}
			}
			//if this has an old favorite, print error message to user
			else {
				pw.println("You have already added " + name + " to your favorites");
				
			}
		}
		else if(requesttype.equals("get")) { //if we are retrieving favorites for a user...
			//userID initialized above.
			//loop through user and create responses 1 by 1 to print back to the favorites page...
			conn = null; //too bad so sad
			st = null; //too bad so sad
			rs = null; //too bad so sad
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://localhost/saleats?user=root&password=root"); //URI to mysql
				st = conn.createStatement();
				rs = st.executeQuery("SELECT * FROM favorites WHERE userID='" + userID + "' ORDER BY favID DESC");
				//return the variables to the front-end ... formatted correctly...
				if(!rs.next()) {
					pw.println("You have not added any restaurants to your Favorites.");
				}
				else { //get the first result
					String id = rs.getString("id");
					String name = rs.getString("name");
					String address = rs.getString("address");
					String link = rs.getString("link");
					String img = rs.getString("img");
					//return the variables to the front-end ... formatted correctly...
					pw.println("<div class=\"onesearchresult\"><div class=\"row\"><div class=\"col-sm-3\"><a href=\"details.jsp?id=" + id + "\"><img class=\"resultpic\" src=\"" + img + "\"></a></div><div class=\"col-sm-auto\" style=\"padding-left: 1vw;\"><h3 class=\"search-result-line\" style=\"font-family: Helvetica; color: #777777; font-weight: bold;\">" + name + "</h3><h4 class=\"search-result-line\" style=\"font-family: Helvetica; color: #777777; \">" + address + "</h4><h4 class=\"search-result-line\" style=\"font-family: Helvetica; color: #777777;\">" + link + "</h4></div></div></div>");
				} //get all results after
				while(rs.next()) {
					//get all variables...
					String id = rs.getString("id");
					String name = rs.getString("name");
					String address = rs.getString("address");
					String link = rs.getString("link");
					String img = rs.getString("img");
					//return the variables to the front-end ... formatted correctly...
					pw.println("<div class=\"onesearchresult\"><div class=\"row\"><div class=\"col-sm-3\"><a href=\"details.jsp?id=" + id + "\"><img class=\"resultpic\" src=\"" + img + "\"></a></div><div class=\"col-sm-auto\" style=\"padding-left: 1vw;\"><h3 class=\"search-result-line\" style=\"font-family: Helvetica; color: #777777; font-weight: bold;\">" + name + "</h3><h4 class=\"search-result-line\" style=\"font-family: Helvetica; color: #777777; \">" + address + "</h4><h4 class=\"search-result-line\" style=\"font-family: Helvetica; color: #777777;\">" + link + "</h4></div></div></div>");
				}
			} catch (SQLException sqle){
				System.out.println("sqle: " + sqle.getMessage());
			}
			catch (ClassNotFoundException e) {
				e.printStackTrace();
			} finally {
				
			}
		}
		
		else if(requesttype.equals("getname")) {
			//System.out.println(username);
			pw.print(username);
			pw.flush();
		}
		
		else if(requesttype.equals("sort")) {
			String sorttype = request.getParameter("type");
			if(sorttype.equals("az")) {
				pw.println("sorted by az");
			}
			if(sorttype.equals("za")) {
				pw.println("sorted by za");
			}
			if(sorttype.equals("highlow")) {
				pw.println("sorted by highlow");
			}
			if(sorttype.equals("lowhigh")) {
				pw.println("sorted by lowhigh");
			}
			if(sorttype.equals("most")) {
				pw.println("sorted by most");
			}
			if(sorttype.equals("least")) {
				pw.println("sorted by least");
			}
			
			
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
