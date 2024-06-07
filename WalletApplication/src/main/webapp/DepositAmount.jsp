<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Transaction Page</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f0f0;
        }
        .container {
            width: 50%;
            margin: 0 auto;
            position:absolute;
            top: 10%;
            left: 23%;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            border: 2px solid #3c445c;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
        }
        form {
            max-width: 400px;
            margin: 0 auto;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"],
        input[type="number"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #3c445c;
            border-radius: 5px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #3c445c;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: black;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Transaction Form</h2>
        <form action="CreateAccount" method="post">
        	<input type="hidden" name="action" value="depositAmount" >
            <label for="accountNumber">Account Number:</label>
            <input type="text" id="accountNumber" name="accountNumber" required><br><br>
            
            <label for="amount">Amount:</label>
            <input type="number" id="amount" name="amount" min="0" required><br><br>
            
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required><br><br>
            
            <input type="submit" value="Submit">
        </form>
    </div>
    <script>  
    <% 
String invalidateMessage = (String) request.getAttribute("invalidateMessage");
String balance = (String) request.getAttribute("balance");

if(invalidateMessage != null && !invalidateMessage.isEmpty()) { 
%>

Swal.fire({
    icon: 'warning',
    title: '<%= invalidateMessage %>',
    showConfirmButton: true,
    confirmButtonText: 'OK',
    confirmButtonColor: '#3c445c',
}).then((result) => {

    if (result.isConfirmed) {
        window.location.href = 'DepositAmount.jsp';
    }
});

<% } else if(balance != null && !balance.isEmpty()) { %>

Swal.fire({
    icon: 'success',
    title: 'Amount Deposited Successfully. Available Balance is: <%= balance %>',
    showConfirmButton: true,
    confirmButtonText: 'OK',
    confirmButtonColor: '#3c445c',
}).then((result) => {
   
    if (result.isConfirmed) {
        window.location.href = 'LandingPage.jsp';
    }
});

<% } %>
    </script>
</body>
</html>
