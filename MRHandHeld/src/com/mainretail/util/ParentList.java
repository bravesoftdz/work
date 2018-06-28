package com.mainretail.util;
import java.io.IOException;
import java.util.Hashtable;

import javax.microedition.lcdui.Command;
import javax.microedition.lcdui.CommandListener;
import javax.microedition.lcdui.Display;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.Image;
import javax.microedition.lcdui.List;

import com.mainretail.handheld.User;

public class ParentList extends List implements CommandListener, InitialInfo{
	private Display display;
	private Displayable caller;	
	
	private String[] titles;
	private Class[] forms;
	private String[] images;
	private Hashtable objects;
	
	private User user;
	
	public ParentList() {
		super("", List.IMPLICIT);
		
	}
	
	public void onSelect(Displayable d){
		int i = (((List)d).getSelectedIndex());				
		
		try {	
		
			Class classeForm = Class.forName(forms[i].getName());

			Object object =  classeForm.newInstance();
			
			if (object instanceof InitialInfo) {
				InitialInfo form = (InitialInfo) object;
				form.setInfo(titles[i], getDisplay(), this, images[i]);
				
				if (form instanceof Displayable)
				  getDisplay().setCurrent((Displayable) form);
			}			
			
		} catch (Exception e) {			
			e.printStackTrace();
		}
	}	
	
	public String getConfirmButtomName(){
		return new String("Start");
	}

	public void initForm(){		
		addCommand(new Command(getConfirmButtomName(), Command.OK, 1));
		addCommand(new Command("Back", Command.BACK, 1));
		setCommandListener(this);
	}
	
	public void commandAction(Command c, Displayable d) {
		switch (c.getCommandType()) {
			case Command.BACK:{
				display.setCurrent(caller);
				break;
			}
			
			case Command.OK:
			case Command.SCREEN:{
				onSelect(d); 
				break;
			}
		}
	}
	
	public Display getDisplay(){
		return display;
	}
	
	public Displayable getCaller(){	
		return caller;
	}

	public void setInfo(String title, Display display, Displayable caller, String image) {
		this.caller = caller;
		this.display = display;		
		setTitle(title);
		
		setUser((User)objects.get("USER"));
		
		initForm();
	}	
	
	public void setList(String[] titles, Class[] forms, String[] images) {		
		this.forms = forms;
		this.images = images;
		this.titles = titles;
		
		for (int i = 0; i < titles.length; i++){
			Image img = null;		
			if (images[i] != null){
				try {
					img = Image.createImage(images[i]);
				} catch (IOException e) {
					
				}				
			}
			append(titles[i], img);
		}
				
	}

	public void defaultValues() {
		
		
	}

	public void refresh() {
				
	}

	public Hashtable getObjects() {
		return objects;

	}	
	
	public void setObjects(Hashtable objects) {		
		this.objects = objects;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public User getUser() {
		return user;
	}
}
