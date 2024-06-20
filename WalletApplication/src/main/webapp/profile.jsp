<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.chainsys.model.UserInfo" %>
<%@ page import="com.chainsys.model.BankAccountInfo" %>
<%@ page import="com.chainsys.model.CardInfo" %>
<%@ page import="com.chainsys.dao.ServerManager" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>Profile</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
   
</head>
<style>
	body {
    background:	whitesmoke;
	height: 90%;
    padding: 0;
    margin: 0;
}

.form-control:focus {
    box-shadow: none;
    border-color: #3c455c
}

.profile-button {
    background: #3c455c;
    box-shadow: none;
    border: none
}

.profile-button:hover {
    background: black;
}

.profile-button:focus {
    background: #3c455c;
    box-shadow: none
}

.profile-button:active {
    background: #3c455c;
    box-shadow: none
}

.back:hover {
    color: #3c455c;
    cursor: pointer
}

.labels {
    font-size: 11px
}

.add-experience:hover {
    background: #3c455c;
    color: #fff;
    cursor: pointer;
    border: solid 1px #BA68C8
}

	:root {
  --field-border: 1px solid #eeeeee;
  --field-border-radius: 0.5em;
  --secondary-text: #aaaaaa;
  --sidebar-color: #f1f1f1;
  --accent-color: #2962ff;
}

* {
  box-sizing: border-box;
}

.flex {
  display: flex;
}
.flex-center {
  display: flex;
  align-items: center;
  justify-content: center;
}
.flex-fill {
  display: flex;
  flex: 1 1;
}
.flex-vertical {
  display: flex;
  flex-direction: column;
}
.flex-vertical-center {
  display: flex;
  align-items: center;
}
.flex-between {
  display: flex;
  justify-content: space-between;
}
.p-sm {
  padding: 0.5em;
}
.pl-sm {
  padding-left: 0.5em;
}
.pr-sm {
  padding-right: 0.5em;
}
.pb-sm {
  padding-bottom: 0.5em;
}
.p-md {
  padding: 1em;
}
.pb-md {
  padding-bottom: 1em;
}
.p-lg {
  padding: 2em;
}
.m-md {
  margin: 1em;
}
.size-md {
  font-size: 0.85em;
}
.size-lg {
  font-size: 1.5em;
}
.size-xl {
  font-size: 2em;
}
.half-width {
  width: 50%;
}

.pointer {
  cursor: pointer;
}
.uppercase {
  text-transform: uppercase;
}
.ellipsis {
  text-overflow: ellipsis;
  overflow: hidden;
}

.f-main-color {
  color: #2962ff;
}
.f-secondary-color {
  color: var(--secondary-text);
}
.b-main-color {
  background: var(--accent-color);
}
.numbers::-webkit-outer-spin-button,
.numbers::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}

