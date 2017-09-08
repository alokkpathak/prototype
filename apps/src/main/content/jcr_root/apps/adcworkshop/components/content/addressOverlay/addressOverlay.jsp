<%--
* Copyright (c)  Vorwerk POC
* Program Name :  addressOverlay.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Add New Address component.Adds new address for existing users
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 28-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<%@page import="com.vorwerk.adc.workshop.core.util.AdcFSLConstants"%>		
<%@page import="java.util.* "%>
<%@page pageEncoding="UTF-8"%>

<adc:restServiceUrl  var="createNewUser" key="createAddress"/>
<input type="hidden" value="${createNewUser}" id="createAddressServiceUrl"/>

<adc:restServiceUrl  var="updateAddress" key="updateAddress"/>
<input type="hidden" value="${updateAddress}" id="updateAddressServiceUrl"/>

<adc:restServiceUrl  var="QASAddress" key="QASAddress"/>
<input type="hidden" value="${QASAddress}" id="QASAddressServiceUrl"/>

<adc:restServiceUrl  var="getAddressByMoniker" key="getAddressByMoniker"/>
<input type="hidden" value="${getAddressByMoniker}" id="QASAddressbyMonikerServiceUrl"/>

<input type="hidden" value="${properties.formSelected}" id="QAS-check"/>
<input type="hidden" value="${properties.defaultoptaddr}" id="QAS-defaultaddrselect"/>

<section class="testimonial">
<div id="myModal-2" class="modal fade edit-address" tabindex="-1">

	<form id="updateForm">
		<div class="hidden" id="<%=AdcFSLConstants.MANDATORY_MESSAGE%>" >${properties.is_mandatory}</div>		
		<div class="hidden" id="<%=AdcFSLConstants.INVALID_CHARACTER_MESSAGE%>" >${properties.invalidCharMessage}</div>		
		<div class="hidden" id="<%=AdcFSLConstants.SELECT_VALID_OPTION_MESSAGE%>" >${properties.selectValidOptionFromList}</div>		
		<div class="hidden" id="<%=AdcFSLConstants.ONLY_NUMBERS_MESSAGE%>" >${properties.onlyNumbersMessage}</div>
		<div class="hidden" id="<%=AdcFSLConstants.VALID_POSTCODE_MESSAGE%>" >${properties.PcodeERR}</div>
		<div class="hidden" id="phone_invalid">${properties.phoneNumberInvalid}</div>
		<input id="entity_id" val="" type="hidden"/>
		<c:set var="addressType" value="shipping"/>
		<input id="formName" type="hidden" value="${addressType}"/>
		<input id="addressType" type="hidden" value=""/>
		
		
		<div class="modal-dialog ">
			<div class="modal-content">
				<div class="modal-header padding-zero">
					<button type="button" class="close" aria-label="close" data-dismiss="modal">&times;</button>
					
				</div>
				<div class="address-global-message"></div>
				<div class="modal-body col-md-10 col-md-offset-1">
					<h2 class="modal-title h4" id="create-heading">${properties.createAddressLabel}</h2>
					<h2 class="modal-title h4" id="edit-heading">${properties.editAddressLabel}</h2>
					<div class="form-group">
						<label class="padding-zero col-xs-12">${properties.titleLabel}*</label>
						<select class="valid form-control" id='${addressType}_prefix' name="title" data-mandatory="true" aria-required="true">
						<option value="select">${properties.defaultoptionselect}</option>
							<c:forEach items="${properties.titleOptions}" var="eachOption">
								<option value="${eachOption}">${eachOption}
								</option>
							</c:forEach>
							
						</select> 
						<span class="error col-md-12"></span> 
					</div>
					
					<div class="form-group ">
						<label for="${addressType}_firstNameForm" class="col-md-12 padding-zero">${properties.fname}*</label>
						<input id="${addressType}_firstNameForm" class="col-md-8 form-control" type="text" name="${addressType}_firstNameForm" value="" data-lbl="${properties.fname}" maxlength="15" aria-required="true">
						<span class="error col-md-12"></span>
					</div>
					<div class="form-group">
						<label for="${addressType}_lastNameForm" class="col-md-12 padding-zero">${properties.lname}*</label>
						<input id="${addressType}_lastNameForm" class="col-md-8 form-control" type="text" name="${addressType}_lastNameForm" value="" data-lbl="${properties.lname}" maxlength="20" aria-required="true">
						<span class="error col-md-12"></span>
					</div>

					
					<!-- Added for QAS On Demand Address START -->
					<div class="QASaddresslookup">
						<div class="form-group col-md-12 padding-left text-orange hidden" id="overlay_FindAddress">
							<div class="Addfind">${properties.findadd}</div>
						</div>
						<div class="form-group col-md-12 padding-left text-orange " id="overlay_ManualAddress">
							<div class="Addfind">${properties.manualadd}</div>
						</div>
					</div>
					<!-- Added for QAS On Demand Address END -->
					<div class="hidden" id="overlay_ManualAddressData">
						<div class="form-group">
							<label for="${addressType}_address_one" class="col-md-12 padding-zero">${properties.addressOne}*</label>
							<input id="${addressType}_address_one" class="col-md-8 form-control"  type="text" name="${addressType}_address_one" data-lbl="${properties.addressOne}" placeholder="${properties.addressPlaceHolder1}" maxlength="35" aria-required="true">
							<span class="error col-md-12"></span>
						</div>

						<c:if test = "${properties.addressfield2checbox eq 'Yes'}" >
						<div class="form-group">
							<label for="${addressType}_address_two" class="col-md-12 padding-zero">${properties.addressTwo}</label>
							<input id="${addressType}_addrss_two" class="col-md-8 form-control valid"  type="text" name="${addressType}_address_two" data-lbl="${properties.addressTwo}" placeholder="${properties.addressPlaceHolder2}" maxlength="35" aria-required="true">
						</div>
						</c:if>
						<div class="form-group " >

							<div class="col-md-5 col-xs-6 padding-left">
								<label for="${addressType}_postCodeForm" class="col-md-12 padding-zero">${properties.pcode}*</label>
                                 <c:choose>
                                <c:when test="${properties.displayPostalCodePrefix eq 'yes'}">
                                	<p id="${addressType}_postCodePrefix" class="postalinlinePrefix">${properties.postalCodeLabel}</p>
									<!-- <input id="${addressType}_postCodePrefix" class="col-xs-1 form-control postalPrefix" type="" value="${properties.postalCodeLabel}" name="postalPrefix" data-lbl="postalPrefix" readonly=""> -->
                                </c:when>
                                     </c:choose>
								<input id="${addressType}_postCodeForm" class="col-md-12 form-control postalActual" type="text" name="${addressType}_postCodeForm" data-lbl="${properties.pcode}" minlength="4" maxlength="10" aria-required="true">
								<span class="error col-md-12 postcodeform_error_text"></span>
							</div>
							<div class="col-md-7 col-xs-6 padding-zero">
								<label for="${addressType}_cityForm" class="col-md-12 padding-zero">${properties.city}*</label>
								<input id="${addressType}_cityForm" class="col-md-7 form-control" type="text" name="${addressType}_cityForm" data-lbl="${properties.city}" maxlength="50" aria-required="true">
								<span class="error col-md-12 cityform_error_text"></span>
							</div>
    <div class="row"><div class="col-md-12"><span class="error" id="postcodeform_error"></span></div></div>
