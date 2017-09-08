<%--
* Copyright (c)  Vorwerk POC
* Program Name :  addressForm.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Address Form
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 28-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<%@page pageEncoding="UTF-8"%>
<input type="hidden" id="contact_title" value="">
<input type="hidden" id="contact_firstName">
<input type="hidden" id="contact_lastName">
<input type="hidden" id="default_shippingaddr" value="${properties.addressNameShipping}">
<input type="hidden" id="default_billingaddr" value="${properties.addressNameBilling}">


<div class="${addressType}-global-message"></div>
<div class="form-group">
    <label class="col-md-12 padding-zero">${properties.titleLabel}*</label>
    <select class="valid col-md-2 form-control" id="${addressType}_title" name="${addressType}_title" data-mandatory="true" aria-required="true" >
        <option value="select">${properties.defaultoptionselectaddress}</option>
        <c:forEach items="${properties.titleOptions}" var="eachOption">
            <option value="${eachOption}">
                ${eachOption}
            </option>
        </c:forEach>
        
    </select>
    <span class="col-xs-12 col-sm-12 col-md-12 error"></span>
    
</div>
<div class="form-group">
    <label for="${addressType}_firstName" class="col-md-12 padding-zero">${properties.fname}*</label>
    <input id="${addressType}_firstName" class="col-md-8 form-control" type="text" name="${addressType}_firstName" data-lbl="${properties.fname}" maxlength="15" aria-required="true">
    <span class="col-xs-12 col-sm-12 col-md-12 error"></span>
</div>
<div class="form-group">
    <label for="${addressType}_lastName" class="col-md-12 padding-zero">${properties.lname}*</label>
    <input id="${addressType}_lastName" class="col-md-8 form-control" type="text" name="${addressType}_lastName" data-lbl="${properties.lname}" maxlength="20" aria-required="true">
    <span class="col-xs-12 col-sm-12 col-md-12 error"></span>
</div>

<!-- Added for QAS On Demand Address START -->
<div class="QASaddresslookup" id="${addressType}_addrlookupCheck">
    <div class="form-group col-md-12 padding-left text-orange hidden" id="${addressType}_FindAddress">
        <div class="Addfind">${properties.findaddInline}</div>
    </div>
    <div class="form-group col-md-12 padding-left text-orange " id="${addressType}_ManualAddress">
        <div class="Addfind">${properties.manualaddInline}</div>
    </div>
</div>
<!-- Added for QAS On Demand Address END -->

<div class="hidden" id="${addressType}_ManualAddressData">
    <div class="form-group">
        <label for="${addressType}_address" class="col-md-12 padding-zero">${properties.address}*</label>
        <input id="${addressType}_address" class="col-md-8 form-control" placeholder="${properties.addressPlaceHolder1}" type="text" name="${addressType}_address" data-lbl="${properties.address}" maxlength="255" aria-required="true">
        <span class="col-xs-12 col-sm-12 col-md-12 error"></span>
    </div>
    <c:if test = "${properties.addresslinetwocheckbox eq 'Yes'}" >
    <div class="form-group">
        <label for="${addressType}_address1" class="col-md-12 padding-zero">${properties.address1}</label>
        <input id="${addressType}_addrss1" class="col-md-8 form-control valid" placeholder="${properties.addressPlaceHolder2}" type="text" name="${addressType}_address1" data-lbl="${properties.address1}" maxlength="255" aria-required="true">
        <span class="col-xs-12 col-sm-12 col-md-12 error"></span>
    </div>
    </c:if>
    <div class="form-group" >
        <div class="col-md-4 col-xs-6 padding-left">
            <label for="${addressType}_postCode" class="col-md-12 padding-zero">${properties.pcode}*</label>
           <c:choose>
			<c:when test="${properties.displayPostalCodePrefix eq 'yes'}">
				<p id="${addressType}_postCodePrefix" class="postalinlinePrefix">${properties.postalCodeLabel}</p>
				<!--  <input id="${addressType}_postCodePrefix" class="col-xs-1 form-control postalinlinePrefix" type="" value="${properties.postalCodeLabel}" name="postalinlinePrefix" data-lbl="postalinlinePrefix" readonly="">-->
			</c:when>
			</c:choose>
			<input id="${addressType}_postCode" class="col-md-12 form-control postalinlineActual" type="text" name="${addressType}_postCode" data-lbl="${properties.pcode}" minlength="4" maxlength="10" aria-required="true">
            <span class="col-xs-12 col-sm-12 col-md-12 error shipping_postcode_error_text"></span>
        </div>

        <div class="col-md-8 col-xs-6 padding-zero">
            <label for="${addressType}_city" class="col-md-12 padding-zero">${properties.city}*</label>
            <input id="${addressType}_city" class="col-md-7 form-control" type="text" name="${addressType}_city" data-lbl="${properties.city}" maxlength="50" aria-required="true">
            <span class="col-xs-12 col-sm-12 col-md-12 error  shipping_citycode_error_text"></span>
        </div>
         <div class="row"><div class="col-xs-12 col-sm-12 col-md-12"><span class="error" id="shipping_postcode_error"></span></div></div>
		<div class="row"><div class="col-xs-12 col-sm-12 col-md-122"><span class="error" id="shipping_citycode_error"></span></div></div>  
    </div>
