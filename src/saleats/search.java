package saleats;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//import org.json.JSONArray;
//import org.json.JSONException;
//import org.json.JSONObject;

@WebServlet("/search")
public class search extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static String myApiKey = "wFhkKp-rA0ANyZHTHylrS4gUvEKV26APQ-PhNPz5gllJJ6Wf31QW40x-JUt7FIhW099rD0Uf5Nz2RqhtwfyX0mflLMSs88iR7ZhF9PNaOMRJfXD1bqT5wS89GCZ4XnYx"; 
	private static HttpURLConnection connection;
	
	public search() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//System.out.println("actually getting to search");
		//get information from search query
		String restaurantname = request.getParameter("restaurantname");
		//prep the restaurantname for yelp api search...
		String rname = restaurantname.replaceAll(" ", "-");
		String latitude = request.getParameter("latitude");
		String longitude = request.getParameter("longitude");
		String sortby = request.getParameter("sortby");
		if(sortby == "undefined")
			sortby = "best_match";
		//establish printwriter to send back to browser
		PrintWriter pw = response.getWriter();
		//make the API call
		
		String line;
		StringBuffer responseContent = new StringBuffer();
		try {
			//temp url... will need to use user latitude & longitude then loop through the names of all the restaurants given in the input file
			URL url = new URL("https://api.yelp.com/v3/businesses/search?latitude=" + latitude + "&longitude=" + longitude 
					+ "&term=" + rname + "&limit=10" + "&sort_by=" + sortby);
			connection = (HttpURLConnection) url.openConnection();
			//request setup
			connection.setRequestMethod("GET");
			connection.setRequestProperty("Authorization", "BEARER " + myApiKey);
			//receive API response and parse through to acquire the latitude and longitude for each restaurant
			InputStreamReader is = new InputStreamReader(connection.getInputStream());
			BufferedReader br = new BufferedReader(is);
			while((line = br.readLine()) != null) {
				responseContent.append(line);
			}
			br.close();
			is.close();
			pw.println(responseContent.toString());
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			pw.flush();
			pw.close();
			connection.disconnect();
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	

}
