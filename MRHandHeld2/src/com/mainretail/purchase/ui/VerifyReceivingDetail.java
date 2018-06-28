package com.mainretail.purchase.ui;

import java.awt.Color;
import java.awt.Dimension;
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

import com.mainretail.commun.controller.LanguageResource;
import com.mainretail.commun.event.ModelItemListener;
import com.mainretail.commun.model.Config;
import com.mainretail.commun.model.inventory.ModelVerifyQty;
import com.mainretail.commun.model.purchase.VerifyReceiving;
import com.mainretail.commun.ui.BasePanel;
import com.mainretail.commun.ui.UPCSearch;
import com.mainretail.commun.ui.WordWrapCellRenderer;

import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.util.ArrayList;
import java.util.List;
import com.mainretail.commun.ui.FractionCellRenderer;
import com.mainretail.purchase.event.EditionListener;

public class VerifyReceivingDetail extends BasePanel {
	private static final long serialVersionUID = -4668971526671723858L;
	
	private ModelItemListener modelItemListener;
	
	private static final int[] columnWidths = {100, 50, 50};
	
	private JPanel jpnFinish;
	private JButton jbtNew;
	private JPanel jpnAdd;
	private JTable jtbGridVerifyReceiving;
	private JScrollPane jspGridVerifyReceiving;
	
	private VerifyReceiving purchaseVerifyReceiving = null;
	private EditionListener editionListener = null;
	
	private UPCSearch upcSearch;

	public VerifyReceivingDetail(ModelItemListener modelItemListener, EditionListener editionListener) {
		super();
		this.modelItemListener = modelItemListener;
		this.editionListener = editionListener;
		init();
	}

	public VerifyReceivingDetail() {		
		super();
	}
	
	public void initGUI() {
		try {
			
			
			setPreferredSize(new Dimension(400, 300));
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
			add(getJspGridVerifyReceiving(), BorderLayout.CENTER);
			getJspGridVerifyReceiving().setViewportView(getJtbGridVerifyReceiving());
			getJtbGridVerifyReceiving().setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
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
				}
				
				
			}

		}
	}
	
	public void onActionPerformed(ActionEvent evt) {
		if ( evt.getSource() == getJbtNew()){
			editionListener.onNew();
		}
		else
			super.onActionPerformed(evt);
	}
	
	public JPanel getJpnFinish() {
		if (jpnFinish == null){
			jpnFinish = new JPanel();
			jpnFinish.setBackground(this.getBackground());
		}
		return jpnFinish;
	}
	
	public JScrollPane getJspGridVerifyReceiving() {
		if (jspGridVerifyReceiving == null) {
			jspGridVerifyReceiving = new JScrollPane();
			jspGridVerifyReceiving.setBackground(this.getBackground());
		}
		return jspGridVerifyReceiving;
	}
	
	public JTable getJtbGridVerifyReceiving() {
		if (jtbGridVerifyReceiving == null) {
			jtbGridVerifyReceiving = new JTable();
			jtbGridVerifyReceiving.setDefaultRenderer(java.lang.Double.class,
					new DifferenceCellRenderer(10, 2, SwingConstants.RIGHT)
			        );

			if (Config.getInstance().getGridNumLines() != 1){
				jtbGridVerifyReceiving.setDefaultRenderer(java.lang.String.class, new WordWrapCellRenderer());
				jtbGridVerifyReceiving.setRowHeight(Config.getInstance().getGridNumLines() * getFontMetrics(jtbGridVerifyReceiving.getFont()).getHeight());
			}
			
		}
		return jtbGridVerifyReceiving;
	}
	
	private JPanel getJpnAdd() {
		if (jpnAdd == null) {
			jpnAdd = new JPanel();
			jpnAdd.setBackground(this.getBackground());
		}
		return jpnAdd;
	}


	public JButton getJbtNew() {
		if (jbtNew == null) {
			jbtNew = new JButton();
		}
		return jbtNew;
	}
	
	public VerifyReceiving refreshTable(VerifyReceiving purchaseVerifyReceiving){
		this.purchaseVerifyReceiving = purchaseVerifyReceiving;
		if (purchaseVerifyReceiving == null)
			getJtbGridVerifyReceiving().setModel(new ModelItemTableModel(null));
		else
		{
			getJtbGridVerifyReceiving().setModel(new ModelItemTableModel(purchaseVerifyReceiving.items));
			initColumnSizes(getJtbGridVerifyReceiving());			
		}
		return purchaseVerifyReceiving;
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

	public ModelItemListener getModelItemListener() {
		return modelItemListener;
	}

	public VerifyReceiving getPurchaseVerifyReceiving() {
		return purchaseVerifyReceiving;
	}
	
	public UPCSearch getUpcSearch() {
		if (upcSearch == null){
			upcSearch = new UPCSearch();
			upcSearch.setModelItemListener(modelItemListener);
		}
		return upcSearch;
	}
	
	
}

class ModelItemTableModel implements TableModel{
	private ArrayList modelItemList;
	
	public ModelItemTableModel(List modelList){
		super();
		this.modelItemList = new ArrayList();
		if (modelList != null)
			this.modelItemList.addAll(modelList);
	}

	
	public int getRowCount() {
		return modelItemList.size();
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
			return LanguageResource.getInstance().getText("REQUESTED_QTY");
		}
		case 2:{
			return LanguageResource.getInstance().getText("RECEIVED_QTY");
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
		return false;
	}

	public Object getValueAt(int rowIndex, int columnIndex) {
		if (modelItemList.size() == 0) 
			return null;
		else{
			switch ( columnIndex ){
			case 0:{			
				return ((ModelVerifyQty)modelItemList.get(rowIndex)).description;
			}
			case 1:{
				return new Double(((ModelVerifyQty)modelItemList.get(rowIndex)).qty);
			}
			
			case 2:{
				return new Double(((ModelVerifyQty)modelItemList.get(rowIndex)).qtyReceived);				
			}

			default:
				return null;
			}
		}
	}

	public void setValueAt(Object arg0, int arg1, int arg2) {
	}

	public void addTableModelListener(TableModelListener arg0) {
	}

	public void removeTableModelListener(TableModelListener arg0) {
	}

	public List getModelItemList() {
		return modelItemList;
	}
	
	public Object getObjectAt(int row){
		return 	modelItemList.get(row);	
	}
	
}

class DifferenceCellRenderer extends FractionCellRenderer{
	private static final long serialVersionUID = 1L;

	public DifferenceCellRenderer(int integer, int fraction, int align) {
	    super(integer, fraction, align);
	}
	
	protected void adjustText(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column) {
		setFont(table.getFont());
		double compare1 = (((Double)(table.getModel().getValueAt(row, 1))).doubleValue());
		double compare2 = (((Double)(table.getModel().getValueAt(row, 2))).doubleValue());
		if ((compare1 == 0) || ((compare1 != compare2) && (compare2 != 0)))
			setForeground(Color.RED);
		else
			if (compare1 == compare2)
				setForeground(Color.BLUE);
			else
				setForeground(table.getForeground());
	}
}


