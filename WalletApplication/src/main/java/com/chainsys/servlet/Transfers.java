package com.chainsys.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;

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
     ServerManager manager = new ServerManager(); 
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Transfers() {
        super();

    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//response.getWriter().append("Served at: ").append(request.getContextPath());
		System.out.println("Get Method");
		String recId = request.getParameter("receiverWalletId");
		System.out.println("----->" + recId);
		try {
			if(manager.checkWalletId(recId)) {
				System.out.println("1");
				request.getRequestDispatcher("QRPage.jsp?recId="+recId).forward(request, response);
			}else {
				System.out.println("2");
			
				doPost(request,response);
			}
		} catch (ClassNotFoundException e) {

			e.printStackTrace();
		} catch (SQLException e) {

			e.printStackTrace();
		} catch (ServletException e) {

			e.printStackTrace();
		} catch (IOException e) {

			e.printStackTrace();
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//doGet(request, response);
		
		System.out.println("Transfers Post Method");
		
		
		String choice = request.getParameter("action");
		System.out.println("Choice : " + choice);
		
		if(choice.equals("accountTransfer"))
		{
			HttpSession getSession = request.getSession();
			int id = (int) getSession.getAttribute("userid");
			
			String receiverId = request.getParameter("receiverWalletID");
			System.out.println("rec ID: " + receiverId);
			double amountToSend = Double.parseDouble(request.getParameter("amountToSend"));
			String senderId = request.getParameter("recipientWalletID");
			System.out.println("SenderID : " + senderId);
			
			try {
				System.out.println("in try");
				if(manager.checkWalletId(receiverId) && manager.checkAccountNumber(id, senderId))
				{

						System.out.println("inif");
						manager.deductBankBalance(id, amountToSend);
						amountToSend += manager.getWalletBalance(senderId);
						manager.updateWalletBalance(amountToSend, receiverId);
						request.getRequestDispatcher("LandingPage.jsp").forward(request, response);
				}
				else if(senderId == null) {
					request.setAttribute("invalidWalletIdMsg", "Create Account");
					
					request.getRequestDispatcher("AccountTransferPage.jsp").forward(request, response);
				}
				else
				{
					
					 System.out.println("invalidWalletIdMsg");
					 request.setAttribute("invalidWalletIdMsg", "Can't Find The WalletID");
					
					request.getRequestDispatcher("AccountTransferPage.jsp").forward(request, response);
				}
			} catch (ClassNotFoundException e) {

				e.printStackTrace();
			} catch (SQLException e) {

				e.printStackTrace();
			} catch (ServletException e) {

				e.printStackTrace();
			} catch (IOException e) {

				e.printStackTrace();
			}
		}else if(choice.equals("walletTransfer")){
			int id = Integer.parseInt(request.getParameter("id"));
			System.out.println("ID ---> " + id);
			String senderId = request.getParameter("senderWalletId");
			System.out.println("SenderID : " + senderId);
			String receiverId = request.getParameter("receiverWalletId");
			System.out.println("Receiver ID: " + receiverId);
			double amountToSend = Double.parseDouble(request.getParameter("amountToSend"));
			String password = request.getParameter("password");
			
			try {
				if(manager.checkWalletId(receiverId) && manager.checkWalletId(senderId) && manager.checkPassword(id, password)) {

					manager.deductWalletBalance(senderId, amountToSend);

					manager.updateWalletBalance(amountToSend, receiverId);
					manager.updateTransactionHistory(senderId, receiverId, amountToSend);
					request.getRequestDispatcher("LandingPage.jsp").forward(request, response);
				}
				else if(!manager.checkPassword(id, password)){
					request.setAttribute("alertMessage", "Invalid Password");
					request.getRequestDispatcher("WalletTransfer.jsp").forward(request, response);
				}
				else if(!manager.checkWalletId(receiverId)) {
					request.setAttribute("alertMessage", "Invalid WalletID");
					request.getRequestDispatcher("WalletTransfer.jsp").forward(request, response);
				}
				else {
					System.out.println("you are totally wrong!!!");
				}
				
			} catch (ClassNotFoundException e) {
		
				e.printStackTrace();
			} catch (SQLException e) {

				e.printStackTrace();
			}
			
		}else if(choice.equals("mobileTransfer")) {
			
			
			String senderId = request.getParameter("senderWalletId");
			System.out.println("SenderID : " + senderId);
			String[] splitedSenderId = senderId.split("@");
			String appendedSenderId = splitedSenderId[0]+"@gmail.com";
			System.out.println("appended : "+ appendedSenderId);
			String receiverId = request.getParameter("receiverWalletId");
			System.out.println("Receiver ID: " + receiverId);
			double amountToSend = Double.parseDouble(request.getParameter("amountToSend"));
			String password = request.getParameter("password");
			
			try {
				if(manager.checkWalletId(receiverId) && manager.checkWalletId(senderId) && manager.checkPassword(appendedSenderId, password)) {

					manager.deductWalletBalance(senderId, amountToSend);

					manager.updateWalletBalance(amountToSend, receiverId);
					manager.updateTransactionHistory(senderId, receiverId, amountToSend);
					request.getRequestDispatcher("LandingPage.jsp").forward(request, response);
				}else if(!manager.checkPassword(appendedSenderId, password)){
					request.setAttribute("alertMessage", "Invalid Password");
					request.getRequestDispatcher("WalletTransferPage.jsp").forward(request, response);
				}
				else if(!manager.checkWalletId(receiverId)) {
					request.setAttribute("alertMessage", "Invalid WalletID");
					request.getRequestDispatcher("WalletTransferPage.jsp").forward(request, response);
				}
			} catch (ClassNotFoundException | SQLException | ServletException | IOException e) {

				e.printStackTrace();
			}   

		}

	}

}
