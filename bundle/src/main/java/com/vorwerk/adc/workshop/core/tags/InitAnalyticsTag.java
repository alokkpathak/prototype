/**
* Copyright (c)  Vorwerk POC
* Program Name :  InitAnalyticsTag.java
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  this class is initialize Analytics configuration for the application.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
* -----------                         ----------------                                    -------------------------
* 21-Sep-2016                  Cognizant Technology solutions            					Initial Creation
* -----------                         -----------------                                   -------------------------
**/

package com.vorwerk.adc.workshop.core.tags;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;

import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.sling.api.scripting.SlingScriptHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.apache.commons.lang3.StringEscapeUtils;

import java.io.PrintWriter;
import com.day.cq.wcm.api.Page;
import com.vorwerk.adc.workshop.core.osgi.service.GlobalSettingsMapping;
import com.vorwerk.adc.workshop.core.util.ConfigurationUtil;

public class InitAnalyticsTag extends CQBaseTag
{
	private static final Logger log = LoggerFactory.getLogger(InitAnalyticsTag.class);
	private static final String INIT_GTM="initGTM";
	  
	private static final String REGION_URL_MAPPING_PID = "com.vorwerk.adc.workshop.core.osgi.service.impl.RegionUrlMappingImpl";
	private static final String REGION_URL_MAPPING_KEY = "adc.workshop.region.url.mapping";
	 
	public void doTag() throws JspException, IOException 
	{
        log.debug("Start doTag");
		
		SlingScriptHelper sling = getSlingHelper();
		Page currentPage = (Page)findPageContextAttribute("currentPage");		
		String reqUrl = currentPage.getPath();

		ConfigurationUtil configurationUtil = sling.getService(com.vorwerk.adc.workshop.core.util.ConfigurationUtil.class);		
		GlobalSettingsMapping globalSettingsService = sling.getService(com.vorwerk.adc.workshop.core.osgi.service.GlobalSettingsMapping.class);		

		String[] propertyArr = configurationUtil.getConfigPropArr(REGION_URL_MAPPING_PID, REGION_URL_MAPPING_KEY);
		String  regionCodePath =  getRegionCode( reqUrl,  propertyArr );
		if (null != regionCodePath){
			initAnalytics(regionCodePath,globalSettingsService);
		}
        log.debug("End doTag");
     }
	 
	private void initAnalytics(String regionCodePath,GlobalSettingsMapping globalSettingsService){
		SlingHttpServletResponse slingResponse = getSlingResponse();	
		String configPropertyValue = "";
		PrintWriter out=null;
		try{
			if(null != regionCodePath && null != globalSettingsService){
				configPropertyValue = globalSettingsService.getEnvProperty(INIT_GTM+"_"+regionCodePath);	
				log.debug("regionCodePath"+regionCodePath +"configPropertyValue " +configPropertyValue);
				if(null != configPropertyValue && !"".equals(configPropertyValue)){
					slingResponse.setContentType("text/xml");
					out = slingResponse.getWriter();
					out.println(StringEscapeUtils.unescapeXml(configPropertyValue));
				}
			}
		}
		catch(IOException ioException){
			log.debug("IOException in retrieving configuration and sending response" +ioException);
		}
	}	 
	
	 SlingScriptHelper getSlingHelper() {
		 return (SlingScriptHelper) getJspContext().getAttribute("sling");
	 }

	 protected SlingHttpServletRequest getSlingRequest()
	 {
		 return (SlingHttpServletRequest) ((PageContext)getJspContext()).findAttribute("slingRequest");
	 }	

	 protected SlingHttpServletResponse getSlingResponse()
	 {
		 return (SlingHttpServletResponse) ((PageContext)getJspContext()).findAttribute("slingResponse");
	 }	
	 
	 private String getRegionCode(String url, String[] properties )
	 {
		 log.info("Config property properties -------------------- "+properties);
		 String retVal = null;
		 if(url != null && properties != null)
		 {
		 	for(String urlPrefix : properties)
         	{   log.info("urlPrefix property properties -------------------- "+urlPrefix);      		
         		String[] keyVal = urlPrefix.trim().split("::");
         		if(url.contains(keyVal[0]))
         		{
         			retVal = keyVal[1];
         			break;
         		}
         	}
		 }
		 log.info("urlPrefix retVal -------------------- "+retVal);  
		 return retVal;
	 }
}
