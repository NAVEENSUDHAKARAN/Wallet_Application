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
import java.util.LinkedList;
import java.util.Queue;
import java.util.Random;
import java.util.Scanner;

import com.chainsys.model.*;
import com.chainsys.util.ConnectUtil;

public class ServerManager {

	Scanner scan = new Scanner(System.in);
	
	public int accountNumberGeneration() {
		String accountNumber = null;
		Random random = new Random();
	
		accountNumber = "1002024"+random.nextInt(100);
		
		return Integer.parseInt(accountNumber);
	}
	
	public Long transactionIdGenerator() {
		
		Random random = new Random();
		LocalDateTime currentDateandTime = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
	    String formattedDateTime = currentDateandTime.format(formatter);
	 
	    String transactionId = formattedDateTime + random.nextInt(1000);
		
		return Long.parseLong(transactionId);
	}

	public void setUserDetails(UserInfo pojo) throws ClassNotFoundException, SQLException {

		while (true) {
			try {
				ConnectUtil connect = new ConnectUtil();
				Connection connection = ConnectUtil.getConnection();

				String query = "insert into users values (?,?,?,?,?)";
				PreparedStatement prepareStatement = connection.prepareStatement(query);
				
				prepareStatement.setInt(1, 0);
				prepareStatement.setString(2, pojo.getFirstName());
				prepareStatement.setString(3, pojo.getLastName());
				prepareStatement.setString(4, pojo.getPassword());
				prepareStatement.setString(5, pojo.getEmail());

				int rows = prepareStatement.executeUpdate();

				System.out.println("Rows Affected : " + rows);
				System.out.println("Inserted To DB!!!");
				break;
			} catch (SQLIntegrityConstraintViolationException e) {
				System.err.println(e);
//				System.out.println("Enter ID Again : ");
//				int id = scan.nextInt();
//				pojo.setId(id);
//				scan.nextLine();
			}
		}
	}
	
	public int getUserID(UserInfo info) throws SQLException, ClassNotFoundException {
		
		ConnectUtil connect = new ConnectUtil();
		Connection connection = ConnectUtil.getConnection();

		String query = "Select user_id from users where email = ?";
		
		PreparedStatement prepareStatement = connection.prepareStatement(query);
		
		prepareStatement.setString(1, info.getEmail());
		
		ResultSet rows = prepareStatement.executeQuery();
		
		ResultSetMetaData metaData = rows.getMetaData();
		int columnCount = metaData.getColumnCount();

		while (rows.next()) {
			for (int i = 1; i <= columnCount; i += 1) {
				return rows.getInt(i);
			}
		}
		return 0;
	}
	
	public int getUserIDFromAccountTable(UserInfo info) throws SQLException, ClassNotFoundException {
			
			ConnectUtil connect = new ConnectUtil();
			Connection connection = ConnectUtil.getConnection();
	
			String query = "Select user_id from users where email = ?";
			
			PreparedStatement prepareStatement = connection.prepareStatement(query);
			
			prepareStatement.setString(1, info.getEmail());
			
			ResultSet rows = prepareStatement.executeQuery();
			
			ResultSetMetaData metaData = rows.getMetaData();
			int columnCount = metaData.getColumnCount();
	
			while (rows.next()) {
				for (int i = 1; i <= columnCount; i += 1) {
					return rows.getInt(i);
				}
			}
			return 0;
		}
	
	public boolean checkUserId(int id) throws ClassNotFoundException, SQLException {
		ConnectUtil connect = new ConnectUtil();
		Connection connection = ConnectUtil.getConnection();

		String query = "select user_id from bank_accounts where user_id = ?";
		PreparedStatement prep = connection.prepareStatement(query);

		prep.setInt(1, id);
		
		ResultSet rows = prep.executeQuery();
		ResultSetMetaData metaData = rows.getMetaData();
		int columnCount = metaData.getColumnCount();

		while (rows.next()) {
			for (int i = 1; i <= columnCount; i += 1) {
				return true;
			}
			System.out.println();
		}
		return false;

	}
	
	public void createAccount(BankAccountInfo detail, int id) throws ClassNotFoundException, SQLException{
		
		ConnectUtil connect = new ConnectUtil();
		Connection connection = connect.getConnection();
		
		String query = "insert into bank_accounts (user_id, account_number, phonenumber, dateofbirth, aadhaarnumber, residential_address, balance) values(?,?,?,?,?,?,?)";
		PreparedStatement prepareStatement = connection.prepareStatement(query);
		
		prepareStatement.setInt(1,id);
		prepareStatement.setInt(2, accountNumberGeneration());
		prepareStatement.setString(3, detail.getPhoneNumber());
		prepareStatement.setString(4, detail.getDOB());
		prepareStatement.setLong(5, detail.getAadharNumber());
		prepareStatement.setString(6, detail.getAddress());
		prepareStatement.setInt(7, 500);		
		
		int rows = prepareStatement.executeUpdate();

		System.out.println("Rows Affected : " + rows);
		System.out.println("Inserted To DB!!!");
			
	}

