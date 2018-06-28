
package com.mainretail.util;

public interface HttpEventListener {
	public static final int STATUS_PROCESSING = 0;
    public static final int STATUS_CONCLUDED = 1;
    public static final int STATUS_CANCELLED = 2;
    public static final int STATUS_ERROR = 3;
	
	public void httpEvent(int status, HttpConnectionHC connectionHC,Throwable error);
}
