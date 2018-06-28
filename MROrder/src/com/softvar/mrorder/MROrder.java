package com.softvar.mrorder;

import java.net.URL;
import java.util.Locale;

import sun.applet.AppletAudioClip;

import com.softvar.controller.RuntimeInfo;
import com.softvar.model.Customer;
import com.softvar.mrorder.controller.Config;
import com.softvar.mrorder.ui.MainForm;
import com.softvar.persistence.db4o.Connection;



public class MROrder {
    public static void main(String[] args) {
    	// Apenas se nao esta rodando em maquina de desenvolvimento
    	Locale currentLocale = Config.getInstance().getLocale();
    	
    	
    	
    	
    	if (currentLocale != null)
    		Locale.setDefault(Config.getInstance().getLocale());
    	
    	Customer customer = new Customer();
    	customer.idcustomer = Config.getInstance().getIDStore();
    	RuntimeInfo.getInstance().customer = customer;  

    	Connection.getInstance().configure(DB4OConfig.getInstace());
    	
    	
    	URL url = MROrder.class.getResource("/com/softvar/res/bet.wma");
    	
		AppletAudioClip clip = new sun.applet.AppletAudioClip(url);
		
		 clip.play();
		 

		 try {
			Thread.sleep(30000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}// sleepTime in millisec
		 clip.stop();
    	
       	MainForm inst = new MainForm();
	    inst.setVisible(true);
    }
}