/**
* Copyright (c)  Vorwerk POC
* Program Name :  ServiceUrlTag.java
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  this class is used to read all service URLs from OSGI config to make calls to APP Server for backend interactions.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
* -----------                         ----------------                                    -------------------------
* 28-Aug-2016                  Cognizant Technology solutions            					Initial Creation
* -----------                         -----------------                                   -------------------------
**/

package com.vorwerk.adc.workshop.core.tags;

import java.io.IOException;
import java.text.MessageFormat;
import java.util.MissingResourceException;
import java.util.regex.PatternSyntaxException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;

import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.scripting.SlingScriptHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.vorwerk.adc.workshop.core.osgi.service.RunModesService;
import com.vorwerk.adc.workshop.core.util.ConfigurationUtil;
import com.day.cq.wcm.api.Page;

public class ServiceUrlTag extends CQBaseTag
{
	 private static final Logger log = LoggerFactory.getLogger(ServiceUrlTag.class);
	 
	 private static final String REST_SERVICE_URL_PID = "com.vorwerk.adc.workshop.core.osgi.service.impl.RestServiceUrlImpl";
	 private static final String REST_SERVICE_URL_PROP = "adc.workshop.url.mapping";
	 private static final String REGION_URL_MAPPING_PID = "com.vorwerk.adc.workshop.core.osgi.service.impl.RegionUrlMappingImpl";
	 private static final String REGION_URL_MAPPING_KEY = "adc.workshop.region.url.mapping";
	 private static final String REGION_DOMAIN_MAPPING_KEY = "adc.workshop.region.domain.mapping";
	 	 	 
	 private String var; 
     private String key;
     
     private String skuid;
     private String skip;
       
	 public void doTag() throws JspException, IOException 
	 {
        log.debug("Start doTag");
        String serviceUrl = "";
		
		SlingScriptHelper sling = getSlingHelper();
		ConfigurationUtil configurationUtil = sling.getService(com.vorwerk.adc.workshop.core.util.ConfigurationUtil.class);
		
		RunModesService runModeService = sling.getService(com.vorwerk.adc.workshop.core.osgi.service.RunModesService.class);
		
		try
		{
			if(getKey() != null )
			{
				 // gets the service url based on the supplied key
				 serviceUrl = configurationUtil.getConfig(REST_SERVICE_URL_PID, REST_SERVICE_URL_PROP,key);
				 
				 if(serviceUrl != null )
				 {
					 serviceUrl = serviceUrl.trim();
				 }
				 // if skip is set no processing of the serviceUrl is required.
				 if( getSkip() == null || (getSkip() != null && getSkip().isEmpty()))
				 {
					 Page currentPage = (Page)findPageContextAttribute("currentPage");
				     String reqUrl = currentPage.getPath();
				     log.info("currentPage.getPath() ===================> "+reqUrl);
					 // gets the region code array.
				     String[] propertyArr = configurationUtil.getConfigPropArr(REGION_URL_MAPPING_PID, REGION_URL_MAPPING_KEY);
				     
				     String  regionCodePath =  getRegionCode( reqUrl,  propertyArr );
				     
				     log.info("runModeService &&&&&&&&&&&&&&&&&&&&&&&&&"+runModeService);
				     if( runModeService != null &&  runModeService.isAuthor())
				     {
				    	// gets the region code array.
				    	 String[] domainArr = configurationUtil.getConfigPropArr(REGION_URL_MAPPING_PID, REGION_DOMAIN_MAPPING_KEY);
				    	 log.info("domainArr &&&&&&&&&&&&&&&&&&&&&&&&&"+domainArr);
				    	 String domain = getDomain(regionCodePath , domainArr );
				    	 serviceUrl = domain + serviceUrl;
				     }
					 if(serviceUrl != null )
					 {
						 if(getSkuid() != null && !getSkuid().isEmpty())
						 {
							 serviceUrl = getUpdatedUrl(serviceUrl.trim(), regionCodePath , getSkuid());
						 }
						 else
						 {
							 serviceUrl = getUpdatedUrl(serviceUrl.trim(), regionCodePath);
						 }
					 }
				 }
				 
			}		
			log.info("Config property value -------------------- "+serviceUrl);
			getJspContext().setAttribute(var, serviceUrl, PageContext.REQUEST_SCOPE);
		}
		catch(Exception e)
		{
			log.error("Unable to fetch the service url ------>>> ", e);
		}

        log.debug("End doTag");
     }
	
	 SlingScriptHelper getSlingHelper() {
		 return (SlingScriptHelper) getJspContext().getAttribute("sling");
	 }

	 protected SlingHttpServletRequest getSlingRequest()
	 {
		 return (SlingHttpServletRequest) ((PageContext)getJspContext()).findAttribute("slingRequest");
	 }	
	
	 /**
	  *  This method matches the url against the property array, and returns the patching region code.
	  * @param url
	  * @param properties
	  * @return region code eg : en_GB
	  */
	 private String getRegionCode(String url, String[] properties )
	 {
		 log.info("Config property properties -------------------- "+properties);
		 String retVal = null;
		 if(url != null && properties != null)
		 {
		 	for(String urlPrefix : properties)
         	{   
				try{
					log.info("urlPrefix property properties -------------------- "+urlPrefix);      		
					String[] keyVal = urlPrefix.trim().split("::");
					if(url.contains(keyVal[0]))
					{
						retVal = keyVal[1];
						break;
					}
				}
				catch(PatternSyntaxException pse){
					log.error("Unable to parse urlPrefix from global settings tag - " + pse);
				}
         	}
		 }
		 log.info("urlPrefix retVal -------------------- "+retVal);  
		 return retVal;
	 }
	 
	 /**
	  *  This method returns the domain based on the region code.
	  * @param key
	  * @param properties
	  * @return the domain value based on the region code.
	  */
	 private String getDomain(String key, String[] properties )
	 {
		 log.info("Config property properties for Domain -------------------- "+properties);
		 String retVal = null;
		 if(key != null && properties != null)
		 {
		 	for(String urlPrefix : properties)
         	{   
				try{
					log.info("urlPrefix property properties -------------------- "+urlPrefix);      		
					String[] keyVal = urlPrefix.trim().split("::");
					if(key.contains(keyVal[0]))
					{
						retVal = keyVal[1];
						break;
					}
				}
				catch(PatternSyntaxException pse){
					log.error("Unable to parse urlPrefix from global settings tag - " + pse);
				}
         	}
		 }
		 log.info("Domain retVal -------------------- "+retVal);  
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
	 * @return the skip
	 */
	public String getSkip() {
		return skip;
	}

	/**
	 * @param skip the skip to set
	 */
	public void setSkip(String skip) {
		this.skip = skip;
	}

	public String getVar() {
		return var;
	}

	public void setVar(String var) {
		this.var = var;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getSkuid() {
		return skuid;
	}

	public void setSkuid(String skuid) {
		this.skuid = skuid;
	}
	 
}
