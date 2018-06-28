package com.softvar.mrorder.controller;

import java.awt.Component;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.Enumeration;
import java.util.Vector;

import com.softvar.controller.ConnectionManager;
import com.softvar.controller.event.ConnectionManagerListener;
import com.softvar.internationalization.LanguageResource;
import com.softvar.model.order.IOrderDAO;
import com.softvar.model.order.Order;
import com.softvar.mrorder.event.OrderSynchListener;
import com.softvar.persistence.DAOUtil;
import com.softvar.persistence.IParentDAO;
import com.softvar.ui.MsgBox;



public class OrderSynch implements ConnectionManagerListener{

	private static String ORDER_SERVLET = "orderservlet";
	private static String SERVLET_APPLICATION = "mrorder";
	private Component owner;
	private OrderSynchListener saleSynchListener;
	
	public OrderSynch(Component owner, OrderSynchListener saleSynchListener){
		this.owner = owner;
		this.saleSynchListener = saleSynchListener;
	}
	
	public Order[] getSynchOrders() {
		Order[] synchOrders;
		IOrderDAO dao = (IOrderDAO)(DAOUtil.getDAO(Order.class, IParentDAO.DATABASE_DB4O));
		Object[] o = dao.getFinalizedOrders().toArray();
		synchOrders = new Order[o.length];
		for (int i = 0; i < o.length; i++){
			synchOrders[i] = (Order)o[i];
		}
		
		return synchOrders;
	}
	
	public void sendOrders(){
		ConnectionManager manager = new ConnectionManager();
		manager.setUrlPath(Config.getInstance().getHost());
		manager.setServlet(ORDER_SERVLET);
		manager.setApplication(SERVLET_APPLICATION);
		manager.setConnectionManagerListener(this);
		manager.send();		
	}
	
	public void dataOutput(ObjectOutputStream oos) {
		try {
			oos.writeObject(getSynchOrders());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void dataInput(InputStream iis) {
		/*
 		TRATAR ESSA PORRA !!! 
	 	*/
		
		Vector vector = null;
		try {
			ObjectInputStream ois = new ObjectInputStream(iis);
			vector = (Vector) ois.readObject();
			ois.close();
			ois = null;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		IOrderDAO dao = (IOrderDAO)(DAOUtil.getDAO(Order.class, IParentDAO.DATABASE_DB4O));
		
		if (saleSynchListener != null)
			saleSynchListener.afterSynch(vector);
	
		for (Enumeration en = vector.elements(); en.hasMoreElements();){
			Order deleteSale = dao.get((Order)en.nextElement());
			((IParentDAO)dao).delete(deleteSale);
		}
		
	}

	public void httpError(int errorCode, String errorMsg) {
		MsgBox.errorMsg(owner, errorCode + " " + errorMsg);		
	}

	public void connectionException(Exception e) {
		MsgBox.infoMsg(owner, LanguageResource.getInstance().getText("MSG_INFO_DATA_SYNCHRONIZED") + "\n" + e.getMessage());
	}

	public void proccesData() {
		// TODO Auto-generated method stub
		
	}

}
