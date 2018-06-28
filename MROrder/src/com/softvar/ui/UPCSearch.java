package com.softvar.ui;

import java.awt.Color;
import java.awt.FlowLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;

import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JPopupMenu;
import javax.swing.JTextField;

import com.softvar.controller.KeyboardManager;
import com.softvar.controller.MRIcon;
import com.softvar.controller.UPCScanListener;
import com.softvar.internationalization.LanguageResource;
import com.softvar.mrorder.controller.Config;

public class UPCSearch extends BasePanel implements KeyListener, KeyboardManager{
	
	private static final long serialVersionUID = 6606879174345382539L;
	
	private JTextField jtfBarcode;
	private JLabel jlbBarcode;
	private JPanel jpnBarcode;
	private JPanel jpnAccept;
	
	private JButton jbtDropDown;
	
	private JPopupMenu menu;
	
	private UPCScanListener upcScanListener;

	public UPCSearch() {
		super();
	}
	
	public void initGUI() {
		try {
			super.initGUI();
			
			FlowLayout jpnFlowLayout = new FlowLayout();
			jpnFlowLayout.setVgap(0);
			jpnFlowLayout.setHgap(0);
			this.setLayout(jpnFlowLayout);

			this.add(getJpnBarcode());

			getJpnBarcode().add(getJlbBarcode());
			getJpnBarcode().add(getJtfBarcode());
			getJpnBarcode().add(getJbtDropDown());
			getJtfBarcode().addKeyListener(this);
			addFocusListener(new FocusListener(){

				public void focusGained(FocusEvent arg0) {
					getJtfBarcode().requestFocusInWindow();
					
				}

				public void focusLost(FocusEvent arg0) {
					// TODO Auto-generated method stub
					
				}
				
			});
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public JButton getJbtDropDown(){
		if (jbtDropDown == null){
			jbtDropDown = MRIcon.createButton("", "dropdown");
			jbtDropDown.setMargin(new Insets(0, 0, 0, 0));
			jbtDropDown.setPreferredSize(new java.awt.Dimension(19,20));
			jbtDropDown.addActionListener(this);
		}
		return jbtDropDown;
	}
	
	private JPanel getJpnBarcode() {
		if (jpnBarcode == null) {
			jpnBarcode = new JPanel();
			jpnBarcode.setBackground(Color.WHITE);
			FlowLayout jpnDropDownLayout = new FlowLayout();
			jpnDropDownLayout.setVgap(0);
			jpnDropDownLayout.setHgap(0);
			jpnBarcode.setLayout(jpnDropDownLayout);
		}
		return jpnBarcode;
	}
	
	public JLabel getJlbBarcode() {
		if (jlbBarcode == null) {
			jlbBarcode = new JLabel();
			jlbBarcode.setText(LanguageResource.getInstance().getText("UPC") + " ");
		}
		return jlbBarcode;
	}
	
	public JTextField getJtfBarcode() {
		if (jtfBarcode == null) {
			jtfBarcode = new JTextField();
			jtfBarcode.setPreferredSize(new java.awt.Dimension(120, 20));
			jtfBarcode.setFocusable(true);
		}
		return jtfBarcode;
	}
	
	public JPanel getJpnAccept(){
		if (jpnAccept == null)
			jpnAccept = new JPanel();
		return jpnAccept;
	}
	
	public void keyTyped(KeyEvent e) {
		if (String.valueOf(e.getKeyChar()).equals(Config.getInstance().getScannPrefix())){
			
			searchBarcode();
			e.consume();
		}
	}

	public void keyPressed(KeyEvent e) {
		if (String.valueOf(e.getKeyChar()).equals(Config.getInstance().getScannPrefix())){
			//System.out.println("keyPressed");
		}
	}

	public void keyReleased(KeyEvent e) {
		if (String.valueOf(e.getKeyChar()).equals(Config.getInstance().getScannPrefix())){
			//System.out.println("keyReleased");
		}
	}

	public void onActionPerformed(ActionEvent evt) {
		if (evt.getSource() == getJbtDropDown())
			getMenu().show(getJtfBarcode(), 0, getJtfBarcode().getSize().height);
		else
			super.onActionPerformed(evt);
	}

	private void searchBarcode() {
		//System.out.println("Procurando barcode " + getJtfBarcode().getText());
		
		try {
			
			StripedBarcodeQtyInfo stripedBarcodeQtyInfo = stripBarcodeQty(getJtfBarcode().getText().trim());
			
			String barcodeText = stripedBarcodeQtyInfo.getBarcode();
			float qty = stripedBarcodeQtyInfo.getQty();
			
			if (upcScanListener != null){
				upcScanListener.UPCScanned(barcodeText, qty);
			}
			
			
		} catch (Exception e) {
			MsgBox.errorMsg(this, e.getMessage());
			getJtfBarcode().requestFocusInWindow();
			getJtfBarcode().requestFocus();
			e.printStackTrace();
		}
		finally{
			getJtfBarcode().setText("");
		}
		
	}

	private StripedBarcodeQtyInfo stripBarcodeQty(String barcodeText) {
		StripedBarcodeQtyInfo result = new StripedBarcodeQtyInfo();
		result.setBarcode(barcodeText);
		result.setQty(1);
		int qtyFinalPos = barcodeText.indexOf("*");
		
		if (qtyFinalPos > 0){
			//System.out.println(barcodeText.substring(0, qtyFinalPos));
			result.setQty(Float.valueOf(barcodeText.substring(0, qtyFinalPos)).floatValue());
			result.setBarcode(barcodeText.substring(qtyFinalPos + 1, barcodeText.length()));
		}
		return result;
	}
	
	public JPopupMenu getMenu() {
		if (menu == null){
			menu = new JPopupMenu();
			menu.add(new KeyboardPanel(this, (KeyboardPanel.START_NUM | KeyboardPanel.START_ALP | KeyboardPanel.START_CHR)));
		}
		return menu;
	}

	public JTextField getManagedComponent() {
		return getJtfBarcode();
	}
	
	public void onReturnKey() {
		searchBarcode();
		getMenu().setVisible(false);
	}

	public void setUpcScanListener(UPCScanListener upcScanListener) {
		this.upcScanListener = upcScanListener;
	}

}

class StripedBarcodeQtyInfo{
	private float qty;
	private String barcode;
	
	public String getBarcode() {
		return barcode;
	}
	
	public void setBarcode(String barcode) {
		this.barcode = barcode;
	}
	
	public float getQty() {
		return qty;
	}
	
	public void setQty(float qty) {
		this.qty = qty;
	}
}
