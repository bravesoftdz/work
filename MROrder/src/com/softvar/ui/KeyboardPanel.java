package com.softvar.ui;

import java.awt.CardLayout;
import java.awt.Font;
import java.awt.Insets;

import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.SwingConstants;

import com.softvar.controller.KeyboardManager;
import com.softvar.controller.MRIcon;

import java.awt.BorderLayout;
import java.awt.FlowLayout;
import java.awt.event.ActionEvent;

public class KeyboardPanel extends BasePanel {
	private static final long serialVersionUID = 1L;
	
	private static final int lineWidth = 230;
	private static final int lineHeight = 135;

	public static final int START_NUM = 0;
	public static final int START_ALP = 1;
	public static final int START_CHR = 2;
	
	private int startType;
	
	private JPanel jpnNumber;
	private JPanel jpnAlpha;
	private JPanel jpnChars;

	private static final String sNumLine1 = "01234";
	private static final String sNumLine2 = "56789";
	private static final String sNumLine3 = "*.,";
	
	private static final String sAlpLine1 = "qwertyu";
	private static final String sAlpLine2 = "iopasdf";
	private static final String sAlpLine3 = "ghjklzx";
	private static final String sAlpLine4 = "cvbnm";
	
	private static final String sChrLine1 = "!@#$%^&";
	private static final String sChrLine2 = "()[]{}?";
	private static final String sChrLine3 = "+-/*.,=";
	private static final String sChrLine4 = ":;<>";

	private CardLayout cardLayout;
	
	private JButton jbtNumbers;
	private JButton jbtAlpha;
	private JButton jbtChars;
	
	private JButton jbtBackspaceNum;
	private JButton jbtBackspaceAlp;
	private JButton jbtBackspaceChr;
	
	private JButton jbtEnterNum;
	private JButton jbtEnterAlp;
	private JButton jbtEnterChr;

	private JPanel jpnDetail;
	private JPanel jpnControl;

	private KeyboardManager keyboardManager;
	
	public KeyboardPanel(){
		super();
	}

	public KeyboardPanel(KeyboardManager keyboardManager, int startType){
		super();
		this.keyboardManager = keyboardManager;
		this.startType = startType;
		createOptions();
	}
	
