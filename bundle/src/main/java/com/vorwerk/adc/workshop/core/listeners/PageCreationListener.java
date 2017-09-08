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

package com.vorwerk.adc.workshop.core.listeners;

import java.util.Iterator;
import java.util.Set;

import javax.jcr.Node;
import javax.jcr.RepositoryException;
import javax.jcr.Session;
import javax.jcr.observation.Event;
import javax.jcr.observation.EventIterator;
import javax.jcr.observation.EventListener;
import javax.jcr.observation.ObservationManager;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.sling.api.resource.ResourceResolverFactory;
import org.apache.sling.commons.osgi.PropertiesUtil;
import org.apache.sling.jcr.api.SlingRepository;
import org.apache.sling.settings.SlingSettingsService;
import org.osgi.service.component.ComponentContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.day.cq.tagging.JcrTagManagerFactory;

@Component(immediate=true, enabled=true, metatype=true, label="ADC FSL : PAGE Creation Listener")
public class PageCreationListener implements EventListener
{
	private static final Logger log = LoggerFactory.getLogger(PageCreationListener.class);
		 
	@Reference
	private SlingSettingsService settingsService;
	
	@Reference
    private SlingRepository repository;
 
    @Reference
    JcrTagManagerFactory tmf;
	
    @Reference
    protected ResourceResolverFactory resourceResolverFactory;
    
	 private Session session;
	 private ObservationManager observationManager;
	
	 @Property(name="adc.page.creation.event.path", label="Page Creation event path", description="Condition that the URI must meet before creating the page.")
	 public static final String DEFAULT_PAGE_CREATION_EVENT_PATH = "/content/adc/fsl/countries";
	 
	 	 
	 private String matchPath;
		 
	 private static final String AUTHOR = "author";
	 
     protected void activate(ComponentContext context) {
    	 if(log.isDebugEnabled()){
    		 log.debug("Added JCR event listener - PageTaggingListener"); 
    	 }
		 try{
			 session = repository.loginAdministrative(null);
			 observationManager = session.getWorkspace().getObservationManager();
	 
			 isAuthorMode();
		 
			 if(isAuthorMode())
			 {
				 observationManager.addEventListener(this, Event.NODE_ADDED, "/content/adc/fsl/countries", true, null, null, true);
			 }
			 matchPath =  PropertiesUtil.toString(context.getProperties().get("adc.page.creation.event.path"), DEFAULT_PAGE_CREATION_EVENT_PATH) ;
		 }
		 catch (RepositoryException re){
			 log.error("Error initializing the JCR event listener - PageCreationListener", re);
		 }	
     }
	 
    protected void deactivate(ComponentContext componentContext) {
        try {
            if (observationManager != null) {
                observationManager.removeEventListener(this);
                log.debug("Removed JCR event listener - PageCreationListener");
            }
            if( resourceResolverFactory != null)
            {
            	resourceResolverFactory = null;
            }
        } catch (RepositoryException re) {
        	log.error("Error removing the JCR event listener - PageCreationListener", re);
        } finally {
            if (session != null) {
                session.logout();
                session = null;
            }
        }
    }
	  
    
	@Override
	public void onEvent(EventIterator events) 
	{
		try
		{
			 if(isAuthorMode())
			 {
				 if (events.hasNext()) 
				 {
		                Event event = events.nextEvent();
		                String path =  event.getPath();
		                if(log.isDebugEnabled()){
		                	log.debug("PageCreationListener ############### new add event: "+ path);
		                }		                       
		               
		                if(path != null &&  path.startsWith(matchPath))
		                {
			                Node pageContentNode = session.getNode(event.getPath());
			                
			                if (pageContentNode.getPrimaryNodeType().isNodeType("cq:Page") 
			                							&& pageContentNode.hasNode("jcr:content")) 
			                {
			                	 log.info("pageContentNode NODE PATH IS PAGE:::::::::::::::::::: "+pageContentNode.getPath());	
			                	
			                	Node contentNode = pageContentNode.getNode("jcr:content");
				                if (contentNode != null) 
				                {
				                	
				                	log.info("contentNode.hasProperty(jcr:title):::::::::::::::::::: "+contentNode.hasProperty("jcr:title"));				                	
				                	contentNode.setProperty("changefreq", "DAILY");
				                	contentNode.setProperty("priority", 0.5d);				                			                	
				                	session.save();
				                }
			                }			               
		                }
		                else
		                {
		                	log.info("EVENT did not match path criteria %%%%%%%%%%%%%%%%%%%%%%%%%% ");
		                }
				 }
			 }
		}
		catch(Exception e)
		{
			log.error("Unable to handle event {} ", e);
		}
	}

		
	private boolean isAuthorMode() 
    {
		boolean retVal = false;
    	if(settingsService != null )
    	{
	    	Set<String> runModes = settingsService.getRunModes();
			if(runModes != null) {
				String currentRunMode = "";
				Iterator<String> runIt = runModes.iterator();
				while(runIt.hasNext()) {
					currentRunMode = runIt.next();
					if(currentRunMode.toLowerCase().equals(AUTHOR)){
						retVal = true;
					}					
				}
			}
    	} 
    	return retVal;
    }
	
}
