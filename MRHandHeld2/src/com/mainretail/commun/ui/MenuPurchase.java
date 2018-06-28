package com.mainretail.commun.ui;

import java.awt.BorderLayout;
import java.awt.FlowLayout;
import java.awt.event.ActionEvent;

import javax.swing.JButton;
import javax.swing.JPanel;

import com.mainretail.MRIcon;
import com.mainretail.commun.controller.LanguageResource;
import com.mainretail.commun.controller.NavigationManager;
import com.mainretail.purchase.ui.POScreenFch;
import com.mainretail.purchase.ui.ReceivingScreenFch;
import com.mainretail.purchase.ui.VerifyReceivingScreenFch;

public class MenuPurchase extends ParentPanel {
	private static final long serialVersionUID = -3263728219503488708L;
	static MRIcon mrIcon;
	private JButton jbtReceiving;
	private JButton jbtClose;
	private JButton jbtPurchaseOrder;
	private JButton jbtVerifyReceive;
	private JPanel jpnIcons;
	
	

	public MenuPurchase(ApplicationManager appManager, NavigationManager navManager){
		super(appManager, navManager);
	}


	public MenuPurchase() {
		super();
	}	
	
	
	public void initGUI() {
		try {
			{
				this.setSize(628, 180);
			}

			super.initGUI();
			{
				
				getJpnClient().add(getJpnIcons(), BorderLayout.CENTER);
				FlowLayout jpnIconsLayout = new FlowLayout();
				jpnIconsLayout.setHgap(5);
				jpnIconsLayout.setVgap(5);
				getJpnIcons().setLayout(jpnIconsLayout);
				getJpnIcons().setPreferredSize(new java.awt.Dimension(531, 134));
				//jpnIcons.setBackground(new java.awt.Color(255,255,255));
				{
					getJpnIcons().add(getJbtReceiving());
					
					getJbtReceiving().setPreferredSize(new java.awt.Dimension(80, 80));
					getJbtReceiving().addActionListener(this);
				}
				{
					getJbtVerifyReceive().setPreferredSize(new java.awt.Dimension(80, 80));
					getJpnIcons().add(getJbtVerifyReceive());
					getJbtVerifyReceive().addActionListener(this);
				}
				{
					getJbtPurchaseOrder().setPreferredSize(new java.awt.Dimension(80, 80));
					getJpnIcons().add(getJbtPurchaseOrder());
					getJbtPurchaseOrder().addActionListener(this);
				}
				{
					getJbtClose().setPreferredSize(new java.awt.Dimension(80, 80));
					getJpnIcons().add(getJbtClose());
					getJbtClose().addActionListener(this);
				}

			}
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public JPanel getJpnIcons() {
		if (jpnIcons == null){
			jpnIcons = new JPanel();
			jpnIcons.setBackground(this.getBackground());
		}
		return jpnIcons;
	}
	
	public MRIcon getMRIcon(){
		if (mrIcon == null)
			mrIcon = new MRIcon();
		return mrIcon;
	}
	public JButton getJbtPurchaseOrder() {
		if (jbtPurchaseOrder == null)
			jbtPurchaseOrder = MRIcon.createButton(LanguageResource.getInstance().getText("PO"),"po");
		return jbtPurchaseOrder;
	}


	public JButton getJbtReceiving() {
		if (jbtReceiving == null)	
			jbtReceiving = MRIcon.createButton(LanguageResource.getInstance().getText("RECEIVING"),"receiving");
		return jbtReceiving;
	}
	

	public JButton getJbtVerifyReceive() {
		if (jbtVerifyReceive == null)
			jbtVerifyReceive = MRIcon.createButton(LanguageResource.getInstance().getText("VERIFY_RECEIVING"),"verifyreceiving");			
		return jbtVerifyReceive;
	}

	public JButton getJbtClose() {
		if (jbtClose == null) {
			jbtClose = MRIcon.createButton(LanguageResource.getInstance().getText("BACK"),"back");
		}
		return jbtClose;
	}
	
	public void onActionPerformed(ActionEvent evt) {
		if (evt.getSource() == getJbtReceiving()){
			getNavManager().addMRPanelComponent(new ReceivingScreenFch(getAppManager(), getNavManager()));			
		} else if (evt.getSource() == getJbtVerifyReceive()) {
			getNavManager().addMRPanelComponent(new VerifyReceivingScreenFch(getAppManager(), getNavManager()));
		} else if (evt.getSource() == getJbtPurchaseOrder()) {
			getNavManager().addMRPanelComponent(new POScreenFch(getAppManager(), getNavManager()));
		} else if (evt.getSource() == getJbtClose()) {
			quit();
		}
	}
}
