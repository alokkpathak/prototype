/**
* Copyright (c)  Vorwerk POC
* Program Name :  RestServiceUrlImpl.java
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

package com.vorwerk.adc.workshop.core.osgi.service.impl;

import java.util.Dictionary;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.PatternSyntaxException;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Service;
import org.apache.sling.commons.osgi.PropertiesUtil;
import org.osgi.service.component.ComponentContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.vorwerk.adc.workshop.core.osgi.service.RestServiceUrl;

@Component(immediate = false, metatype = true, label = "ADC Workshop - Rest Service Urls", description = "Rest urls for all the app services. " )
@Service(value = RestServiceUrl.class)
public class RestServiceUrlImpl implements RestServiceUrl 
{
	private static final Logger log = LoggerFactory.getLogger(RestServiceUrlImpl.class);
	
	private static final String DELIMITER = "::";
	
	private static final String PROPERTY_APP_URL_MAPPING_KEY = "adc.workshop.url.mapping";     
	@Property(name = PROPERTY_APP_URL_MAPPING_KEY,
            label = "App Rest url mapping",
            description = "This maps the function key to url prefixes. EG:Login::/AdcWebApp/service/adc/login",
            value = {"product::http://localhost:8080/adcWebApp/adcWorkshop/product/"
			,"login::http://localhost:8080/adcWebApp/adcWorkshop/login","http://localhost:8080/adcWebApp/adcWorkshop/registeration"})
    private String[] appUrlMapping ;
	
	
	
	Map<String, String > appurlMap = new HashMap<String, String >();
	
	
	protected final void activate(ComponentContext ctx) 
	{
		Dictionary<?, ?> props = ctx.getProperties();		
		
		this.appUrlMapping 	= PropertiesUtil.toStringArray(props.get(PROPERTY_APP_URL_MAPPING_KEY));
		
		log.info("REST SERVICE URLS--------->>> "+this.appUrlMapping);
		setUrlPrefixMappingToMap(this.appUrlMapping);
	}
	
	/**
	 * This method is responsible for separating the key and service url based on the delimiter.
	 * @param prefixArr String[] of service urls
	 */
	private void setUrlPrefixMappingToMap(String[] prefixArr)
	{
		if( prefixArr != null )
		{
			for(String urlPrefix : prefixArr)
         	{  
				if(urlPrefix.contains(DELIMITER))
				{
					try{
						String[] keyVal = urlPrefix.split("::");
						String key 		= keyVal[0];
						String value 	= keyVal[1];
						log.info("REST SERVICE Key------->>> "+key);
						log.info("REST SERVICE Value------->>> "+value);
						appurlMap.put(key , value);
					}
					catch(PatternSyntaxException pse){
						log.error("Unable to parse urlPrefix from Rest Service Impl - " + pse);
					}
				}
				else
				{
					log.warn("NO DELEMETERS PROVIDED FOR SERVICE URL -------->>> ");
				}
         	}
		}
	}

	@Override
	public String getUrl(String key) 
	{
		String retVal = null;
		if( key != null && appurlMap.size() > 0)
		{
			retVal = appurlMap.get(key);
		}
		return retVal;
	}
}
