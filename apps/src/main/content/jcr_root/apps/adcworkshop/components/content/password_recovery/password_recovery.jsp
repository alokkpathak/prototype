<%--
* Copyright (c)  Vorwerk POC
* Program Name :  password_recovery.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Recover password form.
* Modification History:
* ---------------------
    *    Date                                Modified by                                       Modification Description
    *-----------                            ----------------                                    -------------------------
    * 28-Aug-2016                  Cognizant Technology solutions            					Initial Creation
    * 7-sep-2016                    Cognizant Technology solutions                              Error handling modifications
    *-----------                           -----------------                                    -------------------------
--%>


<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<%@page import="com.vorwerk.adc.workshop.core.util.AdcFSLConstants"%>
<%@page import="java.util.* "%>
<adc:restServiceUrl  var="resetPassword" key="resetPassword"/>
<input type="hidden" value="${resetPassword}" id="resetPasswordUrl"/>
<input type="hidden" name="errorPageUrl" id="errorPageUrl" value="${properties.errorPageLink}">
<adc:restServiceUrl  var="profiledetails" key="profiledetails"/>
<input type="hidden" value="${profiledetails}" id="profiledetailsServiceUrl"/>
<adc:restServiceUrl  var="profilevalidate" key="profilevalidate"/>
<input type="hidden" value="${profilevalidate}" id="profiledetailsValidateServiceUrl"/>
<adc:minifyUrlTag  var="unauthorizedurl" actualUrl="${properties.unauthorizedurl}" />
<input type="hidden" name="unauthorizedurl" id="unauthorizedurl" value="${unauthorizedurl}">
<adc:minifyUrlTag  var="accountOverview" actualUrl="${properties.successURL}" />
<input type="hidden" name="accountOverview" id="signInPageURL" value="${accountOverview}">
<script type="text/javascript" src="/etc/designs/adcworkshop/clientlibs-adc-ecomm/js/passwordrecovery.js"></script>

<div class="container greeting-recovery-container">
     <div class="text-center">
               <p>${properties.greetingText}<span id="cusName"></span>${properties.setpwdText}</p>            
          </div> 
</div>
<div class="container reset-recovery-container">

  <form id="recoverPasswordForm">
     <div class="hidden" id="<%=AdcFSLConstants.MANDATORY_MESSAGE%>" >${properties.is_mandatory}</div>
                <div class="hidden" id="<%=AdcFSLConstants.PASSWORD_ERROR_MESSAGE%>" >${properties.validPasswordCheck}</div>
                <div class="hidden" id="<%=AdcFSLConstants.PASSWORD_NOT_MATCHING_MESSAGE%>" >${properties.passwordMatchingCheck}</div>   
  <h2 class="recoverTitle">${properties.heading}</h2> 
    <div class="form-group ">
      <label for="pwd" class="xs-recover-label">${properties.pwd}* <a href="#passwordrevoceryModal" data-toggle="modal"><img src="/content/dam/adc/fsl/images/global/en/desktopImages/questionmark.png"></a></label>

      <input type="password" class="form-control recoverPwd" name="pwd" id="pwd" data-lbl="${properties.pwd}" autocomplete="off" minlength="8" onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false" maxlength="25" aria-required="true">
        <span class="error"></span>
    </div>
    <div class="form-group">
      <label for="pwd" class="xs-recover-label reset-confirm-pwd">${properties.repwd}*</label>
      <input type="password" class="form-control recoverPwd"  name="recover_repeat_pwd" id="recover_repeat_pwd" data-lbl="${properties.repwd}" autocomplete="off" minlength="8" onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false" maxlength="25" aria-required="true">
        <span class="error"></span>
    </div>
       <div class="hidden text-center" id="resetpass" style="color:blue">${properties.resetservicesuccess}</div>
                    <div class="hidden text-center" id="resetfail" style="color:red">${properties.resetservicefail}</div>
                    <div class="hidden text-center" id="<%=AdcFSLConstants.INVALID_OLD_PASSWORD%>" style="color:red">${properties.invalidOldPassword}</div>
                    <div class="hidden text-center" id="<%=AdcFSLConstants.INVALID_PASSWORD_RESET_TOKEN%>" style="color:red">${properties.invalidPasswordResetToken}</div>
                    <div class="hidden text-center" id="<%=AdcFSLConstants.WRONG_CUSTOMER_ACCOUNT%>" style="color:red">${properties.wrongCustomerAccount}</div>
                    <div class="hidden text-center" id="<%=AdcFSLConstants.RESET_LINK_EXPIRED%>" style="color:red">${properties.resetLinkExpired}</div>
                    <div class="hidden text-center" id="<%=AdcFSLConstants.FAILED_LOADING_CUST_ID%>" style="color:red" >${properties.failedLoadingCustomerId}</div>
      <div class="form-group text-center confirm-wrap">
          <input type="button" id="recoverypwd_confirm" class="btn btn-lg button-orange valid" value="${properties.button}"/>
      </div>
  </form>
</div>
<div id="passwordrevoceryModal" class="modal fade" tabindex="-1">
    <div class="modal-dialog">        
        <div class="modal-content">
            <div class="modal-header padding-right">
                <button type="button" class="close" aria-label="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body coupontootipBody">
                ${properties.passwordrecoveryPopup}
            </div>            
        </div>

    </div>
</div>




