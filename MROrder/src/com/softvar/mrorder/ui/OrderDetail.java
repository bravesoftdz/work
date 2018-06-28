package com.softvar.mrorder.ui;

import java.awt.FlowLayout;
import java.awt.Insets;

import javax.swing.JButton;

import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.ListSelectionModel;
import javax.swing.SwingConstants;
import javax.swing.event.TableModelListener;
import javax.swing.table.TableColumn;
import javax.swing.table.TableModel;

import com.softvar.controller.UPCScanListener;
import com.softvar.internationalization.LanguageResource;
import com.softvar.model.order.Order;
import com.softvar.model.order.OrderItem;
import com.softvar.mrorder.controller.Config;
import com.softvar.mrorder.controller.OrderSynch;
import com.softvar.mrorder.event.OrderItemListener;
import com.softvar.mrorder.event.OrderListener;
import com.softvar.ui.BasePanel;
import com.softvar.ui.FractionCellRenderer;
import com.softvar.ui.MsgBox;
import com.softvar.ui.UPCSearch;
import com.softvar.ui.WordWrapCellRenderer;

import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.util.ArrayList;
import java.util.List;


public class OrderDetail extends BasePanel implements UPCScanListener {
	private static final long serialVersionUID = -4668971526671723858L;
	
	private static final int[] columnWidths = {134, 30, 35};
	
	
	
	private OrderItemListener orderItemListener;
	private OrderListener orderListener;
	
	private JPanel jpnFinish;
	private JButton jbtDelete;
	private JButton jbtNew;
	private JButton jbtFinish;
	private JButton jbtSendOrder;
	private JPanel jpnAdd;
	private JTable jtbGridOrder;
	private JScrollPane jspGridOrder;
	private UPCSearch upcSearch;
	private OrderSynch orderSynch;
	
	private Order order = null;

	public OrderDetail(OrderItemListener orderItemListener, OrderListener orderListener, OrderSynch orderSynch) {
		super();
		this.orderItemListener = orderItemListener;
		this.orderListener = orderListener;
		this.orderSynch = orderSynch;
		init();
	}

	public OrderDetail() {		
		super();
	}
	
