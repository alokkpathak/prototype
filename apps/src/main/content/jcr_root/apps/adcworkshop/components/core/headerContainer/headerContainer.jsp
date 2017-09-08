<%--
* Copyright (c)  Vorwerk POC
* Program Name :  headerContainer.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Wrapper for navigations and header.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 26-Jul-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>


<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>

<header class="container-fluid">
	<div id="skip"><a href="#content">${properties.access}</a></div>
    <cq:include path="topbar" resourceType="/apps/adcworkshop/components/core/topbar"/>
    <cq:include path="headerBar" resourceType="/apps/adcworkshop/components/core/header"/>

</header>
<cq:include path="geoLocationPopUp" resourceType="/apps/adcworkshop/components/content/geolocationmessage" />
<cq:include path="countryIndex" resourceType="/apps/adcworkshop/components/content/countryIndex"/>
<c:forEach var="nci" begin="1" end="${properties.noOfMainNav}" varStatus="navCount">
	<%
		int count=(Integer)pageContext.getAttribute("nci");
		request.setAttribute("navcount",count);

    %>
    <cq:include path="subNav_${navCount.count}" resourceType="/apps/adcworkshop/components/core/subMenus"/>
		</c:forEach>