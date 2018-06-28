package com.mainretail.purchase.ui;


import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.ParseException;
import java.util.List;

import javax.swing.BoxLayout;
import javax.swing.ComboBoxModel;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JPopupMenu;
import javax.swing.JTextField;

import com.mainretail.commun.controller.KeyboardManager;
import com.mainretail.commun.controller.LanguageResource;
import com.mainretail.commun.model.Config;
import com.mainretail.commun.model.DAOUtil;
import com.mainretail.commun.model.IParentDAO;
import com.mainretail.commun.model.Vendor;
import com.mainretail.commun.model.purchase.Receiving;
import com.mainretail.commun.ui.BasePanel;
import com.mainretail.commun.ui.KeyboardPanel;
import com.mainretail.commun.ui.MsgBox;
import com.mainretail.purchase.event.ReceivingEditionListener;

public class ReceivingFinish extends BasePanel  implements KeyboardManager, MouseListener{

	private static final long serialVersionUID = 6482120094246832486L;
	private JPanel jpnButton;
	private JButton jbtComplete;
	private JComboBox jcbVendor;
	private JLabel jlbDocNum;
	private JTextField jtfTotal;
	private JLabel jlbTotal;
	private JTextField jtfFreight;
	private JLabel jlbFreight;
	private JTextField jtfDocNum;
	private JLabel jlbVendor;
	private JPanel jpnDetail;
	
	private Receiving receiving;
	
	private ReceivingEditionListener receivingEditionListener;
	private JPopupMenu menu;
	private JTextField popUpController;

	public ReceivingFinish() {
		super();
	}

