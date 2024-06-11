package com.chainsys.servlet;

import java.io.IOException;
import java.lang.ProcessHandle.Info;
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
import com.chainsys.model.WalletIdInfo;

/**
 * Servlet implementation class CreateAccount
 */
@WebServlet("/CreateAccount")
public class CreateAccount extends HttpServlet {
	private static final long serialVersionUID = 1L;
    ServerManager manager = new ServerManager(); 
    BankAccountInfo accountInfo = new BankAccountInfo();
    WalletIdInfo walletInfo = new WalletIdInfo(); 
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateAccount() {
        super();

    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		//doGet(request, response);
		//System.out.println("CreateAccountPostMethod");
		
		String choice = request.getParameter("action");
		System.out.println("Choice : " + choice);

		if(choice.equals("createAccount"))
		{
			String fname = request.getParameter("firstName");
			accountInfo.setFname(fname);
			String lname = request.getParameter("lastName");
			accountInfo.setLname(lname);
			String phNumber = request.getParameter("phoneNumber");
			accountInfo.setPhoneNumber(phNumber);
			String dob = request.getParameter("dateOfBirth");
			accountInfo.setDOB(dob);
			String aadharNo = request.getParameter("aadhaarNumber");
			long adrNo = Long.parseLong(aadharNo);
			accountInfo.setAadharNumber(adrNo);
			String address = request.getParameter("residentialAddress");
			accountInfo.setAddress(address);
			
			int id = (int) session.getAttribute("userid");
			//System.out.println("_____id : " + id);
			
			try {
				if(!manager.checkUserId(id)) {
					try {
						manager.createAccount(accountInfo, id);
						response.sendRedirect("LandingPage.jsp");
					} catch (ClassNotFoundException e) {
						
						e.printStackTrace();
					} catch (SQLException e) {
						
						e.printStackTrace();
					}
				}
				else
				{
					request.setAttribute("message", "Account Already Exist!!!");
					request.getRequestDispatcher("CreateBankAccount.jsp").forward(request, response);
				}
				
			} catch (ClassNotFoundException e) {

				e.printStackTrace();
			} catch (SQLException e) {

				e.printStackTrace();
			}
		}
		else if(choice.equals("depositAmount"))
		{
			int id = (int) session.getAttribute("userid");
			String accountNumber = request.getParameter("accountNumber");
			accountInfo.setAccNo(accountNumber);
			double amount = Double.parseDouble(request.getParameter("amount"));
			session.setAttribute("accountInfo", accountInfo);
			
			try {
				amount += manager.getAvailableBalance(accountNumber);
			} catch (ClassNotFoundException e) {

				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			accountInfo.setAmount(amount);
			String password = request.getParameter("password");
			
		
			System.out.println("_____id : " + id);
			
			try {
				if(manager.checkAccountNumber(id, accountNumber) && manager.checkPassword(id,password))
				{
				
					manager.depositAmount(accountNumber, amount);
					String balance = String.valueOf(manager.getBalance(id));
					System.out.println("Balance : " + balance);
					request.setAttribute("balance", balance);
					request.getRequestDispatcher("DepositAmount.jsp").forward(request, response);

				}
				else if(!manager.checkPassword(id, password))
				{
					System.out.println("invalid password");
					request.setAttribute("invalidateMessage", "Invalid Password");
					request.getRequestDispatcher("DepositAmount.jsp").forward(request, response);
				}
				else if(!manager.checkAccountNumber(id,accountNumber))
				{
					System.out.println("invalid AccountNumber");
					request.setAttribute("invalidateMessage", "Invalid AccountNumber");
					request.getRequestDispatcher("DepositAmount.jsp").forward(request, response);
				}
				else if(!manager.checkPassword(id, password) && !manager.checkAccountNumber(id,accountNumber))
				{
					System.out.println("both are invalid");
					request.setAttribute("invalidateMessage", "Invalid AccountNumber and Password");
					request.getRequestDispatcher("DepositAmount.jsp").forward(request, response);
				}
			} catch (ClassNotFoundException e) {
				
				e.printStackTrace();
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
		}
		else if(choice.equals("transfer"))
		{
			String accountNumber = (String) request.getParameter("accountNumber");
			System.out.println("Account Number From sweetalert : " + accountNumber);
			
			int id = (int) session.getAttribute("userid");
			System.out.println("_____id : " + id);
			
			try {
				if(!manager.checkWalletId(id))
				{
					String email = manager.getEmail(id);
					System.out.println("Email : " + email);
					String[] splitedEmail = email.split("@");
					String walletId = splitedEmail[0] + "@digipay";
					System.out.println("WalletID : " + walletId);
					
					request.setAttribute("walletID", walletId);
					if(!manager.checkWalletId(id))
					{
						walletInfo.setId(id);
						walletInfo.setWalletId(walletId);
						
						manager.createWalletId(walletInfo);
						request.getRequestDispatcher("LandingPage.jsp").forward(request, response);
					}
					
				}
				else	
				{
					
					
					  System.out.println("Account Already Exist");
					  request.getRequestDispatcher("WalletTransferPage.jsp").forward(request, response);
					 
				}
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (ServletException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

}
