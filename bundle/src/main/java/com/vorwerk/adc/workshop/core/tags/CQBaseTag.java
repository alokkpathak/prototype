/**
* Copyright (c)  Vorwerk POC
* Program Name :  CQBaseTag.java
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  this Class has base functionality needed to access CQ features
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
* -----------                         ----------------                                    -------------------------
* 28-Aug-2016                  Cognizant Technology solutions            					Initial Creation
* -----------                         -----------------                                   -------------------------
**/
package com.vorwerk.adc.workshop.core.tags;

import javax.jcr.Session;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import org.apache.sling.api.SlingHttpServletRequest;

import com.day.cq.search.QueryBuilder;


/**
 * Class that has base functionality needed to access CQ features
 * @extends TagSupport
 *
 */
public class CQBaseTag extends  SimpleTagSupport {
	protected static final String CURRENT_NODE 		= "currentNode";
	protected static final String SLING 			= "sling";
	protected static final String SLING_REQUEST 	= "slingRequest";
	protected static final String SLING_RESPONSE 	= "slingResponse";
	protected static final String RESOURCE 			= "resource";
	protected static final String RESOURCE_RESOLVER = "resourceResolver";
	protected static final String BINDINGS 			= "bindings";
	protected static final String COMPONENT_CONTEXT = "componentContext";
	protected static final String EDIT_CONTEXT 		= "editContext";
	protected static final String PROPERTIES 		= "properties";
	protected static final String PAGE_MANAGER 		= "pageManager";
	protected static final String RESOURCE_PAGE 	= "resourcePage";
	protected static final String COMPONENT 		= "component";
	protected static final String DESIGNER 			= "designer";
	protected static final String CURRENT_DESIGN 	= "currentDesign";
	protected static final String RESOURCE_DESIGN 	= "resourceDesign";
	protected static final String CURRENT_STYLE 	= "currentStyle";
	
	protected Object findPageContextAttribute(String key)
	{
		return ((PageContext)getJspContext()).findAttribute(key);
	}
	
	protected SlingHttpServletRequest getSlingRequest()
	{
		return (SlingHttpServletRequest) findPageContextAttribute(SLING_REQUEST);
	}	
	
	protected Session getJcrSession()
	{
		return (getSlingRequest().getResourceResolver()).adaptTo(Session.class);
	}
	
	protected QueryBuilder getQueryBuilder()
	{
		return (getSlingRequest().getResourceResolver()).adaptTo(QueryBuilder.class);
	}
}	


