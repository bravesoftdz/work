package com.mainretail.commun.ui;
import java.awt.BorderLayout;
import java.awt.CardLayout;
import java.awt.FlowLayout;
import java.awt.event.ActionEvent;
import java.util.Vector;

import javax.swing.Box;
import javax.swing.JButton;
import javax.swing.JPanel;

import com.mainretail.MRIcon;
import com.mainretail.commun.controller.NavigationManager;

public class ParentFormFch extends ParentPanel {

	private static final long serialVersionUID = -5564759510274134487L;
	private Box boxSwitchButtons;
	private JPanel jpnDetail;
	
	private Vector buttons = null;
	private JButton jbtQuit;
	private JPanel jpnlFchTop;
	private JPanel jpnlButtons;
	private JPanel jpnlInfo;

	public ParentFormFch() {
		super();
	}

	public ParentFormFch(ApplicationManager appManager, NavigationManager navManager) {
		super(appManager, navManager);
	}
	
	
	public void onActionPerformed(ActionEvent evt) {
		if (evt.getSource() == getJbtQuit()){
			quit();
		}
	}
    
	public void initGUI() {
		try {
			setSize(400, 300);
			super.initGUI();		
			{
				getJpnClient().add(getJpnlFchTop(), BorderLayout.NORTH);

				getJpnlFchTop().add(getJpnlInfo(), BorderLayout.SOUTH);
				getJpnlFchTop().add(getJpnlButtons(), BorderLayout.NORTH);

				getJpnlButtons().add(getBoxSwitchButtons());
				


				//getBoxSwitchButtons().setPreferredSize(new java.awt.Dimension(400, 40));				

			}
			
			{
				CardLayout jpnDetailLayout = new CardLayout();
				getJpnClient().add(getJpnDetail(), BorderLayout.CENTER);
				getJpnDetail().setLayout(jpnDetailLayout);
			}
		
			internalBuildButtons();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private void internalBuildButtons() {
		buildButtons();
		for(int i = 0; i < getButtons().size(); i++){
			JButton button = (JButton)getButtons().elementAt(i);
			getBoxSwitchButtons().add(button);
			button.addActionListener(this);
		}
	}

	public Box getBoxSwitchButtons() {
		if (boxSwitchButtons == null){
			boxSwitchButtons = Box.createHorizontalBox();
		}
		return boxSwitchButtons;
	}
	
	public JPanel getJpnDetail() {
		if (jpnDetail == null)
			jpnDetail = new JPanel();
		return jpnDetail;
	}


	public Vector getButtons() {
		if (buttons == null)
			buttons = new Vector();
		return buttons;
	}
	
	protected void buildButtons(){
		//getJbtQuit().setMaximumSize(new java.awt.Dimension(80, 40));
		insertButton(getJbtQuit());
	}
	
	protected void insertButton(JButton button){
		int i = 0;
		button.setMaximumSize(new java.awt.Dimension(80, 25));
		if (getButtons().size() > 0)
			i = getButtons().size() - 1; 
		getButtons().insertElementAt(button, i);
	}
	
	public JButton getJbtQuit(){
		if (jbtQuit == null){
			jbtQuit = MRIcon.createButton("", "close");
		}
		return jbtQuit;		
	} 
	
	public JPanel getJpnlFchTop() {
		if (jpnlFchTop == null) {
			jpnlFchTop = new JPanel();
			BorderLayout jpnlTopLayout = new BorderLayout();
			jpnlFchTop.setLayout(jpnlTopLayout);
			jpnlFchTop.setBackground(this.getBackground());
		}
		return jpnlFchTop;
	}
	
	public JPanel getJpnlInfo() {
		if (jpnlInfo == null) {
			jpnlInfo = new JPanel();
			BorderLayout jpnlInfoLayout = new BorderLayout();
			jpnlInfo.setLayout(jpnlInfoLayout);
			jpnlInfo.setBackground(this.getBackground());
		}
		return jpnlInfo;
	}
	
	public JPanel getJpnlButtons() {
		if (jpnlButtons == null) {
			jpnlButtons = new JPanel();
			FlowLayout jpnlButtonsLayout = new FlowLayout();
			jpnlButtons.setLayout(jpnlButtonsLayout);
			jpnlButtons.setBackground(this.getBackground());
		}
		return jpnlButtons;
	}

}
