<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.chainsys.model.WalletIdInfo" %>
<%@ page import="com.chainsys.model.TransactionInfo" %>
<%@ page import="com.chainsys.dao.ServerManager" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Wallet Transfer</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/qrcode@latest"></script>
</head>
<style>
	#btnsDiv{
		padding-left: 270px;	
	}
	
	#btn{
		background-color: #3c455c;
		border-radius: 8px;
		color: white;
		border: 3px solid #282e3d;
	}
	
	#btn:hover{
		background-color: black;
		color: white;
		border: 3px solid #282e3d;
	}
	
	 input[type="text"],
     input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 16px;
            border: none;
        }
        
        .bar {
            height: 100%;
            width: 0;
            position: fixed;
            z-index: 1;
            top: 0;
            right: 0;
            background-color: #f0f2f5;
            overflow-x: hidden;
            transition: 0.5s;
            padding-top: 60px;
        }
        .closeBtn {
            position: absolute;
            top: 0;
            right: 25px;
            font-size: 25px;
            margin-left: 50px;
            text-decoration: none;
            color: #333;
        }
        
 /*     ::-webkit-scrollbar {
		  width: 10px;
		}
		
		
		::-webkit-scrollbar-track {
		  background: #f1f1f1;
		}
		
		::-webkit-scrollbar-thumb {
		  background: #282e3d;
		  border-radius: 5px; 
		}
		
		::-webkit-scrollbar-thumb:hover {
		  background: #3c455c;
		}
 */
 </style>
<body>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    System.out.println("parsed Value : " + id);
    ServerManager manager = new ServerManager();
%>
  <section style="background-color: #eee;">
  <div class="container py-5">
        <div class="row">
      <div class="col-lg-4">
        <div class="card mb-4">
          <div class="card-body text-center">
            <img src="images/DigiPayLogo.png" alt="avatar"
              class="rounded-circle img-fluid" style="width: 150px;">
            <h5 class="my-3"><%= manager.getUserName(id) %></h5>
            <p class="text-muted mb-1"><%= manager.getWalletId(id) %></p>
            <h3>Wallet Balance</h3>
            <p><%= manager.getWalletBalance(id) %></p>
          </div>
        </div>
        <div class="card mb-4 mb-lg-0">
          <div class="card-body p-0">
            	<div class="card-body">
                <h4 class="mb-4">POINTS</h4>
                 	<p>0</p>
              </div>
          </div>
        </div>
      </div>
      <div class="col-lg-8">
        <form action="Transfers" method="post">
       		<input type="hidden" name="action" value="walletTransfer">
            <input type="hidden" name="id" value="<%= id %>">
        	<div class="card mb-4">
          <div class="card-body">
            <div class="row">
              <div class="col-sm-3">
                <p class="mb-0">Sender WalletID</p>
              </div>
              <div class="col-sm-9">
                <input type="text" style="border: hidden;" name="senderWalletId" class="text-muted mb-0" value="<%= manager.getWalletId(id) %>"  readonly>
              </div>
            </div>
            <hr>
            <div class="row">
              <div class="col-sm-3">
                <p class="mb-0">Receiver WalletID</p>
              </div>
              <div class="col-sm-9">
                <input style="width: 50%; border: hidden;" class="text-muted mb-0" type="text" name="receiverWalletId" required >&nbsp;&nbsp;&nbsp;<button type="button" onclick="generateQRCode()" id="btn" >Generate QR</button>
              </div>
              <div id="qrBar" class="bar">
	            <div id="qrCodeDiv"></div>
	            <a href="#" class="closeBtn" onclick="closeQr()">&times;</a>
	        </div>
            </div>
            <hr>
            <div class="row">
              <div class="col-sm-3">
                <p class="mb-0">Amount</p>
              </div>
              <div class="col-sm-9">
              	<input type="text" class="text-muted mb-0" name="amountToSend" required>
              </div>
            </div>
            <hr>
            <div class="row">
              <div class="col-sm-3">
                <p class="mb-0">Password</p>
              </div>
              <div class="col-sm-9">
              	<input type="password" class="text-muted mb-0" name="password" required>
              </div>
            </div>
            <hr>
            <div class="row">
              <div class="col-sm-9" id="btnsDiv">
                <button type="submit" id="btn" class="submit-button">OK</button>
            	<button type="button" id="btn" class="cancel-button" onclick="window.location.href='LandingPage.jsp'">Cancel</button>
              </div>
            </div>
          </div>
        </div>
        </form>
        <div class="row" style=" height:60vh; overflow: scroll; overflow-x: hidden; ">
          <div class="col-md-12">
            <div class="card mb-4 mb-md-0">
              <div class="card-body">
                <h3 class="mb-4">Transaction History</h3>
                	<div class="table-responsive">
          <table class="table table-bordered">
            <thead>
              <tr>
                <th>TransactionID</th>
                <th>Receiver WalletID</th>
                <th>Date and Time</th>
                <th>Amount</th>
              </tr>
            </thead>
       <%
       		String senderWalletId = manager.getWalletId(id);
       		ArrayList<TransactionInfo> transactionDetails = manager.readTransactionHistory(senderWalletId);
       		for(TransactionInfo details : transactionDetails){
       %>
            <tbody>
              <tr>
                <td><%= details.getTransactionId() %></td>
                <td><%= details.getReceiverWalletID() %></td>
                <td><%= details.getDateAndTime() %></td>
                <td><%= details.getAmountTransfered() %></td>
              </tr>
            </tbody>
       <% } %>
          </table>
        </div>
              </div>
            </div>
          </div>
        </div>
      </div>
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

function generateQRCode() {
    var receiverWalletId = document.getElementById("receiverWalletId").value;
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            document.getElementById("qrCodeDiv").innerHTML = this.responseText;
            document.getElementById("qrBar").style.width = "50%";
        }
    };
    xhr.open("GET", "QRPage.jsp?recId=" + receiverWalletId, true);
    xhr.send();
}

function closeQr() {
    document.getElementById("qrBar").style.width = "0";
}

</script>
</section>
</body>


</html>