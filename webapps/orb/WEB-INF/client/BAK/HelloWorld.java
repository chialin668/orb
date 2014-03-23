class HelloWorld {
    public native void displayHelloWorld(String str);

    static {
        System.loadLibrary("hello");
    }
    
    public static void main(String[] args) {
	String str = "test";
        new HelloWorld().displayHelloWorld(str);
    }
}


