package com.mainretail.handheldserver.inventoryservlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mainretail.handheld.Model;
import com.mainretail.handheld.inventory.FrozeCount;
import com.mainretail.handheld.inventory.FrozeCountService;
import com.mainretail.handheld.inventory.InvCountItem;
import com.mainretail.handheld.inventory.InvCountItemService;
import com.mainretail.handheld.inventory.InvMov;
import com.mainretail.handheld.inventory.InvMovService;
import com.mainretail.handheldserver.ModelEEDAO;
import com.mainretail.handheldserver.ModelEEDAOFactory;
import com.mainretail.handheldserver.util.ParentServlet;

public class SVLLiveCountInsert extends ParentServlet {

	private static final long serialVersionUID = -5142446075197317295L;

	public boolean processRequest(HttpServletRequest request, HttpServletResponse response) throws 
		ServletException, IOException {
		boolean retValue = super.processRequest(request,response);
		
		if (!retValue)
		{
			return retValue;
		}

		if (!getHashParametros().containsKey("IM.barcode")){
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid barcode.");
			return false;
		}

		if (!getHashParametros().containsKey("IM.iduser")){
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid user.");
			return false;
		}
		
		if (!getHashParametros().containsKey("IM.idinvmovtype")){
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Inventory Type.");
			return false;
		}
		
		if (!getHashParametros().containsKey("IM.idmodel")){
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Model not exist.");
			return false;
		}		
		
		if (!getHashParametros().containsKey("IM.qty")){
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid quantity.");
			return false;
		}

		if (Double.parseDouble((String)getHashParametros().get("IM.qty")) <= 0){
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Quantity must be positive.");
			return false;
		}
		
		try {
			InvMov invmov = InvMovService.toInvMov(getHashParametros());
			InvCountItem invcountitem = InvCountItemService.toInvCountItem(getHashParametros()); 
					
			saveInvCountItem(invcountitem);
			
			FrozeCount frozecount = FrozeCountService.toFrozeCount(invcountitem);
			frozecount.model = searchBarcode(invcountitem.barcode);
			saveFrozeCount(frozecount);
			
			invmov.qty = invmov.qty - frozecount.qty;
			
			saveInvMov(invmov);
					
			response.setStatus(HttpServletResponse.SC_OK);
			retValue = true;
		} catch (Exception e) {
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
		}
		
		return retValue;  	
	}

	private void saveInvCountItem( InvCountItem invcountitem) throws SQLException {
		InvCountItemEEDAO dao = InvCountItemEEDAOFactory.getInvCountDAO(InvCountItemEEDAOFactory.DATABASE_SLQSERVER);
		dao.save(invcountitem);
	}

		
	private void saveInvMov( InvMov invmov) throws SQLException {
		InvMovEEDAO dao = InvMovEEDAOFactory.getInvMovDAO(InvMovEEDAOFactory.DATABASE_SLQSERVER);
		dao.save(invmov);
	}
	
	private void saveFrozeCount( FrozeCount frozecount) throws SQLException {
		FrozeCountEEDAO dao = FrozeCountEEDAOFactory.getFrozeCountDAO(FrozeCountEEDAOFactory.DATABASE_SLQSERVER);
		dao.save(frozecount);
	}
	
	private Model  searchBarcode( String barcode) throws SQLException {

		ModelEEDAO dao = ModelEEDAOFactory.getProductDAO(ModelEEDAOFactory.DATABASE_SLQSERVER);

		return dao.findByBarCode(barcode);
	}
	
}
