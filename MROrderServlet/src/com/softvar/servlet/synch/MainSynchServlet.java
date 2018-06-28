package com.softvar.servlet.synch;

import com.softvar.persistence.DAOUtil;
import com.softvar.persistence.IParentDAO;
import com.softvar.servlet.ParentServlet;
import com.softvar.synch.SynchHeader;
import java.io.*;
import java.util.*;
import java.util.zip.Deflater;
import java.util.zip.DeflaterOutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MainSynchServlet extends ParentServlet
{

    private static final long serialVersionUID = 1L;
    private static final String DESCRIPTION = "Main Synch Servlet";

    public MainSynchServlet()
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
            SynchHeader[] headers = null;
            
            
            Object obj = ois.readObject();
            if(obj instanceof SynchHeader[])
            {
                headers = (SynchHeader[])obj;
                Vector responseVector = loadClasses(headers);
                
                DeflaterOutputStream zip = new DeflaterOutputStream(response.getOutputStream(), new Deflater(Deflater.BEST_COMPRESSION));
                BufferedOutputStream bos = new BufferedOutputStream(zip, COMPRESSED_BUFFER_SIZE);
                ObjectOutputStream oos = new ObjectOutputStream(bos);
                
                for(Enumeration en = responseVector.elements(); en.hasMoreElements(); oos.writeObject(en.nextElement())){}
                
                oos.flush();
                bos.flush();
                zip.finish();
                
                
                response.setStatus(200);
                
                response.getOutputStream().close();
                
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

    protected Vector loadClasses(SynchHeader[] headers) {
        Vector retorno = new Vector();
        for(int i = 0; i < headers.length; i++)
        {
        	Class clazz = null;
			try {
				clazz = Class.forName(headers[i].objectClass);
	            IParentDAO dao = DAOUtil.getDAO(clazz, 3);
	            addClassList(dao, retorno, clazz, headers[i].synchDate);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
        }

        return retorno;
    }

    protected void addClassList(IParentDAO dao, Vector vector, Class classe, Date update) {
        List lista = dao.listAllByDate(update);
        if(lista.size() != 0)
        {
            SynchHeader header = new SynchHeader();
            header.objectClass = classe.getName();
            header.objectCount = lista.size();
            header.synchDate = new Date();
            vector.add(header);
            vector.addAll(lista);
        }
    }
}
