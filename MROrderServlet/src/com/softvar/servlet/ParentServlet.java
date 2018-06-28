package com.softvar.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public abstract class ParentServlet extends HttpServlet
{

    public static final int REQUEST_ERROR = 202;
    public static final String version = "1.0 RC5";
    
    public static final int COMPRESSED_BUFFER_SIZE = 512 * 1024;

    public ParentServlet()
    {
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException
    {
        processRequest(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException
    {
        processRequest(req, resp);
    }

    protected abstract String getServletDescription();

    protected boolean processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        String userAgent = request.getHeader("user-agent");
        if(userAgent != null && userAgent.equals("softvar-agent"))
        {
            return processTrustedRequest(request, response);
        } else
        {
            return processOtherRequest(request, response);
        }
    }

    protected abstract boolean processTrustedRequest(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
        throws ServletException, IOException;

    protected boolean processOtherRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        PrintWriter writter = response.getWriter();
        writter.print("<HTML><HEADER><TITLE>MROrder Servlet</TITLE><HEADER/><BODY><TITLE1><CENTER><B>" + getServletDescription() + "</B><BR> Version " + "1.0 RC1" + "</CENTER></TITLE1></BODY><HTML/>");
        return true;
    }
}
