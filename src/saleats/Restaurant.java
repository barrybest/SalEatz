package saleats;

import java.util.Vector;

public class Restaurant {
	
	public static Vector<Restaurant> rList = new Vector<Restaurant>();
	
	private String name;
	private String address;
	private String phone;
	private String yelpURL;
	private String imgURL;
	private String cuisine;
	private String price;
	private double rating;
	
	public Restaurant(String name, String address, String phone, String yelpURL, String imgURL, String cuisine, String price, double rating) {
		this.name = name;
		this.address = address;
		this.phone = phone;
		this.yelpURL = yelpURL;
		this.imgURL = imgURL;
		this.cuisine = cuisine;
		this.price = price;
		this.rating = rating;
		
	}

	public void addRestaurant(Restaurant r) {
		rList.add(r);
	}
	
	public Restaurant getRestaurant(String r) {
		for(Restaurant res : rList) {
			if(res.getName().equals(r)) {
				return res; 
			}
		}
		return null;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getYelpURL() {
		return yelpURL;
	}

	public void setYelpURL(String yelpURL) {
		this.yelpURL = yelpURL;
	}

	public String getImgURL() {
		return imgURL;
	}

	public void setImgURL(String imgURL) {
		this.imgURL = imgURL;
	}

	public String getCuisine() {
		return cuisine;
	}

	public void setCuisine(String cuisine) {
		this.cuisine = cuisine;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public double getRating() {
		return rating;
	}

	public void setRating(double rating) {
		this.rating = rating;
	}
	
}
