/**
* Copyright (c)  Vorwerk POC
* Program Name :  ADCRedirectController.java
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Servlet to redirect user to order details page for viewing shipment, downloading PDF invoice, credit memo documents.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
* -----------                         ----------------                                    -------------------------
* 20-NOV-2016                  Cognizant Technology solutions            					Initial Creation
* -----------                         -----------------                                   -------------------------
**/

package com.vorwerk.adc.workshop.core.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.MessageFormat;
import java.util.MissingResourceException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.Service;
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.sling.api.resource.ResourceResolver;
import org.apache.sling.api.servlets.SlingSafeMethodsServlet;
import org.apache.commons.lang3.StringEscapeUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.vorwerk.adc.workshop.core.osgi.service.RedirectUrlAppService;
import com.vorwerk.adc.workshop.core.osgi.service.RegionUrlMapping;
import com.vorwerk.adc.workshop.core.osgi.service.RestServiceUrl;
import com.vorwerk.adc.workshop.core.osgi.service.RunModesService;

@Service(value=javax.servlet.Servlet.class)
@Component(immediate=true, metatype=false)
@Properties({
        @Property(name="service.description", value="This servlet will handle redirection based on the request parameter key."),
        @Property(name="sling.servlet.methods", value="GET"),
        @Property(name="sling.servlet.paths", value="/bin/adc/fsl/webshop/requestcontroller"),
        @Property(name="sling.servlet.extensions", value="html")
})
public class ADCRedirectController extends SlingSafeMethodsServlet {

    private static final Logger log = LoggerFactory.getLogger(ADCRedirectController.class);
   
    @Reference
    RunModesService runmodeService;
    
    @Reference
    RedirectUrlAppService redirectAppService;
    
    @Reference 
    RegionUrlMapping regionUrlMapping;
    
    @Reference 
    RestServiceUrl serviceUrl;

    @Override
    protected void doGet(SlingHttpServletRequest slingRequest, SlingHttpServletResponse slingResponse) throws ServletException, IOException 
    {
    	try
    	{
	        final ResourceResolver resourceResolver = slingRequest.getResourceResolver();
    		String operation        = StringEscapeUtils.escapeHtml4(slingRequest.getParameter("opr"));
    		String countryCd        = StringEscapeUtils.escapeHtml4(slingRequest.getParameter("cntry"));
    		String id				= StringEscapeUtils.escapeHtml4(slingRequest.getParameter("id"));
    		
	        String reqUrl = slingRequest.getRequestURI();
	        log.info("REQUEST URL ::::::::>>>>>> "+reqUrl);
	        String redirectPath = null;
	        if(operation != null && countryCd != null )
	        {
				 if(operation.equalsIgnoreCase("orderhistory"))
				 {
					 	redirectPath = getRedirectUrlForOrderDetails(operation, countryCd, resourceResolver);
					 	if( redirectPath != null )
					 	{
					 		// remove cookies before login; always redirect to sign-in page for the case of Order History/Tracking
					 		disableUserCookies(slingRequest, slingResponse, "username");
					 		disableUserCookies(slingRequest, slingResponse, "guestUserCookie");
					 		disableUserCookies(slingRequest, slingResponse, "userid");
					 		disableUserCookies(slingRequest, slingResponse, "productCount");
					 	}
				 }				 
				 else  if(operation.equalsIgnoreCase("pdfdocid"))
				 {
					 redirectPath = getRedirectUrlForOrderPdf(operation, countryCd
							 									, id , isLoggedInUser(slingRequest,countryCd)
							 									, resourceResolver);
				 }
				 
	        }
	        else if( countryCd != null )
	        {
	        	redirectPath = redirectAppService.getRedirectUrl("errorpage");
	        	String cntryCode = regionUrlMapping.getRegionCodeValue(countryCd);
	        	redirectPath = getUpdatedUrl(redirectPath, cntryCode );
	        }
	        else
	        {
	        	PrintWriter out = slingResponse.getWriter();
	            out.println("<h1>INVALID REQUEST PARAMETERS </h1>");
	            out.close();
	        }
	        if(redirectPath != null)
	        {
	        	slingResponse.sendRedirect(redirectPath);
	        }
    	}
    	catch (Exception e) {
            log.error("Error while processing the request.",e);
        }
    	    
    }
    
    
    private String getRedirectUrlForOrderPdf(String operation, String countryCode, String id 
											, boolean isloggedIn ,ResourceResolver resourceResolver)
	{
		String redirectPath = null;
		if(operation != null )
		{
			String key = isloggedIn ? operation : "signin";
			
			if(key.equalsIgnoreCase("signin"))
			{
				redirectPath = getSignInPdfUrl(operation, countryCode, id,resourceResolver );
			}
			else
			{
				redirectPath = getPdfUrl( operation, countryCode, id  );				
			}			
		}
		return redirectPath;	
	}
   
    private String getPdfUrl( String operation, String countryCode, String id  )
    {
    	String redirectPath = serviceUrl.getUrl(operation.toLowerCase()).trim();
		log.info("redirectPath before formating ::::::::::::>>>> "+redirectPath);
		if( redirectPath != null && id != null)
		{				
			log.info("COUNTRY CODE MAPPING ::::::::::::>>>> "+countryCode);
			redirectPath = getUpdatedUrl(redirectPath, countryCode ) + id;				
		}		
    	return redirectPath;
    }
    
