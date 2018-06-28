package com.softvar.mrorder.ui;
import java.awt.BorderLayout;
import java.awt.FlowLayout;
import java.awt.event.ActionEvent;
import javax.swing.JButton;
import javax.swing.JPanel;


import com.softvar.controller.ApplicationManager;
import com.softvar.controller.MRIcon;
import com.softvar.controller.NavigationManager;
import com.softvar.controller.event.LoginListener;
import com.softvar.internationalization.LanguageResource;
import com.softvar.model.order.Account;
import com.softvar.model.order.IAccountDAO;
import com.softvar.mrorder.controller.Config;
import com.softvar.persistence.DAOUtil;
import com.softvar.persistence.IParentDAO;
import com.softvar.ui.LoginScreen;
import com.softvar.ui.MsgBox;
import com.softvar.ui.ParentPanel;

public class MenuScreen extends ParentPanel implements LoginListener{
	private static final long serialVersionUID = -3101440430361360726L;
	private static final int MENU_MAIN = 1;
	private static final int MENU_CONFIG = 2;
	private static final int MENU_EXIT = 3;

	
	private static final int DIMENTION_X = 70;
	private static final int DIMENTION_Y = 80;
	
	private JButton jbtPrinting;
	private JButton jbtClose;
	private JButton jbtConfig;
	private JButton jbtSync;
	private JButton jbtUpdatePrice;
	private JButton jbtPromotion;
	private JButton jbtOrderVirification;
	private JButton jbtSalerPerson;
	private JButton jbtRGA;
	private JPanel jpnIcons;
	private LoginScreen loginScreen;
	private int screen;
	private JButton jbtOrder;

	public MenuScreen(ApplicationManager appManager, NavigationManager navManager){
		super(appManager, navManager);
	}


