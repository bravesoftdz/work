package com.mainretail.util;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Timer;
import java.util.TimerTask;

import javax.microedition.io.Connector;
import javax.microedition.io.HttpConnection;
import javax.microedition.lcdui.Command;
import javax.microedition.lcdui.CommandListener;
import javax.microedition.lcdui.Display;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.Form;
import javax.microedition.lcdui.Gauge;

public class SendingForm extends Form implements CommandListener {

	private Gauge ggSending;
	private Command cmStop;
	private Display display;
	private Displayable caller;
	private Timer timerGauge;
	private String url;
	private String parameters;
	private String requestMethod;
	private byte[] reply;
	private Thread threadSending;
	private boolean cancelled = false;
	private int responseCode=0;
	private String responseMessage;
	//Gerencia a Session junto a um servlet
	private static String cookie;
	
	/* Construtor padrão
	 * 
	*/
	public SendingForm(Display display, Displayable caller) {
		super("TX/RX");
		this.display = display;
		this.caller = caller;
	
		cmStop = new Command("Stop", Command.STOP, 1);
		ggSending = new Gauge("Sending/Receiving data ...", false,100,1);
		
		addCommand(cmStop);
		append(ggSending);
		setCommandListener(this);
	
	}

	/**
	 * Inicia uma thread de envio/recepcao http
	 * @param url Url a ser conectada
	 * @param parametros Parametros a serem passados 
	 * @param requestMethod Método de requisicao 
	 */
    public void startThreadEnvio(String url,
			String parameters, String requestMethod)
    {
    	
    	//Seta os valores dos campos serem passados à thread
    	this.url = url;
    	this.parameters = parameters;
    	this.requestMethod = requestMethod;
    	
    	//Retorna os campos abaixo aos seus valores originais
    	cancelled = false;
    	reply = new byte[0];

    	timerGauge = new Timer();
		timerGauge.scheduleAtFixedRate(new GaugeTimerTask(),500,100 );

    	
    	//Cria uma Thread para envio
    	threadSending = new Thread(new Runnable() {
			public void run(){

				try {
					processarRequisicao();
					if (timerGauge!=null)
					{ 
						timerGauge.cancel() ;
					    timerGauge=null;
					}
					     
					
				} catch (Throwable e) {
					ErrorAlert.getInstance().showError(display, caller ,e);
				}
			
			}
		});
		threadSending.start();
	
    }
    
	/**
	 * Processa a requisição 
	 *
	 */
    private void processarRequisicao() {
		try {

			reply = enviarRequisicao(url, parameters, requestMethod);
			
		} catch (Throwable e) {
			e.printStackTrace();
			responseCode=-1;
			
			ErrorAlert.getInstance().showError(display, caller ,e);
		}

	}

	
	public void commandAction(Command c, Displayable d) {

		if (c == cmStop) {
			if (threadSending != null) {
				cancelled =true;
				
				//threadEnvio.interrupt();   //Disponivel somente em MIDP 2.0
				if (timerGauge!=null)
				{
					timerGauge.cancel() ;
					timerGauge=null;
				
				}
				ErrorAlert.getInstance().showError(display,caller,
						"Process stopped");
			}

		}

	}

