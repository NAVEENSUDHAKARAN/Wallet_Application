package com.chainsys.servlet;

import java.io.IOException;
import java.net.InetAddress;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chainsys.dao.DynamicQR;
import com.chainsys.dao.ServerManager;
import com.chainsys.model.BankAccountInfo;
import com.chainsys.model.WalletIdInfo;

/**
 * Servlet implementation class CreateAccount
 */
@WebServlet("/CreateAccount")
public class CreateAccount extends HttpServlet {
	private static final long serialVersionUID = 1L;
    static ServerManager manager = new ServerManager(); 
    static BankAccountInfo accountInfo = new BankAccountInfo();
    static WalletIdInfo walletInfo = new WalletIdInfo(); 
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateAccount() {
        super();

    }

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String choice = request.getParameter("action");
		final String userId = "userid";
		if(choice.equals("createAccount"))
		{
			
			int id = (int) session.getAttribute(userId);
			
			
			try {
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
				
				if(!manager.checkUserId(id)) {

						manager.createAccount(accountInfo, id);
						response.sendRedirect("LandingPage.jsp");
				}
				else
				{
					request.setAttribute("message", "Account Already Exist!!!");
					request.getRequestDispatcher("CreateBankAccount.jsp").forward(request, response);
				}
				
			} catch (ClassNotFoundException | SQLException e) {

				e.printStackTrace();
			} 
		}
		else if(choice.equals("depositAmount"))
		{
			System.out.println(">=====<");
			final String message = "invalidateMessage";
			try {
				int id = (int) session.getAttribute(userId);
				final String DEPOSIT_AMOUNT_JSP = "DepositAmount.jsp";
				String accountNumber = request.getParameter("accountNumber");
				accountInfo.setAccNo(accountNumber);
				double amount = Double.parseDouble(request.getParameter("amount"));
				session.setAttribute("accountInfo", accountInfo);
	 
				accountInfo.setAmount(amount);
				String password = request.getParameter("password");
				
				if(manager.checkAccountNumber(id, accountNumber) && manager.checkPassword(id,password))
				{	
					System.out.println("<----->");
					amount += manager.getAvailableBalance(accountNumber);
					manager.depositAmount(accountNumber, amount);
					String balance = String.valueOf(manager.getBalance(id));
					request.setAttribute("balance", balance);
					request.getRequestDispatcher(DEPOSIT_AMOUNT_JSP).forward(request, response);

				}
				else if(!manager.checkPassword(id, password))
				{
					
					request.setAttribute(message, "Invalid Password");
					request.getRequestDispatcher(DEPOSIT_AMOUNT_JSP).forward(request, response);
				}
				else if(!manager.checkAccountNumber(id,accountNumber))
				{
					request.setAttribute(message, "Invalid AccountNumber");
					request.getRequestDispatcher(DEPOSIT_AMOUNT_JSP).forward(request, response);
				}
				else if(!manager.checkPassword(id, password) && !manager.checkAccountNumber(id,accountNumber))
				{
					request.setAttribute(message, "Invalid AccountNumber and Password");
					request.getRequestDispatcher(DEPOSIT_AMOUNT_JSP).forward(request, response);
				}
			} catch (ClassNotFoundException | SQLException e) {
				
				e.printStackTrace();
			} 
		}
		else if(choice.equals("transfer"))
		{
			
			int id = (int) session.getAttribute(userId);
			
			try {
				if(!manager.checkWalletId(id))
				{
					String email = manager.getEmail(id);
					String[] splitedEmail = email.split("@");
					String walletId = splitedEmail[0] + "@digipay";
					
					request.setAttribute("walletID", walletId);
					if(!manager.checkWalletId(id))
					{
						InetAddress localhost = InetAddress.getLocalHost();
				        DynamicQR.generateQr(manager.getUserName(id),localhost.getHostAddress()+":8080/WalletApplication/MobileTransaction.jsp?id=" + id+"&walletId="+ walletId,walletInfo);
				       				        
						walletInfo.setId(id);
						walletInfo.setWalletId(walletId);
						
						manager.createWalletId(walletInfo);
						request.getRequestDispatcher("LandingPage.jsp").forward(request, response);
					}
					
				}
				else	
				{
					  request.getRequestDispatcher("WalletTransfer.jsp").forward(request, response);	 
				}
			} catch (ClassNotFoundException | SQLException | ServletException | IOException e) {

				e.printStackTrace();
			}   
		}
	
	}

}
