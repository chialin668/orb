package com.orb.sys;

import java.util.Date;

public class SysLog {

    // prepare the header for the error log
    private static final String classHdr            = "CLASS  : ";
    private static final String methodHdr           = "METHOD : ";
    private static final String levelHdr            = "LEVEL  : ";
    private static final String timeHdr             = "TIME   : ";
    private static final String msgHdr              = "MSG    : ";

    public static final String ML_INFO              = "INFO";
    public static final String ML_WARNING           = "WARNING";
    public static final String ML_SEVERE            = "SEVERE";


	public synchronized void write(String className,
						String methodName,
						String level,
						Exception exception,
						String errMsg) {

        // construct the error message
        Date current = new Date();
        String time = current.toString();

        String classStr = classHdr + className + "\n";
        String methodStr = methodHdr + methodName + "\n";
        String levelStr = levelHdr + level + "\n";
        String timeStr = timeHdr + time + "\n";
        String errorStr = msgHdr + errMsg + "\n";

        String message;

        if (exception != null)
            message = classStr + methodStr
                            + levelStr + timeStr + errorStr
                            + "Exception: " + exception + "\n\n";
        else
            message = classStr + methodStr
                + levelStr + timeStr + errorStr + "\n\n";

		System.out.println(message);
	}

	public static void main(String args[]) {
		SysLog log = new SysLog();
		log.write("Test", "main", SysLog.ML_SEVERE, null, "just a test");

	}
}

