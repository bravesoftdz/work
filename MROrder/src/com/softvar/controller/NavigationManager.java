package com.softvar.controller;


public interface NavigationManager {
	
	public MRPanel getCurrent();
	
	public MRPanel getPrevious();
	
	public void removeMRPanelComponent(MRPanel comp);

	public void addMRPanelComponent(MRPanel comp);
}
