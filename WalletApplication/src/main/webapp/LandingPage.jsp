<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.chainsys.dao.ServerManager" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	
<script defer src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	
	
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>


<title>Home</title>
</head>
<style>
body {
	padding: 0;
	margin: 0;
	overflow-x: hidden;
}

#navbarDiv {
	position: sticky;
	display: flex;
	width: 110vw;
	height: 90px;
	box-shadow: 5px 5px 3px 0px grey;
	z-index: 10;
}

#logoDiv {
	position: relative;
	left: 5%;
	top: 5%;
	width: 100px;
	height: 80px;
}

#dropDown {
	position: relative;
	width: 10%;
	height: 50%;
	left: 20%;
	top: 30%;
}

#optionsDiv {
	position: relative;
	width: 55%;
	height: 90px;
	left: 5%;
	gap: 50px;

}


#contentDiv {

	font-size: x-large;
	position: relative;
	display: flex;
	width: 90%;
	height: 50%;
	gap: 70px;
	left: 40%;
	top: 20%;
	justify-content: space-around;
	color: #3c445c;
}

#help:hover, #login:hover {
	cursor: pointer;
	color: black;
}

#registerBtn {
	background-color: #3c445c;
	border: none;
	color: white;
	width: 30%;
	height: 50px;
	padding: 10px 20px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 4px 2px;
	cursor: pointer;
	border-radius: 5px;
}

#registerBtn:hover {
	background-color: black;
}

#registerBtn:active {
	background-color: #3c445c;
}

#logoutBtn {
	background-color: #3c445c;
	border: none;
	color: white;
	width: 100%;
	height: 50px;
	padding: 10px 20px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 4px 2px;
	cursor: pointer;
	border-radius: 5px;
}

#dropdown{
	border: none;
	color: white;
	width: 100%;
	height: 50px;
	padding: 10px 20px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 4px 2px;
	cursor: pointer;
	border-radius: 5px;
}

#profile {
	background-color: #3c445c;
	position: relative;
	bottom: 50px;
}

#logoutBtn:hover {
	background-color: black;
}

#logoutBtn:active {
	background-color: #3c445c;
}

#login {
	text-decoration: none;
	color: #3c445c;
}

#secondDiv {
	background-color: #F5F5F5;
	height: 59vh; 
	width: 50%;

	
}

#text1 {
	font-size: xxx-large;
	font-weight: bolder;
	font-style: italic;
	position: relative;
	top: 15%;
	left: 10%;

	transition: ease-in 600ms;
	display: flex;
	flex-direction: column;
	
}

#text1 {
	animation: 2s slide-right;
}

@keyframes slide-right {from { margin-left:-100%;
	
}

to {
	margin-left: 0%;
}

}
#text2 {
	font-style: italic;
	position: relative;
	top: 20%;
	left: 10%;
	width: 60%;
}

#parallelogramDiv {
	position: absolute;
	height: 70vh;
	background-color: white;
	transform: skew(-20deg);
	left: 45%;
	height: 59%;; 
	border-left: 5px solid #3c445c;

	
}

#innerSignUp, #innerLearnMore {
	width: 25%;
	position: relative;
	left: 20%;
	top: 20%;
	padding: 10px;
	border: none;
	border-radius: 3px;
	background-color: #3c445c;
	color: #fff;
	cursor: pointer;
}

#innerSignUp:hover, #innerLearnMore:hover {
	background-color: black;
}

#innerBtns {
	animation: 3s slide-right;
	position: relative;
	top: 20%;
}

@keyframes slide-left {from { margin-left:100%;
	
}

to {
	margin-left: 0%;
}

}
#parallelogramImg{
	height: 60vh;
	padding-left: 30%;
}

#functionalities {
	position: relative;
	height: 100vh;
	width: 100vw;
	padding: 50px;
}

#footerDiv {
	background-color: aqua;
	height: 30vh;
	width: 98.6vw;
	display: flex;
	position: absolute;
}

#mediaTag {
	background-color: black;
	width: 30%;
	height: 100%;
	position: relative;
}

#icons {
	position: relative;
	width: 50%;
	height: 25%;
	left: 45px;
	top: 20px;
}

#copyRightDiv {
	background-color: black;
	color: white;
	width: 45%;
	height: 100%;
}

#addressDiv {
	background-color: whitesmoke;
	width: 25%;
	height: 100%;
}

#copyRightsText {
	position: relative;
	top: 25%;
}

#dropdown-menu {
	z-index: 10;
}

.box {
	display: flex;
	background: rgb(245,245,245);
	background: linear-gradient(90deg, rgba(245,245,245,1) 70%, rgba(255,255,255,1) 30%, rgba(255,255,255,1) 51%);

}

