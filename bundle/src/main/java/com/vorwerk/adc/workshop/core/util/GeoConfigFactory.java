package com.vorwerk.adc.workshop.core.util;

import java.util.Dictionary;

import org.apache.felix.scr.annotations.Activate;
import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Modified;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Service;
import org.osgi.service.component.ComponentContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Configuration Factory for Geo Blocker Module.
 * 
 * @author 554666
 * @version 1.0
 */
@Component(metatype = true, label = "Vorwerk FSL  GEO  Configuration Factory", enabled = true, immediate = true, description = "Geo Ip configuration factory for storing the configurable parameters in Felix.")
@Service(value = GeoConfigFactory.class)
@Properties({
		@Property(name = "database.path", value = "", description = "Geo Loction Database Path", label = "Geo Loction Database Path"),
		@Property(name = "license.Path", value = "", description = " Geo Location Database License Path", label = "Geo Location Database License Path"),
		@Property(name = "uk_siteURL", value = "", description = "Geo Loction Uk Site URL", label = "Geo Loction Uk Site URL"),
		@Property(name = "it_siteURL", value = "", description = " Geo Loction It Site URL", label = "Geo Loction It Site URL"),
		@Property(name = "fr_siteURL", value = "", description = " Geo Loction Fr Site URL", label = "Geo Loction Fr Site URL"),

		@Property(name = "uk_site_constant", value = "", description = "UK Site Constant", label = "UK Site Constant"),
		
		@Property(name = "it_site_constant", value = "", description = "It Site Constant", label = "It Site Constant"),
		@Property(name = "fr_site_constant", value = "", description = "FR Site Constant", label = "FR Site Constant"),

		@Property(name = "enablegeolocation", value = "", description = "Boolean value for Geolocation Enablemet ", label = "Boolean value for Geolocation Enablemet "),
		@Property(name = "error_page", value = "", description = " Error Page Path", label = "Error Page path"),
		@Property(name = "group_id_list", value = "", description = "White List Ip ", label = "White List Ip"),
		@Property(name = "ip_regex_list", value = "", description = " Regex List for whitelisted Ip", label = "Regex List for whitelisted Ip"),
		@Property(name = "others_siteURL_uk", value = "", description = "Other Site Redirection For Uk", label = "Other Site Redirection For Uk"),
		@Property(name = "others_siteURL_it", value = "", description = "Other Site Redirection For It", label = "Other Site Redirection For It"),
		@Property(name = "others_siteURL_fr", value = "", description = "Other Site Redirection For Fr", label = "Other Site Redirection For Fr"),

		@Property(name = "safe_user_agents", value = "", description = "Safe User Agent List", label = "Safe User Agent List"),
		@Property(name = "share_site_url", value = "", description = "Shared Site Urls", label = "Shared Site Urls"),
		@Property(name = "sitename", value = "", description = "Site Name", label = "Site Name"),
		@Property(name = "success_page", value = "", description = "Success Redierction Page", label = "Success Redierction Page"),
		@Property(name = "us_ca_siteURL", value = "", description = " Us and Canada Site List", label = "Us and Canada Site List"),
				@Property(name = "mc_siteURL", value = "", description = " MC Site List", label = "MC Site List"),

		  })
public class GeoConfigFactory {
	
	/** Logger Instantiation. */
	private static final Logger LOGGER = LoggerFactory
			.getLogger(GeoConfigFactory.class);

	/** The properties. */
	private static Dictionary<?, ?> properties = null;

	/**
	 * Activate method: re-instantiates the singleton object for config.
	 *
	 * @param componentContext
	 *            the component context
	 */
	@Activate
	protected void activate(final ComponentContext componentContext) {
		LOGGER.info("inside method: activate()");
		properties = componentContext.getProperties();
		LOGGER.info("exiting method: activate()");
	}

	/**
	 * Re-initializes the property map on changes to the config dictionary.
	 * 
	 * @param componentContext
	 */
	@Modified
	protected void modified(final ComponentContext componentContext) {
		LOGGER.info("inside method: modified()");
		properties = componentContext.getProperties();
		LOGGER.info("exiting method: modified()");
	}

	/**
	 * Method to get String property value from config. If property can not be
	 * found or can not be cast to a string, return default string with key.
	 * This will make it apparent if there is some config missing
	 * 
	 * @param key
	 * @return configuration value String
	 */
	public String getStringPropertyValue(String key) {
		GeoConfigFactory.LOGGER.info("inside method: getStringPropertyValue()");
		String property = (String) GeoConfigFactory.properties.get(key);
		GeoConfigFactory.LOGGER
				.info("exiting method: getStringPropertyValue()");
		return property;
	}

	/**
	 * Method to get property value from config.
	 * 
	 * @param key
	 * @return configuration value String
	 */
	public Object getPropertyValue(String key) {
		GeoConfigFactory.LOGGER.info("inside method: getPropertyValue()");
		Object propertyValue = GeoConfigFactory.properties.get(key);
		GeoConfigFactory.LOGGER.info("exiting method: getPropertyValue()");
		return propertyValue;
	}

}
