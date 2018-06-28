package com.softvar.synch;

import java.io.Serializable;
import java.util.Date;

public class SynchHeader implements Serializable {
	
	private static final long serialVersionUID = 7076712843965723259L;
	
	public String objectClass;
	public int objectCount;
	public Date synchDate;
	
	public SynchHeader(){
		super();
	}
}