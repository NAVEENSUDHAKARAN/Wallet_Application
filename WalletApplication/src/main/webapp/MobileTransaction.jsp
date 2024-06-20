<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.chainsys.dao.ServerManager" %>
<%@ page import="com.chainsys.dao.DynamicQR" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mobile Transaction</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 0;
        }
        
        .container {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            background-color: #ffffff;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }
        
        input[type="text"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 16px;
        }
        
        textarea {
            width: 100%;
            height: 60px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 16px;
        }
        
        .submit-button,
        .cancel-button {
            width: 100%;
            padding: 15px;
            border-radius: 5px;
            font-size: 18px;
            cursor: pointer;
            text-align: center;
        }
        
        .submit-button {
            background-color: #3c445c;
            color: #ffffff;
            border: none;
            margin-bottom: 10px;
        }
        
        .cancel-button {
            background-color: #ffffff;
            color: #3c445c;
            border: 1px solid #3c445c;
        }
        
        @media only screen and (max-width: 600px) {
            /* Adjustments for mobile phones */
            .container {
                margin: 10px;
                padding: 10px;
            }
            
            input[type="text"],
            textarea,
            .submit-button,
            .cancel-button {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
    		<%
 				int id = Integer.parseInt(request.getParameter("id"));
    			String receiverId = request.getParameter("walletId");
 				System.out.println("parsed Value in mobile : " + id);
                ServerManager manager = new ServerManager();
                DynamicQR qr = new DynamicQR();
             %>
        <h2>Wallet Transfer</h2>
        <form action="Transfers" method="post">
        	<input type="hidden" name="action" value="mobileTransfer" >
        	<input type="hidden" name="id" value="<%= id %>" >
            <div class="form-group">
                <label for="senderWalletId">Sender Wallet ID:</label>
                <input type="text" id="senderWalletId" name="senderWalletId"  required >
            </div>
            <div class="form-group">
                <label for="receiverWalletId">Receiver Wallet ID:</label>
                <input type="text" id="receiverWalletId" name="receiverWalletId" value="<%= receiverId %>" required readonly="readonly">
            </div>
            <div class="form-group">
                <label for="amountToSend">Amount to Send:</label>
                <input type="text" id="amountToSend" name="amountToSend" required>
            </div>
            <div class="form-group">
                <label for="note">Note:</label>
                <textarea id="note" name="note"></textarea>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit" class="submit-button">Submit</button>
            <button type="button" class="cancel-button" onclick="window.location.href='your_cancel_url_here'">Cancel</button>
        </form>
    </div>
<script>

<% 
String alertMessage = (String) request.getAttribute("alertMessage");
System.out.println("alertMsg : " + alertMessage);
if(alertMessage != null && !alertMessage.isEmpty()){
    if(alertMessage.equals("Invalid Password")){
%>
Swal.fire({
title: '<%= alertMessage %>',
type: 'error',
confirmButtonColor: '#3c445c',
confirmButtonText: 'Ok'
})
<% }else if(alertMessage.equals("Invalid WalletID")){ %>
Swal.fire({
  title: '<%= alertMessage %>',
  type: 'error',
  confirmButtonColor: '#3c445c',
  confirmButtonText: 'Ok'
})
<%}
}%>


</script>
</body>
</html>
