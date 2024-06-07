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
import com.chainsys.model.UserInfo;

/**
 * Servlet implementation class LandingPage
 */
@WebServlet("/LandingPage")
public class LandingPage extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ServerManager manager = new ServerManager();
     UserInfo info = new UserInfo();  
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LandingPage() {
        super();
       
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
		System.out.println("Get Method");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//doGet(request, response);
		
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
				
				if(manager.retrieveUserCred(info))
				{
					manager.setUserDetails(info);
					response.sendRedirect("LoginPage.jsp");
					
				}
				else {
					System.out.println("Email Already Exist!");
					request.setAttribute("message", "Account Already Exist!");
					request.getRequestDispatcher("RegistrationForm.jsp").forward(request, response);

				}
				
				
			} catch (ClassNotFoundException e) {
				
				e.printStackTrace();
			} catch (SQLException e) {
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
			} catch (ClassNotFoundException e) {
				
				e.printStackTrace();
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
			
			try {
				if(manager.checkLogin(email, password))
				{
					session.setAttribute("details", info);
					session.setAttribute("userName", (String) manager.getUserName(info));
					response.sendRedirect("LandingPage.jsp");

				}
				else
				{
					System.out.println("Invalid Login Details");
				
					request.setAttribute("error", "Invalid username or password!");
					request.getRequestDispatcher("LoginPage.jsp").forward(request, response);

				}
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
	}

}
