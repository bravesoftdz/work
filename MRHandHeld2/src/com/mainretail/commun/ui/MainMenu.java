package com.mainretail.commun.ui;
import java.awt.BorderLayout;
import java.awt.FlowLayout;
import java.awt.event.ActionEvent;
import javax.swing.JButton;
import javax.swing.JPanel;
import com.mainretail.MRIcon;
import com.mainretail.commun.controller.LanguageResource;
import com.mainretail.commun.controller.NavigationManager;
import com.mainretail.sales.ui.SalesScreenFch;

public class MainMenu extends ParentPanel{
	private static final long serialVersionUID = -3101440430361360726L;
	static MRIcon mrIcon;
	private JButton jbtSale;
	private JButton jbtClose;
	private JButton jbtPurchase;
	private JButton jbtInventory;
	private JPanel jpnIcons;
	
	

	public MainMenu(ApplicationManager appManager, NavigationManager navManager){
		super(appManager, navManager);
	}


	public MainMenu() {
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
					getJbtPurchase().setPreferredSize(new java.awt.Dimension(80, 80));
					getJpnIcons().add(getJbtPurchase());
					getJbtPurchase().addActionListener(this);
				}
				{
					getJbtInventory().setPreferredSize(new java.awt.Dimension(80, 80));
					getJpnIcons().add(getJbtInventory());
					getJbtInventory().addActionListener(this);
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
	public JButton getJbtPurchase() {
		if (jbtPurchase == null)
			jbtPurchase = MRIcon.createButton(LanguageResource.getInstance().getText("PURCHASE"),"purchase");
		return jbtPurchase;
	}


	public JButton getJbtSale() {
		if (jbtSale == null)	
			jbtSale = MRIcon.createButton(LanguageResource.getInstance().getText("SALE"),"pos");
		return jbtSale;
	}
	

	public JButton getJbtInventory() {
		if (jbtInventory == null)
			jbtInventory = MRIcon.createButton(LanguageResource.getInstance().getText("INVENTORY"),"inventory");			
		return jbtInventory;
	}

	public JButton getJbtClose() {
		if (jbtClose == null) {
			jbtClose = MRIcon.createButton(LanguageResource.getInstance().getText("BACK"),"back");
		}
		return jbtClose;
	}
	
	public void onActionPerformed(ActionEvent evt) {
		if (evt.getSource() == getJbtSale()){
			getNavManager().addMRPanelComponent(new SalesScreenFch(getAppManager(), getNavManager()));			
		} else if (evt.getSource() == getJbtInventory()) {
			getNavManager().addMRPanelComponent(new MenuInventory(getAppManager(), getNavManager()));
		} else if (evt.getSource() == getJbtPurchase()) {
			getNavManager().addMRPanelComponent(new MenuPurchase(getAppManager(), getNavManager()));
		} else if (evt.getSource() == getJbtClose()) {
			quit();
		}
	}	

}
