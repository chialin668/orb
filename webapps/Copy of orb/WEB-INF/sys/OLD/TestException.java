public class TestException {

	public void test(boolean flag) throws SysException {
		if (flag)
			throw new SysException("exception from test");
		else
			return;
	}

	public static void main(String args[]) {
		TestException te = new TestException();
		try {
			te.test(false);
			te.test(true);
		} catch (SysException e) {
			e.printStackTrace();
		}

	}


}