<%--
* Copyright (c)  Vorwerk POC
* Program Name :  body.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Used for including all the Header,Content and Footer Components.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 11-Jul-2016                  Cognizant Technology solutions            					Initial Creation
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
    
    <cq:include script="header.jsp"/>
    <cq:include script="content.jsp"/>
    <cq:include script="footer.jsp"/>

    <cq:includeClientLib js="apps.adc.workshop.products.refactor"/>

</body>
