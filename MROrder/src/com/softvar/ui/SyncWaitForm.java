package com.softvar.ui;

import javax.swing.JButton;
import javax.swing.JLabel;


import com.softvar.controller.MRIcon;

public class SyncWaitForm extends BasePanel{

	private static final long serialVersionUID = 5587595438377846036L;
	private static final int lineWidth = 80;
	private static final int lineHeight = 80;

	private static final int sync_wait = 0;
	private static final int sync_defrag = 0;
	
	private int syncMod;
	
	private JButton jbtSync;
	private JLabel lbPleaseWait;

	public SyncWaitForm(){
		super();
	}

	public SyncWaitForm(int syncMod){
		super();
		this.syncMod = syncMod; 
	}
	
	public void initGUI(){
		try {

			super.initGUI();
			this.setPreferredSize(new java.awt.Dimension(lineWidth, lineHeight));
			
			if ((this.syncMod) == sync_wait){
				this.add(getJbtSyncWait());
			} else if ((this.syncMod) == sync_defrag){
				this.add(getJbtSyncWait());
			} 
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	public JLabel getLbPleaseWait() {
		if (lbPleaseWait == null){
			lbPleaseWait = new JLabel();
			lbPleaseWait.setText("Wait ...");
		}
		return lbPleaseWait;
	}

	public JButton getJbtSyncWait() {
		if (jbtSync == null){
			jbtSync = MRIcon.createButton("Please Wait...", "sync");
		}
		return jbtSync;
	}

	
}
