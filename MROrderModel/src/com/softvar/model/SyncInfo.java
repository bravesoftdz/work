package com.softvar.model;

import java.io.Serializable;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.Date;

public class SyncInfo implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -882717553502900070L;
	public String className;
	public Date syncDate;
	
	public SyncInfo(){
	}

	public boolean equals(Object other) {
		if (other == null){
			return false; 
		}
		else if (other instanceof SyncInfo ){
			if (((SyncInfo)other).className.equals(this.className)){
				return true;				
			} else {
				return false;
			}
		} else 
			return false;
	}
	
	public String getFormatedDate() {
		if (this.syncDate != null){
			Format formatter = new SimpleDateFormat("MM/dd/yyyy HH:mm");
			return " - (" + formatter.format(this.syncDate) + ")";
		}
		else
			return "";
	}
	

}
