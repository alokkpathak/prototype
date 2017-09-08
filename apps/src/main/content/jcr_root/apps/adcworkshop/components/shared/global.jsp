<%--
* Copyright (c)  Vorwerk POC
* Program Name :  global.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Used to provide quick access to specific objects (i.e. to access content) to any JSP script file used to render a component. 
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 23-Jul-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>


<%--
   
The following page context attributes are initialized via the <cq:defineObjects/>
                    tag:

@param slingRequest SlingHttpServletRequest
    @param slingResponse SlingHttpServletResponse
    @param resource the current resource
    @param currentNode the current node
    @param log default logger
    @param sling sling script helper
    
    @param componentContext component context of this request
    @param editContext edit context of this request
    @param properties properties of the addressed resource (aka "localstruct")
    @param pageManager page manager
    @param currentPage containing page addressed by the request (aka "actpage")
    @param resourcePage containing page of the addressed resource (aka "myPage")
    @param pageProperties properties of the containing page
    @param component current CQ5 component
    @param designer designer
    @param currentDesign design of the addressed resource  (aka "actdesign")
    @param resourceDesign design of the addressed resource (aka "myDesign")
    @param currentStyle style of the addressed resource (aka "actstyle")
    
    ==============================================================================

    --%><%@page session="false" import="javax.jcr.*,
    org.apache.sling.api.resource.Resource,
org.apache.sling.api.resource.ValueMap,
com.day.cq.commons.inherit.InheritanceValueMap,
com.day.cq.wcm.commons.WCMUtils,
com.day.cq.wcm.api.Page,
com.day.cq.wcm.api.NameConstants,
com.day.cq.wcm.api.PageManager,
com.day.cq.wcm.api.designer.Designer,
com.day.cq.wcm.api.designer.Design,
com.day.cq.wcm.api.designer.Style,
com.day.cq.wcm.api.components.ComponentContext,
com.day.cq.wcm.api.components.EditContext,
org.apache.sling.settings.SlingSettingsService,
com.day.cq.wcm.api.WCMMode, java.util.Set"

    
    %><%@taglib prefix="sling" uri="http://sling.apache.org/taglibs/sling" %><%
    %><%@taglib prefix="cq" uri="http://www.day.com/taglibs/cq/1.0" %><%
    %><%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%
    %><%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><%
    %><%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<%@taglib prefix="adc" uri="http://www.vorwerk.com/taglibs/adc-workshop/1.0"%><%
    %><cq:defineObjects />

<%
    WCMMode mode = WCMMode.fromRequest(request);
	pageContext.setAttribute("mode",mode); 
	Set<String> runModes = sling.getService(SlingSettingsService.class).getRunModes();
	
	if (runModes.contains("author")) 
	{
	    pageContext.setAttribute("runMode", "author", PageContext.PAGE_SCOPE);	    
	} 
	else 
	{
	    pageContext.setAttribute("runMode", "publish", PageContext.PAGE_SCOPE);
	}

%>
