package com.softvar.model.order;

import java.util.List;

public interface IAccountCostDAO {
	public List listByAccount(Account account);
	public List listByAccounts(Account[] accounts);
	public AccountCost getAccountCost(int idaccount, int idproduct);
}
