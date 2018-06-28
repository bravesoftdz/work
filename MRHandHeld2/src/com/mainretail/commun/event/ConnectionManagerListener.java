package com.mainretail.commun.event;

import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

public interface ConnectionManagerListener {
	public void dataOutput(ObjectOutputStream oos);// throws IOException;
	public void dataInput(ObjectInputStream ois);// throws IOException, ClassNotFoundException;
	public void httpError(int errorCode, String errorMsg);
	public void connectionException(Exception e);
}
