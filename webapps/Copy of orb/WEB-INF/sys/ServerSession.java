package com.orb.sys;

import java.util.Hashtable;

public class ServerSession {

	private ServerInfo sInfo = new ServerInfo();;
	private static Hashtable sidTab = new Hashtable();
	private static Hashtable loginTab = new Hashtable();

	public void setLogin(String id) {
		loginTab.put(id, id);
	}

	public String getLogin(String id) {
		return (String) loginTab.get(id);
	}

	public void setSid(String id, String sid) {
		sidTab.put(id, sid);
	}

	public String getSid(String id) {
		return (String) sidTab.get(id);
	}

	public String getMachine(String id) {
		String sid = (String) sidTab.get(id);
		Server server = sInfo.getServerBySid(sid);
		return server.getMachine();
	}

	public String getPort(String id) {
		String sid = (String) sidTab.get(id);
		Server server = sInfo.getServerBySid(sid);
		return server.getPort();
	}


	public String getUsername(String id) {
		String sid = (String) sidTab.get(id);
		Server server = sInfo.getServerBySid(sid);
		return server.getUsername();
	}

	public String getPassword(String id) {
		String sid = (String) sidTab.get(id);
		Server server = sInfo.getServerBySid(sid);
		return server.getPassword();
	}


	public static void main(String args[]) {

		ServerInfo si = new ServerInfo();
		si.init();

		ServerSession s = new ServerSession();
		String id = "9182738712334";

		s.setSid(id, "CHIALIN");

		System.out.println(s.getSid(id));
		System.out.println(s.getMachine(id));
		System.out.println(s.getPort(id));
		System.out.println(s.getUsername(id));
		System.out.println(s.getPassword(id));
	}

}