package com.mainretail.handheldserver.purchaseservlet;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;
import java.util.Hashtable;

import com.mainretail.handheld.Model;
import com.mainretail.handheld.Pessoa;
import com.mainretail.handheld.purchase.PO;
import com.mainretail.handheldserver.util.*;

public class POEEDAOMSSQL implements POEEDAO {
	
	private static POEEDAOMSSQL instance;
	private POEEDAOMSSQL() {}
	
	public static POEEDAOMSSQL getInstance()
	{
		if (instance == null)
		{
			instance = new POEEDAOMSSQL(); 
		}
		return instance;		
	}

	public PO getPo(int idpo) throws SQLException {
		
		PO po = new PO();
		
		String sql = " SELECT P.IDPO, P.IDFornecedor, P.IDStore, P.DataPedido, P.Aberto, P.Freight, P.Charges, P.SubTotal, " + 
 					 " P.Atendido, P.PaymenteType, P.EstArrival, P.PayDays, P.OBS, V.UserCode " +
  					 " FROM PO P JOIN Pessoa V ON (P.IDFornecedor = V.IDPessoa)" +
					 " WHERE IDPO = '" + idpo + "'";	
	
		Connection con = null;
		ResultSet rs = null;
		Statement stmt = null;
		
		try {
			con = ConnectionFunctions.getInstance().getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				Pessoa vendor = new Pessoa();
				po.vendor = vendor;
				load(rs, po);
			}
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(rs, stmt, con);	
		}		
		return po;
	}
	
	private PO load(ResultSet rs, PO po) throws SQLException 
	{
		po.idpo            = rs.getInt("IDPO");
		po.vendor.idpessoa = rs.getInt("IDFornecedor");
		po.vendor.usercode = rs.getString("UserCode");
		po.idstore         = rs.getInt("IDStore");
		po.paydays         = rs.getInt("PayDays");
		po.obs             = rs.getString("OBS");
		po.freight         = rs.getDouble("Freight");
		po.charges         = rs.getDouble("Charges");
		po.subtotal        = rs.getDouble("SubTotal");
		po.paymentetype    = rs.getDouble("PaymenteType");
		po.aberto          = rs.getBoolean("Aberto");
		po.atendido        = rs.getBoolean("Atendido");
		po.datapedido      = rs.getDate("DataPedido");
		po.estarrival      = rs.getDate("EstArrival");
		
		return po;	
	}

	public boolean save(PO po) throws SQLException {
		
		boolean result = false;
		
		if (po.vendor.idpessoa == 0) {
			po.vendor = getPessoa(po.vendor);
		}		
		
		if (po.vendor.idpessoa == 0) {
			po.idpo = -1;
		} else {
		
			po.idpo = SQLFunctions.getInstance().getNextCode("PO.IDPO");
					
			Hashtable ht = new Hashtable();
				
			ht.put("idpo",new Integer(po.idpo));
			ht.put("idfornecedor",new Integer(po.vendor.idpessoa));
			ht.put("idstore",new Integer(po.idstore));
			ht.put("paydays",new Integer(po.paydays));
			
			if (po.obs != null) {
				ht.put("obs", new String(po.obs));
			}
			
			ht.put("freight", new Double(po.freight));
			ht.put("charges", new Double(po.charges));
			ht.put("subtotal", new Double(po.subtotal));
			ht.put("paymentetype", new Double(po.paymentetype));
			
			po.aberto = true;
			po.atendido = false;
			
			ht.put("aberto", new Boolean(po.aberto));
			ht.put("atendido", new Boolean(po.atendido));
			
			po.datapedido = new Date();
			ht.put("datapedido", po.datapedido);
			
				
			if (po.estarrival != null) {
				ht.put("estarrival", po.estarrival);
			}
							
			String sql = SQLFunctions.getInstance().hashTableToSQLInsert("PO", ht); 
					
					
			Connection con = null;
			Statement stmt = null;
				
			try {
				con = ConnectionFunctions.getInstance().getConnection();
				stmt = con.createStatement();
				stmt.execute(sql);
				result = true;
			}
			finally {
				ConnectionFunctions.getInstance().closeConnection(null, stmt, con);	
			}
		}
		
		return result;
		
	}

	public boolean verifiesExistsModelPO(Model model) throws SQLException {
		
		int id = -1;
		boolean result = false;
		
		String sql = " SELECT ModelID " + 
		 			 " FROM PreInventoryMov JOIN PO ON (DocumentID = IDPO) " +
		 			 " WHERE Qty > QtyRealMov " +
		 			 " AND Aberto = 1 AND ModelID = '" + model.idmodel + "'";	

		Connection con = null;
		ResultSet rs = null;
		Statement stmt = null;
		
		try {
		con = ConnectionFunctions.getInstance().getConnection();
		stmt = con.createStatement();
		rs = stmt.executeQuery(sql);
		if (rs.next())
		{
			id = rs.getInt("ModelID");
		}
		}finally {
			ConnectionFunctions.getInstance().closeConnection(rs, stmt, con);	
		}
        
		if (id != -1) {
			result = true;
		}
		
		return result;
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
	
}