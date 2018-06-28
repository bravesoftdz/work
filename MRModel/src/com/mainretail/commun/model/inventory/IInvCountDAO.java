package com.mainretail.commun.model.inventory;

import com.mainretail.commun.model.IParentDAO;

public interface IInvCountDAO extends IParentDAO {
	public boolean countingExists(InvCount invCount);
	public InvCount getOpenCounting(int countType);
	public void deleteGarbageCount(InvCount invCount);
}
