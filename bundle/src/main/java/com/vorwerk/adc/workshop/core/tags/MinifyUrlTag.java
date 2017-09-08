/**
* Copyright (c)  Vorwerk POC
* Program Name :  MinifyUrlTag.java
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  this class is used to minify the input url based on run mode configurations.
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
import org.apache.sling.api.scripting.SlingScriptHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.vorwerk.adc.workshop.core.osgi.service.RunModesService;

public class MinifyUrlTag extends CQBaseTag
{
	 private static final Logger log = LoggerFactory.getLogger(MinifyUrlTag.class);
	 private static final String DOTHTML=".html";
	 
     private String actualUrl;
	 private String var; 
     
	 public void doTag() throws JspException, IOException 
	 {
        log.debug("Start doTag");
		String minifiedUrl="";
		SlingScriptHelper sling = getSlingHelper();
		RunModesService runModesService = sling.getService(com.vorwerk.adc.workshop.core.osgi.service.RunModesService.class);
		
		if(null != getActualUrl() && null != runModesService){
			if(runModesService.isPublish())
			{     
				minifiedUrl= getSlingRequest().getResourceResolver().map(actualUrl);
			}
			else if(runModesService.isAuthor())
			{
				minifiedUrl = actualUrl;
			}
			log.info("Minified URL -------------------- "+minifiedUrl);
			if(minifiedUrl.endsWith(DOTHTML)){
				getJspContext().setAttribute(var, minifiedUrl, PageContext.REQUEST_SCOPE);}
			else{
				getJspContext().setAttribute(var, minifiedUrl + DOTHTML, PageContext.REQUEST_SCOPE);	}		
		}
		else
		{
			log.debug("Invalid URL/Run mode configuration -------------------- "+getActualUrl());
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
	
	public String getActualUrl() {
		return actualUrl;
	}

	public void setActualUrl(String actualUrl) {
		this.actualUrl = actualUrl;
	}

	public String getVar() {
		return var;
	}
	public void setVar(String var) {
		this.var = var;
	}

	 
}
