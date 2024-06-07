<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Registration Form</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<style>
body {
	background-image: url(images/registerpagebg.png);
	background-repeat: no-repeat;
	background-size: 25%;
	background-position: 20%;
}

#container {
	position: relative;
	max-width: 400px;
	left: 25%;
	top: 30%;
	margin: 50px auto;
	background-color: #fff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 0 10px 5px #3c445c;
}

h2 {
	text-align: center;
	margin-bottom: 20px;
}

label {
	font-weight: bold;
}

input[type="text"], input[type="email"], input[type="password"] {
	width: 100%;
	padding: 10px;
	margin-bottom: 15px;
	border: 1px solid #ccc;
	border-radius: 5px;
	box-sizing: border-box;
}

#submitBtn {
	background-color: #3c445c;
	color: #fff;
	border: none;
	border-radius: 5px;
	padding: 12px 20px;
	cursor: pointer;
	width: 100%;
	font-size: 16px;
}

#submitBtn:hover {
	background-color: #2d2d2a;
}

#loginBtn{
	background-color: #3c445c;
	border: none;
	color: #fff;
	border-radius: 5px;
}
</style>
<body>
	<div id="container">
		<h2>User Registration</h2>
		<form action="LandingPage" method="post">
			<label for="first_name">First Name:</label> <input type="hidden"
				name="action" value="register"> <input type="text"
				id="firstName" name="firstName" required> <label
				for="last_name">Last Name:</label> <input type="text" id="lastName"
				name="lastName" required> <label for="email">Email
				ID:</label> <input type="email" id="email" name="email" required> <label
				for="password">Password:</label> <input type="password"
				id="password" name="password" required>

			<%
			String errorMessage = (String) request.getAttribute("message");
			if (errorMessage != null && !errorMessage.isEmpty()) {
			%>
			<div class="alert alert-danger">
				<%=errorMessage%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input id="loginBtn" type="submit" onclick="location.href='LoginPage.jsp'"
					value="LogIN">
			</div>
			<%
			}
			%>
			<input id="submitBtn" type="submit" value="Register"><br>
			<br>
			<div id="loginBtn">
				
			</div>
		</form>
	</div>

</body>
</html>

