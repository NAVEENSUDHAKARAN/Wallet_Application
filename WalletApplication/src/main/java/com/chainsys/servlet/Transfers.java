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

/**
 * Servlet implementation class Transfers
 */
@WebServlet("/Transfers")
public class Transfers extends HttpServlet {
	private static final long serialVersionUID = 1L;
    static ServerManager manager = new ServerManager(); 
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Transfers() {
        super();

    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    
    static String receiverWalletId = "receiverWalletID";
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String recId = request.getParameter(receiverWalletId);

		try {
			if(manager.checkWalletId(recId)) {
	
				request.getRequestDispatcher("QRPage.jsp?recId="+recId).forward(request, response);
			}else {
			
				doPost(request,response);
			}
		} catch (ClassNotFoundException | SQLException | ServletException | IOException e) {

			e.printStackTrace();
		}   
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String choice = request.getParameter("action");
		final String landingPageJsp = "LandingPage.jsp";
		final String alertMessage = "alertMessage";
		final String invalidWalletIdMsg = "invalidWalletIdMsg";
		final String amountText = "amountToSend";
 		if(choice.equals("accountTransfer"))
		{
			try {
				HttpSession getSession = request.getSession();
				int id = (int) getSession.getAttribute("userid");
				
				String receiverId = request.getParameter(receiverWalletId);
				double amountToSend = Double.parseDouble(request.getParameter(amountText));
				String senderId = request.getParameter("recipientWalletID");
				
				if(manager.checkWalletId(receiverId) && manager.checkAccountNumber(id, senderId))
				{

						manager.deductBankBalance(id, amountToSend);
						amountToSend += manager.getWalletBalance(senderId);
						manager.updateWalletBalance(amountToSend, receiverId);
						request.getRequestDispatcher(landingPageJsp).forward(request, response);
				}
				else if(senderId == null) {
					request.setAttribute(invalidWalletIdMsg, "Create Account");
					
					request.getRequestDispatcher("AccountTransferPage.jsp").forward(request, response);
				}
				else
				{
					 request.setAttribute(invalidWalletIdMsg, "Can't Find The WalletID");
					
					request.getRequestDispatcher("AccountTransferPage.jsp").forward(request, response);
				}
			} catch (ClassNotFoundException | SQLException | ServletException | IOException e) {

				e.printStackTrace();
			}   
		}else if(choice.equals("walletTransfer")){
			try {
			    int id = Integer.parseInt(request.getParameter("id"));
			    double amountToSend = Double.parseDouble(request.getParameter(amountText));
				String senderId = request.getParameter("senderWalletId");
				String receiverId = request.getParameter(receiverWalletId);			
				String password = request.getParameter("password");
				
			    if(manager.checkWalletId(receiverId) && manager.checkWalletId(senderId) && manager.checkPassword(id, password)) {

					manager.deductWalletBalance(senderId, amountToSend);

					manager.updateWalletBalance(amountToSend, receiverId);
					manager.updateTransactionHistory(senderId, receiverId, amountToSend);
					request.getRequestDispatcher(landingPageJsp).forward(request, response);
				}
				else if(!manager.checkPassword(id, password)){
					request.setAttribute(alertMessage, "Invalid Password");
					request.getRequestDispatcher("WalletTransfer.jsp").forward(request, response);
				}
				else if(!manager.checkWalletId(receiverId)) {
					request.setAttribute(alertMessage, "Invalid WalletID");
					request.getRequestDispatcher("WalletTransfer.jsp").forward(request, response);
				}
			} catch (NumberFormatException | ClassNotFoundException | SQLException e) {
				e.printStackTrace();
			    
			}

			
		}else if(choice.equals("mobileTransfer")) {

			try {
				
				String senderId = request.getParameter("senderWalletId");
				String[] splitedSenderId = senderId.split("@");
				String appendedSenderId = splitedSenderId[0]+"@gmail.com";
				String receiverId = request.getParameter("receiverWalletId");
				double amountToSend = Double.parseDouble(request.getParameter(amountText));
				String password = request.getParameter("password");
				
				if(manager.checkWalletId(receiverId) && manager.checkWalletId(senderId) && manager.checkPassword(appendedSenderId, password)) {

					manager.deductWalletBalance(senderId, amountToSend);

					manager.updateWalletBalance(amountToSend, receiverId);
					manager.updateTransactionHistory(senderId, receiverId, amountToSend);
					request.getRequestDispatcher(landingPageJsp).forward(request, response);
				}else if(!manager.checkPassword(appendedSenderId, password)){
					request.setAttribute(alertMessage, "Invalid Password");
					request.getRequestDispatcher("WalletTransferPage.jsp").forward(request, response);
				}
				else if(!manager.checkWalletId(receiverId)) {
					request.setAttribute(alertMessage, "Invalid WalletID");
					request.getRequestDispatcher("WalletTransferPage.jsp").forward(request, response);
				}
			} catch (ClassNotFoundException | SQLException | ServletException | IOException e) {

				e.printStackTrace();
			}   

		}

	}

}
