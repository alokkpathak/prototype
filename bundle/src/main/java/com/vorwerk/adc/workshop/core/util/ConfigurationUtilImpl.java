/**
* Copyright (c)  Vorwerk POC
* Program Name :  ConfigurationUtilImpl.java
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

import java.io.IOException;
import java.util.Dictionary;
import java.util.HashMap;
import java.util.Map;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.ReferencePolicy;
import org.apache.felix.scr.annotations.Service;
import org.osgi.service.cm.Configuration;
import org.osgi.service.cm.ConfigurationAdmin;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


@Component
@Service
public class ConfigurationUtilImpl implements ConfigurationUtil {
	
	@Reference(cardinality = ReferenceCardinality.MANDATORY_UNARY, policy = ReferencePolicy.STATIC)
	private ConfigurationAdmin configAdmin;
	private Configuration conf = null;
	private static final Logger log = LoggerFactory.getLogger(ConfigurationUtilImpl.class);
	
	/*
	 * (non-Javadoc)
	 * @see com.vorwerk.adc.workshop.core.util.ConfigurationUtil#getConfig(java.lang.String, java.lang.String)
	 */
	public String getConfig(String pid,String property)
	{
		try {
			if(configAdmin!=null){
				conf = configAdmin.getConfiguration(pid);
				if(conf!=null){
					if(null!=conf.getProperties() && null!=conf.getProperties().get(property)){
						return conf.getProperties().get(property).toString();
					}
				}
			} else {
				log.error("Configuration for pid "+pid+" is Null");
			}			
		} 
		catch (IOException e) 
		{			
			log.error("Error fetching the Osgi property value for the given pid"+pid, e);
		}
		return null;
	}
	
	/*
	 * (non-Javadoc)
	 * @see com.vorwerk.adc.workshop.core.util.ConfigurationUtil#getConfig(java.lang.String, java.lang.String[])
	 * 
	 */
	public Map<String,String> getConfig(String pid,String[] properties)
	{
		HashMap<String,String> configMap = null;
		try {
			if(configAdmin!=null){
				conf = configAdmin.getConfiguration(pid);
				log.info("Config Object :::::::::::::::>>> " +conf);
				if(conf!=null){
					if( properties != null )
					{
						Dictionary dict = conf.getProperties();
						configMap = new HashMap<String,String>();
						for(int ii = 0; ii < properties.length; ii++)
						{
							log.info("Config Object property :::::::::::::::>>> " +properties[ii]);
							log.info("Config Object Dict :::::::::::::::>>> " +dict);
							if(null!=dict && null!=dict.get(properties[ii])){
								configMap.put(properties[ii], dict.get(properties[ii]).toString()) ;
							}
						}
					}
				}
			} else {
				log.error("Configuration for pid "+pid+" is Null");
			}			
		} 
		catch (IOException e) 
		{			
			log.error("Error fetching the Osgi property value for the given pid"+pid, e);
		}
		return configMap;
	}

	/*
	 * (non-Javadoc)
	 * @see com.vorwerk.adc.workshop.core.util.ConfigurationUtil#getConfig(String pid, String property, String key)
	 * 
	 */
	public String getConfig(String pid, String property, String key) 
	{
		try 
		{
			String retVal = null;
			
			if(configAdmin!=null){
				conf = configAdmin.getConfiguration(pid);
				if(conf!=null){
					if(null!=conf.getProperties() && null!=conf.getProperties().get(property))
					{
						String[] prefixArr = (String[])conf.getProperties().get(property);
						
						for(String urlPrefix : prefixArr)
			         	{         		
			         		String[] keyVal = urlPrefix.split("::");
			         		if(keyVal[0].equalsIgnoreCase(key))
			         		{
			         			retVal = keyVal[1];
			         			break;
			         		}
			         	}
						log.info("REST SERVICE Value::::::::: "+retVal);
						return retVal;
					}
				}
			} 
			else 
			{
				log.error("Configuration for pid "+pid+" is Null");
			}			
		} 
		catch (IOException e) 
		{			
			log.error("Error fetching the Osgi property value for the given pid"+pid, e);
		}
		return null;
	}

	/*
	 * (non-Javadoc)
	 * @see com.vorwerk.adc.workshop.core.util.ConfigurationUtil#getConfigPropArr(String pid, String property)
	 * 
	 */
	public String[] getConfigPropArr(String pid, String property) 
	{
		try 
		{
			String[] retVal = null;
			
			if(configAdmin!=null){
				conf = configAdmin.getConfiguration(pid);
				if(conf!=null){
					if(null!=conf.getProperties() && null!=conf.getProperties().get(property))
					{
						retVal = (String[])conf.getProperties().get(property);
						log.info("REST SERVICE Value::::::::: "+retVal);
						return retVal;
					}
				}
			} else {
				log.error("Configuration for pid "+pid+" is Null");
			}			
		} 
		catch (IOException e) 
		{			
			log.error("Error fetching the Osgi property value for the given pid"+pid, e);
		}
		return null;
	}
}
