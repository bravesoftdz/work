package com.softvar.mrorder.ui;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.util.Locale;

import javax.swing.ComboBoxModel;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JComboBox;
import javax.swing.JLabel;
import javax.swing.JPopupMenu;
import javax.swing.JTextField;


import com.softvar.controller.ApplicationManager;
import com.softvar.controller.KeyboardManager;
import com.softvar.controller.NavigationManager;
import com.softvar.internationalization.LanguageResource;
import com.softvar.mrorder.controller.Config;
import com.softvar.ui.KeyboardPanel;
import com.softvar.ui.ParentFormOKClose;


public class ConfigurationScreen extends ParentFormOKClose implements KeyboardManager, MouseListener{
	private static final long serialVersionUID = -4698685165075642312L;
	public static final String version = "1.0 RC5"; 
	private JLabel lblVersion;
	private JLabel lblHost;
	private JTextField edtHost;
	private JLabel lblAccountNum;
	private JButton btnPopServer;
	private JCheckBox jcbAdminExit;
	private JComboBox jcbLanguage;
	private JTextField edtBarcodePrefix;
	private JLabel lblBarcodePrefix;
	private JTextField edtIDStore;
	private JLabel lblIDStore;
	private JTextField edtAccountNum;
	private JLabel lblIdiome;
	private JPopupMenu menu;
	private JTextField popUpController;
	private JLabel lblGridLines;
	private JTextField edtGridLines;
	
	public ConfigurationScreen(ApplicationManager appManager, NavigationManager navManager){
		super(appManager, navManager);
	}
	
	public ConfigurationScreen() {
		super();		
	}
	
