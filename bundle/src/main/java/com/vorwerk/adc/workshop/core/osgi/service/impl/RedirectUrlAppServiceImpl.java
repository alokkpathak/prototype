/**
* Copyright (c)  Vorwerk POC
* Program Name :  RedirectUrlAppServiceImpl.java
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
* -----------                         ----------------                                    -------------------------
* 20-NOV-2016                  Cognizant Technology solutions            					Initial Creation
* -----------                         -----------------                                   -------------------------
**/

package com.vorwerk.adc.workshop.core.osgi.service.impl;

import java.util.Dictionary;
import java.util.HashMap;
import java.util.Map;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Service;
import org.apache.sling.commons.osgi.PropertiesUtil;
import org.osgi.service.component.ComponentContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.vorwerk.adc.workshop.core.osgi.service.RedirectUrlAppService;

@Component(immediate = false, metatype = true, label = "ADC Workshop - Redirect Url Application Service", description = "Application Redirect urls. " )
@Service(value = RedirectUrlAppService.class)
public class RedirectUrlAppServiceImpl implements RedirectUrlAppService 
{
	private static final Logger log = LoggerFactory.getLogger(RestServiceUrlImpl.class);
	
	private static final String DELIMITER = "::";
	
	private static final String PROPERTY_APP_URL_MAPPING_KEY = "adc.workshop.redirect.url.mapping";     
	@Property(name = PROPERTY_APP_URL_MAPPING_KEY,
            label = "Redirect url mapping",
            description = "This maps the redirect urls based on the operation and country key. EG:orderdetail::/content/adc/fsl/countries{/gb/en/}libre/account-overview.html",
            value = {"signin_en_GB::/content/adc/fsl/countries{0}libre/sign-in.html?id={1}&opr={2}&idx=1"
			,"signin_it_IT::/content/adc/fsl/countries{0}libre/registrati.html?id={1}&opr={2}&idx=1"
			,"orderdetails_en_GB::/content/adc/fsl/countries{0}libre/account-overview.html?oid={1}&idx=1"
			,"orderdetails_it_IT::/content/adc/fsl/countries{0}libre/il-tuo-conto.html?oid={1}&idx=1"
			,"errorpage::/content/adc/fsl/countries{0}libre/utilities/errors/unauthorized.html"})
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
	         		String[] keyVal = urlPrefix.split("::");
	         		String key 		= keyVal[0];
	         		String value 	= keyVal[1].trim();
	         		log.info("REST SERVICE Key------->>> "+key);
	         		log.info("REST SERVICE Value------->>> "+value);
	         		appurlMap.put(key , value);
				}
				else
				{
					log.warn("NO DELEMETERS PROVIDED FOR REDIRECT SERVICE URL -------->>> ");
				}
         	}
		}
	}

	@Override
	public String getRedirectUrl(String key) 
	{
		String retVal = null;
		if( key != null && appurlMap.size() > 0)
		{
			retVal = appurlMap.get(key);
		}
		return retVal;
	}
}
