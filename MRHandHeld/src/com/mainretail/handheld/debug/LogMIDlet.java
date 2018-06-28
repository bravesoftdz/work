package com.mainretail.handheld.debug;
import java.util.Vector;

import javax.microedition.lcdui.Choice;
import javax.microedition.lcdui.Command;
import javax.microedition.lcdui.CommandListener;
import javax.microedition.lcdui.Display;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.List;
import javax.microedition.midlet.MIDlet;

import com.mainretail.util.ErrorAlert;


public class LogMIDlet extends MIDlet implements CommandListener
{
  private Display display;  //referencia a um objeto do tipo Display
  private List lstMain;   //TextBox para mostrar uma mensagem
  private Command cmExit;   //Botão para sair do MIDlet
  private Command cmClean ;

  public LogMIDlet()
  {

	display = Display.getDisplay(this);

        cmExit = new Command("exit", Command.EXIT, 1);
        cmClean = new Command("clean",Command.SCREEN,2 );
        
	lstMain = new List("log",Choice.IMPLICIT);
	
	lstMain.addCommand(cmExit);
	lstMain.addCommand(cmClean);
	lstMain.setCommandListener(this);
	
	try {
		Vector v= Log.getInstance().consult();
		for (int i=0;i<v.size();++i)
		{
			lstMain.append(v.elementAt(i).toString(),null);
		}
	
	}
	catch (Throwable t)
	{
		ErrorAlert.getInstance().showError(display,lstMain,t.getMessage());
		
	}
  }

  public void startApp()
  {
	display.setCurrent(lstMain);
  }	

  public void pauseApp()	 
  { 

  }
  
  public void destroyApp(boolean unconditional)
  {
	  //Log.getInstance().limpar();
	  try {
		LogDAO.getInstance().closeRecordStore();
	} catch (SystemException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
  }

  public void commandAction(Command c, Displayable s)
  {
     if (c==cmExit)
     { 
        destroyApp(false);
        notifyDestroyed(); 

     } 
     if (c==cmClean)
     {
     	Log.getInstance().clean();
     }
  }
}