	public String getUserName(UserInfo pojo) throws ClassNotFoundException, SQLException {
		
		ConnectUtil connect = new ConnectUtil();
		Connection connection = ConnectUtil.getConnection();

		String query = "Select first_name from users where email = ?";
		
		PreparedStatement prepareStatement = connection.prepareStatement(query);
		
		prepareStatement.setString(1, pojo.getEmail());
		
		ResultSet rows = prepareStatement.executeQuery();
		
		ResultSetMetaData metaData = rows.getMetaData();
		int columnCount = metaData.getColumnCount();

		while (rows.next()) {
			for (int i = 1; i <= columnCount; i += 1) {
				return rows.getString(i);
			}
		}
		return "";	
		
	}
	
		public String getUserName(int id) throws ClassNotFoundException, SQLException {
		
		ConnectUtil connect = new ConnectUtil();
		Connection connection = ConnectUtil.getConnection();

		String query = "Select first_name from users where user_id = ?";
		
		PreparedStatement prepareStatement = connection.prepareStatement(query);
		
		prepareStatement.setInt(1, id);
		
		ResultSet rows = prepareStatement.executeQuery();
		
		ResultSetMetaData metaData = rows.getMetaData();
		int columnCount = metaData.getColumnCount();

		while (rows.next()) {
			for (int i = 1; i <= columnCount; i += 1) {
				return rows.getString(i);
			}
		}
		return "";	
		
	}
	
	public boolean retrieveUserCred(UserInfo pojo) throws ClassNotFoundException, SQLException {
		ConnectUtil connect = new ConnectUtil();
		Connection connection = connect.getConnection();
		
		String query = "Select email from users";
		
		PreparedStatement prepareStatement = connection.prepareStatement(query);
		
		ResultSet rows = prepareStatement.executeQuery();
		
		ResultSetMetaData metaData = rows.getMetaData();
		int columnCount = metaData.getColumnCount();

		while (rows.next()) {
			for (int i = 1; i <= columnCount; i += 1) {
				if(rows.getString(i).equals(pojo.getEmail())){
					return false;
				}
			}
		}
		return true;
	}

	public boolean checkLogin(String email, String password) throws ClassNotFoundException, SQLException {
		ConnectUtil connect = new ConnectUtil();
		Connection connection = ConnectUtil.getConnection();

		String query = "select email, password from users where email = ? and Password = ?";
		PreparedStatement prep = connection.prepareStatement(query);

		prep.setString(1, email);
		prep.setString(2, password);
		ResultSet rows = prep.executeQuery();
		ResultSetMetaData metaData = rows.getMetaData();
		int columnCount = metaData.getColumnCount();

		while (rows.next()) {
			for (int i = 1; i <= columnCount; i += 1) {
				return true;
			}
			System.out.println();
		}
		return false;

	}
	
	public boolean checkAccountNumber(int id, String accNo) throws ClassNotFoundException, SQLException{
		
		ConnectUtil connect = new ConnectUtil();
		Connection connection = connect.getConnection();
		
		String query = "Select account_number from bank_accounts where user_id = ?";
		
		PreparedStatement prepStatement = connection.prepareStatement(query);
		prepStatement.setInt(1, id);
		
		ResultSet rows = prepStatement.executeQuery();
		ResultSetMetaData metaData = rows.getMetaData();
		int columnCount = metaData.getColumnCount();

		while (rows.next()) {
			for (int i = 1; i <= columnCount; i += 1) {
				if(accNo.equals(rows.getString(i))) {
		
					return true;
				}
			}
			System.out.println();
		}
	
		return false;
	}
	
public boolean checkPassword(int userId, String password) throws ClassNotFoundException, SQLException{
		
		ConnectUtil connect = new ConnectUtil();
		Connection connection = connect.getConnection();
		
		String query = "Select password from users where user_id = ?";
		
		PreparedStatement prepStatement = connection.prepareStatement(query);
		prepStatement.setInt(1, userId);
		
		ResultSet rows = prepStatement.executeQuery();
		ResultSetMetaData metaData = rows.getMetaData();
		int columnCount = metaData.getColumnCount();

		while (rows.next()) {
			for (int i = 1; i <= columnCount; i += 1) {
				if(password.equals( rows.getString(i))) {
					
					return true;
				}
				
			}
			System.out.println();
		}
		
		return false;
	}
		
