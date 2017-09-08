/**
* Copyright (c)  Vorwerk POC
* Program Name :  OsgiConfigTag.java
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  this class is used to read OSGI configuration
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
* -----------                         ----------------                                    -------------------------
* 28-Aug-2016                  Cognizant Technology solutions            					Initial Creation
* -----------                         -----------------                                   -------------------------
**/

package com.vorwerk.adc.workshop.core.tags;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import org.apache.sling.api.scripting.SlingScriptHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.vorwerk.adc.workshop.core.util.ConfigurationUtil;


public class OsgiConfigTag extends SimpleTagSupport {
    private static final Logger log = LoggerFactory.getLogger(OsgiConfigTag.class);

    // The pid could be a service PID or the Factory PID
    private String pid;
    private String property;
    private String var; 
    private String key;
       
	public void doTag() throws JspException, IOException {
        log.debug("Start doTag");
        String configPropertyValue = null;
		
		SlingScriptHelper sling = getSlingHelper();
		ConfigurationUtil configurationUtil = sling.getService(com.vorwerk.adc.workshop.core.util.ConfigurationUtil.class);
		
		if(getKey() != null )
		{
			configPropertyValue = configurationUtil.getConfig(pid, property,key);
		}
		else
		{
			configPropertyValue = configurationUtil.getConfig(pid, property);
		}
		
		log.info("Config property value -------------------- "+configPropertyValue);
		getJspContext().setAttribute(var, configPropertyValue, PageContext.REQUEST_SCOPE);

        log.debug("End doTag");
    }
    
    SlingScriptHelper getSlingHelper() {
		return (SlingScriptHelper) getJspContext().getAttribute("sling");
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public void setProperty(String property) {
		this.property = property;
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

}