body {
  font-size: 14px;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Roboto", "Oxygen",
    "Ubuntu", "Cantarell", "Fira Sans", "Droid Sans", "Helvetica Neue",
    sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
.bod-3 {
  border-radius: 30px;
}
.main-back {
  background: #a2cdff !important;
  display: flex;
  position: absolute;
  width: 100%;
  height: 100vh;
  top: 0px;
  left: 0px;
}
.header {
  padding-bottom: 1em;
}

.header .title {
  font-size: 1.2em;
}
.header .title span {
  font-weight: 300;
}

.card-data > div {
  padding-bottom: 1.5em;
}
.card-data > div:first-child {
  padding-top: 1.5em;
}

.card-property-title {
  display: flex;
  flex-direction: column;
  flex: 1 1;
  margin-right: 0.5em;
}
.card-property-title strong {
  padding-bottom: 0.5em;
  font-size: 0.85em;
}
.card-property-title span {
  color: var(--secondary-text);
  font-size: 0.75em;
}
.card-property-value {
  flex: 1 1;
}

.card-number {
  background: #fafafa;
  border: var(--field-border);
  border-radius: var(--field-border-radius);
  padding: 0.5em 1em;
}
.card-number-field * {
  line-height: 1;
  margin: 0;
  padding: 0;
}
.card-number-field input {
  width: 100%;
  height: 100%;
  padding: 0.5em 1rem;
  margin: 0 0.75em;
  border: none;
  color: #888888;
  background: transparent;
  font-family: inherit;
  font-weight: 500;
}

.timer span {
  background: #311b92;
  color: #ffffff;
  width: 1.2em;
  padding: 4px 0;
  display: inline-block;
  text-align: center;
  border-radius: 3px;
}
.timer span + span {
  margin-left: 2px;
}
.timer em {
  font-style: normal;
}

.action button {
  padding: 1.1em;
  width: 100%;
  height: 100%;
  font-weight: 600;
  font-size: 1em;
  color: #ffffff;
  border: none;
  border-radius: 0.5em;
  transition: background-color 0.2s ease-in-out;
}
.action button:hover {
  background: #2979ff;
}

.input-container {
  position: relative;
  display: flex;
  align-items: center;
  height: 3em;
  overflow: hidden;
  border: var(--field-border);
  border-radius: var(--field-border-radius);
}
.input-container input,
.input-container i {
  line-height: 1;
}
.input-container input {
  flex: 1 1;
  height: 100%;
  width: 100%;
  text-align: center;
  border: none;
  border-radius: var(--field-border-radius);
  font-family: inherit;
  font-weight: 800;
  font-size: 0.85em;
}
.input-container input:focus {
  background: #e3f2fd;
  color: #283593;
}
.input-container input::placeholder {
  color: #ddd;
}
.input-container input::-webkit-outer-spin-button,
.input-container input::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}
.input-container i {
  position: absolute;
  right: 0.5em;
}

.purchase-section {
  position: relative;
  overflow: visible;
  padding: 0 1em 1em 1em;
  background: var(--sidebar-color);
  border-top-left-radius: 0.8em;
  border-top-right-radius: 0.8em;
}
.purchase-section:before {
  content: "";
  position: absolute;
  width: 1.6em;
  height: 1.6em;
  border-radius: 50%;
  left: -0.8em;
  bottom: -0.8em;
  background: #ffffff;
}
.purchase-section:after {
  content: "";
  position: absolute;
  width: 1.6em;
  height: 1.6em;
  border-radius: 50%;
  right: -0.8em;
  bottom: -0.8em;
  background: #ffffff;
}

.card-mockup {
  position: relative;
  margin: 3em 1em 1.5em 1em;
  padding: 1.5em 1.2em;
  border-radius: 0.6em;
  background: #72a2f7;
  color: #fff;
  box-shadow: 0 0.5em 1em 0.125em rgba(0, 0, 0, 0.1);
}
.card-mockup:after {
  content: "";
  position: absolute;
  width: 25%;
  top: -0.2em;
  left: 37.5%;
  height: 0.2em;
  background: var(--accent-color);
  border-top-left-radius: 0.2em;
  border-top-right-radius: 0.2em;
}
.card-mockup:before {
  content: "";
  position: absolute;
  top: 0;
  width: 25%;
  left: 37.5%;
  height: 0.5em;
  background: #2962ff36;
  border-bottom-left-radius: 0.2em;
  border-bottom-right-radius: 0.2em;
  box-shadow: 0 2px 15px 5px #2962ff4d;
}

.purchase-props {
  margin: 0;
  padding: 0;
  font-size: 0.8em;
  width: 100%;
}
.purchase-props li {
  width: 100%;
  line-height: 2.5;
}
.purchase-props li span {
  color: var(--secondary-text);
  font-weight: 600;
}

.separation-line {
  border-top: 1px dashed #aaa;
  margin: 0 0.8em;
}

.total-section {
  position: relative;
  overflow: hidden;

  padding: 1em;
  background: var(--sidebar-color);
  border-bottom-left-radius: 0.8em;
  border-bottom-right-radius: 0.8em;
}
.total-section:before {
  content: "";
  position: absolute;
  width: 1.6em;
  height: 1.6em;
  border-radius: 50%;
  left: -0.8em;
  top: -0.8em;
  background: #ffffff;
}
.total-section:after {
  content: "";
  position: absolute;
  width: 1.6em;
  height: 1.6em;
  border-radius: 50%;
  right: -0.8em;
  top: -0.8em;
  background: #ffffff;
}
.total-label {
  font-size: 0.8em;
  padding-bottom: 0.5em;
}
.total-section strong {
  font-size: 1.5em;
  font-weight: 800;
}
.total-section small {
  font-weight: 600;
}

