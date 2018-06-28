package com.mainretail.commun.ui;

import com.cloudgarden.layout.AnchorConstraint;
import com.cloudgarden.layout.AnchorLayout;

import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Vector;
import javax.swing.BorderFactory;
import javax.swing.BoxLayout;
import javax.swing.JCheckBox;
import javax.swing.JPanel;
import javax.swing.JProgressBar;
import javax.swing.JTextArea;

import com.mainretail.commun.controller.LanguageResource;
import com.mainretail.commun.controller.NavigationManager;
import com.mainretail.commun.controller.SyncManager;
import com.mainretail.commun.model.Config;
import com.mainretail.commun.model.ServerParameter;
import com.mainretail.commun.model.User;
import com.mainretail.commun.model.Vendor;
import com.mainretail.commun.model.inventory.Barcode;
import com.mainretail.commun.model.inventory.Category;
import com.mainretail.commun.model.inventory.Model;
import com.mainretail.commun.synch.SynchHeader;
import java.awt.BorderLayout;


public class SyncScreen extends ParentFormOKClose implements SynchListener {
	private static final long serialVersionUID = -7576324203934372649L;
	private JCheckBox chkUser;
	private JCheckBox chkVendor;
	private JProgressBar pbSybc;
	private JPanel jpnProgress;
	private JCheckBox chkSrvParam;
	private JCheckBox chkInventory;
	private JTextArea jtaResult;
	private JPanel jpnOption;
	private long duration;

	public SyncScreen(ApplicationManager appManager, NavigationManager navManager){
		super(appManager, navManager);
	}

		
	public JCheckBox getChkUser() {
		if (chkUser == null){
			chkUser = new JCheckBox();
			chkUser.setOpaque(false);
		}
		return chkUser;
	}
	
	public JCheckBox getChkInventory() {
		if (chkInventory == null){
			chkInventory = new JCheckBox();
			chkInventory.setOpaque(false);
		}
		return chkInventory;
	}
	
	public JCheckBox getChkSrvParam() {
		if (chkSrvParam == null){
			chkSrvParam = new JCheckBox();
			chkSrvParam.setOpaque(false);
		}
		return chkSrvParam;
	}
	
	public JCheckBox getChkVendor() {
		if (chkVendor == null) {
			chkVendor = new JCheckBox();
			chkVendor.setOpaque(false);
		}
		return chkVendor;
	}
	
