package com.softvar.ui;

import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JPanel;

public class BasePanel extends JPanel implements ActionListener {
	private static final long serialVersionUID = -7616521673183516162L;
	
	public BasePanel(){
		super();
		initGUI();
	}
	
	public void initGUI(){
		this.setBackground(Color.white);
	}

	public void actionPerformed(ActionEvent evt) {
		onActionPerformed(evt);
	}
	
	public void onActionPerformed(ActionEvent evt) {
		
	}

}
