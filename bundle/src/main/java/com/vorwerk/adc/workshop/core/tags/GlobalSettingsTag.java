/**
* Copyright (c)  Vorwerk POC
* Program Name :  GlobalSettingsTag.java
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  this class is used to retrieve global settings for the application.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
* -----------                         ----------------                                    -------------------------
* 24-Sep-2016                  Cognizant Technology solutions            					Initial Creation
* -----------                         -----------------                                   -------------------------
**/

package com.vorwerk.adc.workshop.core.tags;

import java.io.IOException;
import java.util.regex.PatternSyntaxException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;

import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.scripting.SlingScriptHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.day.cq.wcm.api.Page;
import com.vorwerk.adc.workshop.core.osgi.service.GlobalSettingsMapping;
import com.vorwerk.adc.workshop.core.util.ConfigurationUtil;

public class GlobalSettingsTag extends CQBaseTag
{
	 private static final Logger log = LoggerFactory.getLogger(GlobalSettingsTag.class);
	 
     private String key;
	 private String allDomains;
	 private String currentDomain;
	 private String var; 
	 private static final String REGION_URL_MAPPING_PID = "com.vorwerk.adc.workshop.core.osgi.service.impl.RegionUrlMappingImpl";
	 private static final String REGION_DOMAIN_MAPPING_KEY = "adc.workshop.region.domain.mapping";
	 private static final String REGION_URL_MAPPING_KEY = "adc.workshop.region.url.mapping";	 
     
	 public void doTag() throws JspException, IOException 
	 {
        log.debug("Start doTag");
		String configPropertyValue = "";
		SlingScriptHelper sling = getSlingHelper();
		GlobalSettingsMapping globalSettingsService = sling.getService(com.vorwerk.adc.workshop.core.osgi.service.GlobalSettingsMapping.class);
		ConfigurationUtil configurationUtil = sling.getService(com.vorwerk.adc.workshop.core.util.ConfigurationUtil.class);
		Page currentPage = (Page)findPageContextAttribute("currentPage");		
		String reqUrl = currentPage.getPath();
		String[] propertyArr = configurationUtil.getConfigPropArr(REGION_URL_MAPPING_PID, REGION_URL_MAPPING_KEY);
		String  regionCodePath =  getConfigProperty( reqUrl,  propertyArr );
		
		if(null != globalSettingsService){
  		    if (getAllDomains() != null && ("true").equalsIgnoreCase(getAllDomains()))
			{
				String[] domainArr = configurationUtil.getConfigPropArr(REGION_URL_MAPPING_PID, REGION_DOMAIN_MAPPING_KEY);
				configPropertyValue = getAllDomains(domainArr);
			}
  		    else if (getCurrentDomain() != null && ("true").equalsIgnoreCase(getCurrentDomain()))
			{
				String[] domainArr = configurationUtil.getConfigPropArr(REGION_URL_MAPPING_PID, REGION_DOMAIN_MAPPING_KEY);
				configPropertyValue = getConfigProperty(regionCodePath,domainArr);
			}
			else{
				if(null != getKey()){
					configPropertyValue = globalSettingsService.getEnvProperty(key);	
				}
			}
			log.info("Property value -------------------- "+configPropertyValue);			
			getJspContext().setAttribute(var, configPropertyValue, PageContext.REQUEST_SCOPE);			
		}
		else
		{
			log.debug("Invalid input -------------------- "+getKey());
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
	
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}

	public String getCurrentDomain() {
		return currentDomain;
	}
	public void setCurrentDomain(String currentDomain) {
		this.currentDomain = currentDomain;
	}
	public String getAllDomains() {
		return allDomains;
	}
	public void setAllDomains(String allDomains) {
		this.allDomains = allDomains;
	}
	
	public String getVar() {
		return var;
	}
	public void setVar(String var) {
		this.var = var;
	}
	private String getConfigProperty(String key, String[] properties )
	{
		 log.info("Config property for Domain -------------------- "+properties);
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
	private String getAllDomains(String[] properties )
	{
		 log.info("Config property properties for getAllDomains -------------------- "+properties);
		 String retVal = null;
		 if(properties != null)
		 {
		 	for(String urlPrefix : properties)
         	{   
				try{
					log.info("urlPrefix property properties -------------------- "+urlPrefix);   
					if(retVal==null){
						retVal=urlPrefix.trim();
					}
					else{	
						retVal += ","+urlPrefix.trim();	
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
	 
}
