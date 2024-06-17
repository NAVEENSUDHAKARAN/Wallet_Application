<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Registration Form</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11">
<link rel="stylesheet"  href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
body {
   /*  background-image: url(images/registerpagebg.png); */
    background-repeat: no-repeat;
    background-size: 25%;
    background-position: 20%;
  /*   overflow-y: hidden; */
}

#mainDiv {
    padding-bottom: 50px;
    position: relative; /* Ensure containers are positioned relative to this */
    display: flex;
    justify-content: center; /* Center align flex items horizontally */
    align-items: flex-start; /* Align flex items to the top */
    height: 100vh; 
    gap: 300px;
}

#bgImg {
    position: relative;
    top: 120px;
    width: 25%; /* Adjust width as needed */
    z-index: 1; /* Ensure bgImg is behind containers */
}

#container {
    position: relative; /* Ensure containers are positioned relative to this */
    max-width: 400px;
    margin-top: 30px;
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 0 10px 5px #3c445c;
    z-index: 2; /* Set initial z-index higher to ensure it's on top */
}


#container1 {
    position: relative;
    width: 35%;
    height: 100%;
    top: 20px;
    z-index: 1; /* Initially behind #container */
    margin-top: 50px auto;
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 0 10px 5px #3c445c;
    display: none; /* Initially hide container1 */
}

h2 {
    text-align: center;
    margin-bottom: 20px;
}

label {
    font-weight: bold;
}

input[type="text"],
input[type="email"],
input[type="password"],
input[type="tel"],
input[type="date"],
textarea{
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

#loginBtn {
    background-color: #3c445c;
    border: none;
    color: #fff;
    border-radius: 5px;
}

.alert {
    margin-top: 10px;
}

 .form-group {
    margin-bottom: 20px;
  }
  
  .form-control {
    width: 100%;
    padding: 10px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 5px;
    box-sizing: border-box;
  }
  
  .btn-primary {
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 5px;
    padding: 12px 20px;
    cursor: pointer;
    font-size: 16px;
  }
  
  .btn-primary:hover {
    background-color: #0056b3;
  }

</style>
</head>
<body>
    <div id="mainDiv">
    <img id="bgImg" alt="not working" src="images/registerpagebg.png" width="250px" height="250px">
        <div id="container">
            <h2>Register</h2>
            <form action="LandingPage" method="post">
                <label for="first_name">First Name:</label>
                <input type="hidden" name="action" value="register">
                <input type="text" id="firstName" name="firstName" required>
                <label for="last_name">Last Name:</label>
                <input type="text" id="lastName" name="lastName" required>
                <label for="email">Email ID:</label>
                <input type="email" id="email" name="email" required>
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>

                <%
                String errorMessage = (String) request.getAttribute("message");
                if (errorMessage != null && !errorMessage.isEmpty()) {
                %>
                <div class="alert alert-danger">
                    <%=errorMessage%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input id="loginBtn" type="submit" onclick="location.href='LoginPage.jsp'" value="LogIN">
                </div>
                <%
                }
                %>

                <input id="submitBtn" type="submit" value="Next">
                
                <div id="loginBtn">
                </div>
           </form>
        </div>
        <div id="container1">
       <form action="CreateAccount" method="post">
      <input type="hidden" name="action" value="createAccount">
      <div class="form-group">
      <div class="form-group">
        <label for="phoneNumber">Phone Number:</label><small style="color: red;" >Format: 10 digits (e.g., 1234567890)</small><br>
        <input type="tel" id="phoneNumber" name="phoneNumber" pattern="[0-9]{10}" required>
        
      </div>
      <div class="form-group">
        <label for="dateOfBirth">Date of Birth:</label>
        <input type="date" id="dateOfBirth" name="dateOfBirth"  max="2006-06-13" required>
      </div>
      <div class="form-group">
        <label for="aadhaarNumber">Aadhaar Number:</label><small style="color: red;" >12-digit Aadhaar number</small><br>
        <input type="text" id="aadhaarNumber" name="aadhaarNumber" pattern="[0-9]{12}" required>
        
      </div>
      <div class="form-group">
        <label for="residentialAddress">Residential Address:</label>
        <textarea id="residentialAddress" name="residentialAddress" rows="4" required></textarea>
      </div>
  
      <input id="registerBtn" type="submit" value="Register"><br><br>
    </form>
            
        </div>
        
        
    </div>
    <script>
        document.getElementById('nextBtn').addEventListener('click', function() {
            document.getElementById('container1').style.zIndex = '3'; 
            document.getElementById('container1').style.display = 'block';
            document.getElementById('container').style.zIndex = '1';
            document.getElementById('container').style.display = 'none';
        });
    </script>
</body>
</html>
