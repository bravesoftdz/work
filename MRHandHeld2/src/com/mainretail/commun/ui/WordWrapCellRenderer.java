package com.mainretail.commun.ui;

import java.awt.Component;

import javax.swing.JTable;
import javax.swing.JTextArea;
import javax.swing.table.TableCellRenderer;

public class WordWrapCellRenderer extends JTextArea implements TableCellRenderer {
	private static final long serialVersionUID = 1L;

    public WordWrapCellRenderer() {
        this.setLineWrap(true);
        this.setWrapStyleWord(true);
      }

      public Component getTableCellRendererComponent(JTable table,
          Object obj, boolean isSelected, boolean hasFocus, int row,
          int column) {
  		if (isSelected)
			this.setBackground(table.getSelectionBackground());
		else
			this.setBackground(table.getBackground());
  		setText((String)obj);
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

}
