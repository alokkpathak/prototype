package com.vorwerk.adc.workshop.core.tags;

import java.io.IOException;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.MatchResult;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.jcr.Node;
import javax.jcr.Property;
import javax.jcr.Session;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;

import org.apache.sling.api.resource.Resource;
import org.apache.sling.api.resource.ResourceResolver;
import org.apache.sling.api.scripting.SlingScriptHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.vorwerk.adc.workshop.core.osgi.service.GlobalSettingsMapping;
import com.vorwerk.adc.workshop.core.osgi.service.RunModesService;
import com.vorwerk.adc.workshop.core.exception.AdcFslException;
import com.day.cq.wcm.api.Page;

public class ImageSkuQueryTag extends CQBaseTag 
{
	 private static final Logger log = LoggerFactory.getLogger(ImageSkuQueryTag.class);
	
	 private String var; 
	 public void doTag() throws JspException, IOException 
	 {
        log.debug("Start doTag -----------> ");
       
        List<Map<String, String>> skuImageMap = new ArrayList<Map<String, String>>();
        try
        {
	        ResourceResolver resourceResolver = (ResourceResolver) findPageContextAttribute(RESOURCE_RESOLVER);
			
			if( resourceResolver != null )
			{
				Page currentPage = (Page)findPageContextAttribute("currentPage");
			    String reqUrl = currentPage.getPath();
			    SlingScriptHelper sling = getSlingHelper();
			    GlobalSettingsMapping globalMapping = sling.getService(com.vorwerk.adc.workshop.core.osgi.service.GlobalSettingsMapping.class);
			    
			    String websitePattern = globalMapping.getWebsiteSiteRegex();
			    String imageSuffux    = globalMapping.getProductImgPathSuffix();
			    
				String finalProdPath = getRegionCodeFromUrl(reqUrl, websitePattern, globalMapping);
				 log.info("finalProdPath Path ::::>>>>>>>>>>>>>>> "+finalProdPath );
				Session jcrSession = resourceResolver.adaptTo(Session.class);
				if( jcrSession != null && finalProdPath != null)
				{									
					Node prodNode = jcrSession.getNode(finalProdPath);										
					if( checkIsPage(prodNode) )
					{
						String pagePath =  prodNode.getPath();
	                    log.info("Root Path ::::>>>>>>>>>>>>>>> "+pagePath );
	                    Resource pgResource = resourceResolver.getResource(pagePath);
	                    
	                    if( pgResource != null   )
	                    {
	                    	Page pg = pgResource.adaptTo(Page.class);
	                    	if( pg != null && pg.listChildren() != null )
	                    	{
	                    		Iterator<Page> pageIter = pg.listChildren();
	                    		Map<String, String> skuimageListMap = null;
	                    		while(pageIter.hasNext())
	                    		{
	                    			Page childpg = pageIter.next();	                    			 
	                    			if(childpg != null )
	                    			{
	                    				String childPgpath = childpg.getPath();
	                    				 log.info("childpg Path Str ::::>>>>>>>>>>>>>>> "+childPgpath );
	                    				 Resource childPgResource = resourceResolver.getResource(childPgpath+"/jcr:content/product_par_main");
	                    				 
	                    				 if(childPgResource != null )
	                    				 {
		                    				 Node clildNode = childPgResource.adaptTo(Node.class);
		                    				 String skuid = "";
		                    				 String img = "";
		                    				 String mobileImg = "";
		                    				 String viewURL = "";
		                    				 if( clildNode != null )
		                    				 {
		                    					 Property prop = clildNode.getProperty("skuId");
		                    					 if( prop != null )
		                    					 {
		                    						 skuid = prop.getString();
		                    						 log.info("childpg PROPERTY SKU ID ::::>>>>>>>>>>>>>>> "+skuid );		                    						
		                    					 }
		                    					
		                    					 Property viewitemurl = clildNode.getProperty("redirectionUrltoviewProduct");
		                    					 if(viewitemurl != null)
		                    					 {
		                    						 viewURL = viewitemurl.getString();
		                    						
		                    						 viewURL = getMinifiedUrl(viewURL);
		                    						 		                    						 
		                    						 log.info("childpg PROPERTY viewITEMURL ::::>>>>>>>>>>>>>>> "+viewURL );
		                    					 }

		                    					 Resource imgResource = resourceResolver.getResource(childPgpath+imageSuffux);
		                    					 if( imgResource != null)
		                    					 {
		                    						 Node imageNode = imgResource.adaptTo(Node.class);
		                    						 
		                    						 if(imageNode != null )
		                    						 {
		                    							 if(imageNode.hasProperty("imagePathDesktop"))
		                    							 {
		                    								 Property imgDeskprop = imageNode.getProperty("imagePathDesktop");
		                    								 if(imgDeskprop != null )
		                    								 {
		                    									 img = imgDeskprop.getString();
		                    									 log.info("imgDeskprop PROPERTY IMAGE PATH ::::>>>>>>>>>>>>>>> "+img );	
		                    								 }
		                    							 }
		                    							 if(imageNode.hasProperty("imagePathMobile"))
		                    							 {
		                    								 Property imgMobprop = imageNode.getProperty("imagePathMobile");
		                    								 if(imgMobprop != null )
		                    								 {
		                    									 mobileImg = imgMobprop.getString();
		                    									 log.info("mobileImg PROPERTY IMAGE PATH ::::>>>>>>>>>>>>>>> "+mobileImg );	
		                    								 }
		                    							 }
		                    						 }
		                    					 }
		                    					 
		                    					 skuimageListMap = new HashMap<String, String>();
		                    					 
		                    					 skuimageListMap.put("skuid", skuid);
		                    					 skuimageListMap.put("img", img);
		                    					 skuimageListMap.put("mobileImg", mobileImg);
		                    					 skuimageListMap.put("viewURL", viewURL);
		                    					 skuImageMap.add(skuimageListMap);
		                    					 
		                    				 }
	                    				 }	                    			
	                    			}
	                    		}
	                    	}
	                    }
		            }
				}				
			}
        }
        catch(Exception e )
        {
        	log.error("Exception executing the tag to fetch product image >>>>>>>> ",e);
        }
        log.info("skuImageMap >>>>>>>>>>>>>>>>>>>>>>>>> "+skuImageMap);
		getJspContext().setAttribute(var, skuImageMap , PageContext.REQUEST_SCOPE);

        log.debug("End doTag");
     }
	 
	 
	 private String getRegionCodeFromUrl(String reqUrl , String siteRegex , GlobalSettingsMapping globalMapping)
	 {
		 log.info("SITE REGEX ::::::::::>>>>>>>>>>>>>>>>>>> "+siteRegex);
		 log.info("SITE globalMapping ::::::::::>>>>>>>>>> "+globalMapping);

		 String finalUrl = null;
		 if(reqUrl != null )
		 {
			 log.debug("getSlingRequest().getRequestURI() ============> "+reqUrl);
			 Pattern urlpattern = Pattern.compile( siteRegex);
			 if(urlpattern.matcher(reqUrl).matches())
			 {
				 Matcher m = urlpattern.matcher(reqUrl);
				 while (m.find()) 
				 {
						MatchResult mr = m.toMatchResult();
						
						log.debug("GROUP 0 ---->"+mr.group(0));
						log.info("GROUP 1 ---->"+mr.group(1));
						String country = mr.group(1);
						log.info("GROUP 2 ---->"+mr.group(2));
						String countryCode = mr.group(2);
						log.info("GROUP 3 ---->"+mr.group(3));
						String language = mr.group(3);
						if( countryCode != null && language != null )
						{
							finalUrl = globalMapping.getProductPathByRegion(countryCode+"_"+language);
							log.info("PROD URL BEFORE TRANSFORMATION ---->"+finalUrl);
							finalUrl = getUpdatedUrl(finalUrl , country, countryCode,language);
						}
						
						log.info("TRAN SFORMED URL ---->"+finalUrl);
				}
			 }
		 }
		 return finalUrl;
	 }
	 
