package com.mainretail.commun.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.Enumeration;
import java.util.Hashtable;

import com.mainretail.commun.event.ConnectionManagerListener;

public class ConnectionManager {

	private Hashtable defaultHeaders;
	private String urlPath;
	private int responseCode;
	private String responseMessage;
	private ConnectionManagerListener connectionManagerListener;
	private String servlet;

	public ConnectionManager() {
		super();
	}
	
	public void putDefaultHeaders(){
		if (defaultHeaders == null){
			defaultHeaders = new Hashtable();
			defaultHeaders.put("User-Agent", "MRSynch 0.1");
			defaultHeaders.put("Connection", "close");
		}
	}
	
	private void prepareHeaders(HttpURLConnection http, Hashtable headers){
		if (headers!=null) {
			//Converte o Hashtable em uma String de Parametros
			Enumeration keys = headers.keys();
			while (keys.hasMoreElements()) {
				String key = (String) keys.nextElement() ;
				//System.out.println(key+":"+(String)headers.get(key));
				http.setRequestProperty(key,(String)headers.get(key));
			}
		}
	}
	
	public boolean send(){		
		URL url = null;
		URLConnection con = null;
		HttpURLConnection http = null;
		try {
			url = new URL("http://" + urlPath + ":8080/mrservlet2/" + servlet);
			con = url.openConnection();
			http = (HttpURLConnection) con;
			
			http.setDoInput(true);
			http.setDoOutput(true);
			
			putDefaultHeaders();
			
			prepareHeaders(http, defaultHeaders);
			
			http.setRequestMethod("POST");
			
			ObjectOutputStream oos = new ObjectOutputStream(new BufferedOutputStream(http.getOutputStream()));
			try{
				if (connectionManagerListener != null)
					connectionManagerListener.dataOutput(oos);
				oos.flush();				
			} finally {
				oos.close();
				oos = null;
			}
			
			responseCode = http.getResponseCode();
			
			
			if (responseCode == HttpURLConnection.HTTP_OK) {				
				ObjectInputStream ois = new ObjectInputStream(new BufferedInputStream(http.getInputStream()));
				try{
					if (connectionManagerListener != null)
						connectionManagerListener.dataInput(ois);
					
				} finally{
					ois.close();
					ois = null;
				}
			}
			else {
				responseMessage = http.getResponseMessage();
				connectionManagerListener.httpError(responseCode, responseMessage);
			}
		} catch (Exception e) {
			e.printStackTrace();
			connectionManagerListener.connectionException(e);		
		}finally{
			if (http != null)
				http.disconnect();
			http = null;
			con = null;
			url = null;
		}
		
		return true;
	}

	public void removeConnectionManagerListener() {
		connectionManagerListener = null;
	}

	public void setConnectionManagerListener(
			ConnectionManagerListener connectionManagerListener) {
		this.connectionManagerListener = connectionManagerListener;
	}

	public String getUrlPath() {
		return urlPath;
	}

	public void setUrlPath(String urlPath) {
		this.urlPath = urlPath;
	}

	public int getResponseCode() {
		return responseCode;
	}

	public String getResponseMessage() {
		return responseMessage;
	}

	public String getServlet() {
		return servlet;
	}

	public void setServlet(String servlet) {
		this.servlet = servlet;
	}


	
}
