package com.orb.util;

import java.io.*;
import com.orb.sys.Server;
import com.orb.sys.SysLog;


public class WriteObj {
	private String CLASSNAME = this.getClass().getName();
	private String fileName = null;


   /**
	*
	* constructor
	*
	**/
	public WriteObj(String fileName) {
		this.fileName = fileName;
	}

   /**
	*
	* write the object to object file
	*
	**/
	public boolean write(Object object) {
		String METHODNAME = "read";

		try {
			ObjectOutput out = new ObjectOutputStream(new FileOutputStream(fileName));
			out.writeObject(object);
			out.close();

		} catch (IOException e) {
			String message = "IO error while writing object to file: " + fileName;

			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
                				SysLog.ML_SEVERE,
                				e,
                                message);
            return false;
		}

		return true;
	}


}