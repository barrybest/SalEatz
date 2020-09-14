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

@WebServlet("/loginserv")
public class loginserv extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public loginserv() {
        super();
    }

    //NEED TO FIGURE OUT SESSIONS TO HAVE PEOPLE STAY SIGNED IN!
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String requesttype = request.getParameter("requesttype");
		String clientID = request.getParameter("username");
		String clientSecret = request.getParameter("password");	
		PrintWriter pw = response.getWriter();
		
		if(requesttype.equals("google")) {
			HttpSession session = request.getSession();
			session.setAttribute("username", clientID);
			session.setAttribute("type", "google");
			
			//need to see if user is in database
			Connection conn = null;
			Statement st = null;
			ResultSet rs = null;
				try {
					System.out.println("Am I getting into the database?");
					Class.forName("com.mysql.cj.jdbc.Driver");
					conn = DriverManager.getConnection("jdbc:mysql://localhost/saleats?user=root&password=root"); //URI to mysql
					st = conn.createStatement();
					System.out.println("I am connected to the database");
					rs = st.executeQuery("SELECT * FROM users WHERE username='" + clientID + "'");
					if(!rs.next()) {
						//if first google login - add to the database...
						conn = DriverManager.getConnection("jdbc:mysql://localhost/saleats?user=root&password=root"); //URI to mysql
						st.executeUpdate("INSERT INTO Users (email, username, password) VALUES ('"
								+ request.getParameter("email") + "', '" + clientID + "', '" + clientSecret + "')");
								System.out.println("successfully registered user to the database");
					}
					else {
						String temppass = rs.getString("password");
						if(temppass.contentEquals(clientSecret)) {
							//System.out.println("Success!");
						}
					}
				} catch (SQLException sqle){
					System.out.println("sqle: " + sqle.getMessage());
				}
				catch (ClassNotFoundException e) {
					e.printStackTrace();
				}
			pw.flush();	
		}
		
		else {
			boolean anyErrors = false;
			boolean noname = false;
			boolean success = false;
			if(clientID.isEmpty() || clientID.equals("")) {
				pw.println("<p>The username field cannot be empty</p>");
				//System.out.println("The username field cannot be empty");
				anyErrors = true;
				noname = true;
			}
			if(clientSecret.isEmpty()) {
				pw.println("<p>The password field cannot be empty</p>");
				//System.out.println("The password field cannot be empty");
				anyErrors = true;
				pw.flush();
				return;
				
			}
			Connection conn = null;
			Statement st = null;
			ResultSet rs = null;
			if(!noname) {
				try {
					//System.out.println("Am I getting into the database?");
					Class.forName("com.mysql.cj.jdbc.Driver");
					conn = DriverManager.getConnection("jdbc:mysql://localhost/saleats?user=root&password=root"); //URI to mysql
					st = conn.createStatement();
					//System.out.println("I am connected to the database");
					rs = st.executeQuery("SELECT * FROM users WHERE username='" + clientID + "'");
					if(!rs.next()) {
						pw.println("<p>This username does not exist</p>");
						anyErrors = true;
					}
					else {
						if(rs.getString("username").contentEquals("") || rs.getString("username") == null)
						{
							pw.println("<p>The username does not exist</p>");
							anyErrors = true;
						}
						String temppass = rs.getString("password");
						if(temppass.contentEquals(clientSecret)) {
							//this is a success
							System.out.println("Success!");
							success = true;
						}
						else {
							//this is a fail
							pw.println("<p>The username or password is incorrect</p>");
							anyErrors = true;	
						}	
					}
				} catch (SQLException sqle){
					System.out.println("sqle: " + sqle.getMessage());
				}
				catch (ClassNotFoundException e) {
					e.printStackTrace();
				}
			}
			
			pw.flush();
		
			if(success) {
				//if the user is successfully created... create a session variable!
				HttpSession session = request.getSession();
				session.setAttribute("username", clientID);
				session.setAttribute("type", "normal");
				//System.out.println("Session created.");
				//works! i think at least!
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
