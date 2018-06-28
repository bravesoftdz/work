package com.mainretail.handheldserver;

import java.sql.SQLException;

import com.mainretail.handheld.User;
 
public interface UserEEDAO {

	public User findUser(String pw)  throws SQLException;	
	
}
