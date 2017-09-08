/**
* Copyright (c)  Vorwerk POC
* Program Name :  FaqCategoriesContoller.java
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  To call FaqService and FaqCategoriesService classes.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
* -----------                         ----------------                                    -------------------------
* 01-Sep-2016                  Cognizant Technology solutions            					Initial Creation
* -----------                         -----------------                                   -------------------------
**/


package com.vorwerk.adc.workshop.core.servlets;

import java.io.IOException;

import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.sling.SlingServlet;
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.sling.api.servlets.SlingAllMethodsServlet;
import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.sling.commons.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.vorwerk.adc.workshop.core.osgi.service.FaqService;
import com.vorwerk.adc.workshop.core.osgi.service.RunModesService;
import com.vorwerk.adc.workshop.core.osgi.service.FaqCategoriesService;


@SlingServlet(label = "Vorwerk Controller", paths = "/bin/adc/fsl/webshop/faqServlet", methods = "GET/POST", metatype = false)
@Properties({
	
		@Property(name = "service.vendor", value = "Abbot Adc Workshop"),
		@Property(name = "service.description", value = "Controller for any service interaction") })
public class FaqCategoriesContoller extends SlingAllMethodsServlet {

	private static final long serialVersionUID = -7693041955250192356L;
	private static final Logger LOGGER = LoggerFactory
			.getLogger(FaqCategoriesContoller.class);
	private static final String CLASS_NAME = FaqCategoriesContoller.class.getName();


	@Reference
	private FaqService faqService;
	@Reference
	private FaqCategoriesService faqCategoriesService;
	@Reference
	RunModesService runmodeService;
	
		
	@Override
	protected void doGet(SlingHttpServletRequest request,
			SlingHttpServletResponse response) {
		String methodName = "doGet";
		LOGGER.info(" || " + methodName + " || START");
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		response.setHeader("Cache-Control", "no-cache");
		String actionRequest = StringEscapeUtils.escapeHtml4(request.getParameter("requestType"));
		try
		{
			
			if (actionRequest.equalsIgnoreCase("FaqCategoryDetails"))
			{
				LOGGER.info(" Inside the FaqCategoryDetails loop");
			String	finalResponse1 = faqCategoriesService.getFaqCategoryValues(request);
				response.getWriter().print(finalResponse1);
			}			
			
		}
		catch(Exception e){
			LOGGER.error(" || " + methodName + " || Exception || "
					+ e.getMessage());
			
		}
		
		LOGGER.info(" || " + methodName + " || END");
	}

	@Override
	protected void doPost(SlingHttpServletRequest request,
			SlingHttpServletResponse response) throws IOException{

		String methodName = "doPost";
		LOGGER.info(CLASS_NAME + " || " + methodName + " || START");

		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		response.setHeader("Cache-Control", "no-cache");
		String errorurl = StringEscapeUtils.escapeHtml4(request.getParameter("errorurl"));
		
		LOGGER.info("redirectPath===="+errorurl);

		String actionRequest = StringEscapeUtils.escapeHtml4(request.getParameter("requestType"));

		LOGGER.info(" || " + methodName + " || actionRequest || "
				+ actionRequest);
		JSONObject finalResponse = new JSONObject();

		try {
			LOGGER.info(CLASS_NAME + " || " + methodName
					+ " || ACTION_REQUEST " + actionRequest);
			if (runmodeService.isAuthor()){
			if (actionRequest.equalsIgnoreCase("FaqDetails")) {
								
				finalResponse = faqService.setFaqValues(request);
				response.getWriter().print(finalResponse);
			} 
		}
		else if(runmodeService.isPublish())
			{
			LOGGER.info("This is Publish instance");
			response.sendError(SlingHttpServletResponse.SC_FORBIDDEN,errorurl);
			}
		}
			catch (IOException e) {
			
			LOGGER.error(" || " + methodName + " || Exception || "
					+ e.getMessage());
			response.sendError(SlingHttpServletResponse.SC_FORBIDDEN,errorurl);
		}
		catch (Exception globalexception) {
			LOGGER.error(" || " + methodName + " || Exception || "
					+ globalexception.getMessage());
			response.sendError(SlingHttpServletResponse.SC_FORBIDDEN,errorurl);
		}
		LOGGER.info(CLASS_NAME + " || " + methodName + " || END");
	}
}