package com.mainretail.commun.model;

import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;



public class Util {
	
	public static Vector toVector(Hashtable table)
	{
		Vector vector= new Vector();
		for (Enumeration en = table.elements();en.hasMoreElements();){
			vector.addElement(en.nextElement());
		}
		vector.trimToSize(); 
		return vector;
	}
	
	public static String[] toArray(Hashtable table){
		String[] result = new String[table.size()];
		int i=0;
		for (Enumeration en = table.elements(); en.hasMoreElements(); )
		{
			result[i]= en.nextElement().toString();
			i++;
		}
		return result;
	}
	
	
	public static String replace(String s0,String s1,String s2)	{
		String result= new String(s0);
		int pos;
		while ((pos = result.indexOf(s1))!=-1)
		{
			result = result.substring(0,pos)+s2+result.substring(pos+s1.length());
		}
		return result;
	}
	
	public static void addAll(Hashtable adicionar,Hashtable adicionado)	{
		
		for(Enumeration en=adicionar.keys(); en.hasMoreElements();)
		{
			Object key = en.nextElement() ;
			adicionado.put(key,adicionar.get(key));
		}
	}
	
	public static String hashtableToQuery(Hashtable ht) {
		String result = "";
		//StringBuffer result = new StringBuffer("");
		
		for(Enumeration en = ht.keys(); en.hasMoreElements(); ) {
			String key = (String) en.nextElement();
			String value;
			if (ht.get(key) instanceof String[]) {
				String[] valueTmp = (String[]) ht.get(key);
				value = valueTmp[0];
			}
			else
				value = ht.get(key).toString();
			
			result = result + key + "=" + value;
			
			//result.append(result.toString() + key + "=" + value);
			value = null;
			key = null;
			if (en.hasMoreElements()) {
				//result.append(result.toString()+ "&");
				result = result + "&";
			}
			
		}
		System.gc();
		return result;
		//return result.toString();
	}
	
	public static Hashtable queryToHashtable(String query) {
		
		Hashtable result = new Hashtable();
		
		String auxQuery = new String(query);
		
		while (auxQuery.length() > 0) {
			
			int posSep = auxQuery.indexOf("=");
			
			String key = auxQuery.substring(0, posSep).trim();
			
			auxQuery = auxQuery.substring(posSep + 1, auxQuery.length());
			
			int posFim = auxQuery.indexOf("&");
			
			String value;
			
			
			if (posFim == -1) {
				value = auxQuery.substring(0, auxQuery.length()).trim();
				auxQuery = "";
			}
			else
			{
				value = auxQuery.substring(0, posFim).trim();
				auxQuery = auxQuery.substring(posFim + 1, auxQuery.length());
			}
			
			result.put(key, value);
			key = null;
			value = null;
			System.gc();
		}
		auxQuery = null;
		System.gc();
		 
		return result;
	}
	
	public static Hashtable joinHashtables(Hashtable ht, Hashtable ht2) {
		
		Hashtable newht = new Hashtable();
		
		for(Enumeration en = ht.keys(); en.hasMoreElements();){
			String key = (String)en.nextElement();
			newht.put(key, ht.get(key));
			key = null;
		}
		
		for(Enumeration en = ht2.keys(); en.hasMoreElements();){
			String key = (String)en.nextElement();
			newht.put(key, ht2.get(key));
			key = null;
		}
		
		System.gc();
		
		return newht;
	}
	
	public static String encodeURL(String s){
		String result = new String(s);
		
		
		// Tem q ser o primeiro
		result = replaceAll(result, "%", "%25");
		result = replaceAll(result, "/", "%2F");
		
		result = replaceAll(result, "&", "%26");
		result = replaceAll(result, " ", "%20");
		result = replaceAll(result, "´", "%C2%B4");
		
		result = replaceAll(result, "Á", "%C3%81");
		result = replaceAll(result, "Ã", "%C3%83");
		result = replaceAll(result, "Ç", "%C3%87");
		result = replaceAll(result, "É", "%C3%89");
		result = replaceAll(result, "Ê", "%C3%8A");
		
		result = replaceAll(result, "+", "%2B");
		result = replaceAll(result, ";", "%3B");
		result = replaceAll(result, "=", "%3D");
		result = replaceAll(result, "^", "%5E");
		result = replaceAll(result, "~", "%7E");
		result = replaceAll(result, String.valueOf('"'), "%22");
		result = replaceAll(result, "'", "%27");
		result = replaceAll(result, "´", "%60");
	
		return result; 
	}
	
	public static String decodeURL(String s){
		if ((s != null)){
			String result = new String(s);
			result = replaceAll(result, "%20", " ");
			result = replaceAll(result, "%C2%B4", "´");
			result = replaceAll(result, "%C3%81", "Á");
			result = replaceAll(result, "%C3%83", "Ã");
			result = replaceAll(result, "%C3%87", "Ç");
			result = replaceAll(result, "%C3%89", "É");
			result = replaceAll(result, "%C3%8A", "Ê");
			
			result = replaceAll(result, "%2B", "+");
			result = replaceAll(result, "%3B", ";");
			result = replaceAll(result, "%3D", "=");
			result = replaceAll(result, "%5E", "^");
			result = replaceAll(result, "%7E", "~");
			result = replaceAll(result, "%22", String.valueOf('"'));
			result = replaceAll(result, "%27", "'");
			result = replaceAll(result, "%60", "´");
			
			result = replaceAll(result, "%20", " ");
			result = replaceAll(result, "%26", "&");
			
			
			result = replaceAll(result, "%2F", "/");
			// Tem q ser o último
			result = replaceAll(result, "%25", "%");
			
			return result;
			
		}
		else
			return null;
		
		
	}
	
	public static String replaceAll(String s, String oldPattern, String newPattern){
		
		if (s != null){
			String strTemp = new String(s);
			int pos;
			while ((pos = strTemp.indexOf(oldPattern)) >= 0){
				strTemp = strTemp.substring(0, pos) + newPattern + strTemp.substring(pos + oldPattern.length());
			}
			return strTemp;
		}
		else
			return null;
		
	}
	
	public static boolean stringToBoolean(String boolstr){
		return (boolstr != null) & boolstr.equals(Boolean.TRUE.toString());
	}
	
	public static String booleanToSQLString(Boolean b) {
		if (b.booleanValue()) 
			return "1";
		else
			return "0";
	}
	
	public static double double4Digits(double d){
		return (double)((int)(d * 10000)) / 10000; 
	}
	
	
	public static String fixBarcodeDigits(String barcode, int barcodeType) {
		String retorno = null;
		switch (barcodeType) {
		// Retira primeiro caracter
		case 1:{
			retorno = barcode.substring(1, barcode.length());
			break;
		}
		
		// Retira último caracter
		case 2:{
			retorno = barcode.substring(0, barcode.length() - 1);
			break;
		}
		
		// Retira primeiro e ultimo
		case 3:{
			retorno = barcode.substring(1, barcode.length() - 1);
			break;
		}
		
		default:{
			retorno = barcode.substring(1, barcode.length() - 1);
		}
		}
		return retorno;
	}
	
	public static void showMemUsage() {
		String memUse = String.valueOf(Runtime.getRuntime().freeMemory()) + " of " + String.valueOf(Runtime.getRuntime().freeMemory());
		System.out.println(memUse);
	}
	
}

