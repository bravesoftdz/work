package com.mainretail.handheldserver.purchaseservlet;

import java.sql.SQLException;

import com.mainretail.handheld.Model;
import com.mainretail.handheld.purchase.PO;

public interface POEEDAO {
	
	public PO getPo(int idpo) throws SQLException;
	public boolean save(PO po) throws SQLException;
	public boolean verifiesExistsModelPO(Model model) throws SQLException; 

}