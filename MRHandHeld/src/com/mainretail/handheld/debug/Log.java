package com.mainretail.handheld.debug;

import java.util.Vector;

import com.mainretail.handheld.Config;

public class Log {
	private static Log instance;		
	private LogDAO dao;

	private Log()
	{
		dao= LogDAO.getInstance() ;
	}
	public static  Log getInstance()
	{
		if (instance == null)
		{
			instance = new Log();
		
		}
		return instance;
	
	}
	public void log(String message) 
	{
		if (Config.getInstance().saveLog) {
			try {
				dao.log(message);
			}
			catch (SystemException e)
			{}	
		}
	}
	public Vector consult()  
	{
		try {
		return dao.consult() ;
		}
		catch (SystemException e)
		{}
		return null;
	}
	
	public void clean()  
	{
		try {
		dao.clean() ;
		}
		catch (SystemException e)
		{}
	}
	
	
	
}