	 public String getUpdatedUrl(String serviceUrl, Object... params  ) 
	 {
	   String retVal = null;
       try 
       {
    	   if(serviceUrl != null && params != null)
    	   {
    		   retVal = MessageFormat.format(serviceUrl, params);
    	   }
       } 
       catch (Exception e) {
         log.error("Unable to format url --------------> ",e);
       }
       return retVal;
   }
	 
	 private boolean checkIsPage( Node prodNode) throws AdcFslException
	 {
		boolean retVal = false;
		try{
		 if(prodNode != null && prodNode.hasProperty("jcr:primaryType") 
					&& "cq:Page".equals(prodNode.getPrimaryNodeType().getName()))
		 {
		 	retVal = true;
		 }
		}
		catch(javax.jcr.RepositoryException re)
		{
			log.error("Unable to check is page --------------> ",re);
			throw new AdcFslException(re, "Unable to check is page");
		}
		return retVal;
	 }

	/**
	 * @return the var
	 */
	public String getVar() {
		return var;
	}

	/**
	 * @param var the var to set
	 */
	public void setVar(String var) {
		this.var = var;
	}
	
	
	public String getMinifiedUrl(String url) throws JspException, IOException 
	 {
       log.debug("Start getMinifiedUrl");
		String minifiedUrl="";
		SlingScriptHelper sling = getSlingHelper();
		RunModesService runModesService = sling.getService(com.vorwerk.adc.workshop.core.osgi.service.RunModesService.class);
		
		if(null != url && null != runModesService){
			if(runModesService.isPublish())
			{     
				minifiedUrl= getSlingRequest().getResourceResolver().map(url);
			}
			else if(runModesService.isAuthor())
			{
				minifiedUrl = url;
			}
			log.info("ViewBasket URL -------------------- "+minifiedUrl);
		}
		else
		{
			log.debug("Invalid URL/Run mode configuration -------------------- "+url);
		}
       log.debug("End doTag");
       
       return minifiedUrl;
    }
	 SlingScriptHelper getSlingHelper() {
		 return (SlingScriptHelper) getJspContext().getAttribute("sling");
	 }	 
}
