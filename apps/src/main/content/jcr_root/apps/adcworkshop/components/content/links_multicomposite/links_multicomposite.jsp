<%--
* Copyright (c)  Vorwerk POC
* Program Name :  links_multicomposite.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  To display multifield links on review order page.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 22-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>
<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<%
    String[] multilinks = {"orderLink","orderLinkName"};

pageContext.setAttribute("linkmultifields", multilinks);

%>

<adc:multicompositefield var="linkListarray" fieldNodeName="orderlinks" fieldPropertyNames="${linkmultifields}" returnType="List" />




<div class="col-xs-12 ecom-pdf">
    <ul class="list-unstyled list-inline ecom-finance-links">
        
        <c:forEach items="${linkListarray}" var="llist">
            <li><a href="${llist.orderLink}">${llist.orderLinkName}</a></li>
        </c:forEach>
       <li>  <div id="trackInfo">
            <a href="#shippingInfo" data-toggle="modal" role="dialog">${properties.shipment}</a></div>
            </li>
    </ul>
</div>
