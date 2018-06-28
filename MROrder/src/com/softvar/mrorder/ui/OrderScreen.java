package com.softvar.mrorder.ui;

import java.awt.BorderLayout;
import java.awt.CardLayout;
import java.awt.FlowLayout;
import java.awt.Font;
import java.text.DecimalFormat;
import java.util.Vector;

import javax.swing.JLabel;
import javax.swing.JPanel;

import com.softvar.controller.ApplicationManager;
import com.softvar.controller.NavigationManager;
import com.softvar.controller.RuntimeInfo;
import com.softvar.internationalization.LanguageResource;
import com.softvar.model.order.Account;
import com.softvar.model.order.AccountCost;
import com.softvar.model.order.IAccountCostDAO;
import com.softvar.model.order.IAccountDAO;
import com.softvar.model.order.IOrderDAO;
import com.softvar.model.order.IProductDAO;
import com.softvar.model.order.Order;
import com.softvar.model.order.OrderItem;
import com.softvar.model.order.Product;
import com.softvar.mrorder.controller.Config;
import com.softvar.mrorder.controller.OrderSynch;
import com.softvar.mrorder.event.OrderItemListener;
import com.softvar.mrorder.event.OrderListener;
import com.softvar.mrorder.event.OrderSynchListener;
import com.softvar.persistence.DAOUtil;
import com.softvar.persistence.IParentDAO;
import com.softvar.ui.MsgBox;
import com.softvar.ui.ParentFormFch;



public class OrderScreen extends ParentFormFch implements OrderListener, OrderItemListener, OrderSynchListener {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String activeCard;
	private Order order;
	private OrderDetail orderDetail;
	private CardLayout cardLayout;
	private OrderSynch orderSynch;
	
	private JLabel jlbNumProducts;
	private JLabel jlbNumProd;
	private JPanel jpnNumProd;
	private JPanel jpnlSaleTotal;
	private JLabel jlbAmount;
	private JLabel jlbSaleTotal;
	
	private JPanel jpnlAccountInfo;
	private JPanel jpnlAccount;
	private JPanel jpnlCustomer;
	
	private Account defaultAccount;
	

	public OrderScreen() {
		super();
	}

	public OrderScreen(ApplicationManager appManager, NavigationManager navManager) {
		super(appManager, navManager);
	}
	
