<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Send Money</title>
    <style>
        .container {
            width: 50%;
            margin: 0 auto;
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

        .downward-arrow {
            height: 200px;
            margin-bottom: 20px;
            display: block; 
            margin: 0 auto; 
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
    </style>
</head>
<body>
    <div class="container">
        <h1>Send Money</h1>

	<%
		HttpSession transfers = request.getSession();
		int id = (int) transfers.getAttribute("userid");
	%>

        <form action="Transfers" method="post">

            <label for="recipientName">Recipient Name:</label>
            <div class="accountNumber-container">
                <input type="text" id="recipientName" name="recipientName" required readonly="readonly">
            </div>

            <label for="recipientWalletID">Recipient Wallet ID:</label>
            <div class="accountNumber-container">
                <input type="text" id="recipientWalletID" name="recipientWalletID" required readonly="readonly">
            </div>

            <label for="amountToSend">Amount to Send:</label>
            <div class="accountNumber-container">
                <input type="number" id="amountToSend" name="amountToSend" step="1" min="0" required>
            </div>

            <!-- <img alt="Downward Arrow" src="images/downwardArrow.png" class="downward-arrow"> -->

            <label for="receiverWalletID">Receiver Wallet ID:</label>
            <div class="accountNumber-container">
                <input type="text" id="receiverWalletID" name="receiverWalletID" value="" >
            </div>

            <button type="submit">Pay</button>
            <button type="button" onclick="window.location.href='HomePage.jsp'">Cancel</button>
        </form>
    </div>
</body>
</html>
