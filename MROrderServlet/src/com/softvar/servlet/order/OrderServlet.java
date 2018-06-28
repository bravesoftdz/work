package com.softvar.servlet.order;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.softvar.model.order.Order;
import com.softvar.persistence.DAOUtil;
import com.softvar.persistence.IParentDAO;
import com.softvar.servlet.ParentServlet;

/**
 * @author Carlos Lima
 *
 */
public class OrderServlet extends ParentServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private static final String DESCRIPTION = "Order Servlet";

	protected boolean processTrustedRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		boolean retorno = true;
		
		try{		
			ObjectInputStream ois = new ObjectInputStream(new BufferedInputStream((InputStream)request.getInputStream()));
			try{
			
				Order[] orders = null;
				Object obj = ois.readObject();
				if (obj instanceof Order[]) {
					orders = (Order[]) obj;
					
					Vector responseVector = saveOrders(orders);
					
					ObjectOutputStream oos = new ObjectOutputStream(new BufferedOutputStream(response.getOutputStream()));
					
					try{
						oos.writeObject(responseVector);
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
	
	private Vector saveOrders(Order[] orders) {
		Vector retorno = new Vector();
		for (int i = 0; i < orders.length; i++){
			IParentDAO dao = DAOUtil.getDAO(Order.class, IParentDAO.DATABASE_MYSQL);
			Order order = orders[i]; 
			if (dao.save(order)){
				order.items.clear();
				order.items = null;
				order.customer = null;
				retorno.add(order);
			}
		}
		return retorno; 
	}

	protected String getServletDescription() {
		return DESCRIPTION;
	}
	
	

}
