package com.mainretail.commun.ui;

import java.awt.BorderLayout;
import java.awt.FlowLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import javax.swing.ComboBoxModel;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JLabel;
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
import com.mainretail.commun.model.DAOUtil;
import com.mainretail.commun.model.IParentDAO;
import com.mainretail.commun.model.inventory.Category;
import com.mainretail.commun.model.inventory.IModelDAO;
import com.mainretail.commun.model.inventory.Model;

public class ModelSearch extends BasePanel {
	private static final long serialVersionUID = -3806131602130720192L;
	
	private static final int[] columnWidths = {140, 60};
	
	public  static final int SCREEN_TYPE_SALE = 0;
	public  static final int SCREEN_TYPE_PURCHASE = 1;
	
	private ModelItemListener modelItemListener;
	
	private JPanel jpnFilter;
	private JPanel jpnCategory;
	private QtyPanel qtyPanel;
	private JLabel jlbDescription;
	private JPanel jpnAdd;
	private JPanel jpnInfo;
	private JButton jbtAddItem;
	private JTable jtbGrid;
	private JComboBox jcbCategory;
	private JPanel jpnQty;
	private JScrollPane jspGrid;
	private JPanel jpnAddSearch;
	private JLabel jlbPrice;
	
	
	private int screenType;
		
	public ModelSearch(int screenType, ModelItemListener addItemListener) {
		super();
		this.screenType = screenType;
		this.modelItemListener = addItemListener;
	}

	public ModelSearch() {
		super();
	}
	
