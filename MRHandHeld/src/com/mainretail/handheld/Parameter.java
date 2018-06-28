package com.mainretail.handheld;

public class Parameter {
	public int idparam;
	public Object srvvalue;
	public Object defaulvalue;
	
	public Parameter() {
		super();
	}

	public Parameter(Object defaulvalue, int idparam, Object svrvalue) {
		super();
		this.defaulvalue = defaulvalue;
		this.idparam = idparam;
		this.srvvalue = svrvalue;
	}
	
	public String toString() {
		return idparam + " " + defaulvalue + " " + srvvalue;
	}

}
