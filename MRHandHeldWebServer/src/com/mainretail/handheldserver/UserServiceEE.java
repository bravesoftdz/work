package com.mainretail.handheldserver;


import java.util.*;
import java.util.Map;

import com.mainretail.handheld.User;
import com.mainretail.handheld.UserService;

public class UserServiceEE extends UserService {

	

	 public static User toUser(Map hashUser)
	  {
		 Hashtable t = new Hashtable();
		 Iterator it = hashUser.keySet().iterator();
		 
		 while (it.hasNext() )
		 {
			 Object key = it.next();
			 Object value = hashUser.get(key); 
			 t.put (key,value);
		 }
		 return toUser(t);
		 
	   }
	
}
