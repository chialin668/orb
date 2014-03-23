package com.orb.util;

import java.io.*;
import com.orb.sys.Server;
import com.orb.sys.SysLog;

public class ReadObj {

	private String CLASSNAME = this.getClass().getName();
	private String fileName = null;
	private Object object;

   /**
	*
	* constructor
	*
	**/
	public ReadObj(String fileName) {
		this.fileName = fileName;
	}


   /**
	*
	* read the object from the obj file
	*
	**/
	public Object read() {
		String METHODNAME = "read";

		try {
			File file = new File(fileName);
			ObjectInputStream in = new ObjectInputStream(new FileInputStream(file));
			object = (Object) in.readObject();
			in.close();

		} catch (ClassNotFoundException e) {
			// couldn't file the file ... should create a new one by the caller
			String message = "File NOT found!!  File: " + fileName;

			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
                				SysLog.ML_SEVERE,
                				e,
                                message);

			return null;

		} catch (IOException e) {
			String message = "IO error while reading object from file: " + fileName;

			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
                				SysLog.ML_SEVERE,
                				e,
                                message);
			return null;
		}
		return object;
    }


   /**
	*
	* does the file exist?
	*
	**/
	public boolean exist() {
		String METHODNAME = "exist";

		try {
			File file = new File(fileName);
			new FileInputStream(file);

		} catch (java.io.FileNotFoundException e) {
			// couldn't file the file ... should create a new one by the caller
			return false;
		}

		return true;
    }


}