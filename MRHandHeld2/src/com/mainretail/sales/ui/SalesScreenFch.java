package com.mainretail.sales.ui;

import java.awt.CardLayout;
import java.awt.Font;
import java.awt.event.ActionEvent;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.Vector;

import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;

import com.mainretail.MRIcon;
import com.mainretail.commun.controller.LanguageResource;
import com.mainretail.commun.controller.NavigationManager;
import com.mainretail.commun.controller.RuntimeInfo;
import com.mainretail.commun.event.ModelItemListener;
import com.mainretail.commun.model.Config;
import com.mainretail.commun.model.DAOUtil;
import com.mainretail.commun.model.IParentDAO;
import com.mainretail.commun.model.inventory.Model;
import com.mainretail.commun.model.sale.ISaleDAO;
import com.mainretail.commun.model.sale.Sale;
import com.mainretail.commun.model.sale.SaleItem;
import com.mainretail.commun.ui.ApplicationManager;
import com.mainretail.commun.ui.BarcodeSearch;
import com.mainretail.commun.ui.ModelSearch;
import com.mainretail.commun.ui.ParentFormFch;
import com.mainretail.sales.controller.SaleSynch;
import com.mainretail.sales.event.SaleListener;
import com.mainretail.sales.event.SaleSynchListener;

import java.awt.BorderLayout;

public class SalesScreenFch extends ParentFormFch implements SaleListener, ModelItemListener, SaleSynchListener {
	private static final long serialVersionUID = 1520653107861394572L;
	
	
	private JButton jbtSale;
	private JLabel jlbAmount;
	private JLabel jlbSaleTotal;
	private JButton jbtModelSearch;
	private JButton jbtBarcodeSearch;
	private CardLayout cardLayout;
	private SaleDetail saleDetail;
	private BarcodeSearch barcodeSearch;
	private Sale sale;
	private SalesResult salesResult;

	private JLabel jlbNumProducts;
	private JLabel jlbNumProd;
	private JPanel jpnNumProd;
	private JPanel jpnlSaleTotal;
	private SaleSynch saleSynch;
	
	private String activeCard;

	public SalesScreenFch() {
		super();
	}
	
	public SalesScreenFch(ApplicationManager appManager, NavigationManager navManager){
		super(appManager, navManager);
	}
	
