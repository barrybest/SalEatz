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
		
			function getResults() {
				document.getElementById("results-header").innerHTML = "Results for " + getUrlVars()["restaurantname"];
				var xhttp = new XMLHttpRequest();
				//getting correct responses from servlet ... need to get stuff sorted in the XML
				xhttp.open("GET", "search?restaurantname=" + getUrlVars()["restaurantname"] + "&latitude=" + getUrlVars()["latitude"] 
				+ "&longitude=" + getUrlVars()["longitude"] + "&sortby=" + getUrlVars()["sortby"], true);
				xhttp.send();
				xhttp.onreadystatechange = function () {
					if(this.readyState == XMLHttpRequest.DONE){
						//going to parse on the backend so i don't royally fuck myself over with API call timeout
						var myObj = JSON.parse(this.responseText); //gets JSON object from backend
					    var test = myObj.businesses; //gets into the businesses array to access each object
					    var text = "";
					    for(i = 0; i < 10; i++){ //parses through first 10 repsonses to API
					    	var name = test[i].name; //name of restaurant
					    	var address = test[i].location.address1 + ". " + test[i].location.city + ", " + test[i].location.state + " " + test[i].location.zip_code //address of restaurant
					    	var getlink = test[i].url; //yelp link for restaurant
					    	//trim the URL for the restaurant
					    	var link = getlink.split("?", 1);
					    	var img = test[i].image_url; //img url for restaurant
					    	var id = test[i].id; //id for restaurant to search in the future
					    	//need to shorten the URL...
					    	//add link to get to the details list
							document.getElementById("resultsHere").innerHTML += "<div class=\"onesearchresult\"><div class=\"row\"><div class=\"col-sm-3\"><a href=\"details.jsp?id=" + id + "\"><img class=\"resultpic\" src=\"" + img + "\"></a></div><div class=\"col-sm-auto\" style=\"padding-left: 1vw;\"><h3 class=\"search-result-line\" style=\"font-family: Helvetica; color: #777777; font-weight: bold;\">" + name + "</h3><h4 class=\"search-result-line\" style=\"font-family: Helvetica; color: #777777; \">" + address + "</h4><h4 class=\"search-result-line\" style=\"font-family: Helvetica; color: #777777;\">" + link + "</h4></div></div></div>";
					    }
					    
					}	
				}
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
			<div style="padding-left: 6vw; padding-right: 6vw;"> <!-- search results -->
				<h2 id="results-header"></h2>
				<div id="testing"></div>
				<div class="allsearchresults" id="resultsHere">
					
				</div>
			</div>
		</div>
		<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" ></script>
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" ></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" ></script>
	</body>
</html>