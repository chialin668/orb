//
//
// Serializable Test
//
//
//

import java.io.*;
import java.util.*;

public class foo {

      Bar bar = new Bar();


      public void save(String filename) {

         try {
            ObjectOutputStream out =
               new ObjectOutputStream(new FileOutputStream(filename));
            out.writeObject(bar);
            out.flush();
            out.close();
         } catch (IOException e) { e.printStackTrace(); }
      }

      public void restore(String filename) {

         try {
            ObjectInputStream in =
               new ObjectInputStream(new FileInputStream(filename));
            bar = (Bar) in.readObject();
            in.close();
         } catch (IOException e) { e.printStackTrace(); }
         catch (ClassNotFoundException e) { e.printStackTrace(); }

			System.out.println(bar.persistData);
			System.out.println(bar.tempData);
			System.out.println(bar.name);
			Vector vect = bar.vect;
			for (int i=0;i<20;i++)
				System.out.println(vect.elementAt(i));
      }

	public static void main(String args[]) {
		foo f = new foo();
		f.save("abc");
		f.restore("abc");
	}
   }


 class Bar implements Serializable {

    public int persistData = 123;
    public transient int tempData = 456;
	public String name = "My name here!!";
	public Vector vect = new Vector();


      Bar() {
		  for (int i=0;i<20;i++)
		  	vect.add(new Integer(i));
      }

   }

