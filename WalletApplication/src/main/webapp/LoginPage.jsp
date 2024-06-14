<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Login Page</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
        }
        .container {
            position: absolute;
            left: 19%;
            top: 5%;
            width: 300px;
            margin: 100px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px 5px #3c445c;
        }
        .container h2 {
            text-align: center;
        }
        .container input[type="text"],
        .container input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 3px;
            box-sizing: border-box;
        }
        .container input[type="submit"] {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 3px;
            background-color: #3c445c;
            color: #fff;
            cursor: pointer;
        }
        .container input[type="submit"]:hover {
            background-color: black;
        }
        
        #logo {
            position: relative;
            left: 41%;
            top: 10%;
        }
        
        #bgDiv {
            width: 30%;
            height: 50vh;
            position: relative;
            left: 60%;
            top: 120px;
        }
        
       #createAccountTag {
            position: relative;
            left: 30%;
            text-decoration: none;
            color: #3c445c;
       }
       
       #createAccountTag:hover {
            color: black;
            cursor: pointer;
       }
       
       /* Custom error message style */
       .alert-danger {
            color: #721c24;
            background-color: #f8d7da;
            border-color: #f5c6cb;
            padding: 5px 10px;
            margin-top: 5px;
            border-radius: 3px;
       }
    </style>
</head>
<body>
    <div class="container">
        <img id="logo" src="images/DigiPayLogo.png" width="40px" height="40px" >
        <h2>Login</h2>
        <form id="loginForm" action="LandingPage" method="post">
            <input type="hidden" name="action" value="logIN" >
            <input type="text" id="email" name="email" placeholder="Email" required><br>
            <input type="password" name="loginPassword" placeholder="Password" required><br>
            <input type="submit" value="Login">
        </form>
        <br>
        <a id="createAccountTag" href="RegistrationForm.jsp" >Create Account</a>
        
        
        <% String errorMessage = (String)request.getAttribute("error");
           if(errorMessage != null && !errorMessage.isEmpty()) {
        %>
            <div class="alert alert-danger" role="alert">
                <%= errorMessage %>
            </div>
        <% } %>
    </div>
    
    <div id="bgDiv">
        <img src="images/loginpagebg.png" alt="image not working" width="100%" height="100%" > 
    </div>
    
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script>

        document.getElementById("email").addEventListener("input", function(event) {
            var emailField = document.getElementById("email");
            var email = emailField.value.trim();

            if (email.indexOf("@") === -1) {

                var errorMessage = "Please enter a valid email address.";
                displayErrorMessage(emailField, errorMessage);
            } else {
                removeErrorMessage(emailField);
            }
        });

        function displayErrorMessage(field, message) {
        
            removeErrorMessage(field);

            var errorDiv = document.createElement("div");
            errorDiv.className = "alert alert-danger";
            errorDiv.textContent = message;

            field.parentNode.insertBefore(errorDiv, field.nextSibling);
        }

        function removeErrorMessage(field) {
            var errorDiv = field.parentNode.querySelector(".alert-danger");
            if (errorDiv) {
                errorDiv.parentNode.removeChild(errorDiv);
            }
        }
    </script>
</body>
</html>