	/**
	 * Envia uma requisição no protocolo http
	 * @param url Url a ser conectada
	 * @param tableParametros Parâmetros a serem enviados
	 * @param requestMethod O método de requisição 
	 * @return Um array de bytes contendo o resultado da requisição
	 * @throws IOException
	 */
	public byte[] enviarRequisicao(String url, String tableParameters,
			String requestMethod) throws IOException {
		HttpConnection http = null;
		OutputStream oStrm = null;
		InputStream iStrm = null;
		byte[] reply = null;
		/*String strParametros = "";
		if (tableParametros != null && tableParametros.size() >0) {
			//Converte o Hashtable em uma String de Parametros
			Enumeration keys = tableParametros.keys();
			while (keys.hasMoreElements() )
			{
				String key = (String) keys.nextElement() ;
				strParametros += key+"="+tableParametros.get(key) + "&";
			}
			//Retira o ultimo &
			strParametros = strParametros.substring(0,strParametros.length()-1);
		}
		//System.out.println(strParametros);*/
		try {
			
			//Se for get...
			if (requestMethod.equals(HttpConnection.GET))
			{
				//Abre a conexao com parametros
				http = (HttpConnection) Connector.open(url+"?"+tableParameters);
				
				setDefaultRequestProperties(http);
				
				http.setRequestMethod(HttpConnection.GET);
			}
			//Se for post...
			else if  (requestMethod.equals(HttpConnection.POST))
			{
				//Abre a conexao
				http = (HttpConnection) Connector.open(url);

				http.setRequestMethod(HttpConnection.POST);

				//Seta o header field, sem esse atributo o POST não funciona
				http.setRequestProperty("Content-Type",
						"application/x-www-form-urlencoded");
 
				/* Seta o tamanho dos dados a serem transmitidos, sem isso o POST nao funciona.
				* O valor de 15 bytes a mais é necessário quando o recebedor dos dados for um java 
				* Servlet, pois o processo interno de conversao de parametros conta com 15 bytes a 
				* mais relativos ao botão de SUBMIT de um formulario normal via Browser.   
				*/
				http.setRequestProperty("content-length",
				String.valueOf(tableParameters.length()+15));
		

				setDefaultRequestProperties(http);
				
				//Abre o OutputStream
				oStrm = http.openOutputStream();

				//Escreve os parametros no OutputStream
				oStrm.write(tableParameters.getBytes());
				oStrm.flush();
			}
			else
			{ 
				throw new IllegalArgumentException("Request method invalid");
			
			}
			
			
			
			//Obtem o resultado, se ok procede com a leitura da resposta
			responseCode = http.getResponseCode();
			responseMessage = http.getResponseMessage();

			//Controle de Session
			cookie = http.getHeaderField("cookie");
			
			if (responseCode == HttpConnection.HTTP_OK) {

				//Obtem os dados resultantes do processamento
				iStrm = http.openInputStream();
				int length = (int) http.getLength();
				if (length != -1) {
					reply = new byte[length];
					iStrm.read(reply);
					
				} else {
					ByteArrayOutputStream bStrm = new ByteArrayOutputStream();
					int ch;
					while ((ch = iStrm.read()) != -1) {
						bStrm.write(ch);
					}
					reply = bStrm.toByteArray();
					bStrm.close();
				}

			} else {

				throw new IOException(http.getResponseMessage());

			}

		} 
		//Efetua o fechamento
		finally {
			if (iStrm != null) {
				iStrm.close();
			}
			if (oStrm != null) {
				oStrm.close();
			}
			if (http != null) {
				http.close();
			}

		}

		return reply;
	}

	private void setDefaultRequestProperties(HttpConnection http) throws IOException {
		
		
		//Descomente a linha abaixo caso tenha problemas de conexao
		//http.setRequestProperty("Connection", "close");
		
		//Controle de Session
		if (cookie!=null)
		{
			http.setRequestProperty("cookie",cookie);
		}
		http.setRequestProperty("user-agent","MainRetail-J2ME");
	}


	public boolean isCancelado() {
		return cancelled;
	}
	
	public byte[] getResposta() {
		return reply;
	}
	
	public Thread getThreadEnvio() {
		return threadSending;
	}
	public int getResponseCode() {
		return responseCode;
	}
	
	private class GaugeTimerTask extends TimerTask
	{
		private int value=0;
		
		public void run()
		{
			if (threadSending.isAlive() && !cancelled)
			{
				value=ggSending.getValue()+1;
				if (value>ggSending.getMaxValue())
				{ value=0;}
				ggSending.setValue(value);
			}
		}
	
	}
	public String  getResponseMessage()
	{
		return responseMessage;
		
	}
	
	public void invalidateSession()
	{
		cookie=null;	
	}
	
}