    private String getSignInPdfUrl(String operation, String countryCode, String id 
			,ResourceResolver resourceResolver )
    
    {
    	String redirectPath = null;
    	if( operation != null && countryCode != null && id != null )
    	{
	    	redirectPath = redirectAppService.getRedirectUrl("signin_pdf_"+countryCode);
			String cntryCode = regionUrlMapping.getRegionCodeValue(countryCode);
			log.info("COUNTRY CODE MAPPING ::::::::::::>>>> "+cntryCode);
			redirectPath = getUpdatedUrl(redirectPath, cntryCode, id ,operation);
			if(runmodeService.isPublish())
			{
				redirectPath = getFriendlyUrl( redirectPath ,resourceResolver);
				log.info("redirect path ::::::::::::>>>> "+redirectPath);
			}
    	}
    	return redirectPath;
    }
    
    
    private String getSignInUrl(String operation, String countryCode 
			, ResourceResolver resourceResolver )
    
    {
    	String redirectPath = null;
    	if( operation != null && countryCode != null  )
    	{
	    	redirectPath = redirectAppService.getRedirectUrl("signin_"+countryCode);
			String cntryCode = regionUrlMapping.getRegionCodeValue(countryCode);
			log.info("COUNTRY CODE MAPPING ::::::::::::>>>> "+cntryCode);
			redirectPath = getUpdatedUrl(redirectPath, cntryCode, operation);
			if(runmodeService.isPublish())
			{
				redirectPath = getFriendlyUrl( redirectPath ,resourceResolver);
				log.info("redirect path ::::::::::::>>>> "+redirectPath);
			}
    	}
    	return redirectPath;
    }
    
    private String getRedirectUrlForOrderDetails(String operation, String countryCode
    											, ResourceResolver resourceResolver)
	{
    	String redirectPath = null;
		if(operation != null )
		{
			String key = "signin";
			
			if(key.equalsIgnoreCase("signin"))
			{
				redirectPath = getSignInUrl(operation, countryCode, resourceResolver );
			}
			else
			{
				redirectPath = redirectAppService.getRedirectUrl(key+"_"+countryCode);
				log.info("redirectPath before formating ::::::::::::>>>> "+redirectPath);
				if( redirectPath != null )
				{
					String cntryCode = regionUrlMapping.getRegionCodeValue(countryCode);
					log.info("COUNTRY CODE MAPPING ::::::::::::>>>> "+cntryCode);
					redirectPath = getUpdatedUrl(redirectPath, cntryCode );
					if(runmodeService.isPublish())
					{
						redirectPath = getFriendlyUrl( redirectPath ,resourceResolver);
						log.info("redirect path ::::::::::::>>>> "+redirectPath);
					}
				}			
				else
				{
					log.warn("NO Matching mapping found for operation, setting error -------->>> " +operation);
					
				}
			}
		}
		return redirectPath;
	}
    
    private String getFriendlyUrl( String url ,ResourceResolver resourceResolver)
    {
    	String friendlyUrl = null;
    	if(url != null )
    
    	{
    		String[] urlPath = url.split("\\.");
    		if( urlPath != null && urlPath.length == 2)
    		{
	    		friendlyUrl = resourceResolver.map(urlPath[0]);
	    		if(friendlyUrl != null)
	    		{
	    			friendlyUrl = friendlyUrl +"."+urlPath[1];
	    		}
    		}
    		else
    		{
    			friendlyUrl = url;
    		}
    	}
    	return friendlyUrl;
    }
    
    private boolean isLoggedInUser(SlingHttpServletRequest slingRequest,String countryCode)
    {
    	boolean retVal = false;
    	Cookie userNameCookie = slingRequest.getCookie("username");
    	Cookie countryCookie = slingRequest.getCookie("countryCookie");
		String[] localeCountry = countryCode.split("_");
		
		if( userNameCookie != null && countryCookie!=null 
							&& localeCountry[1].equalsIgnoreCase(countryCookie.getValue()))
		{
			retVal = true;
		}
		return retVal;
    }
    
    /**
	  *  Formats the service url with the appropriate region code.
	  * @param serviceUrl
	  * @param params
	  * @return
	  */
	 public String getUpdatedUrl(String serviceUrl, Object... params  ) 
	 {
       try 
       {
           return MessageFormat.format(serviceUrl, params);
       } 
       catch (MissingResourceException e) {
       		log.warn("Unable to format -------->>> " +serviceUrl);
           return '!' + serviceUrl + '!';
       }
    }
	 /**
	  * This method is responsibel to disable the cookies before login
	  * @param request
	  * @param response
	  * @param cookiName
	  */
	 public void disableUserCookies(SlingHttpServletRequest request, SlingHttpServletResponse response, String cookiName) 
	 {	
		 if( cookiName != null )
		 {
			 Cookie cookie = request.getCookie(cookiName);			
			 if(cookie != null)
			 {
				log.info("Cookie Name ::::::::: "+cookiName+"  Cookie Value ::::::::: "+cookie.getValue());
			    cookie.setMaxAge(0);	         
			    String userNameCookieString=cookie.getName()+"=" + cookie.getValue() + ";Path=/;expires=Thu, 01 Dec 1994 16:00:00 GMT;";
			    response.addHeader("Set-Cookie", userNameCookieString);
			 }
		 }
			
	  }	
		
		
	 
}