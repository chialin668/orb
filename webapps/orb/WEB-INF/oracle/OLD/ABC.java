
import java.io.Serializable;

public class ABC implements Serializable {
	public int id;
	public String name;
	public String ssn;
	public String phone;
	public String address;



	public static void main(String args[]) {
		ABC o = new ABC();
		o.name = "test";
		System.out.println(o.name);

	}


}