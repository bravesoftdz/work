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
import com.mainretail.commun.model.inventory.IInvCountDAO;
import com.mainretail.commun.model.inventory.InvCount;
import com.mainretail.commun.model.inventory.InvCountItem;
import com.mainretail.commun.model.inventory.Model;
import com.mainretail.commun.ui.ApplicationManager;
import com.mainretail.commun.ui.ModelSearch;
import com.mainretail.commun.ui.MsgBox;
import com.mainretail.commun.ui.ParentFormFch;
import com.mainretail.inventory.event.CountingListener;
import java.awt.BorderLayout;

public class CountingScreenFch extends ParentFormFch implements CountingListener, ModelItemListener, ConnectionManagerListener {
	private static final long serialVersionUID = 1520653107861394572L;
	
	private static String COUNTING_SERVLET = "countingservlet";
	
	private JButton jbtCount;
	//private JButton jbtModelSearch;
	private CardLayout cardLayout;
	private CountingDetail countingDetail;
	private JLabel jlbNumProducts;
	private JLabel jlbNumProd;
	private JPanel jpnNumProd;
	
	private String activeCard;
	
	private InvCount invCount;

	public CountingScreenFch() {
		super();
	}
	
	public CountingScreenFch(ApplicationManager appManager, NavigationManager navManager, InvCount invCount){
		super(appManager, navManager);
		this.invCount = invCount;
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
		loadCounting();
		
		countingDetail = new CountingDetail(this, this);
					
		getJpnDetail().add(CountingDetail.class.getName(), countingDetail);
		countingDetail.refreshTable(invCount);
		getJpnDetail().add(ModelSearch.class.getName(), new ModelSearch(ModelSearch.SCREEN_TYPE_SALE, this));
		
		cardLayout = (CardLayout) (getJpnDetail().getLayout());

		getJpnlInfo().add(getJpnNumProd(), BorderLayout.EAST);
		getJpnNumProd().add(getJlbNumProducts());
		getJpnNumProd().add(getJlbNumProd());

		getJpnlInfo().setPreferredSize(new java.awt.Dimension(400, 17));
		super.getJpnlButtons().setPreferredSize(new java.awt.Dimension(400, 36));
		
		activeCard = CountingDetail.class.getName();
	}
	
	protected void buildButtons(){
		super.buildButtons();
		insertButton(getJbtCount());
		//insertButton(getJbtModelSearch());
	}
	
	public JButton getJbtCount(){
		if (jbtCount == null)
			jbtCount = MRIcon.createButton("", "count");
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
			activeCard = CountingDetail.class.getName();
			countingDetail.refreshTable(invCount);
		} /*else if (evt.getSource() == getJbtModelSearch()){
			cardLayout.show(getJpnDetail(), ModelSearch.class.getName());
			activeCard = ModelSearch.class.getName();
		} */else
			super.onActionPerformed(evt);
	}

	public void itemAdded(Object model, String barcode, double qty) {
		subItemAdd(model, barcode, qty);
	}
	
	private void subItemAdd(Object model, String barcode, double qty){
		
		if (invCount == null)
			loadCounting();
		
		InvCountItem invCountItem = new InvCountItem();
		
		if (model != null){
			invCountItem.description = ((Model)model).description;
			invCountItem.idmodel = ((Model)model).idmodel;
		}
		invCountItem.barcode = barcode;
		invCountItem.iduser = RuntimeInfo.getInstance().user.iduser;
		invCountItem.idcount = invCount.idcount;
		invCountItem.qty = qty;

		
		invCount.addItem(invCountItem);
		//DAOUtil.getDAO(Sale.class, IParentDAO.DATABASE_DB4O).delete(sale);
		
		DAOUtil.getDAO(InvCount.class, IParentDAO.DATABASE_DB4O).save(invCount);
		
		if (activeCard.equals(CountingDetail.class.getName()))
			countingDetail.refreshTable(invCount);
		
		refreshCountTotals();
		
	}
	
	private void loadCounting(){
		IInvCountDAO dao = (IInvCountDAO)(DAOUtil.getDAO(InvCount.class, IParentDAO.DATABASE_DB4O));
	
		dao.deleteGarbageCount(invCount);
		
		InvCount tempInvCount = dao.getOpenCounting(invCount.counttype);
		if (tempInvCount != null){
			invCount = tempInvCount;
		}
		refreshCountTotals();
	}

	public void itemRemoved(Object item) {
		invCount.removeItem((InvCountItem)item);
		DAOUtil.getDAO(InvCount.class, IParentDAO.DATABASE_DB4O).save(invCount);
		countingDetail.refreshTable(invCount);
		refreshCountTotals();
	}

	public void countFinalize(Object invCount) {
		DAOUtil.getDAO(InvCount.class, IParentDAO.DATABASE_DB4O).save(this.invCount);
		//this.invCount = null;
		sendCounts();
		//countingDetail.refreshTable(this.invCount);
		//refreshCountTotals();
	}

	public void countRemove(Object invCount) {
		IParentDAO dao = DAOUtil.getDAO(InvCount.class, IParentDAO.DATABASE_DB4O);
		//dao.delete(this.invCount);
		this.invCount.clear();
		dao.save(this.invCount);
		//this.invCount = null;
		countingDetail.refreshTable(this.invCount);
		refreshCountTotals();
	}
	
	
	private void sendCounts(){
		ConnectionManager manager = new ConnectionManager();
		manager.setUrlPath(Config.getInstance().getHost());
		manager.setServlet(COUNTING_SERVLET);
		manager.setConnectionManagerListener(this);
		manager.send();		
	}
	

	public void dataOutput(ObjectOutputStream oos) {
		try {
			oos.writeObject(this.invCount);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	
	private void refreshCountTotals(){
		if (this.invCount == null){
			getJlbNumProd().setText("0");
		} else {
			if (this.invCount.items != null)
				getJlbNumProd().setText(String.valueOf(this.invCount.items.size()));
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
		countRemove(this.invCount);
		
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
		if (invCount.counttype != InvCount.INV_COUNT_LIVE) {
			subItemAdd(null, barcode, qty);
		}
	}

	public void itemChanged(Object item, double oldQty) {
		DAOUtil.getDAO(InvCount.class, IParentDAO.DATABASE_DB4O).save(invCount);
		refreshCountTotals();
	}

	public InvCount getInvCount() {
		return invCount;
	}

}
