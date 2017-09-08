<%--
* Copyright (c)  Vorwerk POC
* Program Name :  ecommerceSteps.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  To create checkout steps.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 23-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>

<%@page import="com.vorwerk.adc.workshop.core.util.AdcFSLConstants"%>		
<%@page import="java.util.* "%>
<%@page pageEncoding="UTF-8"%>
<adc:minifyUrlTag  var="thankYouPageUrl" actualUrl="${properties.thankYouUrl}"/>
<adc:globalSettingsTag  var="domainName"  currentDomain="true" />
<c:set var="checkouturl" value="${thankYouPageUrl}"/>
<c:set var="fullURL" value="${domainName}${checkouturl}"/>
<input type="hidden" value="${fullURL}" id="fullURL"/>
<adc:minifyUrlTag  var="transactionTimeoutUrl" actualUrl="${properties.transactiontimeoutUrl}"/>
<input type="hidden"  id="transactiontimeout" value="${transactionTimeoutUrl}">

<section class="container checkout-container">

    <form id="checkout-form">
		<div class="hidden" id="<%=AdcFSLConstants.MANDATORY_MESSAGE%>" >${properties.is_mandatory}</div>
        <div class="hidden" id="<%=AdcFSLConstants.EMAIL_ERROR_MESSAGE%>" >${properties.emailErrorCheck}</div>	
        <div class="hidden" id="<%=AdcFSLConstants.PASSWORD_ERROR_MESSAGE%>" >${properties.validPasswordCheck}</div>
        <div class="hidden" id="<%=AdcFSLConstants.INVALID_CHARACTER_MESSAGE%>" >${properties.invalidCharacterError}</div>
        <div class="hidden" id="<%=AdcFSLConstants.PASSWORD_NOT_MATCHING_MESSAGE%>" >${properties.passwordMatchingCheck}</div>	
        <div class="hidden" id="<%=AdcFSLConstants.NUMBER_OF_DAYS_MESSAGE%>" >${properties.noOfDaysCheck}</div>
        <div class="hidden" id="<%=AdcFSLConstants.NUMBER_OF_MONTHS_MESSAGE%>" >${properties.noOfMonthsCheck}</div>
		<div class="hidden" id="<%=AdcFSLConstants.INVALID_FORMAT_MESSAGE%>" >${properties.invalidYearMessage}</div>
        <div class="hidden" id="<%=AdcFSLConstants.TERMS_AGREE_MESSAGE%>" >${properties.termsAgreeCheck}</div>	
        <div class="hidden" id="<%=AdcFSLConstants.SELECT_VALID_OPTION_MESSAGE%>" >${properties.selectValidOption}</div>
        <div class="hidden" id="<%=AdcFSLConstants.EMAIL_DO_NOT_MATCH_MESSAGE%>" >${properties.emailMatchingCheck}</div>
        <div class="hidden" id="<%=AdcFSLConstants.VALID_POSTCODE_MESSAGE%>" >${properties.validPostCodeCheck}</div>
        <div class="hidden" id="<%=AdcFSLConstants.ONLY_NUMBERS_MESSAGE%>" >${properties.onlyNumbersMessage}</div>
		<div class="hidden" id="<%=AdcFSLConstants.INVALID_TAX_CODE_MESSAGE%>" >${properties.clientTaxCodeMessage}</div>
		 <div class="hidden" id="<%=AdcFSLConstants.INVALID_FUTURE_DATE%>" >${properties.invalidFutureDateMessage}</div>
        <div class="checkout-steps row">
            <div class="col-md-12 padding-zero">
				<c:choose>
					<c:when test="${empty cookie['username'].value}">
						<!-- create account-->
						<cq:include path="checkOutCreateAccountComp" resourceType="/apps/adcworkshop/components/content/userRegistration"/>
					</c:when>
				</c:choose>	
                <!-- create account-->
                <cq:include path="shippingAddressComp" resourceType="/apps/adcworkshop/components/content/shippingAddress"/>
				 <cq:include path="thirdpartyURL" resourceType="/apps/adcworkshop/components/content/thirdpartyPopup"/>
            </div>	
        </div>
        <!--end of payment-->

        
        <!-- checkout -steps--> 
    </form>	

<!--payment comp-->
                <cq:include path="paymentComp" resourceType="/apps/adcworkshop/components/content/payment_type"/>
 <!-- payment-->

    <form class="payonForm hidden" action="${fullURL}" id=""  > </form>

</section>