package com.softvar.mrorder.ui;

import com.cloudgarden.layout.AnchorConstraint;
import com.cloudgarden.layout.AnchorLayout;
import com.softvar.controller.ApplicationManager;
import com.softvar.controller.NavigationManager;
import com.softvar.controller.SyncManager;
import com.softvar.controller.event.SynchEvent;
import com.softvar.controller.event.SynchListener;
import com.softvar.internationalization.LanguageResource;
import com.softvar.model.order.Account;
import com.softvar.model.order.Product;
import com.softvar.model.SyncInfo;
import com.softvar.model.ISyncInfoDAO;
import com.softvar.mrorder.controller.Config;
import com.softvar.persistence.DAOUtil;
import com.softvar.persistence.IParentDAO;
import com.softvar.synch.SynchHeader;
import com.softvar.ui.ParentFormOKClose;
import com.softvar.ui.SyncWaitForm;
import com.softvar.util.StringUtils;

import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Vector;
import javax.swing.BorderFactory;
import javax.swing.BoxLayout;
import javax.swing.JCheckBox;
import javax.swing.JPanel;
import javax.swing.JPopupMenu;
import javax.swing.JProgressBar;
import javax.swing.JTextArea;


import java.awt.BorderLayout;


public class SyncScreen extends ParentFormOKClose implements SynchListener {
	private static final long serialVersionUID = -7576324203934372649L;
	
	private static final String SERVLET_APPLICATION = "mrorder";
	
	private JCheckBox chkProducts;
	private JCheckBox chkVendor;
	private JProgressBar pbSybc;
	private JPanel jpnProgress;
	private JCheckBox chkSrvParam;
	private JCheckBox chkAccount;
	private JTextArea jtaResult;
	private JPanel jpnOption;
	private long duration;
	private JPopupMenu syncWait;

	public SyncScreen(ApplicationManager appManager, NavigationManager navManager){
		super(appManager, navManager);
	}

		
	public JCheckBox getChkProducts() {
		if (chkProducts == null){
			chkProducts = new JCheckBox();
			chkProducts.setOpaque(false);
		}
		return chkProducts;
	}
	
	public JCheckBox getChkAccount() {
		if (chkAccount == null){
			chkAccount = new JCheckBox();
			chkAccount.setOpaque(false);
		}
		return chkAccount;
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
			
			ISyncInfoDAO dao = ((ISyncInfoDAO) DAOUtil.getDAO(SyncInfo.class, IParentDAO.DATABASE_DB4O));
			
			BorderLayout jpnClientLayout = new BorderLayout();
			super.getJpnClient().setLayout(jpnClientLayout);			
			{
				super.getJpnClient().add(getJpnOption(), BorderLayout.NORTH);
				BoxLayout jpnOptionLayout = new BoxLayout(
						getJpnOption(),
						javax.swing.BoxLayout.Y_AXIS);
				getJpnOption().setLayout(jpnOptionLayout);
				{
					getJpnOption().add(getChkAccount());
					getChkAccount().setText(LanguageResource.getInstance().getText("ACCOUNTS") + 
							                (dao.getSyncInfData(Account.class.getName())).getFormatedDate());
				}
				{
					getJpnOption().add(getChkProducts());
					getChkProducts().setText(LanguageResource.getInstance().getText("PRODUCTS") + 
							(dao.getSyncInfData(Product.class.getName())).getFormatedDate());
				}
				{
//					getJpnOption().add(getChkSrvParam());
//					getChkSrvParam().setText(LanguageResource.getInstance().getText("SVR_PARAMETER"));
				}
				{
//					getJpnOption().add(getChkVendor());
//					getChkVendor().setText(LanguageResource.getInstance().getText("VENDOR"));

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
		
		//vector.add(AccountCost.class);
		
		if (getChkProducts().isSelected()){
			vector.add(Product.class);
		}
		
		if (getChkAccount().isSelected()){
			vector.add(Account.class);
		}
		
		if (getChkSrvParam().isSelected()){
			//vector.add(ServerParameter.class);
		}
		
		if (getChkVendor().isSelected()){
			//vector.add(Vendor.class);
		}
		
		
		if (vector.size() > 0){
			SynchHeader[] headers = new SynchHeader[vector.size()];
			for(int i = 0; i < vector.size(); i++){
				SynchHeader header = new SynchHeader();
				
				Class clazz = ((Class)vector.elementAt(i));
				
				header.objectClass = clazz.getName();
				
				
				header.synchDate = null;
				
				/*
				SyncInfo synchInfo = ((ISyncInfoDAO) DAOUtil.getDAO(SyncInfo.class, IParentDAO.DATABASE_DB4O)).getSyncInfData(clazz.getName());
				
				header.synchDate = synchInfo.syncDate;
				*/
				
				headers[i] = header;
			}
			try{
				getJtaResult().setText(LanguageResource.getInstance().getText("MSG_INFO_PLEASE_WAIT"));
				sync(headers);
			} finally{
				
			}
			
		}
	}

	private void sync(SynchHeader[] headers) {		
		SyncManager synch = new SyncManager();
		synch.setSynchListener(this);
		synch.setSynchHeaders(headers);
		synch.setUrlPath(Config.getInstance().getHost());
		synch.setApplication(SERVLET_APPLICATION);
		duration = System.currentTimeMillis();
		getSyncWait().show(getJpnOption(), 70, 100);
		synch.start();		
	}

	public void update(SynchEvent event, Object data) {
		try{
			switch (event.getEventType()){
			case SynchEvent.EVT_INITIALIZATION:{
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
				getSyncWait().setVisible(false);
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
				getJtaResult().setText(LanguageResource.getInstance().getText("MSG_INFO_INDEXING")+ " " + StringUtils.UnqualifyName(((SynchHeader)data).objectClass));
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
			
			case SynchEvent.EVT_CLASS_FINISHED:{
				Class clazz = Class.forName(((SynchHeader)data).objectClass);
				((ISyncInfoDAO) DAOUtil.getDAO(SyncInfo.class, IParentDAO.DATABASE_DB4O)).updateSyncDate(clazz.getName(), ((SynchHeader)data).synchDate);
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
	
	public JPopupMenu getSyncWait(){
		if (syncWait == null){
			syncWait = new JPopupMenu();
			SyncWaitForm syn = new SyncWaitForm(0);
			syncWait.add(syn);
			syncWait.pack();
		}
		return syncWait;
	}

}
