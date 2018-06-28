package com.mainretail.commun.ui;
import java.awt.BorderLayout;
import java.awt.CardLayout;
import java.awt.Color;
import java.awt.Component;
import java.awt.Toolkit;
import java.util.Vector;

import javax.swing.JPanel;

import com.mainretail.commun.controller.NavigationManager;
import com.mainretail.commun.model.Connection;


public class MainForm extends javax.swing.JFrame implements NavigationManager, ApplicationManager {
	private static final long serialVersionUID = -1800032600374634119L;
	
	private JPanel jpnNorth;
	private JPanel jpnCenter;
	private JPanel jpnWest;
	private JPanel jpnEast;
	private JPanel jpnSouth;
	private CardLayout cardLayout;
	
	private Vector componentes;
	
	//private ApplicationManagerImpl appManager;

	public MainForm() {
		super();
		componentes = new Vector();
		initGUI();
	}
	
	public void initGUI() {
		try {
			setSize(400, 300);
			//appManager = new ApplicationManagerImpl();
			
			BorderLayout thisLayout = new BorderLayout();
			getContentPane().setLayout(thisLayout);
			getContentPane().setBackground(Color.white);
			{				
				getContentPane().add(getJpnNorth(), BorderLayout.NORTH);
				getJpnNorth().setBackground(Color.white);
			}
			{
				
				getContentPane().add(getJpnSouth(), BorderLayout.SOUTH);
				getJpnSouth().setBackground(Color.white);
			}
			{
				getContentPane().add(getJpnEast(), BorderLayout.EAST);
				getJpnEast().setBackground(Color.white);
			}
			{
				getContentPane().add(getJpnWest(), BorderLayout.WEST);
				getJpnWest().setBackground(Color.white);
			}
			{
				getContentPane().add(getJpnCenter(), BorderLayout.CENTER);
				cardLayout = new CardLayout();
				getJpnCenter().setLayout(cardLayout);
				getJpnCenter().setBackground(Color.white);
			}
			
			
			Toolkit tk = Toolkit.getDefaultToolkit();
			
			this.setSize(tk.getScreenSize().width, tk.getScreenSize().height);
			//this.setSize(tk.getDefaultToolkit().getScreenSize());
			
			addMRPanelComponent(new MenuScreen(this, this));
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	

	protected JPanel getJpnNorth() {
		if (jpnNorth == null)
			jpnNorth = new JPanel();
		return jpnNorth;
	}
	
	protected JPanel getJpnSouth() {
		if (jpnSouth == null )
			jpnSouth = new JPanel();
		return jpnSouth;
	}
	
	protected JPanel getJpnEast() {
		if (jpnEast == null)
			jpnEast = new JPanel();
		return jpnEast;
	}
	
	protected JPanel getJpnWest() {
		if (jpnWest == null)
			jpnWest = new JPanel();
		return jpnWest;
	}
	
	protected JPanel getJpnCenter() {
		if (jpnCenter == null)
			jpnCenter = new JPanel();
		return jpnCenter;
	}
	
	

	public void panelClosed(MRPanel panel) {
		if (getPrevious() == null)
		{
			Connection.getInstance().close();
			dispose();
			System.exit(0);
		} else
		{
			if (getPrevious() instanceof LoginScreen) {
				removeMRPanelComponent(getPrevious());
			}
			removeMRPanelComponent(panel);
			showMRComponent(getCurrent());
		}
		
		
		/*
		System.exit(0);
		*/
	}
    	

	
	public MRPanel getCurrent(){
		if (componentes.size() == 0)
			return null;
		else
			return (MRPanel) componentes.get(componentes.size() - 1);
	}
	
	public MRPanel getPrevious(){
		if (componentes.size() <= 1)
			return null;
		else
			return (MRPanel) componentes.get(componentes.size() - 2);
	}
	
	public void removeMRPanelComponent(MRPanel comp){
		cardLayout.removeLayoutComponent((Component)comp);
		getJpnCenter().remove((Component)comp);
		componentes.remove(comp);
		
		comp = null;
	}
	
	public void addMRPanelComponent(MRPanel comp){
		componentes.add(comp);
		getJpnCenter().add(comp.getClass().getName(), (Component) comp);		
		showMRComponent(comp);
	}
	
	public void showMRComponent(MRPanel comp){
		cardLayout.show(getJpnCenter(), comp.getClass().getName());
	}

}
