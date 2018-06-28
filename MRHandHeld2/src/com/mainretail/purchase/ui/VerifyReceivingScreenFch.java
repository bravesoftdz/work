package com.mainretail.purchase.ui;

import java.awt.CardLayout;
import java.awt.Font;
import java.awt.event.ActionEvent;
import java.io.EOFException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;

import com.mainretail.MRIcon;
import com.mainretail.commun.controller.ConnectionManager;
import com.mainretail.commun.controller.LanguageResource;
import com.mainretail.commun.controller.NavigationManager;
import com.mainretail.commun.event.ConnectionManagerListener;
import com.mainretail.commun.event.ModelItemListener;
import com.mainretail.commun.model.Config;
import com.mainretail.commun.model.DAOUtil;
import com.mainretail.commun.model.IParentDAO;
import com.mainretail.commun.model.inventory.Model;
import com.mainretail.commun.model.inventory.ModelVerifyQty;
import com.mainretail.commun.model.purchase.IVerifyReceivingDAO;
import com.mainretail.commun.model.purchase.VerifyReceiving;
import com.mainretail.commun.ui.ApplicationManager;
import com.mainretail.commun.ui.BarcodeSearch;
import com.mainretail.commun.ui.ModelSearch;
import com.mainretail.commun.ui.MsgBox;
import com.mainretail.commun.ui.ParentFormFch;
import com.mainretail.purchase.event.DocumentListener;
import com.mainretail.purchase.event.EditionListener;

import java.awt.BorderLayout;

public class VerifyReceivingScreenFch extends ParentFormFch implements ModelItemListener, ConnectionManagerListener, DocumentListener, EditionListener {
	private static final long serialVersionUID = 1L;

	private static String VERIFY_RECEIVING_SERVLET = "verifyreceivingservlet";
	
	private double totalQty;
	private double totalQtyReceived;
	private JButton jbtVerifyReceiving;
//	private JLabel jlbAmount;
//	private JLabel jlbVerifyReceivingTotal;
	private JButton jbtModelSearch;
	private CardLayout cardLayout;
	private VerifyReceivingDetail verifyReceivingDetail;
	private VerifyReceiving purchaseVerifyReceiving;
	
	private SelectDocument selectDocument;

	private BarcodeSearch barcodeSearch;
	private JButton jbtBarcodeSearch;
	private JLabel jlbNumProducts;
	private JLabel jlbNumProd;
	private JPanel jpnNumProd;
	private JPanel jpnlVerifyReceivingTotal;
	private String activeCard;

	private String documentNumber;

	public VerifyReceivingScreenFch() {
		super();
	}
	
	public VerifyReceivingScreenFch(ApplicationManager appManager, NavigationManager navManager){
		super(appManager, navManager);
	}
	
