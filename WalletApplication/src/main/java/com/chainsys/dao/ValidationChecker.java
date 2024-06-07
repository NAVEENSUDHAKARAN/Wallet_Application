package com.chainsys.dao;

import java.util.InputMismatchException;
import java.util.Scanner;


public class ValidationChecker {

	Scanner scan = new Scanner(System.in);

	public boolean Numerics(int Number) {
		if (Number < 0) {
			return false;
		}
		return true;
	}

	public boolean str(String name) {
		String pattern = "^[A-Za-z ]+$";

		if (name.matches(pattern)) {
			return true;
		} else {
			return false;
		}

	}

	public boolean doubles(double dbl) {
		if (dbl < 0.0) {
			return false;
		}
		return true;
	}

	public boolean phoneNumber(String number) {
		String phoneNumberPattern = "[6-9]{1}[0-9]+$";
		if (number.matches(phoneNumberPattern) && number.length() == 10) {
			return true;
		}
		return false;
	}

	public int IoMismatch4() {
		while (true) {
			try {

				int type = scan.nextInt();
				if (type != 1 && type != 2 && type != 3 && type != 0) {
					System.err.println("Enter The Valid Number : ");
				} else {
					return type;
				}
			} catch (InputMismatchException e) {
				System.out.println(e);
				scan.nextLine();
			}

		}

	}

	public int IoMismatch3() {
		while (true) {
			try {

				int type = scan.nextInt();
				if (type != 1 && type != 2 && type != 3) {
					System.err.println("Enter The Valid Number : ");
				} else {
					return type;
				}
			} catch (InputMismatchException e) {
				System.err.println("Input Cannot be a Character(Input MisMatch)");
				scan.nextLine();
			}

		}

	}

	public int IoMismatch2() {
		while (true) {
			try {

				int type = scan.nextInt();
				if (type != 1 && type != 2 && type != 3) {
					System.err.println("Enter The Valid Number : ");
				} else {
					return type;
				}
			} catch (InputMismatchException e) {
				System.out.println("Input Cannot be a Character(Input MisMatch)");
				scan.nextLine();
			}

		}

	}

	public int IoMismatchDepartment() {
		while (true) {
			try {

				int type = scan.nextInt();
				if (type != 1 && type != 2 && type != 3 && type != 0) {
					System.err.println("Enter The Valid Number : ");
				} else {
					return type;
				}
			} catch (InputMismatchException e) {
				System.out.println("Input Cannot be a Character(Input MisMatch)");
				scan.nextLine();
			}

		}

	}

	public int IoMismatchProductManagementOptions() {
		while (true) {
			try {

				int type = scan.nextInt();
				if (type != 1 && type != 2 && type != 3 && type != 4 && type != 5 && type != 6 && type != 7 &&  type != 8) {
					System.err.println("Enter The Valid Number : ");
				} else {
					return type;
				}
			} catch (InputMismatchException e) {
				System.out.println("Input Cannot be a Character(Input MisMatch)");
				scan.nextLine();
			}

		}

	}

	public int numberValidation() {
		while (true) {
			try {

				int type = scan.nextInt();
				if (type > 0) {
					return type;
				} else {
					System.err.println("Enter The Valid Number : ");
				}
			} catch (InputMismatchException e) {
				System.out.println("Input Cannot be a Character(Input MisMatch)");
				scan.nextLine();
			}

		}

	}

	public static boolean dateValidation(String date) {

		String datePattern = "[0-9]{2}/[0-9]{2}/[0-9]{4}";

		if (date.matches(datePattern)) {
			return true;
		}
		return false;
	}
}
