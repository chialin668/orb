package com.orb.sys;

import java.util.Hashtable;
import java.util.Enumeration;
import java.util.Arrays;
import com.orb.util.ReadObj;
import com.orb.util.WriteObj;

/**
*
* server information
*
**/
public class ServerInfo {

	private String CLASSNAME = this.getClass().getName();
	private static Hashtable serverTab = new Hashtable();
	private String fileName = Environment.SERVER_FILE;


   /**
	*
	* read server information when tomcat starts up
	*
	**/
	public boolean init() {
		System.out.println("Reading server information..." + fileName);
		this.read();
		return true;
	}


   /**
	*
	* convert the hash table to an array (so we can write it to a file)
	*
	**/
	public Server[] toArray() {

		Server[] serverArray = new Server[serverTab.size()];

		int i=0;
		Enumeration keys = serverTab.keys();
		while(keys.hasMoreElements()) {
			String key = (String) keys.nextElement();
			serverArray[i] = (Server) serverTab.get(key);
			i++;
		}
		return serverArray;
	}


   /**
	*
	* write the server information back to the server informaiton file
	*
	**/
	public boolean write() {
		WriteObj w = new WriteObj(fileName);
		Server[] serverArray = this.toArray();
		w.write(serverArray);

		return true;
	}


   /**
	*
	* return an sorted SID list
	*
	**/
	public String [] getOrderedSidList() {
		String METHODNAME = "getOrderedSidList";

		String[] sidArr = new String[serverTab.size()];

		int i=0;
		Enumeration keys = serverTab.keys();
		while(keys.hasMoreElements()) {
			String key = (String) keys.nextElement();
			Server s  = (Server) serverTab.get(key);
			sidArr[i] = s.getSid();
			i++;
		}

		// first one
		Arrays.sort(sidArr);
		return sidArr;
	}


   /**
	*
	* read the server information from the server information file
	*
	**/
	public boolean read() {
		String METHODNAME = "read";

		ReadObj r = new ReadObj(fileName);

		Server[] serverArray = null;
		if (!r.exist()) {
			String message = "[Warning] Server information file doesn't exist.  File name: "
								+ fileName;

			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
                				SysLog.ML_WARNING,
                				null,
                                message);
			return false;
		}

		serverArray = (Server []) r.read();
		for (int i=0;i<serverArray.length;i++) {
			String sid = serverArray[i].getSid();
			Server server = serverArray[i];
			serverTab.put(sid, server);

		}

		return true;
	}


   /**
	*
	* retrieve server obj by sid
	*
	**/
	public Server getServerBySid(String sid) {
		return (Server) serverTab.get(sid);
	}


   /**
	*
	* add server to the hashtable
	*
	**/
	public void add(String sid, Server s) {
		serverTab.put(sid, s);
		this.write();
	}

   /**
	*
	* add modified server to the hash table
	*
	**/
	public void modify(String sid, Server s) {
		serverTab.put(sid, s);
		this.write();
	}


   /**
	*
	* remove the server from the hash table
	*
	**/
	public void remove(String sid) {
		serverTab.remove(sid);
		this.write();
	}


   /**
	*
	* retrieve the hash table
	*
	**/
	public Hashtable getServerTable() {
		return serverTab;
	}

}