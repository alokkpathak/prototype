<%--
  Similar copy of ACS Commons 1.10.4 errorhandler component 404.jsp; except that /libs/sling/servlet/errorhandler/default.js is never called, because it outputs too much CQ info.
  Else logic branch comes from Adobe's customized default.jsp error handler disable_apachesling_signature-1.zip
  --%>
<%@page session="false"
        import="com.adobe.acs.commons.errorpagehandler.ErrorPageHandlerService,
		com.day.cq.wcm.api.WCMMode,
		java.io.PrintWriter,
		org.apache.sling.api.SlingConstants,
		org.apache.sling.settings.SlingSettingsService,
		org.apache.sling.api.request.RequestProgressTracker,
		org.apache.sling.api.request.ResponseUtil,
		org.apache.commons.lang3.StringEscapeUtils"%><%
%><%@include file="/libs/foundation/global.jsp" %>

<%-- This portion of code comes from ACS commons --%>
<%
    ErrorPageHandlerService errorPageHandlerService = sling.getService(ErrorPageHandlerService.class);

    if (errorPageHandlerService != null && errorPageHandlerService.isEnabled()) {
        // Check for and handle 404 Requests properly according on Author/Publish
        if (errorPageHandlerService.doHandle404(slingRequest, slingResponse)) {

            final String path = errorPageHandlerService.findErrorPage(slingRequest, resource);

            if (path != null) {
                slingResponse.setStatus(404);
                errorPageHandlerService.includeUsingGET(slingRequest, slingResponse, path);
                return;
            }
        }
    }
%>
<%-- This portion of code modified to call /apps/sling default.jsp --%>
<%@include file="/apps/sling/servlet/errorhandler/default.jsp" %>