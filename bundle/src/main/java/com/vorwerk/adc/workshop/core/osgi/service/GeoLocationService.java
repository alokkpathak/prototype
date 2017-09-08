/**
* Copyright (c)  Vorwerk POC
* Program Name :  GeoLocationService.java
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
* -----------                         ----------------                                    -------------------------
* 05-Sep-2016                  Cognizant Technology solutions            					Initial Creation
* -----------                         -----------------                                   -------------------------
**/

/**
 *  Interface for fetching country name, to validate the Ip regex patterns and to validate user agent strings
 *
 */
package com.vorwerk.adc.workshop.core.osgi.service;

import org.apache.sling.api.SlingHttpServletRequest;







/**
 * @author 554666
 *
 */
public interface GeoLocationService {

	/**
	 * @param request
	 * @return
	 */
	String getClientIpAddr(SlingHttpServletRequest request);

	/**
	 * @param request
	 * @param searchfilter
	 * @param ipaddress
	 * @return
	 */
	String fetchCountryValuefromIPAdrress(String ipaddress);
	
	boolean validateRegexPattern(String ipaddress, String[] ipRegexList);
	
	boolean validateUserAgent(String userAgentInfo, String[] userAgentStrings);
	
     
	
	

}

