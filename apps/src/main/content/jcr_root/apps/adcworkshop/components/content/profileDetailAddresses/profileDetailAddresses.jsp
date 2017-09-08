<%--
* Copyright (c)  Vorwerk POC
* Program Name :  profileDetailAddresses.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Lists user address details.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 31-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>



<adc:restServiceUrl  var="listAddress" key="listAddress"/>
<input type="hidden" value="${listAddress}" id="listAddressServiceUrl"/>


<input type="hidden" value="" id="shippingAddressEntityId"/>

<c:set var="addressType" value="shipping" scope="request"/>
<input type="hidden" name="adnewaddrslabel" id="adnewaddrslabel" value="${properties.adnewaddrs}">
<cq:include script="deleteAddress.jsp"/>

<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 padding-zero button-center">
    <h2 class="h4">${properties.centertext}</h2>
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 padding-zero address-panes text-left">
    </div>
</div>
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-right button-center links persAddr createNewAddr" id="add-address">
    <a class="font-fourteen link-underline {{{type}}}" href="#myModal-2" id="createAddr" data-toggle="modal" role="dialog"><u>${properties.adnewaddrs}</u></a>
</div>
<table class="table">
					<tbody id="Address-Template">
					</tbody>
</table>

