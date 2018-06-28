package com.mainretail.sales.controller;

import java.awt.Component;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OptionalDataException;
import java.util.Enumeration;
import java.util.Vector;

import com.mainretail.commun.controller.ConnectionManager;
import com.mainretail.commun.controller.LanguageResource;
import com.mainretail.commun.event.ConnectionManagerListener;
import com.mainretail.commun.model.Config;
import com.mainretail.commun.model.DAOUtil;
import com.mainretail.commun.model.IParentDAO;
import com.mainretail.commun.model.sale.ISaleDAO;
import com.mainretail.commun.model.sale.Sale;
import com.mainretail.commun.ui.MsgBox;
import com.mainretail.sales.event.SaleSynchListener;

public class SaleSynch implements ConnectionManagerListener{

	private static String SALE_SERVLET = "saleservlet";
	private Component owner;
	private SaleSynchListener saleSynchListener;
	
	public SaleSynch(Component owner, SaleSynchListener saleSynchListener){
		this.owner = owner;
		this.saleSynchListener = saleSynchListener;
	}
	
	public Sale[] getSynchSales() {
		Sale[] synchSales;
		ISaleDAO dao = (ISaleDAO)(DAOUtil.getDAO(Sale.class, IParentDAO.DATABASE_DB4O));
		Object[] o = dao.getFinalizedSales().toArray();
		synchSales = new Sale[o.length];
		for (int i = 0; i < o.length; i++){
			synchSales[i] = (Sale)o[i];
		}
		
		return synchSales;
	}
	
	public void sendSales(){
		ConnectionManager manager = new ConnectionManager();
		manager.setUrlPath(Config.getInstance().getHost());
		manager.setServlet(SALE_SERVLET);
		manager.setConnectionManagerListener(this);
		manager.send();		
	}
	
	public void dataOutput(ObjectOutputStream oos) {
		try {
			oos.writeObject(getSynchSales());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void dataInput(ObjectInputStream ois) {
		/*
 		TRATAR ESSA PORRA !!! 
	 	*/
		
		Vector vector = null;
		try {
			vector = (Vector) ois.readObject();
		} catch (OptionalDataException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		ISaleDAO dao = (ISaleDAO)(DAOUtil.getDAO(Sale.class, IParentDAO.DATABASE_DB4O));
		
		if (saleSynchListener != null)
			saleSynchListener.afterSynch(vector);
	
		for (Enumeration en = vector.elements(); en.hasMoreElements();){
			Sale deleteSale = dao.get((Sale)en.nextElement());
			dao.delete(deleteSale);
		}
		
	}

	public void httpError(int errorCode, String errorMsg) {
		MsgBox.errorMsg(owner, errorCode + " " + errorMsg);		
	}

	public void connectionException(Exception e) {
		MsgBox.infoMsg(owner, LanguageResource.getInstance().getText("MSG_INFO_DATA_SYNCHRONIZED") + "\n" + e.getMessage());
	}

}
