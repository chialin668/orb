package com.orb.sys;


public class OS {




	public static void main(String sags[]) {

        String osName = System.getProperty("os.name");
        String homeDir = System.getProperty("user.home");
        String tomCatHome = System.getProperty("TOMCAT_HOME");
        String abc = System.getProperty("ABC");

		System.out.println(osName);
		System.out.println(tomCatHome);
		System.out.println(homeDir);
		System.out.println(abc);


String myvar = System.getProperty("myvar");
System.out.println(myvar);


	}




}