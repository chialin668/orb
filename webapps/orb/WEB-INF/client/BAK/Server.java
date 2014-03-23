class Server {
    public native String displayServer(String str);

    static {
        System.loadLibrary("server");
    }
    
    public static void main(String[] args) {
	String str = "from server!!";
        System.out.println(new Server().displayServer(str));
    }
}


