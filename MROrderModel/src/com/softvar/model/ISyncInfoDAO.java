package com.softvar.model;

import java.util.Date;

public interface ISyncInfoDAO {
	public SyncInfo getSyncInfData(String className);
	public void updateSyncDate(String className, Date updateDate);
}
