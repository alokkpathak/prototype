<%--
* Copyright (c)  Vorwerk POC
* Program Name :  metatags.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Used for including meta tags.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 15-oct-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>
<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<%
    String pageDesc=null;
	String pageTitle=null;
    if(currentNode.hasProperty("jcr:description"))
		pageDesc=currentNode.getProperty("jcr:description").getString();
	pageContext.setAttribute("pageDesc", pageDesc);
	if(currentNode.hasProperty("pageTitle"))
		pageTitle=currentNode.getProperty("pageTitle").getString();
	pageContext.setAttribute("pageTitle", pageTitle);
%>
<title><%= pageTitle == null ? xssAPI.encodeForHTML(currentPage.getName()) : xssAPI.encodeForHTML(pageTitle) %></title>
<link rel="SHORTCUT ICON" href="/content/dam/adc/fsl/images/shared/favicon.png" type="image/ico" />
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
 <c:if test="${empty pageDesc}">
	<meta name="description" content="" />
</c:if>
<c:if test="${not empty pageDesc}">
	<meta name="description" content="<%= xssAPI.encodeForHTML((String)pageContext.getAttribute("pageDesc")) %>" />
</c:if>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />

<c:choose>
	<c:when test="${properties.excludeCanonicalTag ne 'yes'}">
		<adc:initMetaTags includeCanonicalTag="true"/>	
	</c:when>
	<c:otherwise>
		<adc:initMetaTags includeCanonicalTag="false"/>	
	</c:otherwise>
</c:choose>
<adc:globalSettingsTag  var="domainName"  currentDomain="true" />
<c:set var="currentPagepath" value="<%=properties.get("navpath",currentPage.getPath())%>"/>
<adc:minifyUrlTag  var="currentPageURL" actualUrl="${currentPagepath}" />
<c:set var="currentUrl" value="${domainName}${currentPageURL}"/>
<adc:globalSettingsTag  var="varfbappid" key="fbappid"/>
<c:if test="${not empty varfbappid}">
	<meta property="fb:app_id" content="${varfbappid}" />
</c:if>
<meta property="og:type" content="article" />
<meta property="og:url" content="${currentUrl}" />
<meta property="og:title" content="<%= pageTitle == null ? xssAPI.encodeForHTML(currentPage.getName()) : xssAPI.encodeForHTML(pageTitle) %>" />
<c:if test="${not empty properties.thumbnailImagePath}">
	<meta property="og:image" content="${properties.thumbnailImagePath}" />
</c:if>
<c:if test="${not empty pageDesc}">
	<meta property="og:description" content="<%= xssAPI.encodeForHTML((String)pageContext.getAttribute("pageDesc")) %>" />
</c:if>