/**
* Copyright (c)  Vorwerk POC
* Program Name :  FaqServiceImpl.java
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  To store the data in repository as a property value.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
* -----------                         ----------------                                    -------------------------
* 01-Sep-2016                  Cognizant Technology solutions            					Initial Creation
* -----------                         -----------------                                   -------------------------
**/

package com.vorwerk.adc.workshop.core.osgi.service.impl;

import java.io.UnsupportedEncodingException;




import javax.jcr.Node;
import javax.jcr.PathNotFoundException;
import javax.jcr.RepositoryException;
import javax.jcr.Session;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.Service;
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.commons.json.JSONException;
import org.apache.sling.commons.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.vorwerk.adc.workshop.core.osgi.service.RunModesService;
import com.vorwerk.adc.workshop.core.osgi.service.FaqService;

@Component(metatype = true, immediate = true)
@Service
public class FaqServiceImpl implements FaqService {

	public static final Logger LOGGER = LoggerFactory
			.getLogger(FaqServiceImpl.class);

	@Reference
	RunModesService runmodeService;
	private Session jcrSession = null;

	public JSONObject setFaqValues(SlingHttpServletRequest slingRequest) {

		if (null == jcrSession || !jcrSession.isLive()) {
			jcrSession = slingRequest.getResourceResolver().adaptTo(
					Session.class);
		}
		JSONObject finalResponse = new JSONObject();
		if (runmodeService.isAuthor()) {
			String pathnode =StringEscapeUtils.escapeHtml4(slingRequest.getParameter("nodePath"));
			String propname = StringEscapeUtils.escapeHtml4(slingRequest.getParameter("propertyName"));
			String jdata = null;
			

			try {
				jdata = new String(slingRequest.getParameter("jsondata")
						.getBytes("ISO-8859-1"), "UTF-8");
				Node faqNode = jcrSession.getNode(pathnode);
				faqNode.setProperty(propname, jdata);
				jcrSession.save();
				finalResponse.put("success", "Success");
			} catch (PathNotFoundException e) {
				LOGGER.info("faqNode Path Not Found-" + e.getMessage());
			} catch (RepositoryException e) {
				LOGGER.info("Error Occured-" + e.getMessage());
			} catch (JSONException e) {
				LOGGER.info("Error is occuring in the process of creation of JSONObject-"
						+ e.getMessage());
			} catch (UnsupportedEncodingException e) {
				LOGGER.info("Encoding Exception Is Occuring-" + e.getMessage());
			}
			
		} else if (runmodeService.isPublish()) {
			LOGGER.info("This is Publish instance");
		}
		return finalResponse;

	}

}


