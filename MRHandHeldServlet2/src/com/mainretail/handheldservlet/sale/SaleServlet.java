package com.mainretail.handheldservlet.sale;

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

import com.mainretail.commun.model.DAOUtil;
import com.mainretail.commun.model.IParentDAO;
import com.mainretail.commun.model.sale.Sale;
import com.mainretail.handheldservlet.ParentServlet;

public class SaleServlet extends ParentServlet {
	private static final long serialVersionUID = -771671207929738400L;

	protected boolean processRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		boolean retorno = true;
		
		try{		
			ObjectInputStream ois = new ObjectInputStream(new BufferedInputStream((InputStream)request.getInputStream()));
			try{
			
				Sale[] sales = null;
				Object obj = ois.readObject();
				if (obj instanceof Sale[]) {
					sales = (Sale[]) obj;
					
					Vector responseVector = saveSales(sales);
					
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

	private Vector saveSales(Sale[] sales) {
		Vector retorno = new Vector();
		
		for (int i = 0; i < sales.length; i++){
			IParentDAO dao = DAOUtil.getDAO(Sale.class, IParentDAO.DATABASE_MSSQL);
			Sale sale = sales[i]; 
			if (dao.save(sale)){
				sale.clear();
				retorno.add(sale);
			}
		}
		return retorno; 
	}
}