	public MenuScreen() {
		super();
	}	
	
	
	public void initGUI() {
		try {
			{
				this.setSize(628, 180);
			}

			super.initGUI();
			{
				
				getJpnClient().add(getJpnIcons(), BorderLayout.CENTER);
				FlowLayout jpnIconsLayout = new FlowLayout();
				jpnIconsLayout.setHgap(0);
				jpnIconsLayout.setVgap(0);
				//jpnIconsLayout.
				getJpnIcons().setLayout(jpnIconsLayout);
				getJpnIcons().setPreferredSize(new java.awt.Dimension(531, 134));

				{
					getJpnIcons().add(getJbtOrder());
					getJbtOrder().setPreferredSize(new java.awt.Dimension(DIMENTION_X, DIMENTION_Y));
					getJbtOrder().addActionListener(this);
				}
				
				{
					getJpnIcons().add(getJbtPrinting());
					getJbtPrinting().setPreferredSize(new java.awt.Dimension(DIMENTION_X, DIMENTION_Y));
					getJbtPrinting().addActionListener(this);
				}

				{
					getJpnIcons().add(getJbtUpdatePrice());
					getJbtUpdatePrice().setPreferredSize(new java.awt.Dimension(DIMENTION_X, DIMENTION_Y));
					getJbtUpdatePrice().addActionListener(this);
				}
				
				{
					getJpnIcons().add(getJbtRGA());
					getJbtRGA().setPreferredSize(new java.awt.Dimension(DIMENTION_X, DIMENTION_Y));
					getJbtRGA().addActionListener(this);
				}

				{
					getJpnIcons().add(getJbtPromotion());
					getJbtPromotion().setPreferredSize(new java.awt.Dimension(DIMENTION_X, DIMENTION_Y));
					getJbtPromotion().addActionListener(this);
				}
				
				{
					getJpnIcons().add(getJbtOrderVirification());
					getJbtOrderVirification().setPreferredSize(new java.awt.Dimension(DIMENTION_X, DIMENTION_Y));
					getJbtOrderVirification().addActionListener(this);
				}
				
				{
					getJpnIcons().add(getJbtSalerPerson());
					getJbtSalerPerson().setPreferredSize(new java.awt.Dimension(DIMENTION_X, DIMENTION_Y));
					getJbtSalerPerson().addActionListener(this);
				}
				
				//jpnIcons.setBackground(new java.awt.Color(255,255,255));
				/*
				{
					getJpnIcons().add(getJbtLogin());
					
					getJbtLogin().setPreferredSize(new java.awt.Dimension(80, 80));
					getJbtLogin().addActionListener(this);
				}
				*/

				{
					getJbtSync().setPreferredSize(new java.awt.Dimension(DIMENTION_X, DIMENTION_Y));
					getJpnIcons().add(getJbtSync());
					getJbtSync().addActionListener(this);
				}
				
				{
					getJbtConfig().setPreferredSize(new java.awt.Dimension(DIMENTION_X, DIMENTION_Y));
					getJpnIcons().add(getJbtConfig());
					getJbtConfig().addActionListener(this);
				}

				{
					getJpnIcons().add(getJbtClose());
					getJbtClose().setPreferredSize(new java.awt.Dimension(DIMENTION_X, DIMENTION_Y));
					getJbtClose().addActionListener(this);
				}
				
			}
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public JPanel getJpnIcons() {
		if (jpnIcons == null){
			jpnIcons = new JPanel();
			jpnIcons.setBackground(this.getBackground());
		}
		return jpnIcons;
	}
	
	public JButton getJbtConfig() {
		if (jbtConfig == null)
			jbtConfig = MRIcon.createButton(LanguageResource.getInstance().getText("CONFIG"),"config");
		return jbtConfig;
	}


	public JButton getJbtPrinting() {
		if (jbtPrinting == null)	
			jbtPrinting = MRIcon.createButton("Printing","printing");
		return jbtPrinting;
	}
	

	public JButton getJbtSync() {
		if (jbtSync == null)
			jbtSync = MRIcon.createButton(LanguageResource.getInstance().getText("SYNC"),"sync");			
		return jbtSync;
	}

	public JButton getJbtClose() {
		if (jbtClose == null) {
			jbtClose = MRIcon.createButton(LanguageResource.getInstance().getText("EXIT"),"exit");
		}
		return jbtClose;
	}
	
	public JButton getJbtOrder(){
		if (jbtOrder == null) {
			jbtOrder = MRIcon.createButton(LanguageResource.getInstance().getText("ORDER"),"po");
		}
		return jbtOrder;
		
	}
	
	public JButton getJbtUpdatePrice() {
		if (jbtUpdatePrice == null) {
			jbtUpdatePrice = MRIcon.createButton("UpdPricing","updateprice");
		}
		return jbtUpdatePrice;
	}

	public JButton getJbtPromotion() {
		if (jbtPromotion == null) {
			jbtPromotion = MRIcon.createButton("Promotion","promotion");
		}
		return jbtPromotion;
	}

	public JButton getJbtOrderVirification() {
		if (jbtOrderVirification == null) {
			jbtOrderVirification = MRIcon.createButton("Order Vefic","orderveri");
		}
		return jbtOrderVirification;
	}


	public JButton getJbtSalerPerson() {
		if (jbtSalerPerson == null) {
			jbtSalerPerson = MRIcon.createButton("SalesPerson","salesperson");
		}
		return jbtSalerPerson;
	}
	
	public JButton getJbtRGA() {
		if (jbtRGA == null) {
			jbtRGA = MRIcon.createButton("RGA","rga");
		}
		return jbtRGA;
	}
	
	
	public void onActionPerformed(ActionEvent evt) {
		/*
		if (evt.getSource() == getJbtLogin()){
			screen = MENU_MAIN;
			getNavManager().addMRPanelComponent(new LoginScreen(getAppManager(), getNavManager(), this));			
		} else*/ if (evt.getSource() == getJbtSync()) {
			if (DAOUtil.getDAO(Account.class, IParentDAO.DATABASE_DB4O).listAll().size() == 0)
				getNavManager().addMRPanelComponent(new SyncScreen(getAppManager(), getNavManager()));
			else
				if (MsgBox.yesNoMsg(this, LanguageResource.getInstance().getText("MSG_QUESTION_SWITCH_SYNCH")))
					getNavManager().addMRPanelComponent(new AccountCostSynchScreen(getAppManager(), getNavManager()));
				else
					getNavManager().addMRPanelComponent(new SyncScreen(getAppManager(), getNavManager()));
		} else if (evt.getSource() == getJbtOrder()) {
			if (hasAccount())
				getNavManager().addMRPanelComponent(new OrderScreen(getAppManager(), getNavManager()));
			else
				MsgBox.errorMsg(this, LanguageResource.getInstance().getText("MSG_ERROR_NO_ACCOUNT"));
		} else if (evt.getSource() == getJbtConfig()) {
		
/*			if (Config.getInstance().getIsAdminExit()){
				screen = MENU_CONFIG;
				loginScreen = new LoginScreen(getAppManager(), getNavManager(), this);
				getNavManager().addMRPanelComponent(loginScreen);
			} else*/
				getNavManager().addMRPanelComponent(new ConfigurationScreen(getAppManager(), getNavManager()));
			
			
		} else if (evt.getSource() == getJbtClose()) {
			
/*			if (Config.getInstance().getIsAdminExit()){
				screen = MENU_EXIT;
				loginScreen = new LoginScreen(getAppManager(), getNavManager(), this);
				getNavManager().addMRPanelComponent(loginScreen);
			} else
*/				quit();
		}
	}


	public void ValidLogin() {
		
		switch (screen) {
			case MENU_MAIN : {
				getNavManager().addMRPanelComponent(new MainMenu(getAppManager(), getNavManager())); 
				break;
			}
			case MENU_CONFIG : {
//								if (!RuntimeInfo.getInstance().customer.isAdministrator())
//									MsgBox.errorMsg(this, LanguageResource.getInstance().getText("MSG_INFO_ONLY_ADM_EDIT_CONG"));
//								else
									{
										getNavManager().addMRPanelComponent(new ConfigurationScreen(getAppManager(), getNavManager())); 										
									}
									break;
			}
			case MENU_EXIT : {
//								if (!RuntimeInfo.getInstance().customer.isAdministrator())
//									MsgBox.errorMsg(this, LanguageResource.getInstance().getText("MSG_INFO_ONLY_ADM_EXIT"));
//								else
									{
										loginScreen.quit();
										quit();
									}; 
								break;
			}
			default: break;
		}
		
		
		
	}
	
	private boolean hasAccount(){
		return ((IAccountDAO)DAOUtil.getDAO(Account.class, IParentDAO.DATABASE_DB4O)).getByAccountNum(Config.getInstance().getAccountNum()) != null;
	}


}
