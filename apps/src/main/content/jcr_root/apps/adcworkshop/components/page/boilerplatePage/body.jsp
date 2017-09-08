<%--
* Copyright (c)  Vorwerk POC
* Program Name :  body.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Used to include all the required Components along with the Content on the Component.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
*10-Sep-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<c:choose>
	<c:when test="${not empty properties.cssPageClass}"> 	
		<body class="${properties.cssPageClass}">
	</c:when>
	<c:otherwise>
		<body>
	</c:otherwise>
</c:choose>

	<cq:include script="content.jsp"/>
 </body>
<cq:includeClientLib js="apps.adc.workshop.last"/>