	public void initGUI() {
		try {
			this.setPreferredSize(new java.awt.Dimension(400, 300));
			super.initGUI();
			
			cardLayout = (CardLayout) (getJpnDetail().getLayout());
			
			selectDocument = new SelectDocument();
			selectDocument.setDocumentListener(this);
			getJpnDetail().add(SelectDocument.class.getName(), selectDocument);
			
			verifyReceivingDetail = new VerifyReceivingDetail(this, this);
			getJpnDetail().add(VerifyReceivingDetail.class.getName(), verifyReceivingDetail);
			
			loadVerifyReceiving();
			
			
			//verifyReceivingDetail.refreshTable(purchaseVerifyReceiving);
			getJpnDetail().add(ModelSearch.class.getName(), new ModelSearch(ModelSearch.SCREEN_TYPE_PURCHASE, this));
			barcodeSearch = new BarcodeSearch();
			barcodeSearch.setModelItemListener(this);
			getJpnDetail().add(BarcodeSearch.class.getName(), barcodeSearch);
			
			getJpnlInfo().add(getJpnlVerifyReceivingTotal(), BorderLayout.WEST);
//			getJpnlVerifyReceivingTotal().add(getJlbVerifyReceivingTotal());
//			getJpnlVerifyReceivingTotal().add(getJlbAmount());
			
			getJpnlInfo().add(getJpnNumProd(), BorderLayout.EAST);
			getJpnNumProd().add(getJlbNumProducts());
			getJpnNumProd().add(getJlbNumProd());

			getJpnlInfo().setPreferredSize(new java.awt.Dimension(400, 17));
			super.getJpnlButtons().setPreferredSize(new java.awt.Dimension(400, 36));
			
			activeCard = VerifyReceivingDetail.class.getName();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	protected void buildButtons(){
		super.buildButtons();
		insertButton(getJbtVerifyReceiving());
		insertButton(getJbtModelSearch());
		insertButton(getJbtBarcodeSearch());
	}
	
	private JButton getJbtBarcodeSearch() {
		if (jbtBarcodeSearch == null)
			jbtBarcodeSearch = MRIcon.createButton("", "scan");
		return jbtBarcodeSearch;
	}

	public JButton getJbtVerifyReceiving(){
		if (jbtVerifyReceiving == null)
			jbtVerifyReceiving = MRIcon.createButton("", "purchaseitems");
		return jbtVerifyReceiving;		
	}
	
	public JButton getJbtModelSearch(){
		if (jbtModelSearch == null)
			jbtModelSearch = MRIcon.createButton("", "search");
		return jbtModelSearch;		
	}
	
	public void onActionPerformed(ActionEvent evt){
		if (evt.getSource() == getJbtVerifyReceiving()){
			if (purchaseVerifyReceiving != null){
				cardLayout.show(getJpnDetail(), VerifyReceivingDetail.class.getName());
				activeCard = VerifyReceivingDetail.class.getName();
				verifyReceivingDetail.refreshTable(purchaseVerifyReceiving);
			}
		} else if (evt.getSource() == getJbtModelSearch()){
			if (purchaseVerifyReceiving != null)
				cardLayout.show(getJpnDetail(), ModelSearch.class.getName());
			activeCard = ModelSearch.class.getName();
		} else if (evt.getSource() == getJbtBarcodeSearch()){
			if (purchaseVerifyReceiving != null)
				cardLayout.show(getJpnDetail(), BarcodeSearch.class.getName());	
			activeCard = BarcodeSearch.class.getName();
		} else
			super.onActionPerformed(evt);
	}

	public void itemAdded(Object model, String barcode, double qty) {
		if (purchaseVerifyReceiving == null)
			loadVerifyReceiving();
		
		ModelVerifyQty modelVerifyQty = searchModelVerify(((Model)model).idmodel);
		
		if (modelVerifyQty == null){
			modelVerifyQty = newModelVerifyQty(((Model)model));
			purchaseVerifyReceiving.addItem(modelVerifyQty);
		}
		
		modelVerifyQty.qtyReceived += qty;
		
		totalQtyReceived += qty; 
		
		DAOUtil.getDAO(VerifyReceiving.class, IParentDAO.DATABASE_DB4O).save(purchaseVerifyReceiving);
		
		if (activeCard.equals(VerifyReceivingDetail.class.getName()))
			verifyReceivingDetail.refreshTable(this.purchaseVerifyReceiving);
			
		refreshReceivingTotals();
	}
	
	
	private ModelVerifyQty newModelVerifyQty(Model model) {
		ModelVerifyQty result = new ModelVerifyQty();
		result.idmodel = model.idmodel;
		result.description = model.description;
		return result;
	}

	private ModelVerifyQty searchModelVerify(int idmodel){
//		ModelVerifyQty result = null;
//		for (int i = 0; i < purchaseVerifyReceiving.items.size(); i++){
//			ModelVerifyQty testing =  (ModelVerifyQty) purchaseVerifyReceiving.items.get(i);
//			if (testing.idmodel == idmodel){
//				result = testing;
//			}
//		}
//		return result;
		
		IVerifyReceivingDAO dao = (IVerifyReceivingDAO)DAOUtil.getDAO(VerifyReceiving.class, IParentDAO.DATABASE_DB4O);
		return dao.getItem(purchaseVerifyReceiving.idpurchase, idmodel);
	}
	
	private ModelVerifyQty searchModelVerify(String description){
		ModelVerifyQty result = null;
		for (int i = 0; i < purchaseVerifyReceiving.items.size(); i++){
			ModelVerifyQty testing =  (ModelVerifyQty) purchaseVerifyReceiving.items.get(i);
			if (testing.description.equals(description)){
				result = testing;
			}
		}
		return result;
	}
	
	private void loadVerifyReceiving(){
		IVerifyReceivingDAO dao = (IVerifyReceivingDAO)(DAOUtil.getDAO(VerifyReceiving.class, IParentDAO.DATABASE_DB4O));
		
		purchaseVerifyReceiving = dao.getActiveVerifyreceiving();
		
		if (purchaseVerifyReceiving == null){
			cardLayout.show(getJpnDetail(), SelectDocument.class.getName());
		}
		else{
			verifyReceivingDetail.refreshTable(purchaseVerifyReceiving);			
			cardLayout.show(getJpnDetail(), VerifyReceivingDetail.class.getName());
		}
		
		calcReceivingTotals();
		refreshReceivingTotals();
	}
	
	private void newReceiving(){
		IParentDAO dao = DAOUtil.getDAO(VerifyReceiving.class, IParentDAO.DATABASE_DB4O);
		dao.delete(purchaseVerifyReceiving);
		purchaseVerifyReceiving = null;
		verifyReceivingDetail.refreshTable(purchaseVerifyReceiving);			
		getJlbNumProd().setText("0");
		cardLayout.show(getJpnDetail(), SelectDocument.class.getName());
	}

	public void itemRemoved(Object item) {
	}

	public void dataOutput(ObjectOutputStream oos) {
		try {
			VerifyReceiving pvr = new VerifyReceiving();
			pvr.documentnumber = documentNumber;
			
			oos.writeObject(pvr);		
		} catch (Exception e) {
			e.printStackTrace();
			MsgBox.errorMsg(this, e.getMessage());
		}
	}

	public void dataInput(ObjectInputStream ois) {
		purchaseVerifyReceiving = null;
		try {
			try{
				Object o = ois.readObject();
				purchaseVerifyReceiving = (VerifyReceiving)(o);
			
			} catch (EOFException e) {
			}
			
			IParentDAO dao = DAOUtil.getDAO(VerifyReceiving.class, IParentDAO.DATABASE_DB4O);
			
			dao.save(purchaseVerifyReceiving);
			
			verifyReceivingDetail.refreshTable(purchaseVerifyReceiving);			
			cardLayout.show(getJpnDetail(), VerifyReceivingDetail.class.getName());
			calcReceivingTotals();
			refreshReceivingTotals();
		} catch (Exception e) {
			e.printStackTrace();
			MsgBox.errorMsg(this, e.getMessage());
		}
	}
	

	public void httpError(int errorCode, String errorMsg) {
		MsgBox.errorMsg(this, errorCode + " " + errorMsg);
		
	}

	public void connectionException(Exception e) {
		MsgBox.errorMsg(this, e.getMessage());
		
	}
	
//	public JLabel getJlbVerifyReceivingTotal() {
//		if (jlbVerifyReceivingTotal == null){
//			jlbVerifyReceivingTotal = new JLabel();
//			jlbVerifyReceivingTotal.setText("Total :");
//			jlbVerifyReceivingTotal.setFont(new java.awt.Font("Tahoma", Font.PLAIN ,10));
//		}
//		return jlbVerifyReceivingTotal;
//	}
//	
//	public JLabel getJlbAmount() {
//		if (jlbAmount == null) {
//			jlbAmount = new JLabel();
//			jlbAmount.setText("0.00");
//			jlbAmount.setFont(new java.awt.Font("Tahoma", Font.BOLD ,11));
//		}
//		return jlbAmount;
//	}
	
	public JLabel getJlbNumProducts() {
		if (jlbNumProducts == null) {
			jlbNumProducts = new JLabel();
			jlbNumProducts.setText(LanguageResource.getInstance().getText("PRODUCTS")+ ":");
			
			jlbNumProducts.setFont(new java.awt.Font("Tahoma", Font.PLAIN ,10));
		}
		return jlbNumProducts;
	}
	
	public JLabel getJlbNumProd() {
		if (jlbNumProd == null) {
			jlbNumProd = new JLabel();
			jlbNumProd.setText("0");
			jlbNumProd.setFont(new java.awt.Font("Tahoma", Font.BOLD ,11));
		}
		return jlbNumProd;
	}

	private JPanel getJpnlVerifyReceivingTotal() {
		if (jpnlVerifyReceivingTotal == null) {
			jpnlVerifyReceivingTotal = new JPanel();
			jpnlVerifyReceivingTotal.setBackground(this.getBackground());
		}
		return jpnlVerifyReceivingTotal;
	}
	
	public JPanel getJpnNumProd() {
		if (jpnNumProd == null) {
			jpnNumProd = new JPanel();
			jpnNumProd.setBackground(this.getBackground());
		}
		return jpnNumProd;
	}

	public void documentEntered(String document) {
		documentNumber = document;
		requestPurchase();
	}
	
	public void requestPurchase(){
		ConnectionManager manager = new ConnectionManager();
		manager.setUrlPath(Config.getInstance().getHost());
		manager.setServlet(VERIFY_RECEIVING_SERVLET);
		manager.setConnectionManagerListener(this);
		manager.send();
	}

	public void onNew() {
		newReceiving();
	}

	private void refreshReceivingTotals(){
		if (this.purchaseVerifyReceiving == null){
			getJlbNumProd().setText("0");
		} else {
			if (this.purchaseVerifyReceiving.items != null)
				getJlbNumProd().setText(String.valueOf(totalQty) + "/" + String.valueOf(totalQtyReceived));
		}
	}
	
	private void calcReceivingTotals(){
	
		totalQty = 0;
		totalQtyReceived = 0;
		
		if (purchaseVerifyReceiving != null)
			if (purchaseVerifyReceiving.items != null)
				for(int i=0; i < purchaseVerifyReceiving.items.size(); i++){
					ModelVerifyQty mvq = (ModelVerifyQty)(purchaseVerifyReceiving.items.get(i));
					totalQty += mvq.qty;
					totalQtyReceived += mvq.qtyReceived;
				}
		
	}
	
	public void barcodeNotFound(String barcode, double qty) {
		if (purchaseVerifyReceiving == null)
			loadVerifyReceiving();
		
		ModelVerifyQty modelVerifyQty = searchModelVerify(barcode);
		
		if (modelVerifyQty == null){
			Model modelNotFound = new Model();
			modelNotFound.idmodel = 0;
			modelNotFound.description = barcode;
			modelVerifyQty = newModelVerifyQty(modelNotFound);
			purchaseVerifyReceiving.addItem(modelVerifyQty);
		}
		
		modelVerifyQty.qtyReceived += qty;
		
		totalQtyReceived += qty;
		
		DAOUtil.getDAO(VerifyReceiving.class, IParentDAO.DATABASE_DB4O).save(purchaseVerifyReceiving);
		
		refreshReceivingTotals();
	}

	public void itemChanged(Object item, double oldQty) {
		// TODO Auto-generated method stub
		
	}


}


