/**
* Copyright (c)  Vorwerk POC
* Program Name :  AlternateLangUtil.java
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  this class is used to generate list of alternate urls for a given blueprint source and locale
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
* -----------                         ----------------                                    -------------------------
* 28-Nov-2016                  Cognizant Technology solutions            					Initial Creation
* -----------                         -----------------                                   -------------------------
**/
package com.vorwerk.adc.workshop.core.util;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.felix.scr.annotations.Activate;
import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.Service;
import org.apache.sling.api.resource.Resource;
import org.apache.sling.api.resource.ResourceResolver;
import org.apache.sling.api.resource.ResourceUtil;
import org.apache.commons.lang.StringUtils;
import org.osgi.framework.Constants;
import org.osgi.service.component.ComponentContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.day.cq.wcm.api.Page;
import com.day.cq.wcm.msm.api.LiveRelationship;
import com.day.cq.wcm.msm.api.LiveRelationshipManager;





@Service(AlternateLangUtil.class)
@Component(immediate = true, enabled = true, metatype = true, name = "com.vorwerk.adc.workshop.core.util.AlternateLangUtil", label = "AlternateLangUtil")
@Properties({@Property(
        name = Constants.SERVICE_DESCRIPTION, value = "AlternateLangUtil Service"),
        @Property(name = Constants.SERVICE_VENDOR, value = "Vorwerk") })
public class AlternateLangUtil {

	@Reference
    private LiveRelationshipManager liveRelManager;
	
	private static final Logger logger = LoggerFactory.getLogger(AlternateLangUtil.class);
	 
	 @Activate
	 protected final void activate(final ComponentContext componentContext) {
		 logger.info("AlternateLangUtil activated.");
		 
	 }
	 
	/*
	 * Returns a list of alternate Urls for a given blueprint source and locale
	 */
	public Map<String,String> getAlternateUrls(ResourceResolver resolver, String jcrPagePath, String[] propertyArr) {
		logger.info("getAlternateUrls called for jcrPagePath [" + jcrPagePath + "].");
		
		String bluePrintSource = null;
		Map<String,String> liveRelationsMap=new HashMap<String,String>();
		List<String> liveRelationsList=new ArrayList<String>();
		
		try {
			Page jcrPage = resolver.getResource(jcrPagePath).adaptTo(Page.class);
			LiveRelationship liveRelationship = this.liveRelManager.getLiveRelationship(jcrPage.getContentResource(), false);
			// if liveRelationship null, then this page isn't a blueprint
			if(liveRelationship != null) {
				bluePrintSource = liveRelationship.getSourcePath();
			}
			else {
				logger.info("No blueprint source found for the requested jcrPagePath [" + jcrPagePath + "].");
				return liveRelationsMap;
			}
			
		}
		catch(Exception ex) {
			logger.error("Error getting reference to jcrPage or liveRelationship.  Or failed to get bluePrintSource.  Unable to return altUrls." );
			return liveRelationsMap;
		}	    		

		String JCR_CONTENT="/jcr:content";
		int jcrContentIndex=bluePrintSource.indexOf(JCR_CONTENT);
		if(jcrContentIndex>0){
			bluePrintSource = bluePrintSource.substring(0,jcrContentIndex);	
			 
		}
		logger.info("blue print is  "+bluePrintSource);
		Resource source = resolver.getResource(bluePrintSource);
		boolean isSource = liveRelManager.isSource(source);
		logger.info("source flag is  "+isSource);
		if (isSource) {
			try {
				logger.info("inside try "+isSource);
				javax.jcr.RangeIterator liveRelationIterator=liveRelManager.getLiveRelationships(source, null,null);
				 while(liveRelationIterator.hasNext())
				 {
					LiveRelationship  liveRelationship = (LiveRelationship)liveRelationIterator.next();
					liveRelationsList.add(liveRelationship.getTargetPath());
				 }
				logger.info("liveRelationsList "+liveRelationsList);	
				liveRelationsMap=buildRelationshipList(liveRelationsList,jcrPagePath,resolver,propertyArr);
			} catch (Exception e) {
				logger.error("Error getting reference to jcrPage or liveRelationship.  Or failed to get bluePrintSource.  Unable to return altUrls." +e);
			}
		}
		return liveRelationsMap;
	}
	
	private Map<String,String> buildRelationshipList( List<String> liveRelationsList,String jcrPagePath,ResourceResolver resourceResolver,String[] propertyArr)
	{
		int pathLength=StringUtils.split(jcrPagePath, '/').length;
		Map<String,String> liveRelationsMap=new HashMap<String,String>();
		for (String targetURL:liveRelationsList)
		{
			if (StringUtils.split(targetURL,'/').length==pathLength)
			{ 
				logger.info("Resource: "+resourceResolver.getResource(targetURL) +" TargetURL:" + targetURL);
				if(null != resourceResolver.getResource(targetURL)){
					if(Boolean.FALSE.equals(ResourceUtil.isNonExistingResource(resourceResolver.getResource(targetURL)))){
						for(String urlPrefix : propertyArr)
						{   
							String[] keyVal = urlPrefix.trim().split("::");
							if(targetURL.contains(keyVal[0]))
							{
								liveRelationsMap.put(keyVal[1],targetURL); 
							}
						}
					}
				}
			}
		}
		logger.info("This is added to the final Map  -------------------- "+liveRelationsMap); 		
		return liveRelationsMap;
	}
}
