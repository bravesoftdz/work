package com.mainretail.commun.model.inventory;

import java.util.List;

import com.db4o.ObjectSet;
import com.db4o.query.Query;
import com.mainretail.commun.model.Connection;
import com.mainretail.commun.model.DAOUtil;
import com.mainretail.commun.model.IParentDAO;
import com.mainretail.commun.model.IParentDAODB4O;
import com.mainretail.commun.model.IServerParameterDAO;
import com.mainretail.commun.model.ServerParameter;

public class BarcodeDAODB4O implements IBarcodeDAO, IParentDAODB4O {
	
	public List listAll() {
		Query query = Connection.getInstance().getDatabase().query();
		query.constrain(Barcode.class);
		query.descend("idbarcode").orderAscending();
		
		ObjectSet cont = query.execute();
		java.util.ArrayList lista = new java.util.ArrayList();
		lista.addAll(cont);
		return lista;
	}

	public boolean save(Object obj) {
		try{
			Connection.getInstance().getDatabase().set(obj);
			Connection.getInstance().getDatabase().ext().purge(obj);
			Connection.getInstance().getDatabase().deactivate(obj, 5);
		}catch(Throwable t){
			return false;
		}
		return true;
	}

	public boolean delete(Object obj) {
		try{
			Connection.getInstance().getDatabase().delete(obj);
			Connection.getInstance().getDatabase().ext().purge(obj);
		}catch(Throwable t){
			return false;
		}
		return true;
	}

	public Barcode getBarcode(String idbarcode) {
		
		Barcode barcode = null;
		
		IServerParameterDAO dao = (IServerParameterDAO)(DAOUtil.getDAO(ServerParameter.class, IParentDAO.DATABASE_DB4O));  
		
		barcode = subGetBarcode(idbarcode);
		
		if ((idbarcode.length() > 0) && (barcode == null)) {
			
			int barcodeType = ((Integer)dao.getParameterValue(IServerParameterDAO.PARAM_REMOVE_BARCODE_DIGIT)).intValue();
			
			int minBarcodeLength = ((Integer)dao.getParameterValue(IServerParameterDAO.PARAM_MIN_BARCODE_LENGTH)).intValue();
			
			if ((barcodeType != 0) && (idbarcode.length() >= minBarcodeLength))
				switch (barcodeType){
				case 1:{
					barcode = subGetBarcode(idbarcode.substring(1, idbarcode.length()));
					break;
				}
				case 2:{
					barcode = subGetBarcode(idbarcode.substring(0, idbarcode.length() - 1));
					break;
				}
				
				case 3:{
					barcode = subGetBarcode(idbarcode.substring(1, idbarcode.length() - 1));
					break;
				}
				} 
		}

		
		return barcode;
	}
	
	
	public Barcode subGetBarcode(String idbarcode) {
		Query query = Connection.getInstance().getDatabase().query();
		query.constrain(Barcode.class);
		query.descend("idbarcode").constrain(idbarcode);
		ObjectSet result = query.execute();
		
		if (result.isEmpty())
			return null;
		else
			return (Barcode) result.next();
	}

	public void activateIndexes() {
		Query query = Connection.getInstance().getDatabase().query();
		query.constrain(Barcode.class);
		query.descend("idbarcode").constrain("");
		query.execute();
	}
	
	public Barcode getBarcode(String idbarcode, int searchType) {
		
		Query query = Connection.getInstance().getDatabase().query();
		query.constrain(Barcode.class);
		query.descend("idbarcode").constrain(idbarcode);
		ObjectSet result = query.execute();
		
		if (result.isEmpty())
			return null;
		else
			return (Barcode)result.next();
	}

}
