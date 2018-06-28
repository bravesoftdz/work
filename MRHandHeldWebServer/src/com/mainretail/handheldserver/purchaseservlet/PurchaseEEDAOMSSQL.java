package com.mainretail.handheldserver.purchaseservlet;

import java.sql.*;
import java.util.Date;
import java.util.Hashtable;

import com.mainretail.handheld.purchase.Purchase;
import com.mainretail.handheld.Pessoa;
import com.mainretail.handheldserver.util.*;

public class PurchaseEEDAOMSSQL implements PurchaseEEDAO {
	private static final String DOCUMENTTYPE = "Packing Slip";
	
	private static PurchaseEEDAOMSSQL instance;
	private PurchaseEEDAOMSSQL() {}
	
	public static PurchaseEEDAOMSSQL getInstance(){
		if (instance == null)
		{
			instance = new PurchaseEEDAOMSSQL(); 
		}
		return instance;		
	}

	public int save(Purchase purchase) throws SQLException {
		
		if (purchase.vendor.idpessoa == 0) {
			purchase.vendor = getPessoa(purchase.vendor);
		}		
		
		if (purchase.vendor.idpessoa == 0) {
			purchase.idpurchase = -1;
		} else {
		
			purchase.idpurchase = SQLFunctions.getInstance().getNextCode("Pur_Purchase.IDPurchase");
			
			purchase.dateprereceiving = new Date();
						
			purchase.documenttype = DOCUMENTTYPE;
			
			Hashtable ht = new Hashtable();
			
			ht.put("idpurchase",new Integer(purchase.idpurchase));
			ht.put("idfornecedor",new Integer(purchase.vendor.idpessoa));
			ht.put("idstore",new Integer(purchase.idstore));
			ht.put("iduserprereceiving",new Integer(purchase.iduserprereceiving));
			
			if (purchase.idpo != 0) {
				ht.put("idpo",new Integer(purchase.idpo));
			} 		
			
			if (purchase.documenttype != null) {
				ht.put("documenttype", new String(purchase.documenttype));
			}
			
			if (purchase.documentnumber != null) {
				ht.put("documentnumber", new String(purchase.documentnumber));
			}
				
			ht.put("freight", new Double(purchase.freight));
			ht.put("othercharges", new Double(purchase.othercharges));
			ht.put("subtotal", new Double(purchase.subtotal));
			
			if (purchase.dateprereceiving != null) {
				ht.put("dateprereceiving", purchase.dateprereceiving);
			}
			
			if (purchase.documentdate != null) {
				ht.put("documentdate", purchase.documentdate);
			}
			
			if (purchase.documentduedate != null) {
				ht.put("documentduedate", purchase.documentduedate);
			}
					
			String sql = SQLFunctions.getInstance().hashTableToSQLInsert("Pur_Purchase", ht); 
				
				
			Connection con = null;
			Statement stmt = null;
			
			try {
				con = ConnectionFunctions.getInstance().getConnection();
				stmt = con.createStatement();
				stmt.execute(sql);
			}
			finally {
				ConnectionFunctions.getInstance().closeConnection(null, stmt, con);	
			}
		}
		
		return purchase.idpurchase;
	}
	
