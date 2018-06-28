package com.softvar.controller;

import java.io.ObjectOutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.Enumeration;
import java.util.Hashtable;
import com.softvar.controller.event.ConnectionManagerListener;

public class ConnectionManager {

	private Hashtable defaultHeaders;
	private String urlPath;
	private int responseCode;
	private String responseMessage;
	private ConnectionManagerListener connectionManagerListener;
	private String servlet;
	private String application;

	public ConnectionManager() {
		super();
	}
	
	public void putDefaultHeaders(){
		if (defaultHeaders == null){
			defaultHeaders = new Hashtable();
			defaultHeaders.put("user-agent", "softvar-agent");
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
		boolean result = true;
		URL url = null;
		URLConnection con = null;
		HttpURLConnection http = null;
		try {
			String path = "http://" + urlPath + ":8080/"+ application +"/" + servlet;
			url = new URL(path);
			con = url.openConnection();
			http = (HttpURLConnection) con;
			
			http.setDoInput(true);
			http.setDoOutput(true);
			
			putDefaultHeaders();
			
			prepareHeaders(http, defaultHeaders);
			
			http.setRequestMethod("POST");
			
			ObjectOutputStream oos = new ObjectOutputStream(http.getOutputStream());
			try{
				if (connectionManagerListener != null)
					connectionManagerListener.dataOutput(oos);
				oos.flush();				
			} finally {
				//oos.close();
				oos = null;
			}
			
			responseCode = http.getResponseCode();
			
			
			if (responseCode == HttpURLConnection.HTTP_OK) {
				try{
					if (connectionManagerListener != null)
						connectionManagerListener.dataInput(http.getInputStream());
					
				} finally{
				}
			}
			else {
				responseMessage = http.getResponseMessage();
				connectionManagerListener.httpError(responseCode, responseMessage);
				result = false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			connectionManagerListener.connectionException(e);
			result = false;
		}finally{
			if (http != null)
				http.disconnect();
			http = null;
			con = null;
			url = null;
		}
		
		if (result)
			connectionManagerListener.proccesData();
		return result;
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

	public String getApplication() {
		return application;
	}

	public void setApplication(String application) {
		this.application = application;
	}
	
}