	public void depositAmount(String accNo, double amount) throws ClassNotFoundException, SQLException {
		
		ConnectUtil connect = new ConnectUtil();
		Connection connection = connect.getConnection();
		
		String query = "update bank_accounts set balance = ? where account_number = ? ";
		
		PreparedStatement prepareStatement = connection.prepareStatement(query);
		
		prepareStatement.setDouble(1, amount);
		prepareStatement.setString(2, accNo);
		
		int rows = prepareStatement.executeUpdate();

		System.out.println("Rows Updated : " + rows);
	}
	
	public int getAvailableBalance(String accNo) throws ClassNotFoundException, SQLException {
		ConnectUtil connect = new ConnectUtil();
		Connection connection = ConnectUtil.getConnection();

		String query = "Select balance from bank_accounts where account_number = ?";
		
		PreparedStatement prepareStatement = connection.prepareStatement(query);
		
		prepareStatement.setString(1, accNo);
		
		ResultSet rows = prepareStatement.executeQuery();
		
		ResultSetMetaData metaData = rows.getMetaData();
		int columnCount = metaData.getColumnCount();

		while (rows.next()) {
			for (int i = 1; i <= columnCount; i += 1) {
				return rows.getInt(i);
			}
		}
		return 0;	
	}
	
	public boolean checkEmail(int id) throws ClassNotFoundException, SQLException {
		ConnectUtil connect = new ConnectUtil();
		Connection connection = ConnectUtil.getConnection();

		String query = "Select email from users where user_id = ?";
		
		PreparedStatement prepareStatement = connection.prepareStatement(query);
		
		prepareStatement.setInt(1, id);
		
		ResultSet rows = prepareStatement.executeQuery();
		
		ResultSetMetaData metaData = rows.getMetaData();
		int columnCount = metaData.getColumnCount();

		while (rows.next()) {
			for (int i = 1; i <= columnCount; i += 1) {
				if(rows.getString(i).length() > 1)
					return true;
			}
		}
		return false;
	}
	
	public String getEmail(int id) throws ClassNotFoundException, SQLException {
		ConnectUtil connect = new ConnectUtil();
		Connection connection = ConnectUtil.getConnection();

		String query = "Select email from users where user_id = ?";
		
		PreparedStatement prepareStatement = connection.prepareStatement(query);
		
		prepareStatement.setInt(1, id);
		
		ResultSet rows = prepareStatement.executeQuery();
		
		ResultSetMetaData metaData = rows.getMetaData();
		int columnCount = metaData.getColumnCount();

		while (rows.next()) {
			for (int i = 1; i <= columnCount; i += 1) {
				if(rows.getString(i).length() > 1)
					return rows.getString(i);
			}
		}
		return "";
	}
	
	public int getBalance(int id) throws ClassNotFoundException, SQLException {
		ConnectUtil connect = new ConnectUtil();
		Connection connection = connect.getConnection();
		
		String query = "Select balance from bank_accounts where user_id = ?";
		
		PreparedStatement prepareStatement = connection.prepareStatement(query);
		
		prepareStatement.setInt(1, id);
		
		ResultSet rows = prepareStatement.executeQuery();
		
		ResultSetMetaData metaData = rows.getMetaData();
		int columnCount = metaData.getColumnCount();
		
		while (rows.next()) {
			for(int i=1; i<=columnCount; i+=1)
			{
				if(rows.getString(i).length() > 1)
				{
					return rows.getInt(i);
				}
			}
		}
		
		return 0;
		
	}
	
	public void createWalletId(WalletIdInfo walletInfo) throws ClassNotFoundException, SQLException {
		
		ConnectUtil connect = new ConnectUtil();
		Connection connection = connect.getConnection();
		
		String query = "insert into wallets (wallet_id, user_id, balance) value (?,?,?)";
		
		PreparedStatement prepareStatement = connection.prepareStatement(query);
		
		prepareStatement.setString(1, walletInfo.getWalletId());
		prepareStatement.setInt(2, walletInfo.getId());
		prepareStatement.setInt(3, 0);
		
		int rows = prepareStatement.executeUpdate();

		System.out.println("Rows Affected : " + rows);
		System.out.println("Inserted To DB!!!");
		
	}
	
