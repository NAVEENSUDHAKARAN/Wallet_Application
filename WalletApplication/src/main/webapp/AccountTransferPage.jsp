<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.chainsys.dao.ServerManager" %>
<%@ page import="com.chainsys.model.UserInfo" %>
<%@ page import="com.chainsys.model.BankAccountInfo" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Send Money</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    
    <style>
        .container {
            width: 50%;
            margin: 0 auto; /* Center the container horizontally */
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
        }

        label {
            text-align: left;
            display: inline-block;
            width: 150px; 
            margin-right: 10px; 
            margin-bottom: 10px;
        }

        .accountNumber-container {
            position: relative;
            margin-bottom: 20px;
            text-align: left; 
        }

        input[type="text"],
        input[type="number"],
        button {
            width: calc(100% - 160px); 
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            display: inline-block;
        }

        button {
            background-color: #3c445c;
            color: white;
            border: none;
            cursor: pointer;
        }

        button:hover {
            background-color: #3c445c;
        }
        
        .custom-alert {
            width: 100%; /* Adjust the width as needed */
            padding: 10px;
            text-align: center; /* Center the text horizontally */
        }

        .btn-container {
            text-align: center; /* Center the buttons horizontally */
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Send Money</h1>

        <% HttpSession transfers = request.getSession();
           int id = (int) transfers.getAttribute("userid");
           ServerManager manager = new ServerManager();
           ArrayList<UserInfo> userDetails = manager.readUserDetails(id);
           for(UserInfo user : userDetails) {
        %>
        <form action="Transfers" method="post">
        <input type="hidden" name="action" value="accountTransfer" > 
            <label for="recipientName">Recipient Name:</label>
            <div class="accountNumber-container">
                <input type="text" id="recipientName" name="recipientName" value="<%= user.getFirstName() %>" required readonly="readonly">
            </div>
        <% } %>
        
        <% ArrayList<BankAccountInfo> accountDetails = manager.readAccountDetails(id);
           for(BankAccountInfo accountInfo : accountDetails) {
        %>
           <!--  <input type="hidden" name="action" value="accountToWallet"> -->
            <label for="recipientWalletID">Recipient AccountNumber:</label>
            <div class="accountNumber-container">
                <input type="text" id="recipientWalletID" name="recipientWalletID" value="<%= accountInfo.getAccNo() %>" required readonly="readonly">
            </div>
        <% } %>
        
        <label for="amountToSend">Amount to Send:</label>
        <div class="accountNumber-container">
            <input type="number" id="amountToSend" name="amountToSend" step="1" min="0" required>
        </div>

        <label for="receiverWalletID">Receiver Wallet ID:</label>
        <div class="accountNumber-container">
            <input type="text" id="receiverWalletID" name="receiverWalletID" value="" >
        </div>
        
        <div class="btn-container">
            <% String errorMessage = (String)request.getAttribute("invalidWalletIdMsg");
               if(errorMessage != null && !errorMessage.isEmpty()) {
            %>
            <div class="alert alert-danger custom-alert" role="alert">
                <%= errorMessage %>
            </div>
            <% } %>

            <button type="submit">Pay</button>
            <button type="button" onclick="window.location.href='LandingPage.jsp'">Cancel</button>
        </div>
        </form>
    </div>
    
    <script>
        // JavaScript code here
    </script>
</body>
</html>
