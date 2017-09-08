/**
* Copyright (c)  Vorwerk POC
* Program Name :  FaqCategoriesService.java
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  To call method in FaqCategoriesServiceImpl.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
* -----------                         ----------------                                    -------------------------
* 01-Sep-2016                  Cognizant Technology solutions            					Initial Creation
* -----------                         -----------------                                   -------------------------
**/

package com.vorwerk.adc.workshop.core.osgi.service;

import org.apache.sling.api.SlingHttpServletRequest;


public interface FaqCategoriesService {
	
	public String getFaqCategoryValues(SlingHttpServletRequest slingRequest);
}
