package com.mainretail.handheld;

import java.util.Hashtable;

import com.mainretail.util.Util;

public class ParameterService {

	public ParameterService() {
		super();
	}
	
	public static Hashtable parameterToHashTable(Parameter parameter, String alias) {
		Hashtable ht = new Hashtable();
		
		if (parameter.idparam != 0)
			ht.put(alias + "idparam", String.valueOf(parameter.idparam));
		
		if (parameter.srvvalue != null)
			ht.put(alias + "srvvalue", Util.encodeURL(parameter.srvvalue.toString()));
		
		if (parameter.defaulvalue != null)
			ht.put(alias + "defaulvalue", Util.encodeURL(parameter.defaulvalue.toString()));
		
		return ht;
	}	

}
