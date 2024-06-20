package com.chainsys.model;

public class BankAccountInfo {

	String fName;
	String lName;
	String phoneNumber;
	String dob;
	String address;
	String accNo;
	long aadharNumber;
	int userId;
	double amount;
	
	
	
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public String getAccNo() {
		return accNo;
	}
	public void setAccNo(String accNo) {
		this.accNo = accNo;
	}
		
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getFname() {
		return fName;
	}
	public void setFname(String fname) {
		this.fName = fname;
	}
	public String getLname() {
		return lName;
	}
	public void setLname(String lname) {
		this.lName = lname;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getDOB() {
		return dob;
	}
	public void setDOB(String dOB) {
		dob = dOB;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public long getAadharNumber() {
		return aadharNumber;
	}
	public void setAadharNumber(long aadharNumber) {
		this.aadharNumber = aadharNumber;
	}
	
	
}
