package com.mainretail.util;

import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Enumeration;
import java.util.Hashtable;

import javax.microedition.io.Connector;
import javax.microedition.io.HttpConnection;
import javax.microedition.lcdui.Displayable;

import com.mainretail.handheld.debug.Log;

/**
 * Helper Class para execução de conexões http
 * @author beckmann
 *
 */
public class HttpConnectionHC {

	private String url;
	private Hashtable parameters;
	private String requestMethod;
	private Hashtable headers;
	private byte[] response = null;
	private int responseCode;
	private String responseMessage;
	private Displayable caller;
	
	private static Hashtable defaultHeaders;
	
	
	
	private  HttpConnection http = null;
	private boolean logEnabled = false;
	
	static {
		defaultHeaders=new Hashtable();
		defaultHeaders.put("User-Agent", "Profile/MIDP-1.0 Configuration/CLDC-1.0");
		defaultHeaders.put("Connection", "close");
	}
	
		
	public HttpConnectionHC(String url,Hashtable parametros,String requestMethod) {
		this(url, parametros, new Hashtable(), requestMethod);
	}
	/* Construtor padrão
	 * 
	*/
	
	public HttpConnectionHC(String url,Hashtable parameters,Hashtable headers,String requestMethod) {
		this.parameters = parameters;
		this.headers = headers;
		this.requestMethod = requestMethod;
		this.url = url;
	}

	public void send() throws IOException {
		log("HttpConnectionHC.send() - Begin (Called By "+ getCaller().getTitle() +"");
		OutputStream oStrm = null;
		InputStream iStrm = null;
		DataOutputStream os = null;
		response = null;
		String strParameters = prepareParameters();
		System.out.println(url);
		try {
			
			//Se for get...
			if (requestMethod.equals(HttpConnection.GET))
			{
				//Abre a conexao com parametros
				log("HttpConnectionHC.send() - Open Connection - GET");
				http = (HttpConnection) Connector.open(url + "?" + strParameters);				
				prepareHeaders(http, defaultHeaders);
				prepareHeaders(http, headers);
				http.setRequestMethod(HttpConnection.GET);
			}
			//Se for post...
			else if  (requestMethod.equals(HttpConnection.POST))
			{
				
				/*
				//Abre a conexao
				log("HttpConnectionHC.send() - Open Connection - POST");
				http = (HttpConnection) Connector.open(url);
				http.setRequestMethod(HttpConnection.POST);
				//Seta o header field, sem esse atributo o POST não funciona
				headers.put("Content-Type", "application/x-www-form-urlencoded");
				headers.put("content-length", String.valueOf(strParameters.length() + 15));
				prepareHeaders(http, defaultHeaders);
				prepareHeaders(http, headers);
				//Abre o OutputStream
				oStrm = http.openOutputStream();

				//Escreve os parametros no OutputStream
				oStrm.write(strParameters.getBytes());
				oStrm.flush();
				*/
				
				log("HttpConnectionHC.send() - Open Connection - POST");
				http = (HttpConnection) Connector.open(url);
				http.setRequestMethod(HttpConnection.POST);
				prepareHeaders(http, defaultHeaders);
				prepareHeaders(http, headers);

				os = (DataOutputStream)http.openDataOutputStream();
            
	            os.writeUTF(strParameters);
	            //os.flush();
	            
	            
					
			}
			else
			{ 
				throw new IllegalArgumentException("Invalid request method ");
			
			}
				
			//Obtem o resultado, se ok procede com a leitura da resposta
			log("HttpConnectionHC.send() - Waiting reply");
			responseCode = http.getResponseCode();
			responseMessage = http.getResponseMessage();
			log("HttpConnectionHC.send() - Reply Received");
			
			if (responseCode== HttpConnection.HTTP_OK) {
				//Obtem os dados resultantes do processamento
				log("HttpConnectionHC.send() - Reply OK - Getting Data");
				iStrm = http.openInputStream();				
				int size = (int) http.getLength();
				
				if (size != -1) {					
					response = new byte[size];					
					iStrm.read(response);
				} else {
					ByteArrayOutputStream bStrm = new ByteArrayOutputStream();
					int ch;
					while ((ch = iStrm.read()) != -1) {
						bStrm.write(ch);
					}
					response = bStrm.toByteArray();
					
					log("Resposta: " + new String(response));
					
					bStrm.close();					
				}
				log("HttpConnectionHC.send() - Reply OK - Data OK");
			} else {

				throw new IOException(responseCode + " - " +http.getResponseMessage());

			}
			
		} 
		//Efetua o fechamento
		finally {
			if (iStrm != null) {
				iStrm.close();
			}
			
			if (oStrm != null) {
				try{
				oStrm.close();
				}catch(Throwable t){
					t.printStackTrace();
					return;
				}
			}
			
			if (os != null) { 
				os.close();
				os = null;
			}
			
			
			//Nao pode fechar!
			/* PODE SIM !!! */
			if (http != null) {
				http.close();
			}
			
			
			log("HttpConnectionHC.send() - End (Called By "+ getCaller().getTitle() +")");
		}
		
		
	}

	
	
	private void prepareHeaders(HttpConnection http, Hashtable headers)
	throws IOException 
	{
		if (headers!=null) {
			//Converte o Hashtable em uma String de Parametros
			Enumeration keys = headers.keys();
			while (keys.hasMoreElements() )
			{
				String key = (String) keys.nextElement() ;
				System.out.println(key+":"+(String)headers.get(key));
				http.setRequestProperty(key,(String)headers.get(key));
			}
		}
	}
	
	private String prepareParameters()
	{
		return Util.hashtableToQuery(parameters);
		/*
		String strParameters = "";
		if (parameters!=null) {
			//Converte o Hashtable em uma String de Parametros
			Enumeration keys = parameters.keys();
			while (keys.hasMoreElements() )
			{
				String key = (String) keys.nextElement() ;
				strParameters += key+"="+parameters.get(key) + "&";
				System.out.println(key+"="+parameters.get(key) );
			}
			//Retira o ultimo &
			strParameters = strParameters.substring(0,strParameters.length()-1);
		}	
		
		return strParameters;
		*/
	
	}
	
	public byte[] getResponse(){
		return response;
	}

	public int getResponseCode(){
		return responseCode;
	}
	
	public String getResponseMessage(){
		return responseMessage;
	}
	
	public Displayable getCaller(){
		return caller;
	}
	
	public void setCaller(Displayable caller){
		this.caller = caller;
	}
	
	public void unload(){
		url = null;
		parameters = null;
		requestMethod = null;
		headers = null;
		response = null;
		responseMessage = null;
		caller = null;
		System.gc();		
	}

	private void log(String texto) {
		if (logEnabled)
			Log.getInstance().log(texto);
	}
	
}