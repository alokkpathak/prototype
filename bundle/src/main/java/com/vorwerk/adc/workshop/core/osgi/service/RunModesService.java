/**
* Copyright (c)  Vorwerk POC
* Program Name :  RunModesService.java
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
public interface RunModesService {
	public String getMasterRunMode();

    public boolean isPublish();

    public boolean isMaster();

    public boolean isPublishAndMaster();

    public boolean isAuthor();

    public boolean isRunModesActive(final String[] modes);
    

}