	public boolean checkWalletId(int id) throws ClassNotFoundException, SQLException {
		
		ConnectUtil connect = new ConnectUtil();
		Connection connection = connect.getConnection();
		
		String query = "Select wallet_id from wallets where user_id = ?";
		
		PreparedStatement preparedStatement = connection.prepareStatement(query);
		
		preparedStatement.setInt(1, id);
		
		ResultSet rows = preparedStatement.executeQuery();
		ResultSetMetaData metaData = rows.getMetaData();
		int columnCount = metaData.getColumnCount();
		
		while(rows.next())
		{
			for(int i=1; i<=columnCount; i=+1)
			{
				return true;
			}
		}
		return false;
	}
	
		public boolean checkWalletId(String walletId) throws ClassNotFoundException, SQLException {
		
		ConnectUtil connect = new ConnectUtil();
		Connection connection = connect.getConnection();
		
		String query = "Select wallet_id from wallets where wallet_id = ?";
		
		PreparedStatement preparedStatement = connection.prepareStatement(query);
		
		preparedStatement.setString(1, walletId);
		
		ResultSet rows = preparedStatement.executeQuery();
		ResultSetMetaData metaData = rows.getMetaData();
		int columnCount = metaData.getColumnCount();
		
		while(rows.next())
		{
			for(int i=1; i<=columnCount; i=+1)
			{
				if(rows.getString(i).equals(walletId))
				{
					System.out.println("WalletID exist");
					return true;
				}
			}
		}
		return false;
	}
	
	public String getWalletId(int id) throws ClassNotFoundException, SQLException {
		
		ConnectUtil connect = new ConnectUtil();
		Connection connection = connect.getConnection();
		
		String query = "Select wallet_id from wallets where user_id = ?";
		
		PreparedStatement preparedStatement = connection.prepareStatement(query);
		
		preparedStatement.setInt(1, id);
		
		ResultSet rows = preparedStatement.executeQuery();
		ResultSetMetaData metaData = rows.getMetaData();
		int columnCount = metaData.getColumnCount();
		
		while(rows.next())
		{
			for(int i=1; i<=columnCount; i=+1)
			{
				return rows.getString(i);
			}
		}
		return null;
	}
	
	public ArrayList<UserInfo> readUserDetails(int id) throws ClassNotFoundException{
		
		 ArrayList<UserInfo> userDetailsList = new ArrayList<>();
		    
		    try {
		        Connection connection = ConnectUtil.getConnection();
		        String query = "select * from users where user_id = ?";
				PreparedStatement prepareStatement = connection.prepareStatement(query);
				
				prepareStatement.setInt(1,id);
				
		        ResultSet resultSet = prepareStatement.executeQuery();
		        
		        while (resultSet.next()) {
		            UserInfo userDetails = new UserInfo();
		            userDetails.setFirstName(resultSet.getString("first_name"));
		            userDetails.setLastName(resultSet.getString("last_name"));
		            userDetails.setEmail(resultSet.getString("email"));
		            userDetailsList.add(userDetails);
		 
		        }
		        
		        resultSet.close();
		        prepareStatement.close();
		        connection.close();
		    } catch (SQLException e) {
		        e.printStackTrace();
		    }
		    
		    return userDetailsList;
		
	}
	
	public ArrayList<BankAccountInfo> readAccountDetails(int id) throws ClassNotFoundException{
		
		 ArrayList<BankAccountInfo> accountDetailsList = new ArrayList<>();
		    
		    try {
		        Connection connection = ConnectUtil.getConnection();
		        String query = "select * from bank_accounts where user_id = ?";
				PreparedStatement prepareStatement = connection.prepareStatement(query);
				
				prepareStatement.setInt(1,id);
				
		        ResultSet resultSet = prepareStatement.executeQuery();
		        
		        while (resultSet.next()) {
		        	BankAccountInfo accountDetails = new BankAccountInfo();
		        	accountDetails.setDOB(resultSet.getString("dateofbirth"));
		        	accountDetails.setAadharNumber(resultSet.getLong("aadhaarnumber"));
		        	accountDetails.setAccNo(resultSet.getString("account_number"));
		        	accountDetails.setAddress(resultSet.getString("residential_address"));
		        	accountDetailsList.add(accountDetails);
		 
		        }
		        
		        resultSet.close();
		        prepareStatement.close();
		        connection.close();
		    } catch (SQLException e) {
		        e.printStackTrace();
		    }
		    
		    return accountDetailsList;
	}
	
