<%--
* Copyright (c)  Vorwerk POC
* Program Name : forgotpassword_popup.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Forgot password popup.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 10-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>


<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<%@page import="com.vorwerk.adc.workshop.core.util.AdcFSLConstants"%>		
<%@page import="java.util.* "%>
<cq:setContentBundle/>

<adc:restServiceUrl  var="send_resetpwd_email" key="send_resetpwd_email"/>
<input type="hidden" value="${send_resetpwd_email}" id="resetPasswordMailUrl"/>

<section class="testimonial">
<div id="myModaltest" class="modal fade" tabindex="-1">
<form id="forgot_password_form" role="form">
<div class="hidden" id="<%=AdcFSLConstants.MANDATORY_MESSAGE%>">${properties.is_mandatory}</div>		
	<div class="hidden" id="<%=AdcFSLConstants.EMAIL_ERROR_MESSAGE%>" >${properties.validEmailCheck}</div>
    						<div class="hidden" id="<%=AdcFSLConstants.TERMS_AGREE_MESSAGE%>" >${properties.termsAgreeCheck}</div>	


                  <div class="modal-dialog ">
                      <div class="modal-content">
                          <div class="modal-header padding-zero">
                               <button type="button" class="close mailclose" aria-label="close" data-dismiss="modal">&times;</button>
                          </div>

                          <div class="modal-body text-center">
                            <h2 class="modal-title forget-modal-title">${properties.pheading}</h2>
                          <div id="before-submitcon">
                            <p>${properties.ptext}</p>

                            <div class="form-group text-left email-form-group">
                               <label for="email" class="emaillabel">${properties.pfield}*</label>
                                <input type="email" class="form-control it-form-control" name="email" id="email_consent" data-lbl="${properties.pfield}" maxlength="255" aria-required="true">
                                 <span class="error col-xs-12 col-sm-12 col-md-12 col-lg-12"></span>
                               <div id="<%=AdcFSLConstants.INVALID_EMAIL%>" class="hidden errorpf">${properties.invalidEmail}</div>
							   <div id="<%=AdcFSLConstants.EMAIL_ADDRESS_DOESNT_EXIST%>" class="hidden errorpf">${properties.emaildoesntexist}</div>
                                <div id="Ajaxerror" class="hidden" style="color:red">${properties.ajaxfailed}</div>
                            </div>
                            <div class="form-group checkboxOrange divChk col-md-12 col-sm-12 col-xs-12 padding-zero">
                                 <input type="checkbox" value="None" id="dataAcceptConsent" name="check" aria-required="true" data-mandatory="true" >
                                 <label for="dataAcceptConsent">${properties.dataAccepttext}</label>
                                <span class="error col-xs-12 col-sm-12 col-md-12 col-lg-12"></span>
                            </div>

                            </div>
                              <div id="after-submitcon">
                              ${properties.successtext}
                                <a adhocenable="false" id="resendconsent" class="resend-email">${properties.resendmail}</a>

							</div>
                              <div id="after-resend-submitcon">
                              ${properties.resendtext}

							</div>
                          </div>
                          <div class="forgot-pswd-loading"><div class="line-pulse"><div></div><div></div><div></div><div></div></div></div>
                          <div class="modal-footer forget-modal-footer">
                              <a class="btn btn-lg cancel-xs cancel mailcancel"  data-dismiss="modal" role="button">${properties.cancel}</a> 
                              <a class="btn btn-lg button-orange" id="retrieve-pwdcon"  style="background-color:#E4572D;">${properties.rpwd}</a>
                            </div>
                      </div>
                  </div>
                  </form>
              </div>
  
</section>
