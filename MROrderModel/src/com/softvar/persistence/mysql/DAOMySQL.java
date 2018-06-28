package com.softvar.persistence.mysql;

import java.util.List;

import com.softvar.persistence.jdbc.INextCodeDAO;

public abstract class DAOMySQL implements IParentDAOMySQL {


	public INextCodeDAO getNextCodeDAO(){
		return NextCodeDAOMySQL.getInstance();
	}

	public boolean delete(Object obj){
		return false;
	}

	public List listAll(){
		return null;
	};

	public abstract boolean save(Object obj);

}