	public void initGUI() {
		try {
			this.setPreferredSize(new java.awt.Dimension(400, 300));
			super.initGUI();
			
			loadSale();
			
			saleSynch = new SaleSynch(this, this);
			saleDetail = new SaleDetail(this, this, saleSynch);
						
			getJpnDetail().add(SaleDetail.class.getName(), saleDetail);
			saleDetail.refreshTable(sale);
			getJpnDetail().add(ModelSearch.class.getName(), new ModelSearch(ModelSearch.SCREEN_TYPE_SALE, this));

			barcodeSearch = new BarcodeSearch();
			barcodeSearch.setModelItemListener(this);
			getJpnDetail().add(BarcodeSearch.class.getName(), barcodeSearch);
			
			salesResult = new SalesResult();
			getJpnDetail().add(SalesResult.class.getName(), salesResult);
			
			cardLayout = (CardLayout) (getJpnDetail().getLayout());

			getJpnlInfo().add(getJpnlSaleTotal(), BorderLayout.WEST);
			getJpnlSaleTotal().add(getJlbSaleTotal());
			getJpnlSaleTotal().add(getJlbAmount());
			
			getJpnlInfo().add(getJpnNumProd(), BorderLayout.EAST);
			getJpnNumProd().add(getJlbNumProducts());
			getJpnNumProd().add(getJlbNumProd());

			getJpnlInfo().setPreferredSize(new java.awt.Dimension(400, 17));
			super.getJpnlButtons().setPreferredSize(new java.awt.Dimension(400, 36));
			
			activeCard = SaleDetail.class.getName();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	protected void buildButtons(){
		super.buildButtons();
		insertButton(getJbtSale());
		insertButton(getJbtModelSearch());
		insertButton(getJbtBarcodeSearch());
	}
	
	private JButton getJbtBarcodeSearch() {
		if (jbtBarcodeSearch == null)
			jbtBarcodeSearch = MRIcon.createButton("", "scan");
		return jbtBarcodeSearch;
	}
	
	public JButton getJbtSale(){
		if (jbtSale == null)
			jbtSale = MRIcon.createButton("", "sale");
		return jbtSale;		
	}
	
	public JButton getJbtModelSearch(){
		if (jbtModelSearch == null)
			jbtModelSearch = MRIcon.createButton("", "search");
		return jbtModelSearch;		
	}
	
	public void onActionPerformed(ActionEvent evt){
		if (evt.getSource() == getJbtSale()){
			cardLayout.show(getJpnDetail(), SaleDetail.class.getName());
			activeCard = SaleDetail.class.getName();
			saleDetail.refreshTable(sale);
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
		if (sale == null)
			loadSale();
		
		SaleItem saleItem = new SaleItem();
		
		saleItem.idmodel = ((Model)model).idmodel;
		saleItem.description = ((Model)model).description;
		saleItem.costprice = ((Model)model).vendorcost;
		saleItem.salePrice = ((Model)model).sellingprice;
		
		saleItem.qty = qty;
		
		sale.addItem(saleItem);
		//DAOUtil.getDAO(Sale.class, IParentDAO.DATABASE_DB4O).delete(sale);
		
		DAOUtil.getDAO(Sale.class, IParentDAO.DATABASE_DB4O).save(sale);
		
		if (activeCard.equals(SaleDetail.class.getName()))
			saleDetail.refreshTable(sale);
		
		refreshSaleTotals();
	}
	
	private void loadSale(){
		ISaleDAO dao = (ISaleDAO)(DAOUtil.getDAO(Sale.class, IParentDAO.DATABASE_DB4O));
		
		sale = dao.getOpenSale();
		if (sale == null){
			sale = new Sale(Config.getInstance().getIDStore(), new Date(), RuntimeInfo.getInstance().user);
		}
		refreshSaleTotals();
	}

	public void itemRemoved(Object item) {
		sale.removeItem((SaleItem)item);
		DAOUtil.getDAO(Sale.class, IParentDAO.DATABASE_DB4O).save(sale);
		saleDetail.refreshTable(sale);
		refreshSaleTotals();
	}

	public void saleFinalize(Object sale) {
		this.sale.finalized = true;
		DAOUtil.getDAO(Sale.class, IParentDAO.DATABASE_DB4O).save(this.sale);
		this.sale = null;
		saleSynch.sendSales();
		saleDetail.refreshTable(this.sale);
		refreshSaleTotals();
	}

	public void saleRemove(Object sale) {
		IParentDAO dao = DAOUtil.getDAO(Sale.class, IParentDAO.DATABASE_DB4O);
		dao.delete(this.sale);
		this.sale = null;
		saleDetail.refreshTable(this.sale);
		refreshSaleTotals();
	}
	

	private void refreshSaleTotals(){
		if (this.sale == null){
			getJlbAmount().setText("0.00");
			getJlbNumProd().setText("0");
		} else {
			DecimalFormat formatter = new DecimalFormat("##0.00");
			getJlbAmount().setText(formatter.format(this.sale.getSaleTotal()));
			if (this.sale.items != null)
				getJlbNumProd().setText(String.valueOf(this.sale.items.size()));
		}
	}
	

	public JLabel getJlbSaleTotal() {
		if (jlbSaleTotal == null){
			jlbSaleTotal = new JLabel();
			jlbSaleTotal.setText("Total :");
			jlbSaleTotal.setFont(new java.awt.Font("Tahoma", Font.PLAIN ,10));
		}
		return jlbSaleTotal;
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

	private JPanel getJpnlSaleTotal() {
		if (jpnlSaleTotal == null) {
			jpnlSaleTotal = new JPanel();
			jpnlSaleTotal.setBackground(this.getBackground());
		}
		return jpnlSaleTotal;
	}
	
	public JPanel getJpnNumProd() {
		if (jpnNumProd == null) {
			jpnNumProd = new JPanel();
			jpnNumProd.setBackground(this.getBackground());
		}
		return jpnNumProd;
	}

	public void barcodeNotFound(String barcode, double qty) {
		// TODO Auto-generated method stub
		
	}

	public void itemChanged(Object item, double oldQty) {
		DAOUtil.getDAO(Sale.class, IParentDAO.DATABASE_DB4O).save(sale);
		refreshSaleTotals();
	}

	public void afterSynch(Vector salesList) {
		salesResult.setSales(salesList);
		cardLayout.show(getJpnDetail(), SalesResult.class.getName());
		saleDetail.getJbtSendSale().setVisible(saleSynch.getSynchSales().length > 0);
	}



}
