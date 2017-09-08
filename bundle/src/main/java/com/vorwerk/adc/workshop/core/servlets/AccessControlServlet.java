/**
* Copyright (c)  Vorwerk POC
* Program Name :  AccessControlServlet.java
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Servlet to add or delete permission to components from selected page based on the selected groups.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
* -----------                         ----------------                                    -------------------------
* 19-Jan-2017                  Cognizant Technology solutions            					Initial Creation
* -----------                         -----------------                                   -------------------------
**/

package com.vorwerk.adc.workshop.core.servlets;

import java.io.IOException;
import java.net.URI;

import javax.jcr.Session;
import javax.jcr.security.AccessControlEntry;
import javax.jcr.security.AccessControlManager;
import javax.jcr.security.AccessControlPolicy;
import javax.jcr.security.AccessControlPolicyIterator;
import javax.jcr.security.Privilege;
import javax.servlet.ServletException;

import org.apache.commons.lang3.StringUtils;
import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.Service;
import org.apache.jackrabbit.api.JackrabbitSession;
import org.apache.jackrabbit.api.security.JackrabbitAccessControlList;
import org.apache.jackrabbit.api.security.JackrabbitAccessControlPolicy;
import org.apache.jackrabbit.api.security.user.Authorizable;
import org.apache.jackrabbit.api.security.user.UserManager;
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.sling.api.servlets.SlingAllMethodsServlet;
import org.apache.sling.commons.json.JSONArray;
import org.apache.sling.commons.json.JSONObject;
import org.apache.sling.commons.json.io.JSONWriter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.vorwerk.adc.workshop.core.osgi.service.RunModesService;
import com.vorwerk.adc.workshop.core.exception.AdcFslException;

@Component
@Service
@Properties({
		@Property(name = "service.vendor", value = "Abbot Adc Workshop"),
		@Property(name = "service.description", value = "Custom service for access controls"),
        @Property(name = "sling.servlet.resourceTypes", value = { "sling/servlet/default" }),
        @Property(name = "sling.servlet.selectors", value = { "fslwebshop.accessControl" }),
        @Property(name = "sling.servlet.extensions", value = { "json" }),
        @Property(name = "sling.servlet.methods", value = { "POST" }) })

public class AccessControlServlet extends SlingAllMethodsServlet {

	/**
	 * 
	 */
	
	private static final long serialVersionUID = 9039034643000264055L;
	private final static Logger log = LoggerFactory.getLogger(AccessControlServlet.class);
	
	private static final String DENY_EDIT = "denyEdit";
	private static final String DENY_DELETE = "denyDelete";
	private static final String DENY_EDIT_DELETE = "denyEditDelete";
	
	private static final String RESOURCE_PATH = "resPath";
	private static final String GROUP_NAME = "groupName";
	private static final String PERMISSION = "permission";
	private static final String SELECT = "select";

	
	@Reference
    RunModesService runmodeService;
	
	/**
	 * Returns the ACL of path
	 * 
	 * @param session
	 * @param path
	 * @return
	 * @throws Exception
	 **/
	private JackrabbitAccessControlList getACL(Session session, String path)
			throws AdcFslException {
		JackrabbitAccessControlList acl = null;
		try{
			AccessControlManager acMgr = session.getAccessControlManager();
			AccessControlPolicyIterator app = acMgr.getApplicablePolicies(path);

			while (app.hasNext()) {
				AccessControlPolicy pol = app.nextAccessControlPolicy();

				if (pol instanceof JackrabbitAccessControlPolicy) {
					acl = (JackrabbitAccessControlList) pol;
					break;
				}
			}

			if (acl == null) {
				for (AccessControlPolicy pol : acMgr.getPolicies(path)) {
					if (pol instanceof JackrabbitAccessControlPolicy) {
						acl = (JackrabbitAccessControlList) pol;
						break;
					}
				}
			}
			if(null!=acl){
				log.info("get acl from the path : "+path+"acl : " + acl.toString());
			}
		}
		catch(Exception e){
			log.error("Unable to get access control manager instance"+e);
			throw new AdcFslException(e,"Unable to get access control manager instance");
		}

		return acl;
	}

