class Server {
    public native String displayServer(String str);

    static {
        System.loadLibrary("server");
    }
    
    public static void main(String[] args) {
        for (;;) {
		String str = "from server!!";
	 	System.out.println("--------------------");
       	 	System.out.println(new Server().displayServer(str));
 		System.out.println("--------------------");
    	}
    }
}


