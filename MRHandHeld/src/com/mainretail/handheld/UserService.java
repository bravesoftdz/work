package com.mainretail.handheld;

import java.util.Hashtable;

import com.mainretail.util.Util;

public class UserService {
	
	public static Hashtable toHashtable(User user)
	{
		Hashtable hashUser = new Hashtable();

		if (user.iduser!=0) {
			hashUser.put("U.id",String.valueOf(user.iduser));
		}
		
		if (user.usertypeid!=0) {
			hashUser.put("U.userTypeId",String.valueOf(user.usertypeid));
		}
		
		if (user.comissionid!=0) {
			hashUser.put("U.comissionID",String.valueOf(user.comissionid));
		}

		if (user.systemuser!=null) {
			hashUser.put("U.systemUser",user.systemuser);
		}
		
		if (user.pw!=null) {
			hashUser.put("U.pw",user.pw);
		}
		
		if (user.system!=null) {
			hashUser.put("U.system",user.system);
		}
		
		if (user.desativado!=null) {
			hashUser.put("U.desativado",user.desativado);
		}
		
		if (user.hidden!=null) {
			hashUser.put("U.hidden",user.hidden);
		}
		
		if (user.codsystemuser!=null) {
			hashUser.put("U.codSystemUse",user.codsystemuser);
		}
		
		if (user.storesaccess!=null) {
			hashUser.put("U.storesAccess",user.storesaccess);
		}
		
		if (user.contadorclasse!=null) {
			hashUser.put("U.contadorClasse",user.contadorclasse);
		}
		
		
		return  hashUser;
	}


   public static User toUser(Hashtable hashUser)
   {
	   
	    User user= new User ();
		if (hashUser.containsKey("U.id")) {
			user.iduser = Integer.parseInt((String)hashUser.get("U.id"));
		}
		if (hashUser.containsKey("U.userTypeId")) {
			user.usertypeid = Integer.parseInt((String)hashUser.get("U.userTypeId"));
		}
		if (hashUser.containsKey("U.comissionID")) {
			user.comissionid = Integer.parseInt((String)hashUser.get("U.comissionID"));
		}
		if (hashUser.containsKey("U.systemUser")) {
			user.systemuser = (String)hashUser.get("U.systemUser");
		}
		 
		if (hashUser.containsKey("U.pw")) {
			user.pw = (String)hashUser.get("U.pw");
		}
		
		if (hashUser.containsKey("U.system")) {
			user.system = (String)hashUser.get("U.system");
		}
		if (hashUser.containsKey("U.desativado")) {
			user.desativado = (String)hashUser.get("U.desativado");
		}
		 
		if (hashUser.containsKey("U.hidden")) {
			user.hidden = (String)hashUser.get("U.hidden");
		}
		
		if (hashUser.containsKey("U.codSystemUser")) {
			user.codsystemuser = (String)hashUser.get("U.codSystemUser");
		}
		if (hashUser.containsKey("U.storesAccess")) {
			user.storesaccess = (String)hashUser.get("U.storesAccess");
		}
		if (hashUser.containsKey("U.contadorClasse")) {
			user.contadorclasse = (String)hashUser.get("U.contadorClasse");
		}		
	   
	   return user;
   }

   public static String toQueryString(User user){
	   Hashtable ht = toHashtable(user);
	   return Util.hashtableToQuery(ht);
	}
   
}