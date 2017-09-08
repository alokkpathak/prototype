package com.vorwerk.adc.workshop.core.servlets;

import java.io.IOException;

import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.sling.SlingServlet;
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.sling.api.servlets.SlingAllMethodsServlet;
import org.apache.commons.lang3.StringEscapeUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.vorwerk.adc.workshop.core.osgi.service.GeoLocationService;
import com.vorwerk.adc.workshop.core.util.GeoConfigFactory;

@SlingServlet(paths = "/bin/adc/fsl/webshop/findmylocation", methods = { "GET" }, metatype = false)
public class FindMyLocationServlet extends SlingAllMethodsServlet {
	
	private static final long serialVersionUID = 1641208274249854400L;
	private final static Logger LOG = LoggerFactory.getLogger(FindMyLocationServlet.class);


	@Reference
	private GeoLocationService geoLocation;

	@Reference
	private GeoConfigFactory configAdmin;

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * org.apache.sling.api.servlets.SlingSafeMethodsServlet#doGet(org.apache.
	 * sling.api.SlingHttpServletRequest,
	 * org.apache.sling.api.SlingHttpServletResponse) Takes the request &
	 * response as input, gets the ip from location servlet & picks either the
	 * clinic or Reps based on the button clicked in the ui
	 */
	@Override
	protected void doGet(SlingHttpServletRequest request, SlingHttpServletResponse response) {

		LOG.info("FindMyLocationServlet --> doGet started --> ");

		String countryName = "";
		boolean ipFlag = false;
		boolean userAgentFlag = false;
		String domain="";

		try {

			LOG.debug("getting the ip address");
			LOG.debug("Requested Domain"+request.getServerName().replaceAll(".*\\.(?=.*\\.)", ""));
			domain=request.getServerName().replaceAll(".*\\.(?=.*\\.)", "");
			String ipaddress = geoLocation.getClientIpAddr(request); // gets the ip
			LOG.info("IP address :: " + ipaddress);
			countryName = geoLocation.fetchCountryValuefromIPAdrress(ipaddress); // get country name

			LOG.info("countryName :: " + countryName);
			String[] ipRegexList = (String[]) configAdmin.getPropertyValue("ip_regex_list");

			ipFlag = geoLocation.validateRegexPattern(ipaddress, ipRegexList);
			LOG.info("IP address is matching with Regex pattern or public IP ? : "+ipFlag);

			String userAgentInfo = "";
			userAgentInfo = request.getHeader("User-Agent");
			LOG.info("User Agent Info : "+userAgentInfo);

			String[] userAgentStrings =  (String[])  configAdmin.getPropertyValue("safe_user_agents");
			LOG.debug("User Agent Strings : "+userAgentStrings);

			userAgentFlag = geoLocation.validateUserAgent(userAgentInfo, userAgentStrings);
			
			LOG.info("User Agent Flag value : "+userAgentFlag);

			String pageToRedirect = "";
			if(ipFlag==true || userAgentFlag==true){
				LOG.info("Custom IP address from US/Canada or a safe user agent ");
				if((domain.equalsIgnoreCase(configAdmin.getStringPropertyValue("uk_site_constant"))))
				{
		         if(request.getHeader("referer")==null || request.getHeader("referer").endsWith("/libre/") )
		         {
		        	 LOG.info("Inside if statement of  a safe user agent ");
				pageToRedirect = configAdmin.getStringPropertyValue("uk_siteURL");
		         }
		         else
		         {
		        	 LOG.info("Inside else  statement of  a safe user agent ");
		        	 pageToRedirect=StringEscapeUtils.escapeHtml4(request.getHeader("referer"));
		         }
				}
				else if (domain.equalsIgnoreCase(configAdmin.getStringPropertyValue("it_site_constant")))
				{
					if(request.getHeader("referer")==null || request.getHeader("referer").endsWith("/libre/"))
			         {
						LOG.info("Inside if statement of  a safe user agent ");
					pageToRedirect = configAdmin.getStringPropertyValue("it_siteURL");
			         }
			         else
			         {
			        	 LOG.info("Inside else  statement of  a safe user agent ");
			        	 pageToRedirect=StringEscapeUtils.escapeHtml4(request.getHeader("referer"));
			         }
				}
				else if (domain.equalsIgnoreCase(configAdmin.getStringPropertyValue("lu_site_constant")))
				{
					if(request.getHeader("referer")==null || request.getHeader("referer").endsWith("/libre/"))
			         {
						LOG.info("Inside if statement of  a safe user agent ");
					pageToRedirect = configAdmin.getStringPropertyValue("lu_siteURL");
			         }
			         else
			         {
			        	 LOG.info("Inside else  statement of  a safe user agent ");
			        	 pageToRedirect=StringEscapeUtils.escapeHtml4(request.getHeader("referer"));
			         }
				}
				
				
				else if((domain.equalsIgnoreCase(configAdmin.getStringPropertyValue("fr_site_constant"))))
				{
				pageToRedirect = configAdmin.getStringPropertyValue("fr_siteURL");
				}
				else
				{
					LOG.info("Else condition...didnt meet other conditions");
				}
				
				LOG.info("Page to redirect :: "+pageToRedirect);	
				response.getWriter().write(pageToRedirect);
			} else if (countryName == null || "".equalsIgnoreCase(countryName)) {
				LOG.info("Could not find the country based on IP address");	
				pageToRedirect = configAdmin.getStringPropertyValue("error_page");;
				LOG.info("Page to redirect :: "+pageToRedirect);	
				response.getWriter().write(pageToRedirect);

			} else if (countryName.equalsIgnoreCase("US") || countryName.equalsIgnoreCase("CA") ) {

				LOG.info("Either United states or Canada ip address ");	
				pageToRedirect = configAdmin.getStringPropertyValue("us_ca_siteURL");
				LOG.info("Page to redirect :: "+pageToRedirect);
				response.getWriter().write(pageToRedirect);

			} 
			else if(( countryName.equalsIgnoreCase("MC"))&& (domain.equalsIgnoreCase(configAdmin.getStringPropertyValue("fr_site_constant"))))
			{
				LOG.info("MC user accessing FR site");	
				pageToRedirect = configAdmin.getStringPropertyValue("mc_siteURL");
				LOG.info("Page to redirect :: "+pageToRedirect);
				response.getWriter().write(pageToRedirect);
				
			}
			
			else if ((countryName != null && countryName.equalsIgnoreCase("GB") && domain.equalsIgnoreCase(configAdmin.getStringPropertyValue("uk_site_constant"))) ){

				LOG.info("UK country ip address country Ip address");
				pageToRedirect = configAdmin.getStringPropertyValue("uk_siteURL");
				LOG.info("Page to redirect :: "+pageToRedirect);
				response.getWriter().write(pageToRedirect);

			}
			else if ((countryName != null && countryName.equalsIgnoreCase("FR") && domain.equalsIgnoreCase(configAdmin.getStringPropertyValue("fr_site_constant"))) ){

				LOG.info("fr country ip address country Ip address");
				pageToRedirect = configAdmin.getStringPropertyValue("fr_siteURL");
				LOG.info("Page to redirect :: "+pageToRedirect);
				response.getWriter().write(pageToRedirect);

			}
			else if (countryName != null && countryName.equalsIgnoreCase("IT") && domain.equalsIgnoreCase(configAdmin.getStringPropertyValue("it_site_constant"))) {

				LOG.info("Italy  country ip address ");
				pageToRedirect = configAdmin.getStringPropertyValue("it_siteURL");
				LOG.info("Page to redirect :: "+pageToRedirect);
				response.getWriter().write(pageToRedirect);

			}
			else if ((countryName != null && countryName.equalsIgnoreCase("TR") && domain.equalsIgnoreCase(configAdmin.getStringPropertyValue("tr_site_constant"))) ){

				LOG.info("tr country ip address country Ip address");
				pageToRedirect = configAdmin.getStringPropertyValue("tr_siteURL");
				LOG.info("Page to redirect :: "+pageToRedirect);
				response.getWriter().write(pageToRedirect);

			}else if (countryName != null && countryName.equalsIgnoreCase("LU") && domain.equalsIgnoreCase(configAdmin.getStringPropertyValue("lu_site_constant"))) {

				LOG.info("Luxemburg  country ip address ");
				pageToRedirect = configAdmin.getStringPropertyValue("lu_siteURL");
				LOG.info("Page to redirect :: "+pageToRedirect);
				response.getWriter().write(pageToRedirect);

			}
			else {

				LOG.info("IP adddress for neither US/CA/MC");
				if((domain.equalsIgnoreCase(configAdmin.getStringPropertyValue("uk_site_constant"))))
				{
				pageToRedirect = configAdmin.getStringPropertyValue("others_siteURL_uk");
				
				}
				else if(domain.equalsIgnoreCase(configAdmin.getStringPropertyValue("fr_site_constant"))) {
				
				pageToRedirect = configAdmin.getStringPropertyValue("others_siteURL_fr");

				}
				else if(domain.equalsIgnoreCase(configAdmin.getStringPropertyValue("tr_site_constant"))) {
				
				pageToRedirect = configAdmin.getStringPropertyValue("others_siteURL_tr");

				}else if(domain.equalsIgnoreCase(configAdmin.getStringPropertyValue("lu_site_constant"))) {
				
				pageToRedirect = configAdmin.getStringPropertyValue("others_siteURL_lu");

				}
				else
				{
				pageToRedirect = configAdmin.getStringPropertyValue("others_siteURL_it");
				}	
				LOG.info("Page to redirect :: "+pageToRedirect);
				response.getWriter().write(pageToRedirect);

			}

			LOG.debug("got country name: " + countryName);

		} catch (Exception e) {
			LOG.error("Exception in doGet(): "+e.getMessage());
		}

	}

	/**
	 * 
	 * @param keyName
	 * @return
	 * 
	 * 		reads the config property from the keyname passed
	 * 
	 */
	 

	 
	/**
	 * 
	 * @param landingPage
	 * @param slingRequest
	 * @param slingResponse
	 * @throws IOException
	 * 
	 *             This method redirects to either success or failure page
	 *             depending on the status of execution
	 * 
	 */
	public void redirectPage(String landingPage, SlingHttpServletRequest slingRequest,
			SlingHttpServletResponse slingResponse) throws IOException {

		if (!landingPage.isEmpty()) {
			if (landingPage.contains(".html")) {
				slingResponse.sendRedirect(landingPage);
			} else {
				slingResponse.sendRedirect(landingPage + ".html");
			}

		}
	}

}
