import java.util.*;


// for top
public class Parser {
	private String CLASSNAME = this.getClass().getName();


	private static Hashtable top5Tab = new Hashtable();

	private String loadAvgUsr;
	private String loadAvgSys;
	private String loadAvgWio;

	private String psCount;
	private Hashtable psStatusTab = new Hashtable();
	private String cpuIdle;
	private String cpuUsr;
	private String cpuKernel;
	private String cpuWio;
	private String cpuSwap;

	private String memReal;
	private String memFree;
	private String memSwapFree;
	private String memSwap;

	private Vector psVect = new Vector();

	public String getData(String inStr, String tag) {
		String METHODNAME = "getData";
		String beginTag = "<" + tag + ">";
		String endTag = "</" + tag + ">";
		String retStr = null;

		try {
			retStr = inStr.substring(inStr.indexOf(beginTag)+beginTag.length(),
								inStr.indexOf(endTag));
		} catch (Exception e) {
			String message = "Exception caught!! input string: " + inStr
								+ " tag: " + tag;

			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
                				SysLog.ML_SEVERE,
                				e,
                                message);
			return null;
		}
		return retStr;
	}

	public void process(String inStr) {
//		System.out.println(inStr);

		// load average
		String loadAvgStr = getData(inStr, "loadaverage");
		loadAvgUsr = getData(loadAvgStr, "usr");
		loadAvgSys = getData(loadAvgStr, "sys");
		loadAvgWio = getData(loadAvgStr, "wt");

		//@@@???
		String processStr = getData(inStr, "processes");

		// cpu
		String cpuStr = getData(inStr, "cpu");
		cpuIdle = getData(cpuStr, "idle");
		cpuUsr = getData(cpuStr, "user");
		cpuKernel = getData(cpuStr, "kernel");
		cpuWio = getData(cpuStr, "iowait");
		cpuSwap = getData(cpuStr, "swap");

		// mrmory
		String memStr = getData(inStr, "memory");
		memReal = getData(memStr, "real");
		memFree = getData(memStr, "free");
		memSwapFree = getData(memStr, "swapfree");
		memSwap = getData(memStr, "swapinuse");

		// ps
		String psStr = getData(inStr, "psstat");
		StringTokenizer st = new StringTokenizer(psStr, "|");
		while (st.hasMoreTokens()) {
			String nextPsStr = st.nextToken();
			psVect.add(nextPsStr);
			System.out.println(nextPsStr);
		}

		System.out.println(memReal);
		System.out.println(memFree);
		System.out.println(memSwapFree);
		System.out.println(memSwap);


	}


	public String getLoadAvgUsr() { return loadAvgUsr; }
	public String getLoadAvgSys() { return loadAvgSys; }
	public String getLoadAvgWio() { return loadAvgWio; }

	public String getPsCount() { return psCount; }
	public Hashtable getPsStatusTab() { return psStatusTab; }
	public String getCpuIdle() { return cpuIdle; }
	public String getCpuUsr() { return cpuUsr; }
	public String getCpuKernel() { return cpuKernel; }
	public String getCpuWio() { return cpuWio; }
	public String getCpuSwap() { return cpuSwap; }

	public String getMemReal() { return memReal; }
	public String getMemFree() { return memFree; }
	public String getMemSwapFree() { return memSwapFree; }
	public String getMemSwap() { return memSwap; }

	public Vector getPsVect() { return psVect; }





}