/**
* Copyright (c)  Vorwerk POC
* Program Name :  InitMetaTag.java
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  this class is used to generated Meta tags, link canonical, alternate tags, hreflang as part of SEO requirements
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
* -----------                         ----------------                                    -------------------------
* 7-Sep-2016                  Cognizant Technology solutions            					Initial Creation
* -----------                         -----------------                                   -------------------------
**/


package com.vorwerk.adc.workshop.core.tags;

import java.io.IOException;
import java.util.regex.PatternSyntaxException;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;

import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.sling.api.scripting.SlingScriptHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.apache.commons.lang3.LocaleUtils;
import org.apache.sling.api.resource.ResourceResolver;

import java.io.PrintWriter;
import java.util.Locale;
import java.util.Map;
import java.util.HashMap;
import com.day.cq.wcm.api.Page;

import com.vorwerk.adc.workshop.core.util.ConfigurationUtil;
import com.vorwerk.adc.workshop.core.osgi.service.RunModesService;
import com.vorwerk.adc.workshop.core.util.AlternateLangUtil;

public class InitMetaTag extends CQBaseTag
{
	private static final Logger log = LoggerFactory.getLogger(InitMetaTag.class);
	private static final String REGION_URL_MAPPING_PID = "com.vorwerk.adc.workshop.core.osgi.service.impl.RegionUrlMappingImpl";
	private static final String REGION_URL_MAPPING_KEY = "adc.workshop.region.url.mapping";
	private static final String REGION_DOMAIN_MAPPING_KEY = "adc.workshop.region.domain.mapping";

	private static final String DOTHTML=".html";
	private static final String INDEXHTML="index.html";
	private String includeCanonicalTag;
	
	public void doTag() throws JspException, IOException 
	{
        log.debug("Start doTag");
		SlingHttpServletResponse slingResponse = getSlingResponse();	
		SlingScriptHelper sling = getSlingHelper();
		Page currentPage = (Page)findPageContextAttribute("currentPage");		
		String reqUrl = currentPage.getPath();
		log.debug("Page URL:" +reqUrl);
		ConfigurationUtil configurationUtil = sling.getService(com.vorwerk.adc.workshop.core.util.ConfigurationUtil.class);		
		AlternateLangUtil alternateLangUtil = sling.getService(com.vorwerk.adc.workshop.core.util.AlternateLangUtil.class);		

		String[] domainArr = configurationUtil.getConfigPropArr(REGION_URL_MAPPING_PID, REGION_DOMAIN_MAPPING_KEY);
		RunModesService runModesService = sling.getService(com.vorwerk.adc.workshop.core.osgi.service.RunModesService.class);
		
		String[] propertyArr = configurationUtil.getConfigPropArr(REGION_URL_MAPPING_PID, REGION_URL_MAPPING_KEY);
		String  regionCodePath =  getConfigProperty( reqUrl,  propertyArr );
		if (null != regionCodePath){
			setMetaTag(regionCodePath,slingResponse);
			if(null != getIncludeCanonicalTag() && "true".equalsIgnoreCase(getIncludeCanonicalTag())){			
				setCanonicalTag(runModesService, slingResponse,domainArr,reqUrl,regionCodePath);
				setAlternateTags(runModesService, slingResponse,domainArr,reqUrl,alternateLangUtil,propertyArr,regionCodePath);					
			}
		}
        log.debug("End doTag");
    }
	 
	private void setMetaTag(String regionCodePath,SlingHttpServletResponse slingResponse){
		try
		{
			Locale forLangLocale = LocaleUtils.toLocale(regionCodePath);		
			PrintWriter out = slingResponse.getWriter();
			out.println("<meta name=\"language\" content=\""+forLangLocale.getLanguage()+"-"+forLangLocale.getCountry()+"\"  />");
		}	
		catch(Exception ioe){
			log.debug("Exception occurred while pushing meta tag" +ioe);		
		}
	}
	