	public void initGUI() {
		try {
			BorderLayout thisLayout = new BorderLayout();
			this.setLayout(thisLayout);
			this.setPreferredSize(new java.awt.Dimension(400, 300));
			super.initGUI();
			{
				this.add(getJpnFilter(), BorderLayout.NORTH);
				BorderLayout jpnFilterLayout = new BorderLayout();
				getJpnFilter().setLayout(jpnFilterLayout);
				getJpnFilter().setPreferredSize(new java.awt.Dimension(400, 61));
				{
					getJpnFilter().add(getJpnCategory(), BorderLayout.NORTH);
					getJpnCategory().setPreferredSize(new java.awt.Dimension(500,30));
					/*
					BorderLayout jpnCategoryLayout = new BorderLayout();
					getJpnCategory().setLayout(jpnCategoryLayout);
					*/
					{
						//getJpnCategory().add(getJcbCategory(), BorderLayout.CENTER);
						getJpnCategory().add(getJcbCategory());
						setComboModel(getCategoryModel());
						
						getJcbCategory().setPreferredSize(new java.awt.Dimension(200, 20));
						getJcbCategory().addActionListener(this);
					}
				}				
				{
					getJpnFilter().add(getJpnQty(), BorderLayout.SOUTH);
					getJpnQty().setPreferredSize(new java.awt.Dimension(400,33));
					getJpnQty().add(getQtyPanel());
				}
			}
			{
				this.add(getJpnAddSearch(), BorderLayout.SOUTH);
				getJpnAddSearch().setPreferredSize(new java.awt.Dimension(400, 26));
				BorderLayout jpnAddSearchLayout = new BorderLayout();
				getJpnAddSearch().setLayout(jpnAddSearchLayout);
				
				{
					getJpnAddSearch().add(getJpnAdd(), BorderLayout.EAST);
					FlowLayout jpnAddLayout = new FlowLayout();
					jpnAddLayout.setAlignment(FlowLayout.RIGHT);
					jpnAddLayout.setHgap(0);
					jpnAddLayout.setVgap(2);
					getJpnAdd().setLayout(jpnAddLayout);
					getJpnAdd().setPreferredSize(new java.awt.Dimension(76, 26));
					{
						getJpnAdd().add(getJbtAddItem());
						getJbtAddItem().addActionListener(this);
						getJbtAddItem().setText(LanguageResource.getInstance().getText("ADD"));
						getJbtAddItem().setPreferredSize(new java.awt.Dimension(50, 22));
						getJbtAddItem().setMargin(new Insets(0, 0, 0, 0));
					}
				}
				
				
				{
					getJpnAddSearch().add(getJpnInfo(), BorderLayout.CENTER);
					{
						BorderLayout jpnInfolayout = new BorderLayout();
						getJpnInfo().setLayout(jpnInfolayout);
						{
							getJpnInfo().add(getJlbDescription(), BorderLayout.CENTER);
							getJlbDescription().setText("");
						}
						{
							getJpnInfo().add(getJlbPrice(), BorderLayout.SOUTH);
							getJlbPrice().setText("0.00");
						}
						
					}
				}


			}
			{
				
				{
					this.add(getJspGrid(), BorderLayout.CENTER);
					getJspGrid().setViewportView(getJtbGrid());
					getJtbGrid().setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
					
					setGridModel(new ModelTableModel(new ArrayList(), screenType));
					getJtbGrid().setAutoResizeMode(JTable.AUTO_RESIZE_OFF);
					/*
					setGridModel(new DefaultTableModel(new String[][] {
							{ "One", "Two" }, { "Three", "Four" } }, new String[] {
							"Column 1", "Column 2" }));
					*/
				}
				
				getJtbGrid().addMouseListener(new MouseAdapter(){
					public void mouseClicked(MouseEvent e){
						if (e.getSource() == getJtbGrid()){
							if (e.getClickCount() == 2){
								addItem();
							}
				    	}
					}
				});
				      
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
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
	

	private JLabel getJlbPrice() {
		if (jlbPrice == null)
			jlbPrice = new JLabel();
		return jlbPrice;
	}

	public JPanel getJpnFilter() {
		if (jpnFilter == null){
			jpnFilter = new JPanel();
			jpnFilter.setBackground(this.getBackground());
		}
		return jpnFilter;
	}

	public JPanel getJpnCategory() {
		if (jpnCategory == null){
			jpnCategory = new JPanel();
			jpnCategory.setBackground(this.getBackground());
		}
			
		return jpnCategory;
	}

	public JPanel getJpnQty() {
		if (jpnQty == null){
			jpnQty = new JPanel();
			jpnQty.setBackground(this.getBackground());
		}
		return jpnQty;
	}

	public JPanel getJpnAddSearch() {
		if (jpnAddSearch == null)
			jpnAddSearch = new JPanel();
		return jpnAddSearch;
	}

	public JScrollPane getJspGrid() {
		if (jspGrid == null){
			jspGrid = new JScrollPane();
			jspGrid.setBackground(this.getBackground());
		}
		return jspGrid;
	}
	
	public JComboBox getJcbCategory() {
		if (jcbCategory == null) {
			jcbCategory = new JComboBox();
		}
		return jcbCategory;
	}
	
	private void setComboModel(ComboBoxModel model) {
		getJcbCategory().setModel(model);
	}
	
	private void setGridModel(TableModel model){
		
		getJtbGrid().setModel(model);
		//getJtbGrid().getColumnModel().getColumn(1).setMaxWidth(80);
		initColumnSizes(getJtbGrid());
	}

	private DefaultComboBoxModel getCategoryModel(){
		IParentDAO dao = DAOUtil.getDAO(Category.class, IParentDAO.DATABASE_DB4O);
		List categoryList = dao.listAll();
		
		Object[] objects = categoryList.toArray();
		
		return new DefaultComboBoxModel(objects);
	}
	
	public JTable getJtbGrid() {
		if (jtbGrid == null) {
			jtbGrid = new JTable();	
			jtbGrid.setDefaultRenderer(java.lang.Double.class,
					new FractionCellRenderer(10, 2, SwingConstants.RIGHT));
			
			if (Config.getInstance().getGridNumLines() != 1){
				jtbGrid.setDefaultRenderer(java.lang.String.class, new WordWrapCellRenderer());
				jtbGrid.setRowHeight(Config.getInstance().getGridNumLines() * getFontMetrics(jtbGrid.getFont()).getHeight());
			}
			
		}
		return jtbGrid;
	}
	
	public void onActionPerformed(ActionEvent evt){
		if (evt.getSource() ==  getJcbCategory()){
			filterGrid();
		} else if (evt.getSource() ==  getJbtAddItem()){
			if (getJtbGrid().getSelectedRowCount() != 0)
				addItem();
		}
	}
	
	private void filterGrid(){
		IParentDAO dao = DAOUtil.getDAO(Model.class, IParentDAO.DATABASE_DB4O);			 
		List modelList = ((IModelDAO)dao).list((Category)(getJcbCategory().getSelectedItem()));
		setGridModel(new ModelTableModel(modelList, screenType));
	}
	
	

	private JPanel getJpnAdd() {
		if (jpnAdd == null) {
			jpnAdd = new JPanel();
			jpnAdd.setBackground(this.getBackground());
		}
		return jpnAdd;
	}
	public JButton getJbtAddItem() {
		if (jbtAddItem == null) {
			jbtAddItem = new JButton();
		}
		return jbtAddItem;
	}
	
	private JPanel getJpnInfo() {
		if (jpnInfo == null) {
			jpnInfo = new JPanel();
			jpnInfo.setBackground(this.getBackground());
		}
		return jpnInfo;
	}
	public JLabel getJlbDescription() {
		if (jlbDescription == null) {
			jlbDescription = new JLabel();
		}
		return jlbDescription;
	}
	
	private QtyPanel getQtyPanel() {
		if (qtyPanel == null) {
			qtyPanel = new QtyPanel();
		}
		return qtyPanel;
	}

	public int getScreenType() {
		return screenType;
	}
	
	private void addItem() {
		ModelTableModel tableModel = (ModelTableModel)getJtbGrid().getModel();
		Model modelo = (Model) tableModel.getObjectAt(getJtbGrid().getSelectedRow());
		
		if (modelItemListener != null){
			modelItemListener.itemAdded(modelo, null, getQtyPanel().getQty());
		}
		
		
		if (modelo != null){			
			getJlbDescription().setText(modelo.description);
			double price = 0;
			if (screenType == ModelSearch.SCREEN_TYPE_SALE)
				price = modelo.sellingprice;
			else
				price = modelo.vendorcost;
			
			DecimalFormat formatter = new DecimalFormat("##0.00");
			getJlbPrice().setText(formatter.format(price));
		}
	}

	

}

class ModelTableModel implements TableModel{
	private ArrayList modelList;
	private int type;
	
	public ModelTableModel(List modelList, int type){
		super();
		this.modelList = new ArrayList();
		this.modelList.addAll(modelList);
		this.type = type; 
	}

	
	public int getRowCount() {
		return modelList.size();
	}

	public int getColumnCount() {
		return 2;
	}

	public String getColumnName(int columnIndex) {
		switch ( columnIndex ){
		case 0:{
			return LanguageResource.getInstance().getText("DESCRIPTION");
		}
		case 1:{
			if (type == ModelSearch.SCREEN_TYPE_SALE )
				return LanguageResource.getInstance().getText("SALEPRICE");
			else
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
		default:
			return null;
		}
	}

	public boolean isCellEditable(int rowIndex, int columnIndex) {
		return false;
	}

	public Object getValueAt(int rowIndex, int columnIndex) {
		if (modelList.size() == 0) 
			return null;
		else
			switch ( columnIndex ){
			case 0:{			
				return ((Model)modelList.get(rowIndex)).description;
			}
			case 1:{
				if (type == ModelSearch.SCREEN_TYPE_SALE )
					return new Double(((Model)modelList.get(rowIndex)).sellingprice);
				else
					return new Double(((Model)modelList.get(rowIndex)).vendorcost);
			}
			default:
				return null;
			}
	}

	public void setValueAt(Object arg0, int arg1, int arg2) {
	}

	public void addTableModelListener(TableModelListener arg0) {
	}

	public void removeTableModelListener(TableModelListener arg0) {
	}

	public List getModelList() {
		return modelList;
	}
	
	public Object getObjectAt(int row){
		return 	modelList.get(row);	
	}
	
	
	
}
