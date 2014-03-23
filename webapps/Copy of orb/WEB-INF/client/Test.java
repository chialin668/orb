public final class Test extends Thread {

	private String sName;
	
	public Test(String sName) {
		this.sName = sName;
	}

	public void run() {
		System.out.println("from " + sName);
	}
}
