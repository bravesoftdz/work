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
import com.mainretail.commun.model.purchase.PO;
import com.mainretail.handheldservlet.ParentServlet;

public class POServlet extends ParentServlet {
	private static final long serialVersionUID = 1L;
	
	protected boolean processRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		boolean retorno = true;
		ObjectInputStream ois = new ObjectInputStream(new BufferedInputStream((InputStream)request.getInputStream()));
		try{
			ObjectOutputStream oos = new ObjectOutputStream(new BufferedOutputStream(response.getOutputStream()));
			try{
				try{		
					PO po = null;
					Object obj = ois.readObject();
					if (obj instanceof PO) {
						po = (PO) obj;
						
					
						IParentDAO dao = DAOUtil.getDAO(PO.class, IParentDAO.DATABASE_MSSQL);
						if (!dao.save(po))
							throw new Exception("PO could not be saved");
						
						
						oos.writeObject(po);
						oos.flush();
						response.setStatus(HttpServletResponse.SC_OK);
					}
					
					
				}catch(Throwable t){
					retorno = false;
					
					response.sendError(ParentServlet.REQUEST_ERROR, t.getMessage());
					t.printStackTrace();
				}
			}finally{
				oos.close();
			}
			
		}finally{
			ois.close();
		}
		return retorno;
	}
	
}
