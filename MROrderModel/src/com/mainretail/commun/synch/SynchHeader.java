package com.mainretail.commun.synch;

import java.io.Serializable;

public class SynchHeader implements Serializable{
	private static final long serialVersionUID = 7076712843965723259L;
	public String objectClass;
	public int objectCount;
	public SynchHeader(){
		super();
	}
}