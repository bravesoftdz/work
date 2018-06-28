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
import com.mainretail.commun.model.purchase.Receiving;
import com.mainretail.commun.model.purchase.ReceivingItem;
import com.mainretail.handheldservlet.ParentServlet;

public class ReceivingServlet extends ParentServlet {

	private static final long serialVersionUID = 1L;

	protected boolean processRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		boolean retorno = true;
		
		try{		
			ObjectInputStream ois = new ObjectInputStream(new BufferedInputStream((InputStream)request.getInputStream()));
			try{
			
				Receiving receiving = null;
				Object obj = ois.readObject();
				if (obj instanceof Receiving) {
					receiving = (Receiving) obj;
					
					// Acerta a quantidade
					fixReceivingQty(receiving);
					
					IParentDAO dao = DAOUtil.getDAO(Receiving.class, IParentDAO.DATABASE_MSSQL);
					if (!dao.save(receiving))
						throw new Exception("Receiving could not be saved");
					
					ObjectOutputStream oos = new ObjectOutputStream(new BufferedOutputStream(response.getOutputStream()));
					
					try{
						oos.writeObject(receiving);
						oos.flush();
					}finally{
						oos.close();
					}
					response.setStatus(HttpServletResponse.SC_OK);
				}
			}finally{
				ois.close();
			}
					
		}catch(Throwable t){
			retorno = false;
			t.printStackTrace();
			response.sendError(ParentServlet.REQUEST_ERROR, t.getMessage());
		}
		
		return retorno;
	}
	
	
	private void fixReceivingQty(Receiving receiving){
		for (int i = 0; i < receiving.items.size(); i++){
			ReceivingItem ri = ((ReceivingItem)receiving.items.get(i));
			ri.qty = ri.qtyReceived; 
		}
	}

}
