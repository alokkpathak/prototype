/**
* Copyright (c)  Vorwerk POC
* Program Name :  FaqService.java
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  To call method in FaqServiceImpl.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
* -----------                         ----------------                                    -------------------------
* 01-Sep-2016                  Cognizant Technology solutions            					Initial Creation
* -----------                         -----------------                                   -------------------------
**/


package com.vorwerk.adc.workshop.core.osgi.service;

import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.commons.json.JSONObject;
public interface FaqService {

	public JSONObject setFaqValues(SlingHttpServletRequest slingRequest);
	
}