	public void initGUI(){
		try {

			this.setPreferredSize(new java.awt.Dimension(lineWidth, lineHeight));
			super.initGUI();
			
			
			BorderLayout thisLayout = new BorderLayout();
			this.setLayout(thisLayout);

		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	private void createOptions(){
		{
			
			this.add(getJpnControl(), BorderLayout.NORTH);

			this.add(getJpnDetail(), BorderLayout.CENTER);
			
			cardLayout = (CardLayout) (getJpnDetail().getLayout());
			
			if ((startType & START_NUM) == START_NUM){ 
				getJpnControl().add(getJbtNumbers());
				getJpnDetail().add("NUM", getJpnNumber());
			}
			if ((startType & START_ALP) == START_ALP){ 
				getJpnControl().add(getJbtAlpha());
				getJpnDetail().add("ALP", getJpnAlpha());
			}
			if ((startType & START_CHR) == START_CHR){ 
				getJpnControl().add(getJbtChars());
				getJpnDetail().add("CHR", getJpnChars());
			}
			
		}
	}
	
	private JPanel createButtons(String items, int Hgap, int Vgap){
		JPanel pnl = null;
		if (items != null){
			
			pnl = new JPanel();
			FlowLayout jpnLine1Layout = new FlowLayout();
			jpnLine1Layout.setHgap(Hgap);
			jpnLine1Layout.setVgap(Vgap);
			pnl.setLayout(jpnLine1Layout);
			pnl.setPreferredSize(new java.awt.Dimension(lineWidth, 25));
			pnl.setBackground(this.getBackground());

			for (int i = 0; i < items.length(); i++ ){
				JButton btn = MRIcon.createButton(String.valueOf(items.charAt(i)), "key");
				setButtonProperties(btn);
				pnl.add(btn);	
			}
		}
		
		return pnl;
	}
	
	public void onActionPerformed(ActionEvent evt) {
		
		if (keyboardManager != null){
			
			JTextField value = keyboardManager.getManagedComponent();
			
			String text = value.getText();
						
			if((evt.getSource() == getJbtBackspaceNum()) || 
			   (evt.getSource() == getJbtBackspaceAlp()) ||
			   (evt.getSource() == getJbtBackspaceChr())){
				if (text.length() > 0)
					value.setText(text.substring(0, (text.length()-1)));
			} else if ((evt.getSource() == getJbtEnterNum()) || 
					   (evt.getSource() == getJbtEnterAlp()) ||
					   (evt.getSource() == getJbtEnterChr())){
				keyboardManager.onReturnKey();
			} else if(evt.getSource() == getJbtNumbers()){
				cardLayout.show(getJpnDetail(), "NUM");
			} else if (evt.getSource() == getJbtAlpha()){
				cardLayout.show(getJpnDetail(), "ALP");
			} else if (evt.getSource() == getJbtChars()){
				cardLayout.show(getJpnDetail(), "CHR");
			}
			else {
				String key = ((JButton)evt.getSource()).getText();
			
				if ((key != null) && (! key.equals(""))){
					value.setText(text + key);						
				}
			}
			keyboardManager.getManagedComponent().requestFocus();
		}
	}
	
	
	public void setButtonProperties(JButton btn){
		btn.setMargin(new Insets(0, 0, 0, 0));
		btn.setPreferredSize(new java.awt.Dimension(29, 24));
		btn.setVerticalTextPosition(SwingConstants.CENTER);
		btn.setFont(new Font("Tahoma", 0, 12));
		btn.addActionListener(this);
	}

	public JButton getJbtAlpha(){
		if (jbtAlpha == null){
			jbtAlpha = MRIcon.createButton("", "key_alph");
		setButtonProperties(jbtAlpha);
		}
		return jbtAlpha;
	}

	
	public JButton getJbtChars(){
		if (jbtChars == null){
			jbtChars = MRIcon.createButton("", "key_char");
		setButtonProperties(jbtChars);
		}
		return jbtChars;
	}
	
	
	public JButton getJbtNumbers(){
		if (jbtNumbers == null){
			jbtNumbers = MRIcon.createButton("", "key_num");
		setButtonProperties(jbtNumbers);
		}
		return jbtNumbers;
	}
	
	public JButton getJbtBackspaceNum() {
		if (jbtBackspaceNum == null){
			jbtBackspaceNum = MRIcon.createButton("", "keyback");
		setButtonProperties(jbtBackspaceNum);
		}
		return jbtBackspaceNum;
	}

	public JButton getJbtBackspaceAlp() {
		if (jbtBackspaceAlp == null){
			jbtBackspaceAlp = MRIcon.createButton("", "keyback");
		setButtonProperties(jbtBackspaceAlp);
		}
		return jbtBackspaceAlp;
	}

	public JButton getJbtBackspaceChr() {
		if (jbtBackspaceChr == null){
			jbtBackspaceChr = MRIcon.createButton("", "keyback");
		setButtonProperties(jbtBackspaceChr);
		}
		return jbtBackspaceChr;
	}
	
	public JButton getJbtEnterNum() {
		if (jbtEnterNum == null){
			jbtEnterNum = MRIcon.createButton("", "keyenter");
		setButtonProperties(jbtEnterNum);
		}
		return jbtEnterNum;
	}

	public JButton getJbtEnterAlp() {
		if (jbtEnterAlp == null){
			jbtEnterAlp = MRIcon.createButton("", "keyenter");
		setButtonProperties(jbtEnterAlp);
		}
		return jbtEnterAlp;
	}

	public JButton getJbtEnterChr() {
		if (jbtEnterChr == null){
			jbtEnterChr = MRIcon.createButton("", "keyenter");
		setButtonProperties(jbtEnterChr);
		}
		return jbtEnterChr;
	}
	

	public void setKeyboardManager(KeyboardManager keyboardManager) {
		this.keyboardManager = keyboardManager;
	}

	
	public JPanel getJpnAlpha() {
		if (jpnAlpha == null){
			jpnAlpha = new JPanel();
			FlowLayout jpnAlphaLayout = new FlowLayout();
			jpnAlphaLayout.setHgap(1);
			jpnAlphaLayout.setVgap(1);
			jpnAlpha.setLayout(jpnAlphaLayout);
			jpnAlpha.setPreferredSize(new java.awt.Dimension(lineWidth, 50));
			jpnAlpha.setBackground(this.getBackground());
			{
				jpnAlpha.add(createButtons(sAlpLine1, 1, 1));
				jpnAlpha.add(createButtons(sAlpLine2, 1, 1));
				jpnAlpha.add(createButtons(sAlpLine3, 1, 1));
				JPanel jpnlA = createButtons(sAlpLine4, 1, 1);
				jpnlA.add(getJbtBackspaceAlp());
				jpnlA.add(getJbtEnterAlp());
				jpnAlpha.add(jpnlA);
			}
		}
		return jpnAlpha;
	}
	
	
	public JPanel getJpnChars() {
		if (jpnChars == null){
			jpnChars = new JPanel();
			FlowLayout jpnNumberLayout = new FlowLayout();
			jpnNumberLayout.setHgap(1);
			jpnNumberLayout.setVgap(1);
			jpnChars.setLayout(jpnNumberLayout);
			jpnChars.setPreferredSize(new java.awt.Dimension(lineWidth, 50));
			jpnChars.setBackground(this.getBackground());
			{
				jpnChars.add(createButtons(sChrLine1, 1, 1));
				jpnChars.add(createButtons(sChrLine2, 1, 1));
				jpnChars.add(createButtons(sChrLine3, 1, 1));
				JPanel jpnlC = createButtons(sChrLine4, 1, 1);
				jpnlC.add(getJbtBackspaceChr());
				jpnlC.add(getJbtEnterChr());
				jpnChars.add(jpnlC);
			}
		}
		return jpnChars;
	}
	
	
	public JPanel getJpnNumber() {
		if (jpnNumber == null){
			jpnNumber = new JPanel();
			FlowLayout jpnNumberLayout = new FlowLayout();
			jpnNumberLayout.setHgap(1);
			jpnNumberLayout.setVgap(8);
			jpnNumber.setLayout(jpnNumberLayout);
			jpnNumber.setPreferredSize(new java.awt.Dimension(lineWidth, 50));
			jpnNumber.setBackground(this.getBackground());
			{
				jpnNumber.add(createButtons(sNumLine1, 8, 1));
				jpnNumber.add(createButtons(sNumLine2, 8, 1));
				JPanel jpnlN = createButtons(sNumLine3, 8, 1);
				jpnlN.add(getJbtBackspaceNum());
				jpnlN.add(getJbtEnterNum());
				jpnNumber.add(jpnlN);
			}
		}
		return jpnNumber;
	}
	
	public JPanel getJpnControl() {
		if (jpnControl == null){ 
			jpnControl = new JPanel();
			BoxLayout jpnControlLayout = new BoxLayout(
				jpnControl,
				javax.swing.BoxLayout.X_AXIS);
			jpnControl.setLayout(jpnControlLayout);
			jpnControl.setPreferredSize(new java.awt.Dimension(lineWidth, 30));
			jpnControl.setBackground(this.getBackground());
		}
		return jpnControl;
	}
	
	public JPanel getJpnDetail() {
		if (jpnDetail == null) {
			jpnDetail = new JPanel();
			jpnDetail.setBackground(this.getBackground());
			CardLayout jpnDetailLayout = new CardLayout();
			jpnDetail.setLayout(jpnDetailLayout);
		}
		return jpnDetail;
	}


}
