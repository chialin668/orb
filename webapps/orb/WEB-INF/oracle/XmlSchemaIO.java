package com.orb.oracle;

import java.io.*;
import com.orb.sys.*;


public class XmlSchemaIO {
	private String CLASSNAME = this.getClass().getName();
	
	private String projectDir = Environment.TOMCAT_ROOT + File.separator + "webapps"
								+ File.separator + Environment.WEB_SERVER_NAME
								+ File.separator + "project"
								+ File.separator;


	/**
	*
	*
	*
	**/
	public boolean write(String projectName, String xmlStr) {
		String METHODNAME = "write";
		String fileName = projectDir + projectName + ".xml";
		
		try {
			File data = new File(fileName);
				PrintWriter out = new PrintWriter(
											new BufferedWriter(
											new FileWriter(data)));
			out.println(xmlStr);
			out.close();
			return true;
			
		} catch (IOException e) {
			String message = "Error saving xml to file: " + fileName;
			
						SysLog log = new SysLog();
						log.write(CLASSNAME, METHODNAME,
			                				SysLog.ML_SEVERE,
			                				e,
			                                message);
			return false;
		}
	}


   	/**
	*
	*
	*
	**/
	public String read(String projectName) {
	
		String METHODNAME = "write";
		String fileName = projectDir + projectName + ".xml";
		
		try {
			File data = new File(fileName);
			
			if (data.exists()){
			
				BufferedReader in = new BufferedReader(new FileReader(data));
				
				String retStr = "";
				
				String line = in.readLine();
				while(line != null) {

					retStr = retStr + line + "\n";
					line = in.readLine();
				}
				
				
				in.close();
				return retStr;
				
			} else {
			
				String message = "File doesn't exist!!  File name: " + fileName;

							SysLog log = new SysLog();
							log.write(CLASSNAME, METHODNAME,
												SysLog.ML_SEVERE,
												null,
												message);
				return null;
			}

		} catch (IOException e) {
			String message = "Error saving xml to file: " + fileName;
			
						SysLog log = new SysLog();
						log.write(CLASSNAME, METHODNAME,
			                				SysLog.ML_SEVERE,
			                				e,
			                                message);
			return null;
		}

   }


}