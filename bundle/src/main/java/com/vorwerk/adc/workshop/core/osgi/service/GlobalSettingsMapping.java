/**
* Copyright (c)  Vorwerk POC
* Program Name :  GlobalSettingsMapping.java
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  GlobalSettngsMapping
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
* -----------                         ----------------                                    -------------------------
* 24-Sep-2016                  Cognizant Technology solutions            					Initial Creation
* -----------                         -----------------                                   -------------------------
**/

package com.vorwerk.adc.workshop.core.osgi.service;

public interface GlobalSettingsMapping 
{
	public String getEnvProperty(String key);
	
	/**
	 * @return the websiteSiteRegex
	 */
	public String getWebsiteSiteRegex();

	
	/**
	 * @return the default productPath base on region code
	 */
	public String getProductPathByRegion(String key);

	/**
	 * @return the productImgPathSuffix
	 */
	public String getProductImgPathSuffix();
	
}
