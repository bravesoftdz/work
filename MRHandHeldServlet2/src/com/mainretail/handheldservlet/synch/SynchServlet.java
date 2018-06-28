package com.mainretail.handheldservlet.synch;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.Enumeration;
import java.util.List;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mainretail.commun.model.DAOUtil;
import com.mainretail.commun.model.IParentDAO;
import com.mainretail.commun.synch.SynchHeader;
import com.mainretail.handheldservlet.ParentServlet;

public class SynchServlet extends ParentServlet {
	private static final long serialVersionUID = 6269500129014993009L;

	protected boolean processRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		boolean retorno = true;
		
		try{		
			ObjectInputStream ois = new ObjectInputStream(new BufferedInputStream((InputStream)request.getInputStream()));
			
			Class[] classes = null;
			Object obj = ois.readObject();
			if (obj instanceof Class[]) {
				classes = (Class[]) obj;
				Vector responseVector = loadClasses(classes);
				
				ObjectOutputStream oos = new ObjectOutputStream(new BufferedOutputStream(response.getOutputStream()));
				for(Enumeration en = responseVector.elements(); en.hasMoreElements();){
					oos.writeObject(en.nextElement());
				}
				
				oos.flush();
				
				response.setStatus(HttpServletResponse.SC_OK);
			}
					
		}catch(Throwable t){
			retorno = false;
			t.printStackTrace();
			response.sendError(ParentServlet.REQUEST_ERROR, t.getMessage());
		}
		
		return retorno;
	}
	
	protected Vector loadClasses(Class[] classes){
		Vector retorno = new Vector();
		
		for (int i = 0; i < classes.length; i++){
			IParentDAO dao = DAOUtil.getDAO(classes[i], IParentDAO.DATABASE_MSSQL);
			addClassList(dao, retorno, classes[i]);
		}
		return retorno;
	}
	
	protected void addClassList(IParentDAO dao, Vector vector, Class classe){
		List lista = dao.listAll();
		
		if (lista.size() != 0){
			// Cria o header e adiciona no vetor
			SynchHeader header = new SynchHeader();
			header.objectClass = classe.getName();
			header.objectCount = lista.size();
			vector.add(header);			
			vector.addAll(lista);		
		}

	}

}
