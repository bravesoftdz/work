package com.softvar.mrorder.ui;

import java.awt.BorderLayout;
import java.awt.Component;
import java.awt.Dimension;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Vector;

import javax.swing.BorderFactory;
import javax.swing.JCheckBox;
import javax.swing.JList;
import javax.swing.JPanel;
import javax.swing.JProgressBar;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.ListCellRenderer;
import javax.swing.ListModel;
import javax.swing.event.ListDataListener;

import com.softvar.controller.ApplicationManager;
import com.softvar.controller.NavigationManager;
import com.softvar.controller.event.SynchEvent;
import com.softvar.controller.event.SynchListener;
import com.softvar.internationalization.LanguageResource;
import com.softvar.model.ISyncInfoDAO;
import com.softvar.model.SyncInfo;
import com.softvar.model.order.Account;
import com.softvar.mrorder.controller.AccountCostSynchManager;
import com.softvar.mrorder.controller.Config;
import com.softvar.persistence.DAOUtil;
import com.softvar.persistence.IParentDAO;
import com.softvar.synch.SynchHeader;
import com.softvar.ui.ParentFormOKClose;
import com.softvar.util.StringUtils;



public class AccountCostSynchScreen extends ParentFormOKClose implements SynchListener {
	private static final long serialVersionUID = 1L;
	
	private static final String SERVLET_APPLICATION = "mrorder";
	
	private JScrollPane jspAccountList;
	private JList accountList;
	private JProgressBar pbSync;
	private JPanel jpnProgress;
	private JTextArea jtaResult;
	private JPanel jpnInfo;
	private long duration;
	
	public AccountCostSynchScreen(ApplicationManager appManager, NavigationManager navManager){
		super(appManager, navManager);
	}
	
	public void initGUI() {
		setSize(400, 300);
		super.initGUI();
		BorderLayout jpnClientLayout = new BorderLayout();
		super.getJpnClient().setLayout(jpnClientLayout);
		{
			getJpnClient().add(getJspAccountList(), BorderLayout.CENTER);
			refreshList();
		}
		{
			getJpnClient().add(getJpnInfo(), BorderLayout.SOUTH);
		}
	}

	public JList getAccountList() {
		if (accountList == null){
			accountList = new JList(new CheckAccountCostModel(null));
			accountList.setCellRenderer(new CheckCellRenderer());
			accountList.addMouseListener(
					new MouseAdapter(){

						public void mouseClicked(MouseEvent arg0) {
							CheckModelItem checkModelItem = (CheckModelItem)accountList.getSelectedValue();
							checkModelItem.checked = !checkModelItem.checked;
							accountList.repaint();
						}
						
					}
			);
		} 
		return accountList;
	}
	
	public void refreshList(){
		List lista = DAOUtil.getDAO(Account.class, IParentDAO.DATABASE_DB4O).listAll();
		ISyncInfoDAO dao = ((ISyncInfoDAO) DAOUtil.getDAO(SyncInfo.class, IParentDAO.DATABASE_DB4O));
		
		ArrayList model = new ArrayList(); 
		for(int i = 0; i < lista.size(); i++){
			CheckModelItem o = new CheckModelItem();
			o.object = lista.get(i);
			o.checked = false;
			((Account)o.object).accountname = ((Account)o.object).accountname + 
				dao.getSyncInfData(((Account)o.object).accountnum).getFormatedDate();
			
			model.add(o);
		}
		
		getAccountList().setModel(new CheckAccountCostModel(model));
		
		
	}
	
