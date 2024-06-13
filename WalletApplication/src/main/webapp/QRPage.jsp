<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.chainsys.model.WalletIdInfo" %>
<%@ page import="com.chainsys.dao.ServerManager" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>QR Page</title>
</head>
<style>
	
	 body {
        font-family: Arial, sans-serif;
        background-color: #f0f2f5;
        margin: 0;
        padding: 20px; /* Add padding here */
    }
	
	#image{
		 background-color: #ffffff;
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	}
</style>
<body>
	<% 
		String receiverId = request.getParameter("recId");
	
		ServerManager manager = new ServerManager();

    ArrayList<WalletIdInfo> walletInfo = manager.readWalletDetails(receiverId);
    for(WalletIdInfo details : walletInfo){
    	byte[] imageData = details.getImage(); 
        if (imageData != null) {
            String base64Image = java.util.Base64.getEncoder().encodeToString(imageData);
		%>
			<div id="image">
				<img id="qrcode" alt="image" src="data:image/png;base64,<%= base64Image %>">
			</div>
			 
			
		<%System.out.println("image link from DB : " + details.getImage());}else {
			%>
		    <p>No image available</p>
		<%
		}
}
		%>
</body>
</html>