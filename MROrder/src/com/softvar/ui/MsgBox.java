package com.softvar.ui;

import java.awt.Component;
import java.net.URL;

import javax.swing.ImageIcon;
import javax.swing.JOptionPane;

import com.softvar.controller.MRIcon;
import com.softvar.internationalization.LanguageResource;


public class MsgBox {

	public static void errorMsg(Component c, String msg){
		basicMsg(c, msg, "res/msg_critial.png", "TITLE_ERROR", JOptionPane.ERROR_MESSAGE);
	}
	
	public static void infoMsg(Component c, String msg){
		basicMsg(c, msg, "res/msg_inform.png", "TITLE_INFORMATION", JOptionPane.INFORMATION_MESSAGE);
	}
	
	public static void warningMsg(Component c, String msg){
		basicMsg(c, msg, "res/msg_warning.png", "TITLE_WARNING", JOptionPane.WARNING_MESSAGE);
	}
	
	public static void basicMsg(Component c, String msg, String imageResource, String titleResource, int option){
		ImageIcon img = null;
		String title = null;
		try{
			title = LanguageResource.getInstance().getText(titleResource);
			
			URL url = MRIcon.class.getResource(imageResource);
			
			if (url != null){
				img = new ImageIcon(url);
			}
			
		}catch(Throwable t){
			t.printStackTrace();
		}
		JOptionPane.showMessageDialog(c, msg, title, option, img);
	}
	
	public static boolean yesNoMsg(Component c, String msg){
		return basicConfirmMsg(c, msg, "TITLE_CONFIRMATION", JOptionPane.YES_NO_OPTION);
	}
	
	public static boolean okCancelMsg(Component c, String msg){
		return basicConfirmMsg(c, msg, "TITLE_CONFIRMATION", JOptionPane.OK_CANCEL_OPTION);
	}
	
	public static boolean basicConfirmMsg(Component c, String msg, String titleResource, int option){
		boolean result = false;
		String title = null;
		try{
			title = LanguageResource.getInstance().getText(titleResource);
			
		}catch(Throwable t){
			t.printStackTrace();
		}		
		int iResult = JOptionPane.showConfirmDialog(c, msg, title, option, JOptionPane.QUESTION_MESSAGE);
		
		switch (option){
		case JOptionPane.YES_NO_OPTION: {
			result = (iResult == JOptionPane.YES_OPTION);
			break;
		}
		case JOptionPane.OK_CANCEL_OPTION: {
			result = (iResult == JOptionPane.OK_OPTION);
			break;
		}
		}
		return result;
	}
	
}
