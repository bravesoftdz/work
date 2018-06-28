package com.mainretail.handheldserver;

import java.sql.SQLException;

import com.mainretail.handheld.ParameterList;

public interface ParameterListEEDAO {
	public ParameterList getParameterList() throws SQLException;
	public boolean save(ParameterList parameterList) throws SQLException;
}
