package com.mainretail.commun.ui;

import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import javax.swing.JButton;
import javax.swing.JPanel;
import com.cloudgarden.layout.AnchorConstraint;
import com.cloudgarden.layout.AnchorLayout;
import com.mainretail.commun.controller.LanguageResource;
import com.mainretail.commun.controller.NavigationManager;

public class ParentFormOKClose extends ParentPanel {
	
	public ParentFormOKClose(ApplicationManager appManager, NavigationManager navManager){
		super(appManager, navManager);
	}
	
	public ParentFormOKClose(){
		super();
	}
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -2451462332064514198L;
	private JButton jbtOK;
	private JButton jbtClose;
	private JPanel jpnButtons;

		
	public void initGUI() {
		try {
			setSize(400, 300);
			super.initGUI();
			
			{
				
				add(getJpnButtons(), BorderLayout.SOUTH);
				AnchorLayout jpnButtonsLayout = new AnchorLayout();
				getJpnButtons().setLayout(jpnButtonsLayout);
				getJpnButtons().setPreferredSize(new java.awt.Dimension(371, 28));
				
				{					
					getJpnButtons().add(getJbtOK(), new AnchorConstraint(2, 85, 2, -774, AnchorConstraint.ANCHOR_ABS, AnchorConstraint.ANCHOR_ABS, AnchorConstraint.ANCHOR_ABS, AnchorConstraint.ANCHOR_NONE));
					getJbtOK().setText("OK");
					getJbtOK().setPreferredSize(new java.awt.Dimension(70, 28));
					getJbtOK().addActionListener(this);
					
				}
				
				{				
					getJpnButtons().add(getJbtClose(), new AnchorConstraint(2, 7, 2, -774, AnchorConstraint.ANCHOR_ABS, AnchorConstraint.ANCHOR_ABS, AnchorConstraint.ANCHOR_ABS, AnchorConstraint.ANCHOR_NONE));
					getJbtClose().setText(LanguageResource.getInstance().getText("CLOSE"));
					getJbtClose().setPreferredSize(new java.awt.Dimension(70, 28));
					getJbtClose().addActionListener(this);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public JPanel getJpnButtons() {
		if (jpnButtons == null){
			jpnButtons = new JPanel();
			jpnButtons.setBackground(this.getBackground());
		}
		return jpnButtons;
	}
	
	public JButton getJbtOK() {
		if (jbtOK == null){
			jbtOK = new JButton();
			
		}
		return jbtOK;
	}
	
	public JButton getJbtClose() {
		if (jbtClose == null)
			jbtClose = new JButton();
		return jbtClose;
	}

	public void onActionPerformed(ActionEvent evt) {
		if (evt.getSource() == getJbtOK()){
			onClickJbtOK();
		}
		else if (evt.getSource() == getJbtClose()) {
			onClickJbtClose();
		}
		
	}

	protected void onClickJbtClose() {
		quit();
	}

	public void onClickJbtOK(){
		
	};
	
		
	public JPanel getJpnClient(){
		return super.getJpnClient();
	}
	
	
}
