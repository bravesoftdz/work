package com.mainretail.handheld;

import java.util.Hashtable;

import com.mainretail.util.KeyValueParser;
import com.mainretail.util.Util;

public class ModelService {
	
	public static Hashtable toHashtable(Model model){
		return  toHashtable(model,"M.");
	}
	
	public static Hashtable toHashtable(Model model, String modelalias)
	{
		Hashtable hashModel = new Hashtable();
		if (model.idmodel != 0) {
			hashModel.put(modelalias + "idmodel", String.valueOf(model.idmodel));
		}
		
		if (model.idgroup != 0) {
			hashModel.put(modelalias + "idgroup", String.valueOf(model.idgroup));
		}
		
		if (model.model != null) {
			hashModel.put(modelalias + "model", Util.encodeURL(model.model));
		}
		
		if (model.barcode != null) {
			hashModel.put(modelalias + "barcode", Util.encodeURL(model.barcode));
		}
		
		
		if (model.description != null) {
			hashModel.put(modelalias + "description", Util.encodeURL(model.description));
		}
		
		if (model.qty != Double.NaN || model.qty != 0 ) {
			hashModel.put(modelalias + "qty", String.valueOf(model.qty));
		}
		
		if (model.sellingprice != Double.NaN || model.sellingprice != 0 ) {
			hashModel.put(modelalias + "sellingprice", String.valueOf(model.sellingprice));
		}
		
		if (model.vendorcost != Double.NaN || model.vendorcost != 0 ) {
			hashModel.put(modelalias + "vendorcost", String.valueOf(model.vendorcost));
		}
		
		if (model.suggretail != Double.NaN || model.suggretail != 0 ) {
			hashModel.put(modelalias + "suggretail", String.valueOf(model.suggretail));
		}
		
		return  hashModel;
	}

   public static Model toModel(Hashtable hashModel) {
		return toModel(hashModel, "");
   }
   
   public static Model toModel(Hashtable hashModel, String alias) {
	   //return toModel(hashModel, "", "M.");
	   return toModel(hashModel, alias, "M.");
   }
   
   public static Model toModel(Hashtable hashModel, String alias, String modelalias) {
	    Model model = new Model ();

		if (hashModel.containsKey(alias + modelalias + "idmodel")) {
			model.idmodel = Integer.parseInt((String)hashModel.get(alias + modelalias + "idmodel"));
		}
		
		if (hashModel.containsKey(alias + modelalias + "idgroup")) {
			model.idgroup = Integer.parseInt((String)hashModel.get(alias + modelalias + "idgroup"));
		}

		if (hashModel.containsKey(alias + modelalias + "model")) {
			model.model = Util.decodeURL((String)hashModel.get(alias + modelalias + "model"));
		}

		if (hashModel.containsKey(alias + modelalias + "barcode")) {
			model.barcode = Util.decodeURL((String)hashModel.get(alias + modelalias + "barcode"));
		}

		if (hashModel.containsKey(alias + modelalias + "description")) {
			model.description = Util.decodeURL((String)hashModel.get(alias + modelalias + "description"));
		}

		if (hashModel.containsKey(alias + modelalias + "qty")) {
			model.qty = Double.parseDouble((String)hashModel.get(alias + modelalias + "qty"));
		}
		
		if (hashModel.containsKey(alias + modelalias + "sellingprice")) {
			model.sellingprice = Double.parseDouble((String)hashModel.get(alias + modelalias + "sellingprice"));
		}

		if (hashModel.containsKey(alias + modelalias + "vendorcost")) {
			model.vendorcost = Double.parseDouble((String)hashModel.get(alias + modelalias + "vendorcost"));
		}

		if (hashModel.containsKey(alias + modelalias + "suggretail")) {
			model.suggretail = Double.parseDouble((String)hashModel.get(alias + modelalias + "suggretail"));
		}

		return model;
   }
	
   public static String toQueryString(Model model) {
	   Hashtable ht = toHashtable(model);
	   return Util.hashtableToQuery(ht);
   }
   
   
   // Otmização //
   
   public static Model toModel(String query, String alias) {
	   //return toModel(hashModel, "", "M.");
	   return toModel(query, alias, "M.");
   }
   
   public static Model toModel(String query, String alias, String modelalias) {
	    Model model = new Model ();
	    
	    KeyValueParser hashModel = new KeyValueParser();

		if (hashModel.containsKey(query, alias + modelalias + "idmodel")) {
			model.idmodel = Integer.parseInt((String)hashModel.get());
		}
		
		if (hashModel.containsKey(query, alias + modelalias + "idgroup")) {
			model.idgroup = Integer.parseInt((String)hashModel.get());
		}

		if (hashModel.containsKey(query, alias + modelalias + "model")) {
			model.model = Util.decodeURL((String)hashModel.get());
		}

		if (hashModel.containsKey(query, alias + modelalias + "barcode")) {
			model.barcode = Util.decodeURL((String)hashModel.get());
		}

		if (hashModel.containsKey(query, alias + modelalias + "description")) {
			model.description = Util.decodeURL((String)hashModel.get());
		}

		if (hashModel.containsKey(query, alias + modelalias + "qty")) {
			model.qty = Double.parseDouble((String)hashModel.get());
		}
		
		if (hashModel.containsKey(query, alias + modelalias + "sellingprice")) {
			model.sellingprice = Double.parseDouble((String)hashModel.get());
		}

		if (hashModel.containsKey(query, alias + modelalias + "vendorcost")) {
			model.vendorcost = Double.parseDouble((String)hashModel.get());
		}

		if (hashModel.containsKey(query, alias + modelalias + "suggretail")) {
			model.suggretail = Double.parseDouble((String)hashModel.get());
		}

		return model;
  }
   
}