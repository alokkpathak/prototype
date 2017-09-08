<%--
* Copyright (c)  Vorwerk POC
* Program Name :  dynamiccrossselling.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Dynamically display content based the selected product.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 28-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<%@ page import="java.util.*"%>
<%
	Node node = resourceResolver.getResource(currentPage.getPath()).adaptTo(Node.class);
	node = node.getNode("jcr:content");
	String name=node.getProperty("jcr:title").getString();

%>

<c:set value="<%=name%>" var="check" />
<c:set value="Starter Pack" var="starter" />




<c:choose>
	<c:when test="${check==starter}">
		<c:set var="text" value="${properties.textForSensor}"/>
   		<c:set var="path"  value="${properties.imageForSensor}"/>
        <c:set var="mobilepath"  value="${properties.mobileimageForSensor}"/>
  	</c:when>
  	<c:otherwise>
    	<c:set var="text"  value="${properties.textForStarter}"/>
   		<c:set var="path"  value="${properties.imageForStarter}"/>
        <c:set var="mobilepath"  value="${properties.mobileimageForStarter}"/>
  	</c:otherwise>
</c:choose>


	<div class="col-md-9 col-xs-12 text-center">
        ${text}
    </div>
    <div class="col-md-3 col-xs-12">
        <img src="${path}" class="imgSwap img-responsive" alt="" desk-img="${path}" mob-img="${mobilepath}" alt="${properties.imagealt1}"/>
    </div>