	private void setCanonicalTag(RunModesService runModesService,SlingHttpServletResponse slingResponse,String[] domainArr, String hrefurl, String regionCodePath){
		try{
			PrintWriter out = slingResponse.getWriter();
			String domainName = getConfigProperty(regionCodePath , domainArr );
			String minifiedUrl= getMinifiedURL(runModesService, hrefurl);
			if(null != domainName && null !=minifiedUrl){
				out.println("<link rel=\"canonical\" href=\""+domainName+minifiedUrl+"\" /> ");
			}
		}
		catch(Exception ioe){
			log.debug("Exception occurred while pushing canonical tags" +ioe);		
		}
	}
	private void setAlternateTags(RunModesService runModesService, SlingHttpServletResponse slingResponse,String[] domainArr,String hrefurl,AlternateLangUtil alternateLangUtil,String[] propertyArr, String regionCodePath )
	{
		 log.info("JCR page path -------------------- "+hrefurl);
		 if(domainArr != null && null!=hrefurl)
		 {
			try{
				PrintWriter out = slingResponse.getWriter();
				final ResourceResolver resourceResolver = (ResourceResolver) findPageContextAttribute(RESOURCE_RESOLVER);
				log.info("JCR page path -------------------- "+resourceResolver);
				Map<String,String> liveRelationsMap=new HashMap<String,String>();
				liveRelationsMap = alternateLangUtil.getAlternateUrls(resourceResolver,hrefurl,propertyArr);
				log.info("JCR page path from alturl-------------------- "+liveRelationsMap);
				
				if(liveRelationsMap==null || liveRelationsMap.isEmpty()){
					String domainName = getConfigProperty(regionCodePath , domainArr );
					Locale forLangLocale = LocaleUtils.toLocale(regionCodePath);		
					String minifiedUrl= getMinifiedURL(runModesService, hrefurl);
					if(null != domainName && null !=minifiedUrl && null!=forLangLocale){
						out.println("<link rel=\"alternate\" href=\""+domainName+minifiedUrl +"\" hreflang=\""+forLangLocale.getLanguage().toLowerCase()+"-"+forLangLocale.getCountry().toLowerCase()+"\"/>");
					}
				}else{
					for (String localeKey : liveRelationsMap.keySet()) {
						String[] hrefLangVal = localeKey.trim().split("_");
						String minifiedUrl= getMinifiedURL(runModesService, liveRelationsMap.get(localeKey));
						String domainName = getConfigProperty(localeKey , domainArr );
						if(null != domainName && null !=minifiedUrl){
							out.println("<link rel=\"alternate\" href=\""+domainName+minifiedUrl +"\" hreflang=\""+hrefLangVal[0].toLowerCase()+"-"+hrefLangVal[1].toLowerCase()+"\"/>");
						}
					}
				}
			}
			catch(Exception e){
				log.error("Exception occurred while creating href lang tags" +e);		
			}
		}
	}
	 
	 private String getMinifiedURL(RunModesService runModesService,String reqUrl){
		String hrefRevisedUrl="";
		if(runModesService.isPublish())
		{     
			String minifiedUrl=getSlingRequest().getResourceResolver().map(reqUrl);
			if(null !=minifiedUrl && !minifiedUrl.endsWith(DOTHTML)){
				minifiedUrl+=DOTHTML;
			}
			if(null!=minifiedUrl){			
				int hrefUrlIndex=minifiedUrl.indexOf(INDEXHTML);
				if(hrefUrlIndex>0){
					//strip of index.html
					hrefRevisedUrl = minifiedUrl.substring(0,hrefUrlIndex);
				}
				else{
					hrefRevisedUrl = minifiedUrl;
				}
			}
		}
		else if(runModesService.isAuthor())
		{
			hrefRevisedUrl = reqUrl;
			if(null !=hrefRevisedUrl && !hrefRevisedUrl.endsWith(DOTHTML)){
				hrefRevisedUrl+=DOTHTML;
			}
		}
		return hrefRevisedUrl;
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
	 
	 private String getConfigProperty(String url, String[] properties )
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
	public String getIncludeCanonicalTag() {
		return includeCanonicalTag;
	}

	public void setIncludeCanonicalTag(String includeCanonicalTag) {
		this.includeCanonicalTag = includeCanonicalTag;
	}
	 
}