/* .btn-outline-dark:hover {
        background-color: transparent;
        color: inherit;
    } */
    
     #dropdown.dropdown-toggle:hover {
            background-color: transparent !important;
            color: white !important;
        }

 .dropdown-menu a.dropdown-item:active {
        background-color: black;
        color: white; 
    }
    
    .dropdown-menu button.dropdown-item:active {
        background-color: black;
        color: white; 
    }
   
   #dropdownDiv{
   		padding-top: 40px;
   }
   
   #profileDiv{
   width: fit-content;
   position: relative;
   left: 50%;
   }
   
   #walletBalanceDiv{

   		width: 180px;
   		position: absolute;
   		bottom:-10px;
   		left: 40%;
   }
   
   #classBody{
   		
   }
   
   /* #dropdown{
   		border: 2px groove #3c445c;
   		height: 51px;
   		padding-bottom: 10px;
   }  */

</style>
<body>

	<%
	if (session == null) {
		response.sendRedirect("LoginPage.jsp");
		
	}
  	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setHeader("Expires", "0");
	
	ServerManager manager = new ServerManager();
	%>

	<div id="navbarDiv">

		<div id="logoDiv">
			<img alt="image not working" src="images/DigiPayLogo.png"
				width="100px" height="80px">
		</div>
		<!-- <div id="dropDown">
                <div class="dropdown">
                  <button style="background-color: #3c445c; width: 100%; height: 100%; " class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                    Services
                  </button>
                  <ul class="dropdown-menu">
                    <li><button class="dropdown-item" type="button">Transfer Money</button></li>
                    <li><button class="dropdown-item" type="button">Pay Online</button></li>
                    <li><button class="dropdown-item" type="button">Buy and Sell Crypto</button></li>
                  </ul>
                </div>
            </div> -->
		<div id="optionsDiv">
			<div id="contentDiv">
				<a id="help" style="padding-top: 10px;">Help</a> <a id="login"
					href="LoginPage.jsp" style="padding-top: 10px;">LogIN</a>
				
				<% 
					if(session.getAttribute("userName") == null){
				%>
						<button id="registerBtn"
					onclick="window.location.href='RegistrationForm.jsp'">Register</button>
				<%} else{  
					HttpSession id = request.getSession();
					int userId = (int) id.getAttribute("userid");
				%>
						<div id="walletBalanceDiv">
							<span style="font-size: medium;small;">WalletBalance</span><br>
							<img alt="image not working" src="images/walleticon.png" width="35px" height="35px"><input type="text" name="walletBalance" style="width: 130px; position:relative; border:none; left: 10px;" value="<%= manager.getWalletBalance(userId) %>" readonly="readonly" >
						</div>	
				<%} %>
				<%-- <p id="welcomeNote" >Hi, <%= session.getAttribute("userName") %></p> --%>
				<%
					String name;
					if(session.getAttribute("userName") == null)
					{
						name = "Register/Login";
					}
					else
					{
						name = (String) session.getAttribute("userName");
					}
				%>
				
				<div id="profile" class="container mt-5 ">
					<div id="profileDiv" class="d-flex justify-content-end ">
						<div id="dropdown" class="dropdown ">
							<button class="btn btn-outline-dark dropdown-toggle"
								type="button" id="dropdownMenuButton" data-bs-toggle="dropdown"
								aria-expanded="false"> <img src="images/profilelogo.png" width="25px" height="25px" alt="Profile" class="profile-icon"><%= name %></button>
								<% 
								if(session.getAttribute("userName") != null){
									
								%>
								<div id="dropdownDiv">
									<ul id="dropdown-menu" class="dropdown-menu" aria-labelledby="dropdownMenuButton">
									<li><a class="dropdown-item" href="ProfilePage.jsp">Profile</a></li>
									<form action="Logout" method="post">
									<li><button class="dropdown-item" >Logout</button></li>
									</ul>
									</form>
								</div>
							<%} %>			
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="box">
		<div id="secondDiv">
			<div id="text1">
				<h2 id="text1">Make Your</h2>
				<h2 id="text1">Money Move</h2>
				<h5 id="text2">Pay online, send money and buy crypto</h5>
				<h5 id="text2">with a digital wallet used by millions.</h5>
			</div>

			<div id="innerBtns">
				<button id="innerSignUp"
					onclick="window.location.href='RegistrationForm.jsp'">SignUP</button>
				<button id="innerLearnMore">Learn More</button>
			</div>
		</div>
		<div id="p">
		<div id="parallelogramDiv">
			<div id="parallelogramImg">
				<img alt="image not working" src="images/frontpagebg.jpg" width="100%" height="100%" >
			</div>
		</div>
		</div>
	</div>
	<div id="functionalities">
		<div id="row" class="row">
			<div class="col-sm-6 mb-3 mb-sm-0">
				<div id="row" class="card">
					<div id="classBody" class="card-body">
						<h5 class="card-title">
							<img alt="icon not working" src="images/bankaccounticon.png"
								width="20px" height="20px">&nbsp; Create Bank Account
						</h5>
						<p class="card-text">Create a bank account with Digipay
							quickly.</p>
						<a href="CreateBankAccount.jsp"
							style="background-color: #3c445c; border-color: black;"
							class="btn btn-primary">Open Account</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a
							href="DepositAmount.jsp"
							style="background-color: #3c445c; border-color: black;"
							class="btn btn-primary">Deposit Amount</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="AccountTransferPage.jsp"
							style="background-color: #3c445c; border-color: black;"
							class="btn btn-primary">Transfer Money</a>
					</div>
				</div>
			</div>
				<br>
			<br>
			<div id="row" class="col-sm-6">
				<div id="row" class="card">
					<div class="card-body">
						<h5 class="card-title">
							<img alt="icon not working" src="images/moneytransfericon.png"
								width="21px" height="21px">&nbsp;Send Money
						</h5>
						<p class="card-text">to any Digipay User or Bank Account.</p>
						<!-- <a onclick="openTransferDialog()" style="background-color: #3c445c; border-color: black;" class="btn btn-primary">Transfer</a>  -->
							
							<button
							 onclick="openTransferDialog()" 
							style="background-color: #3c445c; border-color: black;"
							class="btn btn-primary">Transfer</button>

					</div>
				</div>
			</div>
		
			<div id="row1" class="col-sm-6">
				<div id="row" class="card">
					<div class="card-body">
						<h5 class="card-title">Special title treatment</h5>
						<p class="card-text">With supporting text below as a natural
							lead-in to additional content.</p>
						<a href="#"
							style="background-color: #3c445c; border-color: black;"
							class="btn btn-primary">Go somewhere</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div id="footerDiv">
		<div id="mediaTag">
			<div>
				<h2
					style="height: 50%; color: white; position: relative; top: 20px; left: 40px;">Follow
					Us on :</h2>
			</div>
			<div id="icons">
				<img src="images/youtube.png" alt="image not working" width="30px"
					height="30px"> <img src="images/facebook.png"
					alt="image not working" width="30px" height="30px"> <img
					src="images/linkedin.png" alt="image not working" width="30px"
					height="30px"> <img src="images/instagram.png"
					alt="image not working" width="30px" height="30px">
			</div>
		</div>
		<div id="copyRightDiv">
			<div id="copyRightsText">
				<p style="padding-left: 35px;">Copyrights &copy;2024 Stock
					Management System. All rights reserved.</p>
				<p>Use of this site constitutes acceptance of our Terms of Use
					and Privacy Policy.</p>
			</div>
		</div>
		<div id="addressDiv">
			<div id="address" style="position: relative; left: 25%; top: 20px;">
				<p>
					<img src="images/addressgif.gif" alt="image not working"
						width="15px" height="15px">123,South Street, Chennai-28
				</p>
				<p>
					<img src="images/mailgif.gif" alt="gif not working" width="15px"
						height="15px">naveensudhakaran2@gmail.com
				</p>
				<p>
					<img src="images/phonegif.gif" alt="image not working" width="15px" height="15px">6382401736
				</p>
			</div>
		</div>
	</div>
