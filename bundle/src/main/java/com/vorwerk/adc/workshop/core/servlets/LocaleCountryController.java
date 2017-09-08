/**
* Copyright (c)  Vorwerk POC
* Program Name :  LocaleCountryController.java
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  this class is used to set the language and country specific locale cookies. These cookies would be used to render country specific requirements through out the application.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
* -----------                         ----------------                                    -------------------------
* 7-Sep-2016                  Cognizant Technology solutions            					Initial Creation
* -----------                         -----------------                                   -------------------------
**/

package com.vorwerk.adc.workshop.core.servlets;

import java.util.regex.PatternSyntaxException;

import javax.servlet.http.Cookie;

import org.apache.felix.scr.annotations.Modified;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.sling.SlingServlet;
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.commons.lang3.LocaleUtils;
import org.apache.sling.api.servlets.SlingAllMethodsServlet;
import org.apache.sling.api.resource.Resource;
import org.apache.sling.api.resource.ResourceResolver;
import org.apache.commons.lang3.StringEscapeUtils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Locale;
import com.day.cq.wcm.api.Page;
import com.day.cq.wcm.api.PageManager;

import com.vorwerk.adc.workshop.core.util.ConfigurationUtil;

@SlingServlet(label = "Vorwerk Locale Country Controller", paths = "/bin/adc/fsl/webshop/localeServlet", methods = "GET", metatype = false)
@Properties({
		@Property(name = "service.vendor", value = "Vorwerk Webshop"),
		@Property(name = "service.description", value = "Controller for any service interaction") })
public class LocaleCountryController extends SlingAllMethodsServlet {
	private static final Logger log = LoggerFactory.getLogger(LocaleCountryController.class);
	private static final String REGION_URL_MAPPING_PID = "com.vorwerk.adc.workshop.core.osgi.service.impl.RegionUrlMappingImpl";
	private static final String REGION_URL_MAPPING_KEY = "adc.workshop.region.url.mapping";
	private static final int expiryTime = -1;
	private static final String cookiePath = "/";
	private static final String CLASS_NAME = LocaleCountryController.class.getName();
		
	@Reference
	ConfigurationUtil configurationUtil;
	
	@Override
	protected void doGet(SlingHttpServletRequest slingRequest,
			SlingHttpServletResponse slingResponse) {
		String methodName = "doGet";
		log.info(CLASS_NAME + " || " + methodName + " || START");
				
		String callingPage = StringEscapeUtils.escapeHtml4(slingRequest.getParameter("callingPage"));
		if(null!=callingPage){
			ResourceResolver resourceResolver = slingRequest.getResourceResolver();
			PageManager pageManager = resourceResolver.adaptTo(PageManager.class);
			Resource resource=resourceResolver.getResource(callingPage);
			Page currentPage = pageManager.getContainingPage(resource);
			String reqUrl = currentPage.getPath();		
			String[] propertyArr = configurationUtil.getConfigPropArr(REGION_URL_MAPPING_PID, REGION_URL_MAPPING_KEY);
			String  regionCodePath =  getRegionCode( reqUrl,  propertyArr );
			log.info("current page locale:"+regionCodePath);
			if (null != regionCodePath){
				setLocaleCookies(regionCodePath,slingResponse);
			}
		}
		else{
			log.error("Calling page is null or empty - " + callingPage);
		}
	}	
	
	private String getRegionCode(String url, String[] properties )
	{
		 String retVal = null;
		 if(url != null && properties != null)
		 {
		 	for(String urlPrefix : properties)
         	{         
				try{
					String[] keyVal = urlPrefix.trim().split("::");
					if(url.contains(keyVal[0]))
					{
						retVal = keyVal[1];
						break;
					}
				}
				catch(PatternSyntaxException pse){
					log.error("Unable to parse urlPrefix from LocaleCountryController - " + pse);
				}
         	}
		 }
		 return retVal;
	 }
	 
	private void setLocaleCookies(String regionCodePath,SlingHttpServletResponse slingResponse){
		Locale forLangLocale = LocaleUtils.toLocale(regionCodePath);
		Cookie countryCookie = new Cookie("countryCookie",forLangLocale.getCountry());
		countryCookie.setPath(cookiePath);
		countryCookie.setMaxAge(expiryTime);
		slingResponse.addCookie(countryCookie);
		
		log.info("country cookie created successfully -------------------- "+countryCookie);
	}
}
