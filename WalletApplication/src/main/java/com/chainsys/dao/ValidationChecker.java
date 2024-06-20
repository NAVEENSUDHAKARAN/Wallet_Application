package com.chainsys.dao;

import java.util.InputMismatchException;
import java.util.Scanner;


public class ValidationChecker {

	Scanner scan = new Scanner(System.in);

	public boolean numerics(int number) {
		
			return number >= 0;
	}

	public boolean str(String name) {
		String pattern = "^[A-Za-z ]+$";

		 return name.matches(pattern);

	}

	public boolean doubles(double dbl) {

		return dbl>=0.0;
	}

	public boolean phoneNumber(String number) {
		String phoneNumberPattern = "[6-9]//d+$";

		return number.matches(phoneNumberPattern) && number.length() == 10;
	}

	public int numberValidation() {
		while (true) {
			try {

				int type = scan.nextInt();
				if (type > 0) {
					return type;
				} 
			} catch (InputMismatchException e) {
				scan.nextLine();
			}

		}

	}

	public static boolean dateValidation(String date) {

		String datePattern = "\\d{2}/\\d{2}/\\d{4}";

		return date.matches(datePattern);
	}
}
