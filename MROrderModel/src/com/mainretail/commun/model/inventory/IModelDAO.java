package com.mainretail.commun.model.inventory;

import java.util.List;

import com.mainretail.commun.model.IParentDAO;

public interface IModelDAO extends IParentDAO {
	public List list(Category C);
	
	public Model getModel(int idmodel);
	
}
