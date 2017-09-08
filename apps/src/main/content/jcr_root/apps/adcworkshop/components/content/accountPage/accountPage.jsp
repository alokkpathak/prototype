<%--
* Copyright (c)  Vorwerk POC
* Program Name :  accountPage.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  The customers can create or login into the account.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 08-Jul-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%
%><%@include file="/apps/adcworkshop/components/shared/global.jsp"%><%
%><%@page session="false" %><%
%>
<%@page import="com.vorwerk.adc.workshop.core.util.AdcFSLConstants"%>
<%@page import="java.util.* "%>
<%@page pageEncoding="UTF-8"%>
<adc:restServiceUrl  var="var" key="login" />
<adc:restServiceUrl  var="var1" key="getToken" />
<adc:restServiceUrl  var="isCust" key="isCustomer"/>

<section class="login container-fluid">
    <input type="hidden" name="loginUrl" id="login-url" value="${var}">
	<input type="hidden" name="newtokenUrl" id="newtokenUrl" value="${var1}">
	<input type="hidden" name="isCustUrl" id="isCustUrl" value="${isCust}">
	<adc:minifyUrlTag  var="signInLink" actualUrl="${properties.signInLink}"/>
	<adc:minifyUrlTag  var="ctaCheckoutGuestLink" actualUrl="${properties.ctaCheckoutGuestLink}"/>
	<adc:minifyUrlTag  var="ctaCheckoutLink" actualUrl="${properties.ctaCheckoutLink}"/>
	<adc:minifyUrlTag  var="registrationPageLink" actualUrl="${properties.registrationPageLink}"/>	
	<adc:minifyUrlTag  var="viewBasketPageLink" actualUrl="${properties.viewBaketLink}"/>
	
	 <c:choose>
		<c:when test="${not empty param.opr && param.opr == 'orderhistory'}">
            <input type="hidden" name="signInPageURL" id="signInPageURL" value="${signInLink}?idx=1">
    	</c:when>    	
    	<c:when test="${not empty param.id && not empty param.opr && param.opr == 'pdfdocid'}">
    		<adc:restServiceUrl  var="pdfurl" key="pdfdocid" />
            <input type="hidden" name="signInPageURL" id="signInPageURL" value="${pdfurl}${param.id}">
            <c:set var="ctaCheckoutGuestLink" scope="request" value="${pdfurl}${param.id}" />
            <c:set var="ctaCheckoutLink" scope="request" value="${pdfurl}${param.id}" />
            <c:set var="viewBasketPageLink" scope="request" value="${pdfurl}${param.id}" />
    	</c:when>    	
        <c:otherwise>
			<input type="hidden" name="signInPageURL" id="signInPageURL" value="${signInLink}">
    	</c:otherwise>
    </c:choose>
   
    <input type="hidden" name="guestCheckoutUrl" id="guestCheckoutUrl" value="${ctaCheckoutGuestLink}">
    <input type="hidden" name="checkoutUrl" id="checkoutUrl" value="${ctaCheckoutLink}">
    <input type="hidden" name="registrationPageUrl" id="registrationPageUrl" value="${registrationPageLink}">
    <input type="hidden" name="viewBasketPageLink" id="viewBasketPageLink" value="${viewBasketPageLink}">
    
    <div class="container login-wrap col-md-12" style="margin-left: 1px;">
        <div class="col-md-offset-1 col-md-10 required-field hidden" id="accountactivationlink">
            <p>${properties.accountConfimationMessage}</p>
        </div>
        <div class="col-md-offset-4 col-md-8 required-field">
            <p class="text-orange"></p>
        </div>
		
	 <div class="col-md-offset-1 col-md-5 col-md-push-5">
            <div class="login-container" style="background-color:#F4F2F4;">
                <h1>${properties.headingTextSignUp}</h1>
                
                <div class="col-md-12 text-center">
                    <p class="noteforgetpwd">${properties.signUpDesc}</p>
                </div>
                
                <div class="form-group">        
                    <div class=" col-sm-12 text-center">
                        <a href="#" id="createAccountLink" class="btn btn-lg button-orange reg-btn" role="button" style="background-color:#E4572D;">${properties.continueButtonText}</a>
                    </div>
                    
                    
                </div>
                
            </div>        
            
        </div>	
        
        <div class="col-md-5 col-md-pull-5 ">        
            <div class="login-container" style="background-color:#F4F2F4;">
				<div class="col-md-12 col-xs-12 text-orange create-mand">
                    <span class="pull-right">${properties.mandatoryFieldText}</span>
                </div>
                <h2>${properties.headingTextSignIn}</h2>
                <span class="hidden error_show" id="<%=AdcFSLConstants.INVALID_LOGIN%>" >
                    ${properties.invalidLoginMessage}
					<a href="#myModal-1" id="forgetPwdReset" data-toggle="modal" class="aResetPassword" role="dialog">${properties.invalidLoginTextModal}</a>
                </span>
                <div class="hidden" id="<%=AdcFSLConstants.ACCOUNT_ACTIVATION_PENDING%>" >
                   <span class="activationPending error_show col-xs-12">${properties.activationPendingMessage}</span>
                </div>											
                
                
                <form class="form-horizontal" id="login" role="form" method="POST">
                    <div class="hidden" id="<%=AdcFSLConstants.MANDATORY_MESSAGE%>" >${properties.login_error_mandatory}</div>
                    <div class="hidden" id="<%=AdcFSLConstants.EMAIL_ERROR_MESSAGE%>" >${properties.validEmailCheck}</div>	
                    <div class="hidden" id="<%=AdcFSLConstants.PASSWORD_ERROR_MESSAGE%>" >${properties.validPasswordCheck}</div>
                    <div class="form-group col-md-12 ">
                        <label class="control-label " for="login_email">${properties.emailLabelSignIn}*</label>
                        <input type="email" class="form-control" id="login_email" name="email" data-lbl="${properties.emailLabelSignIn}" placeholder="${properties.emailPlaceHolder}" autocomplete="off" maxlength="255">
                        <span class="error"></span>
                    </div>
                    <div class="form-group col-md-12">
                        <label class="control-label" for="login_pwd">${properties.passwordLabelSignIn}*</label>        
                        <input type="password" class="form-control" id="login_pwd" name="pwd" data-lbl="${properties.passwordLabelSignIn}" placeholder="${properties.passwordPlaceHolder}" autocomplete="off" maxlength="25" onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false">
                        <span id="passworderror" class="error"></span>
                    </div>
                    <div class="form-group col-md-12"> 
                        <div class="reloadModal"><a href="#myModal-1" id="forgetPwdReset" data-toggle="modal" class="text-orange">${properties.forgotPassword}</a></div>
                    </div>
                    <div class="login-loading">
                        <p>${properties.signinLoadingMessage}</p>
                        <div class="line-pulse"><div></div><div></div><div></div><div></div></div>
                    </div>
                    <div class="form-group col-md-12 text-center" id="login_submit">                        
                        <button type="button" class="btn  btn-lg button-orange">${properties.signInButtonText}</button>
                    </div>
                </form>
            </div>    
        </div>  
  
    </div> 
    
</section>

