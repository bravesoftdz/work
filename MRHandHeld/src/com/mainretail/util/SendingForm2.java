package com.mainretail.util;

import java.util.Timer;
import java.util.TimerTask;

import javax.microedition.lcdui.Command;
import javax.microedition.lcdui.CommandListener;
import javax.microedition.lcdui.Display;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.Form;
import javax.microedition.lcdui.Gauge;

public class SendingForm2 extends Form implements CommandListener {

	private Gauge ggSending;
	private Command cmStop;
	private Timer timerGauge;
	//private Display display;
	//private Displayable chamador;
	private Thread thread;
	private  HttpConnectionHC httpConnectionHC;
	private HttpEventListener httpEventListener;
	//private Display display;
	private Displayable chamador;
	
	
	public SendingForm2(Display display, Displayable chamador, HttpConnectionHC httpConnectionHC, HttpEventListener httpEventListener ) {
		super("tx/rx");
		//this.display = display;
		this.chamador = chamador;
		this.httpConnectionHC = httpConnectionHC;
		this.httpEventListener =  httpEventListener;
		
		httpConnectionHC.setCaller(this.chamador);
		
		cmStop = new Command("parar", Command.STOP, 1);
		ggSending = new Gauge("sending request...", false, 100, 1);
		
		addCommand(cmStop);
		append(ggSending);
		setCommandListener(this);	
	}

	 
    public void start()
    {
    	
		//Cria um timer para girar o Gauge
    	timerGauge = new Timer();
		timerGauge.scheduleAtFixedRate(new GaugeTimerTask(), 0, 50);
    	
    	//Cria uma Thread para envio
    	thread= new Thread(new Runnable() {
			public void run(){
				try {
					
									
					httpConnectionHC.send();
										
					if (timerGauge != null) {
					   timerGauge.cancel();
					   timerGauge = null;
					}
					
					httpEventListener.httpEvent(HttpEventListener.STATUS_CONCLUDED, httpConnectionHC, null);
					
				} catch (Throwable t) {
					
					if (timerGauge != null) {
						timerGauge.cancel();
						timerGauge = null;
					}
					
					httpEventListener.httpEvent(HttpEventListener.STATUS_ERROR, httpConnectionHC, t);
					
				}
				finally {
					httpConnectionHC = null;
				}
			
			}
		});
		thread.start();
	
    }
    
	
	
	public void commandAction(Command c, Displayable d) {

		if (c == cmStop) {
	   	
    		
			if (thread != null) {
				
				if (timerGauge != null)
				{
					timerGauge.cancel() ;
					timerGauge = null;
				}
				httpEventListener.httpEvent(HttpEventListener.STATUS_CANCELLED, httpConnectionHC, null);
				thread.interrupt();  //Só em midp 2.0
				//thread = null;
				System.gc();
			}
		}

	}

	
	
	
	
	
	public Thread getThread() {
		return thread;
	}
	
	public HttpConnectionHC getHttpConnectionHC() {
		return httpConnectionHC;
	}
	
	private class GaugeTimerTask extends TimerTask
	{
		private int value = 0;
		
		public void run()
		{
			if (thread != null && thread.isAlive())
			{
				value = ggSending.getValue() + 1;
				if (value > ggSending.getMaxValue())
				{ value = 0; }
				ggSending.setValue(value);
			}
		}
	
	}

}