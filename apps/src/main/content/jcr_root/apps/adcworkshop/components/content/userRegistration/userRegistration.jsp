<%--
* Copyright (c)  Vorwerk POC
* Program Name :  userRegistration.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  User account creation for new and exsiting customer.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 02-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>
    
<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<%@page import="com.vorwerk.adc.workshop.core.util.AdcFSLConstants"%>		
<%@page import="java.util.* "%>
<%@page pageEncoding="UTF-8"%>
<adc:restServiceUrl  var="var1" key="registration" />
<adc:restServiceUrl  var="updatePersonal" key="updatepersonaldetails" />
<c:set var="check" value="${properties.formSelected}"></c:set>
<adc:minifyUrlTag  var="successPagepath" actualUrl="${properties.successPagepath}"/>
<input type="hidden" name="successPageUrl" id="successPageUrl" value="${successPagepath}">
<input type="hidden" name="registrationUrl" id="registration-url" value="${var1}">
<c:choose>
    <c:when test="${check eq 'true'}">

	
        <!-- create account-->
        <div id="create-account" class="create-account" data-section="checkout" data-index="1">
		<input type="hidden" name="updatePersonalDetailsUrl" id="updatepersonaldetails-url" value="${updatePersonal}">
            <div class="col-md-12 padding-zero">
                <div class="panel panel-default">                    
                    <div class="panel-heading" role="tab">	                    
                        <span class="checkout-step pull-left">1</span>
                        <h2 class="panel-title"><strong>${properties.headtext}</strong><span class="pull-right glyphicon glyphicon-menu-down hidden"></span></h2>
                    </div>           
                    <div class="panel-collapse collapse in col-md-12" role="tabpanel">		
                        <div class="panel-body">  
                            
                            <div class="col-md-3 hidden-xs pull-right text-orange">
                                <span>* ${properties.vtext}</span>
                            </div>
                            <div class="form col-lg-6 col-md-8 col-sm-8 create-user">	
                                <div class="global-message"></div> 
								<div class="hidden" id="<%=AdcFSLConstants.DUPLICATE_EMAIL%>" >
									<label class="padding-zero col-xs-12"><font class="checkoutDuplicateEmail">${properties.duplicateEmailMessage}<a href="#myModal-1" id="userRegiPwdReset" data-toggle="modal" class="userResetPassword" role="dialog">${properties.modatltxtduplicateEmailMessage}</a>
                    ${properties.postduplicateEmailMessage}</font></label>
								</div>											
                                <div class="form-group">
                                    <label class="padding-zero col-xs-12">${properties.ftitle} *</label>
                                    <select class="valid form-control" name="title" id="contact_title" data-mandatory="true" data-lbl="${properties.ftitle}" aria-required="true">
                                        <option value="select"> ${properties.defaultoptionselectregis} </option>
                                        <c:forEach items="${properties.option}" varStatus="count" var="eachOption">
                                            <option value="${eachOption}">${eachOption}</option>
                                        </c:forEach>						                       
                                    </select> 
                                    <span class="error col-md-12"></span> 
                                </div>
                                <div class="form-group">
                                    <label for="contact_firstName" class="padding-zero">${properties.fname} *</label>
                                    <input id="contact_firstName" class="form-control" type="text" name="firstName" data-lbl="${properties.fname}" maxlength="30" aria-required="true">
                                    <span class="error col-md-12"></span>        
                                </div>
                                <div class="form-group">
                                    <label for="contact_lastName" class="padding-zero">${properties.lname} *</label>
                                    <input id="contact_lastName" class="form-control" type="text" name="lastName" data-lbl="${properties.lname}" maxlength="30" aria-required="true">
                                    <span class="error col-md-12"></span>        
                                </div>

								<c:set var="taxCode" value="${properties.includeClientTaxCode}"></c:set>
								<c:if test="${taxCode eq 'true'}">
									<div class="form-group">
										<label for="contact_clientcode" class="padding-zero">${properties.clientTaxCode} *</label>
										<input id="contact_clientcode" class="form-control" type="text" name="contact_clientcode" data-lbl="${properties.clientTaxCode}" maxlength="16" aria-required="true" onkeyup="javascript:this.value=this.value.toUpperCase();" onchange="javascript:this.value=this.value.toUpperCase();" > 
										<span class="error col-md-12"></span>        
									</div>
                                </c:if>
								
                                <div class="form-group">
                                    <label for="email">${properties.email} *</label>
                                    <input type="email" class="form-control" name="email" id="register_email" data-lbl="${properties.email}" autocomplete="off" maxlength="120" onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false" aria-required="true">
                                    <span class="error col-md-12"></span>
                                </div>
                                <div class="form-group">
                                    <label for="confirmemail">${properties.cnfemail} *</label>
                                    <input type="email" class="form-control" name="confirmEmail" id="confirmEmail" data-lbl="${properties.cnfemail}" autocomplete="off" maxlength="120" onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false" aria-required="true">
                                    <span class="error col-md-12"></span>
                                </div>
								<c:set var="displayMobNum" value="${properties.displayMobNum}"></c:set>
                        		<c:if test="${displayMobNum eq 'Yes'}">
										<div class="form-group">
											<label for="contact_phone">${properties.mobilenum} *</label> <input
												id="contact_phone" class="form-control" type="phone"
												value="+33" name="phone" data-lbl="${properties.mobilenum}" maxlength="13">
											<span class="error col-md-12"></span>
										</div>
								</c:if>
                                <div class="form-group">
                                    <label for="pwd">${properties.password} *</label>
                                   <a href="#passwordModal" data-toggle="modal"> <img src="${properties.passwordInfoTooltipImage}"  title="${properties.passwordInfoTooltip}" width="25px" alt="${properties.passwordInfoimagealt}">

                                    </a>                           
                                    <input type="password" class="form-control" name="pwd" id="pwd" data-lbl="${properties.password}" autocomplete="off"  onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false" maxlength="25" aria-required="true">
                                    <span class="error col-md-12"></span>
                                </div>
                                <div class="form-group">
                                    <label for="confirmPassword">${properties.confirmpass} *</label>
                                    <input type="password" class="form-control" name="confirmPassword" id="confirmPassword" data-lbl="${properties.confirmpass}" autocomplete="off" onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false" maxlength="25" aria-required="true">
                                    <span class="error col-md-12"></span>
                                </div>

                                <c:set var="check" value="${properties.optionSwapCheckBox}"></c:set>
                        		<c:choose>
                            	<c:when test="${check eq 'yes'}">
                                    <div class="col-md-12 padding-zero checkboxOrange checkboxmargin">								 	
                                        
                                        <input type="checkbox" id="chkAcceptTerms" data-mandatory="true" aria-required="true">                          						
                                        <label id="agreeCheckbox"  for="chkAcceptTerms"><p>${properties.text1} <a id="privacyPolicyId" href="${properties.linkPath}.html" data-toggle="modal" role="dialog" target=_blank>${properties.link}</a> ${properties.text2}</p></label>	
                                        <span class="error col-xs-12 col-md-12 "></span>	   						  
                                    </div>
                                     <div class="form-group col-md-12 padding-zero checkboxOrange checkboxmarginnotify">	
                                        <input type="checkbox" id="chkAcceptReceive">
                                        <label for="chkAcceptReceive">${properties.notifytext}</label>							   								  
                                    </div>

                                 </c:when>
                                 <c:when test="${check eq 'no'}">
                                     <div class="form-group col-md-12 padding-zero checkboxOrange notify">	
                                        <input type="checkbox" id="chkAcceptReceive">
                                        <label for="chkAcceptReceive">${properties.notifytext}</label>							   								  
                                    </div> 
                                    <div class="form-group col-md-12 padding-zero checkboxOrange agree">								 	
                                        
                                        <input type="checkbox" id="chkAcceptTerms" data-mandatory="true" aria-required="true">                          						
                                        <label id="agreeCheckbox" class="agreementTerms" for="chkAcceptTerms"><p>${properties.text1} <a id="privacyPolicyId" href="${properties.linkPath}.html" data-toggle="modal" role="dialog" target=_blank>${properties.link}</a> ${properties.text2}</p></label>	
                                        <span class="error col-xs-12 col-md-12 agreeCheck"></span>	   						  
                                    </div>

                                    </c:when>
                                </c:choose>




                                <div class="nxt-btn">
                                    <div class="UserRegistration-loading">
                                       <div class="line-pulse"><div></div><div></div><div></div><div></div></div>
                                 </div>
									<button type="submit" href="#shipping-address" class="btn-lg button-orange pull-left btnCheckoutNext" role="button" style="background-color:#E4572D;">${properties.button}</button>	
                                </div>
                            </div>	
                        </div>	
                    </div>
                </div>
            </div>
        </div>
        <!-- create account-->
    </c:when>
    <c:otherwise>
        <!-- contact form -->
        <section class="contact-form container">
			<div class="col-md-offset-2 col-md-8 registrationSuccess"></div>
			<div class="col-md-10 hidden error_show duplicateemail " id="<%=AdcFSLConstants.DUPLICATE_EMAIL%>" >
				<span class="padding-zero col-xs-12"><p>${properties.duplicateEmailMessage}
                <a href="#myModal-1" id="userRegiPwdReset" data-toggle="modal" class="userResetPassword" role="dialog">${properties.modatltxtduplicateEmailMessage}</a>
                    ${properties.postduplicateEmailMessage}</p></span>
			</div>					
			 <div class ="col-md-10">
				<p class="pull-right text-orange">* ${properties.vtext}</p>
			</div>
            <div class="col-md-8">
                <div class="col-md-10 col-xs-12">

                    <!--begin HTML Form-->
                    <form class="form-horizontal contact-horizontal" id="registration" role="form" method="POST">
							
						<div class="hidden" id="<%=AdcFSLConstants.MANDATORY_MESSAGE%>" >${properties.is_mandatory}</div>
						<div class="hidden" id="<%=AdcFSLConstants.EMAIL_ERROR_MESSAGE%>" >${properties.emailErrorCheck}</div>	
						<div class="hidden" id="<%=AdcFSLConstants.PASSWORD_ERROR_MESSAGE%>" >${properties.validPasswordCheck}</div>
						<div class="hidden" id="<%=AdcFSLConstants.INVALID_CHARACTER_MESSAGE%>" >${properties.invalidCharacterError}</div>
						<div class="hidden" id="<%=AdcFSLConstants.PASSWORD_NOT_MATCHING_MESSAGE%>" >${properties.passwordMatchingCheck}</div>	
						<div class="hidden" id="<%=AdcFSLConstants.NUMBER_OF_DAYS_MESSAGE%>" >${properties.noOfDaysCheck}</div>
						<div class="hidden" id="<%=AdcFSLConstants.NUMBER_OF_MONTHS_MESSAGE%>" >${properties.noOfMonthsCheck}</div>
						<div class="hidden" id="<%=AdcFSLConstants.TERMS_AGREE_MESSAGE%>" >${properties.termsAgreeCheck}</div>	
						<div class="hidden" id="<%=AdcFSLConstants.SELECT_VALID_OPTION_MESSAGE%>" >${properties.selectValidOption}</div>
						<div class="hidden" id="<%=AdcFSLConstants.EMAIL_DO_NOT_MATCH_MESSAGE%>" >${properties.emailMatchingCheck}</div>
						<div class="hidden" id="<%=AdcFSLConstants.VALID_POSTCODE_MESSAGE%>" >${properties.validPostCodeCheck}</div>
						<div class="hidden" id="<%=AdcFSLConstants.ONLY_NUMBERS_MESSAGE%>" >${properties.onlyNumbersMessage}</div>
						<div class="hidden" id="<%=AdcFSLConstants.INVALID_TAX_CODE_MESSAGE%>" >${properties.clientTaxCodeMessage}</div>
                        <div class="hidden" id="phoneLength">${properties.phoneNumberLengthCheck}</div>
                        <div class="form-group">
                            <label class="padding-zero col-xs-12" for="contact_title">${properties.ftitle} *</label>
                            
                            <select class="valid form-control" name="title"  id="contact_title" data-mandatory="true" aria-required="true">
							<option value="select"> ${properties.defaultoptionselectregis} </option>
                                <c:forEach items="${properties.option}" varStatus="count" var="eachOption">
                                    <option value="${eachOption}">${eachOption}</option>
                                </c:forEach>						                       
                            </select> 
                            <span class="error col-md-12"></span> 
                        </div>
                        <div class="form-group">
                            <label for="contact_firstName" class="padding-zero">${properties.fname} *</label>
                            <input id="contact_firstName" class="form-control" type="text" name="firstName" data-lbl="${properties.fname}" maxlength="30" aria-required="true">
                            <span class="error col-md-12"></span>        
                        </div>
                        <div class="form-group">
                            <label for="contact_lastName" class="padding-zero">${properties.lname} *</label>
                            <input id="contact_lastName" class="form-control" type="text" name="lastName" data-lbl="${properties.lname}" maxlength="30" aria-required="true">
                            <span class="error col-md-12"></span>        
                        </div>
						<c:set var="taxCode" value="${properties.includeClientTaxCode}"></c:set>
						<c:if test="${taxCode eq 'true'}">
							<div class="form-group">
								<label for="contact_clientcode" class="padding-zero">${properties.clientTaxCode} *</label>
								<input id="contact_clientcode" class="form-control" type="text" name="contact_clientcode" data-lbl="${properties.clientTaxCode}" maxlength="16" aria-required="true" onkeyup="javascript:this.value=this.value.toUpperCase();" onchange="javascript:this.value=this.value.toUpperCase();" >
								<span class="error col-md-12"></span>        
							</div>
                        </c:if>
                        <div class="form-group">
                            <label for="register_email">${properties.email} *</label>
                            <input type="email" class="form-control" name="email" id="register_email" data-lbl="${properties.email}" autocomplete="off" maxlength="255" onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false" aria-required="true">
                            <span class="error col-md-12"></span>
                        </div>
                        <div class="form-group">
                            <label for="confirmEmail">${properties.cnfemail} *</label>
                            <input type="email" class="form-control" name="confirmEmail" id="confirmEmail" data-lbl="${properties.cnfemail}" autocomplete="off" maxlength="255" onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false" aria-required="true">
                            <span class="error col-md-12"></span>
                        </div>
						<c:set var="displayMobNum" value="${properties.displayMobNum}"></c:set>
                        	<c:if test="${displayMobNum eq 'Yes'}">
								<div class="form-group">
									<label for="contact_phone">${properties.mobilenum} *</label> <input
										id="contact_phone" class="form-control" type="phone" value="+33" name="phone" data-lbl="${properties.mobilenum}" maxlength="13">
									<span class="error col-md-12"></span>
								</div>
							</c:if>
                        <div class="form-group">
                            <label for="pwd">${properties.password} *</label>							
                            <a href="#passwordModal" data-toggle="modal"><img src="${properties.passwordInfoTooltipImage}" title="${properties.passwordInfoTooltip}" width="25px" alt="${properties.passwordInfoimagealt}"> </a>                           
                            <input type="password" class="form-control" name="pwd" id="pwd" data-lbl="${properties.password}" autocomplete="off" onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false" maxlength="25" aria-required="true">
                            <span class="error col-md-12"></span>
                        </div>
                        <div class="form-group">
                            <label for="confirmPassword">${properties.confirmpass} *</label>
                            <input type="password" class="form-control" name="confirmPassword" id="confirmPassword" data-lbl="${properties.confirmpass}" autocomplete="off" onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false" maxlength="25" aria-required="true">
                            <span class="error col-md-12"></span>
                        </div> 
                       
						
						<c:set var="check" value="${properties.optionSwapCheckBox}"></c:set>
                        <c:choose>
                            <c:when test="${check eq 'yes'}">
                                <div class="form-group col-md-12 padding-zero checkboxOrange RegistraionCheckbox">
                                <input type="checkbox" id="chkAcceptTerms" data-mandatory="true" aria-required="true">                          						
                                    <label id="agreeCheckbox" class="agreementTerms" for="chkAcceptTerms"><p>${properties.text1} <a href="${properties.linkPath}.html" id="checkPrivacyPolicyId" data-toggle="modal" role="dialog" target=_blank>${properties.link}<span class="sr-only">${properties.opensnewtab}<span></a> ${properties.text2}</p></label>	
                                <span class="error col-xs-12 col-md-12 agreeCheck"></span>	   						  
                            </div>
                             <div class="form-group col-md-12 padding-zero checkboxOrange">	
                                <input type="checkbox" id="chkAcceptReceive">
                                <label for="chkAcceptReceive">${properties.notifytext}</label>							   								  
                            </div>
                           </c:when>

                        <c:when test="${check eq 'no'}">
                            
                            <div class="form-group col-md-12 padding-zero checkboxOrange NoRegistraionCheckbox">	
                                <input type="checkbox" id="chkAcceptReceive">
                                <label for="chkAcceptReceive">${properties.notifytext}</label>							   								  
                            </div> 
                            <div class="form-group col-md-12 padding-zero checkboxOrange">								 	
                                <input type="checkbox" id="chkAcceptTerms" data-mandatory="true" aria-required="true">                          						
                                <label id="agreeCheckbox" class="agreementTerms" for="chkAcceptTerms"><p>${properties.text1} <a id="checkPrivacyPolicyId" href="${properties.linkPath}.html" data-toggle="modal" role="dialog" target=_blank>${properties.link}<span class="sr-only">${properties.opensnewtab}<span></a> ${properties.text2}</p></label>	
                                <span class="error col-xs-12 col-md-12 agreeCheck"></span>	   						  
                            </div>

                         </c:when>
                        </c:choose>
						<div class="form-group col-md-12 text-center padding-zero" id="Registration_submit"> 
                            <div class="Registration-loading">
                                       <div class="line-pulse"><div></div><div></div><div></div><div></div></div>
                                 </div>
							<button type="submit" class="btn-lg button-orange pull-left" style="background-color:#E4572D;">${properties.button}</button>
						</div>
                        					
                    </form><!--end Form-->
                </div>    
            </div><!--end col block-->
            
        </section>
    </c:otherwise>
</c:choose>
<cq:include path="forgotpasswordPopup" resourceType="/apps/adcworkshop/components/content/forgotpassword_popup" />
<div id="passwordModal" class="modal fade" tabindex="-1">
    <div class="modal-dialog">        
        <div class="modal-content">
            <div class="modal-header padding-right">
                <button type="button" class="close" aria-label="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body coupontootipBody">
                ${properties.passwordPopup}
            </div>            
        </div>
        
    </div>
</div>
