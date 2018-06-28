package com.mainretail.commun.controller;

import com.mainretail.commun.ui.MRPanel;

public interface NavigationManager {
	
	public MRPanel getCurrent();
	
	public MRPanel getPrevious();
	
	public void removeMRPanelComponent(MRPanel comp);

	public void addMRPanelComponent(MRPanel comp);
}
