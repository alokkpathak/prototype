/**
* Copyright (c)  Vorwerk POC
* Program Name :  FaqCategoriesServiceImpl.java
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  To read FaqCategories data from the repository.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
* -----------                         ----------------                                    -------------------------
* 01-Sep-2016                  Cognizant Technology solutions            					Initial Creation
* -----------                         -----------------                                   -------------------------
**/

package com.vorwerk.adc.workshop.core.osgi.service.impl;
import javax.jcr.Node;
import javax.jcr.PathNotFoundException;
import javax.jcr.RepositoryException;
import javax.jcr.Session;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Service;
import org.apache.sling.api.SlingHttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.vorwerk.adc.workshop.core.osgi.service.FaqCategoriesService;


@Service
@Component(metatype = false, immediate = true)
public class FaqCategoriesServiceImpl implements FaqCategoriesService {

	public static final Logger LOGGER = LoggerFactory
			.getLogger(FaqCategoriesServiceImpl.class);
	private Session jcrSession = null;

	public String getFaqCategoryValues(SlingHttpServletRequest slingRequest) {
		LOGGER.info("Inside the category Related File");

		if (null == jcrSession || !jcrSession.isLive()) {
			jcrSession = slingRequest.getResourceResolver().adaptTo(
					Session.class);
		}

		String categoryProperty =StringEscapeUtils.escapeHtml4(slingRequest.getParameter("categorypropVal"));
		String categoryPage = StringEscapeUtils.escapeHtml4(slingRequest.getParameter("categorypageVal"));
		String dataneeded = null;
		try {
			Node faqNode = jcrSession.getNode(categoryPage);
			dataneeded = faqNode.getProperty(categoryProperty).getString();
			LOGGER.info("Required nodedata" + dataneeded);
		}

		catch (PathNotFoundException e) {
			LOGGER.error("faqNode Path Not Found-" + e.getMessage());
		} catch (RepositoryException e) {
			LOGGER.error("Error Occured-" + e.getMessage());
		}
		return dataneeded;

	}

}
