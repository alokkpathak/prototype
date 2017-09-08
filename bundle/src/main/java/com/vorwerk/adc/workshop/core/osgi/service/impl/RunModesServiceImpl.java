/**
* Copyright (c)  Vorwerk POC
* Program Name :  RunModesServiceImpl.java
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

package com.vorwerk.adc.workshop.core.osgi.service.impl;

import com.vorwerk.adc.workshop.core.osgi.service.RunModesService;
import org.apache.felix.scr.annotations.Activate;
import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.Service;
import org.apache.sling.commons.osgi.PropertiesUtil;
import org.apache.sling.settings.SlingSettingsService;
import org.osgi.service.component.ComponentContext;

/**
 * @author 554666
 *
 */
@Component(immediate = true, metatype = true, label = "ADC-FSL - Run mode service",
description = "Utility service to deal with specific usages of run modes")
@Service
public class RunModesServiceImpl implements RunModesService {

private final static String MASTER_RUN_MODE_DEFAULT = "www01";
private static final String CQ_RUN_MODE_PUBLISH_INSTANCE = "publish";
private static final String CQ_RUN_MODE_AUTHOR_INSTANCE = "author";

// Properties
@Property(label = "Master run mode", description = "Name of run mode use to define which instance is the \"master\" one",
    value = MASTER_RUN_MODE_DEFAULT)
protected static final String MASTER_RUN_MODE = "masterRunMode";
protected String masterRunMode;

@Reference
private SlingSettingsService slingSettingsService;

@Activate
public void activate(ComponentContext ctx) {
masterRunMode = PropertiesUtil.toString(ctx.getProperties().get(MASTER_RUN_MODE), MASTER_RUN_MODE_DEFAULT);
}

@Override
public String getMasterRunMode() {
return masterRunMode;
}

@Override
public boolean isPublish() {
return slingSettingsService.getRunModes().contains(CQ_RUN_MODE_PUBLISH_INSTANCE);
}

@Override
public boolean isAuthor() {
return slingSettingsService.getRunModes().contains(CQ_RUN_MODE_AUTHOR_INSTANCE);
}

@Override
public boolean isMaster() {
return slingSettingsService.getRunModes().contains(getMasterRunMode());
}

@Override
public boolean isPublishAndMaster() {
return isPublish() && isMaster();
}

@Override
public boolean isRunModesActive(String[] modes) {
if (modes == null) {
    return false;
}

boolean active = true;

for (String mode : modes) {
    active = active && slingSettingsService.getRunModes().contains(mode);
}

return active;
}
}

