package com.mainretail.commun.ui;

import java.awt.Component;
import java.net.URL;

import javax.swing.ImageIcon;
import javax.swing.JOptionPane;

import com.mainretail.MRIcon;
import com.mainretail.commun.controller.LanguageResource;

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
	
}
