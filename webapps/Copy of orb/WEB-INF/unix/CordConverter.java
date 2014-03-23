package com.orb.unix;


public class CordConverter {

	private int INCRE = 20;
	private int x = 300 - 20;

	int MAX = 100;

	public int getX() {
		x = x + INCRE;
		return x;
	}

	public int getY(int yIn) {
		int y = MAX - yIn;
		y = y*(1000-200)/MAX + 200;
		return y;
	}

	public static void main(String args[]) {
		CordConverter cc = new CordConverter();

		for (int i=0;i<10;i++)
			System.out.println(cc.getX());


	}

}