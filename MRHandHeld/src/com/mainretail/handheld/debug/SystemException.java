
package com.mainretail.handheld.debug;


public class SystemException extends Exception {

	public SystemException()
	{
		super("Error in the system");
	}
	
	public SystemException(String msg)
	{
		super(msg);
	}

}
