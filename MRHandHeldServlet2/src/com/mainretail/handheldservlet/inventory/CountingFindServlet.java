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
import com.mainretail.commun.model.inventory.IInvCountDAO;
import com.mainretail.commun.model.inventory.InvCount;
import com.mainretail.handheldservlet.ParentServlet;

public class CountingFindServlet extends ParentServlet {
	private static final long serialVersionUID = 1L;

	protected boolean processRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		boolean retorno = true;
		
		try{
			ObjectInputStream ois = new ObjectInputStream(new BufferedInputStream((InputStream)request.getInputStream()));
			
			InvCount invCount = null;
			Object obj = ois.readObject();
			if (obj instanceof InvCount) {
				invCount = (InvCount) obj;
				
				IInvCountDAO dao =  (IInvCountDAO) DAOUtil.getDAO(InvCount.class, IParentDAO.DATABASE_MSSQL);
				
				if (dao.countingExists(invCount)){
					ObjectOutputStream oos = new ObjectOutputStream(new BufferedOutputStream(response.getOutputStream()));					
					oos.writeObject(invCount);
					oos.flush();
					response.setStatus(HttpServletResponse.SC_OK);
				}
				else {
					response.sendError(ParentServlet.REQUEST_ERROR, "There is no open count for this type");
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