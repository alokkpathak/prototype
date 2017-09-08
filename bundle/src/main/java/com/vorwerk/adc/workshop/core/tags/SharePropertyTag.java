package com.vorwerk.adc.workshop.core.tags;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.jcr.Node;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;

import org.apache.sling.api.resource.Resource;
import org.apache.sling.api.resource.ResourceResolver;
import org.apache.sling.api.resource.ValueMap;
import com.vorwerk.adc.workshop.core.exception.AdcFslException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class SharePropertyTag extends CQBaseTag 
{
	 private static final Logger log = LoggerFactory.getLogger(SharePropertyTag.class);
	
	 private String var; 
	 
	 private String componentNodePath = "share";
	 
	
	 /**
	 * @return the componentNodePath
	 */
	public String getComponentNodePath() {
		return componentNodePath;
	}


	/**
	 * @param componentNodePath the componentNodePath to set
	 */
	public void setComponentNodePath(String componentNodePath) {
		this.componentNodePath = componentNodePath;
	}


	/**
	 * @return the var
	 */
	public String getVar() {
		return var;
	}


	/**
	 * @param var the var to set
	 */
	public void setVar(String var) {
		this.var = var;
	}


	public void doTag() throws JspException, IOException 
	 {
		
		 try
		 {
			 Node currentNode = (Node)findPageContextAttribute(CURRENT_NODE);
			 
			 if( currentNode != null )
			 {
				 log.info(":::::::::::::::::::::::::::>>>>>>>>>>> "+currentNode.getPath());
				
				 ResourceResolver resourceResolver = (ResourceResolver) findPageContextAttribute(RESOURCE_RESOLVER);
				 Resource rootRes = resourceResolver.getResource(currentNode.getPath()+"/"+componentNodePath);

				 log.info(":::::::::::::::::::::::::::>>>>>>>>>>> "+rootRes);
                 if (log.isDebugEnabled()){
					 log.debug("componentPath :{}", componentNodePath);
				 }

                 if (rootRes == null || rootRes.isResourceType(Resource.RESOURCE_TYPE_NON_EXISTING)) 
                 {
                    throw new AdcFslException("Please provide component path."+componentNodePath);
                 }
                 
                 Map<String, Object> mapProps = new HashMap<String, Object>();
                 if (rootRes != null) {

                     final ValueMap props = rootRes.adaptTo(ValueMap.class);
                     mapProps.putAll(props);                     

                     getJspContext().setAttribute(getVar(), mapProps , PageContext.REQUEST_SCOPE);                     
                     log.info("page properties :>>>>>>>>>>>>>>>>> {}", mapProps.toString());
                     if (log.isDebugEnabled()){
						 log.debug("page properties : {}", mapProps.toString());
					 }
                 }
			 }
		 }
		 catch(Exception e )
		 {
			 log.error("Unable to process tag {} ", e);
		 }
	 }
}