	public void initGUI() {
		try {
			setSize(400, 300);
			super.initGUI();
			GridBagLayout jpnClientLayout = new GridBagLayout();
			jpnClientLayout.rowWeights = new double[] {0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1};
			jpnClientLayout.rowHeights = new int[] {20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20};
			jpnClientLayout.columnWeights = new double[] {0.1, 1.1, 0.1, 0.1};
			jpnClientLayout.columnWidths = new int[] {7, 7, 7, 7};
			super.getJpnClient().setLayout(jpnClientLayout);
			this.setPreferredSize(new java.awt.Dimension(400, 300));
			{
				super.getJpnClient().add(getLblHost(), getGridPos(0, 1, true));
				getLblHost().setText(LanguageResource.getInstance().getText("HOST"));
			}
			{
				super.getJpnClient().add(getEdtHost(), getGridPos(1, 1, false));
				getEdtHost().setPreferredSize(new java.awt.Dimension(231,20));
			}
			{
				super.getJpnClient().add(getLblIDStore(), getGridPos(0, 2, true));
				getLblIDStore().setText(LanguageResource.getInstance().getText("CUSTOMER_NUM"));
			}
			{
				super.getJpnClient().add(getEdtIDStore(), getGridPos(1, 2, false));
				getEdtIDStore().setPreferredSize(new java.awt.Dimension(231,20));
			}
			{
				super.getJpnClient().add(getLblBarcodePrefix(), getGridPos(0, 3, true));
				getLblBarcodePrefix().setText(LanguageResource.getInstance().getText("BARCODE_PREFIX"));
			}
			{
				super.getJpnClient().add(getEdtBarcodePrefix(), getGridPos(1, 3, false));
				getEdtBarcodePrefix().setPreferredSize(new java.awt.Dimension(231,20));
			}
			{
				super.getJpnClient().add(getLblIdiome(), getGridPos(0, 4, true));
				getLblIdiome().setText(LanguageResource.getInstance().getText("LANGUAGE"));
			}
			{
				super.getJpnClient().add(getJcbLanguage(), getGridPos(1, 4, false));
			}
			{
				super.getJpnClient().add(getJcbAdminExit(), getGridPos(1, 5, false));
			}
			{
				super.getJpnClient().add(getLblGridLines(), getGridPos(0, 6, true));
				getLblGridLines().setText(LanguageResource.getInstance().getText("GRID_NUM_LINES"));
			}
			{
				super.getJpnClient().add(getEdtGridLines(), getGridPos(1, 6, false));
				getEdtGridLines().setPreferredSize(new java.awt.Dimension(231,20));
			}
			{
				super.getJpnClient().add(getLblAccountNum(), getGridPos(0, 7, true));
				getLblAccountNum().setText(LanguageResource.getInstance().getText("ACCOUNT"));				
			}
			{
				super.getJpnClient().add(getEdtAccountNum(), getGridPos(1, 7, false));
				getEdtAccountNum().setPreferredSize(new java.awt.Dimension(231,20));				
			}
			{
				super.getJpnClient().add(getLblVersion(), getGridPos(0, 8, false));
			}
			fillValues();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public GridBagConstraints getGridPos(int x, int y, boolean isLabel){
		GridBagConstraints gridBagConstraint = new GridBagConstraints();
		
		if (isLabel){
			gridBagConstraint.fill = GridBagConstraints.NONE;
			gridBagConstraint.insets = new Insets(0, 0, 0, 8);
			gridBagConstraint.anchor = GridBagConstraints.EAST;
		}
		else{
			gridBagConstraint.fill = GridBagConstraints.HORIZONTAL;
			gridBagConstraint.insets = new Insets(0, 0, 0, 0);
			gridBagConstraint.anchor = GridBagConstraints.WEST;
			
		}
		gridBagConstraint.gridheight = 1;
		gridBagConstraint.gridwidth = 1;
		gridBagConstraint.gridx = x;
		gridBagConstraint.gridy = y;
		return gridBagConstraint;

	}
	
	private void fillValues(){
		Config.getInstance().load();
		
		Config cfg = Config.getInstance();
		
		getEdtHost().setText(cfg.getHost());
		getEdtAccountNum().setText(String.valueOf(cfg.getTransfSaleNum()));
		getEdtIDStore().setText(String.valueOf(cfg.getIDStore()));
		getEdtBarcodePrefix().setText(String.valueOf(cfg.getScannPrefix()));
		getJcbAdminExit().setSelected(cfg.getIsAdminExit());
		getEdtGridLines().setText(String.valueOf(cfg.getGridNumLines()));
		getEdtAccountNum().setText(cfg.getAccountNum());
		
		for(int i = 0; i < getJcbLanguage().getItemCount(); i++) 
			if (((LanguageInfo)(getJcbLanguage().getItemAt(i))).locale.equals(cfg.getLocale())){
				getJcbLanguage().setSelectedItem(getJcbLanguage().getItemAt(i));
				break;
			}
		
	}
	
	private void save(){
		Config.getInstance().setHost(getEdtHost().getText());
		Config.getInstance().setTransfSaleNum(Integer.parseInt(getEdtAccountNum().getText()));
		Config.getInstance().setIDStore(Integer.parseInt(getEdtIDStore().getText()));
		Config.getInstance().setScannPrefix(getEdtBarcodePrefix().getText());
		Config.getInstance().setLocale(((LanguageInfo)(getJcbLanguage().getSelectedItem())).locale);
		Config.getInstance().setAdminExit(getJcbAdminExit().isSelected());
		Config.getInstance().setGridNumLines(Integer.parseInt(getEdtGridLines().getText()));
		Config.getInstance().setAccountNum(getEdtAccountNum().getText());
		Config.getInstance().save();
	}

	public JTextField getEdtHost() {
		if (edtHost == null){
			edtHost = new JTextField();
			edtHost.addMouseListener(this);
		}
		return edtHost;
	}

	public JLabel getLblHost() {
		if (lblHost == null){
			lblHost = new JLabel();
		}
		return lblHost;
	}

	public JTextField getEdtGridLines() {
		if (edtGridLines == null){
			edtGridLines = new JTextField();
			edtGridLines.addMouseListener(this);
		}
		return edtGridLines;
	}

	public JLabel getLblGridLines() {
		if (lblGridLines == null){
			lblGridLines = new JLabel();
		}
		return lblGridLines;
	}

	public JLabel getLblAccountNum() {
		if (lblAccountNum == null)
			lblAccountNum = new JLabel();
		return lblAccountNum;
	}
	
	public JTextField getEdtAccountNum() {
		if (edtAccountNum == null){
			edtAccountNum = new JTextField();
			edtAccountNum.addMouseListener(this);
		}
		
		return edtAccountNum;
	}
	
	public void onClickJbtOK() {
		save();
		onClickJbtClose();
	}
	
	public JLabel getLblIDStore() {
		if (lblIDStore == null) {
			lblIDStore = new JLabel();
		}
		return lblIDStore;
	}
	
	public JTextField getEdtIDStore() {
		if (edtIDStore == null) {
			edtIDStore = new JTextField();
			edtIDStore.addMouseListener(this);
		}
		return edtIDStore;
	}
	
	public JLabel getLblBarcodePrefix() {
		if (lblBarcodePrefix == null) {
			lblBarcodePrefix = new JLabel();
		}
		return lblBarcodePrefix;
	}
	
	public JTextField getEdtBarcodePrefix() {
		if (edtBarcodePrefix == null) {
			edtBarcodePrefix = new JTextField();
			edtBarcodePrefix.addMouseListener(this);
		}
		return edtBarcodePrefix;
	}
	
	public JLabel getLblIdiome() {
		if (lblIdiome == null){
			lblIdiome = new JLabel();
		}
		return lblIdiome;
	}
	
	public JComboBox getJcbLanguage() {
		if (jcbLanguage == null) {
			ComboBoxModel jcbLanguageModel = new DefaultComboBoxModel(
				new Object[] { 
						new LanguageInfo("English", new Locale("en", "US")), 
						new LanguageInfo("Português", new Locale("pt", "BR")) 
				});
			jcbLanguage = new JComboBox();
			jcbLanguage.setModel(jcbLanguageModel);
			jcbLanguage.setBackground(this.getBackground());
			jcbLanguage.setOpaque(false);
		}
		return jcbLanguage;
	}
	
	public JCheckBox getJcbAdminExit() {
		if (jcbAdminExit == null) {
			jcbAdminExit = new JCheckBox();
			jcbAdminExit.setText(LanguageResource.getInstance().getText("ADM_CAN_EXIT"));
			jcbAdminExit.setBackground(this.getBackground());
		}
		return jcbAdminExit;
	}
	
	public JButton getBtnPopServer() {
		if (btnPopServer == null) {
			btnPopServer = new JButton();
			btnPopServer.setText("Abc..");
		}
		return btnPopServer;
	}

	public JPopupMenu getMenu() {
		if (menu == null){
			menu = new JPopupMenu();
			KeyboardPanel kbp = new KeyboardPanel(this, (KeyboardPanel.START_NUM | KeyboardPanel.START_ALP | KeyboardPanel.START_CHR));
			kbp.setSize(190, 100);

			menu.add(kbp);
			//menu.setSize(kbp.getSize());
			//menu.setMinimumSize(kbp.getSize());
			
			menu.pack();
		}
		return menu;
	}	
	public void mouseClicked(MouseEvent arg0) {
		// TODO Auto-generated method stub
		
	}

	public void mousePressed(MouseEvent arg0) {
		if (arg0.getComponent() ==  getEdtHost()){
			getMenu().show(getEdtHost(), 0, getEdtHost().getSize().height);
			popUpController = getEdtHost();
		}
		else if (arg0.getComponent() ==  getEdtIDStore()){
			getMenu().show(getEdtIDStore(), 0, getEdtIDStore().getSize().height);
			popUpController = getEdtIDStore();
		}
		else if (arg0.getComponent() == getEdtBarcodePrefix()){
			getMenu().show(getEdtBarcodePrefix(), 0, getEdtBarcodePrefix().getSize().height);
			popUpController = getEdtBarcodePrefix();
		} else if (arg0.getComponent() == getEdtGridLines()){
			getMenu().show(getEdtGridLines(), 0, getEdtGridLines().getSize().height);
			popUpController = getEdtGridLines();
		} else if (arg0.getComponent() == getEdtAccountNum()){
			getMenu().show(getEdtAccountNum(), 0, getEdtAccountNum().getSize().height);
			popUpController = getEdtAccountNum();
		}
	}

	public void mouseReleased(MouseEvent arg0) {
		// TODO Auto-generated method stub
		
	}

	public void mouseEntered(MouseEvent arg0) {
		// TODO Auto-generated method stub
		
	}

	public void mouseExited(MouseEvent arg0) {
		// TODO Auto-generated method stub
		
	}

	public JTextField getManagedComponent() {
		return popUpController;
	}

	public void onReturnKey() {
		getMenu().setVisible(false);
	}

	public JLabel getLblVersion() {
		if (lblVersion == null)
		{
			lblVersion = new JLabel(LanguageResource.getInstance().getText("VERSION") + ": " + version);
		}
		return lblVersion;
	}

}


class LanguageInfo{
	String language;
	Locale locale;
	
		
	public LanguageInfo(String language, Locale locale) {
		super();
		this.language = language;
		this.locale = locale;
	}


	public String toString(){
		return language;
	}
	
	
}