package com.chainsys.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.Scanner;

import com.chainsys.model.BankAccountInfo;
import com.chainsys.model.CardInfo;
import com.chainsys.model.TransactionInfo;
import com.chainsys.model.UserInfo;
import com.chainsys.model.WalletIdInfo;
import com.chainsys.util.ConnectUtil;

public class ServerManager {

	static String password = "password";
	static String balanceText = "balance";
	static String mail = "email";
	static String walId = "wallet_id";
	
	Scanner scan = new Scanner(System.in);
	Random random = new Random();
	
	public int accountNumberGeneration() {
		String accountNumber = null;
		accountNumber = "1002024"+random.nextInt(100);
		
		return Integer.parseInt(accountNumber);
	}
	
	public Long transactionIdGenerator() {

		LocalDateTime currentDateandTime = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
	    String formattedDateTime = currentDateandTime.format(formatter);
	 
	    String transactionId = formattedDateTime + random.nextInt(1000);
		
		return Long.parseLong(transactionId);
	}
	
	public long digipayCardNumberGenerator() {
		String prefix = "10002024";
		StringBuilder strBuilder = new StringBuilder(prefix);
		
		for(int i=1; i<=8; i+=1) {
			strBuilder.append(random.nextInt(10));
		}
		
		return Long.parseLong(strBuilder.toString());
		
	}
	
	public int cvvGenerator() {
		StringBuilder strBuilder = new StringBuilder();
		
		for(int i=1; i<=3; i+=1)
		{
			strBuilder.append(random.nextInt(10));
		}
		
		return Integer.parseInt(strBuilder.toString());
	}

