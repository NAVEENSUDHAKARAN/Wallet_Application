<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.chainsys.model.UserInfo" %>
<%@ page import="com.chainsys.model.BankAccountInfo" %>
<%@ page import="com.chainsys.dao.ServerManager" %>
<%@ page import="java.util.ArrayList" %>
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
</style>
<body>
    <div class="container rounded bg-white mt-2 mb-2"  style="box-shadow: 0 0 10px 5px #3c455c;">
    <%
    HttpSession id = request.getSession(); 
    int userId = (int) id.getAttribute("userid");
    System.out.println("id ---> " + userId);
    ServerManager server = new ServerManager();
    ArrayList<UserInfo> arrList = server.readUserDetails(userId);
    for (UserInfo userInfo : arrList) {
    %>
        <div class="row">
            <div class="col-md-3 border-right">
                <div class="d-flex flex-column align-items-center text-center p-3 py-5">
                    <img class="rounded-circle mt-5" width="150px" src="https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg">
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
                            <label class="labels">Name</label>
                            <input type="text" class="form-control" placeholder="first name" value="<%= userInfo.getFirstName() %>" readonly>
                        </div>
                        <div class="col-md-6">
                            <label class="labels">Surname</label>
                            <input type="text" class="form-control" value="<%= userInfo.getLastName() %>" placeholder="surname" readonly>
                        </div>
                    </div>
            <%} %>
            <% 
			    ArrayList<BankAccountInfo> arrList1 = server.readAccountDetails(userId);
			    for (BankAccountInfo bankAccountInfo : arrList1) { 
			%>
                    <div class="row mt-3">
                        <div class="col-md-12">
                            <label class="labels">Mobile Number</label>
                            <input type="text" class="form-control" placeholder="enter phone number" value="<%= bankAccountInfo.getPhoneNumber() %>" readonly>
                        </div><br>
                        <div class="col-md-12" >
                            <label class="labels">Account Number</label>
                            <input type="text" style="border-color: #3c455c; border-radius: 3px;" class="form-control" placeholder="enter address line 1" value="<%= bankAccountInfo.getAccNo() %>" readonly>
                        </div><br>
                        <div class="col-md-12">
                            <label class="labels">Date Of Birth</label>
                            <input type="text" class="form-control" placeholder="enter address line 2" value="<%= bankAccountInfo.getDOB() %>" readonly>
                        </div><br><br>
                        <div class="col-md-12">
                            <label class="labels">Address</label>
                            <input type="text" class="form-control" placeholder="enter postcode" value="<%= bankAccountInfo.getAddress() %>" readonly>
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
                   
                </div>
            </div>
        </div>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
