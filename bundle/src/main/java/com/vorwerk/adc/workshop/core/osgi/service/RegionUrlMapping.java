/**
* Copyright (c)  Vorwerk POC
* Program Name :  RegionUrlMapping.java
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
* -----------                         ----------------                                    -------------------------
* 26-Jul-2016                  Cognizant Technology solutions            					Initial Creation
* -----------                         -----------------                                   -------------------------
**/

package com.vorwerk.adc.workshop.core.osgi.service;

public interface RegionUrlMapping 
{
	public String getRegionCode(String url);
	
	public String getRegionCodeValue(String key);
}
