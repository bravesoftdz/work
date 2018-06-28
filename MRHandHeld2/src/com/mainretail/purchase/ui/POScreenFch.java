package com.mainretail.purchase.ui;

import java.awt.BorderLayout;
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
import com.mainretail.commun.event.ConnectionManagerListener;
import com.mainretail.commun.event.ModelItemListener;
import com.mainretail.commun.model.Config;
import com.mainretail.commun.model.DAOUtil;
import com.mainretail.commun.model.IParentDAO;
import com.mainretail.commun.model.inventory.Model;
import com.mainretail.commun.model.purchase.IPODAO;
import com.mainretail.commun.model.purchase.PO;
import com.mainretail.commun.model.purchase.POItem;
import com.mainretail.commun.model.sale.Sale;
import com.mainretail.commun.ui.ApplicationManager;
import com.mainretail.commun.ui.BarcodeSearch;
import com.mainretail.commun.ui.ModelSearch;
import com.mainretail.commun.ui.MsgBox;
import com.mainretail.commun.ui.ParentFormFch;
import com.mainretail.purchase.event.DocumentListener;
import com.mainretail.purchase.event.POEditionListener;

public class POScreenFch extends ParentFormFch implements ModelItemListener, DocumentListener, POEditionListener {
	private static final long serialVersionUID = 1L;

	private static String PO_SERVLET = "poservlet";
	
	private double totalQty;
	private double totalQtyReceived;
	private JButton jbtPO;
	private JLabel jlbAmount;
	private JLabel jlbPOTotal;
	private JButton jbtModelSearch;
	private CardLayout cardLayout;
	private PODetail poDetail;
	private PO po;
	
	private SelectDocument selectDocument;
	private POFinish poFinish;

	private BarcodeSearch barcodeSearch;
	private JButton jbtBarcodeSearch;
	private JLabel jlbNumProducts;
	private JLabel jlbNumProd;
	private JPanel jpnNumProd;
	private JPanel jpnlPOTotal;

	private String documentNumber;
	
	private String activeCard;

	public POScreenFch() {
		super();
	}
	
	public POScreenFch(ApplicationManager appManager, NavigationManager navManager){
		super(appManager, navManager);
	}
	
