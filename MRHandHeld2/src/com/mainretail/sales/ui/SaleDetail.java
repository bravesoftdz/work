package com.mainretail.sales.ui;

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
import com.mainretail.commun.model.sale.Sale;
import com.mainretail.commun.model.sale.SaleItem;
import com.mainretail.commun.ui.BasePanel;
import com.mainretail.commun.ui.UPCSearch;
import com.mainretail.commun.ui.WordWrapCellRenderer;
import com.mainretail.sales.controller.SaleSynch;
import com.mainretail.sales.event.SaleListener;
import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.util.ArrayList;
import java.util.List;
import com.mainretail.commun.ui.FractionCellRenderer;

public class SaleDetail extends BasePanel {
	private static final long serialVersionUID = -4668971526671723858L;
	
	private static final int[] columnWidths = {100, 50, 50};
	
	private ModelItemListener modelItemListener;
	private SaleListener saleListener;
	
	private JPanel jpnFinish;
	private JButton jbtDelete;
	private JButton jbtNew;
	private JButton jbtFinish;
	private JButton jbtSendSale;
	private JPanel jpnAdd;
	private JTable jtbGridSale;
	private JScrollPane jspGridSale;
	private UPCSearch upcSearch;
	private SaleSynch saleSynch;
	
	private Sale sale = null;

	public SaleDetail(ModelItemListener modelItemListener, SaleListener saleListener, SaleSynch saleSynch) {
		super();
		this.modelItemListener = modelItemListener;
		this.saleListener = saleListener;
		this.saleSynch = saleSynch;
		init();
	}

	public SaleDetail() {		
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
			add(getJspGridSale(), BorderLayout.CENTER);
			getJspGridSale().setViewportView(getJtbGridSale());
			getJtbGridSale().setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
			getJtbGridSale().setAutoResizeMode(JTable.AUTO_RESIZE_OFF);
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
						getJpnAdd().add(getJbtSendSale());
						getJbtSendSale().setText(LanguageResource.getInstance().getText("SYNC"));
						getJbtSendSale().addActionListener(this);
						getJbtSendSale().setMaximumSize(new java.awt.Dimension(40,22));
						getJbtSendSale().setSize(new java.awt.Dimension(40,22));
						getJbtSendSale().setPreferredSize(new java.awt.Dimension(50,22));
						getJbtSendSale().setMargin(new Insets(0, 0, 0, 0));
						getJbtSendSale().setVisible(saleSynch.getSynchSales().length > 0);
					}
				}
				
				
			}

		}
		
	}
	
	public void onActionPerformed(ActionEvent evt) {
		if (evt.getSource() == getJbtDelete()){
			SaleItem saleItem = null;
			try{
				ModelItemTableModel tableModel = (ModelItemTableModel)getJtbGridSale().getModel();
				saleItem = (SaleItem)(tableModel.getObjectAt(getJtbGridSale().getSelectedRow()));
			} catch(Throwable t){

			}
			if (saleItem != null)
				modelItemListener.itemRemoved(saleItem);
		} else if ( evt.getSource() == getJbtNew()){
			saleListener.saleRemove(sale);
		} else if ( evt.getSource() == getJbtFinish()){
			if ((sale != null) && (sale.getItemCount() > 0))
			{
				saleListener.saleFinalize(sale);
				getJbtSendSale().setVisible(saleSynch.getSynchSales().length > 0);
			}
		} else if ( evt.getSource() == getJbtSendSale()){
			saleSynch.sendSales();
			
		}
	}
	
	public JPanel getJpnFinish() {
		if (jpnFinish == null){
			jpnFinish = new JPanel();
			jpnFinish.setBackground(this.getBackground());
		}
		return jpnFinish;
	}
	
	public JScrollPane getJspGridSale() {
		if (jspGridSale == null) {
			jspGridSale = new JScrollPane();
			jspGridSale.setBackground(this.getBackground());
		}
		return jspGridSale;
	}
	
	public JTable getJtbGridSale() {
		if (jtbGridSale == null) {
			jtbGridSale = new JTable();
			jtbGridSale.setDefaultRenderer(java.lang.Double.class,
					new FractionCellRenderer(10, 2, SwingConstants.RIGHT)
			        );
			if (Config.getInstance().getGridNumLines() != 1){
				jtbGridSale.setDefaultRenderer(java.lang.String.class, new WordWrapCellRenderer());
				jtbGridSale.setRowHeight(Config.getInstance().getGridNumLines() * getFontMetrics(jtbGridSale.getFont()).getHeight());
			}
		}
		return jtbGridSale;
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
	
	public Sale refreshTable(Sale sale){
		this.sale = sale;
		ModelItemTableModel tableModel;
		if (sale == null)
			tableModel = new ModelItemTableModel(null);
		else
			tableModel = new ModelItemTableModel(sale.items);
						
		
		tableModel.setModelItemListener(modelItemListener);
		getJtbGridSale().setModel(tableModel);
		initColumnSizes(getJtbGridSale());
		return sale;
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
			upcSearch.setModelItemListener(modelItemListener);
		}
		return upcSearch;
	}
	
	public JButton getJbtSendSale() {
		if (jbtSendSale == null) {
			jbtSendSale = new JButton();
		}
		return jbtSendSale;
	}

	public void setJbtSendSale(JButton jbtSendSale) {
		this.jbtSendSale = jbtSendSale;
	}
	
	
	
}

class ModelItemTableModel implements TableModel{
	
	private ArrayList modelItemList;
	
	private ModelItemListener modelItemListener;
	
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
			return LanguageResource.getInstance().getText("QTY");
		}
		case 2:{
			return LanguageResource.getInstance().getText("TOTAL");
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
				return ((SaleItem)modelItemList.get(rowIndex)).description;
			}
			case 1:{
				return new Double(((SaleItem)modelItemList.get(rowIndex)).qty);
			}
			
			case 2:{
				SaleItem saleItem = ((SaleItem)modelItemList.get(rowIndex));
				return new Double(saleItem.qty * saleItem.salePrice);
			}

			default:
				return null;
			}
		}
	}

	public void setValueAt(Object object, int rowIndex, int columnIndex) {
		SaleItem saleItem = ((SaleItem)modelItemList.get(rowIndex));
		double oldQty = saleItem.qty;
		saleItem.qty = ((Double)object).doubleValue();
		modelItemListener.itemChanged(saleItem, oldQty);
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




