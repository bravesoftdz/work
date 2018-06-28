package com.mainretail.handheld.purchase;

import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;

import com.mainretail.handheld.Model;
import com.mainretail.handheld.ModelService;
import com.mainretail.util.Util;

public class RequestService {
	
		   
	public static Hashtable vectorToHashtable(Vector vector)
	{
		Hashtable ht = new Hashtable();
		
		Request request = null;
		int i = 0;
		String strObj;
		
		for (Enumeration en = vector.elements(); en.hasMoreElements();)
		{
			i++;
			request = (Request)en.nextElement();
			strObj = "REQ_" + String.valueOf(i) + ".";
			
			if (request.model != null){
				
				Hashtable htModel = ModelService.toHashtable(request.model);
				for (Enumeration enumModel = htModel.keys(); enumModel.hasMoreElements();){
					String key = (String)enumModel.nextElement();
					ht.put(strObj + key, String.valueOf((String)htModel.get(key)));
				}
			}
			
			if (request.idrequest != 0) {
				ht.put(strObj + "idrequest", String.valueOf(request.idrequest));
			}
			
			if (request.userid != 0) {
				ht.put(strObj + "userid", String.valueOf(request.userid));
			}
			
			if (request.storeid != 0) {
				ht.put(strObj + "storeid", String.valueOf(request.storeid));
			}
			
			if (request.idpreinventorymov != 0) {
				ht.put(strObj + "idpreinventorymov", String.valueOf(request.idpreinventorymov));
			}
			
			if (request.idcotacao != 0) {
				ht.put(strObj + "idcotacao", String.valueOf(request.idcotacao));
			}
			
			if (request.type != null) {
				ht.put(strObj + "type", Util.encodeURL(request.type));
			}
			
			if (request.description != null) {
				ht.put(strObj + "description", Util.encodeURL(request.description));
			}
			
			if (request.qtyreq != Double.NaN || request.qtyreq != 0 ) {
				ht.put(strObj + "qtyreq", String.valueOf(request.qtyreq));
			}
			
			if (request.qtyordered != Double.NaN || request.qtyordered != 0 ) {
				ht.put(strObj + "qtyordered", String.valueOf(request.qtyordered));
			}
			
			ht.put(strObj + "cotado", String.valueOf(request.cotado));
			
			if (request.daterequest != null) {
				ht.put(strObj + "daterequest", String.valueOf(request.daterequest.getTime()));
			}
			
			if (request.delaydate != null) {
				ht.put(strObj + "delaydate", String.valueOf(request.delaydate.getTime()));
			}
							
		}
		return ht;
	}
	
	public static Vector queryStringToVector(String query){
		Vector vector = new Vector();
		Hashtable ht = Util.queryToHashtable(query);			
		
		String strObj = null;
		int i = 1;
		
		while(query.indexOf(strObj = new String("REQ_" + String.valueOf(i) + ".")) >= 0){
			
			Request request = new Request();
			
			// Model
			if (query.indexOf(strObj + "M.") >= 0){
				request.model = ModelService.toModel(ht, strObj);
			}
			
			if (ht.containsKey(strObj + "idrequest")) {
				request.idrequest = Integer.parseInt((String)ht.get(strObj + "idrequest"));
			}
			
			if (ht.containsKey(strObj + "userid")) {
				request.userid = Integer.parseInt((String)ht.get(strObj + "userid"));
			}
			
			if (ht.containsKey(strObj + "storeid")) {
				request.storeid = Integer.parseInt((String)ht.get(strObj + "storeid"));
			}
			
			if (ht.containsKey(strObj + "idpreinventorymov")) {
				request.idpreinventorymov = Integer.parseInt((String)ht.get(strObj + "idpreinventorymov"));
			}
			
			if (ht.containsKey(strObj + "idcotacao")) {
				request.idcotacao = Integer.parseInt((String)ht.get(strObj + "idcotacao"));
			}
			
			if (ht.containsKey(strObj + "type")) {
				request.type = Util.decodeURL((String)ht.get(strObj + "type"));
			}
			
			if (ht.containsKey(strObj + "description")) {
				request.description = Util.decodeURL((String)ht.get(strObj + "description"));
			}

			if (ht.containsKey(strObj + "qtyreq")) {
				request.qtyreq = Double.parseDouble((String)ht.get(strObj + "qtyreq"));
			}
			
			if (ht.containsKey(strObj + "qtyordered")) {
				request.qtyordered = Double.parseDouble((String)ht.get(strObj + "qtyordered"));
			}
			
			if (ht.containsKey(strObj + "cotado")) {			
				request.cotado =  Util.stringToBoolean((String)ht.get(strObj + "cotado"));
			}
			
			if (ht.containsKey(strObj + "daterequest")) {
				request.daterequest = new Date(Long.parseLong((String)ht.get(strObj + "daterequest")));
			}
			
			if (ht.containsKey(strObj + "delaydate")) {
				request.delaydate = new Date(Long.parseLong((String)ht.get(strObj + "delaydate")));
			}
			
			vector.addElement(request);
			
			i++;
		}
		
		return vector;
	}
	
	public static Request toRequest(Model model){
		Request request = new Request();
		
		request.model = model;
		request.description = model.description;
	
		return request;		
	}

}