	public void setUserDetails(UserInfo pojo) throws ClassNotFoundException, SQLException {
	    Connection connection = null;
	    PreparedStatement prepareStatement = null;
	    
	    try {
	        connection = ConnectUtil.getConnection();
	        String query = "insert into users values (?,?,?,?,?)";
	        prepareStatement = connection.prepareStatement(query);
	        
	        prepareStatement.setInt(1, 0);
	        prepareStatement.setString(2, pojo.getFirstName());
	        prepareStatement.setString(3, pojo.getLastName());
	        prepareStatement.setString(4, pojo.getPassword());
	        prepareStatement.setString(5, pojo.getEmail());
	        
	        prepareStatement.executeUpdate();
	        
	    } catch (SQLIntegrityConstraintViolationException e) {
	        e.printStackTrace();
	    } finally {

	        if (prepareStatement != null) {
	            try {
	                prepareStatement.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	        if (connection != null) {
	            try {
	                connection.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	    }
	}

	
	public int getUserID(UserInfo info) throws SQLException, ClassNotFoundException {
	    String query = "Select user_id from users where email = ?";
	    int userId = 0;

	    try (Connection connection = ConnectUtil.getConnection();
	         PreparedStatement prepareStatement = connection.prepareStatement(query)) {

	        prepareStatement.setString(1, info.getEmail());

	        try (ResultSet rows = prepareStatement.executeQuery()) {
	            ResultSetMetaData metaData = rows.getMetaData();
	            int columnCount = metaData.getColumnCount();

	            while (rows.next()) {
	                for (int i = 1; i <= columnCount; i++) {
	                    userId = rows.getInt(i);

	                }
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace(); 
	    }

	    return userId; 
	}

	
	public int getUserIDFromAccountTable(UserInfo info) throws SQLException, ClassNotFoundException {
	    String query = "SELECT user_id FROM users WHERE email = ?";
	    int userId = 0;

	    try (Connection connection = ConnectUtil.getConnection();
	         PreparedStatement prepareStatement = connection.prepareStatement(query)) {

	        prepareStatement.setString(1, info.getEmail());

	        try (ResultSet rows = prepareStatement.executeQuery()) {
	            ResultSetMetaData metaData = rows.getMetaData();
	            int columnCount = metaData.getColumnCount();

	            while (rows.next()) {
	                for (int i = 1; i <= columnCount; i++) {
	                    userId = rows.getInt(i);
	                }
	            }
	        }
	    } catch (SQLException e) {
	       
	        e.printStackTrace();
	    }

	    return userId; 
	}

	
	public boolean checkUserId(int id) throws ClassNotFoundException, SQLException {
	    String query = "SELECT user_id FROM bank_accounts WHERE user_id = ?";

	    try (Connection connection = ConnectUtil.getConnection();
	         PreparedStatement prep = connection.prepareStatement(query)) {

	        prep.setInt(1, id);

	        try (ResultSet rows = prep.executeQuery()) {
	            while (rows.next()) {
	                return true;
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return false;
	}

	
	public void createAccount(BankAccountInfo detail, int id) throws ClassNotFoundException, SQLException {
	    String query = "INSERT INTO bank_accounts (user_id, account_number, phonenumber, dateofbirth, aadhaarnumber, residential_address, balance) VALUES (?, ?, ?, ?, ?, ?, ?)";

	    try (Connection connection = ConnectUtil.getConnection();
	         PreparedStatement prepareStatement = connection.prepareStatement(query)) {

	        prepareStatement.setInt(1, id);
	        prepareStatement.setInt(2, accountNumberGeneration());
	        prepareStatement.setString(3, detail.getPhoneNumber());
	        prepareStatement.setString(4, detail.getDOB());
	        prepareStatement.setLong(5, detail.getAadharNumber());
	        prepareStatement.setString(6, detail.getAddress());
	        prepareStatement.setInt(7, 500);

	        prepareStatement.executeUpdate();

	    } catch (SQLException e) {

	        e.printStackTrace();
	    }
	}


	public String getUserName(UserInfo pojo) throws ClassNotFoundException, SQLException {
	    String query = "SELECT first_name FROM users WHERE email = ?";
	    String userName = "";

	    try (Connection connection = ConnectUtil.getConnection();
	         PreparedStatement prepareStatement = connection.prepareStatement(query)) {

	        prepareStatement.setString(1, pojo.getEmail());

	        try (ResultSet rows = prepareStatement.executeQuery()) {
	            ResultSetMetaData metaData = rows.getMetaData();
	            int columnCount = metaData.getColumnCount();

	            while (rows.next()) {
	                for (int i = 1; i <= columnCount; i++) {
	                    userName = rows.getString(i);
	                }
	            }
	        }
	    } catch (SQLException e) {

	        e.printStackTrace();
	    }

	    return userName;
	}

	
	public String getUserName(int id) throws ClassNotFoundException, SQLException {
	    String query = "SELECT first_name FROM users WHERE user_id = ?";
	    String userName = "";

	    try (Connection connection = ConnectUtil.getConnection();
	         PreparedStatement prepareStatement = connection.prepareStatement(query)) {

	        prepareStatement.setInt(1, id);

	        try (ResultSet rows = prepareStatement.executeQuery()) {
	            if (rows.next()) {
	                userName = rows.getString(1);
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return userName;
	}

	
	public boolean retrieveUserCred(UserInfo pojo) throws ClassNotFoundException, SQLException {
	    String query = "SELECT email FROM users WHERE email = ?";
	    
	    try (Connection connection = ConnectUtil.getConnection();
	         PreparedStatement prepareStatement = connection.prepareStatement(query)) {

	        prepareStatement.setString(1, pojo.getEmail());

	        try (ResultSet rows = prepareStatement.executeQuery()) {
	            if (rows.next()) {

	                return false;
	            }
	        }
	    } catch (SQLException e) {
	
	        e.printStackTrace();
	    }

	    return true; 
	}

	public boolean checkLogin(String email, String password) throws ClassNotFoundException, SQLException {
	    String query = "SELECT email, password FROM users WHERE email = ? AND password = ?";
	    
	    try (Connection connection = ConnectUtil.getConnection();
	         PreparedStatement prep = connection.prepareStatement(query)) {

	        prep.setString(1, email);
	        prep.setString(2, password);

	        try (ResultSet rows = prep.executeQuery()) {
	            if (rows.next()) {
	                return true;
	            }
	        }
	    } catch (SQLException e) {
	     
	        e.printStackTrace();
	    }

	    return false;
	}

	
	public boolean checkAccountNumber(int id, String accNo) throws ClassNotFoundException, SQLException {
	    String query = "SELECT account_number FROM bank_accounts WHERE user_id = ?";
	    
	    try (Connection connection = ConnectUtil.getConnection();
	         PreparedStatement prepStatement = connection.prepareStatement(query)) {

	        prepStatement.setInt(1, id);

	        try (ResultSet rows = prepStatement.executeQuery()) {
	            while (rows.next()) {
	                String accountNumber = rows.getString("account_number");
	                if (accNo.equals(accountNumber)) {
	                    return true;
	                }
	            }
	        }
	    } catch (SQLException e) {

	        e.printStackTrace();
	    }

	    return false;
	}

	
	public boolean checkPassword(int userId, String password) throws ClassNotFoundException, SQLException {
	    String query = "SELECT password FROM users WHERE user_id = ?";
	    
	    try (Connection connection = ConnectUtil.getConnection();
	         PreparedStatement prepStatement = connection.prepareStatement(query)) {

	        prepStatement.setInt(1, userId);

	        try (ResultSet rows = prepStatement.executeQuery()) {
	            if (rows.next()) {
	                String storedPassword = rows.getString(password);
	                return password.equals(storedPassword);
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return false; 
}

	public boolean checkPassword(String walletId, String password) throws ClassNotFoundException, SQLException {
	    String query = "SELECT password FROM users WHERE email = ?";
	    
	    try (Connection connection = ConnectUtil.getConnection();
	         PreparedStatement prepStatement = connection.prepareStatement(query)) {

	        prepStatement.setString(1, walletId);

	        try (ResultSet rows = prepStatement.executeQuery()) {
	            if (rows.next()) {
	                String storedPassword = rows.getString(password);
	                return password.equals(storedPassword);
	            }
	        }
	    } catch (SQLException e) {
	    	e.printStackTrace(); 
	    }

	    return false;
	}

		
	public void depositAmount(String accNo, double amount) throws ClassNotFoundException, SQLException {
	    String query = "UPDATE bank_accounts SET balance = ? WHERE account_number = ?";
	    
	    try (Connection connection = ConnectUtil.getConnection();
	         PreparedStatement prepareStatement = connection.prepareStatement(query)) {

	        prepareStatement.setDouble(1, amount);
	        prepareStatement.setString(2, accNo);

	        prepareStatement.executeUpdate();
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}

	
	public int getAvailableBalance(String accNo) throws ClassNotFoundException, SQLException {
	    String query = "SELECT balance FROM bank_accounts WHERE account_number = ?";
	    
	    try (Connection connection = ConnectUtil.getConnection();
	         PreparedStatement prepareStatement = connection.prepareStatement(query)) {

	        prepareStatement.setString(1, accNo);

	        try (ResultSet rows = prepareStatement.executeQuery()) {
	            if (rows.next()) {
	                return rows.getInt(balanceText);
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return 0;
	}

	
	public boolean checkEmail(int id) throws ClassNotFoundException, SQLException {
	    String query = "SELECT email FROM users WHERE user_id = ?";
	    
	    try (Connection connection = ConnectUtil.getConnection();
	         PreparedStatement prepareStatement = connection.prepareStatement(query)) {

	        prepareStatement.setInt(1, id);

	        try (ResultSet rows = prepareStatement.executeQuery()) {
	            if (rows.next()) {
	                String email = rows.getString(mail);
	                return email != null && !email.isEmpty();
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return false;
	}

	
	public String getEmail(int id) throws ClassNotFoundException, SQLException {
	    String query = "SELECT email FROM users WHERE user_id = ?";
	    String email = "";

	    try (Connection connection = ConnectUtil.getConnection();
	         PreparedStatement prepareStatement = connection.prepareStatement(query)) {

	        prepareStatement.setInt(1, id);

	        try (ResultSet rows = prepareStatement.executeQuery()) {
	            if (rows.next()) {
	                email = rows.getString(email);
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return email;
	}

	
	public int getBalance(int id) throws ClassNotFoundException, SQLException {
	    String query = "SELECT balance FROM bank_accounts WHERE user_id = ?";
	    int balance = 0;

	    try (Connection connection = ConnectUtil.getConnection();
	         PreparedStatement prepareStatement = connection.prepareStatement(query)) {

	        prepareStatement.setInt(1, id);

	        try (ResultSet rows = prepareStatement.executeQuery()) {
	            if (rows.next()) {
	                balance = rows.getInt(balance);
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return balance;
	}

	
	public void createWalletId(WalletIdInfo walletInfo) throws ClassNotFoundException, SQLException {
	    String query = "INSERT INTO wallets (wallet_id, user_id, balance, qr) VALUES (?, ?, ?, ?)";

	    try (Connection connection = ConnectUtil.getConnection();
	         PreparedStatement prepareStatement = connection.prepareStatement(query)) {

	        prepareStatement.setString(1, walletInfo.getWalletId());
	        prepareStatement.setInt(2, walletInfo.getId());
	        prepareStatement.setInt(3, 0);
	        prepareStatement.setBytes(4, walletInfo.getImage());

	        prepareStatement.executeUpdate();

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}

	
	public boolean checkWalletId(int id) throws ClassNotFoundException, SQLException {
	    String query = "SELECT wallet_id FROM wallets WHERE user_id = ?";
	    boolean walletExists = false;

	    try (Connection connection = ConnectUtil.getConnection();
	         PreparedStatement preparedStatement = connection.prepareStatement(query)) {

	        preparedStatement.setInt(1, id);

	        try (ResultSet rows = preparedStatement.executeQuery()) {
	            while (rows.next()) {

	                walletExists = true;
	            }
	        }
	    } catch (SQLException e) {

	        e.printStackTrace(); 
	    }

	    return walletExists;
	}
	
	public boolean checkWalletId(String walletId) throws ClassNotFoundException, SQLException {
	    String query = "SELECT wallet_id FROM wallets WHERE wallet_id = ?";
	    boolean walletExists = false;

	    try (Connection connection = ConnectUtil.getConnection();
	         PreparedStatement preparedStatement = connection.prepareStatement(query)) {

	        preparedStatement.setString(1, walletId);

	        try (ResultSet rows = preparedStatement.executeQuery()) {
	            if (rows.next()) {
	                walletExists = true;
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace(); 
	    }

	    return walletExists;
	}
	
	public String getWalletId(int id) throws ClassNotFoundException, SQLException {
	    String query = "SELECT wallet_id FROM wallets WHERE user_id = ?";
	    String walletId = null;

	    try (Connection connection = ConnectUtil.getConnection();
	         PreparedStatement preparedStatement = connection.prepareStatement(query)) {

	        preparedStatement.setInt(1, id);

	        try (ResultSet rows = preparedStatement.executeQuery()) {
	            if (rows.next()) {
	                walletId = rows.getString(walId);
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return walletId;
	}

	
	public String getWalletId(String walletId) throws ClassNotFoundException, SQLException {
	    String query = "SELECT wallet_id FROM wallets WHERE wallet_id = ?";
	    String foundWalletId = null;

	    try (Connection connection = ConnectUtil.getConnection();
	         PreparedStatement preparedStatement = connection.prepareStatement(query)) {

	        preparedStatement.setString(1, walletId);

	        try (ResultSet rows = preparedStatement.executeQuery()) {
	            if (rows.next()) {
	                foundWalletId = rows.getString(walId);
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return foundWalletId;
	}

	
	public List<UserInfo> readUserDetails(int id) throws ClassNotFoundException {
	    List<UserInfo> userDetailsList = new ArrayList<>(); 
	    String query = "SELECT user_id, first_name, last_name, password, email FROM users WHERE user_id = ?";
        
	    try (Connection connection = ConnectUtil.getConnection();
	    		PreparedStatement prepareStatement = connection.prepareStatement(query);) {
	        
	        prepareStatement.setInt(1, id);
	        
	        ResultSet resultSet = prepareStatement.executeQuery();

	        while (resultSet.next()) {
	            UserInfo userDetails = new UserInfo();
	            userDetails.setFirstName(resultSet.getString("first_name"));
	            userDetails.setLastName(resultSet.getString("last_name"));
	            userDetails.setPassword(resultSet.getString(password));
	            userDetails.setEmail(resultSet.getString("email"));
	            userDetailsList.add(userDetails);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return userDetailsList;
	}


	
	public List<BankAccountInfo> readAccountDetails(int id) throws ClassNotFoundException {
	    List<BankAccountInfo> accountDetailsList = new ArrayList<>();
        String query = "SELECT user_id, account_number, phonenumber, dateofbirth, aadhaarnumber, residential_address, balance FROM bank_accounts WHERE user_id = ?";

	    try (Connection connection = ConnectUtil.getConnection();
		        PreparedStatement prepareStatement = connection.prepareStatement(query);) {
	        prepareStatement.setInt(1, id);
	        
	        ResultSet resultSet = prepareStatement.executeQuery();

	        while (resultSet.next()) {
	            BankAccountInfo accountDetails = new BankAccountInfo();
	            accountDetails.setPhoneNumber(resultSet.getString("phonenumber"));
	            accountDetails.setDOB(resultSet.getString("dateofbirth"));
	            accountDetails.setAadharNumber(resultSet.getLong("aadhaarnumber"));
	            accountDetails.setAccNo(resultSet.getString("account_number"));
	            accountDetails.setAddress(resultSet.getString("residential_address"));
	            accountDetails.setAmount(resultSet.getDouble(balanceText));
	            accountDetailsList.add(accountDetails);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace(); 
	    }

	    return accountDetailsList;
	}
	
	public List<WalletIdInfo> readWalletDetails(int id) throws ClassNotFoundException {
	    List<WalletIdInfo> walletDetailsList = new ArrayList<>(); 
        String query = "SELECT wallet_id, user_id, balance, qr FROM wallets WHERE user_id = ?";

	    try (Connection connection = ConnectUtil.getConnection();
	    		PreparedStatement prepareStatement = connection.prepareStatement(query);) {
	        
	        prepareStatement.setInt(1, id);
	        
	        ResultSet resultSet = prepareStatement.executeQuery();

	        while (resultSet.next()) {
	            WalletIdInfo walletDetails = new WalletIdInfo();
	            walletDetails.setWalletId(resultSet.getString(walId));
	            walletDetails.setImage(resultSet.getBytes("qr"));
	            walletDetailsList.add(walletDetails);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return walletDetailsList;
	}
	
	public List<WalletIdInfo> readWalletDetails(String walletId) throws ClassNotFoundException {
	    List<WalletIdInfo> walletDetailsList = new ArrayList<>();
        String query = "SELECT wallet_id, user_id, balance, qr FROM wallets WHERE wallet_id = ?";

	    try (Connection connection = ConnectUtil.getConnection();
	    		PreparedStatement prepareStatement = connection.prepareStatement(query);) {
	        
	        prepareStatement.setString(1, walletId);
	        
	        ResultSet resultSet = prepareStatement.executeQuery();

	        while (resultSet.next()) {
	            WalletIdInfo walletDetails = new WalletIdInfo();
	            walletDetails.setWalletId(resultSet.getString(walId));
	            walletDetails.setImage(resultSet.getBytes("qr"));
	            walletDetailsList.add(walletDetails);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return walletDetailsList;
	}
	
	public List<TransactionInfo> readTransactionHistory(String walletId) throws ClassNotFoundException {
	    List<TransactionInfo> historyDetailsList = new ArrayList<>();
	    String query = "SELECT transaction_id, sender_wallet_id, receiver_wallet_id, DataAndTime, amount " +
                "FROM transactions WHERE sender_wallet_id = ? ORDER BY DataAndTime DESC";
	    
	    try (Connection connection = ConnectUtil.getConnection();
		        PreparedStatement prepareStatement = connection.prepareStatement(query);) {
	        
	        prepareStatement.setString(1, walletId);
	        
	        ResultSet resultSet = prepareStatement.executeQuery();

	        while (resultSet.next()) {
	            TransactionInfo transactionDetails = new TransactionInfo();
	            transactionDetails.setTransactionId(resultSet.getString("transaction_id"));
	            transactionDetails.setSenderWalletID(resultSet.getString("sender_wallet_id"));
	            transactionDetails.setReceiverWalletID(resultSet.getString("receiver_wallet_id"));
	            transactionDetails.setDateAndTime(resultSet.getString("DataAndTime"));
	            transactionDetails.setAmountTransfered(resultSet.getDouble("amount"));
	            historyDetailsList.add(transactionDetails);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return historyDetailsList;
	}
	
	public List<CardInfo> readCardDetails(int userId) throws ClassNotFoundException {
	    List<CardInfo> cardDetailsList = new ArrayList<>();
	    String query = "select * from cards where user_id = ?";
	    
	    try (Connection connection = ConnectUtil.getConnection();
		        PreparedStatement prepareStatement = connection.prepareStatement(query);) {
	        
	        prepareStatement.setInt(1, userId);
	        
	        ResultSet resultSet = prepareStatement.executeQuery();

	        while (resultSet.next()) {
	        	CardInfo cardDetails = new CardInfo();
	        	cardDetails.setCardNumber(resultSet.getLong("cardnumber"));
	        	cardDetails.setExpiryDate(resultSet.getString("expiry_date"));
	        	cardDetails.setCvv(resultSet.getInt("cvv"));
	        	cardDetailsList.add(cardDetails);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return cardDetailsList;
	}
	
	public double getWalletBalance(int id) throws ClassNotFoundException, SQLException {
		String query = "SELECT balance FROM wallets WHERE user_id = ?";
		double balance = 0.0;
	    
	    try (Connection connection = ConnectUtil.getConnection();
	    		PreparedStatement prepareStatement = connection.prepareStatement(query);) {
	        
	        prepareStatement.setInt(1, id);
	        
	        try (ResultSet rows = prepareStatement.executeQuery()) {
	            if (rows.next()) {
	                balance = rows.getDouble(balanceText);
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    
	    return balance;
	}	
	
	
	public void updateWalletBalance(double balance, String walletId) throws ClassNotFoundException, SQLException {
		String query = "update wallets set balance = ? where wallet_id = ?";

		try(Connection connection = ConnectUtil.getConnection();
				PreparedStatement prepareStatement = connection.prepareStatement(query);) {
			
			double amountToUpdate = balance + getWalletBalance(walletId);
			
			
			prepareStatement.setDouble(1, amountToUpdate);
			prepareStatement.setString(2, walletId);

			prepareStatement.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}
	
	public double getWalletBalance(String walletId) throws ClassNotFoundException, SQLException {
	    String query = "SELECT balance FROM wallets WHERE wallet_id = ?";
	    
	    try (Connection connection = ConnectUtil.getConnection();
	         PreparedStatement prepareStatement = connection.prepareStatement(query)) {
	        
	        prepareStatement.setString(1, walletId);
	        
	        try (ResultSet rows = prepareStatement.executeQuery()) {
	            if (rows.next()) {
	                return rows.getDouble(balanceText);
	            }
	        }
	        return 0.0;
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	        throw e;
	    }
	}

	
	public void deductBankBalance(int id, double amount) throws ClassNotFoundException, SQLException {
	    String query = "UPDATE bank_accounts SET balance = ? WHERE user_id = ?";
	    
	    try (Connection connection = ConnectUtil.getConnection();
	         PreparedStatement prepareStatement = connection.prepareStatement(query)) {
	        
	        double updatedAmount = getBalance(id) - amount;
	        
	        prepareStatement.setDouble(1, updatedAmount);
	        prepareStatement.setInt(2, id);
	        
	        prepareStatement.executeUpdate();
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}

	
	public void deductWalletBalance(String walletId, double amount) throws ClassNotFoundException, SQLException {
	    String query = "update wallets set balance = ? where wallet_id = ?";
	    
	    try (Connection connection = ConnectUtil.getConnection();
	         PreparedStatement prepareStatement = connection.prepareStatement(query)) {
	        
	        double updatedAmount = getWalletBalance(walletId) - amount;
	        
	        prepareStatement.setDouble(1, updatedAmount);
	        prepareStatement.setString(2, walletId);
	        
	        prepareStatement.executeUpdate();
	        
	    } catch (SQLException e) {
	        
	        e.printStackTrace(); 
	    }
	}

	
	public void updateTransactionHistory(String senderId, String receiverId, double amount) throws ClassNotFoundException, SQLException {
	    String query = "INSERT INTO transactions (transaction_id, sender_wallet_id, receiver_wallet_id, DataAndTime, amount) VALUES (?,?,?,?,?)";

	    try (Connection connection = ConnectUtil.getConnection();
	         PreparedStatement prepareStatement = connection.prepareStatement(query)) {
	    	
	    	long transactionId = transactionIdGenerator();
	        LocalDateTime now = LocalDateTime.now();

	        prepareStatement.setLong(1, transactionId);
	        prepareStatement.setString(2, senderId);
	        prepareStatement.setString(3, receiverId);
	        prepareStatement.setString(4, now.toString());
	        prepareStatement.setDouble(5, amount);

	        prepareStatement.executeUpdate();

	    } catch (SQLException e) {
	        e.printStackTrace();
	        throw e;
	    }
	}
	
	public void setCardDetails(CardInfo cardInfo) throws SQLException, ClassNotFoundException {
		String query = "insert into cards (user_id, cardnumber, applied_date, expiry_date, cvv) values (?,?,?,?,?)";
		
		try(Connection connection = ConnectUtil.getConnection();
				PreparedStatement prepareStatement = connection.prepareStatement(query)){
			
			prepareStatement.setInt(1, cardInfo.getId());
			prepareStatement.setLong(2, cardInfo.getCardNumber());
			prepareStatement.setString(3, cardInfo.getAppliedDate());
			prepareStatement.setString(4, cardInfo.getExpiryDate());
			prepareStatement.setInt(5, cardInfo.getCvv());
			
			prepareStatement.executeUpdate();
		}
	}

}