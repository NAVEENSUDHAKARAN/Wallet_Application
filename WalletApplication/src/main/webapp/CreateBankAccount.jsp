<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bank Account Registration</title>
  <style>
    body {
      display: flex;
      justify-content: center;
      align-items: center;
    
      margin: 0;
    }
    #registrationForm {
      width: 500px;
      padding: 20px;
      border: 1px solid #3c445c;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      background-color: #fff;
      border-color:#3c445c;
    }
    #registrationForm .form-group {
      margin-bottom: 20px;
    }
    #registrationForm label {
      display: block;
      margin-bottom: 5px;
    }
    #registrationForm input[type="text"], 
    #registrationForm input[type="tel"], 
    #registrationForm input[type="date"], 
    #registrationForm textarea {
      width: calc(50% - 10px);
      padding: 8px;
      border: 1px solid #3c445c;
      border-radius: 4px;
    }
    #registrationForm input[type="submit"] {
      width: 100%;
      background-color: #3c445c;
      color: white;
      padding: 10px 15px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }
    #registrationForm input[type="submit"]:hover {
      background-color: #3c445c;
    }
  </style>
</head>
<body>
  <div id="registrationForm">
    <h2>Bank Account Registration</h2>
    <form action="CreateAccount" method="post">
      <input type="hidden" name="action" value="createAccount">
      <div class="form-group">
        <label for="firstName">First Name:</label>
        <input type="text" id="firstName" name="firstName" required>
      </div>
      <div class="form-group">
        <label for="lastName">Last Name:</label>
        <input type="text" id="lastName" name="lastName" required>
      </div>
      <div class="form-group">
        <label for="phoneNumber">Phone Number:</label><small style="color: red;" >Format: 10 digits (e.g., 1234567890)</small><br>
        <input type="tel" id="phoneNumber" name="phoneNumber" pattern="[0-9]{10}" required>
        
      </div>
      <div class="form-group">
        <label for="dateOfBirth">Date of Birth:</label>
        <input type="date" id="dateOfBirth" name="dateOfBirth"  max="2006-06-13" required>
      </div>
      <div class="form-group">
        <label for="aadhaarNumber">Aadhaar Number:</label><small style="color: red;" >12-digit Aadhaar number</small><br>
        <input type="text" id="aadhaarNumber" name="aadhaarNumber" pattern="[0-9]{12}" required>
        
      </div>
      <div class="form-group">
        <label for="residentialAddress">Residential Address:</label>
        <textarea id="residentialAddress" name="residentialAddress" rows="4" required></textarea>
      </div>
      <input type="submit" value="Submit">
    </form>
  </div>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
  <% String alertMessage = (String) request.getAttribute("message"); 
	System.out.println("errrrrrror msg : " + alertMessage);
    if (alertMessage != null && !alertMessage.isEmpty()) {    %> 
      Swal.fire({
        icon: 'info',
        title: '<span style="color: #3c445c;"><%= alertMessage %></span>',
        showConfirmButton: false,
        timer: 3000
      });
   <% } %>
</script>
</body>
</html>
