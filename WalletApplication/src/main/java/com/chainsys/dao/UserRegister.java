package com.chainsys.dao;


import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

import java.util.Scanner;

public class UserRegister {
	
	public static void write() {
		Scanner scanner = new  Scanner(System.in);
		try {

			System.out.println("<-----Register----->");

			System.out.println("Enter the UserName: ");
			String userName = scanner.next();
			System.out.println("Enter the Password : ");
			String password = scanner.next();
			
			

			FileWriter writer = new FileWriter("D:\\UserDetails.txt", true);
			String str = userName + " " + password + "\n";
			writer.write(str);
			
			writer.close();
			System.out.println("Registered Successfully");

		} catch (IOException e) {
			e.printStackTrace();
		}
		scanner.close();
	}
	
	public static void read() {
		try {
			FileReader reader = new FileReader("D:\\UserDetails.txt");
			StringBuilder strBuilder = new StringBuilder();
			int num;
			char ch;
			while((num = reader.read()) != -1)
			{
				ch = (char) num;
				strBuilder.append(ch);
			}
			String[] str = strBuilder.toString().split(" ");
			for(int i=0; i<str.length; i+=1)
			{
				System.out.println(str[i]);
			}
				reader.close();		
	}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
}
