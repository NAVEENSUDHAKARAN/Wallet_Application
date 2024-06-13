<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.chainsys.model.WalletIdInfo" %>
<%@ page import="com.chainsys.dao.ServerManager" %>
<%@ page import="com.chainsys.dao.DynamicQR" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.InetAddress" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Wallet Transfer</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 0;
            overflow-y: hidden; 
        }
        .main-container {
            display: flex;
            padding: 10px;
            margin: 10px;
        }
        .left-container {
            width: 30%;
            background-color: #3c445c;
            color: #ffffff;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }
        .container {
            width: 70%;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #ffffff;
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
        input[type="text"],
        input[type="password"] {
            width: 100%;
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
        .logo {
            display: block;
            margin: 0 auto;
            margin-bottom: 20px;
        }
        @media only screen and (max-width: 600px) {
    /* Adjustments for mobile phones */
    .main-container {
        flex-direction: column;
        align-items: center;
    }
    
    .left-container,
    .container {
        width: 100%;
        margin: 0;
    }
    
    .left-container {
        padding: 10px;
    }
    
    .logo {
        margin-bottom: 10px;
    }
    
    .form-group {
        margin-bottom: 10px;
    }
    
    input[type="text"],
    input[type="password"],
    .submit-button,
    .cancel-button {
        width: 100%;
        margin-bottom: 10px;
    }
}
        
        
    </style>
</head>
<body>
 				<%
 				int id = Integer.parseInt(request.getParameter("id"));
 				System.out.println("parsed Value : " + id);
                ServerManager manager = new ServerManager();
                DynamicQR qr = new DynamicQR();
                %>
    <div class="main-container">
        <div class="left-container">
            <h3 style="font-style: italic; font-size: xx-large; "><%= manager.getUserName(id) %></h3>
            <p>Current Balance: <%= manager.getWalletBalance(id) %></p>

            <% String name = manager.getUserName(id); System.out.println("Name : " + name); %>
            <img alt="image not working" src="images/<%= name %>.png">
          
        </div>
        <div class="container">
            <img src="images/DigiPayLogo.png" width="60px" height="60px" alt="DigiPay Logo" class="logo">
            <form action="Transfers" method="post">
            <input type="hidden" name="action" value="walletTransfer" >
           	<input type="hidden" name="id" value="<%= id %>" >
			<%
                ArrayList<WalletIdInfo> walletInfo = manager.readWalletDetails(id);
                for(WalletIdInfo details : walletInfo){
            %>
                <div class="form-group">
                    <label for="senderWalletId">Sender Wallet ID:</label>
                    <input type="text" id="senderWalletId" name="senderWalletId" value="<%= details.getWalletId() %>" required readonly="readonly" >
                </div>
            <%} %>    
                <div class="form-group">
                    <label for="receiverWalletId">Receiver Wallet ID:</label>
                    <input type="text" id="receiverWalletId" name="receiverWalletId" required>
                </div>
                <div class="form-group">
                    <label for="amountToSend">Amount to Send:</label>
                    <input type="text" id="amountToSend" name="amountToSend" required>
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <button type="submit" class="submit-button">OK</button>
                <button type="button" class="cancel-button" onclick="window.location.href='LandingPage.jsp'">Cancel</button>
            </form>
        </div>
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
