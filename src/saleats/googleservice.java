package saleats;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/googleservice")
public class googleservice extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public googleservice() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String requesttype = request.getParameter("request");
		PrintWriter pw = response.getWriter();
		System.out.println("In google service");
		
		if(requesttype.equals("check")) {
			HttpSession session = request.getSession();
			String type = (String) session.getAttribute("type");
			//System.out.println("session type: " + type);
			if(type.equals("google")) {
				//System.out.println("google session... user can add!");
				return;
			}
			else {
				pw.println("not a google user");
			}
		}
	
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
