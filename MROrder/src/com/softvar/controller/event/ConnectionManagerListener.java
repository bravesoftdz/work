package com.softvar.controller.event;

import java.io.InputStream;
import java.io.ObjectOutputStream;

public interface ConnectionManagerListener {
	public void dataOutput(ObjectOutputStream oos);// throws IOException;
	public void dataInput(InputStream is);// throws IOException, ClassNotFoundException;
	public void httpError(int errorCode, String errorMsg);
	public void connectionException(Exception e);
	public void proccesData();
}
