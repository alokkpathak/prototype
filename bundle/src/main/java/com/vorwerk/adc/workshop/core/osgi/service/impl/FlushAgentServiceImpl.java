package com.vorwerk.adc.workshop.core.osgi.service.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import javax.jcr.Node;
import javax.jcr.RepositoryException;
import javax.jcr.Session;

import org.apache.commons.lang3.StringUtils;
import org.apache.felix.scr.annotations.Activate;
import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.Service;
import org.apache.jackrabbit.commons.JcrUtils;
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.resource.ResourceResolver;
import org.apache.sling.api.resource.ResourceResolverFactory;
import org.osgi.service.component.ComponentContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.vorwerk.adc.workshop.core.osgi.service.FlushAgentService;
import com.vorwerk.adc.workshop.core.util.AdcFSLConstants;
import com.day.cq.search.PredicateGroup;
import com.day.cq.search.Query;
import com.day.cq.search.QueryBuilder;
import com.day.cq.search.result.Hit;
import com.day.cq.search.result.SearchResult;

@Component(immediate = true, metatype = true)
@Service(value = FlushAgentService.class)
public class FlushAgentServiceImpl implements FlushAgentService {

	private static final Logger log = LoggerFactory
			.getLogger(FlushAgentServiceImpl.class);
	@Reference
	private ResourceResolverFactory resolverFactory;


	@Override
	public void createFlushAgent(String ip, SlingHttpServletRequest request) {
		try {
			ResourceResolver resolver = resolverFactory.getAdministrativeResourceResolver(null);
			Session session = resolver.adaptTo(Session.class);
			Map<String, String> map = new HashMap<String, String>();
			map.put("path", "/etc/replication/agents.publish");
			map.put("type", "cq:Page");
			map.put("property", "jcr:content/serializationType");
			map.put("property.value", "flush");
			log.info("map is" + map);
			QueryBuilder queryBuilder = resolver.adaptTo(QueryBuilder.class);
			Query query = queryBuilder.createQuery(PredicateGroup.create(map),
					session);
			SearchResult result = query.getResult();
			long totalMatches = result.getTotalMatches();
			log.info("totalMatches is" + totalMatches);
			ArrayList<Integer> arrayList = new ArrayList<Integer>();
			for (Hit hit : result.getHits()) {

				if (hit.getPath().contains("flush")
						&& !(hit.getPath().endsWith("flush"))) {
					log.info("totalMatches is" + hit.getPath());
					String[] array = hit.getPath().split("flush");
					log.info("Value is " + array[1]);
					arrayList.add(Integer.parseInt(array[1]));

				}

			}
			Integer maxVal = Collections.max(arrayList);
			++maxVal;
			log.info("Max Value is " + Integer.toString(maxVal));
			Calendar calender = Calendar.getInstance();
			String[] protocolHTTPHeaders = { "CQ-Action:{action}",
					"CQ-Handle:{path}", "CQ-Path: {path}" };
			Node pageNode = JcrUtils.getOrCreateUniqueByPath(
					"/etc/replication/agents.publish"
							+ AdcFSLConstants.BACK_SLASH + "flush" + maxVal,
					"cq:Page", session);
			if (null != pageNode) {
				Node contentNode = pageNode.addNode(
						AdcFSLConstants.JCR_CONTENT, "nt:unstructured");
				contentNode.setProperty("jcr:title", "Dispatcher Flush");
				contentNode.setProperty("cq:template",
						"/libs/cq/replication/templates/agent");
				contentNode.setProperty("sling:resourceType",
						"cq/replication/components/agent");
				contentNode.setProperty("jcr:lastModifiedBy",
						session.getUserID());
				contentNode.setProperty("jcr:lastModified", calender);
				contentNode.setProperty("enabled", "true");
				contentNode.setProperty("logLevel", "error");
				contentNode.setProperty("noVersioning", "true");
				contentNode.setProperty("protocolHTTPMethod", "GET");
				contentNode.setProperty("retryDelay", "6000");
				contentNode.setProperty("serializationType", "flush");
				contentNode.setProperty("transportUri", "http://" + ip
						+ ":80/dispatcher/invalidate.cache");
				contentNode.setProperty("triggerReceive", "true");
				contentNode.setProperty("triggerSpecific", "true");
				contentNode.addMixin("cq:ReplicationStatus");
				contentNode.setProperty("protocolHTTPHeaders",
						protocolHTTPHeaders);
				contentNode.setProperty("ssl", "default");

				if (null != session && session.hasPendingChanges()) {
					session.save();
				}
				if (null != resolver && resolver.isLive()) {
					log.debug("Closing the resolver");
					resolver.close();
				}
				if (null != session && session.isLive()) {
					log.debug("Closing the session");
					session.logout();
				}

			}
		} catch (RepositoryException e) {
			log.error("Error Occurred - " + e);
		} catch (Exception e) {
			log.error("Error Occurred - " + e);
		}

	}

	@Override
	public void deleteFlushAgent(String ip, SlingHttpServletRequest request) {
		try {
			ResourceResolver resolver = resolverFactory.getAdministrativeResourceResolver(null);
			Session session = resolver.adaptTo(Session.class);
			Map<String, String> map = new HashMap<String, String>();
			map.put("path", "/etc/replication/agents.publish");
			map.put("type", "cq:Page");
			map.put("1_property", "jcr:content/serializationType");
			map.put("1_property.value", "flush");
			map.put("2_property", "jcr:content/transportUri");
			map.put("2_property.value", "http://" + ip
					+ ":80/dispatcher/invalidate.cache");
			map.put("property.and", "true");
			log.info("map is" + map);
			QueryBuilder queryBuilder = resolver.adaptTo(QueryBuilder.class);
			Query query = queryBuilder.createQuery(PredicateGroup.create(map),
					session);
			SearchResult result = query.getResult();
			long totalMatches = result.getTotalMatches();
			log.info("totalMatches is" + totalMatches);

			for (Hit hit : result.getHits()) {
				log.info("Vaue Map is  " + hit.getProperties());
				if (StringUtils.isNotEmpty(hit.getProperties()
						.get("transportUri").toString())
						&& StringUtils.isNotEmpty(hit.getProperties()
								.get("transportUri").toString())) {
					if (hit.getProperties().get("transportUri").toString()
							.contains(ip)) {
						resolver.delete(hit.getResource());
					}
				}
			}

			if (null != session && session.hasPendingChanges()) {
				session.save();
			}
			if (null != resolver && resolver.isLive()) {
				log.debug("Closing the resolver");
				resolver.close();
			}
			if (null != session && session.isLive()) {
				log.debug("Closing the session");
				session.logout();
			}

		} catch (Exception e) {
			log.error("exception occured " + e);
		}

	}

	/**
	 * this method activates the FlushAgentService service
	 * 
	 */
	@Activate
	protected void activate(ComponentContext context) {
		log.info("inside actiavte method");
	}
}