package com.softvar.ui;

import java.awt.Component;
import java.text.NumberFormat;

import javax.swing.JLabel;
import javax.swing.JTable;
import javax.swing.table.TableCellRenderer;

 

public class FractionCellRenderer extends JLabel implements TableCellRenderer {
	private static final long serialVersionUID = 1L;

	public FractionCellRenderer(int integer, int fraction, int align) {
	    this.integer = integer;
	    this.fraction = fraction;
	    this.align = align;
	}

	  protected void setValue(Object value) {
	    if (value != null && value instanceof Number) {
	      formatter.setMaximumIntegerDigits(integer);
	      formatter.setMaximumFractionDigits(fraction);
	      formatter.setMinimumFractionDigits(fraction);
	      //setFont(getFont().deriveFont(Font.PLAIN, getFont().getSize()));
	      setText(formatter.format(((Number) value).doubleValue()));
	      setOpaque(true);
	    } else {
	      setText(value.toString());
	    }
	    setHorizontalAlignment(align);
	  }

	  protected int integer;

	  protected int fraction;

	  protected int align;

	  protected static NumberFormat formatter = NumberFormat.getInstance();

	public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column) {
		adjustText(table, value, isSelected, hasFocus, row, column);
		if (isSelected)
			this.setBackground(table.getSelectionBackground());
		else
			this.setBackground(table.getBackground());
		setValue(value);
		return this;
	}
	
	protected void adjustText(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column) {
		setFont(table.getFont());
		setForeground(table.getForeground());
	}
	
	public boolean isOpaque(){
		return true;
	}
	
	public void validate(){
		
	}
	public void revalidate(){
		
	}
	public void repaint(){
		
	}
	
	public void firePropertyChange(String propertyName, boolean oldValue, boolean newValue) {
		
	}
	
	protected void firePropertyChange(String propertyName, Object oldValue, Object newValue) {
		
	}
	
	
}
