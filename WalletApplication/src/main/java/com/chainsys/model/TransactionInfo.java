package com.chainsys.model;

public class TransactionInfo {
	
	String transactionId;
	String senderWalletID;
	String receiverWalletID;
	String dateAndTime;
	double amountTransfered;
	
	public String getTransactionId() {
		return transactionId;
	}
	public void setTransactionId(String transactionId) {
		this.transactionId = transactionId;
	}
	public String getSenderWalletID() {
		return senderWalletID;
	}
	public void setSenderWalletID(String senderWalletID) {
		this.senderWalletID = senderWalletID;
	}
	public String getReceiverWalletID() {
		return receiverWalletID;
	}
	public void setReceiverWalletID(String receiverWalletID) {
		this.receiverWalletID = receiverWalletID;
	}
	public String getDateAndTime() {
		return dateAndTime;
	}
	public void setDateAndTime(String dateAndTime) {
		this.dateAndTime = dateAndTime;
	}
	public double getAmountTransfered() {
		return amountTransfered;
	}
	public void setAmountTransfered(double amountTransfered) {
		this.amountTransfered = amountTransfered;
	}
	
}
