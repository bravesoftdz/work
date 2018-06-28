package com.mainretail.purchase.ui;

import java.awt.BorderLayout;
import java.awt.FlowLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;

import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JPopupMenu;
import javax.swing.JTextField;

import com.mainretail.MRIcon;
import com.mainretail.commun.controller.KeyboardManager;
import com.mainretail.commun.controller.LanguageResource;
import com.mainretail.commun.ui.KeyboardPanel;
import com.mainretail.purchase.event.DocumentListener;

public class SelectDocument extends com.mainretail.commun.ui.BasePanel implements KeyboardManager {
	private static final long serialVersionUID = 1L;
	private JTextField jtfDocument;
	private JLabel jlbDocument;
	private JPanel jpnTop;
	
	private JButton jbtDropDown;
	
	private JPanel jpnKey;
	private JPopupMenu menu;
	
	private DocumentListener documentListener;

	public SelectDocument() {
		super();
	}
	
	public void initGUI() {
		
		try {
			
			super.initGUI();
			
			BorderLayout thisLayout = new BorderLayout();
			this.setLayout(thisLayout);

			this.add(getJpnTop(), BorderLayout.NORTH);
			getJpnTop().add(getJlbDocument());
			getJpnTop().add(getJtfDocument());
			getJpnTop().add(getJbtDropDown());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public JPanel getJpnTop() {
		if (jpnTop == null){
			jpnTop = new JPanel();
			jpnTop.setBackground(this.getBackground());
			FlowLayout jpnTopLayout = new FlowLayout();
			jpnTopLayout.setVgap(0);
			jpnTopLayout.setHgap(0);
			jpnTop.setLayout(jpnTopLayout);
			
		}
		return jpnTop;
	}	
	
	public JPanel getJpnKey() {
		if (jpnKey == null) {
			jpnKey = new JPanel();
			jpnKey.setBackground(this.getBackground());
		}
		return jpnKey;
	}
	public JTextField getJtfDocument() {
		if (jtfDocument == null){
			jtfDocument = new JTextField();
			jtfDocument.setPreferredSize(new java.awt.Dimension(45, 20));
		}
		return jtfDocument;
	}
	
	public JLabel getJlbDocument() {
		if (jlbDocument == null){
			jlbDocument = new JLabel();
			jlbDocument.setText(LanguageResource.getInstance().getText("DOCUMENT_NUMBER") + " ");
		}
		return jlbDocument;
	}
	
	public void onDocument(){
		if (documentListener != null){
			documentListener.documentEntered(getJtfDocument().getText());
			getJtfDocument().setText("");
		}
	}
	
	public void onActionPerformed(ActionEvent evt) {
		if (evt.getSource() == getJbtDropDown()){
			getMenu().show(getJtfDocument(), 0, getJtfDocument().getSize().height);
		}
		else
			super.onActionPerformed(evt);
		
	}

	public DocumentListener getDocumentListener() {
		return documentListener;
	}

	public void setDocumentListener(DocumentListener documentListener) {
		this.documentListener = documentListener;
	}

	public JTextField getManagedComponent() {
		return getJtfDocument();
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
	
	
	public JPopupMenu getMenu() {
		if (menu == null){
			menu = new JPopupMenu();
			KeyboardPanel kbp = new KeyboardPanel(this, (KeyboardPanel.START_NUM | KeyboardPanel.START_ALP | KeyboardPanel.START_CHR) );
			//kbp.setSize(190, 100);
			kbp.setSize(190, 300);
			menu.add(kbp);
			//menu.setSize(kbp.getSize());
			//menu.setMinimumSize(kbp.getSize());
			
			menu.pack();
		}
		return menu;
	}

	public void onReturnKey() {
		onDocument();
		getMenu().setVisible(false);
	}
	

}
