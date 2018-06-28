package com.mainretail.sales.ui;

import java.awt.Dimension;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.event.TableModelListener;
import javax.swing.table.TableModel;

import com.mainretail.commun.model.sale.Sale;
import com.mainretail.commun.ui.BasePanel;
import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

public class SalesResult extends BasePanel {
	private static final long serialVersionUID = 5273487885611900265L;
	
	private JScrollPane jscResult;
	private JTable jtbResult;
	private List sales;

	public void setSales(List sales) {
		this.sales = sales;
		getJtbResult().setModel(new SaleTableModel(this.sales));
	}

	public SalesResult(){
		super();
	}
	
	public void initGUI(){
		try {
			setPreferredSize(new Dimension(400, 300));
			
			BorderLayout thisLayout = new BorderLayout();
			this.setLayout(thisLayout);
			{
				this.add(getJscResult(), BorderLayout.CENTER);
				getJscResult().setViewportView(getJtbResult());
			}

			super.initGUI();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void onActionPerformed(ActionEvent evt){
		
	}

	public JScrollPane getJscResult() {
		if (jscResult == null) {
			jscResult = new JScrollPane();
			jscResult.setBackground(this.getBackground());
		}
		return jscResult;
	}
	
	public JTable getJtbResult() {
		if (jtbResult == null) {
			jtbResult = new JTable();
		}
		return jtbResult;
	}

}



class SaleTableModel implements TableModel{
	private ArrayList modelItemList;
	private DateFormat dateFormatter;
	
	public SaleTableModel(List modelList){
		super();
		this.modelItemList = new ArrayList();
		if (modelList != null)
			this.modelItemList.addAll(modelList);
	}

	
	public int getRowCount() {
		return modelItemList.size();
	}

	public int getColumnCount() {
		return 2;
	}

	public String getColumnName(int columnIndex) {
		switch ( columnIndex ){
		case 0:{
			return "Pocket";
		}
		case 1:{
			return "MainRetail";
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
			return String.class;
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
				dateFormatter = DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.SHORT, new Locale("en","US"));
				return dateFormatter.format(((Sale)modelItemList.get(rowIndex)).saleDate);
			}
			case 1:{
				return (((Sale)modelItemList.get(rowIndex)).salecode);
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