	public void initGUI() {
		try {
			this.setPreferredSize(new java.awt.Dimension(400, 300));
			super.initGUI();
			
			cardLayout = (CardLayout) (getJpnDetail().getLayout());
			
			poFinish = new POFinish();
			getJpnDetail().add(POFinish.class.getName(), poFinish);
			
			selectDocument = new SelectDocument();
			selectDocument.setDocumentListener(this);
			getJpnDetail().add(SelectDocument.class.getName(), selectDocument);
			
			poDetail = new PODetail(this, this);
			getJpnDetail().add(PODetail.class.getName(), poDetail);
			
			loadPO();
			cardLayout.show(getJpnDetail(), PODetail.class.getName());
			
			getJpnDetail().add(ModelSearch.class.getName(), new ModelSearch(ModelSearch.SCREEN_TYPE_PURCHASE, this));
			barcodeSearch = new BarcodeSearch();
			barcodeSearch.setModelItemListener(this);
			getJpnDetail().add(BarcodeSearch.class.getName(), barcodeSearch);

			getJpnlInfo().add(getJpnlPOTotal(), BorderLayout.WEST);
			getJpnlPOTotal().add(getJlbPOTotal());
			getJpnlPOTotal().add(getJlbAmount());
			
			getJpnlInfo().add(getJpnNumProd(), BorderLayout.EAST);
			getJpnNumProd().add(getJlbNumProducts());
			getJpnNumProd().add(getJlbNumProd());

			getJpnlInfo().setPreferredSize(new java.awt.Dimension(400, 17));
			super.getJpnlButtons().setPreferredSize(new java.awt.Dimension(400, 36));
			
			activeCard = PODetail.class.getName();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	protected void buildButtons(){
		super.buildButtons();
		insertButton(getJbtPO());
		insertButton(getJbtModelSearch());
		insertButton(getJbtBarcodeSearch());
	}
	
	private JButton getJbtBarcodeSearch() {
		if (jbtBarcodeSearch == null)
			jbtBarcodeSearch = MRIcon.createButton("", "scan");
		return jbtBarcodeSearch;
	}

	public JButton getJbtPO(){
		if (jbtPO == null)
			jbtPO = MRIcon.createButton("", "purchaseitems");
		return jbtPO;		
	}
	
	public JButton getJbtModelSearch(){
		if (jbtModelSearch == null)
			jbtModelSearch = MRIcon.createButton("", "search");
		return jbtModelSearch;		
	}
	
	public void onActionPerformed(ActionEvent evt){
		if (evt.getSource() == getJbtPO()){
			cardLayout.show(getJpnDetail(), PODetail.class.getName());
			activeCard = PODetail.class.getName();
			poDetail.refreshTable(po);
			calcPOTotals();
			refreshPOTotals();
		} else if (evt.getSource() == getJbtModelSearch()){
			cardLayout.show(getJpnDetail(), ModelSearch.class.getName());
			activeCard = ModelSearch.class.getName();
		} else if (evt.getSource() == getJbtBarcodeSearch()){
			cardLayout.show(getJpnDetail(), BarcodeSearch.class.getName());	
			activeCard = BarcodeSearch.class.getName();
		} else
			super.onActionPerformed(evt);
	}

	public void itemAdded(Object model, String barcode, double qty) {
		if (this.po == null)
			loadPO();
		
		POItem poItem = searchModelVerify(((Model)model).idmodel, qty);
		
		if (poItem == null){
			poItem = newPOItem(((Model)model));
			poItem.barcode = barcode;
			poItem.qty += qty;
			this.po.addItem(poItem);
		}
		this.po.subtotal += qty * poItem.costprice;
		
		totalQtyReceived += qty; 
		
		DAOUtil.getDAO(PO.class, IParentDAO.DATABASE_DB4O).save(po);
		
		
		if (activeCard.equals(PODetail.class.getName()))
			poDetail.refreshTable(this.po);	
		
		refreshPOTotals();
	}
	
	
	private POItem newPOItem(Model model) {
		POItem result = new POItem();
		result.idmodel = model.idmodel;
		result.description = model.description;
		result.costprice = model.vendorcost;
		return result;
	}

	private POItem searchModelVerify(int idmodel, double qty){
		POItem result = null;
		for (int i = 0; i < this.po.getItems().size(); i++){
			POItem testing =  (POItem) this.po.getItems().get(i);
			if (testing.idmodel == idmodel){
				testing.qty += qty;
				result = testing;
				break;
			}
		}
		return result;
	}
	
	private POItem searchPOItem(String description){
		POItem result = null;
		for (int i = 0; i < this.po.getItems().size(); i++){
			POItem testing =  (POItem) this.po.getItems().get(i);
			if (testing.description.equals(description)){
				result = testing;
			}
		}
		return result;
	}
	
	private void loadPO(){
		IPODAO dao = (IPODAO)(DAOUtil.getDAO(PO.class, IParentDAO.DATABASE_DB4O));
		
		this.po = dao.getActivePO();
		
		if (this.po == null){
			this.po = new PO();
			this.po.idstore = Config.getInstance().getIDStore();
			//this.po.iduserprereceiving = RuntimeInfo.getInstance().user.iduser;
		}
		
		poDetail.refreshTable(po);			
		
		
		calcPOTotals();
		refreshPOTotals();
	}
	
	public void itemRemoved(Object item) {
		po.removeItem((POItem)item);
		DAOUtil.getDAO(Sale.class, IParentDAO.DATABASE_DB4O).save(po);
		poDetail.refreshTable(po);
	}

	public JLabel getJlbPOTotal() {
		if (jlbPOTotal == null){
			jlbPOTotal = new JLabel();
			jlbPOTotal.setText("Total :");
			jlbPOTotal.setFont(new java.awt.Font("Tahoma", Font.PLAIN ,10));
		}
		return jlbPOTotal;
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

	private JPanel getJpnlPOTotal() {
		if (jpnlPOTotal == null) {
			jpnlPOTotal = new JPanel();
			jpnlPOTotal.setBackground(this.getBackground());
		}
		return jpnlPOTotal;
	}
	
	public JPanel getJpnNumProd() {
		if (jpnNumProd == null) {
			jpnNumProd = new JPanel();
			jpnNumProd.setBackground(this.getBackground());
		}
		return jpnNumProd;
	}

	public void documentEntered(String document) {
		newPO();
		documentNumber = document;
		requestPO();
	}
	
	public void requestPO(){
		
	}


	private void refreshPOTotals(){
		if (this.po == null){
			getJlbNumProd().setText("0");
			getJlbAmount().setText("0.00");
		} else {
			if (this.po.getItems() != null){
				getJlbNumProd().setText(String.valueOf(totalQty) + "/" + String.valueOf(totalQtyReceived));
				DecimalFormat formatter = new DecimalFormat("##0.00");
				getJlbAmount().setText(formatter.format(po.subtotal));
			}
		}
	}
	
	private void calcPOTotals(){
	
		totalQty = 0;
		totalQtyReceived = 0;
		
		if (this.po != null)
			if (this.po.getItems() != null)
				for(int i=0; i < this.po.getItems().size(); i++){
					POItem mvq = (POItem)(this.po.getItems().get(i));
					totalQty += mvq.qty;
					//totalQtyReceived += mvq.qtyReceived;
				}
		
	}
	
	public void barcodeNotFound(String barcode, double qty) {
		if (this.po == null)
			loadPO();
		
		POItem poItem = searchPOItem(barcode);
		
		if (poItem == null){
			Model modelNotFound = new Model();
			modelNotFound.idmodel = 0;
			modelNotFound.description = barcode;
			poItem = newPOItem(modelNotFound);
			this.po.addItem(poItem);
		}
		
		poItem.qty += qty;
		this.po.subtotal += (poItem.costprice * poItem.qty);
		totalQtyReceived += qty;
		
		DAOUtil.getDAO(PO.class, IParentDAO.DATABASE_DB4O).save(this.po);
		
		calcPOTotals();
		refreshPOTotals();
	}

	public void onNew() {
		newPO();
	}
	
	public void newPO(){
		IParentDAO dao = DAOUtil.getDAO(PO.class, IParentDAO.DATABASE_DB4O);
		if (po != null){
			dao.delete(po);
			po = null;
		}
		poDetail.refreshTable(po);			
		getJlbNumProd().setText("0");
		
		refreshPOTotals();
		
		cardLayout.show(getJpnDetail(), PODetail.class.getName());
	}

	public void importPO() {
		cardLayout.show(getJpnDetail(), SelectDocument.class.getName());
	}

	public void finish() {
		if (po != null){
			poFinish.setPo(po);
			poFinish.setEditionListener(this);
			cardLayout.show(getJpnDetail(), POFinish.class.getName());
		}
	}
	
	public void save() {
		savePO();
	}

	public String getDocumentNumber() {
		return documentNumber;
	}

	public void setDocumentNumber(String documentNumber) {
		this.documentNumber = documentNumber;
	}

	public PO getPo() {
		return po;
	}

	public void setPo(PO po) {
		this.po = po;
	}
	
	public void showPODetail(){
		poDetail.refreshTable(this.po);			
		cardLayout.show(getJpnDetail(), PODetail.class.getName());
		calcPOTotals();
		refreshPOTotals();
	}

	private void savePO(){
		ConnectionManager manager = new ConnectionManager();
		manager.setUrlPath(Config.getInstance().getHost());
		manager.setServlet(PO_SERVLET);
		manager.setConnectionManagerListener(new POSaveManager(this));
		manager.send();
	}

	public void itemChanged(Object item, double oldQty) {
		DAOUtil.getDAO(PO.class, IParentDAO.DATABASE_DB4O).save(po);
		refreshPOTotals();
	}

}


class POSaveManager implements ConnectionManagerListener{
	POScreenFch screen;
	
	public POSaveManager(POScreenFch screen){
		super();
		this.screen = screen;
	}
	
	public void dataOutput(ObjectOutputStream oos) {
		try {			
			oos.writeObject(screen.getPo());		
		} catch (Exception e) {
			e.printStackTrace();
			MsgBox.errorMsg(screen, e.getMessage());
		}
	}

	public void dataInput(ObjectInputStream ois) {
		try {
			try{
				Object o = ois.readObject();
				if (o instanceof PO) {
					MsgBox.infoMsg(screen, LanguageResource.getInstance().getText("MSG_INFO_PO_NUMBER") + " " + ((PO)o).idpo);
				}
				
			} catch (EOFException e) {
			}
			
			screen.newPO();
			
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


