package saleats;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/loadpage")
public class loadpage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public loadpage() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//check to see if a session variable exists...
		HttpSession session = request.getSession();
		boolean success = false;
		PrintWriter pw = response.getWriter();
		String username = (String) session.getAttribute("username");
		if(username != null) {
			//System.out.println("The user signed in is: " + username);
			success = true;
		}
		//if it exists - return html of Home / Favorite / Logout
		if(success) {
			pw.println("<div class=\"col-sm\"><h2 id=\"sal-eats\"><a class=\"sallink\" style=\"text-decoration: none;\" href=\"home.jsp\">SalEats!</a></h2></div>");
			pw.println("<div class=\"col-sm-auto\"><p class=\"font\"><a class=\"nav\" href=\"home.jsp\">Home</a></p></div> ");
			pw.println("<div class=\"col-sm-auto\"><p class=\"font\"><a class=\"nav\" href=\"favorites.jsp\">Favorites</a></p></div> ");
			pw.println("<div class=\"col-sm-auto\"><p class=\"font\"><a class=\"nav\" href=\"logout\">Logout</a></p></div> ");
		}
		//if it doesn't - return html of Home / Login & Sign Up
		else {
			pw.println("<div class=\"col-sm\"><h2 id=\"sal-eats\"><a class=\"sallink\" style=\"text-decoration: none;\" href=\"home.jsp\">SalEats!</a></h2></div>");
			pw.println("<div class=\"col-sm-auto\"><p class=\"font\"><a class=\"nav\" href=\"home.jsp\">Home</a></p></div> ");
			pw.println("<div class=\"col-sm-auto\"><p class=\"font\"><a class=\"nav\" href=\"login-signup.jsp\">Login / Sign Up</a></p></div>");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
