package com.mainretail.commun.model;

public interface IUserDAO extends IParentDAO {
	
	public User validateUser(String pw);
	
}
