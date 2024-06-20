package com.chainsys.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.time.YearMonth;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chainsys.dao.ServerManager;
import com.chainsys.model.CardInfo;

/**
 * Servlet implementation class CardTransfer
 */
@WebServlet("/CardTransfer")
public class CardTransfer extends HttpServlet {
	private static final long serialVersionUID = 1L;
    static ServerManager manager = new ServerManager(); 
    static CardInfo cardInfo = new CardInfo();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CardTransfer() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String choice = request.getParameter("action");
		
		if(choice.equals("createCard")){
			
			int userId = (int) session.getAttribute("userid");
			cardInfo.setId(userId);
			long cardNumber = manager.digipayCardNumberGenerator();
			cardInfo.setCardNumber(cardNumber);
			YearMonth appliedDate = YearMonth.now();
			cardInfo.setAppliedDate(appliedDate.toString());
			YearMonth expiryDate = appliedDate.plusYears(3);
			cardInfo.setExpiryDate(expiryDate.toString());
			int cvv = manager.cvvGenerator();
			cardInfo.setCvv(cvv);
			
			try {
				manager.setCardDetails(cardInfo);
				request.getRequestDispatcher("profile.jsp").forward(request, response);
			} catch (ClassNotFoundException | SQLException e) {
				e.printStackTrace();
			} 
			
		}
	}

}
