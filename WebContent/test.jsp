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
			function test() {
				alert("Googe API here!")
			}
		</script>
	</head>
	<body>
		<div class="container-fluid">
			<div class="top-bar-padding">
				<div class="row align-items-center">
					<div class="col-sm"><h2 id="sal-eats">SalEats!</h2></div>
					<div class="col-sm-auto"><p class="font">Home</p></div> 
					<div class="col-sm-auto"><p class="font">Login / Sign Up</p></div>
				</div>
			</div>	
			<div style="padding-top: 35px; padding-bottom: 30px; padding-left: 5vh; padding-right: 5vh;">
				<div class="row justify-content-center">
				<img class="picA" src="pic.jpg"/>
				</div>
			</div>
			<form method="GET" action="tobenamed" name="searchattributes">
				<div class="search-row">
					<div class="row">
						<div class="col-sm-7">
							<div class="form-group">
								<input type="text" class="form-control" placeholder="Restaurant Name" name="restaurantname">
							</div>
						</div>
						<div class="col-sm-auto">
							<button id="search-button"></button>
						</div>
						<div class="col-sm">
							<div class="row">
								<div class="col-sm-7 r-buttons">
									<!-- <input type="radio" class="" name="sortby" value="bestmatch"> Best Match -->
									<label class="radiocontainer"> Best Match
										<input type="radio" name="sortby" value="bestmatch">
										<span class="circle"></span>
									</label>
								</div>
								<div class="col-sm-5 r-buttons">
									<label class="radiocontainer"> Reviews
										<input type="radio" name="sortby" value="reviews">
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
								<input type="number" class="form-control" min="-90" max="90" placeholder="Latitude" name="latitude">
							</div>
						</div>
						<div class="col-sm">
							<div class="form-group">
								<input type="number" class="form-control" min="-180" max="180" placeholder="Longitude" name="longitude">
							</div>
						</div>
						<div class="col-sm">
							<button type="button" id="google-button" name="google-pin" onclick="test()"> Google Maps (Drop a pin)</button>
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