</body>
<script>
function openTransferDialog() {
	 var valueToSend = "transfer";
	$.ajax({
        url: "CreateAccount",
        method: "post",
        data:{
        	action: valueToSend
        },
        success: function(response) {
            console.log("AJAX success");
            window.location.href = "WalletTransferPage.jsp";
        },
        error: function(xhr, status, error) {
            console.error("AJAX error:", error);
            
            Swal.fire({
                icon: 'info',
                title: 'Enter Account Number',
                html: '<form id="transferForm" action="CreateAccount" method="post">' +
                    '<input type="hidden" name="action" value="transfer">' +
                    '<input id="amountInput" class="swal2-input" name="accountNumber" type="text" placeholder="Enter Account Number">' +
                    '</form>',
                showCancelButton: true,
                confirmButtonText: 'Ok',
                cancelButtonText: 'Cancel',
                showLoaderOnConfirm: true,
                preConfirm: () => {
                    const amount = document.getElementById('amountInput').value;
                    console.log('Account Number:', amount);
                    return amount;
                }
            }).then((result) => {
                if (result.isConfirmed) {
                   
                    document.getElementById('transferForm').submit();
                }
            });
        }

    });
}

document.addEventListener('DOMContentLoaded', function() {
    var dropdownToggle = document.getElementById('dropdownMenuButton');
    var dropdownMenu = document.querySelector('.dropdown-menu');

    dropdownToggle.addEventListener('click', function() {
        dropdownMenu.classList.toggle('show');
    });

    window.addEventListener('click', function(event) {
        if (!dropdownToggle.contains(event.target)) {
            dropdownMenu.classList.remove('show');
        }
    });
});
</script>

</html>
