/**
* Copyright (c)  Vorwerk POC
* Program Name :  GeoLocationServiceImpl.java
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
* -----------                         ----------------                                    -------------------------
* 05-Sep-2016                  Cognizant Technology solutions                                                                                  Initial Creation
* -----------                         -----------------                                   -------------------------
**/
package com.vorwerk.adc.workshop.core.osgi.service.impl;

/**
* @author 554666
*
*/

import java.io.File;
import java.io.IOException;
import java.net.InetAddress;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.felix.scr.annotations.Activate;
import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.Service;
import org.apache.sling.api.SlingHttpServletRequest;
import org.osgi.service.component.ComponentContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.vorwerk.adc.workshop.core.osgi.service.GeoLocationService;
import com.vorwerk.adc.workshop.core.util.GeoConfigFactory;
import com.maxmind.geoip2.DatabaseReader;
import com.maxmind.geoip2.model.CountryResponse;
import com.maxmind.geoip2.record.Country;
import com.maxmind.geoip2.exception.GeoIp2Exception;

/**
 * This service class is used to get the details using do geolocation search
 *
 */

@Component(immediate = true, label = "GeoLocationService", metatype = true, description = "Geolocation service.")

@Service(value = GeoLocationService.class)
public class GeoLocationServiceImpl implements GeoLocationService {

	@Reference
	private GeoConfigFactory geoConfigFactory;

	private static final Logger LOG = LoggerFactory.getLogger(GeoLocationService.class);
	private static String databasePath;

	private static Pattern pattern;
	private static Matcher matcher;
	private static DatabaseReader reader;

	public enum IPHeaders {
		CLIENT_IP_UNDERSCORE("Client_IP"), CLIENT_IP("Client-IP"), X_CLIENT_IP("X-Client-IP"), X_FORWARDED_FOR(
				"X-Forwarded-For"), FORWARDED_FOR("Forwarded-For"), VIA("Via"), REMOTE_ADDR(
						"Remote-Addr"), X_REMOTE_ADDR("X-Remote-Addr"), X_CLUSTER_CLIENT_IP(
								"X-Cluster-Client-IP"), X_FORWARDED("X-Forwarded"), FORWARDED("Forwarded");

		public final String text;

		private IPHeaders(String text) {
			this.text = text;
		}

		public String getText() {
			return text;
		}

	};

	private static DatabaseReader getReader() {
		try {
			// A File object pointing to your GeoIP2 or GeoLite2 database
			File database = new File(databasePath);
			// This creates the DatabaseReader object, which should be reused
			// across lookups.
			reader = new DatabaseReader.Builder(database).build();

		} catch (IOException e) {
			LOG.error("Error While Performing Io Operation  :::::::::::::::: ", e);
		} catch (Exception e) {
			LOG.error("Error While Performing Database   :::::::::::::::: ", e);
		}

		return reader;

	}

	/**
	 * 
	 * @return CountryName
	 */
	public String getCountryName(String ipaddress) {
		String counrtyName = null;

		if (reader == null) {
			reader = getReader();
		}

		try {
			CountryResponse response = reader.country(InetAddress.getByName(ipaddress));
			Country country = response.getCountry();
			if (country != null) {
				counrtyName = country.getName();
			}
		} catch (GeoIp2Exception e) {
			LOG.error("Error While Looking Country from GeoIp   :::::::::::::::: ", e);
		} catch (IOException e) {
			LOG.error("Error While Performing Io Operation    :::::::::::::::: ", e);
		}
		return counrtyName;
	}

	/**
	 * CountryCode
	 * 
	 * @return
	 */
	public String getCountryCode(String ipaddress) {
		String counrtyCode = null;

		if (reader == null) {
			reader = getReader();
		}
		LOG.info("GeoLocationServiceImpl --> getClientIpAddr started --> ");
		try {
			CountryResponse response = reader.country(InetAddress.getByName(ipaddress));
			Country country = response.getCountry();
			if (country != null) {
				counrtyCode = country.getIsoCode();
			}

		} catch (GeoIp2Exception e) {
			LOG.error("Error While Looking Country from GeoIp   :::::::::::::::: ", e);
		} catch (IOException e) {
			LOG.error("Error While Performing Io Operation    :::::::::::::::: ", e);
		}
		return counrtyCode;
	}

