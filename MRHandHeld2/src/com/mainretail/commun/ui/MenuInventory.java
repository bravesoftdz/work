package com.mainretail.commun.ui;

import java.awt.BorderLayout;
import java.awt.FlowLayout;
import java.awt.event.ActionEvent;
import java.io.EOFException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

import javax.swing.JButton;
import javax.swing.JPanel;

import com.mainretail.MRIcon;
import com.mainretail.commun.controller.ConnectionManager;
import com.mainretail.commun.controller.LanguageResource;
import com.mainretail.commun.controller.NavigationManager;
import com.mainretail.commun.event.ConnectionManagerListener;
import com.mainretail.commun.model.Config;
import com.mainretail.commun.model.inventory.InvCount;
import com.mainretail.inventory.ui.BarcodePrintListFch;
import com.mainretail.inventory.ui.CountingScreenFch;


public class MenuInventory extends ParentPanel implements ConnectionManagerListener{
	private static final long serialVersionUID = 1L;
	
	private static final String FIND_COUNT_SERVLET = "countingfindservlet";
	static MRIcon mrIcon;
	
	private JButton jbtCycleCount;
	private JButton jbtPhysicalCount;
	private JButton jbtLiveCount;
	private JButton jbtStartUpCount;
	private JButton jbtBarcodeQueu;
	private JButton jbtClose;
	
	private JPanel jpnIcons;
	
	private int countType;

	public MenuInventory(ApplicationManager appManager, NavigationManager navManager){
		super(appManager, navManager);
	}


	public MenuInventory() {
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
					getJpnIcons().add(getJbtCycleCount());
					
					getJbtCycleCount().setPreferredSize(new java.awt.Dimension(80, 80));
					getJbtCycleCount().addActionListener(this);
				}
				{
					getJbtPhysicalCount().setPreferredSize(new java.awt.Dimension(80, 80));
					getJpnIcons().add(getJbtPhysicalCount());
					getJbtPhysicalCount().addActionListener(this);
				}
				{
					getJbtLiveCount().setPreferredSize(new java.awt.Dimension(80, 80));
					getJpnIcons().add(getJbtLiveCount());
					getJbtLiveCount().addActionListener(this);
				}
				
				{
					getJbtStartUpCount().setPreferredSize(new java.awt.Dimension(80, 80));
					getJpnIcons().add(getJbtStartUpCount());
					getJbtStartUpCount().addActionListener(this);
				}
				{
					getJbtBarcodeQueu().setPreferredSize(new java.awt.Dimension(80, 80));
					getJpnIcons().add(getJbtBarcodeQueu());
					getJbtBarcodeQueu().addActionListener(this);
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
	public JButton getJbtLiveCount() {
		if (jbtLiveCount == null)
			jbtLiveCount = MRIcon.createButton(LanguageResource.getInstance().getText("LIVECOUNT"),"livecount");
		return jbtLiveCount;
	}


	public JButton getJbtBarcodeQueu() {
		if (jbtBarcodeQueu == null)	
			jbtBarcodeQueu = MRIcon.createButton(LanguageResource.getInstance().getText("BARCODEQUEU"), "barcode_queu");
		return jbtBarcodeQueu;
	}
		
	
	public JButton getJbtCycleCount() {
		if (jbtCycleCount == null)	
			jbtCycleCount = MRIcon.createButton(LanguageResource.getInstance().getText("CYCLECOUNT"), "cyclecount");
		return jbtCycleCount;
	}
	

	public JButton getJbtPhysicalCount() {
		if (jbtPhysicalCount == null)
			jbtPhysicalCount = MRIcon.createButton(LanguageResource.getInstance().getText("PHYSICALCOUNT"), "physicalcount");			
		return jbtPhysicalCount;
	}
	
	public JButton getJbtStartUpCount() {
		if (jbtStartUpCount == null)
			jbtStartUpCount = MRIcon.createButton(LanguageResource.getInstance().getText("STARTUPCOUNT"), "startupcount");			
		return jbtStartUpCount;
	}

	public JButton getJbtClose() {
		if (jbtClose == null) {
			jbtClose = MRIcon.createButton(LanguageResource.getInstance().getText("BACK"), "back");
		}
		return jbtClose;
	}
	
	public void onActionPerformed(ActionEvent evt) {
		if (evt.getSource() == getJbtCycleCount()){
			searchCount(InvCount.INV_COUNT_CYCLE);
		} else if (evt.getSource() == getJbtPhysicalCount()) {
			searchCount(InvCount.INV_COUNT_PHYSICAL);
		} else if (evt.getSource() == getJbtLiveCount()) {
			searchCount(InvCount.INV_COUNT_LIVE);
		} else if (evt.getSource() == getJbtStartUpCount()) {
			searchCount(InvCount.INV_COUNT_STARTUP);
		} else if (evt.getSource() == getJbtBarcodeQueu()){
			getNavManager().addMRPanelComponent(new BarcodePrintListFch(getAppManager(), getNavManager()));
		}
		else if (evt.getSource() == getJbtClose()) {
			quit();
		}
	}
	
	
	private void searchCount(int countType){
		this.countType = countType;
		
		ConnectionManager manager = new ConnectionManager();
		manager.setUrlPath(Config.getInstance().getHost());
		manager.setServlet(FIND_COUNT_SERVLET);
		manager.setConnectionManagerListener(this);
		manager.send();
	}


	public void dataOutput(ObjectOutputStream oos) {
		InvCount invCount = new InvCount();
		invCount.counttype = countType;
		invCount.idstore = Config.getInstance().getIDStore();
		try {
			oos.writeObject(invCount);
		} catch (Exception e) {
			e.printStackTrace();
			MsgBox.errorMsg(this, e.getMessage());
		}

	}


	public void dataInput(ObjectInputStream ois) {
		try {
			try{
				Object o = ois.readObject();
				if (o instanceof InvCount) {
					getNavManager().addMRPanelComponent(new CountingScreenFch(getAppManager(), getNavManager(), (InvCount)o));			
				}
				
			} catch (EOFException e) {
			}
						
		} catch (Exception e) {
			e.printStackTrace();
			MsgBox.errorMsg(this, e.getMessage());
		}
		
	}


	public void httpError(int errorCode, String errorMsg) {
		MsgBox.errorMsg(this, errorCode + " " + errorMsg);
		
	}


	public void connectionException(Exception e) {
		e.printStackTrace();
		MsgBox.errorMsg(this, e.getMessage());		
	}



}
