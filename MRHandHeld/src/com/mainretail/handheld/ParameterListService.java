package com.mainretail.handheld;

import java.util.Enumeration;
import java.util.Hashtable;
import com.mainretail.util.Util;

public class ParameterListService {

	public ParameterListService() {
		super();
	}
	
	public static Hashtable parameterListToHashtable(ParameterList parameterList) {
		
		Hashtable ht = new Hashtable();
		
		String strObj = "PMTLST.PMT_";
		int i = 1;
		for(Enumeration enumParameter = parameterList.parameters.elements(); enumParameter.hasMoreElements();) {			
			Parameter p = (Parameter)enumParameter.nextElement(); 
			Hashtable htParameter = ParameterService.parameterToHashTable(p, ""/*strObj + i + '.'*/);
			for (Enumeration en = htParameter.keys(); en.hasMoreElements();){
				String key = (String)en.nextElement();
				ht.put(strObj + i + '.' + key, String.valueOf((String)htParameter.get(key)));
			}
			htParameter = null;
			i++;
		}
		
		return ht;
	}
	
	public static ParameterList queryStringToParameterList(String query)   {
		ParameterList parameterList = new ParameterList();
		Hashtable ht = Util.queryToHashtable(query);			
		
		String strObj = null;

		int i = 1;
		
		while(query.indexOf(strObj = new String("PMTLST.PMT_" + String.valueOf(i) + ".")) >= 0){
			
			Parameter parameter = new Parameter();
			
	    	if (ht.containsKey(strObj + "idparam")) {
	    		parameter.idparam = Integer.parseInt((String)ht.get(strObj + "idparam"));
			}

			if (ht.containsKey(strObj + "defaulvalue")) {
				parameter.defaulvalue =  Util.decodeURL((String)ht.get(strObj + "defaulvalue"));
			}
			
			if (ht.containsKey(strObj + "srvvalue")) {
				parameter.srvvalue =  Util.decodeURL((String)ht.get(strObj + "srvvalue"));
			}
			 
			parameterList.parameters.addElement(parameter);
			
			i++;
		}
		
		return parameterList;
	}

}
