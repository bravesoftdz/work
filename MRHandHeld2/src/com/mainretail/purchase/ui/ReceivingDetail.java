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
import com.mainretail.commun.model.purchase.Receiving;
import com.mainretail.commun.model.purchase.ReceivingItem;
import com.mainretail.commun.ui.BasePanel;
import com.mainretail.commun.ui.UPCSearch;
import com.mainretail.commun.ui.WordWrapCellRenderer;

import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.util.ArrayList;
import java.util.List;
import com.mainretail.commun.ui.FractionCellRenderer;
import com.mainretail.purchase.event.ReceivingEditionListener;

public class ReceivingDetail extends BasePanel {
	private static final long serialVersionUID = -4668971526671723858L;
	
	private ModelItemListener modelItemListener;
	
	private static final int[] columnWidths = {100, 50, 50};
	
	private JPanel jpnFinish;
	private JButton jbtNew;
	private JButton jbtDelete;
	private JPanel jpnAdd;
	private JTable jtbGridReceiving;
	private JScrollPane jspGridReceiving;
	
	private Receiving purchaseReceiving = null;
	private ReceivingEditionListener editionListener = null;
	private JButton jbtImportPO;
	private JButton jbtFinish;
	
	private UPCSearch upcSearch;

	public ReceivingDetail(ModelItemListener modelItemListener, ReceivingEditionListener editionListener) {
		super();
		this.modelItemListener = modelItemListener;
		this.editionListener = editionListener;
		init();
	}

	public ReceivingDetail() {		
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
			add(getJspGridReceiving(), BorderLayout.CENTER);
			getJspGridReceiving().setViewportView(getJtbGridReceiving());
			getJtbGridReceiving().setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
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
						getJpnAdd().add(getJbtImportPO());
						getJbtImportPO().addActionListener(this);
					}
					{
						getJpnAdd().add(getJbtFinish());
						getJbtFinish().addActionListener(this);
					}
				}
				
				
			}

		}
	}
	
	public void onActionPerformed(ActionEvent evt) {
		if ( evt.getSource() == getJbtNew()){
			editionListener.onNew();
		} else if (evt.getSource() == getJbtImportPO()){
			editionListener.importPO();
		} else if (evt.getSource() == getJbtFinish()) {
			if ((purchaseReceiving != null) && (purchaseReceiving.items.size() > 0))
				editionListener.finish();
		} else if (evt.getSource() == getJbtDelete()){
			ReceivingItem receivingItem = null;
			
			try{
				ReceivingItemTableModel tableModel = (ReceivingItemTableModel)getJtbGridReceiving().getModel();
				receivingItem = (ReceivingItem)(tableModel.getObjectAt(getJtbGridReceiving().getSelectedRow()));
			} catch(Throwable t){

			}
			if (receivingItem != null)
				modelItemListener.itemRemoved(receivingItem);
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
	
	public JScrollPane getJspGridReceiving() {
		if (jspGridReceiving == null) {
			jspGridReceiving = new JScrollPane();
			jspGridReceiving.setBackground(this.getBackground());
		}
		return jspGridReceiving;
	}
	
	public JTable getJtbGridReceiving() {
		if (jtbGridReceiving == null) {
			jtbGridReceiving = new JTable();
			jtbGridReceiving.setDefaultRenderer(java.lang.Double.class,
					new ReceivingDiffCellRenderer(10, 2, SwingConstants.RIGHT));
			
			if (Config.getInstance().getGridNumLines() != 1){
				jtbGridReceiving.setDefaultRenderer(java.lang.String.class, new WordWrapCellRenderer());
				jtbGridReceiving.setRowHeight(Config.getInstance().getGridNumLines() * getFontMetrics(jtbGridReceiving.getFont()).getHeight());
			}
			
			
		}
		return jtbGridReceiving;
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
	
	public JButton getJbtDelete() {
		if (jbtDelete == null) {
			jbtDelete = new JButton();
		}
		return jbtDelete;
	}
	
	
	public Receiving refreshTable(Receiving purchaseReceiving){
		this.purchaseReceiving = purchaseReceiving;
		
		ReceivingItemTableModel tableModel = null;
		
		if (purchaseReceiving == null)
			tableModel = new ReceivingItemTableModel(null);
		else
			tableModel = new ReceivingItemTableModel(purchaseReceiving.items);
		
		tableModel.setModelItemListener(modelItemListener);
		getJtbGridReceiving().setModel(tableModel);
		initColumnSizes(getJtbGridReceiving());
		return purchaseReceiving;
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

	public Receiving getPurchaseReceiving() {
		return purchaseReceiving;
	}
	
	public JButton getJbtImportPO() {
		if (jbtImportPO == null) {
			jbtImportPO = new JButton();
			jbtImportPO.setText(LanguageResource.getInstance().getText("IMPORT"));
			jbtImportPO.setMaximumSize(new java.awt.Dimension(40,22));
			jbtImportPO.setSize(new java.awt.Dimension(40,22));
			jbtImportPO.setPreferredSize(new java.awt.Dimension(50,22));
			jbtImportPO.setMargin(new Insets(0, 0, 0, 0));
		}
		return jbtImportPO;
	}
	
	public JButton getJbtFinish() {
		if (jbtFinish == null) {
			jbtFinish = new JButton();
			jbtFinish.setText(LanguageResource.getInstance().getText("FINISH"));
			jbtFinish.setMaximumSize(new java.awt.Dimension(40,22));
			jbtFinish.setSize(new java.awt.Dimension(40,22));
			jbtFinish.setPreferredSize(new java.awt.Dimension(50,22));
			jbtFinish.setMargin(new Insets(0, 0, 0, 0));
		}
		return jbtFinish;
	}
	
	public UPCSearch getUpcSearch() {
		if (upcSearch == null){
			upcSearch = new UPCSearch();
			upcSearch.setModelItemListener(modelItemListener);
		}
		return upcSearch;
	}
	

}

class ReceivingItemTableModel implements TableModel{
	private ArrayList modelItemList;
	
	private ModelItemListener modelItemListener;
	
	public ReceivingItemTableModel(List modelList){
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
		return (columnIndex == 2);
	}

	public Object getValueAt(int rowIndex, int columnIndex) {
		if (modelItemList.size() == 0) 
			return null;
		else{
			switch ( columnIndex ){
			case 0:{			
				return ((ReceivingItem)modelItemList.get(rowIndex)).description;
			}
			case 1:{
				return new Double(((ReceivingItem)modelItemList.get(rowIndex)).qty);
			}
			
			case 2:{
				return new Double(((ReceivingItem)modelItemList.get(rowIndex)).qtyReceived);				
			}

			default:
				return null;
			}
		}
	}

	public void setValueAt(Object object, int rowIndex, int columnIndex) {
		switch (columnIndex){
		case 2:{
			ReceivingItem ri = ((ReceivingItem)modelItemList.get(rowIndex));
			double oldQty = ri.qtyReceived;
			ri.qtyReceived = ((Double)object).doubleValue();
			modelItemListener.itemChanged(ri, oldQty);
		}
		default:;
		}
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


	public void setModelItemListener(ModelItemListener modelItemListener) {
		this.modelItemListener = modelItemListener;
	}
	
}

class ReceivingDiffCellRenderer extends FractionCellRenderer{
	private static final long serialVersionUID = 1L;

	public ReceivingDiffCellRenderer(int integer, int fraction, int align) {
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


