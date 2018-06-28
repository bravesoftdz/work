package com.mainretail.handheld;

import org.zaval.data.Matrix;
import org.zaval.lw.LwActContainer;
import org.zaval.lw.LwButton;
import org.zaval.lw.LwPanel;
import org.zaval.lw.grid.LwGrid;
import org.zaval.lw.grid.LwGridCaption;
import org.zaval.port.j2me.Color;
import org.zaval.lw.event.LwActionListener;


public class PanelGrid {
	
	private LwPanel panel;
	private LwGrid grid;
	private Matrix gridModel;
	private LwGridCaption cap;
	
	private LwButton btnNext;
	private LwButton btnPrior;
	private LwButton btnDelete;
	private LwButton btnEdit;
	
	private InternalListener internalListener;
	
	public PanelGrid(){
		
	}
	
	private void setVisibility(boolean visible){
		cap.setVisible(visible);
		btnPrior.setVisible(visible);
		btnNext.setVisible(visible);
		btnDelete.setVisible(visible);
		btnEdit.setVisible(visible);
	}
	
	public PanelGrid(String[] colTitles, int[] colSize){
		
		/**/
		gridModel = new Matrix(0, colTitles.length);
	    grid = new LwGrid(gridModel);
		/**/
		
		
		panel = new LwActContainer(grid);
		
		panel.setGaps(0, 0);
	    panel.setBackground(Color.white);
	    
		btnNext = new LwButton("Next");
		btnPrior = new LwButton("Prior");
		btnDelete = new LwButton("Delete");
		btnEdit = new LwButton("Edit");

		//btnNext.setBackground(Color.white);
		
		internalListener = new InternalListener();
		initPainel();
		
		/*
	    gridModel = new Matrix(0, colTitles.length);
	    
	    
	    grid = new LwGrid(gridModel);
	    */
	    
	    grid.setBackground(Color.white);
	    

	    for (int i = 0; i <= (colSize.length-1); i++){
	    	grid.setColWidth(i, colSize[i]);
	    }
	    
	    cap  = new LwGridCaption(grid);
    
	    cap.setBackground(Color.lightGray);
        
	    for (int i = 0; i <= (colTitles.length-1); i++){
	     	cap.putTitle (i, colTitles[i].toString());
	    }
	    panel.add(LwPanel.LAYOUT_NEWLINE_AFTER, cap);
	    setVisibility(false);
	    panel.add(grid);
	    
	}
	
	public void initPainel(){
		btnNext.setActionListener(internalListener);
	    btnPrior.setActionListener(internalListener);
	}

	public LwGridCaption getCap(){
		return cap;
	}
	
	public LwPanel getPanelGrid() {
		return panel;
	}
	
	public LwGrid getGrid(){
		return grid;
	}
	
	public Matrix getGridModel(){
		return gridModel;
	}
	
	public LwButton getBtnNext(){
		return btnNext;
	}
	
	public LwButton getBtnPrior(){
		return btnPrior;
	}

	public LwButton getBtnDelete(){
		return btnDelete;
	}
	
	public LwButton getBtnEdit(){
		return btnEdit;
	}
	
	public void insertRow (String values[]){
		int newRow = gridModel.getRows();
		gridModel.setRows(newRow + 1);
				
		for (int i=0; i < values.length; i++ ){
			gridModel.put(newRow, i, values[i]);
		}
		
		if (!cap.isVisible())
			setVisibility(true);
		
	}
	
	public void deleteRow (int line){
		gridModel.removeRows(line, line);
	}
	
	public void deleteRows (int iniLine, int endLine){
		gridModel.removeRows(iniLine, endLine);
		if ((gridModel.getRows()==0))
			setVisibility(false);
	}
	
	class InternalListener implements LwActionListener {

			public void actionPerformed(Object src, Object data) {
				if (src == btnNext){
					if (grid.getSelectedIndex()+1 < gridModel.getRows())
						grid.select(grid.getSelectedIndex()+1);
					
				} else if (src == btnPrior) {
					if (grid.getSelectedIndex()-1 >= 0)
						grid.select(grid.getSelectedIndex()-1);
				}
			}
	   }
	
	
}
