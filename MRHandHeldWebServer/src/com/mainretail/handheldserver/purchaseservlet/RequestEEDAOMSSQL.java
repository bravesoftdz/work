package com.mainretail.handheldserver.purchaseservlet;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;
import java.util.Hashtable;

import com.mainretail.handheld.purchase.Request;
import com.mainretail.handheldserver.util.ConnectionFunctions;
import com.mainretail.handheldserver.util.SQLFunctions;

public class RequestEEDAOMSSQL implements RequestEEDAO {
	
	private static RequestEEDAOMSSQL instance;
	private RequestEEDAOMSSQL() {}
	
	public static RequestEEDAOMSSQL getInstance()
	{
		if (instance == null)
		{
			instance = new RequestEEDAOMSSQL(); 
		}
		return instance;		
	}

	public boolean save(Request request) throws SQLException {
		
		boolean result = false;
		
		request.idrequest = SQLFunctions.getInstance().getNextCode("Request.IDRequest"); 
			
		Hashtable ht = new Hashtable();
		
		if (request.model.idmodel != 0) {
			ht.put("modelid", new Integer(request.model.idmodel));
			
			if ( request.model.description != null) {
				ht.put("description", new String(request.model.description));
			}
		} else {
			ht.put("description", new String(request.model.barcode));
		}
		
		ht.put("idrequest", new Integer(request.idrequest));
		ht.put("userid", new Integer(request.userid));
		ht.put("storeid", new Integer(request.storeid));
		
		
		// null
		//ht.put("idpreinventorymov", new Integer(request.idpreinventorymov));
		
		if (request.idcotacao != 0) {
			ht.put("idcotacao", new Integer(request.idcotacao));
		}
		
		request.type = "H";
		ht.put("type", new String(request.type));
		
		ht.put("qtyreq", new Double(request.qtyreq));
		ht.put("qtyordered", new Double(request.qtyordered));
		
		ht.put("cotado", new Boolean(request.cotado));
		
		request.daterequest = new Date();
		ht.put("daterequest", request.daterequest);
		
		
		// null
		/*if (request.delaydate != null) {
			ht.put("delaydate", request.delaydate);
		}*/	
		
		String sql = SQLFunctions.getInstance().hashTableToSQLInsert("Request", ht);
		
		Connection con = null;
		Statement stmt = null;
		
		try {
			con = ConnectionFunctions.getInstance().getConnection();
			stmt = con.createStatement();
			stmt.execute(sql);
			result = true;
		} finally {
			ConnectionFunctions.getInstance().closeConnection(null, stmt, con);	
		}
		return result;
	}
		
}
