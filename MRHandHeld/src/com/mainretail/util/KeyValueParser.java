package com.mainretail.util;

public class KeyValueParser {
	
	private String key;
	private String value;
	
	public KeyValueParser() {
		super();
	}
	public String getKey() {
		return key;
	}
	public String get() {
		return value;
	}
	
	public boolean containsKey(String query, String key) {
		int pos = query.indexOf(key + "=");
		this.key = key;
		this.value = null;
				
		if (pos >= 0) {
			int inicio = pos;
			
			this.key = key;
			
			int posFim = query.indexOf("&", inicio + key.length() + 1);			
				
			if (posFim == -1)
				this.value = query.substring(inicio, query.length()).trim();
			else
				this.value = query.substring(inicio, posFim).trim();
			
			inicio = this.value.indexOf("=");
			this.value = this.value.substring(inicio + 1, this.value.length());
			return true;
		}
		else
			return false;
	}

}
