package com.chainsys.dao;

import java.net.InetAddress;
import java.net.UnknownHostException;

public class getIP {

	public static void main(String[] args) throws UnknownHostException {
		 InetAddress localhost = InetAddress.getLocalHost();
         System.out.println("Your IP Address: " + localhost.getHostAddress());
	}
}
