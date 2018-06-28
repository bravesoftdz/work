package com.softvar.persistence.jdbc;

import java.sql.Connection;
import java.sql.SQLException;

public interface INextCodeDAO {
	public int getNextCode(Connection con, Class clazz) throws SQLException ;
}
