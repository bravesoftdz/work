package com.mainretail.commun.model.sale;

import java.util.ArrayList;

import com.mainretail.commun.model.IParentDAO;

public interface ISaleDAO extends IParentDAO {
	public Sale getOpenSale();
	
	public ArrayList getFinalizedSales();
	
	public Sale get(Sale sale);
}
