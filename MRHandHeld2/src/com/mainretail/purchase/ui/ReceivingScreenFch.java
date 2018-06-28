package com.mainretail.purchase.ui;

import java.awt.CardLayout;
import java.awt.Font;
import java.awt.event.ActionEvent;
import java.io.EOFException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.text.DecimalFormat;

import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;

import com.mainretail.MRIcon;
import com.mainretail.commun.controller.ConnectionManager;
import com.mainretail.commun.controller.LanguageResource;
import com.mainretail.commun.controller.NavigationManager;
import com.mainretail.commun.controller.RuntimeInfo;
import com.mainretail.commun.event.ConnectionManagerListener;
import com.mainretail.commun.event.ModelItemListener;
import com.mainretail.commun.model.Config;
import com.mainretail.commun.model.DAOUtil;
import com.mainretail.commun.model.IParentDAO;
import com.mainretail.commun.model.inventory.Model;
import com.mainretail.commun.model.purchase.IReceivingDAO;
import com.mainretail.commun.model.purchase.Receiving;
import com.mainretail.commun.model.purchase.ReceivingItem;
import com.mainretail.commun.ui.ApplicationManager;
import com.mainretail.commun.ui.BarcodeSearch;
import com.mainretail.commun.ui.ModelSearch;
import com.mainretail.commun.ui.MsgBox;
import com.mainretail.commun.ui.ParentFormFch;
import com.mainretail.purchase.event.DocumentListener;
import com.mainretail.purchase.event.ReceivingEditionListener;
import java.awt.BorderLayout;

public class ReceivingScreenFch extends ParentFormFch implements ModelItemListener, DocumentListener, ReceivingEditionListener {
	private static final long serialVersionUID = 1L;

	private static String IMPORT_PO_SERVLET = "importposervlet";
	private static String RECEIVING_SERVLET = "receivingservlet";
	
	private double totalQty;
	private double totalQtyReceived;
	private JButton jbtReceiving;
	private JLabel jlbAmount;
	private JLabel jlbVerifyReceivingTotal;
	private JButton jbtModelSearch;
	private CardLayout cardLayout;
	private ReceivingDetail receivingDetail;
	private Receiving receiving;
	
	private SelectDocument selectDocument;
	private ReceivingFinish receivingFinish;

	private BarcodeSearch barcodeSearch;
	private JButton jbtBarcodeSearch;
	private JLabel jlbNumProducts;
	private JLabel jlbNumProd;
	private JPanel jpnNumProd;
	private JPanel jpnlReceivingTotal;

	private String documentNumber;
	
	private String activeCard;

	public ReceivingScreenFch() {
		super();
	}
	
	public ReceivingScreenFch(ApplicationManager appManager, NavigationManager navManager){
		super(appManager, navManager);
	}
	
