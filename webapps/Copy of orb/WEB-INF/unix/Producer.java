package com.orb.unix;

public class Producer extends Thread {
    private CubbyHole cubbyhole;
    private String number;

    public Producer(CubbyHole c, String number) {
        cubbyhole = c;
        this.number = number;
    }

    public void run() {
        for (int i = 0; i < 10; i++) {
            cubbyhole.put(new Integer(i).toString());
            System.out.println("Producer #" + this.number
                               + " put: " + i);
/*
            try {
                sleep((int)(Math.random() * 100));
            } catch (InterruptedException e) { }
*/
        }
    }
}
