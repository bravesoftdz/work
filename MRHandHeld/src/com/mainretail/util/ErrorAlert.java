package com.mainretail.util;

import java.io.IOException;

import javax.microedition.lcdui.Alert;
import javax.microedition.lcdui.AlertType;
import javax.microedition.lcdui.Display;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.Image;

public class ErrorAlert extends Alert
{

    private static Image img;
    private static ErrorAlert instance;

    private ErrorAlert()
    {
        super("Error", "", img, AlertType.ERROR);
        setTimeout(Alert.FOREVER);
    }

    public static ErrorAlert getInstance()
    {
        if(instance == null)
        {
            instance = new ErrorAlert();
        }
        return instance;
    }

    public void showError(Display d, String msg)
    {
        setString(msg);
        d.setCurrent(this, d.getCurrent());
    }
    public void showError(Display d, Throwable t)
    {
       //String msg = t.getMessage();
       String msg = t.getClass().getName() + " " + t.getMessage();

       if  (msg == null)
       {
    	   msg = t.getClass().getName();
    	   
       }
       showError(d,msg);
    }
    public void showError(Display display,Displayable displayable ,String msg)
    {
        setString(msg);
        display.setCurrent(this, displayable);
    }

    public void showError(Display display,Displayable displayable ,Throwable t)
    {
    	String msg = t.getMessage();
        if  (msg == null)
        {
     	   msg = t.getClass().getName();
     	   
        }
    	showError(display,displayable,msg);
    	
    }
    

    static 
    {
        try
        {
            img = Image.createImage("/erro.png");
        }
        catch(IOException e)
        {
            System.out.println("Loading image error");
        }
    }
}
