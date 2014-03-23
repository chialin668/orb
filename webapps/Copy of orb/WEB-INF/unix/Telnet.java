package com.orb.unix;

import java.io.*;
import java.net.*;

public class Telnet {

   BufferedInputStream bin;
   BufferedOutputStream bout;



   // negotiating commands
   private static final byte IAC = (byte)-1; // 255  FF
   private static final byte DONT = (byte)-2; //254  FE
   private static final byte DO = (byte)-3; //253    FD
   private static final byte WONT = (byte)-4; //252  FC
   private static final byte WILL = (byte)-5; //251  FB
   private static final byte SB = (byte)-6; //250 Sub Begin  FA
   private static final byte SE = (byte)-16; //240 Sub End   F0
   private static final byte EOR = (byte)-17; //239 End of Record  EF
   private static final byte TERMINAL_TYPE = (byte)24;     // 18
   private static final byte OPT_END_OF_RECORD = (byte)25;  // 19
   private static final byte TRANSMIT_BINARY = (byte)0;     // 0
   private static final byte QUAL_IS = (byte)0;             // 0
   private static final byte TIMING_MARK = (byte)6;         // 6

   // miscellaneous
   private static final byte ESC = 0x04; // 04
   private static final char char0 = 0;

   // commands
   private static final byte CMD_WRITE_TO_DISPLAY = 0x11; // 17
   private static final byte CMD_CLEAR_UNIT = 0x40; // 64
   private static final byte CMD_CLEAR_UNIT_ALTERNATE = 0x20; // 32
   private static final byte CMD_CLEAR_FORMAT_TABLE = 0x50; // 80
   private static final byte CMD_READ_MDT_IMMEDIATE = 0x52; // 82
   private static final byte CMD_READ_IMMEDIATE = 0x72; // 114
   private static final byte CMD_READ_SCREEN_IMMEDIATE = 0x62; // 98
   private static final byte CMD_WRITE_STRUCTURED_FIELD = (byte)243;  // (byte)0xF3 -13
   private static final byte CMD_SAVE_SCREEN = 0x02; // 02
   private static final byte CMD_RESTORE_SCREEN = 0x12; // 18
   private static final byte CMD_WRITE_ERROR_CODE = 0x21; // 33
   private static final byte CMD_WRITE_ERROR_CODE_TO_WINDOW = 0x22; // 34
   private static final byte CMD_READ_INPUT_FIELDS = 0x42; // 66
   private static final byte CMD_ROLL = 0x23; // 35
   private static final byte CMD_READ_MDT_FIELDS_ALT = (byte)0x82; // 130
   private static final byte CMD_READ_IMMEDIATE_ALT = (byte)0x83; // 131

   // AID-Generating Keys
   public static final int AID_CLEAR = 0xBD;
   public static final int AID_ENTER = 0xF1;
   public static final int AID_HELP = 0xF3;
   public static final int AID_ROLL_UP = 0xF4;
   public static final int AID_ROLL_DOWN = 0xF5;
   public static final int AID_ROLL_LEFT = 0xD9;
   public static final int AID_ROLL_RIGHT = 0xDA;
   public static final int AID_PRINT = 0xF6;
   public static final int AID_PF1 = 0x31;
   public static final int AID_PF2 = 0x32;
   public static final int AID_PF3 = 0x33;
   public static final int AID_PF4 = 0x34;
   public static final int AID_PF5 = 0x35;
   public static final int AID_PF6 = 0x36;
   public static final int AID_PF7 = 0x37;
   public static final int AID_PF8 = 0x38;
   public static final int AID_PF9 = 0x39;
   public static final int AID_PF10 = 0x3A;
   public static final int AID_PF11 = 0x3B;
   public static final int AID_PF12 = 0x3C;
   public static final int AID_PF13 = 0xB1;
   public static final int AID_PF14 = 0xB2;
   public static final int AID_PF15 = 0xB3;
   public static final int AID_PF16 = 0xB4;
   public static final int AID_PF17 = 0xB5;
   public static final int AID_PF18 = 0xB6;
   public static final int AID_PF19 = 0xB7;
   public static final int AID_PF20 = 0xB8;
   public static final int AID_PF21 = 0xB9;
   public static final int AID_PF22 = 0xBA;
   public static final int AID_PF23 = 0xBB;
   public static final int AID_PF24 = 0xBC;

