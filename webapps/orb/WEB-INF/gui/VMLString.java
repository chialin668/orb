import java.util.*;

public class VMLString {

	private String sid;
	private String tag;
	private String stat;
	private String col;


	//
	// For the VML Graph
	//
	public static int graphWidth = Environment.GRAPH_WIDTH;
	public static int graphHeight = Environment.GRAPH_HEIGHT;

	private double graphXMin = Environment.GRAPH_X_MIN;
	private double graphXMax = Environment.GRAPH_X_MAX;
	private double graphYMin = Environment.GRAPH_Y_MIN;
	private double graphYMax = Environment.GRAPH_Y_MAX;

	private double x = graphXMin;
	//
	// X Cord size is 4200-400 = 3800 (units)
	// Monitor it for 10 hours
	// (4200-400)/(10 hr * 60 min)
	//
	private double X_INCREMENT = 6.333;

	private double y = 0.0;
	private double yMax = Environment.DOUBLE_MIN;
	private double yMin = Environment.DOUBLE_MAX;
	private double dataHeight = 0;
	private String yUnitArr[] = new String[6];
	private String outStr = "";
	private String dataStr = null;


  /**
	*
	*
	*
	**/
	public VMLString(String sid, String tag, String stat, String col) {
		this.sid = sid;
		this.tag = tag;
		this.stat = stat;
		this.col = col;
	}


	public String generate() {

		DBMem t = new DBMem();

		Vector valueVect = (Vector) t.getVect(sid, tag, stat, col);

		if (valueVect == null)
			return null;

		///////////////////////////////
		// calculate the difference
		///////////////////////////////
		double prevData = 0.0;
		Vector diffVect = new Vector();

		for (int i=0;i<valueVect.size();i++) {

			if (i==0) {
				prevData = Double.parseDouble((String) valueVect.elementAt(i));
				continue;
			} else {
				y = Double.parseDouble((String) valueVect.elementAt(i)) - prevData;
				prevData = Double.parseDouble((String) valueVect.elementAt(i));
			}
			diffVect.add(new Double(y).toString());
		}

		///////////////////////////////
		// Find min and max
		///////////////////////////////
		for (int i=0;i<diffVect.size();i++) {
			double chkData = Double.parseDouble((String) diffVect.elementAt(i));
			if (chkData >= yMax) yMax = chkData;

			chkData = Double.parseDouble((String) diffVect.elementAt(i));
			if (chkData <= yMin) yMin = chkData;
		}

		dataHeight = yMax - yMin;
/*
		out.println("<b>Max:</b> " + yMax
				+ ", <b>Min:</b> " + yMin
				+ ", <b>Height:</b> " + dataHeight + "<br>");
*/
		///////////////////////////////
		// Generate the output string
		///////////////////////////////
		for (int i=0;i<diffVect.size();i++) {
			x = x + X_INCREMENT;
			y = Double.parseDouble((String) diffVect.elementAt(i));
			y = y - yMin;
			y = (int) (y*(graphYMax-graphYMin)/dataHeight);
			y = graphYMax - y;

			//out.println("x: " + x + "y: " + y + "<br>");
			outStr = outStr + " " + x + " " + y;

			//@@@@
			dataStr = outStr;
		}

		if (outStr.length()>1)
			outStr = outStr.substring(1);
		else
			return null;

		return 	outStr;
	}


	public double getDataHeight() {
		return dataHeight;
	}


   /**
	*
	*
	*
	**/
	public String getYUnit() {
		String retStr = "";

		int unitCount = 6;
		for (int i=0;i<unitCount;i++) {
			double result = yMin + i*dataHeight/(unitCount-1);

			// K
			if (Math.round(result)/1000000 > 0) {
				result = result/1000000;
				result = Math.round(result*10.0)/10.0;
				yUnitArr[i] = result + "M";

			} else if (Math.round(result)/1000 > 0) {
				result = result/1000;
				result = Math.round(result*10.0)/10.0;
				yUnitArr[i] = result + "K";
			} else {
				result = Math.round(result*10.0)/10.0;
				yUnitArr[i] = new Double(result).toString();
			}
		}

		int top = 90;
		int diff = 15;
		for (int i=0;i<6;i++) {
			retStr = retStr + "<p class=Chart style='position:absolute; left:5pt; top:"
					+ (top - i*diff) + "pt; width:16pt; height:6pt; '>"
					+ yUnitArr[i] + "</p>";
		}

		return retStr;
	}

}