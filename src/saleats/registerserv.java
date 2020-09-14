package saleats;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/registerserv")
public class registerserv extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public registerserv() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String confirmation = request.getParameter("confirmation");
		PrintWriter pw = response.getWriter();
		boolean anyErrors = false;
		boolean exists = false;
		boolean success = false;
		
		//check for empty inputs and invalid email extensions
		if(email.isEmpty() || !(email.contains(".com") || email.contains(".org") || email.contains(".net") || email.contains(".edu"))) {			
			pw.println("<p>Enter a valid email</p>");
			anyErrors = true;
		}
		if(username.isEmpty()) {
			pw.println("<p>Enter a username</p>");
			anyErrors = true;
		}
		if(password.isEmpty()) {
			pw.println("<p>Enter a password</p>");
			anyErrors = true;
		}
		if(confirmation.isEmpty() && !password.isEmpty()) {
			pw.println("<p>Please confirm your password</p>");
			anyErrors = true;
		}
		if(!confirmation.isEmpty() && !password.isEmpty() && !confirmation.equals(password)) {
			pw.println("<p>Your passwords do not match</p>");
			anyErrors = true;
		}
		//check to see if username or email already exists in our database
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		if(!anyErrors) {
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://localhost/saleats?user=root&password=root"); //URI to mysql
				st = conn.createStatement();
				rs = st.executeQuery("SELECT * FROM users WHERE email='" + email+ "'");
				while(rs.next()) {
					String tempemail = rs.getString("email");
					if(tempemail.equals(email)) {
						pw.println("<p>This email already exists in our database.</p>");
						exists = true;
					}
				}
			} catch (SQLException sqle){
				System.out.println("sqle: " + sqle.getMessage());
			}
			catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
		}
		//if everything is good ... create user(now logged in)
		if(!anyErrors && !exists ) {
			conn = null;
			st = null;
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://localhost/saleats?user=root&password=root"); //URI to mysql
				st = conn.createStatement();
				st.executeUpdate("INSERT INTO Users (email, username, password) VALUES ('"
				+ email + "', '" + username + "', '" + password + "')");
				//System.out.println("successfully registered user to the database");
				success = true;
			} catch (SQLException sqle){
				System.out.println("sqle: " + sqle.getMessage());
			}
			catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
		}
	
		if(success) {
			//if the user is successfully created... create a session variable!
			//if the user is successfully created... create a session variable!
			HttpSession session = request.getSession();
			session.setAttribute("username", username);
			//System.out.println("Session created.");
			//works! i think at least!
		}
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
