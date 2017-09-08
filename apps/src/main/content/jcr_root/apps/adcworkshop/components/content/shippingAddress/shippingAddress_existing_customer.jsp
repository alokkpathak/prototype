<%--
* Copyright (c)  Vorwerk POC
* Program Name :  shippingAddress_existing_customer.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Lists Existing user address details
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 28-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>



<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>


<%
String[] delList={"delName","delCost","delTime"};
pageContext.setAttribute("delList",delList);

%>

<adc:restServiceUrl  var="createNewUser" key="createAddress"/>
<input type="hidden" value="${createNewUser}" id="createAddressServiceUrl"/>
<c:set var="createAddress" value="${properties.createaddr}"></c:set>
<input type="hidden" value="${createAddress}" id="createAddress"/>
<input type="hidden" value="${properties.addressName}" id="defaultAddrName"/>


<cq:include script="deleteAddress.jsp"/>

<adc:multicompositefield var="delListItems" fieldNodeName="delType" fieldPropertyNames="${delList}" returnType="List"/>

	<div class="setshipping-global-message"></div>
    <div class="col-md-9 col-sm-9">
        ${properties.shippingtext}
    </div>
	<div class="col-md-12 col-lg-9 col-sm-9 shippingAddressPanes text-left">
	</div>

    <div class="col-md-9 col-sm-9">
        ${properties.billingaddresstext}
    </div>
	<div class="col-md-12 col-lg-9 col-sm-9 billingAddressPanes text-left">
	</div>
	
	<table class="table">
					<tbody id="Address-Template-shipping">
					</tbody>
</table>