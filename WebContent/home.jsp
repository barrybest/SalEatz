<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
   		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" media="screen">
		<link rel="stylesheet" type="text/css" href="home.css" media="screen">
		<title>SalEats - Home</title>
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
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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
		<script async defer
  			src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY_HERE&callback=initMap">
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
	</head>
	<body onload="sessionCheck()">
		<div class="container-fluid top-bar-padding">
			<div id="thetopbar" class="row align-items-center">
				<div class="col-sm"><h2 id="sal-eats"><a class="sallink" style="text-decoration: none;" href="home.jsp">SalEats!</a></h2></div>
				<div class="col-sm-auto"><p class="font"><a class="nav" href="home.jsp">Home</a></p></div> 
				<div class="col-sm-auto"><p class="font"><a class="nav" href="login-signup.jsp">Login / Sign Up</a></p></div>
			</div>
		</div>
		<div class="container-fluid text-center">
			<div style="padding-top: 35px; padding-bottom: 30px; padding-left: 5vw; padding-right: 5vw; margin: auto;">
				<img class="picA" src="pic.jpg"/>
			</div>
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
		</div>
		<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" ></script>
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" ></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" ></script>
	</body>
</html>