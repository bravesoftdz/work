package com.softvar.util;

public class StringUtils {
	public static String UnqualifyName(String className){
		int lastIndex = className.lastIndexOf(".");
		if (lastIndex != -1)
			return className.substring(lastIndex + 1);
		else
			return className;
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
}
