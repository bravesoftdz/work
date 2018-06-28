package com.mainretail.commun.ui;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.FlowLayout;
import java.awt.Insets;

import java.awt.event.ActionEvent;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;

import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JPopupMenu;
import javax.swing.JTextField;

import com.mainretail.MRIcon;
import com.mainretail.commun.controller.KeyboardManager;
import com.mainretail.commun.controller.LanguageResource;
import com.mainretail.commun.event.ModelItemListener;
import com.mainretail.commun.model.Config;
import com.mainretail.commun.model.DAOUtil;
import com.mainretail.commun.model.IParentDAO;
import com.mainretail.commun.model.inventory.Barcode;
import com.mainretail.commun.model.inventory.IBarcodeDAO;
import com.mainretail.commun.model.inventory.IModelDAO;
import com.mainretail.commun.model.inventory.Model;


public class BarcodeSearch extends BasePanel implements KeyListener, KeyboardManager {
	private static final long serialVersionUID = 1L;
	
	private ModelItemListener modelItemListener;
	
	
	private JPanel jpnPanelGroup;
	private JTextField jtfBarcode;
	private JLabel jlbBarcode;
	private JPanel jpnBarcode;
	private JPanel jpnAccept;
	private JPanel jpnResult;
	private JLabel jlbResult;
	
	private JButton jbtDropDown;
	
	private JPopupMenu menu;

	private Model model;

	private Barcode barcode;

	public BarcodeSearch() {
		super();
	}
	
	public void initGUI() {
		try {
			super.initGUI();
			BorderLayout thisLayout = new BorderLayout();
			this.setLayout(thisLayout);
			{
				this.add(getJpnPanelGroup(), BorderLayout.NORTH);
			}
			{
				this.add(getJpnResult(), BorderLayout.CENTER);
				{
					getJpnResult().add(getJlbResult());
					getJlbResult().setText("");
				}
			}
			
			this.setPreferredSize(new java.awt.Dimension(400, 300));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public JPanel getJpnPanelGroup(){
		if (jpnPanelGroup == null){
			jpnPanelGroup = new JPanel();
			jpnPanelGroup.setBackground(this.getBackground());
			FlowLayout jpnPanelGroupLayout = new FlowLayout();
			jpnPanelGroup.setLayout(jpnPanelGroupLayout);
			jpnPanelGroupLayout.setVgap(0);
			jpnPanelGroupLayout.setHgap(0);
			
			jpnPanelGroup.add(getJpnBarcode());

			getJpnBarcode().add(getJlbBarcode());
			getJpnBarcode().add(getJtfBarcode());
			getJpnBarcode().add(getJbtDropDown());
			getJtfBarcode().addKeyListener(this);
			
		}
		return jpnPanelGroup;
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
			//jlbBarcode.setText(LanguageResource.getInstance().getText("BARCODE"));
			jlbBarcode.setText("UPC:");
		}
		return jlbBarcode;
	}
	
	public JTextField getJtfBarcode() {
		if (jtfBarcode == null) {
			jtfBarcode = new JTextField();
			jtfBarcode.setPreferredSize(new java.awt.Dimension(120, 20));
		}
		return jtfBarcode;
	}
	
	public JPanel getJpnAccept(){
		if (jpnAccept == null)
			jpnAccept = new JPanel();
		return jpnAccept;
	}
	
	public JPanel getJpnResult(){
		if (jpnResult == null){
			jpnResult = new JPanel();
			jpnResult.setBackground(this.getBackground());
		}
		return jpnResult;
	}

	public JLabel getJlbResult() {
		if (jlbResult == null) {
			jlbResult = new JLabel();
		}
		return jlbResult;
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
			model = null;
			barcode = null;
			
			StripedBarcodeQtyInfo stripedBarcodeQtyInfo = stripBarcodeQty(getJtfBarcode().getText().trim());
			
			String barcodeText = stripedBarcodeQtyInfo.getBarcode();
			float qty = stripedBarcodeQtyInfo.getQty();
			
			IBarcodeDAO dao = (IBarcodeDAO) DAOUtil.getDAO(Barcode.class, IParentDAO.DATABASE_DB4O);
			
			//long duration = System.currentTimeMillis();
			
			barcode = dao.getBarcode(barcodeText);
			
			//duration = System.currentTimeMillis() - duration;
			//System.out.println("Busca do barcode:" + (duration/1000)); 
			
			if (barcode != null){
				IModelDAO modelDAO = (IModelDAO) DAOUtil.getDAO(Model.class, IParentDAO.DATABASE_DB4O);

				//duration = System.currentTimeMillis();

				model = modelDAO.getModel(barcode.idmodel);

				//duration = System.currentTimeMillis() - duration;
				//System.out.println("Busca do Model:" + (duration/1000)); 

				if (model != null){
					getJlbResult().setText(model.description);
					if (modelItemListener != null)
						modelItemListener.itemAdded(model, barcode.idbarcode, qty);
				}
			}
			else{
				if (modelItemListener != null)
					modelItemListener.barcodeNotFound(barcodeText, qty);
				getJlbResult().setText(LanguageResource.getInstance().getText("MSG_INFO_BARCODE_NOT_FOUND"));
				//System.out.println("barcode not found");
			}
		} catch (Exception e) {
			MsgBox.errorMsg(this, e.getMessage());
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
			System.out.println(barcodeText.substring(0, qtyFinalPos));
			result.setQty(Float.valueOf(barcodeText.substring(0, qtyFinalPos)).floatValue());
			result.setBarcode(barcodeText.substring(qtyFinalPos + 1, barcodeText.length()));
		}
		return result;
	}

	public void setModelItemListener(ModelItemListener modelItemListener) {
		this.modelItemListener = modelItemListener;
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

}


class StripedBarcodeQtyInfo2{
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
