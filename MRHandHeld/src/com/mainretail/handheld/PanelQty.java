package com.mainretail.handheld;

import javax.microedition.lcdui.Font;
import org.zaval.data.Text;
import org.zaval.lw.LwBorder;
import org.zaval.lw.LwButton;
import org.zaval.lw.LwLabel;
import org.zaval.lw.LwPanel;
import org.zaval.lw.LwTextRender;
import org.zaval.lw.event.LwActionListener;
import org.zaval.port.j2me.Color;

public class PanelQty {

	private LwPanel mainPanel;
	private final LwButton btnPlus;
	private final LwButton btnLess;
	private final LwButton btn10;
	private final LwButton btnClr;
	private LwPanel panelQty;
	private LwLabel lbQty;
	private LwLabel lbValue;
	private InternalListener internalListener;
	
	public PanelQty() {

		mainPanel = new LwPanel();
		panelQty = new LwPanel();
		
		btnPlus = new LwButton("+");
		btnLess = new LwButton("-");
		btn10 = new LwButton("+10");
		btnClr = new LwButton("CLR");

		lbQty = new LwLabel("Qty ");
		lbValue = new LwLabel(new Text("1"));
		
		internalListener = new InternalListener();
		
		initPainel();
	}

	public void initPainel() {

		mainPanel.setLayout(LwPanel.LAYOUT_LEFT);

		mainPanel.setBackground(Color.white);
		panelQty.setBackground(Color.white);
		lbQty.setBackground(Color.white);
		lbValue.setBackground(Color.white);
		
		btnPlus.setBackground(Color.lightGray);
		btnLess.setBackground(Color.lightGray);
		btn10.setBackground(Color.lightGray);
		btnClr.setBackground(Color.lightGray);
		
		btnPlus.setGaps(0,0);
		btnLess.setGaps(0,0);
		btn10.setGaps(0,0);
		btnClr.setGaps(0,0);
		
		((LwTextRender)lbQty.getTextRender()).setFont(Font.getFont(Font.FACE_SYSTEM, Font.STYLE_BOLD, Font.SIZE_MEDIUM));
		
		((LwTextRender)lbValue.getTextRender()).setFont(Font.getFont(Font.FACE_SYSTEM, Font.STYLE_PLAIN, Font.SIZE_MEDIUM));
		lbValue.setGaps(0,30);
		lbValue.setBorder(new LwBorder(LwBorder.ORIGINAL));
				
		panelQty.add(lbQty);
		panelQty.add(lbValue);

		mainPanel.add(panelQty);
		
		btnPlus.setActionListener(internalListener);
	    btnLess.setActionListener(internalListener);
	    btn10.setActionListener(internalListener);
	    btnClr.setActionListener(internalListener);
		
		
	}

    class InternalListener implements LwActionListener {

		public void actionPerformed(Object src, Object data) {
			double qty = 1;

			if (src == btnPlus){
				qty = Double.parseDouble(lbValue.getText()) + 1;
			} else if (src == btnLess) {
				if ((Double.parseDouble(lbValue.getText()) - 1) > 1) 
					qty = Double.parseDouble(lbValue.getText()) - 1;
			} else if (src == btn10){
				qty = Double.parseDouble(lbValue.getText()) + 10;
			}
			lbValue.setText( String.valueOf(qty) );
			
		}
    	
    }
	
	public LwPanel getPanelQty() {
		return mainPanel;
	}
	
	public LwButton getButton10(){
		return btn10;
	}
	
	public LwButton getButtonClr(){
		return btnClr;
	}
	
	public LwButton getButtonLess(){
		return btnLess;
	}

	public LwButton getButtonPluss(){
		return btnPlus;
	}
	
	public double getQty(){
		double qty = Double.parseDouble(lbValue.getText());
		return qty;
	}
	
	public void setQty(double var){
		lbValue.setText( String.valueOf(var) );
	}
	
}

