
<%--
* Copyright (c)  Vorwerk POC
* Program Name :  image_text_resources.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  For Configuring Links on the Order.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 01-Sep-2016                  Cognizant Technology solutions            			Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
    
<%
String[] multilinks = {"path","text","imagealt","pathMobile"};
pageContext.setAttribute("linkmultifields", multilinks);
%>

<adc:multicompositefield var="linkListarray" fieldNodeName="imagetext" fieldPropertyNames="${linkmultifields}" returnType="List" />

<section class="container resource-data text-center">
	<div class="col-md-12 col-xs-12">
		<c:forEach items="${linkListarray}" var="llist">
			<div class="col-md-3 col-xs-6 col-resources">
        			<img src="${llist.path}" class="img-circle help-resource-img imgSwap img-responsive" alt="${llist.imagealt}" desk-img="${llist.path}" mob-img="${llist.pathMobile}">
        			<h2>${llist.text}</h2>
			</div>
		</c:forEach>
	</div>
</section>