	/**
	 * @param request
	 *            This method is used to fetch the client-ip
	 */
	public String getClientIpAddr(SlingHttpServletRequest request) {

		LOG.info("GeoLocationServiceImpl --> getClientIpAddr started --> ");

		LOG.info(" Database Path:: " + geoConfigFactory.getStringPropertyValue("database.path"));

		String ip = "";

		// looks through http headers, case-insensitive
		for (IPHeaders ipHeader : IPHeaders.values()) {
			ip = StringEscapeUtils.escapeHtml4(request.getHeader(ipHeader.getText()));
			LOG.info("IP " + ip);
			if (ip != null && ip.length() > 0 && !"unknown".equalsIgnoreCase(ip)) {
				LOG.info("IP " + ip);
				String[] tokens = ip.split(",");
				
				try {

					boolean foundOnePublicIP = false;

					for (String s : tokens) {
						s = s.trim();
						LOG.info("For Loop Starts  " + s);
						if (Boolean.FALSE.equals(InetAddress.getByName(s).isSiteLocalAddress())) {
							ip = s;
							LOG.info("Inside if " + s);
							foundOnePublicIP = true;
							break;
						}

						LOG.info("Inside for loop and Ip is " + s);

					}

					LOG.info("value of foundOnePublicIP  " + foundOnePublicIP);
					// hard coded the value in case to cater cognizant internal
					// ips
					if (StringUtils.isNotBlank(ip) && (!foundOnePublicIP)) {
						LOG.info("Inside If");
						ip = "52.31.212.233";
					}

				} catch (Exception ex) {
					LOG.debug("Exception ex" + ex);

				}
				LOG.info("IPADDRESS++++++++++++++++" + ip);
				return ip;
			}
		}

		LOG.info("ipaddress-----------------" + ip);
		LOG.info("GeoLocationServiceImpl --> getClientIpAddr ended --> returning");

		return ip;
	}

	/**
	 * @param ipaddress
	 *            This method fetches the Reps closer to the ipaddress location
	 */
	@Override
	public String fetchCountryValuefromIPAdrress(String ipaddress) {

		LOG.info("GeoLocationServiceImpl --> fetchCountryValuefromIPAdrress started --> ");

		String countryName = "";

		try {
			countryName = getCountryCode(ipaddress);
			LOG.info("GeoLocationServiceImpl --> fetchCountryValuefromIPAdrress ended -->" + getCountryCode(ipaddress));
			LOG.info("GeoLocationServiceImpl --> fetchCountryValuefromIPAdrress ended -->" + getCountryName(ipaddress));

		} catch (Exception e) {
			LOG.error("Exception in fetchRepValuesfromIPAdrress():" + e.getMessage());
		}

		LOG.info("GeoLocationServiceImpl --> fetchCountryValuefromIPAdrress ended --> returning ");
		return countryName;
	}

	/**
	 * this method activates the geolocation service
	 * 
	 */
	@Activate
	protected void activate(ComponentContext context) {
		LOG.info("inside actiavte method");
		try {
			LOG.info("Geo Location Service activated");
			databasePath = geoConfigFactory.getStringPropertyValue("database.path");
			LOG.info(" Value of databasePath " + databasePath);
			try {
				// A File object pointing to your GeoIP2 or GeoLite2 database
				File database = new File(databasePath);
				// This creates the DatabaseReader object, which should be
				// reused across lookups.
				reader = new DatabaseReader.Builder(database).build();
				LOG.info(" Reader intialized  " + reader);

			} catch (IOException e) {
				LOG.error("Error While Performing Io Operation  :::::::::::::::: ", e);
			} catch (Exception e) {
				LOG.error("Error While Performing Database   :::::::::::::::: ", e);
			}

		} catch (Exception e) {
			LOG.error("Error Occurred - ", e.getMessage());

		}
	}

	/**
	 * @param ipaddress,
	 *            ipRegexList array
	 * @return ipFlag This method validates the ip address/regex patters with
	 *         the cofigures strings from OSGI config
	 */

	@Override
	public boolean validateRegexPattern(String ipaddress, String[] ipRegexList) {
		boolean ipFlag = false;
		if (ipRegexList.length > 0) {
			LOG.info("Inside validationRegex Loop");
			String regEx = "";
			for (String ipRegex : ipRegexList) {
				LOG.info("IP/Regex : " + ipRegex);
				if (ipRegex.length() > 0 && !StringUtils.isBlank(ipRegex.trim())) {
					LOG.info("IP/Regex value present");
					regEx = ipRegex;
					pattern = Pattern.compile(regEx);
					matcher = pattern.matcher(ipaddress);
					if (matcher.matches()) {
						ipFlag = true;
						break;
					}
				}
			}
		}
		return ipFlag;
	}

	/**
	 * @param userAgentInfo,
	 *            userAgentStrings array
	 * @return userAgentFlag This method validates the user agent strings with
	 *         the cofigures strings from OSGI config
	 */

	@Override
	public boolean validateUserAgent(String userAgentInfo, String[] userAgentStrings) {
		boolean userAgentFlag = false;
		if (userAgentStrings.length > 0) {
			LOG.info("Inside loop");
			String userAgentString = "";
			for (String userAgent : userAgentStrings) {
				if (userAgent.length() > 0 && !StringUtils.isBlank(userAgent.trim())) {

					userAgentString = userAgent;
					pattern = Pattern.compile(userAgentString);
					matcher = pattern.matcher(userAgentInfo);
					if (matcher.matches()) {
						userAgentFlag = true;
						break;
					}
				}
			}
		}
		return userAgentFlag;
	}

}
