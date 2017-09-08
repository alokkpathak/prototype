<%--
* Copyright (c)  Vorwerk POC
* Program Name :  head.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Used to load Sidekick and loading of css and Js files.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 08-Jul-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>
           
    <%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
    <%@page session="false" %>
    <%@page import="com.day.cq.wcm.api.WCMMode"%>

<%
boolean isEdit = WCMMode.fromRequest(request) == WCMMode.EDIT;
boolean isDesign = WCMMode.fromRequest(request) == WCMMode.DESIGN; 
%>
<head>
    <cq:include script="/libs/wcm/core/components/init/init.jsp" />
	<cq:include script="metatags.jsp"/>

	<c:choose>
        <c:when test="${not empty properties.contentClientLibCss}"> 	
            <cq:includeClientLib css="${properties.contentClientLibCss}"/>
        </c:when>
        <c:otherwise>
            <cq:includeClientLib css="apps.adc.workshop.marketing"/>    
        </c:otherwise>	
	</c:choose>
	<cq:includeClientLib js="apps.adc.webshop.jquery"/>
<%  if (((isEdit) || (isDesign))) {  %>
    <cq:includeClientLib js="apps.adc.workshop.authorlibs"/>
<% } %>
</head>
