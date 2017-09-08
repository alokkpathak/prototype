/**
* Copyright (c)  Vorwerk POC
* Program Name :  MultiCompositeField.java
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  this class is used to create Multi composite form type for content authoring
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
* -----------                         ----------------                                    -------------------------
* 28-Aug-2016                  Cognizant Technology solutions            					Initial Creation
* -----------                         -----------------                                   -------------------------
**/

package com.vorwerk.adc.workshop.core.tags;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;

import org.apache.sling.api.SlingHttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.apache.sling.api.resource.Resource;

import javax.jcr.Node;
import javax.jcr.NodeIterator;

public class MultiCompositeField extends CQBaseTag 
{
	private static final Logger log = LoggerFactory.getLogger(MultiCompositeField.class);
	
	private String fieldNodeName;
	
	private String[] fieldPropertyNames;
	
	private String returnType;
	
	private String var = "var";
	
	private static final String TYPE_LIST = "List";

	private static final String TYPE_ARRAY = "Array";
	
	public String getVar() {
		return var;
	}

	public void setVar(String var) {
		this.var = var;
	}

	public String getReturnType() {
		return returnType;
	}

	public void setReturnType(String returnType) {
		this.returnType = returnType;
	}

	public void doTag() throws JspException, IOException 
	{
		if(this.fieldNodeName != null && this.fieldPropertyNames != null)
		{
			if(this.returnType != null && this.returnType.equalsIgnoreCase(TYPE_ARRAY) )
			{
				getJspContext().setAttribute(this.var, getMultiCompositeFieldValues(this.fieldNodeName, this.fieldPropertyNames)
											, PageContext.REQUEST_SCOPE);
			}
			else if(this.returnType != null && this.returnType.equalsIgnoreCase(TYPE_LIST) )
			{
			
				getJspContext().setAttribute(this.var, getMultiCompositeValuesArrayList(this.fieldNodeName, this.fieldPropertyNames)
											, PageContext.REQUEST_SCOPE);
			}			
		}	
	}
	
	
	/**
	 * @param path
	 * @param nodename
	 * @param propertyNames
	 * @return
	 * @return
	 */
	public String[] getMultiCompositeFieldValues(String nodename,String[] propertyNames) {

		SlingHttpServletRequest slingRequest = getSlingRequest();
		
		if ( null != nodename && null != propertyNames) {
			try {
				
				Node currentNode = (Node)findPageContextAttribute(CURRENT_NODE);
				String path = currentNode.getPath();
				
				String[] multiCompositeFieldValues;
				final ArrayList<String> fieldList = new ArrayList<String>();
				final Resource resource = slingRequest.getResourceResolver()
						.getResource(path);
				final Node resourceNode = resource.adaptTo(Node.class);
				if (resourceNode.hasNode(nodename)) {
					final NodeIterator nodeIterator = resourceNode.getNode(
							nodename).getNodes();
					while (nodeIterator.hasNext()) {
						final StringBuffer childNodeProprties = new StringBuffer();
						final Node childNode = (Node) nodeIterator.next();
						for (final String propertyName : propertyNames) {
							if (childNode.hasProperty(propertyName)
									&& null != childNode.getProperty(
											propertyName).getString()) {
								childNodeProprties.append(childNode
										.getProperty(propertyName).getString());
								log.info("Multifield Prop Values"+childNode.getProperty(propertyName).getString());
							} else {
								childNodeProprties.append(" ");
							}
							childNodeProprties.append(",");
						}
						fieldList.add(childNodeProprties.toString());
					}
					multiCompositeFieldValues = fieldList
							.toArray(new String[fieldList.size()]);

					for (final String test : fieldList) {
						log.debug(" properties" + test);
					}
					log.info("MULTI FIELD VALUES ::::::::::::: "+multiCompositeFieldValues);
					return multiCompositeFieldValues;
				} else {
					log.error(nodename + " is not available in the path" + path);
					return null;
				}
			} catch (final Exception e) {
				log.error("exception occured while retreiving compositevalues"
						+ e.getMessage());
				return null;
			}
		}
		return propertyNames;

	}
	
	private List< HashMap<String, String>> getMultiCompositeValuesArrayList(String nodename, String[] propertyNames){
		 
		SlingHttpServletRequest slingRequest = getSlingRequest();
		
		 if (null != nodename && null != propertyNames) {
				try {
					Node currentNode = (Node)findPageContextAttribute(CURRENT_NODE);
					String path = currentNode.getPath();
					final ArrayList<HashMap<String, String>> fieldList = new ArrayList<HashMap<String, String>>();
					final Resource resource = slingRequest.getResourceResolver()
							.getResource(path);
					final Node resourceNode = resource.adaptTo(Node.class);
					if (resourceNode.hasNode(nodename)) {
						final NodeIterator nodeIterator = resourceNode.getNode(
								nodename).getNodes();
						while (nodeIterator.hasNext()) {
							final Node childNode = (Node) nodeIterator.next();
							
							HashMap<String, String> map = new HashMap<String, String>();

							for (final String propertyName : propertyNames) {
								if (childNode.hasProperty(propertyName)
										&& null != childNode.getProperty(
												propertyName).getString()) {
									
									map.put(propertyName, childNode.getProperty(
											propertyName).getString());
								} 
							}
							fieldList.add(map);
						}
						

						for ( HashMap<String, String> mapIterator  : fieldList) {
							log.info( "Properties.........");
							for (final String propertyName : propertyNames) {
								log.info(propertyName +"  ::::  "  +mapIterator.get(propertyName));
							}
						}
						return fieldList;
					} else {
						log.error(nodename + " is not available in the path" + path);
						return null;
					}
				} catch (final Exception e) {
					log.error("exception occured while retreiving compositevalues"
							+ e.getMessage());
					return null;
				}
			}
		return null;

		
	}
	public String getFieldNodeName() {
		return fieldNodeName;
	}

	public void setFieldNodeName(String fieldNodeName) {
		this.fieldNodeName = fieldNodeName;
	}

	public String[] getFieldPropertyNames() {
		return fieldPropertyNames;
	}

	public void setFieldPropertyNames(String[] fieldPropertyNames) {
		this.fieldPropertyNames = fieldPropertyNames;
	}
}
