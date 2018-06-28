package com.mainretail;

import java.awt.Color;
import java.awt.Font;
import java.net.URL;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.SwingConstants;

public final class MRIcon {
  
  public static JButton createButton(String text) {
    JButton button = new JButton(text);
    button.setFocusPainted(true);
    button.setBorderPainted(true);
    button.setContentAreaFilled(true);
    return button;
  }
  
  public static JButton createButton(String text, String icon) {
    ImageIcon iconNormal = readImageIcon(icon + ".png");
    ImageIcon iconHighlight = readImageIcon(icon + ".png");
    ImageIcon iconPressed = readImageIcon(icon + "_pressed.png");
    
    
    JButton button = new JButton(iconNormal);    
    button.setText(text);
    button.setVerticalTextPosition(SwingConstants.BOTTOM);
    button.setHorizontalTextPosition(SwingConstants.CENTER);
    button.setFont(new Font("Arial", 0, 7));
    button.setFocusPainted(false);
    button.setBorderPainted(false);
    button.setContentAreaFilled(false);
    button.setBackground(Color.white);
    if (iconHighlight != null) {
      button.setRolloverEnabled(true);
      button.setRolloverIcon(iconHighlight);
    }
    if (iconPressed != null)
      button.setPressedIcon(iconPressed);
    return button;
  }
  
  protected static ImageIcon readImageIcon(String filename) {
	  URL url = MRIcon.class.getResource("res/"+filename);
	  if (url == null)
		  return null;
	  else
		  return new ImageIcon(url);
  }
}