</div>

<!-- Added for QAS On Demand Address START -->
<div class="" id="${addressType}_FindAddressData">
    <div class="form-group" >
        <div class="col-md-4 col-sm-8 col-xs-6 padding-left">
            <label for="${addressType}_contact_postCode" class="col-md-12 padding-zero">${properties.pcode}*</label>
            <c:choose>
				<c:when test="${properties.displayPostalCodePrefix eq 'yes'}">
					<p id="${addressType}_postCodePrefix" class="postalinlinePrefix">${properties.postalCodeLabel}</p>
					<!-- <input id="${addressType}_postCodePrefix" class="col-xs-1 form-control postalinlinePrefix" type="" value="${properties.postalCodeLabel}" name="postalinlinePrefix" data-lbl="postalinlinePrefix" readonly="">-->
				</c:when>
			</c:choose>
			<input id="${addressType}_contact_postCode" class="col-md-12 form-control postalinlineActual"  type="text" name="postCode" data-lbl="${properties.pcode}" minlength="4" maxlength="10" aria-required="true">
            <span class="col-xs-12 col-sm-12 col-md-12 error postalcode_contact_error_text"></span>
        </div>
        <div class="col-md-8 col-sm-4 col-xs-6 padding-left">
            <div class="col-md-6 padding-left">
<a href="" class="btn btn-lg AddressBtn" disabled="disabled" id="${addressType}_AddresssFind">${properties.findInlineCTA}</a>

            </div>
        </div>

 <div class="row"><div class="col-xs-12 col-sm-12 col-md-12"><span class="error" id="postalcode_contact_error"></span></div></div>
    </div>
    <div class="hidden " id="${addressType}_ShowAddress">
        <div class="form-group">
            <label class="col-md-12 padding-zero">${properties.slctdrpdownInline}</label>
            <select class="valid col-md-12 form-control qas-address-selection qas-address-${addressType}" id="${addressType}" name="address" aria-required="true" >
                <option value="select"></option>
                
            </select>
        </div>
        <div class="form-group">
            <label for="${addressType}_addressline_one" class="col-md-12 padding-zero">${properties.address}*</label>
            <input id="${addressType}_addressline_one" class="col-md-12 form-control ${addressType}_addressFind_one" type="text" name="addressline_one" maxlength="255" aria-required="true">
        </div>
        <c:if test = "${properties.addresslinetwocheckbox eq 'Yes'}" >
        <div class="form-group">
            <label for="${addressType}_addressline_two" class="col-md-12 padding-zero">${properties.address1}</label>
            <input id="${addressType}_addrssline_two" class="col-md-12 form-control ${addressType}_addressFind_two valid" type="text" name="addressline_two" maxlength="255" aria-required="true">
        </div>
        </c:if>
        <div class="form-group">
            <label for="${addressType}_contact_city" class="col-md-12 padding-zero">${properties.city}*</label>
            <input id="${addressType}_contact_city" class="col-md-12 form-control ${addressType}_addressFind_city" type="text" name="city" maxlength="50" aria-required="true">
        </div>
    </div>
</div>
<!-- Added for QAS On Demand Address END -->
<div class="clearfix"></div>
<div class="form-group">
    <div class="col-md-2 col-xs-12  padding-zero">
        <label>${properties.country}</label>
    </div>
</div>




<div class="form-group col-md-12 col-xs-12 padding-left">
    <div class="col-md-12 col-xs-12  padding-zero">
        <h5>${properties.countryLabel}</h5>
    </div>
</div>
<div class="form-group">
    <label for="${addressType}_phone" class="col-xs-12 padding-zero">${properties.phone}*</label>
    <p class="secondPhoneNumberLabel col-xs-12">${properties.secondPhoneLabel}</p>
    <input  class="col-xs-1 form-control fixdialcode" type="" value="${properties.dialCode}" name="phone" data-lbl="${properties.phone}" readonly>
    <input id="${addressType}_phone" name="${addressType}_phone" class="col-xs-11 form-control fixdialActual" data-lbl="${properties.phone}" type="text" maxlength="25" aria-required="true">
    <span class="col-xs-12 col-sm-12 col-md-12 error "></span>
</div>

<p class="col-xs-12 col-sm-12 col-md-12 padding-zero phoneInfo">${properties.telephoneInfo}</p>