   // negative response categories
   private static final int NR_REQUEST_REJECT = 0x08;
   private static final int NR_REQUEST_ERROR = 0x10;
   private static final int NR_STATE_ERROR = 0x20;
   private static final int NR_USAGE_ERROR = 0x40;
   private static final int NR_PATH_ERROR = 0x80;

    private final void writeByte(byte abyte0[])
        throws IOException {

		for (int i=0;i<abyte0.length;i++)
		    System.out.println(abyte0[i]);
        bout.write(abyte0);
        bout.flush();
    }

    private final void writeByte(byte byte0)
        throws IOException {


            System.out.println(byte0);
        bout.write(byte0);

        bout.flush();
    }


   private final boolean negotiate(byte abyte0[])
         throws IOException {
      int i = 0;

System.out.print("/");
      // from server negotiations
      if(abyte0[i] == IAC) { // -1

            while(i < abyte0.length && abyte0[i++] == -1)
                switch(abyte0[i++]) {

                // we will not worry about what it WONT do
                case WONT:            // -4
                default:

                    break;

                case DO: //-3

                    switch(abyte0[i])
                    {
                    case TERMINAL_TYPE: // 24

                        writeByte(IAC);
                        writeByte(WILL);
                        writeByte(TERMINAL_TYPE);
                        break;

                    case OPT_END_OF_RECORD: // 25

                        writeByte(IAC); // -1
                        writeByte(WILL);
                        writeByte(OPT_END_OF_RECORD);
                        break;

                    case TRANSMIT_BINARY: // 0

                        writeByte(IAC);
                        writeByte(WILL);
                        writeByte(TRANSMIT_BINARY);
                        break;

                    case TIMING_MARK: // 6   rfc860
                        System.out.println("Timing Mark Received and notifying " +
                        "the server that we will not do it");
                        writeByte(IAC);
                        writeByte(WONT);
//                        writeByte(WILL);
                        writeByte(TIMING_MARK);
                        break;

                    default:  // every thing else we will not do at this time

                        writeByte(IAC);
                        writeByte(WONT);
                        writeByte(abyte0[i]); // either
                        break;
                    }

                    i++;
                    break;

                case WILL:

                    switch(abyte0[i])
                    {
                    case OPT_END_OF_RECORD: // 25
                        writeByte(IAC);
                        writeByte(DO);
                        writeByte(OPT_END_OF_RECORD);
                        break;

                    case TRANSMIT_BINARY: // '\0'
                        writeByte(IAC);
                        writeByte(DO);
                        writeByte(TRANSMIT_BINARY);
                        break;
                    }
                    i++;
                    break;

                case SB: // -6

                    if(abyte0[i] == TERMINAL_TYPE && abyte0[i + 1] == 1)
                    {
                        writeByte(IAC); // -1
                        writeByte(SB); // -6
                        writeByte(TERMINAL_TYPE);  // 24
                        writeByte(QUAL_IS); // 0
//                        if(support132)
                            writeByte((new String("IBM-3179-2")).getBytes());
//                        else
//                            writeByte((new String("IBM-3477-FC")).getBytes());
                        writeByte(IAC);  // -1
                        writeByte(SE); // -16
                        i++;
                    }
                    i++;
                    break;
                }
            return true;
        } else
        {
            return false;
        }
    }


    private final byte[] readNegotiations()
        throws IOException {
        int i = bin.read();
        if(i < 0) {
            throw new IOException("Connection closed.");
        }
        else {
            int j = bin.available();
            byte abyte0[] = new byte[j + 1];
            abyte0[0] = (byte)i;
            bin.read(abyte0, 1, j);
            System.out.println(abyte0);
            return abyte0;
        }
    }

	public void run() {


                try {
		Socket   sock = new Socket("orb", 23);
         InputStream in = sock.getInputStream();
         System.out.println("got input stream");

         bin = new BufferedInputStream(sock.getInputStream(), 8192);
         bout = new BufferedOutputStream(sock.getOutputStream());

		byte abyte0[];
		while(negotiate(abyte0 = readNegotiations())) {

			System.out.print(".");
		}
//                out.close();
//                in.close();


                } catch (UnknownHostException e) {
                        System.err.println("Don't know about host: orb.");
                        System.exit(1);
                } catch (IOException e) {
                        System.err.println("Couldn't get I/O for "
                                + "the connection to: orb.");
                        System.exit(1);
                }


	}


        public static void main(String[] args) throws IOException {
			Telnet t = new Telnet();
			t.run();
        }
}