<div class="row"><div class="col-md-12"><span class="error" id="cityform_error"></span></div></div>
    </div> 
					</div>
					
					<!-- Added for QAS On Demand Address START -->
					<div  id="overlay_FindAddressData">
						<div class="form-group" >
							<div class="col-md-5 col-xs-6 padding-left">
								<label for="contact_postCode_overlay" class="col-md-12 padding-zero">${properties.pcode}*</label>
                                <c:choose>
                                <c:when test="${properties.displayPostalCodePrefix eq 'yes'}">
                                 	<p id="${addressType}_postCodePrefix" class="postalinlinePrefix">${properties.postalCodeLabel}</p>
									<!-- <input id="${addressType}_postCodePrefix" class="col-xs-1 form-control postalPrefix" type="" value="${properties.postalCodeLabel}" name="postalPrefix" data-lbl="postalPrefix" readonly=""> -->
                                </c:when>
                                </c:choose>
								<input id="contact_postCode_overlay" class="col-md-12 form-control postalActual"  type="text" name="postCode" data-lbl="${properties.pcode}" minlength="4" maxlength="10" aria-required="true" autocomplete="off">
								<span class="error col-md-12"></span>
							</div>
                            <span class="error col-xs-12 col-sm-12 col-md-12 _text"></span>
							<div class="col-md-7 col-xs-6 padding-left">
								<div class="col-md-6 padding-left">
									<button class="btn btn-lg AddressBtn" role="button" id="Shipping_AddresssFind_overlay">${properties.findCTA}</button>
								</div>
							</div>
				<div class="row"><div class="col-xs-12 col-sm-12 col-md-12"><span class="error" id="postalcode_overlay_error"></span></div></div>
						</div> 
						<div class="hidden " id="Shipping_ShowAddress_overlay">
							<div class="form-group">
								<label class="col-xs-12 col-sm-12 col-md-12 padding-zero">${properties.slctdrpdown}</label>
								<select class="valid col-md-12 form-control qas-address-selection qas-address-overlay" id="overlay" name="address" aria-required="true">
									<option value="select"></option>

								</select>
							</div>
							<div class="form-group">
								<label for="addressline_one" class="col-xs-12 col-sm-12 col-md-12 padding-zero">${properties.addressOne}*</label>
								<input id="addressline_one" class="col-xs-12 col-sm-12 col-md-12 form-control overlay_addressFind_one" type="text" name="addressline_one" data-lbl="${properties.addressOne}" placeholder="${properties.addressPlaceHolder1}" maxlength="35" aria-required="true">
								<span class="error col-md-12"></span>
							</div>
							<div class="form-group">
								<label for="addressline_two" class="col-xs-12 col-sm-12 col-md-12 padding-zero">${properties.addressTwo}</label>
								<input id="addressline_two" class="col-xs-12 col-sm-12 col-md-12 form-control overlay_addressFind_two valid" type="text" name="addressline_two" data-lbl="${properties.addressTwo}" placeholder="${properties.addressPlaceHolder2}" maxlength="35" aria-required="true">
							</div>
							<div class="form-group">
								<label for="contact_city" class="col-md-12 padding-zero">${properties.city}*</label>
								<input id="contact_city" class="col-md-12 form-control overlay_addressFind_city" type="text" name="city" data-lbl="${properties.city}" maxlength="50" aria-required="true">
								<span class="error col-md-12"></span>
							</div>
						</div>
					</div>
					<!-- Added for QAS On Demand Address END -->

					<div class="clearfix"></div>
					<div class="form-group">
						<div class="col-md-3 col-xs-5  padding-zero">
							<label>${properties.country}</label>
						</div>
						
					</div>
				   <div class="form-group col-md-12 col-xs-12 padding-left">
						
						<div class="col-md-12 col-xs-12  padding-zero">
							<h5>${properties.countryLabel}</h5>
						</div>
					</div>
               <div class="form-group">
                <label for="${addressType}_phoneForm" class="col-xs-12 padding-zero">${properties.phone}*</label>
                <p class="secondPhoneNumberLabel col-xs-12">${properties.secondPhoneLabel}</p>   
                <input  class="col-xs-1 form-control fixdialcode" type="" value="${properties.dialcode}" name="phone" data-lbl="${properties.phone}" readonly>
                <input id="${addressType}_phoneForm" name="${addressType}_phoneForm" class="col-xs-11 form-control fixdialActual"  type="text" data-lbl="${properties.phone}" maxlength="25" aria-required="true">
                <span class="error col-xs-12 col-sm-12 col-md-12"></span>
                </div> 
					<p class="col-xs-12 col-sm-12 col-md-12 padding-zero phoneInfo">${properties.phoneInfo}</p>
					<div class="form-group">
						<label for="${addressType}_AddressName" class="col-xs-12 col-sm-12 col-md-12 padding-zero">${properties.addressName}*</label>
						<input id="${addressType}_AddressName" class="col-md-8 form-control" type="text" name="${addressType}_AddressName" data-lbl="${properties.addressName}" maxlength="30" aria-required="true">
						<span class="error col-xs-12 col-sm-12 col-md-12"></span>
					</div>
					<div class="form-group col-xs-12 col-sm-12 col-md-12 padding-zero checkboxOrange">							
						<input type="checkbox" id="defaultAddr">
						<label for="defaultAddr"><p>${properties.checkLabel}<p></label>								   								  
					</div>
				</div>
				<div class="modal-footer ">
                    <div class="col-md-offset-1 col-md-8 hidden-xs EditAddress-loading">
                        	<div class="line-pulse"><div></div><div></div><div></div><div></div></div>
                   		</div>
                    <div class="col-md-10 col-md-offset-1 text-left padding-zero addrOverlayFooter">                       
                        <a href="#" class="btn btn-lg cancel cancel-xs-one" data-dismiss="modal">${properties.cancelCTA}</a>
					<div class="hidden-sm hidden-md hidden-lg EditAddress-loading">
                        	<div class="line-pulse"><div></div><div></div><div></div><div></div></div>
                   		</div>		
                        <a href="#" class="btn btn-lg button-orange" id="edit-submit" style="background-color:#E4572D;">${properties.addCTA}</a>
                  </div>
				</div>
			</div>
		</div>
	</form>
</div>
</section>
