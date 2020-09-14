<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
   		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
   		<meta name="google-signin-client_id" content="YOUR_CLIENT_ID_HERE.apps.googleusercontent.com">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" media="screen">
		<link rel="stylesheet" type="text/css" href="home.css" media="screen">
		<title>SalEats - Login/Sign Up</title>
		<script src="https://apis.google.com/js/api:client.js"></script>
		<script src="https://apis.google.com/js/platform.js" async defer></script>
		<!-- google sign in script -->
		<script>
			var googleUser = {};
			var startApp = function() {
		   		gapi.load('auth2', function(){
		   	 		// Retrieve the singleton for the GoogleAuth library and set up the client.
		    		auth2 = gapi.auth2.init({
		        		client_id: 'YOUR_CLIENT_ID_HERE.apps.googleusercontent.com',
		        		cookiepolicy: 'single_host_origin',
		        		// Request scopes in addition to 'profile' and 'email'
		        		//scope: 'additional_scope'
					});
		    	attachSignin(document.getElementById('google-sign'));
		    	});
		  	};
			function attachSignin(element) {
		    	auth2.attachClickHandler(element, {},
		        function(googleUser) {
		    		 var emptyResult = false;
		             $.ajax({
		                 url: "loginserv",
		                 async: false,
		                 data: {
		                     requesttype: 'google',
		                     username: googleUser.getBasicProfile().getName(),
		                     password: "google",
		                     email: googleUser.getBasicProfile().getEmail()
		                 },
		                 success: function(result) {
		                     if(result.length == 0) {
		                         emptyResult = true;
		                     } else {
		                         $("#loginerror").html(result);
		                     }
		                 }
		             });
		             if(emptyResult) {
		                 window.location.href = "home.jsp";
		             }
		             return emptyResult;
		        	
		        }, function(error) {
		          alert(JSON.stringify(error, undefined, 2));
		        });
		  	}
		</script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		<script>
		//waiting on these functions to see what i can do with 
			//JS to validate the login funciton
			function validateLog() {
				var xhttp = new XMLHttpRequest();
				//getting correct responses from servlet ... need to get stuff sorted in the XML
				xhttp.open("GET", "loginserv?username=" + document.login.username.value + "&password=" + document.login.password.value + "&requesttype=normal", true);
				xhttp.send();
				xhttp.onreadystatechange = function () {
					if(this.readyState == XMLHttpRequest.DONE){
						document.getElementById("loginerror").innerHTML = this.responseText;
						if(this.responseText.length > 0)
						{
							return false;
						}
						else { //i don't know if this will forward sessions or if it just redirects to the home page
							window.location = "home.jsp";
							return true;
						}
					}	
				}		
			}
			function validateReg() {
				var xhttp = new XMLHttpRequest();
				//getting correct responses from servlet ... need to get stuff sorted in the XML
				xhttp.open("GET", "registerserv?email=" + document.signup.email.value +  "&username=" + document.signup.username.value 
						+ "&password=" + document.signup.password.value + "&confirmation=" + document.signup.confirmation.value, true);
				xhttp.send();
				xhttp.onreadystatechange = function () {
					if(this.readyState == XMLHttpRequest.DONE){
						document.getElementById("registererror").innerHTML = this.responseText;
						if(this.responseText.length > 0)
						{
							return false;
						}
						else {
							window.location = "home.jsp";
							return true;
						}
					}	
				}		
			}
		</script>
	</head>
	<body>
		<div class="container-fluid top-bar-padding">
			<div class="row align-items-center">
				<div class="col-sm"><h2 id="sal-eats"><a class="sallink" style="text-decoration: none;" href="home.jsp">SalEats!</a></h2></div>
				<div class="col-sm-auto"><p class="font"><a class="nav" href="home.jsp">Home</a></p></div> 
				<div class="col-sm-auto"><p class="font"><a class="nav" href="login-signup.jsp">Login / Sign Up</a></p></div> 
			</div>
		</div>
		<div class="container-fluid">
			<div class="row" style="padding-left: 6vh; padding-right: 6vh; padding-top: 10vh;" >
				<div class="col-sm-6">
					<span id="loginerror" class="form-error"></span>
					<h2 style="font-family: Helvetica; font-size: 30px; color: #777777;">Login</h2>
					<form name="login" action="loginserv.java" onsubmit="event.preventDefault(); validateLog();">
						<div class="form-group">
							<label for="username" class="font">Username</label>
							<input type="text" class="form-control" name="username">
							<span class="form-error">${login.username}</span>
						</div>
						<div class="form-group">
							<label for="password" class="font">Password</label>
							<input type="text" class="form-control" name="password">
							<span class="form-error">${login.password}</span>
						</div>
						<div class="form-group">
							<button type="Submit" class="log-in"> Sign In </button>
						</div>
						<div class="form-group" style="border-bottom: 2px solid #CCCCCC; padding-right: 10px; padding-left: 10px;">
						</div>
					</form>
					<div id="gSignInWrapper">
						<button type="button" class="customGPlusSignIn" id="google-sign"> Sign in with Google</button>
					</div>
					<div id="name"></div>
  					<script>startApp();</script>
				</div>
				<div class="col-sm-6">
					<span id="registererror" class="form-error"></span>
					<h2 style="font-family: Helvetica; font-size: 30px; color: #777777;">Sign Up</h2>
					<form name="signup" onsubmit="event.preventDefault(); validateReg();">
						<div class="form-group">
							<label for="email" class="font">Email</label>
							<input type="email" class="form-control" name="email">
							<span class="form-error">${errors.email}</span>
						</div>
						<div class="form-group">
							<label for="username" class="font">Username</label>
							<input type="text" class="form-control" name="username">
							<span class="form-error">${errors.username}</span>
						</div>
						<div class="form-group">
							<label for="password" class="font">Password</label>
							<input type="text" class="form-control" name="password">
							<span class="form-error">${errors.password}</span>
						</div>
						<div class="form-group">
							<label for="confirmation" class="font">Confirm Password</label>
							<input type="text" class="form-control" name="confirmation">
							<span class="form-error">${errors.confirm}</span>
						</div>
						<div>
							<input type="checkbox" id="termandcon" name="termcon">
							<label for="termcon" class="font"> I have read and agree to all terms and conditions of SalEats. </label>
						</div>
						<div class="form-group">
							<button type="submit" class="sign-in"> Create Account </button>	
						</div>
					</form>
				</div>
			</div>
		</div>
	</body>
</html>