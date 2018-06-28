package com.softvar.persistence.jdbc;

import java.sql.Connection;
import java.sql.SQLException;

import com.softvar.persistence.IParentDAO;

public interface IParentDAOJDBC extends IParentDAO {
	public INextCodeDAO getNextCodeDAO();
	public void saveAsChield(Connection con, Object obj) throws SQLException;
	public boolean find(Connection con, Object object, Object pk) throws SQLException;
}
