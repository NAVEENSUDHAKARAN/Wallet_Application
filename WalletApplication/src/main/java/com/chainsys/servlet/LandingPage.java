package com.chainsys.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chainsys.dao.ServerManager;
import com.chainsys.model.BankAccountInfo;
import com.chainsys.model.UserInfo;

/**
 * Servlet implementation class LandingPage
 */
@WebServlet("/LandingPage")
public class LandingPage extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static ServerManager manager = new ServerManager();
     static UserInfo info = new UserInfo(); 
     static BankAccountInfo accountInfo = new BankAccountInfo();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LandingPage() {
        super();
       
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String choice = request.getParameter("action");
		if(choice.equals("register"))
		{
			try {
				
				String fname = request.getParameter("firstName");
				info.setFirstName(fname);
				String lname = request.getParameter("lastName");
				info.setLastName(lname);
				String email = request.getParameter("email");
				String lowerCaseEmail = email.toLowerCase();
				info.setEmail(lowerCaseEmail);
				String password = request.getParameter("password");
				info.setPassword(password);
				String phoneNumber = request.getParameter("phoneNumber");
				accountInfo.setPhoneNumber(phoneNumber);
				String dob = request.getParameter("dateOfBirth");
				accountInfo.setDOB(dob);
				String aadharNo = request.getParameter("aadhaarNumber");
				long adrNo = Long.parseLong(aadharNo);
				accountInfo.setAadharNumber(adrNo);
				String address = request.getParameter("residentialAddress");
				accountInfo.setAddress(address);
				
				if(manager.retrieveUserCred(info))
				{
					manager.setUserDetails(info);
					int id = manager.getUserID(info);
					manager.createAccount(accountInfo, id);
					response.sendRedirect("LoginPage.jsp");
					
				}
				else {
					request.setAttribute("message", "Account Already Exist!");
					request.getRequestDispatcher("Register.jsp").forward(request, response);

				}
				
				
			} catch (ClassNotFoundException | SQLException e) {
				
				e.printStackTrace();
			} 
		}
		else if(choice.equals("logIN"))
		{
			HttpSession session = request.getSession();
			String email = request.getParameter("email");
			info.setEmail(email);
			String password = request.getParameter("loginPassword");
			
			try {
				int userID = manager.getUserID(info);
				session.setAttribute("userid", userID);
			} catch (ClassNotFoundException | SQLException e) {
				
				e.printStackTrace();
			} 
			
			try {
				if(manager.checkLogin(email, password))
				{
					session.setAttribute("details", info);
					session.setAttribute("userName", manager.getUserName(info));
					response.sendRedirect("LandingPage.jsp");

				}
				else
				{
				
					request.setAttribute("error", "Invalid username or password!");
					request.getRequestDispatcher("LoginPage.jsp").forward(request, response);

				}
			} catch (ClassNotFoundException | SQLException e) {
				e.printStackTrace();
			} 
		}
		
	}

}
