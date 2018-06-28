package com.mainretail.inventory.ui;

import java.awt.CardLayout;
import java.awt.Font;
import java.awt.event.ActionEvent;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
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
import com.mainretail.commun.model.inventory.BarcodePrintItem;
import com.mainretail.commun.model.inventory.BarcodePrintList;
import com.mainretail.commun.model.inventory.IBarcodePrintListDAO;
import com.mainretail.commun.ui.ApplicationManager;
import com.mainretail.commun.ui.ModelSearch;
import com.mainretail.commun.ui.MsgBox;
import com.mainretail.commun.ui.ParentFormFch;
import com.mainretail.inventory.event.BarcodePrintListListener;
import java.awt.BorderLayout;

public class BarcodePrintListFch extends ParentFormFch implements BarcodePrintListListener, ModelItemListener, ConnectionManagerListener {
	private static final long serialVersionUID = 1520653107861394572L;
	
	private static String COUNTING_SERVLET = "barcodeprintlistservlet";
	
	private JButton jbtCount;
	//private JButton jbtModelSearch;
	private CardLayout cardLayout;
	private BarcodePrintListDetail barcodePrintListDetail;
	private JLabel jlbNumProducts;
	private JLabel jlbNumProd;
	private JPanel jpnNumProd;
	
	private BarcodePrintList barcodePrintList;
	
	public BarcodePrintListFch() {
		super();
	}
	
	public BarcodePrintListFch(ApplicationManager appManager, NavigationManager navManager){
		super(appManager, navManager);
		init();
	}
	
	public void initGUI() {
		try {
			this.setPreferredSize(new java.awt.Dimension(400, 300));
			super.initGUI();
			

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private void init(){
		loadBarcodePrintList();
		
		barcodePrintListDetail = new BarcodePrintListDetail(this, this);
					
		getJpnDetail().add(BarcodePrintListDetail.class.getName(), barcodePrintListDetail);
		barcodePrintListDetail.refreshTable(barcodePrintList);
		getJpnDetail().add(ModelSearch.class.getName(), new ModelSearch(ModelSearch.SCREEN_TYPE_SALE, this));
		
		cardLayout = (CardLayout) (getJpnDetail().getLayout());

		getJpnlInfo().add(getJpnNumProd(), BorderLayout.EAST);
		getJpnNumProd().add(getJlbNumProducts());
		getJpnNumProd().add(getJlbNumProd());

		getJpnlInfo().setPreferredSize(new java.awt.Dimension(400, 17));
		super.getJpnlButtons().setPreferredSize(new java.awt.Dimension(400, 36));
		
	}
	
	protected void buildButtons(){
		super.buildButtons();
		insertButton(getJbtCount());
		//insertButton(getJbtModelSearch());
	}
	
	public JButton getJbtCount(){
		if (jbtCount == null)
			jbtCount = MRIcon.createButton("", "barcode_queu");
		return jbtCount;		
	}
	
	/*
	public JButton getJbtModelSearch(){
		if (jbtModelSearch == null)
			jbtModelSearch = MRIcon.createButton("", "search");
		return jbtModelSearch;		
	}*/
	
	public void onActionPerformed(ActionEvent evt){
		if (evt.getSource() == getJbtCount()){
			cardLayout.show(getJpnDetail(), CountingDetail.class.getName());
			barcodePrintListDetail.refreshTable(barcodePrintList);
		} /*else if (evt.getSource() == getJbtModelSearch()){
			cardLayout.show(getJpnDetail(), ModelSearch.class.getName());
			activeCard = ModelSearch.class.getName();
		} */else
			super.onActionPerformed(evt);
	}

	public void itemAdded(Object model, String barcode, double qty) {

		if (barcodePrintList == null)
			loadBarcodePrintList();
		
		BarcodePrintItem barcodePrintItem = new BarcodePrintItem();
		
		barcodePrintItem.idbarcode = barcode;
		barcodePrintItem.iduser = RuntimeInfo.getInstance().user.iduser;
		barcodePrintItem.qty = (int)qty;

		
		barcodePrintList.addItem(barcodePrintItem);
		//DAOUtil.getDAO(Sale.class, IParentDAO.DATABASE_DB4O).delete(sale);
		
		DAOUtil.getDAO(BarcodePrintList.class, IParentDAO.DATABASE_DB4O).save(barcodePrintList);
		
		barcodePrintListDetail.refreshTable(barcodePrintList);
		refreshCountTotals();
	}
	
	private void loadBarcodePrintList(){
		IBarcodePrintListDAO dao = (IBarcodePrintListDAO)(DAOUtil.getDAO(BarcodePrintList.class, IParentDAO.DATABASE_DB4O));
	
		barcodePrintList = dao.getOpenBarcodePrintList();
		if (barcodePrintList == null){
			barcodePrintList = new BarcodePrintList();
		}
		refreshCountTotals();
	}

	public void itemRemoved(Object item) {
		barcodePrintList.removeItem((BarcodePrintItem)item);
		DAOUtil.getDAO(BarcodePrintList.class, IParentDAO.DATABASE_DB4O).save(barcodePrintList);
		barcodePrintListDetail.refreshTable(barcodePrintList);
		refreshCountTotals();
	}

	public void countFinalize(Object barcodePrintList) {
		DAOUtil.getDAO(BarcodePrintList.class, IParentDAO.DATABASE_DB4O).save(this.barcodePrintList);
		sendBarcodePrintList();
	}

	public void countRemove(Object barcodePrintList) {
		IParentDAO dao = DAOUtil.getDAO(BarcodePrintList.class, IParentDAO.DATABASE_DB4O);
		this.barcodePrintList.clear();
		dao.save(this.barcodePrintList);
		barcodePrintListDetail.refreshTable(this.barcodePrintList);
		refreshCountTotals();
	}
	
	
	private void sendBarcodePrintList(){
		ConnectionManager manager = new ConnectionManager();
		manager.setUrlPath(Config.getInstance().getHost());
		manager.setServlet(COUNTING_SERVLET);
		manager.setConnectionManagerListener(this);
		manager.send();		
	}
	

	public void dataOutput(ObjectOutputStream oos) {
		try {
			oos.writeObject(this.barcodePrintList);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	
	private void refreshCountTotals(){
		if (this.barcodePrintList == null){
			getJlbNumProd().setText("0");
		} else {
			if (this.barcodePrintList.items != null)
				getJlbNumProd().setText(String.valueOf(this.barcodePrintList.items.size()));
		}
	}
	
	public void dataInput(ObjectInputStream ois) {
		
		/*InvCount invCount = null;
		try {
			invCount = (InvCount) ois.readObject();
		} catch (OptionalDataException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		*/
		countRemove(this.barcodePrintList);
		
	}
	
	public void httpError(int errorCode, String errorMsg) {
		MsgBox.errorMsg(this, errorCode + " " + errorMsg);		
	}

	public void connectionException(Exception e) {
		MsgBox.errorMsg(this, e.getMessage());		
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

	public JPanel getJpnNumProd() {
		if (jpnNumProd == null) {
			jpnNumProd = new JPanel();
			jpnNumProd.setBackground(this.getBackground());
		}
		return jpnNumProd;
	}

	public void barcodeNotFound(String barcode, double qty) {
		//itemAdded(null, barcode, qty);
	}

	public void itemChanged(Object item, double oldQty) {
		DAOUtil.getDAO(BarcodePrintList.class, IParentDAO.DATABASE_DB4O).save(barcodePrintList);
		refreshCountTotals();
	}

	public BarcodePrintList getBarcodePrintList() {
		return barcodePrintList;
	}

}
