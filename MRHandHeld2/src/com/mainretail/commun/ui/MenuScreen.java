package com.mainretail.commun.ui;
import java.awt.BorderLayout;
import java.awt.FlowLayout;
import java.awt.event.ActionEvent;
import javax.swing.JButton;
import javax.swing.JPanel;
import com.mainretail.MRIcon;
import com.mainretail.commun.controller.LanguageResource;
import com.mainretail.commun.controller.NavigationManager;
import com.mainretail.commun.controller.RuntimeInfo;
import com.mainretail.commun.model.Config;

public class MenuScreen extends ParentPanel implements LoginListener{
	private static final long serialVersionUID = -3101440430361360726L;
	private static final int MENU_MAIN = 1;
	private static final int MENU_CONFIG = 2;
	private static final int MENU_EXIT = 3;
	static MRIcon mrIcon;
	private JButton jbtSale;
	private JButton jbtClose;
	private JButton jbtConfig;
	private JButton jbtSync;
	private JPanel jpnIcons;
	private LoginScreen loginScreen;
	private int screen;

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
				jpnIconsLayout.setHgap(5);
				jpnIconsLayout.setVgap(5);
				getJpnIcons().setLayout(jpnIconsLayout);
				getJpnIcons().setPreferredSize(new java.awt.Dimension(531, 134));
				//jpnIcons.setBackground(new java.awt.Color(255,255,255));
				{
					getJpnIcons().add(getJbtSale());
					
					getJbtSale().setPreferredSize(new java.awt.Dimension(80, 80));
					getJbtSale().addActionListener(this);
				}
				{
					getJbtSync().setPreferredSize(new java.awt.Dimension(80, 80));
					getJpnIcons().add(getJbtSync());
					getJbtSync().addActionListener(this);
				}
				{
					getJbtConfig().setPreferredSize(new java.awt.Dimension(80, 80));
					getJpnIcons().add(getJbtConfig());
					getJbtConfig().addActionListener(this);
				}
				{
					getJbtClose().setPreferredSize(new java.awt.Dimension(80, 80));
					getJpnIcons().add(getJbtClose());
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
	
	public MRIcon getMRIcon(){
		if (mrIcon == null)
			mrIcon = new MRIcon();
		return mrIcon;
	}
	public JButton getJbtConfig() {
		if (jbtConfig == null)
			jbtConfig = MRIcon.createButton(LanguageResource.getInstance().getText("CONFIG"),"config");
		return jbtConfig;
	}


	public JButton getJbtSale() {
		if (jbtSale == null)	
			jbtSale = MRIcon.createButton(LanguageResource.getInstance().getText("LOGIN"),"login");
		return jbtSale;
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
	
	public void onActionPerformed(ActionEvent evt) {
		if (evt.getSource() == getJbtSale()){
			screen = MENU_MAIN;
			getNavManager().addMRPanelComponent(new LoginScreen(getAppManager(), getNavManager(), this));			
		} else if (evt.getSource() == getJbtSync()) {
			getNavManager().addMRPanelComponent(new SyncScreen(getAppManager(), getNavManager()));
		} else if (evt.getSource() == getJbtConfig()) {
		
			if (Config.getInstance().getIsAdminExit()){
				screen = MENU_CONFIG;
				loginScreen = new LoginScreen(getAppManager(), getNavManager(), this);
				getNavManager().addMRPanelComponent(loginScreen);
			} else{
				getNavManager().addMRPanelComponent(new ConfigurationScreen(getAppManager(), getNavManager()));
			}
			
		} else if (evt.getSource() == getJbtClose()) {
			if (Config.getInstance().getIsAdminExit()){
				screen = MENU_EXIT;
				loginScreen = new LoginScreen(getAppManager(), getNavManager(), this);
				getNavManager().addMRPanelComponent(loginScreen);
			} else
				quit();
		}
	}


	public void ValidLogin() {
		
		switch (screen) {
			case MENU_MAIN : getNavManager().addMRPanelComponent(new MainMenu(getAppManager(), getNavManager())); break;
			case MENU_CONFIG :
								if (!RuntimeInfo.getInstance().user.isAdministrator())
									MsgBox.errorMsg(this, LanguageResource.getInstance().getText("MSG_INFO_ONLY_ADM_EDIT_CONG"));
								else
									getNavManager().addMRPanelComponent(new ConfigurationScreen(getAppManager(), getNavManager())); break;
			case MENU_EXIT :
								if (!RuntimeInfo.getInstance().user.isAdministrator())
									MsgBox.errorMsg(this, LanguageResource.getInstance().getText("MSG_INFO_ONLY_ADM_EXIT"));
								else{
									loginScreen.quit();
									quit();
								}; break;
			default: break;
		}
		
		
		
	}



}
