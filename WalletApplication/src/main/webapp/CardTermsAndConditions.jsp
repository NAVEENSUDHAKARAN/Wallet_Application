<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>Terms and Conditions</title>
</head>
 <style>
        .bulletin {
        	position: absolute;
            margin-bottom: 10px;
            padding: 10px;
            width: 50%;
            left: 25%;
            top: 20%;
            border: 1px solid #ccc;
            background-color: white;
            border-radius: 10px;
            box-shadow: 5px 0 5px 0 #3c455c;
        }
        
        #okButton, #cancelButton{
        	background-color: #3c455c;
        	border-radius: 5px;
        	color: white;
        }
        
        #okButton:hover, #cancelButton:hover{
        	cursor: pointer;
        	background-color: black;
        }
    </style>
<body>

 <div class="bulletin">
        <p>To get a card, Rupees 200 will be deducted from your wallet.</p>
        <p>The card's expiry date will be three years from the date of application.</p>
    
    
    <form action="CardTransfer" method="post">
    	<input type="hidden" name="action" value="createCard" >
        <input type="checkbox" id="agreeCheckbox" onchange="toggleButton()"> I agree<br><br>
        <button type="submit" id="okButton" name="submitButton" disabled>OK</button>
        <button type="button" id="cancelButton" onclick="window.location.href='profile.jsp'" name="submitButton" >Cancel</button>
    </form>
</div>
<script>
        function toggleButton() {
            var checkbox = document.getElementById("agreeCheckbox");
            var okButton = document.getElementById("okButton");
            
            okButton.disabled = !checkbox.checked;
        }
</script>
</body>
</html>