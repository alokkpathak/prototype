/**
* Copyright (c)  Vorwerk POC
* Program Name :  RegionUrlMappingImpl.java
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

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Service;
import org.apache.sling.commons.osgi.PropertiesUtil;
import org.osgi.service.component.ComponentContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.vorwerk.adc.workshop.core.osgi.service.RegionUrlMapping;

@Component(immediate = false, metatype = true, label = "ADC Workshop - Region Url Mapping", description = "Mapping the request url to a region code" )
@Service(value = RegionUrlMapping.class)
public class RegionUrlMappingImpl implements RegionUrlMapping
{

	private static final Logger log = LoggerFactory.getLogger(RegionUrlMappingImpl.class);
	
	private static final String PROPERTY_REGION_URL_MAPPING_KEY = "adc.workshop.region.url.mapping";     
	@Property(name = PROPERTY_REGION_URL_MAPPING_KEY,
            label = "Region url mapping",
            description = "This maps the request url to the appropriate region code. EG:/gb/en/::en_GB",
            value = {"/gb/en/::en_GB","/it/it/::it_IT"})
    private String[] regionUrlMapping ;
	
	private static final String PROPERTY_REGION_DOMAIN_MAPPING_KEY = "adc.workshop.region.domain.mapping";     
	@Property(name = PROPERTY_REGION_DOMAIN_MAPPING_KEY,
            label = "Region domain mapping",
            description = "This maps the region to the appropriate domain. EG:en_GB::libre-dev1-app.freestylelibre.co.uk",
            value = {"en_GB::http://libre-dev1-app.freestylelibre.co.uk","it_IT::http://libre-dev1-app.freestylelibre.it"})
    private String[] regionDomainMapping ;
	
	Map<String, String > regionUrlMap = new HashMap<String, String >();
	
	Map<String, String > regionCodeUrlMap = new HashMap<String, String >();
	
	protected final void activate(ComponentContext ctx) 
	{
		Dictionary<?, ?> props = ctx.getProperties();		
		
		this.regionUrlMapping 	= PropertiesUtil.toStringArray(props.get(PROPERTY_REGION_URL_MAPPING_KEY));
		
		log.info("REGION URL MAPPING ::::::::: "+this.regionUrlMapping);
		setUrlPrefixMappingToMap(this.regionUrlMapping);
		setRegionCodeMap(this.regionUrlMapping);
		
		this.regionDomainMapping 	= PropertiesUtil.toStringArray(props.get(PROPERTY_REGION_DOMAIN_MAPPING_KEY));
		
		setUrlPrefixMappingToMap(this.regionDomainMapping);
	}
	
	private void setUrlPrefixMappingToMap(String[] prefixArr)
	{
		if( prefixArr != null )
		{
			for(String urlPrefix : prefixArr)
         	{  
				if( urlPrefix.contains("::"))
				{
	         		String[] keyVal = urlPrefix.trim().split("::");
	         		String key 		= keyVal[0];
	         		String value 	= keyVal[1];
	         		log.info("REST SERVICE Key::::::::: "+key);
	         		log.info("REST SERVICE Value::::::::: "+value);
	         		regionUrlMap.put(key , value);
				}
				else
				{
					log.error("Invalid urlPrefix Mapping ------------> "+urlPrefix);
				}
         	}
		}
	}
	
	private void setRegionCodeMap(String[] prefixArr)
	{
		if( prefixArr != null )
		{
			for(String urlPrefix : prefixArr)
         	{  
				if( urlPrefix.contains("::"))
				{
	         		String[] keyVal = urlPrefix.trim().split("::");
	         		String key 		= keyVal[0];
	         		String value 	= keyVal[1];
	         		log.info("REST SERVICE Key::::::::: "+key);
	         		log.info("REST SERVICE Value::::::::: "+value);
	         		regionCodeUrlMap.put(value , key);
				}
				else
				{
					log.error("Invalid urlPrefix Mapping ------------> "+urlPrefix);
				}
         	}
		}
	}
	
	@Override
	public String getRegionCode(String key) 
	{
		String retVal = null;
		
		if(regionUrlMap != null && key != null)
		{
			retVal = regionUrlMap.get(key);						
		}
		return retVal;
	}
	
	@Override
	public String getRegionCodeValue(String key) 
	{
		String retVal = null;
		
		if(regionUrlMap != null && key != null)
		{
			retVal = regionCodeUrlMap.get(key);						
		}
		return retVal;
	}
}
