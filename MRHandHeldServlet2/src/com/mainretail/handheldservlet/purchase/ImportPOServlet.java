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
import com.mainretail.commun.model.purchase.IReceivingDAO;
import com.mainretail.commun.model.purchase.Receiving;
import com.mainretail.handheldservlet.ParentServlet;

public class ImportPOServlet extends ParentServlet {

	private static final long serialVersionUID = -5158840356543539305L;

	protected boolean processRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		boolean retorno = true;
		
		try{
			ObjectInputStream ois = new ObjectInputStream(new BufferedInputStream((InputStream)request.getInputStream()));
			
			Receiving purchaseReceiving = null;
			Object obj = ois.readObject();
			if (obj instanceof Receiving) {
				purchaseReceiving = (Receiving) obj;
				
				IReceivingDAO dao =  (IReceivingDAO) DAOUtil.getDAO(Receiving.class, IParentDAO.DATABASE_MSSQL);
				
				purchaseReceiving = dao.importPO(purchaseReceiving.documentnumber);
				
				if (purchaseReceiving == null){					
					response.sendError(ParentServlet.REQUEST_ERROR, "PO number does not exists");
					retorno = false;
				} else{		
					ObjectOutputStream oos = new ObjectOutputStream(new BufferedOutputStream(response.getOutputStream()));					
					oos.writeObject(purchaseReceiving);
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