	public void initGUI() {
		try {
			this.setPreferredSize(new java.awt.Dimension(400, 300));
			super.initGUI();
			
			cardLayout = (CardLayout) (getJpnDetail().getLayout());
			
			receivingFinish = new ReceivingFinish();
			getJpnDetail().add(ReceivingFinish.class.getName(), receivingFinish);
			
			selectDocument = new SelectDocument();
			selectDocument.setDocumentListener(this);
			getJpnDetail().add(SelectDocument.class.getName(), selectDocument);
			
			receivingDetail = new ReceivingDetail(this, this);
			getJpnDetail().add(ReceivingDetail.class.getName(), receivingDetail);
			
			loadReceiving();
			cardLayout.show(getJpnDetail(), ReceivingDetail.class.getName());
			
			getJpnDetail().add(ModelSearch.class.getName(), new ModelSearch(ModelSearch.SCREEN_TYPE_PURCHASE, this));
			barcodeSearch = new BarcodeSearch();
			barcodeSearch.setModelItemListener(this);
			getJpnDetail().add(BarcodeSearch.class.getName(), barcodeSearch);

			getJpnlInfo().add(getJpnlReceivingTotal(), BorderLayout.WEST);
			getJpnlReceivingTotal().add(getJlbVerifyReceivingTotal());
			getJpnlReceivingTotal().add(getJlbAmount());
			
			getJpnlInfo().add(getJpnNumProd(), BorderLayout.EAST);
			getJpnNumProd().add(getJlbNumProducts());
			getJpnNumProd().add(getJlbNumProd());

			getJpnlInfo().setPreferredSize(new java.awt.Dimension(400, 17));
			super.getJpnlButtons().setPreferredSize(new java.awt.Dimension(400, 36));
			
			activeCard = ReceivingDetail.class.getName();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	protected void buildButtons(){
		super.buildButtons();
		insertButton(getJbtReceiving());
		insertButton(getJbtModelSearch());
		insertButton(getJbtBarcodeSearch());
	}
	
	private JButton getJbtBarcodeSearch() {
		if (jbtBarcodeSearch == null)
			jbtBarcodeSearch = MRIcon.createButton("", "scan");
		return jbtBarcodeSearch;
	}

	public JButton getJbtReceiving(){
		if (jbtReceiving == null)
			jbtReceiving = MRIcon.createButton("", "purchaseitems");
		return jbtReceiving;		
	}
	
	public JButton getJbtModelSearch(){
		if (jbtModelSearch == null)
			jbtModelSearch = MRIcon.createButton("", "search");
		return jbtModelSearch;		
	}
	
	public void onActionPerformed(ActionEvent evt){
		if (evt.getSource() == getJbtReceiving()){
			cardLayout.show(getJpnDetail(), ReceivingDetail.class.getName());
			activeCard = ReceivingDetail.class.getName();
			receivingDetail.refreshTable(receiving);
			calcReceivingTotals();
			refreshReceivingTotals();
		} else if (evt.getSource() == getJbtModelSearch()){
			cardLayout.show(getJpnDetail(), ModelSearch.class.getName());
			activeCard = ReceivingDetail.class.getName();
		} else if (evt.getSource() == getJbtBarcodeSearch()){
			cardLayout.show(getJpnDetail(), BarcodeSearch.class.getName());
			activeCard = ReceivingDetail.class.getName();
		} else
			super.onActionPerformed(evt);
	}

	public void itemAdded(Object model, String barcode, double qty) {
		if (this.receiving == null)
			loadReceiving();
		
		ReceivingItem receivingItem = searchModelVerify(((Model)model).idmodel, qty);
		
		if (receivingItem == null){
			receivingItem = newModelVerifyQty(((Model)model));
			receivingItem.barcode = barcode;
			receivingItem.qtyReceived += qty;
			this.receiving.addItem(receivingItem);
			this.receiving.subtotal += qty * receivingItem.newcostprice;
		} else if ((receivingItem.qty) < (receivingItem.qtyReceived + qty) ){
			receiving.subtotal += qty * receivingItem.newcostprice;
		}
		
		
		totalQtyReceived += qty; 
		
		DAOUtil.getDAO(Receiving.class, IParentDAO.DATABASE_DB4O).save(receiving);
		
		if (activeCard.equals(ReceivingDetail.class.getName()))
			receivingDetail.refreshTable(receiving);
		
		refreshReceivingTotals();
	}
	
	
	private ReceivingItem newModelVerifyQty(Model model) {
		ReceivingItem result = new ReceivingItem();
		result.idmodel = model.idmodel;
		result.description = model.description;
		result.costprice = model.vendorcost;
		result.newcostprice = model.vendorcost;
		result.newsaleprice = model.sellingprice;
		result.idgroup = model.idcategory;
		return result;
	}

	private ReceivingItem searchModelVerify(int idmodel, double qty){
		ReceivingItem result = null;
		for (int i = 0; i < this.receiving.items.size(); i++){
			ReceivingItem testing =  (ReceivingItem) this.receiving.items.get(i);
			if (testing.idmodel == idmodel){
				testing.qtyReceived += qty;
				result = testing;
				break;
			}
		}
		return result;
	}
	
	private ReceivingItem searchReceivingItem(String description){
		ReceivingItem result = null;
		for (int i = 0; i < this.receiving.items.size(); i++){
			ReceivingItem testing =  (ReceivingItem) this.receiving.items.get(i);
			if (testing.description.equals(description)){
				result = testing;
			}
		}
		return result;
	}
	
	private void loadReceiving(){
		IReceivingDAO dao = (IReceivingDAO)(DAOUtil.getDAO(Receiving.class, IParentDAO.DATABASE_DB4O));
		
		this.receiving = dao.getActiveReceiving();
		
		if (this.receiving == null){
			this.receiving = new Receiving();
			this.receiving.idstore = Config.getInstance().getIDStore();
			this.receiving.iduserprereceiving = RuntimeInfo.getInstance().user.iduser;
		}
		
		receivingDetail.refreshTable(receiving);			
		
		calcReceivingTotals();
		refreshReceivingTotals();
	}
	
	public void itemRemoved(Object item) {
		this.receiving.removeItem((ReceivingItem)item); 
		DAOUtil.getDAO(Receiving.class, IParentDAO.DATABASE_DB4O).save(this.receiving);
		receivingDetail.refreshTable(this.receiving);
	}

	public JLabel getJlbVerifyReceivingTotal() {
		if (jlbVerifyReceivingTotal == null){
			jlbVerifyReceivingTotal = new JLabel();
			jlbVerifyReceivingTotal.setText("Total :");
			jlbVerifyReceivingTotal.setFont(new java.awt.Font("Tahoma", Font.PLAIN ,10));
		}
		return jlbVerifyReceivingTotal;
	}
	
	public JLabel getJlbAmount() {
		if (jlbAmount == null) {
			jlbAmount = new JLabel();
			jlbAmount.setText("0.00");
			jlbAmount.setFont(new java.awt.Font("Tahoma", Font.BOLD ,11));
		}
		return jlbAmount;
	}
	
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

	private JPanel getJpnlReceivingTotal() {
		if (jpnlReceivingTotal == null) {
			jpnlReceivingTotal = new JPanel();
			jpnlReceivingTotal.setBackground(this.getBackground());
		}
		return jpnlReceivingTotal;
	}
	
	public JPanel getJpnNumProd() {
		if (jpnNumProd == null) {
			jpnNumProd = new JPanel();
			jpnNumProd.setBackground(this.getBackground());
		}
		return jpnNumProd;
	}

	public void documentEntered(String document) {
		newReceiving();
		documentNumber = document;
		requestPO();
	}
	
	public void requestPO(){
		
		ConnectionManager manager = new ConnectionManager();
		manager.setUrlPath(Config.getInstance().getHost());
		manager.setServlet(IMPORT_PO_SERVLET);
		manager.setConnectionManagerListener(new ReceivingImportManager(this));
		manager.send();
		
	}


	private void refreshReceivingTotals(){
		if (this.receiving == null){
			getJlbNumProd().setText("0");
			getJlbAmount().setText("0.00");
		} else {
			if (this.receiving.items != null){
				getJlbNumProd().setText(String.valueOf(totalQty) + "/" + String.valueOf(totalQtyReceived));
				DecimalFormat formatter = new DecimalFormat("##0.00");
				getJlbAmount().setText(formatter.format(receiving.subtotal));
			}
		}
	}
	
	private void calcReceivingTotals(){
	
		totalQty = 0;
		totalQtyReceived = 0;
		
		if (this.receiving != null)
			if (this.receiving.items != null)
				for(int i=0; i < this.receiving.items.size(); i++){
					ReceivingItem mvq = (ReceivingItem)(this.receiving.items.get(i));
					totalQty += mvq.qty;
					totalQtyReceived += mvq.qtyReceived;
				}
		
	}
	
	public void barcodeNotFound(String barcode, double qty) {
		if (this.receiving == null)
			loadReceiving();
		/*
		ReceivingItem receivingItem = searchReceivingItem(barcode);
		
		if (receivingItem == null){
			Model modelNotFound = new Model();
			modelNotFound.idmodel = 0;
			modelNotFound.description = barcode;
			receivingItem = newModelVerifyQty(modelNotFound);
			this.receiving.addItem(receivingItem);
		}
		
		receivingItem.qtyReceived += qty;
		this.receiving.subtotal += (receivingItem.newcostprice * receivingItem.qty);
		totalQtyReceived += qty;
		
		DAOUtil.getDAO(Receiving.class, IParentDAO.DATABASE_DB4O).save(this.receiving);
		*/
		
		calcReceivingTotals();
		
		if (activeCard.equals(ReceivingDetail.class.getName()))
			receivingDetail.refreshTable(receiving);
		
		refreshReceivingTotals();
	}

	public void onNew() {
		newReceiving();
	}
	
	public void newReceiving(){
		IParentDAO dao = DAOUtil.getDAO(Receiving.class, IParentDAO.DATABASE_DB4O);
		if (receiving != null){
			dao.delete(receiving);
			receiving = null;
		}
		receivingDetail.refreshTable(receiving);			
		getJlbNumProd().setText("0");
		
		refreshReceivingTotals();
		
		cardLayout.show(getJpnDetail(), ReceivingDetail.class.getName());
	}

	public void importPO() {
		cardLayout.show(getJpnDetail(), SelectDocument.class.getName());
	}

	public void finish() {
		if (receiving != null){
			receivingFinish.setReceiving(receiving);
			receivingFinish.setReceivingEditionListener(this);
			cardLayout.show(getJpnDetail(), ReceivingFinish.class.getName());
		}
	}
	
	public void save() {
		saveReceiving();
	}

	public String getDocumentNumber() {
		return documentNumber;
	}

	public void setDocumentNumber(String documentNumber) {
		this.documentNumber = documentNumber;
	}

	public Receiving getReceiving() {
		return receiving;
	}

	public void setReceiving(Receiving receiving) {
		this.receiving = receiving;
	}
	
	public void showReceivingDetail(){
		receivingDetail.refreshTable(this.receiving);			
		cardLayout.show(getJpnDetail(), ReceivingDetail.class.getName());
		calcReceivingTotals();
		refreshReceivingTotals();
	}

	private void saveReceiving(){
		ConnectionManager manager = new ConnectionManager();
		manager.setUrlPath(Config.getInstance().getHost());
		manager.setServlet(RECEIVING_SERVLET);
		manager.setConnectionManagerListener(new ReceivingSaveManager(this));
		manager.send();
	}

	public void itemChanged(Object item, double oldQty) {
		DAOUtil.getDAO(Receiving.class, IParentDAO.DATABASE_DB4O).save(receiving);
		refreshReceivingTotals();
	}

}

class ReceivingImportManager implements ConnectionManagerListener{
	ReceivingScreenFch screen;
	
	public ReceivingImportManager(ReceivingScreenFch screen){
		super();
		this.screen = screen;
	}
	

	public void dataOutput(ObjectOutputStream oos) {
		try {			
			Receiving pvr = new Receiving();
			pvr.documentnumber = screen.getDocumentNumber();
			oos.writeObject(pvr);		
		} catch (Exception e) {
			e.printStackTrace();
			MsgBox.errorMsg(screen, e.getMessage());
		}
	}

	public void dataInput(ObjectInputStream ois) {
		screen.setReceiving(null);
		try {
			try{
				Object o = ois.readObject();
				screen.setReceiving((Receiving)(o));
			} catch (EOFException e) {
			}
			
			IParentDAO dao = DAOUtil.getDAO(Receiving.class, IParentDAO.DATABASE_DB4O);
			
			dao.save(screen.getReceiving());
			
			screen.showReceivingDetail();
			
		} catch (Exception e) {
			e.printStackTrace();
			MsgBox.errorMsg(screen, e.getMessage());
		}
	}

	public void httpError(int errorCode, String errorMsg) {
		MsgBox.errorMsg(screen, errorCode + " " + errorMsg);
		
	}

	public void connectionException(Exception e) {
		e.printStackTrace();
		MsgBox.errorMsg(screen, e.getMessage());
	}
	
}

class ReceivingSaveManager implements ConnectionManagerListener{
	ReceivingScreenFch screen;
	
	public ReceivingSaveManager(ReceivingScreenFch screen){
		super();
		this.screen = screen;
	}
	
	public void dataOutput(ObjectOutputStream oos) {
		try {			
			oos.writeObject(screen.getReceiving());		
		} catch (Exception e) {
			e.printStackTrace();
			MsgBox.errorMsg(screen, e.getMessage());
		}
	}

	public void dataInput(ObjectInputStream ois) {
		try {
			try{
				Object o = ois.readObject();
				if (o instanceof Receiving) {
					MsgBox.infoMsg(screen, LanguageResource.getInstance().getText("MSG_INFO_RECEIVING_NUMBER") + " " + ((Receiving)o).idpurchase);
				}
				
			} catch (EOFException e) {
			}
			
			screen.newReceiving();
			
		} catch (Exception e) {
			e.printStackTrace();
			MsgBox.errorMsg(screen, e.getMessage());
		}

		
	}

	public void httpError(int errorCode, String errorMsg) {
		MsgBox.errorMsg(screen, errorCode + " " + errorMsg);
		
	}

	public void connectionException(Exception e) {
		e.printStackTrace();
		MsgBox.errorMsg(screen, e.getMessage());
	}
	
}


