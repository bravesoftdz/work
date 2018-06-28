package com.softvar.servlet.synch;

import com.softvar.model.order.IAccountCostDAO;
import com.softvar.persistence.DAOUtil;
import com.softvar.servlet.ParentServlet;
import com.softvar.synch.SynchHeader;
import java.io.*;
import java.util.ArrayList;
import java.util.ListIterator;
import java.util.zip.Deflater;
import java.util.zip.DeflaterOutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AccountCostSynchServlet extends ParentServlet
{

    private static final long serialVersionUID = 1L;
    private static final String DESCRIPTION = "Account Cost Synch Servlet";

    public AccountCostSynchServlet()
    {
    }

    protected String getServletDescription()
    {
        return DESCRIPTION;
    }

    protected boolean processTrustedRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        boolean retorno = true;
        try
        {
            ObjectInputStream ois = new ObjectInputStream(new BufferedInputStream(request.getInputStream()));
            Object obj = ois.readObject();
            if(obj instanceof com.softvar.model.order.Account[])
            {
                IAccountCostDAO dao = (IAccountCostDAO)DAOUtil.getDAO(com.softvar.model.order.AccountCost.class, 3);
                ArrayList lista = (ArrayList)dao.listByAccounts((com.softvar.model.order.Account[])obj);

                DeflaterOutputStream zip = new DeflaterOutputStream(response.getOutputStream(), new Deflater(Deflater.BEST_COMPRESSION));
                BufferedOutputStream bos = new BufferedOutputStream(zip, COMPRESSED_BUFFER_SIZE);
                ObjectOutputStream oos = new ObjectOutputStream(bos);
                
                SynchHeader sh = new SynchHeader();
                sh.objectClass = com.softvar.model.order.AccountCost.class.getName();
                sh.objectCount = lista.size();
                oos.writeObject(sh);
                
                for(ListIterator it = lista.listIterator(); it.hasNext(); oos.writeObject(it.next())){}
                
                oos.flush();
                bos.flush();
                zip.finish();
                response.setStatus(200);
            }
        }
        catch(Throwable t)
        {
            retorno = false;
            t.printStackTrace();
            response.sendError(202, t.getMessage());
        }
        return retorno;
    }
}
