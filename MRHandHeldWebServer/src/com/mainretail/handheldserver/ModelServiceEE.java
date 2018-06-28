package com.mainretail.handheldserver;


import java.util.*;

import javax.servlet.http.HttpServletRequest;

import com.mainretail.handheld.Model;
import com.mainretail.handheld.ModelService;

public class ModelServiceEE extends ModelService {

	 public static Model toProduct(HttpServletRequest request)
	  {
		 Hashtable t = new Hashtable();
		 Enumeration en = request.getParameterNames();
		 
		 while (en.hasMoreElements())
		 {
			 String key = (String)en.nextElement();
			 String value=request.getParameter(key); 
			 t.put (key,value);
		 }
		 return toModel(t);
		 
	   }
	 
		
		
}