	public void initGUI() {
		
		try {

			BorderLayout jpnGridLayout = new BorderLayout();
			this.setLayout(jpnGridLayout);
			this.setSize(400, 300);
			this.setBackground(Color.white);
			{
				/*
				GridLayout jpnDetailLayout = new GridLayout(1, 1);
				jpnDetailLayout.setHgap(5);
				jpnDetailLayout.setVgap(5);
				jpnDetailLayout.setColumns(1);*/
				GridBagLayout jpnClientLayout = new GridBagLayout();
				jpnClientLayout.rowWeights = new double[] {0.1, 1.0, 1.0, 1.0, 0.1};
				jpnClientLayout.rowHeights = new int[] {10, 40, 40, 40, 40};
				jpnClientLayout.columnWeights = new double[] {0.1, 20.0, 0.1, 0.1};
				jpnClientLayout.columnWidths = new int[] {7, 70, 7, 7};
				
				
				this.add(getJpnDetail(), BorderLayout.CENTER);
				this.add(getJpnButton(), BorderLayout.SOUTH);
				getJpnDetail().setLayout(jpnClientLayout);
				
				getJpnDetail().add(getJlbVendor(), getGridPos(0, 1, true));
				getJpnDetail().add(getJcbVendor(), getGridPos(1, 1, false));

				getJpnDetail().add(getJlbDocNum(), getGridPos(0, 2, true));
				getJpnDetail().add(getJtfDocNum(), getGridPos(1, 2, false));

				getJpnDetail().add(getJlbFreight(), getGridPos(0, 3, true));
				getJpnDetail().add(getJtfFreight(), getGridPos(1, 3, false));

				getJpnDetail().add(getJlbTotal(), getGridPos(0, 4, true));
				getJpnDetail().add(getJtfTotal(), getGridPos(1, 4, false));

				setComboModel(getVendors());

				getJpnButton().add(getJbtComplete());
			}
			super.initGUI();
			

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
	
	public JPanel getJpnDetail() {
		if (jpnDetail == null){
			jpnDetail = new JPanel();
			//jpnDetail.setPreferredSize(new java.awt.Dimension(400, 278));
			jpnDetail.setBackground(this.getBackground());
		}
		return jpnDetail;
	}
	
	public JPanel getJpnButton() {
		if (jpnButton == null) {
			jpnButton = new JPanel();
			BoxLayout jpnButtonLayout = new BoxLayout(
				jpnButton,
				javax.swing.BoxLayout.X_AXIS);
			jpnButton.setLayout(jpnButtonLayout);
			jpnButton.setBackground(this.getBackground());
		}
		return jpnButton;
	}
	
	public JButton getJbtComplete() {
		if (jbtComplete == null) {
			jbtComplete = new JButton();
			jbtComplete.setText(LanguageResource.getInstance().getText("FINISH"));
			jbtComplete.setMaximumSize(new java.awt.Dimension(60,22));
			jbtComplete.setSize(new java.awt.Dimension(60,22));
			jbtComplete.setPreferredSize(new java.awt.Dimension(60,22));
			jbtComplete.setMargin(new Insets(0, 0, 0, 0));
			jbtComplete.addActionListener(this);
			
		}
		return jbtComplete;
	}
	
	public JLabel getJlbVendor() {
		if (jlbVendor == null) {
			jlbVendor = new JLabel();
			jlbVendor.setText(LanguageResource.getInstance().getText("VENDOR"));
		}
		return jlbVendor;
	}
	
	public JComboBox getJcbVendor() {
		if (jcbVendor == null) {
			jcbVendor = new JComboBox();
			jcbVendor.setOpaque(false);
			//jcbVendor.setPreferredSize(new java.awt.Dimension(150, 20));
		}
		return jcbVendor;
	}

	private DefaultComboBoxModel getVendors(){
		IParentDAO dao = DAOUtil.getDAO(Vendor.class, IParentDAO.DATABASE_DB4O);
		List vendorList = dao.listAll();
		
		Object[] objects = vendorList.toArray();
		
		return new DefaultComboBoxModel(objects);
	}
	
	private void setComboModel(ComboBoxModel model) {
		getJcbVendor().setModel(model);
	}
	
	public int getVendor() {
		return ((Vendor)(getJcbVendor().getItemAt(getJcbVendor().getSelectedIndex()))).idvendor;
	}

	public void setReceiving(Receiving receiving) {
		this.receiving = receiving;
		RefreshValues();
	}
	
	private void RefreshValues(){
		//Vendor
		for(int i = 0; i < getJcbVendor().getItemCount(); i++) 
			if (((Vendor)(getJcbVendor().getItemAt(i))).idvendor == (this.receiving.idvendor)){
				getJcbVendor().setSelectedItem(getJcbVendor().getItemAt(i));
				break;
			}
		DecimalFormat formatter = new DecimalFormat("##0.00");
		getJtfTotal().setText(formatter.format(this.receiving.subtotal));
		getJtfFreight().setText(formatter.format(this.receiving.freight));
	}
	
	public JLabel getJlbDocNum() {
		if (jlbDocNum == null) {
			jlbDocNum = new JLabel();
			jlbDocNum.setText(LanguageResource.getInstance().getText("DOCUMENT_NUMBER"));
		}
		return jlbDocNum;
	}
	
	public JTextField getJtfDocNum() {
		if (jtfDocNum == null) {
			jtfDocNum = new JTextField();
			jtfDocNum.addMouseListener(this);
		}
		return jtfDocNum;
	}
	
	public JLabel getJlbFreight() {
		if (jlbFreight == null) {
			jlbFreight = new JLabel();
			jlbFreight.setText(LanguageResource.getInstance().getText("FREIGHT"));
		}
		return jlbFreight;
	}
	
	public JTextField getJtfFreight() {
		if (jtfFreight == null) {
			jtfFreight = new JTextField();
			jtfFreight.addMouseListener(this);
		}
		return jtfFreight;
	}
	
	public JLabel getJlbTotal() {
		if (jlbTotal == null) {
			jlbTotal = new JLabel();
			jlbTotal.setText("Total");
		}
		return jlbTotal;
	}
	
	public JTextField getJtfTotal() {
		if (jtfTotal == null) {
			jtfTotal = new JTextField();
			jtfTotal.addMouseListener(this);
		}
		return jtfTotal;
	}

	public void onActionPerformed(ActionEvent evt) {
		if (evt.getSource() == getJbtComplete()){
			if (validateValues()){
				try{
					setReceivingInfo();
					if (receivingEditionListener != null)
						receivingEditionListener.save();
				} catch(Exception e){
					MsgBox.errorMsg(this, e.getMessage());
				}
			}
		}
		else
			super.onActionPerformed(evt);
	}
	
	private void setReceivingInfo() throws ParseException{
			NumberFormat format = NumberFormat.getInstance(Config.getInstance().getLocale());
			receiving.freight =  format.parse(getJtfFreight().getText().trim()).doubleValue();
			receiving.subtotal =  format.parse(getJtfTotal().getText().trim()).doubleValue();
			receiving.documentnumber = getJtfDocNum().getText().trim();
			receiving.idvendor = getVendor();
	}
	
	private boolean validateValues(){
		if (getJtfDocNum().getText().trim().equals("")){
			MsgBox.errorMsg(this, LanguageResource.getInstance().getText("MSG_INFO_ENTER_DOC_NUMBER"));
			return false;
		}
		return true;
	}

	public void setReceivingEditionListener(
			ReceivingEditionListener receivingEditionListener) {
		this.receivingEditionListener = receivingEditionListener;
	}

	public ReceivingEditionListener getReceivingEditionListener() {
		return receivingEditionListener;
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
	
	
	public JTextField getManagedComponent() {
		return popUpController;
	}

	public void onReturnKey() {
		getMenu().setVisible(false);
	}

	public void mouseClicked(MouseEvent arg0) {
		// TODO Auto-generated method stub
		
	}

	public void mousePressed(MouseEvent arg0) {
		if (arg0.getComponent() ==  getJtfDocNum()){
			getMenu().show(getJtfDocNum(), 0, getJtfDocNum().getSize().height);
			popUpController = getJtfDocNum();
		}
		else if (arg0.getComponent() ==  getJtfFreight()){
			getMenu().show(getJtfFreight(), 0, getJtfFreight().getSize().height-160);
			popUpController = getJtfFreight();
		}
		else if (arg0.getComponent() == getJtfTotal()){
			getMenu().show(getJtfTotal(), 0, getJtfTotal().getSize().height-160);
			popUpController = getJtfTotal();
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


}