	public void initGUI() {
		try {
			this.setPreferredSize(new java.awt.Dimension(400, 300));
			super.initGUI();
			
			loadOrder();
			
			orderSynch = new OrderSynch(this, this);
			orderDetail = new OrderDetail(this, this, orderSynch);
			orderDetail.getJbtSendOrder().setVisible(orderSynch.getSynchOrders().length > 0);
						
			getJpnDetail().add(OrderDetail.class.getName(), orderDetail);
			orderDetail.refreshTable(order);
			
			/*
			getJpnDetail().add(ModelSearch.class.getName(), new ModelSearch(ModelSearch.SCREEN_TYPE_SALE, this));

			barcodeSearch = new BarcodeSearch();
			barcodeSearch.setModelItemListener(this);
			getJpnDetail().add(BarcodeSearch.class.getName(), barcodeSearch);
			
			salesResult = new SalesResult();
			getJpnDetail().add(SalesResult.class.getName(), salesResult);
			*/
			
			
			cardLayout = (CardLayout) (getJpnDetail().getLayout());
			
			getJpnlInfo().add(getJpnlSaleTotal(), BorderLayout.WEST);
			getJpnlSaleTotal().add(getJlbSaleTotal());
			getJpnlSaleTotal().add(getJlbAmount());
			
			getJpnlInfo().add(getJpnNumProd(), BorderLayout.EAST);
			getJpnNumProd().add(getJlbNumProducts());
			getJpnNumProd().add(getJlbNumProd());
			

			getJpnlInfo().setPreferredSize(new java.awt.Dimension(400, 17));
			super.getJpnlButtonsControl().setPreferredSize(new java.awt.Dimension(400, 30));
			super.getJpnlButtonsControl().add(getJpnlAccountInfo(), BorderLayout.WEST);
			
			getJpnlAccountInfo().add(getJpnlAccount(), BorderLayout.SOUTH);
			getJpnlAccountInfo().add(getJpnlCustomer(), BorderLayout.NORTH);
			
			activeCard = OrderDetail.class.getName();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private void loadOrder(){
		IOrderDAO dao = (IOrderDAO)(DAOUtil.getDAO(Order.class, IParentDAO.DATABASE_DB4O));
		order = dao.getOpenOrder();
		if (order == null){
			order = new Order();
			order.customer = RuntimeInfo.getInstance().customer;
			if (getDefaultAccount() ==  null)
				order.idaccount = 0;
			else
				order.idaccount = getDefaultAccount().idaccount;
		}
		refreshOrderTotals();
	}
	
	private Account getDefaultAccount(){
		if (defaultAccount ==  null)
			defaultAccount = ((IAccountDAO)DAOUtil.getDAO(Account.class, IParentDAO.DATABASE_DB4O)).getByAccountNum(Config.getInstance().getAccountNum());
		return defaultAccount;
	}


	private void refreshOrderTotals() {
		
		double totCost = 0;
		int totItems = 0;

		if (this.order == null){
			getJlbAmount().setText("0.00");
			getJlbNumProd().setText("0");
		} else {
			//this.sale.getSaleTotal()
			if (this.order.items != null){
				for(int i = 0; i < order.items.size(); i++){
					totCost += ((OrderItem)order.items.get(i)).cost * ((OrderItem)order.items.get(i)).qty;
				}
				totItems = this.order.items.size();
				/*
				IOrderDAO dao = (IOrderDAO) DAOUtil.getDAO(Order.class, IParentDAO.DATABASE_DB4O);
				List lista = dao.getItemView(this.order);
				for(int i = 0; i < lista.size(); i++){
					OrderItemView oiv = (OrderItemView) lista.get(i);
					totCost += (oiv.cost * oiv.orderitem.qty); 
				}
				totItems = this.order.items.size();
				*/
			}
				
		}
		
		DecimalFormat formatter = new DecimalFormat("##0.00");
		getJlbAmount().setText(formatter.format(totCost));
		getJlbNumProd().setText(String.valueOf(totItems));
		
	}

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public void orderRemove(Order order) {
		IParentDAO dao = DAOUtil.getDAO(Order.class, IParentDAO.DATABASE_DB4O);
		dao.delete(this.order);
		this.order = null;
		orderDetail.refreshTable(this.order);	
	}

	public void orderFinalize(Order order) {
		this.order.finalized = true;
		DAOUtil.getDAO(Order.class, IParentDAO.DATABASE_DB4O).save(this.order);
		this.order = null;
		orderSynch.sendOrders();
		orderDetail.refreshTable(this.order);
		refreshOrderTotals();
	}

	public void itemChanged(OrderItem item, double oldQty) {
		DAOUtil.getDAO(Order.class, IParentDAO.DATABASE_DB4O).save(order);
		refreshOrderTotals();
	}

	public void itemRemoved(OrderItem item) {
		order.items.remove(item);
		DAOUtil.getDAO(Order.class, IParentDAO.DATABASE_DB4O).save(order);
		orderDetail.refreshTable(this.order);
		refreshOrderTotals();
	}

	public void itemAdded(String barcode, double qty) {
		
		Product p = ((IProductDAO) DAOUtil.getDAO(Product.class, IParentDAO.DATABASE_DB4O)).findByUPC(barcode);
		if (p != null){
			
			if (order == null)
				loadOrder();
			
			AccountCost ac =((IAccountCostDAO)DAOUtil.getDAO(AccountCost.class, IParentDAO.DATABASE_DB4O)).getAccountCost(order.idaccount, p.idproduct);
			
			OrderItem orderItem = new OrderItem();
			 
			orderItem.idproduct = p.idproduct;
			orderItem.qty = qty;
			orderItem.description = p.description;
			
			if (ac == null)
				orderItem.cost = 0;
			else
				orderItem.cost = ac.cost;
			
			order.items.add(0, orderItem);
		
			DAOUtil.getDAO(Order.class, IParentDAO.DATABASE_DB4O).save(order);
			
			if (activeCard.equals(OrderDetail.class.getName()))
				orderDetail.refreshTable(order);
			
			refreshOrderTotals();
		} else{
			MsgBox.errorMsg(this, LanguageResource.getInstance().getText("MSG_INFO_BARCODE_NOT_FOUND"));
			getParent().requestFocusInWindow();
			requestFocusInWindow();
			orderDetail.getUpcSearch().requestFocusInWindow();
			orderDetail.getUpcSearch().getJtfBarcode().requestFocus();
			
		}
		
	}

	public CardLayout getCardLayout() {
		return cardLayout;
	}

	public void afterSynch(Vector ordersList) {
		// TODO Auto-generated method stub
		boolean enable = orderSynch.getSynchOrders().length > 0;
		orderDetail.getJbtSendOrder().setVisible(enable);
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
			jlbNumProducts.setText(LanguageResource.getInstance().getText("LINES")+ ":");
			
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

	public JPanel getJpnlAccountInfo() {
		if (jpnlAccountInfo == null) {
			jpnlAccountInfo = new JPanel();
			BorderLayout jpnlAccInfoLayout = new BorderLayout();
			jpnlAccountInfo.setLayout(jpnlAccInfoLayout);
			jpnlAccountInfo.setBackground(this.getBackground());
			jpnlAccountInfo.setPreferredSize(new java.awt.Dimension(200, 35));
		}
		return jpnlAccountInfo;
	}

	public JPanel getJpnlAccount() {
		if (jpnlAccount == null) {	
			
			jpnlAccount = new JPanel();
			Font fontAcc = new Font("Tahoma", 0, 9);
			JLabel lbAcc = new JLabel(LanguageResource.getInstance().getText("ACCOUNT"));
			JLabel lbAccNum = new JLabel(getDefaultAccount().accountnum + " - " + getDefaultAccount().accountname);
			
			lbAcc.setFont(fontAcc);
			lbAccNum.setFont(fontAcc);
			
			FlowLayout jpnlAccountLayout = new FlowLayout();
			jpnlAccountLayout.setVgap(0);
			jpnlAccountLayout.setHgap(2);
			jpnlAccountLayout.setAlignment(0);
			
			jpnlAccount.setLayout(jpnlAccountLayout);
			jpnlAccount.add(lbAcc);
			jpnlAccount.add(lbAccNum);
			jpnlAccount.setBackground(this.getBackground());
			jpnlAccount.setPreferredSize(new java.awt.Dimension(100, 15));
		}
		
		return jpnlAccount;
	}

	public JPanel getJpnlCustomer() {
		if (jpnlCustomer == null) {
		
			jpnlCustomer = new JPanel();
			Font font = new Font("Tahoma", 0, 9);

			JLabel lbCus = new JLabel(LanguageResource.getInstance().getText("CUSTOMER_NUM"));
			JLabel lbCusNum = new JLabel(String.valueOf(Config.getInstance().getIDStore()));
			
			lbCus.setFont(font);
			lbCusNum.setFont(font);
			
			FlowLayout jpnlCustomerLayout = new FlowLayout();
			jpnlCustomerLayout.setVgap(0);
			jpnlCustomerLayout.setHgap(2);
			jpnlCustomerLayout.setAlignment(0);

			jpnlCustomer.setLayout(jpnlCustomerLayout);
			jpnlCustomer.add(lbCus);
			jpnlCustomer.add(lbCusNum);
			jpnlCustomer.setBackground(this.getBackground());
			jpnlCustomer.setPreferredSize(new java.awt.Dimension(100, 15));
		}
		return jpnlCustomer;
	}
	

}