	private Pessoa getPessoa(Pessoa pessoa) throws SQLException {
	
		String sql = " SELECT IDPessoa, IDTipoPessoa, IDStore, IDEstado, IDRamoAtividade, " +
				     " IDUser, Code, Pessoa, CPF, CGC, Identidade, UserCode, CartMotorista " +
				     " FROM Pessoa " +
				     " WHERE UserCode = '" + pessoa.usercode + "'";	
		 
	
		Connection con = null;
		ResultSet rs = null;
		Statement stmt = null;
		
		try {
			con = ConnectionFunctions.getInstance().getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				pessoa.idpessoa = rs.getInt("IDPessoa");
				pessoa.idtipopessoa = rs.getInt("IDTipoPessoa");
				pessoa.idstore = rs.getInt("IDStore");
				pessoa.idestado = rs.getString("IDEstado");
				pessoa.idramoatividade = rs.getInt("IDRamoAtividade");
				pessoa.iduser = rs.getInt("IDUser");
				pessoa.code = rs.getInt("Code");
				pessoa.pessoa = rs.getString("Pessoa");
				pessoa.cpf = rs.getString("CPF");
				pessoa.cgc = rs.getString("CGC");
				pessoa.identidade = rs.getString("Identidade");
				pessoa.usercode = rs.getString("UserCode");
				pessoa.cartmotorista = rs.getString("CartMotorista");
				
			}
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(rs, stmt, con);	
		}		
		return pessoa;
	}

	public boolean runPurchaseDo(int idpurhase) throws SQLException {
		
		boolean result = false;
		Connection con = null;
		CallableStatement spPurchaseDo = null;
							
		try {
			con = ConnectionFunctions.getInstance().getConnection();
			spPurchaseDo = con.prepareCall("{call sp_Purchase_Do(?, ?, ?)}");	
			
			Timestamp today = SQLFunctions.getInstance().sqlNow();
			boolean taxincost = getTaxInCost();
			
			spPurchaseDo.setInt(1, idpurhase);	
			spPurchaseDo.setTimestamp(2, today);
			spPurchaseDo.setBoolean(3, taxincost);
						
			spPurchaseDo.execute();
			result = true;
						
		} finally {
			ConnectionFunctions.getInstance().closeConnection(null, spPurchaseDo, con);	
		}
		
		return result;
	}
	
	private boolean getTaxInCost() throws SQLException {
		
		boolean result = false;
		
		String sql = " SELECT SrvValue FROM Param WHERE IDParam = 66 ";	
		
		Connection con = null;
		ResultSet rs = null;
		Statement stmt = null;
		
		try {
			con = ConnectionFunctions.getInstance().getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				result = rs.getBoolean("SrvValue");
				
			}
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(rs, stmt, con);	
		}	
		
		return result;
	}

	public Purchase getPurchase(String field, String value)  throws SQLException {
		Purchase purchase = new Purchase();
		
		String sql = 			
			"SELECT" +
			"	PU.idpurchase," +
			"	PU.idstore," +
			"	PU.iduserprereceiving," +
			"	PU.idpo," +
			"	PU.documenttype," +
			"	PU.documentnumber," +
			"	PU.freight," +
			"	PU.othercharges," +
			"	PU.subtotal," +
			"	PU.dateprereceiving," +
			"	PU.documentdate," +
			"	PU.documentduedate," +
			"	PU.datefinalreceiving," +
			"	P.pessoa," +
			"	P.idtipopessoa," +
			"	P.idpessoa " +
			"FROM " +
			"	Pur_Purchase PU " +
			"	JOIN Pessoa P ON (P.IDPessoa = PU.IDFornecedor) " +
			"WHERE " +
				field + " = " + "'" + value + "'";
	
		Connection con = null;
		ResultSet rs = null;
		Statement stmt = null;
		
		try {
			con = ConnectionFunctions.getInstance().getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next())
			{
				Pessoa vendor = new Pessoa();
				purchase.vendor = vendor;
				load(rs, purchase);
			}
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(rs, stmt, con);	
		}		
		return purchase;
	}
	
	private Purchase load(ResultSet rs, Purchase purchase) throws SQLException 
	{
		purchase.idpurchase = rs.getInt("idpurchase");
		purchase.idstore = rs.getInt("idstore");
		purchase.iduserprereceiving = rs.getInt("iduserprereceiving");
		purchase.idpo = rs.getInt("idpo");
		purchase.documenttype = rs.getString("documenttype");
		purchase.documentnumber = rs.getString("documentnumber");
		purchase.freight = rs.getInt("freight");
		purchase.othercharges = rs.getInt("othercharges");
		purchase.subtotal = rs.getInt("subtotal");
		purchase.dateprereceiving = rs.getDate("dateprereceiving");
		purchase.documentdate = rs.getDate("documentdate");
		purchase.documentduedate = rs.getDate("documentduedate");
		purchase.datefinalreceiving = rs.getDate("datefinalreceiving");
		purchase.vendor.idpessoa = rs.getInt("idpessoa");
		purchase.vendor.pessoa = rs.getString("pessoa");
		purchase.vendor.idtipopessoa = rs.getInt("idtipopessoa");
		
		return purchase;	
	}
		
}
