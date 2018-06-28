package com.mainretail.handheld.purchase;

import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;

import com.mainretail.handheld.PessoaService;
import com.mainretail.util.Util;

public class POService {
	
	public static Hashtable toHashtable(PO po)
	{
		Hashtable hashpo = new Hashtable();
		
		String strObj;
		
		strObj = "PO.";
		
		if (po.vendor != null){
			Hashtable htPessoa = PessoaService.pessoaToHashtable(po.vendor, "vendor.");
			for (Enumeration enumPessoa = htPessoa.keys(); enumPessoa.hasMoreElements();){
				String key = (String)enumPessoa.nextElement();
				hashpo.put(strObj + key, String.valueOf((String)htPessoa.get(key)));
			}
		}	
				
		if (po.idpo != 0) {
			hashpo.put(strObj + "idpo", String.valueOf(po.idpo));
		}
		
		if (po.idstore != 0) {
			hashpo.put(strObj + "idstore", String.valueOf(po.idstore));
		}
		
		if (po.paydays != 0) {
			hashpo.put(strObj + "paydays", String.valueOf(po.paydays));
		}
		
		if (po.obs != null) {
			hashpo.put(strObj + "obs", Util.encodeURL(po.obs));
		}
			
		if (po.freight != 0) {
			hashpo.put(strObj + "freight", String.valueOf(po.freight));
		}

		if (po.charges != 0) {
			hashpo.put(strObj + "charges", String.valueOf(po.charges));
		}
		
		if (po.subtotal != 0) {
			hashpo.put(strObj + "subtotal", String.valueOf(po.subtotal));
		}

		if (po.paymentetype != 0) {
			hashpo.put(strObj + "paymentetype", String.valueOf(po.paymentetype));
		}
		
		hashpo.put(strObj + "aberto", String.valueOf(po.aberto));
		hashpo.put(strObj + "atendido", String.valueOf(po.atendido));
		
		if (po.datapedido != null) {
			hashpo.put(strObj + "datapedido", String.valueOf(po.datapedido.getTime()));
		}
		
		if (po.estarrival != null) {
			hashpo.put(strObj + "estarrival", String.valueOf(po.estarrival.getTime()));
		}
		return hashpo;
	}
	
	public static PO toPO(Hashtable ht) {
		PO po = new PO();
		
		String query = Util.hashtableToQuery(ht);
		
		String strObj = "PO.";
		
		// Pessoa
		if (query.indexOf(strObj + "vendor.") >= 0){
			po.vendor = PessoaService.hashTableToPessoa(ht, strObj, "vendor.");
		}
		
		query = null;
		
		if (ht.containsKey(strObj + "idpo")) {
			po.idpo = Integer.parseInt((String)ht.get(strObj + "idpo"));
		}

		if (ht.containsKey(strObj + "idstore")) {
			po.idstore = Integer.parseInt((String)ht.get(strObj + "idstore"));
		} 
		
		if (ht.containsKey(strObj + "paydays")) {
			po.paydays = Integer.parseInt((String)ht.get(strObj + "paydays"));
		}
		
		if (ht.containsKey(strObj + "obs")) {
			po.obs = Util.decodeURL((String)ht.get(strObj + "obs"));
		}
		
		if (ht.containsKey(strObj + "freight")) {
			po.freight = Double.parseDouble((String)ht.get(strObj + "freight"));
		}
		
		if (ht.containsKey(strObj + "charges")) {
			po.charges = Double.parseDouble((String)ht.get(strObj + "charges"));
		}
		
		if (ht.containsKey(strObj + "subtotal")) {
			po.subtotal = Double.parseDouble((String)ht.get(strObj + "subtotal"));
		}
		
		if (ht.containsKey(strObj + "paymentetype")) {
			po.paymentetype = Double.parseDouble((String)ht.get(strObj + "paymentetype"));
		}
		
		if (ht.containsKey(strObj + "aberto")) {			
			po.aberto =  Util.stringToBoolean((String)ht.get(strObj + "aberto"));
		}
		
		if (ht.containsKey(strObj + "atendido")) {		
			po.atendido = Util.stringToBoolean((String)ht.get(strObj + "atendido"));
		}		

		if (ht.containsKey(strObj + "datapedido")) {
			po.datapedido = new Date(Long.parseLong((String)ht.get(strObj + "datapedido")));
		}
		
		if (ht.containsKey(strObj + "estarrival")) {
			po.estarrival = new Date(Long.parseLong((String)ht.get(strObj + "estarrival")));
		}
		
		return po;
	}
	
	public static Purchase toPurchase(PO po){
		Purchase purchase = new Purchase();
		if (po != null){
			purchase.idstore = po.idstore;
			purchase.vendor = po.vendor;
			purchase.freight = po.freight;
			purchase.othercharges = po.charges;
			purchase.idpo = po.idpo;
		} 
		
		return purchase;
	}
	

	public static String toQueryString(PO po){
		Hashtable ht = toHashtable(po);
		return Util.hashtableToQuery(ht);	
   }

}
