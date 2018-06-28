package com.mainretail.handheldservlet.purchase;

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
import com.mainretail.commun.model.purchase.IVerifyReceivingDAO;
import com.mainretail.commun.model.purchase.VerifyReceiving;
import com.mainretail.handheldservlet.ParentServlet;

public class VerifyReceivingServlet extends ParentServlet {
	private static final long serialVersionUID = 1L;

	protected boolean processRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		boolean retorno = true;
		
		try{
			ObjectInputStream ois = new ObjectInputStream(new BufferedInputStream((InputStream)request.getInputStream()));
			
			VerifyReceiving purchaseVerifyReceiving = null;
			Object obj = ois.readObject();
			if (obj instanceof VerifyReceiving) {
				purchaseVerifyReceiving = (VerifyReceiving) obj;
				
				IVerifyReceivingDAO dao =  (IVerifyReceivingDAO) DAOUtil.getDAO(VerifyReceiving.class, IParentDAO.DATABASE_MSSQL);
				
				purchaseVerifyReceiving = dao.getPurchase(purchaseVerifyReceiving.documentnumber);
				
				if (purchaseVerifyReceiving.idpurchase == 0){
					response.sendError(ParentServlet.REQUEST_ERROR, "The selectted document number does not exists");
					retorno = false;
				} else if (purchaseVerifyReceiving.datefinalreceiving != null) {
					response.sendError(ParentServlet.REQUEST_ERROR, "Purchase had Final Receiving");
					retorno = false; 	
				}
				else{		
					ObjectOutputStream oos = new ObjectOutputStream(new BufferedOutputStream(response.getOutputStream()));					
					oos.writeObject(purchaseVerifyReceiving);
					oos.flush();
					response.setStatus(HttpServletResponse.SC_OK);
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
