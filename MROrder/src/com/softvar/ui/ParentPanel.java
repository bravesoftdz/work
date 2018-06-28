package com.softvar.ui;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JPanel;

import com.softvar.controller.ApplicationManager;
import com.softvar.controller.MRPanel;
import com.softvar.controller.NavigationManager;


public class ParentPanel extends javax.swing.JPanel  implements ActionListener, MRPanel {	
	private static final long serialVersionUID = -5544237650494577706L;
	
	private JPanel jpnClient;
	//private MRPanel caller;
	private ApplicationManager appManager;
	private NavigationManager navManager;
	
	public ParentPanel(ApplicationManager appManager, NavigationManager navManager) {
		super();
		this.appManager = appManager;
		this.navManager = navManager;
		initGUI();
	}

	public ParentPanel() {
		super();
		initGUI();
	}
	
	public void initGUI() {
		try {
			setPreferredSize(new Dimension(400, 300));
			this.setBackground(Color.white);
			{
				BorderLayout jpnCenterLayout = new BorderLayout();
				setLayout(jpnCenterLayout);
				
				{
					add(getJpnClient(), BorderLayout.CENTER);					
					BorderLayout jpnClientLayout = new BorderLayout();					
					
					getJpnClient().setLayout(jpnClientLayout);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public JPanel getJpnClient() {
		if (jpnClient == null){
			jpnClient = new JPanel();
			jpnClient.setBackground(this.getBackground());
		}
		return jpnClient;
	}

	public void actionPerformed(ActionEvent evt) {
		onActionPerformed(evt);		
	}
	
	public void onActionPerformed(ActionEvent evt){
		
	}
	
	public void quit(){
		appManager.panelClosed(this);
		appManager = null;
		navManager = null;
		
	}
	

	public NavigationManager getNavManager() {
		return navManager;
	}

	public void setNavManager(NavigationManager navManager) {
		this.navManager = navManager;
	}

	public ApplicationManager getAppManager() {
		return appManager;
	}

	public void setAppManager(ApplicationManager appManager) {
		this.appManager = appManager;
	}


}