	public void initGUI() {
		try {
			setSize(400, 300);
			super.initGUI();
			
			BorderLayout jpnClientLayout = new BorderLayout();
			super.getJpnClient().setLayout(jpnClientLayout);			
			{
				super.getJpnClient().add(getJpnOption(), BorderLayout.NORTH);
				BoxLayout jpnOptionLayout = new BoxLayout(
						getJpnOption(),
						javax.swing.BoxLayout.Y_AXIS);
				getJpnOption().setLayout(jpnOptionLayout);
				{
					getJpnOption().add(getChkInventory());
					getChkInventory().setText(LanguageResource.getInstance().getText("INVENTORY"));
				}
				{
					getJpnOption().add(getChkUser());
					getChkUser().setText(LanguageResource.getInstance().getText("USER"));
				}
				{
					getJpnOption().add(getChkSrvParam());
					getChkSrvParam().setText(LanguageResource.getInstance().getText("SVR_PARAMETER"));
				}
				{
					getJpnOption().add(getChkVendor());
					getChkVendor().setText(LanguageResource.getInstance().getText("VENDOR"));

				}

				super.getJpnClient().add(getJpnProgress(), BorderLayout.CENTER);
				AnchorLayout jpnProgressLayout = new AnchorLayout();
				
				getJpnProgress().setLayout(jpnProgressLayout);
				getJpnProgress().setPreferredSize(new java.awt.Dimension(250,50));
				
				{
					getJpnProgress().add(getPbSync(), new AnchorConstraint(66, 946, 227, 53, AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_NONE, AnchorConstraint.ANCHOR_REL));
					getPbSync().setPreferredSize(new java.awt.Dimension(357, 14));
					getPbSync().setVisible(false);
				}
				{
					getJpnProgress().add(getJtaResult(), new AnchorConstraint(264, 22, 455, 53, AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_ABS, AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL));
					getJtaResult().setText(LanguageResource.getInstance().getText("MSG_INFO_SELECT_ITENS"));
					getJtaResult().setPreferredSize(new java.awt.Dimension(357, 45));
					getJtaResult().setDoubleBuffered(true);
					getJtaResult().setBorder(BorderFactory.createEmptyBorder(0,0,0,0));
					getJtaResult().setEditable(false);
					getJtaResult().setLineWrap(true);
					getJtaResult().setRows(3);
					getJtaResult().setOpaque(false);
				}
			
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void onClickJbtOK() {
		Vector vector = new Vector();
		
		if (getChkUser().isSelected()){
			vector.add(User.class);
		}
		
		if (getChkInventory().isSelected()){
			vector.add(Category.class);
			vector.add(Model.class);
			vector.add(Barcode.class);
		}
		
		if (getChkSrvParam().isSelected()){
			vector.add(ServerParameter.class);
		}
		
		if (getChkVendor().isSelected()){
			vector.add(Vendor.class);
		}
		
		
		if (vector.size() > 0){
			Class[] classes = new Class[vector.size()];
			for(int i = 0; i < vector.size(); i++)
				classes[i] = (Class)vector.elementAt(i);
			try{
				getJtaResult().setText(LanguageResource.getInstance().getText("MSG_INFO_PLEASE_WAIT"));
				sync(classes);
			} finally{
				
			}
			
		}
	}

	private void sync(Class[] classes) {		
		SyncManager synch = new SyncManager();
		synch.setSynchListener(this);
		synch.setSynchClasses(classes);
		synch.setUrlPath(Config.getInstance().getHost());
		synch.start();		
	}

	public void update(SynchEvent event, Object data) {
		try{
			switch (event.getEventType()){
			case SynchEvent.EVT_INITIALIZATION:{
				duration = System.currentTimeMillis();
				getJtaResult().setText(LanguageResource.getInstance().getText("MSG_INFO_SYNCHRONIZING") + ((SynchHeader)data).objectClass);
				getPbSync().setValue(0);
				getPbSync().setMaximum(((SynchHeader)data).objectCount);
				getPbSync().setVisible(true);
				break;
			}
			case SynchEvent.EVT_POSITION:{
				getPbSync().setValue(getPbSync().getValue() + 1);
				break;
			}
			case SynchEvent.EVT_FINISH:{
				duration = System.currentTimeMillis() - duration;
				Date durationDate = new Date(duration);
				Format formatter = new SimpleDateFormat("mm:ss");
				getJtaResult().setText(LanguageResource.getInstance().getText("MSG_INFO_DATA_SYNCHRONIZED") + " " +
						               LanguageResource.getInstance().getText("DURATION") + 
						               ": ("+ (formatter.format(durationDate)) + ")");
				getPbSync().setVisible(false);
				break;
			}
			case SynchEvent.EVT_ERROR:{
				Object[] errorObject = (Object[])data;
				Integer errorCode = (Integer)errorObject[0];
				String errorMessage = (String)errorObject[1];
				getJtaResult().setText(LanguageResource.getInstance().getText("MSG_ERROR_CONNECTION") + ": " + errorCode + " - " + errorMessage);
				getPbSync().setVisible(false);
				break;
			}
			
			case SynchEvent.EVT_EXCEPTION:{
				Exception e = (Exception)data; 
				getJtaResult().setText(LanguageResource.getInstance().getText("MSG_ERROR_INTERNAL") + ": " + e.getMessage());
				getPbSync().setVisible(false);
				break;
			}
			
			case SynchEvent.EVT_HANDLE_DATA:{
				Class classe = (Class)data; 
				getJtaResult().setText(LanguageResource.getInstance().getText("MSG_INFO_INDEXING")+ " " + classe.getName());
				getPbSync().setVisible(false);
				break;
			}
			
			case SynchEvent.EVT_DEFRAG:{				 
				getJtaResult().setText(LanguageResource.getInstance().getText("MSG_INFO_DEFRAGMENTING"));
				getPbSync().setVisible(false);
				break;
			}
			
			case SynchEvent.EVT_REMOVE_BACKUP:{
				getJtaResult().setText(LanguageResource.getInstance().getText("MSG_INFO_REMOVING_BACKUP"));
				getPbSync().setVisible(false);
				break;
			}


			}
		}
		catch(Throwable t){
			t.printStackTrace();
		}
	}
	
	private JPanel getJpnProgress() {
		if (jpnProgress == null) {
			jpnProgress = new JPanel();
			jpnProgress.setBackground(this.getBackground());
		}
		return jpnProgress;
	}
	
	private JProgressBar getPbSync() {
		if (pbSybc == null) {
			pbSybc = new JProgressBar();
			pbSybc.setBackground(this.getBackground());
		}
		return pbSybc;
	}

	public JTextArea getJtaResult() {
		if (jtaResult == null){
			jtaResult = new JTextArea(); 
		}
		return jtaResult;
	}
	
	private JPanel getJpnOption() {
		if (jpnOption == null) {
			jpnOption = new JPanel();
			jpnOption.setBackground(this.getBackground());
		}
		return jpnOption;
	}
	

}
