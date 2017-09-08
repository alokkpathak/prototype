<%--
* Copyright (c)  Vorwerk POC
* Program Name :  shippingAddressnewcustomer.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Shipping Address for new customer
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 28-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>


<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>


<adc:restServiceUrl  var="createNewUserAddress" key="createAddress"/>
<adc:restServiceUrl  var="updateNewUserAddress" key="updateAddress"/>
<adc:restServiceUrl  var="getshippingcharges" key="getshippingMethod"/>
<input type="hidden" value="${createNewUserAddress}" id="createAddressServiceUrl"/>
<input type="hidden" value="${updateNewUserAddress}" id="updateAddressServiceUrl"/>
<input type="hidden" value="${getshippingcharges}" id="getshippingchargesURL"/>
<input type="hidden" class="valid" id="shippingAddressEntityId"/>
<input type="hidden" class="valid" id="billingAddressEntityId"/>
<input type="hidden" class="valid" id="shippingMethodCode"/>

<!-- shipping address-->
<c:set var="addressType" value=""/>

            
<div class="col-md-3 hidden-xs pull-right text-orange">
    <span>${properties.mandatory}</span>
</div>
<div class="setshipping-global-message"></div>
<div class="form col-lg-6 col-md-8 col-sm-8">
<c:if test="${not empty properties.todtext}">
    ${properties.todtext}
</c:if>
	<c:set var="addressType" value="shipping" scope="request"/>
	<cq:include script="addressForm.jsp"/>     
</div>

<div class="form-group col-xs-12 col-sm-12 col-md-12 checkboxOrange" >

    <input type="checkbox" id="billingDiffers"  name="check" value="1" required/> 
    <label for="billingDiffers"><p>${properties.billingdiff}</p></label>

</div>

<div class="billing-address col-xs-12 col-sm-12 col-md-12">
	<div class="form col-sm-10 col-md-8 col-lg-6">
		<h3>${properties.billingForm}</h3>
		<c:set var="addressType" value="billing" scope="request"/>
		<cq:include script="addressForm.jsp"/>             
	</div>
</div>
                
    <!-- end of shipping address-->
