package com.mainretail.handheldservlet.inventory;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mainretail.commun.model.DAOUtil;
import com.mainretail.commun.model.IParentDAO;
import com.mainretail.commun.model.inventory.BarcodePrintList;
import com.mainretail.handheldservlet.ParentServlet;

public class BarcodePrintListServlet extends ParentServlet {

	private static final long serialVersionUID = 1L;

	protected boolean processRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		boolean retorno = true;
		
		try{
			ObjectInputStream ois = new ObjectInputStream(new BufferedInputStream((InputStream)request.getInputStream()));
			
			BarcodePrintList barcodePrintList = null;
			Object obj = ois.readObject();
			if (obj instanceof BarcodePrintList) {
				barcodePrintList = (BarcodePrintList) obj;
				
				IParentDAO dao =  (IParentDAO) DAOUtil.getDAO(BarcodePrintList.class, IParentDAO.DATABASE_MSSQL);
				
				if (dao.save(barcodePrintList)){
					ObjectOutputStream oos = new ObjectOutputStream(new BufferedOutputStream(response.getOutputStream()));
					oos.writeObject(barcodePrintList);
					oos.flush();
					response.setStatus(HttpServletResponse.SC_OK);
				}
				else {
					response.sendError(ParentServlet.REQUEST_ERROR, "Barcode item could not save.");
					retorno = false;
				}
				
			}
					
		}catch(Throwable t){
			retorno = false;
			t.printStackTrace();
			response.sendError(ParentServlet.REQUEST_ERROR, t.getMessage());
		}
		
		return retorno;
	}

}
