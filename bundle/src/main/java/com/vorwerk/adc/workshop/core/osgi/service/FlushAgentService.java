/**
* Copyright (c)  Vorwerk POC
* Program Name :  FlushAgentService.java
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

package com.vorwerk.adc.workshop.core.osgi.service;

/**
 * @author 554666
 *
 */
import org.apache.sling.api.SlingHttpServletRequest;
public interface FlushAgentService {
	
	public void  createFlushAgent(String ip,SlingHttpServletRequest request);
	
	public void  deleteFlushAgent(String ip,SlingHttpServletRequest request);

}
