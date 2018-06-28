package com.mainretail.commun.ui;

import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JPopupMenu;
import javax.swing.JTextField;

import com.mainretail.MRIcon;
import com.mainretail.commun.controller.LanguageResource;
import com.mainretail.commun.controller.KeyboardManager;

public class QtyPanel extends BasePanel implements KeyboardManager{

	private static final long serialVersionUID = 737878789910663746L;
	private JLabel jlbQty;
	private JTextField jtfQty;
	private JButton jbtDropDown;
	private JPopupMenu menu;
	private JPanel jpnDropDown; 

	public QtyPanel() {
		super();
	}
	
	public void initGUI() {
		try {
			//this.setPreferredSize(new java.awt.Dimension(400, 25));
			super.initGUI();
			{
				FlowLayout qtyPanel_ILLayout = new FlowLayout();
				qtyPanel_ILLayout.setVgap(0);
				this.setLayout(qtyPanel_ILLayout);
				
				this.add(getJpnDropDown());
				
				getJpnDropDown().add(getJlbQty());
				getJlbQty().setText(LanguageResource.getInstance().getText("QTY") + " ");
				
				getJpnDropDown().add(getJtfQty());
				
				getJpnDropDown().add(getJbtDropDown());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public void setQty(int qty){
		if (qty == 0)
			getJtfQty().setText("");
		else
			getJtfQty().setText(String.valueOf(qty));
	}
	
	public double getQty(){
		double retorno = 1;
		try{
			String valor = getJtfQty().getText().trim();
			if (!valor.equals("")){
				retorno = Double.valueOf(valor).doubleValue();
			}
		}
		catch(Exception e){
		}
		return retorno;
	}

	public void onActionPerformed(ActionEvent evt) {
		if (evt.getSource() == getJbtDropDown()){
			getMenu().show(getJtfQty(), 0, getJtfQty().getSize().height);
		}
	}
	
	public JPopupMenu getMenu() {
		if (menu == null){
			menu = new JPopupMenu();
			KeyboardPanel kbp = new KeyboardPanel(this, KeyboardPanel.START_NUM);
			//kbp.setSize(190, 100);
			kbp.setSize(190, 300);
			menu.add(kbp);
			//menu.setSize(kbp.getSize());
			//menu.setMinimumSize(kbp.getSize());
			
			menu.pack();
		}
		return menu;
	}
	
	public JLabel getJlbQty(){
		if (jlbQty == null)
			jlbQty = new JLabel();
		return jlbQty;  
	}
	
	public JTextField getJtfQty() {
		if (jtfQty == null) {
			jtfQty = new JTextField();
			jtfQty.setPreferredSize(new Dimension(28, 20));
		}
		return jtfQty;
	}

	public JButton getJbtDropDown(){
		if (jbtDropDown == null){
			jbtDropDown = MRIcon.createButton("", "dropdown");
			jbtDropDown.setMargin(new Insets(0, 0, 0, 0));
			jbtDropDown.setPreferredSize(new java.awt.Dimension(19,20));
			jbtDropDown.addActionListener(this);
		}
		return jbtDropDown;
	}
	
	public JTextField getManagedComponent() {
		return getJtfQty();
	}

	public void onReturnKey() {
		getMenu().setVisible(false);
	}

	public JPanel getJpnDropDown() {
		if (jpnDropDown == null){
			jpnDropDown = new JPanel();
			FlowLayout jpnDropDownLayout = new FlowLayout();
			jpnDropDownLayout.setVgap(0);
			jpnDropDownLayout.setHgap(0);
			jpnDropDown.setLayout(jpnDropDownLayout);
			jpnDropDown.setBackground(this.getBackground());
		}
		return jpnDropDown;
	}

}