	private void sync(Account[] accounts) {		
		AccountCostSynchManager synch = new AccountCostSynchManager();
		synch.setSynchListener(this);
		synch.setAccountObjects(accounts);
		synch.setUrlPath(Config.getInstance().getHost());
		synch.setApplication(SERVLET_APPLICATION);
		duration = System.currentTimeMillis();
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
				getJtaResult().setText(LanguageResource.getInstance().getText("MSG_INFO_INDEXING")+ " " + StringUtils.UnqualifyName(classe.getName()));
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
				((ISyncInfoDAO) DAOUtil.getDAO(clazz, IParentDAO.DATABASE_DB4O)).updateSyncDate(clazz.getName(), ((SynchHeader)data).synchDate);
				break;
			}

			}
		}
		catch(Throwable t){
			t.printStackTrace();
		}
		
	}

	public JPanel getJpnProgress() {
		if (jpnProgress == null) {
			jpnProgress = new JPanel();
			jpnProgress.setLayout(new BorderLayout());
			jpnProgress.add(getPbSync(), BorderLayout.CENTER);
			jpnProgress.setPreferredSize(new Dimension(10, 14));
			jpnProgress.setBackground(this.getBackground());
		}
		return jpnProgress;
	}


	public JScrollPane getJspAccountList() {
		if (jspAccountList == null) {
			jspAccountList = new JScrollPane(getAccountList());
		}
		return jspAccountList;
	}


	public JTextArea getJtaResult() {
		if (jtaResult == null){
			jtaResult = new JTextArea();
			
			jtaResult.setText(LanguageResource.getInstance().getText("MSG_INFO_SELECT_ITENS"));
			
			jtaResult.setPreferredSize(new java.awt.Dimension(10, 25));
			
			jtaResult.setDoubleBuffered(true);
			
			jtaResult.setBorder(BorderFactory.createEmptyBorder(0,0,0,0));
			
			jtaResult.setEditable(false);
			
			jtaResult.setLineWrap(true);
			
			//jtaResult.setRows(3);
			
			jtaResult.setOpaque(false);
			
			jtaResult.setBackground(this.getBackground());
		}
		return jtaResult;
	}


	public JProgressBar getPbSync() {
		if (pbSync == null) {
			pbSync = new JProgressBar();			
			pbSync.setBackground(this.getBackground());
		}
		return pbSync;
	}

	public JPanel getJpnInfo() {
		if (jpnInfo == null) {
			jpnInfo = new JPanel();
			jpnInfo.setLayout(new BorderLayout());
			jpnInfo.setBackground(this.getBackground());
			jpnInfo.setPreferredSize(new Dimension(10, 40));
			jpnInfo.add(getJpnProgress(), BorderLayout.NORTH);
			jpnInfo.add(getJtaResult(), BorderLayout.SOUTH);
		}
		return jpnInfo;
	}

	public void onClickJbtOK() {
		Vector vector = new Vector();
		for (int i = 0; i < getAccountList().getModel().getSize(); i++){
			CheckModelItem checkModelItem = (CheckModelItem) getAccountList().getModel().getElementAt(i);
			if (checkModelItem.checked)
			{
				vector.add((Account)(checkModelItem.object));				
			}
		}
		
		if (vector.size() == 0)
			return;
		
		Account[] accounts = new Account[vector.size()];
		
		for(int i = 0; i < vector.size(); i++)
			accounts[i] = (Account)vector.get(i);
		
		sync(accounts);
	}
	
}

class CheckCellRenderer extends JCheckBox implements ListCellRenderer {
	// This is the only method defined by ListCellRenderer.
	// We just reconfigure the JLabel each time we're called.
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public Component getListCellRendererComponent(
			JList list,
			Object value,            // value to display
			int index,               // cell index
			boolean isSelected,      // is the cell selected
			boolean cellHasFocus)    // the list and the cell have the focus
	{
		/*
		String s = value.toString();
		setText(s);
		*/        
		if (isSelected) {
			setBackground(list.getSelectionBackground());
			setForeground(list.getSelectionForeground());
		}
		else {
			setBackground(list.getBackground());
			setForeground(list.getForeground());
		}
		
		if (value instanceof CheckModelItem) {
			CheckModelItem checkModelItem = (CheckModelItem) value;
			setSelected(checkModelItem.checked);
			String s = ((Account)checkModelItem.object).accountname; 
			setText(s);
		}
			
		setEnabled(list.isEnabled());
		setFont(list.getFont());
		setOpaque(true);
		return this;		
	}
}

class CheckModelItem{
	public Object object;
	public boolean checked; 
}

class CheckAccountCostModel implements ListModel{
	List modelList;
	
	public CheckAccountCostModel(List modelList){
		setModelList(modelList);
	}

	public int getSize() {
		// TODO Auto-generated method stub
		if (modelList == null)
			return 0;
		else
			return modelList.size();
	}

	public Object getElementAt(int index) {
		// TODO Auto-generated method stub
		return modelList.get(index);
	}

	public void addListDataListener(ListDataListener l) {
		// TODO Auto-generated method stub
		
	}

	public void removeListDataListener(ListDataListener l) {
		// TODO Auto-generated method stub
		
	}

	public List getModelList() {
		return modelList;
	}

	public void setModelList(List modelList) {
		this.modelList = modelList;
	}
	
}
