package com.orb.unix;

public class Consumer extends Thread {
    private CubbyHole cubbyhole;
    private String number;

    public Consumer(CubbyHole c, String number) {
        cubbyhole = c;
        this.number = number;
    }

    public void run() {
        String value = "0";
        for (int i = 0; i < 10; i++) {
            value = cubbyhole.get();
            System.out.println("Consumer #" + this.number
                               + " got: " + value);
        }
    }
}

