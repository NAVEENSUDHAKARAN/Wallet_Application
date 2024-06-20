<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.chainsys.model.UserInfo" %>
<%@ page import="com.chainsys.model.BankAccountInfo" %>
<%@ page import="com.chainsys.dao.ServerManager" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            color: #333;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        h2 {
            color: #3c445c;
            margin-bottom: 20px;
            text-align: center;
        }
        form {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            flex-basis: 48%;
        }
        input[type="text"],
        input[type="email"],
        input[type="password"],
        textarea {
            width: calc(100% - 10px);
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            flex-basis: 48%;
        }
        textarea {
            resize: vertical;
            height: 100px;
        }
        .password-container {
            position: relative;
        }
        .password-toggle {
            position: absolute;
            top: 50%;
            right: 10px;
            transform: translateY(-50%);
            cursor: pointer;
        }
        input[type="submit"] {
            background-color: #3c445c;
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 12px 20px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
            flex-basis: 100%;
        }
        input[type="submit"]:hover {
            background-color: #3c445c;
        }
    </style>
</head>
<body>
    <div class="container">
    <h2>User Profile</h2>
    <%
    HttpSession id = request.getSession(); 
    int userId = (int) id.getAttribute("userid");
    System.out.println("id ---> " + userId);
    ServerManager server = new ServerManager();
    List<UserInfo> arrList = server.readUserDetails(userId);
    for (UserInfo userInfo : arrList) {
       
%>
		<label for="email">First Name:</label>
        <input type="text" id="email" name="firstName" value="<%= userInfo.getFirstName() %>" readonly>
        
        <label for="email">Last Name:</label>
        <input type="text" id="email" name="lastName" value="<%= userInfo.getLastName() %>" readonly>
			
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" value="<%= userInfo.getEmail() %>" readonly>
<% } %>

<% 
    List<BankAccountInfo> arrList1 = server.readAccountDetails(userId);
    for (BankAccountInfo bankAccountInfo : arrList1) { 
%>
        <label for="dob">Date of Birth:</label>
        <input type="text" id="dob" name="dob" value="<%= bankAccountInfo.getDOB() %>" readonly>
        
        <label for="accountNumber">Account Number:</label>
        <div class="password-container">
            <input type="text" id="accountNumber" name="accountNumber" value="<%= bankAccountInfo.getAccNo() %>" readonly>
		</div>
		
		<label for="aadhaarNumber">Aadhaar Number:</label>
		<div>
		    <input type="text" id="aadhaarNumber" name="aadhaarNumber" value="<%= bankAccountInfo.getAadharNumber() %>" readonly>
		</div>

<script>
    function togglePassword(inputId) {
        var inputField = document.getElementById(inputId);
        if (inputField.type === "password") {
            inputField.type = "text";
        } else {
            inputField.type = "password";
        }
    }
</script>
            <label for="address">Address:</label>
            <textarea id="address" name="address" readonly><%= bankAccountInfo.getAddress() %></textarea>
        <% } %>
            <input type="submit" onclick="location.href='LandingPage.jsp'" value="Back">

    </div>
    
    <script>
        function togglePassword(fieldId) {
            var passwordField = document.getElementById(fieldId);
            if (passwordField.type === "password") {
                passwordField.type = "text";
            } else {
                passwordField.type = "password";
            }
        }
    </script>
</body>
</html>
