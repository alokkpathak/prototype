/**
* Copyright (c)  Vorwerk POC
* Program Name :  ConfigurationUtil.java
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
* -----------                         ----------------                                    -------------------------
* 29-Aug-2016                  Cognizant Technology solutions            					Initial Creation
* -----------                         -----------------                                   -------------------------
**/

package com.vorwerk.adc.workshop.core.util;

import java.util.Map;

public interface ConfigurationUtil {
	
	/**
	 * This method returns a single value for the given property
	 * @param pid the osgi component process identifier
	 * @param property the configurable property name 
	 * @return the configured property value
	 */
	public String getConfig(String pid,String property);
	
	/**
	 * This method returns a Map with nested value for the given property
	 * @param pid the osgi component process identifier
	 * @param properties a list of osgi property names
	 * @return an map of property and its values.
	 */
	public Map<String,String> getConfig(String pid,String[] properties);
	
	/**
	 * 
	 * @param pid the osgi component process identifier
	 * @param property the configurable property name 
	 * @param key the property values prefix eg: ADC_Login::/adcWebApp/service/adc/login
	 * @return the property value after the colon( :: )
	 */
	public String getConfig(String pid,String property, String key);
	
	/**
	 * This method returns a value Array for the given property.
	 * @param pid
	 * @param property
	 * @return
	 */
	public String[] getConfigPropArr(String pid, String property);
}
