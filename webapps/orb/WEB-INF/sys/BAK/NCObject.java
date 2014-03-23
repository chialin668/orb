import java.util.*;
import java.io.Serializable;

public class NCObject implements Serializable {

	protected String name;
	protected String networkAddress;

	protected String vendor;
	protected String model;
	protected String type;
	protected String version;


	// @@@ remove this!!!
	protected NCObject() {}

	protected NCObject(String name, String networkAddress) {
		this.name = name;
		this.networkAddress = networkAddress;
	}

	protected String getName() {return name; }
	protected String getNetworkAddress() {return networkAddress; }
}