	public ArrayList<WalletIdInfo> readWalletDetails(int id) throws ClassNotFoundException{
		
		 ArrayList<WalletIdInfo> walletDetailsList = new ArrayList<>();
		    
		    try {
		        Connection connection = ConnectUtil.getConnection();
		        String query = "select * from wallets where user_id = ?";
				PreparedStatement prepareStatement = connection.prepareStatement(query);
				
				prepareStatement.setInt(1,id);
				
		        ResultSet resultSet = prepareStatement.executeQuery();
		        
		        while (resultSet.next()) {
		        	WalletIdInfo walletDetails = new WalletIdInfo();
		        	walletDetails.setWalletId(resultSet.getString("wallet_id"));
		        	walletDetailsList.add(walletDetails);
		 
		        }
		        
		        resultSet.close();
		        prepareStatement.close();
		        connection.close();
		    } catch (SQLException e) {
		        e.printStackTrace();
		    }
		    
		    return walletDetailsList;
	}
	
	public double getWalletBalance(int id) throws ClassNotFoundException, SQLException {
		
		ConnectUtil connect = new ConnectUtil();
		Connection connection = connect.getConnection();
		
		String query = "select balance from wallets where user_id = ?";
		
		PreparedStatement prepareStatement = connection.prepareStatement(query);
		
		prepareStatement.setInt(1, id);
		
		ResultSet rows = prepareStatement.executeQuery();
		ResultSetMetaData metaData = rows.getMetaData();
		int columnCount = metaData.getColumnCount();
		
		while(rows.next())
		{
			for(int i=1; i<=columnCount; i+=1)
			{
				return rows.getDouble(i);
			}
		}
		return 0;
	}
	
	public void updateWalletBalance(double balance, String walletId) throws ClassNotFoundException, SQLException {
		ConnectUtil connect = new ConnectUtil();
		Connection connection = connect.getConnection();
		
		double amountToUpdate = balance + getWalletBalance(walletId);
		
		String query = "update wallets set balance = ? where wallet_id = ?";
		
		PreparedStatement prepareStatement = connection.prepareStatement(query);
		
		prepareStatement.setDouble(1, amountToUpdate);
		prepareStatement.setString(2, walletId);
		
		int rows = prepareStatement.executeUpdate();
		
		System.out.println("Rows Updated : " + rows);
	}
	
	public double getWalletBalance(String walletId) throws ClassNotFoundException, SQLException {
		ConnectUtil connect = new ConnectUtil();
		Connection connection = ConnectUtil.getConnection();

		String query = "Select balance from wallets where wallet_id = ?";
		
		PreparedStatement prepareStatement = connection.prepareStatement(query);
		
		prepareStatement.setString(1, walletId);
		
		ResultSet rows = prepareStatement.executeQuery();
		
		ResultSetMetaData metaData = rows.getMetaData();
		int columnCount = metaData.getColumnCount();

		while (rows.next()) {
			for (int i = 1; i <= columnCount; i += 1) {
				return rows.getDouble(i);
			}
		}
		return 0;	
	}
	
	public void deductBankBalance(int id, double amount) throws ClassNotFoundException, SQLException {
		ConnectUtil connect = new ConnectUtil();
		Connection connection = connect.getConnection();
		
		double updatedAmount = getBalance(id) - amount;
		
		String query = "update bank_accounts set balance = ? where user_id = ?";
		
		PreparedStatement prepareStatement = connection.prepareStatement(query);
		
		prepareStatement.setDouble(1, updatedAmount);
		prepareStatement.setInt(2, id);
		
		int rows = prepareStatement.executeUpdate();
		System.out.println("Balance Updated : " + rows);
		
	}
	
	public void deductWalletBalance(String walletId, double amount) throws ClassNotFoundException, SQLException {
		ConnectUtil connect = new ConnectUtil();
		Connection connection = connect.getConnection();
		
		double updatedAmount = getWalletBalance(walletId) - amount;
		
		String query = "update wallets set balance = ? where wallet_id = ?";
		
		PreparedStatement prepareStatement = connection.prepareStatement(query);
		
		prepareStatement.setDouble(1, updatedAmount);
		prepareStatement.setString(2, walletId);
		
		int rows = prepareStatement.executeUpdate();
		System.out.println("Balance Updated : " + rows);
		
		
	}
	
	public void updateTransactionHistory(String senderId, String receiverId, double amount) throws ClassNotFoundException, SQLException {
		
		ConnectUtil connect = new ConnectUtil();
		Connection connection = connect.getConnection();
		
		String query = "insert into transactions values (?,?,?,?,?)";
		
		PreparedStatement prepareStatement = connection.prepareStatement(query);
		
		prepareStatement.setLong(1, transactionIdGenerator());
		prepareStatement.setString(2, senderId);
		prepareStatement.setString(3, receiverId);
		prepareStatement.setString(4, LocalDateTime.now().toString());
		prepareStatement.setDouble(5, amount);
		
		int rows = prepareStatement.executeUpdate();
		System.out.println("Transaction update : " + rows);
		
	}
}