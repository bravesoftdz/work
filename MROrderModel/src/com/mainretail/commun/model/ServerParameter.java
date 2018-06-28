package com.mainretail.commun.model;

import java.io.Serializable;

public class ServerParameter implements Serializable{
	private static final long serialVersionUID = -5608763525104520273L;
	
	public int idparam;
	public Object srvvalue;
	public Object defaulvalue;
	
	public ServerParameter() {
		super();
	}

}
