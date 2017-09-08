/**
* Copyright (c)  Vorwerk POC
* Program Name :  GlobalSettingsMappingImpl.java
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  file to get global settings like country domain url, init script for analytics
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
* -----------                         ----------------                                    -------------------------
* 24-Sep-2016                  Cognizant Technology solutions            					Initial Creation
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

import com.vorwerk.adc.workshop.core.osgi.service.GlobalSettingsMapping;

@Component(immediate = false, metatype = true, label = "ADC Workshop - Global Settings Mapping", description = "Global settings" )
@Service(value = GlobalSettingsMapping.class)
public class GlobalSettingsMappingImpl implements GlobalSettingsMapping
{

	private static final Logger log = LoggerFactory.getLogger(GlobalSettingsMappingImpl.class);
	
	private static final String PROPERTY_GLOBAL_SETTINGS_MAPPING_KEY = "adc.webshop.globalproperties.mapping";     
	@Property(name = PROPERTY_GLOBAL_SETTINGS_MAPPING_KEY,
            label = "Global Settings mapping",
            description = "This maps the global properties."
            )
	private static final String PROPERTY_GLOBAL_SETTINGS_ANALYTICS_KEYS = "adc.webshop.global.analytics.gtmscripts";     
	@Property(name = PROPERTY_GLOBAL_SETTINGS_ANALYTICS_KEYS,
            label = "Global Settings analytics mapping",
            description = "This maps the global keys for analytics."
            )

	private String[] propertyGlobalMapping ;
	private String[] propertyAnalyticsMapping ;
	
	private static final String WEBSITE_PATH_PROPERTY = "adc.webshop.global.site.regex";
	private static final String DEFAULT_WEBSITE_PATH = "/content/adc/fsl/(countries|global)/([^/]+)/([^/]+)/.*$";
	@Property(name = WEBSITE_PATH_PROPERTY,
            label = "Regex Website  Path ",
            description = "Regex for the default path to the website pages.",
            value = DEFAULT_WEBSITE_PATH)
    private String websiteSiteRegex = DEFAULT_WEBSITE_PATH;
	
	private static final String PRODUCT_PATH_PROPERTY = "adc.webshop.global.product.path";
	@Property(name = PRODUCT_PATH_PROPERTY,
            label = "Product root Path ",
            description = "Path to the product page root folder Eg: /content/adc/fsl/global/gb/en/libre/products.",
            value ={"gb_en::/content/adc/fsl/{0}/{1}/{2}/libre/products","it_it::/content/adc/fsl/{0}/{1}/{2}/libre/prodotti"})
    private String[] productPathArr;
	
	private static final String PRODUCT_IMG_NODE_PROPERTY = "adc.webshop.global.product.node.suffix";
	private static final String DEFAULT_PRODUCT_IMG_NODE = "/jcr:content/product_par_main/selectProductImages/prodimage1_1";
	@Property(name = PRODUCT_IMG_NODE_PROPERTY,
            label = "Product image node suffix ",
            description = "Suffix Path to the product image node.",
            value = DEFAULT_PRODUCT_IMG_NODE)
    private String productImgPathSuffix = DEFAULT_PRODUCT_IMG_NODE;
	
	Map<String, String > globalPropertiesMap = new HashMap<String, String >();
	
	Map<String, String > productPathMap = new HashMap<String, String >();
	
	protected final void activate(ComponentContext ctx) 
	{
		Dictionary<?, ?> props = ctx.getProperties();		
		
		this.propertyGlobalMapping 	= PropertiesUtil.toStringArray(props.get(PROPERTY_GLOBAL_SETTINGS_MAPPING_KEY));
		this.propertyAnalyticsMapping 	= PropertiesUtil.toStringArray(props.get(PROPERTY_GLOBAL_SETTINGS_ANALYTICS_KEYS));
		
		log.info("PROPERTY_GLOBAL_SETTINGS_MAPPING ::::::::: "+this.propertyGlobalMapping);
		setUrlPrefixMappingToMap(this.propertyGlobalMapping);
		setUrlPrefixMappingToMap(this.propertyAnalyticsMapping);
		
		this.websiteSiteRegex = PropertiesUtil.toString(props.get(WEBSITE_PATH_PROPERTY), DEFAULT_WEBSITE_PATH);
        log.trace("Set website path to " + websiteSiteRegex + ".");
        
        this.productPathArr = PropertiesUtil.toStringArray(props.get(PRODUCT_PATH_PROPERTY));
        log.trace("Set Product path to " + productPathArr + ".");
        setProductPathMapping(productPathArr);
        
        this.productImgPathSuffix = PropertiesUtil.toString(props.get(PRODUCT_IMG_NODE_PROPERTY), DEFAULT_PRODUCT_IMG_NODE);
        log.trace("Set Product Image node path to " + productImgPathSuffix + ".");
	}
	
	private void setUrlPrefixMappingToMap(String[] prefixArr)
	{
		if( prefixArr != null )
		{
			for(String urlPrefix : prefixArr)
         	{         	
				try{
					String[] keyVal = urlPrefix.split("::");
					String key 		= keyVal[0];
					String value 	= keyVal[1];
					log.info("Property Key::::::::: "+key);
					log.info("Property Value::::::::: "+value);
					globalPropertiesMap.put(key , value);
				}
				catch(PatternSyntaxException pse){
					log.error("Unable to parse urlPrefix from global settings impl - " + pse);
				}
         	}
		}
	}
	
	
	private void setProductPathMapping(String[] prefixArr)
	{
		if( prefixArr != null )
		{
			for(String urlPrefix : prefixArr)
         	{         	
				try{
					String[] keyVal = urlPrefix.split("::");
					String key 		= keyVal[0];
					String value 	= keyVal[1].trim();
					log.info("Property product Key::::::::: "+key);
					log.info("Property product Value::::::::: "+value);
					productPathMap.put(key , value);
				}
				catch(PatternSyntaxException pse){
					log.error("Unable to parse product path settings impl - " + pse);
				}
         	}
		}
	}
	
	@Override
	public String getEnvProperty(String key) 
	{
		String retVal = null;
		
		if(globalPropertiesMap != null )
		{
			retVal = globalPropertiesMap.get(key);
		}
		return retVal;
	}
	
	@Override
	public String getProductPathByRegion(String key) 
	{
		String retVal = null;
		
		if(productPathMap != null )
		{
			retVal = productPathMap.get(key);
		}
		return retVal;
	}
	

	/**
	 * @return the websiteSiteRegex
	 */
	public String getWebsiteSiteRegex() {
		return websiteSiteRegex;
	}

	/**
	 * @param websiteSiteRegex the websiteSiteRegex to set
	 */
	public void setWebsiteSiteRegex(String websiteSiteRegex) {
		this.websiteSiteRegex = websiteSiteRegex;
	}

	

	/**
	 * @return the productImgPathSuffix
	 */
	public String getProductImgPathSuffix() {
		return productImgPathSuffix;
	}

	/**
	 * @param productImgPathSuffix the productImgPathSuffix to set
	 */
	public void setProductImgPathSuffix(String productImgPathSuffix) {
		this.productImgPathSuffix = productImgPathSuffix;
	}


}
