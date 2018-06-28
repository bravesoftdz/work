package com.softvar.ui;

import java.awt.FlowLayout;
import java.awt.Insets;

import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JPopupMenu;
import javax.swing.JTextField;


import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import javax.swing.JButton;


import com.softvar.controller.ApplicationManager;
import com.softvar.controller.KeyboardManager;
import com.softvar.controller.MRIcon;
import com.softvar.controller.NavigationManager;
import com.softvar.controller.RuntimeInfo;
import com.softvar.controller.event.LoginListener;
import com.softvar.internationalization.LanguageResource;
import com.softvar.model.Customer;

public class LoginScreen extends ParentFormOKClose implements KeyboardManager {
	
	private static final long serialVersionUID = 5312403515919319902L;
	private JLabel jlbPW;
	private JPasswordField jtfPW;
	private JPanel jpnTop;
	
	private JButton jbtDropDown;
	
	private JPanel jpnKey;
	private Customer customer;
	private LoginListener loginListener;
	private JPopupMenu menu;
	
	public LoginScreen(ApplicationManager appManager, NavigationManager navManager, LoginListener loginListener){
		super(appManager, navManager);
		this.loginListener = loginListener;
	}

	public LoginScreen() {
		super();
	}
	
	public void initGUI() {
		try {

			super.initGUI();
			{
				getJpnClient().add(getJpnTop(), BorderLayout.NORTH);
			
				getJpnTop().add(getJlbPW());
				getJpnTop().add(getJtfPW());
				getJpnTop().add(getJbtDropDown());
				getJtfPW().requestFocus();
				
				{
					getJpnClient().add(getJpnKey(), BorderLayout.CENTER);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public JLabel getJlbPW() {
		if (jlbPW == null){
			jlbPW = new JLabel();
			jlbPW.setText(LanguageResource.getInstance().getText("PASSWORD") + " ");
		}
		return jlbPW;
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

	public JPasswordField getJtfPW() {
		if (jtfPW == null){
			jtfPW = new JPasswordField();
			jtfPW.setPreferredSize(new java.awt.Dimension(105, 20));
		}
		return jtfPW;
	}

	public void onClickJbtOK() {
		
		
		
		
		RuntimeInfo.getInstance().customer = getCustomer();
		loginListener.ValidLogin();
		
		// OLD CODE FROM MRHANDHELD
		/*
		 
		String pw = String.valueOf(getJtfPW().getPassword()).trim();
		if (!pw.equals("")) {
			IUserDAO iUser = (IUserDAO)DAOUtil.getDAO(User.class, IParentDAO.DATABASE_DB4O);
			customer = (User)iUser.validateUser(pw);
			if (customer != null) {
				RuntimeInfo.getInstance().customer = this.customer;
				loginListener.ValidLogin();
			} else {
				MsgBox.errorMsg(this, LanguageResource.getInstance().getText("MSG_INFO_INVALID_PASSWORD"));
			}
		}
		*/
		
	}
	
	protected Customer getCustomer(){
		if (customer == null){
			customer = new Customer();
			customer.customer = "Test Customer";
		}
		return customer;
	}
	
	public JPanel getJpnKey() {
		if (jpnKey == null) {
			jpnKey = new JPanel();
			jpnKey.setBackground(this.getBackground());
		}
		return jpnKey;
	}

	public JTextField getManagedComponent() {
		return getJtfPW();
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

	
	public JButton getJbtDropDown(){
		if (jbtDropDown == null){
			jbtDropDown = MRIcon.createButton("", "dropdown");
			jbtDropDown.setMargin(new Insets(0, 0, 0, 0));
			jbtDropDown.setPreferredSize(new java.awt.Dimension(19,20));
			jbtDropDown.addActionListener(this);
		}
		return jbtDropDown;
	}
	
	
	public void onActionPerformed(ActionEvent evt) {
		if (evt.getSource() == getJbtDropDown()){
			getMenu().show(getJtfPW(), 0, getJtfPW().getSize().height);
		} else {
			super.onActionPerformed(evt);
		}
	}

	public void onReturnKey() {
		onClickJbtOK();
		getMenu().setVisible(false);
	}
	

}