#debitCard{
	
	background-color: #6c7484;
}

#getCard{
	position: relative;
	left: 120px;
}

</style>
<body>
    <div class="container rounded bg-white mt-2 mb-2"  style="box-shadow: 0 0 10px 5px #3c455c; height: 95vh;">
    <%
    HttpSession id = request.getSession(); 
    int userId = (int) id.getAttribute("userid");
    System.out.println("id ---> " + userId);
    ServerManager server = new ServerManager();
    List<UserInfo> arrList = server.readUserDetails(userId);
    for (UserInfo userInfo : arrList) {
    %>
        <div class="row">
            <div class="col-md-3 border-right">
                <div class="d-flex flex-column align-items-center text-center p-3 py-5">
                    <img class="rounded-circle mt-5" width="150px" src="images/profilelogo.png" alt="profile">
                    <span class="font-weight-bold"><%= userInfo.getFirstName() %></span>
                    <span class="text-black-50"><%= userInfo.getEmail() %></span>
                </div>
            </div>
            <div class="col-md-5 border-right">
                <div class="p-3 py-5">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h4 class="text-right">Profile</h4>
                    </div>
                    <div class="row mt-2">
                        <div class="col-md-6">
                            <label for="firstName" class="labels">Name</label>
                            <input type="text" name="firstName" class="form-control" placeholder="first name" value="<%= userInfo.getFirstName() %>" readonly>
                        </div>
                        <div class="col-md-6">
                            <label for="lastName" class="labels">Surname</label>
                            <input name="lastName" type="text" class="form-control" value="<%= userInfo.getLastName() %>" placeholder="surname" readonly>
                        </div>
                    </div>
            <%} %>
            <% 
			    List<BankAccountInfo> arrList1 = server.readAccountDetails(userId);
			    for (BankAccountInfo bankAccountInfo : arrList1) { 
			%>
                    <div class="row mt-3">
                        <div class="col-md-12">
                            <label for="mobileNumber" class="labels">Mobile Number</label>
                            <input name="mobileNumber" type="text" class="form-control" placeholder="enter phone number" value="<%= bankAccountInfo.getPhoneNumber() %>" readonly>
                        </div><br>
                        <div class="col-md-12" >
                            <label for="accountNumber" class="labels">Account Number</label>
                            <input name="accountNumber" type="text" style="border-color: #3c455c; border-radius: 3px;" class="form-control" placeholder="enter address line 1" value="<%= bankAccountInfo.getAccNo() %>" readonly>
                        </div><br>
                        <div class="col-md-12">
                            <label for="dob" class="labels">Date Of Birth</label>
                            <input name="dob" type="text" class="form-control" placeholder="enter address line 2" value="<%= bankAccountInfo.getDOB() %>" readonly>
                        </div><br><br>
                        <div class="col-md-12">
                            <label for="address" class="labels">Address</label>
                            <input name="address" type="text" class="form-control" placeholder="enter postcode" value="<%= bankAccountInfo.getAddress() %>" readonly>
                        </div>
                    </div>
                    <div class="mt-5 text-center">
                        <button class="btn btn-primary profile-button" onclick="window.location.href='LandingPage.jsp'" type="button">Back</button>
                    </div>
                </div>
            </div>
       
            <div class="col-md-4">
                <div class="p-3 py-5">
	                    <div class="d-flex justify-content-between align-items-center mb-3">
	                        <h4 class="text-right">Balance</h4>
	                    </div>
                    <div class="col-md-12">
                        <input type="text" class="form-control" placeholder="experience" value="<%= bankAccountInfo.getAmount() %>">
                    </div><br>
           <%} %> 

			<%
				if(server.getUserIdFromCards(userId)){
			%>	
			<div id="debitCard" class="card-mockup flex-vertical snipcss0-0-0-1 snipcss-c6oPp">
		    <img id="logo" src="images/DigiPayNoBG.png" alt="logo" height="40px" width="40px" ><br>
		    <div class="snipcss0-1-1-3">
    	<%
    		String userName = server.getUserName(userId);
    	%>
        <strong class="snipcss0-2-3-4">
            <div id="name_mock" class="size-md pb-sm uppercase ellipsis snipcss0-3-4-5" style="">Mr. <%= userName %></div>
        </strong>
        <% 
        	List<CardInfo> cardDetails = server.readCardDetails(userId);
            for(CardInfo cardInfo : cardDetails){
        %>
        <div class="size-md pb-md snipcss0-2-3-6">
            <strong class="snipcss0-3-6-7">
            <%
            String cardNumber = Long.toString(cardInfo.getCardNumber());

            StringBuilder formattedNumber = new StringBuilder();
            for (int i = 0; i < cardNumber.length(); i += 4) {
                String group = cardNumber.substring(i, Math.min(i + 4, cardNumber.length()));
                formattedNumber.append(group).append(" ");
            }
            %>
                <span id="carddigits_mock" class="snipcss0-4-7-8"><%= formattedNumber %></span>
                <%System.out.println("form frontend ---> " + cardInfo.getCardNumber()); %>
            </strong>
        </div>
        <div class="flex-between flex-vertical-center snipcss0-2-3-9">
            <strong class="size-md snipcss0-3-9-10">
            <%
            	String date = cardInfo.getExpiryDate();
            	String year = date.substring(0, 4);
            	String month = date.substring(4);
            %>
                <span class="snipcss0-4-10-11">Expiry Date : </span><span id="mm_mock" class="snipcss0-4-10-12"><%= month %></span> / <span id="yy_mock" class="snipcss0-4-10-13"><%= year %></span>
            </strong>
            <strong class="size-md snipcss0-3-9-10">
                <span class="snipcss0-4-10-11">CVV : </span><span id="mm_mock" class="snipcss0-4-10-12"><%= cardInfo.getCvv() %></span>
            </strong>
           <%} %>
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48" width="40px" height="40px" class="snipcss0-3-9-14">
                <path fill="#1565C0" d="M45,35c0,2.209-1.791,4-4,4H7c-2.209,0-4-1.791-4-4V13c0-2.209,1.791-4,4-4h34c2.209,0,4,1.791,4,4V35z"></path>
                <path fill="#FFF" d="M15.186 19l-2.626 7.832c0 0-.667-3.313-.733-3.729-1.495-3.411-3.701-3.221-3.701-3.221L10.726 30v-.002h3.161L18.258 19H15.186zM17.689 30L20.56 30 22.296 19 19.389 19zM38.008 19h-3.021l-4.71 11h2.852l.588-1.571h3.596L37.619 30h2.613L38.008 19zM34.513 26.328l1.563-4.157.818 4.157H34.513zM26.369 22.206c0-.606.498-1.057 1.926-1.057.928 0 1.991.674 1.991.674l.466-2.309c0 0-1.358-.515-2.691-.515-3.019 0-4.576 1.444-4.576 3.272 0 3.306 3.979 2.853 3.979 4.551 0 .291-.231.964-1.888.964-1.662 0-2.759-.609-2.759-.609l-.495 2.216c0 0 1.063.606 3.117.606 2.059 0 4.915-1.54 4.915-3.752C30.354 23.586 26.369 23.394 26.369 22.206z"></path>
                <path fill="#FFC107" d="M12.212,24.945l-0.966-4.748c0,0-0.437-1.029-1.573-1.029c-1.136,0-4.44,0-4.44,0S10.894,20.84,12.212,24.945z"></path>
            </svg>
        </div>
    </div>
</div> 
			<%}else{ %>
			<div>
				<div id="debitCard" class="card-mockup flex-vertical snipcss0-0-0-1 snipcss-c6oPp">
		    <img id="logo" src="images/DigiPayNoBG.png" alt="logo" height="40px" width="40px" ><br>
		    <div class="snipcss0-1-1-3">
        <strong class="snipcss0-2-3-4">
            <div id="name_mock" class="size-md pb-sm uppercase ellipsis snipcss0-3-4-5" style="">Mr. CardHolder</div>
        </strong>

        <div class="size-md pb-md snipcss0-2-3-6">
            <strong class="snipcss0-3-6-7">
                <span id="carddigits_mock" class="snipcss0-4-7-8">xxxx xxxx xxxx xxxx</span>
           </strong>
        </div>
        <div class="flex-between flex-vertical-center snipcss0-2-3-9">
            <strong class="size-md snipcss0-3-9-10">
                <span class="snipcss0-4-10-11">Expiry Date : </span><span id="mm_mock" class="snipcss0-4-10-12">mm</span> / <span id="yy_mock" class="snipcss0-4-10-13">yyyy</span>
            </strong>
            <strong class="size-md snipcss0-3-9-10">
                <span class="snipcss0-4-10-11">CVV : </span><span id="mm_mock" class="snipcss0-4-10-12">000</span>
            </strong>

            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48" width="40px" height="40px" class="snipcss0-3-9-14">
                <path fill="#1565C0" d="M45,35c0,2.209-1.791,4-4,4H7c-2.209,0-4-1.791-4-4V13c0-2.209,1.791-4,4-4h34c2.209,0,4,1.791,4,4V35z"></path>
                <path fill="#FFF" d="M15.186 19l-2.626 7.832c0 0-.667-3.313-.733-3.729-1.495-3.411-3.701-3.221-3.701-3.221L10.726 30v-.002h3.161L18.258 19H15.186zM17.689 30L20.56 30 22.296 19 19.389 19zM38.008 19h-3.021l-4.71 11h2.852l.588-1.571h3.596L37.619 30h2.613L38.008 19zM34.513 26.328l1.563-4.157.818 4.157H34.513zM26.369 22.206c0-.606.498-1.057 1.926-1.057.928 0 1.991.674 1.991.674l.466-2.309c0 0-1.358-.515-2.691-.515-3.019 0-4.576 1.444-4.576 3.272 0 3.306 3.979 2.853 3.979 4.551 0 .291-.231.964-1.888.964-1.662 0-2.759-.609-2.759-.609l-.495 2.216c0 0 1.063.606 3.117.606 2.059 0 4.915-1.54 4.915-3.752C30.354 23.586 26.369 23.394 26.369 22.206z"></path>
                <path fill="#FFC107" d="M12.212,24.945l-0.966-4.748c0,0-0.437-1.029-1.573-1.029c-1.136,0-4.44,0-4.44,0S10.894,20.84,12.212,24.945z"></path>
            </svg>
        </div>
    </div>
</div> 
</div>
<button id="getCard" class="btn btn-primary profile-button" onclick="window.location.href='CardTermsAndConditions.jsp'" >Get Card</button>
<%} %>
			


                </div>
            </div>
        </div>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <script>

    const bounds = document.querySelectorAll("[data-bound]");

    for (let i = 0; i < bounds.length; i++) {
      const targetId = bounds[i].getAttribute("data-bound");
      const defValue = bounds[i].getAttribute("data-def");
      const targetEl = document.getElementById(targetId);
      bounds[i].addEventListener(
        "blur",
        () => (targetEl.innerText = bounds[i].value || defValue)
      );
    }

 
    const cvc_toggler = document.getElementById("cvc_toggler");

    cvc_toggler.addEventListener("click", () => {
      const target = cvc_toggler.getAttribute("data-target");
      const el = document.getElementById(target);
      el.setAttribute("type", el.type === "text" ? "password" : "text");
    });

    function onlyNumberKey(evt) {
      // Only ASCII character in that range allowed
      var ASCIICode = evt.which ? evt.which : evt.keyCode;
      if (ASCIICode > 31 && (ASCIICode < 48 || ASCIICode > 57)) return false;
      return true;
    }

    $(function () {
      $("#cardNumber").on("keyup", function (e) {
        var val = $(this).val();
        var newval = "";
        val = val.replace(/\s/g, "");
        for (var i = 0; i < val.length; i++) {
          if (i % 4 == 0 && i > 0) newval = newval.concat(" ");
          newval = newval.concat(val[i]);
        }
        $(this).val(newval);
      });

      $(".year-own").datepicker({
        minViewMode: 2,
        format: "yyyy"
      });

      $(".month-own").datepicker({
        format: "MM",
        minViewMode: "months",
        maxViewMode: "months",
        startView: "months"
      });
    });

    </script>
</body>
</html>
