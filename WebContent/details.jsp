<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
   		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" media="screen">
		<link rel="stylesheet" type="text/css" href="home.css" media="screen">
		<title>SalEats - Results</title>
		<script>
		/* Open when someone clicks on the span element */
		function openNav() {
		  document.getElementById("myNav").style.width = "100%";
		}

		/* Close when someone clicks on the "x" symbol inside the overlay */
		function closeNav() {
		  document.getElementById("myNav").style.width = "0%";
		}
		</script>
		<script>  
			var map
			var marker
			function initMap() {
	    		var la = {lat: 34.05223, lng: -118.24368};
	    		map = new google.maps.Map(
	    	    document.getElementById('map-api'), {zoom: 10, center: la});
	    	  // The marker, positioned at Uluru
	    	  	marker = new google.maps.Marker({position: la, map: map});	  
	    	  	google.maps.event.addListener(map, 'click', function(event) {
	    	  		marker.setPosition(event.latLng);
	    	  		//update latitude and longitude fields with location of new marker
	    	  		$('#glat1').val(event.latLng.lat());
	    	  		$('#glng1').val(event.latLng.lng());
				});
	      	}
		</script> 
		
		<script>
			function sessionCheck() {
				//alert("Checking if a session exists!");	//do stuff here to check the sessions woot woot!!!!
				var xhttp = new XMLHttpRequest();
				//getting correct responses from servlet ... need to get stuff sorted in the XML
				xhttp.open("GET", "loadpage", true);
				xhttp.send();
				xhttp.onreadystatechange = function () {
					if(this.readyState == XMLHttpRequest.DONE){
						document.getElementById("thetopbar").innerHTML = this.responseText;
					}	
				}
			}
		</script>
		<script>
			function validateFields() {
				var errors = false;
				if( document.searchattributes.restaurantname.value == "" ) {
		            document.getElementById("rerror").innerHTML = "<p>Enter a restaurant name.</p>";
		          	errors = true;  
		        }
				else {
					document.getElementById("rerror").innerHTML = "";
				}
				if(document.searchattributes.latitude.value == "") {
					document.getElementById("laterror").innerHTML = "<p>Enter a latitude</p>";
					errors = true;
				}
				else {
					document.getElementById("laterror").innerHTML = "";
				}
				if(document.searchattributes.latitude.value == "") {
					document.getElementById("longerror").innerHTML = "<p>Enter a longitude</p>";
					errors = true;
				}
				else {
					document.getElementById("longerror").innerHTML = "";
				}
				return (!errors);
			}
		</script>
		<script>
			//parse URL to get parameteres
			function getUrlVars() {
			    var vars = {};
			    var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
			        vars[key] = value;
			    });
			    return vars;
			}
			
			//global variables!
			var name
			var id
			var address
			var link
			var img
			var phone
			var cuisine
			var price
			var rating
			function getResults() {
				var xhttp = new XMLHttpRequest();
				//getting correct responses from servlet ... need to get stuff sorted in the XML
				xhttp.open("GET", "detailsearch?id=" + getUrlVars()["id"], true);
				xhttp.send();
				xhttp.onreadystatechange = function () {
					if(this.readyState == XMLHttpRequest.DONE){
						//going to parse on the backend so i don't royally fuck myself over with API call timeout
						var test = JSON.parse(this.responseText); //gets JSON object from backend
					    name = test.name; //name of restaurant
					    address = test.location.address1 + ". " + test.location.city + ", " + test.location.state + " " + test.location.zip_code
					    var getlink = test.url; //yelp link for restaurant
					    //trim the URL for the restaurant
					    link = getlink.split("?", 1);
					    img = test.image_url; //img url for restaurant
					    id = test.id; //id for restaurant to search in the future
					    phone = test.display_phone;
					    cuisine = test.categories[0].title;
					    price = test.price;
					    rating = test.rating;
					    //turn rating into stars??
					    document.getElementById("results-header").innerHTML = "<p id=\"rname\" value=\"" + name + "\">" + name + "</p>";
					    //no idea if this works
					    //document.getElementById("results-header").value = name;
						document.getElementById("detail").innerHTML = "<div class=\"onesearchresult\"><div class=\"row\"><div class=\"col-sm-3\"><a href=\"" + link + "\"><img class=\"resultpic\" src=\"" + img + "\"></a></div><div class=\"col-sm-auto\" style=\"padding-left: 1vw;\"><h4 id=\"thisaddress\" value=\"" + address + "\" class=\"search-result-line\" style=\"font-family: Helvetica; color: #777777; \">Address: " + address + "</h4><h4 class=\"search-result-line\" style=\"font-family: Helvetica; color: #777777; \">Phone No: " + phone + "</h4><h4 class=\"search-result-line\" style=\"font-family: Helvetica; color: #777777;\">Cuisine: " + cuisine + "</h4><h4 class=\"search-result-line\" style=\"font-family: Helvetica; color: #777777; \">Price: " + price + "</h4><h4 class=\"search-result-line\" style=\"font-family: Helvetica; color: #777777;\">Rating: " + rating + "</h4></div></div></div>";   
					}	
				}
			}
			
			function addfavorite() {
				var xhttp = new XMLHttpRequest();
				//getting correct responses from servlet ... need to get stuff sorted in the XML
				xhttp.open("GET", "favoriteFunctions?request=add&id=" + window.id + "&name=" + window.name + "&address=" + window.address + "&link=" 
						+ window.link + "&img=" + window.img + "&phone=" + window.phone + "&cuisine=" + window.cuisine + "&price=" + window.price 
						+ "&rating=" + window.rating, true);
				xhttp.send();
				xhttp.onreadystatechange = function () {
					if(this.readyState == XMLHttpRequest.DONE){
						//notify the user that the location has been added to your database
						alert(this.responseText);
					}
				}
			}
			
			function addreservation() {
				//check to see if user is logged in...
				var xhttp = new XMLHttpRequest();
				//getting correct responses from servlet ... need to get stuff sorted in the XML
				xhttp.open("GET", "googleservice?request=check", true);
				xhttp.send();
				xhttp.onreadystatechange = function () {
					if(this.readyState == XMLHttpRequest.DONE){
						if(this.responseText.length == 0) {
							document.getElementById("google-calendar").innerHTML = "<form name=\"calendar\" onsubmit=\"return submitRes()\"><div class=\"row\" style=\"padding-bottom: 10px;\"><div class=\"col-sm\"><input type=\"date\" id=\"resdate\" placeholder=\"Date\"></div><div class=\"col-sm\"><input type=\"time\" id=\"restime\" placeholder=\"Time\"></div></div><div class=\"row\" style=\"padding-bottom: 10px;\"><div class=\"col-sm\"><input type=\"text\" id=\"resnotes\" placeholder=\"Reservation Notes\"></div></div><div class=\"row\"><div class=\"col-sm\" style=\"padding-bottom: 10px;\"><button type=\"Submit\" id=\"subres-button\"> Submit Reservation</button></div></div></form>";
						
						}
						else {
							alert("You are not signed in through Google - you cannot add a reservation");
						}
					}
				}
				
			}
			
			function submitRes() {
				var resdate = document.calendar.resdate.value.split("-").join("");
				var restime = document.calendar.restime.value.split(":").join("");
				var rescombo = resdate + "T" + restime + "00";
				var resnotes = document.calendar.resnotes.value;
				
				//alert(document.getElementById("address"))

				window.location.href = "http://www.google.com/calendar/render?action=TEMPLATE" +
						"&text=" + "Reservation at " + document.getElementById("rname").textContent + 
						"&dates=" + rescombo + "/" + rescombo + "&details=" + resnotes +
						"&location=" + document.getElementById("thisaddress").textContent + 
						"&sf=true&output=xml";
				
				return false;
			
			}
		</script>
		<!-- imported script -->
		<script async defer
  			src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY_HERE&callback=initMap">
		</script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	</head>
	<body onload="sessionCheck(); getResults();">
		<div class="container-fluid top-bar-padding">
			<div id="thetopbar" class="row align-items-center">
				<div class="col-sm"><h2 id="sal-eats"><a class="sallink" style="text-decoration: none;" href="home.jsp">SalEats!</a></h2></div>
				<div class="col-sm-auto"><p class="font"><a class="nav" href="home.jsp">Home</a></p></div> 
				<div class="col-sm-auto"><p class="font"><a class="nav" href="login-signup.jsp">Login / Sign Up</a></p></div>
			</div>
		</div>	
		<div style="padding-top: 35px;">
			</div>
		<div id="myNav" class="overlay">
			<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
			<div id="map-api" class="overlay-content"></div>
		</div>
		<div class="container-fluid">
			<form method="GET" action="search-results.jsp" name="searchattributes" onsubmit="return validateFields()">
				<div class="search-row">
					<div class="row">
						<div class="col-sm-7">
							<div class="form-group">
								<input type="text" class="form-control" placeholder="Restaurant Name" id="123" name="restaurantname">
								<span id="rerror" class="form-error"></span>
							</div>
						</div>
						<div class="col-sm-auto">
							<button type="Submit" id="search-button"></button>
						</div>
						<div class="col-sm">
							<div class="row">
								<div class="col-sm-7 r-buttons">
									<!-- <input type="radio" class="" name="sortby" value="bestmatch"> Best Match -->
									<label class="radiocontainer"> Best Match
										<input type="radio" name="sortby" checked="checked" value="best_match">
										<span class="circle"></span>
									</label>
								</div>
								<div class="col-sm-5 r-buttons">
									<label class="radiocontainer"> Reviews
										<input type="radio" name="sortby" value="review_count">
										<span class="circle"></span>
									</label>
								</div>
							</div>
							<div class="row" style="padding-left: 1vh;">
								<div class="col-sm-7 r-buttons">
									<label class="radiocontainer"> Rating
										<input type="radio" name="sortby" value="rating">
										<span class="circle"></span>
									</label>
								</div>
								<div class="col-sm-5 r-buttons">
									<label class="radiocontainer"> Distance
										<input type="radio" name="sortby" value="distance">
										<span class="circle"></span>
									</label>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="search-row">
					<div class="row">
						<div class="col-sm">
							<div class="form-group">
								<input type="number" class="form-control" min="-90" max="90" step="0.00000000000001" id="glat1" placeholder="Latitude" name="latitude">
								<span id="laterror" class="form-error"></span>
							</div>
						</div>
						<div class="col-sm">
							<div class="form-group">
								<input type="number" class="form-control" min="-180" max="180" step="0.00000000000001" id="glng1" placeholder="Longitude" name="longitude">
								<span id="longerror" class="form-error"></span>
							</div>
						</div>
						<div class="col-sm">
							<button type="button" id="google-button" name="google-pin" onclick="openNav()"> Google Maps (Drop a pin)</button>
						</div>
					</div>
				</div>
			</form>
			<div style="padding-left: 6vw; padding-right: 6vw;"> <!-- individual result for single location -->
				<h2 id="results-header"></h2>
				<div class="details" id="detail">
					
				</div>
				<div id="detail-buttons">
					<div style="padding-bottom: 10px;"><button type="button" id="addfav-button" name="addfav" onclick="addfavorite()"> Add to Favorites</button></div>
					<div style="padding-bottom: 10px;"><button type="button" id="addres-button" name="addres" onclick="addreservation()"> Add Reservation</button></div>
					<div id="google-calendar">

					</div>
				</div>
			</div>
		</div>
		<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" ></script>
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" ></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" ></script>
	</body>
</html>