	@Override
	protected void doPost(SlingHttpServletRequest request,SlingHttpServletResponse response) throws ServletException,IOException {
		log.info("Entering doPost method called");
		
		String aclFormData = request.getParameter("jsondata");
		log.info("aclFormData>>>>> " +aclFormData);
		
		
		
		 try {
			 if(runmodeService.isAuthor())
			{
				 if (aclFormData != null) {
				 JSONObject jsondata = new JSONObject(aclFormData);
				 JSONArray aclData = jsondata.getJSONArray("aclData");
				 log.info("aclData>>-->>> " +aclData);
				 
					 if (aclData != null && aclData.length() > 0) {
					    int size = aclData.length()-1;
					    for (int i = 0; i < size; i++)
					    {
					    	
					    	JSONObject dataObject = aclData.getJSONObject(i);
					    	if (dataObject != null) {
						    	String resPath = dataObject.getString(RESOURCE_PATH);
						    	String groupName = dataObject.getString(GROUP_NAME);
						    	String permission = dataObject.getString(PERMISSION);
						    	
						    	if (resPath != null && (groupName != null && !groupName.equalsIgnoreCase(SELECT)) && (permission != null && !permission.equalsIgnoreCase(SELECT))) {
						    		log.info("Calling setPrivileges method with resPath : "+resPath+"### groupName : "+groupName + "### permission : "+permission);
						    		setPrivileges(request, resPath, groupName, permission);
								}
						    	
					    	}
					    }
					 }
				 }
			
			 
			 String referer = request.getHeader("Referer");
				if (referer != null) {
					URI uri = URI.create(referer);
					referer = uri.getPath();
				} else {
					log.info("No referer. Should never happen.");
				}
			 	
			 	JSONWriter jw = new JSONWriter(response.getWriter());
				jw.object().key("success").value("success").endObject();
				referer = request.getContextPath() + referer;
				referer = request.getResourceResolver().map(referer);
				response.sendRedirect(referer);
				} 
			 }catch (Exception e1) {
			log.error("Error message is : ", e1.getMessage());
		}
	}
	 
	 /**
	  *  setPrivileges for resource Path.
	  * @param request
	  * @param resourcePath
	  * @param groupName
	  * @param permission
	  */

	public void setPrivileges(SlingHttpServletRequest request, String resourcePath, String groupName, String permission)throws AdcFslException {
		
		Boolean setAccessType = false;
		
		AccessControlPolicy[] accessControlPolicyArray = null;
		if (StringUtils.isEmpty(resourcePath) || StringUtils.isEmpty(groupName)) {
			throw new AdcFslException("Required parameters missing");
		}

		try {
			Session session = request.getResourceResolver().adaptTo(Session.class);
			AccessControlManager acMgr = session.getAccessControlManager();

			JackrabbitAccessControlList acl = getACL(session, resourcePath);

			if (acl == null) {
				throw new AdcFslException("ACL not found for  path: "
						+ resourcePath);
			} else {

				UserManager uMgr = ((JackrabbitSession) session).getUserManager();
				Authorizable authorizable = uMgr.getAuthorizable(groupName);
				Privilege[] setPrivilege = null;
				if (permission.equalsIgnoreCase(DENY_EDIT)) {
					setPrivilege = new Privilege[] {
							acMgr.privilegeFromName(Privilege.JCR_ADD_CHILD_NODES) ,
							acMgr.privilegeFromName(Privilege.JCR_MODIFY_PROPERTIES)};
				} else if (permission.equalsIgnoreCase(DENY_DELETE)) {
					setPrivilege = new Privilege[] {
							acMgr.privilegeFromName(Privilege.JCR_REMOVE_CHILD_NODES),
							acMgr.privilegeFromName(Privilege.JCR_REMOVE_NODE) };
				} else if (permission.equalsIgnoreCase(DENY_EDIT_DELETE)) {
					setPrivilege = new Privilege[] {
							acMgr.privilegeFromName(Privilege.JCR_ADD_CHILD_NODES) ,
							acMgr.privilegeFromName(Privilege.JCR_MODIFY_PROPERTIES),
							acMgr.privilegeFromName(Privilege.JCR_REMOVE_CHILD_NODES),
							acMgr.privilegeFromName(Privilege.JCR_REMOVE_NODE) };
				}
				else {
					setPrivilege = null;
				}

				
				
				
				for (AccessControlEntry str : acl.getAccessControlEntries()) {
					
					if(str.getPrincipal().equals(authorizable.getPrincipal())){
						
							acl.removeAccessControlEntry(str);
					}
					
					
				}
				
				if (setPrivilege != null) {
					for (Privilege str : setPrivilege) {
						log.info("Privilege for permission : "+permission+"### is : " + str);
					}
					acl.addEntry(authorizable.getPrincipal(), setPrivilege,
							setAccessType);
				}
				acMgr.setPolicy(resourcePath, acl);
				session.save();
				
			}
			
		} catch (Exception e) {
			log.error("Error adding acl in path - " + resourcePath
					+ ", for - livecopies", e);
			
		}
	}

	
}
