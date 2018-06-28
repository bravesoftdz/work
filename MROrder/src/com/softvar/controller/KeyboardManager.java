package com.softvar.controller;

import javax.swing.JTextField;

public interface KeyboardManager {
	
	public JTextField getManagedComponent();
	public void onReturnKey();

}
