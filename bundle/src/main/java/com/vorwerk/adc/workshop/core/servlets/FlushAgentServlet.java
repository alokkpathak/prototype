package com.vorwerk.adc.workshop.core.servlets;

import java.io.IOException;
import java.rmi.ServerException;

import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.sling.SlingServlet;
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.commons.lang3.StringEscapeUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.vorwerk.adc.workshop.core.osgi.service.FlushAgentService;
import com.vorwerk.adc.workshop.core.osgi.service.GeoLocationService;


@SlingServlet(paths="/bin/adc/services/createFlushAgent", methods = "GET", metatype=true)
@Property(name = "sling.auth.requirements", value = "-/bin/adc/services/createFlushAgent")
public class FlushAgentServlet extends org.apache.sling.api.servlets.SlingAllMethodsServlet {
	     private static final long serialVersionUID = 2598426539166789515L;
	     private static final Logger LOG = LoggerFactory.getLogger(GeoLocationService.class);
	     
	     @Reference
	     private FlushAgentService flush;
	  
	     @Override
	     protected void doGet(SlingHttpServletRequest request, SlingHttpServletResponse response) throws ServerException, IOException {
	        
	      try
	      {
			String strScaled = StringEscapeUtils.escapeHtml4(request.getParameter("scaled"));
			String strIpAddress = StringEscapeUtils.escapeHtml4(request.getParameter("ip"));
			if(null!=strScaled && strScaled.equalsIgnoreCase("up")){
				flush.createFlushAgent(strIpAddress, request);
			}
			//Define a String value to return
			else
			{
				flush.deleteFlushAgent(strIpAddress, request);
			}
	      }
	      catch(Exception e)
	      {
	    	  LOG.error("Error Occurred - ", e.getMessage()); 
	      }
	    }
}