	public void initGUI() {
		try {
			this.setPreferredSize(new java.awt.Dimension(400, 300));
			super.initGUI();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void init(){
	
		BorderLayout thisLayout = new BorderLayout();
		setLayout(thisLayout);
		{
			add(getUpcSearch(), BorderLayout.NORTH);
		}
		{
			add(getJspGridOrder(), BorderLayout.CENTER);
			getJspGridOrder().setViewportView(getJtbGridOrder());
			getJtbGridOrder().setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
			getJtbGridOrder().setAutoResizeMode(JTable.AUTO_RESIZE_OFF);
			//getJtbGridSale().setAutoResizeMode(JTable.AUTO_RESIZE_LAST_COLUMN);
			refreshTable(null);
		}
		{
			add(getJpnFinish(), BorderLayout.SOUTH);
			getJpnFinish().setPreferredSize(new java.awt.Dimension(400, 29));
			
			{
				BorderLayout jpnFinishLayout = new BorderLayout();
				getJpnFinish().setLayout(jpnFinishLayout);
				{
				getJpnFinish().add(getJpnAdd(), BorderLayout.CENTER);

				FlowLayout jpnAddLayout = new FlowLayout();
				jpnAddLayout.setAlignment(FlowLayout.LEFT);
				jpnAddLayout.setHgap(1);
				jpnAddLayout.setVgap(1);
				getJpnAdd().setLayout(jpnAddLayout);
				getJpnAdd().setPreferredSize(new java.awt.Dimension(68,29));
					{
						getJpnAdd().add(getJbtNew());
						getJbtNew().setText(LanguageResource.getInstance().getText("NEW"));
						getJbtNew().addActionListener(this);
						getJbtNew().setMaximumSize(new java.awt.Dimension(40,22));
						getJbtNew().setSize(new java.awt.Dimension(40,22));
						getJbtNew().setPreferredSize(new java.awt.Dimension(50,22));
						getJbtNew().setMargin(new Insets(0, 0, 0, 0));
					}
					{
						getJpnAdd().add(getJbtDelete());
						getJbtDelete().setText(LanguageResource.getInstance().getText("DELETE"));
						getJbtDelete().addActionListener(this);
						getJbtDelete().setMaximumSize(new java.awt.Dimension(40,22));
						getJbtDelete().setSize(new java.awt.Dimension(40,22));
						getJbtDelete().setPreferredSize(new java.awt.Dimension(50,22));
						getJbtDelete().setMargin(new Insets(0, 0, 0, 0));
					}
					{	
						getJpnAdd().add(getJbtFinish());
						getJbtFinish().setText(LanguageResource.getInstance().getText("FINISH"));
						getJbtFinish().addActionListener(this);
						getJbtFinish().setMaximumSize(new java.awt.Dimension(40,22));
						getJbtFinish().setSize(new java.awt.Dimension(40,22));
						getJbtFinish().setPreferredSize(new java.awt.Dimension(50,22));
						getJbtFinish().setMargin(new Insets(0, 0, 0, 0));
					}
					{	
						getJpnAdd().add(getJbtSendOrder());
						getJbtSendOrder().setText(LanguageResource.getInstance().getText("SYNC"));
						getJbtSendOrder().addActionListener(this);
						getJbtSendOrder().setMaximumSize(new java.awt.Dimension(40,22));
						getJbtSendOrder().setSize(new java.awt.Dimension(40,22));
						getJbtSendOrder().setPreferredSize(new java.awt.Dimension(50,22));
						getJbtSendOrder().setMargin(new Insets(0, 0, 0, 0));
						//getJbtSendSale().setVisible(saleSynch.getSynchSales().length > 0);
					}
				}
				
				
			}

		}
		
	}
	
	public void onActionPerformed(ActionEvent evt) {
		if (evt.getSource() == getJbtDelete()){
			OrderItem orderItem = null;
			try{
				OrderItemViewTableModel tableModel = (OrderItemViewTableModel)getJtbGridOrder().getModel();
				orderItem = (OrderItem)(tableModel.getObjectAt(getJtbGridOrder().getSelectedRow()));
			} catch(Throwable t){

			}
			if (orderItem != null)
				orderItemListener.itemRemoved(orderItem);
		} else if ( evt.getSource() == getJbtNew()){
			if (MsgBox.yesNoMsg(this, LanguageResource.getInstance().getText("MSG_QUESTION_NEW")))
					orderListener.orderRemove(order);
		} else if ( evt.getSource() == getJbtFinish()){
			if ((order != null) && (order.items.size() > 0))
			{
				orderListener.orderFinalize(order);
				getJbtSendOrder().setVisible(orderSynch.getSynchOrders().length > 0);
			}
		} else if ( evt.getSource() == getJbtSendOrder()){
			orderSynch.sendOrders();
			
		}
	}
	
	public JPanel getJpnFinish() {
		if (jpnFinish == null){
			jpnFinish = new JPanel();
			jpnFinish.setBackground(this.getBackground());
		}
		return jpnFinish;
	}
	
	public JScrollPane getJspGridOrder() {
		if (jspGridOrder == null) {
			jspGridOrder = new JScrollPane();
			jspGridOrder.setBackground(this.getBackground());
		}
		return jspGridOrder;
	}
	
	public JTable getJtbGridOrder() {
		if (jtbGridOrder == null) {
			jtbGridOrder = new JTable();
			jtbGridOrder.setDefaultRenderer(java.lang.Double.class,
					new FractionCellRenderer(10, 2, SwingConstants.RIGHT)
			        );
			if (Config.getInstance().getGridNumLines() != 1){
				jtbGridOrder.setDefaultRenderer(java.lang.String.class, new WordWrapCellRenderer());
				jtbGridOrder.setRowHeight(Config.getInstance().getGridNumLines() * getFontMetrics(jtbGridOrder.getFont()).getHeight());
			}
		}
		return jtbGridOrder;
	}
	
	private JPanel getJpnAdd() {
		if (jpnAdd == null) {
			jpnAdd = new JPanel();
			jpnAdd.setBackground(this.getBackground());
		}
		return jpnAdd;
	}

	public JButton getJbtFinish() {
		if (jbtFinish == null) {
			jbtFinish = new JButton();
		}
		return jbtFinish;
	}
	
	public JButton getJbtDelete() {
		if (jbtDelete == null) {
			jbtDelete = new JButton();
		}
		return jbtDelete;
	}
	
	public JButton getJbtNew() {
		if (jbtNew == null) {
			jbtNew = new JButton();
		}
		return jbtNew;
	}
	
	public Order refreshTable(Order order){
		this.order = order;
		OrderItemViewTableModel tableModel;
		if (order == null)
			tableModel = new OrderItemViewTableModel(null);
		else{
			List items = order.items;
			tableModel = new OrderItemViewTableModel(items);
		}
						
		tableModel.setOrderItemListener(orderItemListener);
		getJtbGridOrder().setModel(tableModel);
		initColumnSizes(getJtbGridOrder());
		return order;
	}
	
	private void initColumnSizes(JTable table){
		TableColumn column = null;
		for (int i = 0; i < columnWidths.length; i++) {
		    column = table.getColumnModel().getColumn(i);
		    if (column != null){
		    	column.setMinWidth(columnWidths[i]);
		    	column.setMaxWidth(columnWidths[i]);
		    	column.setWidth(columnWidths[i]);
		        column.setPreferredWidth(columnWidths[i]);
		    }
		}				
	}
	
	public UPCSearch getUpcSearch() {
		if (upcSearch == null){
			upcSearch = new UPCSearch();
			upcSearch.setUpcScanListener(this);
		}
		return upcSearch;
	}
	
	public JButton getJbtSendOrder() {
		if (jbtSendOrder == null) {
			jbtSendOrder = new JButton();
		}
		return jbtSendOrder;
	}

	public void setJbtSendOrder(JButton jbtSendSale) {
		this.jbtSendOrder = jbtSendSale;
	}

	public void UPCScanned(String barcode, double qty) {
		orderItemListener.itemAdded(barcode, qty);
		
	}
	
	
	
}

class OrderItemViewTableModel implements TableModel{
	
	private ArrayList orderItemViewList;
	
	private OrderItemListener orderItemListener;
	
	public OrderItemViewTableModel(List orderItemViewList){
		//super();
		this.orderItemViewList = new ArrayList();
		if (orderItemViewList != null)
			this.orderItemViewList.addAll(orderItemViewList);
	}
	
	public int getRowCount() {
		return orderItemViewList.size();
	}

	public int getColumnCount() {
		return 3;
	}

	public String getColumnName(int columnIndex) {
		switch ( columnIndex ){
		case 0:{
			return LanguageResource.getInstance().getText("DESCRIPTION");
		}
		case 1:{
			return LanguageResource.getInstance().getText("QTY");
		}
		case 2:{
			return LanguageResource.getInstance().getText("COSTPRICE");
		}


		default:
			return null;
		}
	}

	public Class getColumnClass(int columnIndex) {
		switch ( columnIndex ){
		case 0:{
			return String.class;
		}
		case 1:{
			return Double.class;
		}
		case 2:{
			return Double.class;
		}


		default:
			return null;
		}
	}

	public boolean isCellEditable(int rowIndex, int columnIndex) {
		return (columnIndex == 1);		
	}

	public Object getValueAt(int rowIndex, int columnIndex) {
		if (orderItemViewList.size() == 0) 
			return null;
		else{
			switch ( columnIndex ){
			case 0:{
				return ((OrderItem)orderItemViewList.get(rowIndex)).description;
			}
			case 1:{
				return new java.lang.Double(((OrderItem)orderItemViewList.get(rowIndex)).qty);
			}
			case 2:{
				return new java.lang.Double(((OrderItem)orderItemViewList.get(rowIndex)).cost);
			}

			default:
				return null;
			}
		}
	}

	public void setValueAt(Object object, int rowIndex, int columnIndex) {

		OrderItem saleItem = ((OrderItem)orderItemViewList.get(rowIndex));
		double oldQty = saleItem.qty;
		
		//saleItem.qty = ((Double)object).doubleValue();
		
		saleItem.qty = Double.parseDouble(object.toString());
		orderItemListener.itemChanged(saleItem, oldQty);
	}
	
	public void addTableModelListener(TableModelListener arg0) {
	}

	public void removeTableModelListener(TableModelListener arg0) {
	}

	public List getOrderItemViewList() {
		return orderItemViewList;
	}
	
	public Object getObjectAt(int row){
		return 	((OrderItem)orderItemViewList.get(row));	
	}


	public void setOrderItemListener(OrderItemListener orderItemListener) {
		this.orderItemListener = orderItemListener;
	}
	
}




