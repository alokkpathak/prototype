<%--
* Copyright (c)  Vorwerk POC
* Program Name :  personalDeatils.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  PersonalDeatils for the profile details .
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
<%
    String acckountsDetails=properties.get("acckountsDetails","acckountsDetails");
	String fname=properties.get("fname","fname");
%>

<adc:restServiceUrl  var="updatepersonaldetails" key="updatepersonaldetails"/>
<input type="hidden" value="${updatepersonaldetails}" id="updatepersonaldetailsServiceUrl"/>

<adc:restServiceUrl  var="profiledetails" key="profiledetails"/>
<input type="hidden" value="${profiledetails}" id="profiledetailsServiceUrl"/>

<section id="persDetails" class="col-lg-12 hidden container-fluid">
    <div class="details-container" id="personal-details">
        <form id="detailsForm" action="">
            <div class="hidden" id="<%=AdcFSLConstants.MANDATORY_MESSAGE%>" >${properties.is_mandatory}</div>
            <div class="hidden" id="<%=AdcFSLConstants.SELECT_VALID_OPTION_MESSAGE%>" >${properties.selectValidOption}</div>
            <div class="hidden" id="<%=AdcFSLConstants.EMAIL_ERROR_MESSAGE%>" >${properties.emailErrorCheck}</div>
            <div class="hidden" id="<%=AdcFSLConstants.PASSWORD_ERROR_MESSAGE%>" >${properties.validPasswordCheck}</div>	
            <div class="hidden" id="<%=AdcFSLConstants.INVALID_CHARACTER_MESSAGE%>" >${properties.invalidCharacterError}</div>
            <div class="hidden" id="<%=AdcFSLConstants.PASSWORD_NOT_MATCHING_MESSAGE%>" >${properties.passwordMatchingCheck}</div>
            <div class="hidden" id="<%=AdcFSLConstants.EMAIL_DO_NOT_MATCH_MESSAGE%>" >${properties.emailMatchingCheck}</div>
             <div class="hidden" id="phoneLength">${properties.phoneNumberLengthCheck}</div>
            
            
            <!--Personal details component starts here  -->
            
            <div class="button-center">
                <h2 class="h4"><%= xssAPI.encodeForHTML(acckountsDetails) %></h2>
                <div class="form col-sm-8 col-md-8 col-lg-6  padding-zero">
                    <div class="hidden" id="pers-success" style="margin-bottom:15px">${properties.personalupdatesuccess}</div>
                    <div class="hidden" id="pers-failure" style="margin-bottom:15px">${properties.personalupdatefailure}</div>
                    <div class="hidden persSaveError" id="<%=AdcFSLConstants.MAGENTO_ERROR%>" ></div>
                    
                    
                    
                    <form class="form-horizontal contact-horizontal" role="form">
                        
                        
                        <div class="form-group">
                            <label class="padding-zero col-xs-12">${properties.ftitle}*</label>
                            <select class="form-control" name="title" data-mandatory="true" aria-required="true" id="selectTitle" data-lbl="${properties.ftitle}">
                                <option value="select">${properties.defaultoptionselectpersonal}</option>
                                <c:forEach items="${properties.option}" varStatus="count" var="eachOption" >
                                    <option value="${eachOption}">${eachOption}</option>
                                </c:forEach>	
                                
                            </select> 
                            <span class="error col-xs-12 col-sm-12 col-md-12"></span> 
                        </div>
                        <div class="form-group">
                            <label for="contact_firstName" class="padding-zero"><%= xssAPI.encodeForHTML(fname) %>*</label>
                            <input id="contact_firstName" class="form-control" type="text" name="firstName" data-lbl="${properties.fname}" maxlength="30" aria-required="true">
                            <span class="error col-xs-12 col-sm-12 col-md-12"></span>        
                        </div>
                        <div class="form-group">
                            <label for="contact_lastName" class="padding-zero">${properties.lname}*</label>
                            <input id="contact_lastName" class="form-control" type="text" name="lastName" data-lbl="${properties.lname}" maxlength="30" aria-required="true">
                            <span class="error col-xs-12 col-sm-12 col-md-12"></span>        
                        </div>
                        
                        <div class="form-group">
                            <label for="register_email">${properties.email}*</label>
                            <input type="email" class="form-control" name="email" id="register_email" data-lbl="${properties.email}" autocomplete="off" maxlength="255" onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false" maxlength="255" aria-required="true">
                            <span class="error col-xs-12 col-sm-12 col-md-12 text-left"></span>
                        </div>
                        <div class="form-group">
                            <label for="confirmEmail">${properties.cnfemail}*</label>
                            <input type="email" class="form-control" name="confirmEmail" id="confirmEmail" data-lbl="${properties.cnfemail}" autocomplete="off" maxlength="255" onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false" maxlength="255" aria-required="true">
                            <span class="error col-xs-12 col-sm-12 col-md-12 text-left"></span>
                        </div>
                        <c:set var="displayMob" value="${properties.displayMobNum}"></c:set>
                       	<c:if test="${displayMob eq 'Yes'}">
                                <div class="form-group">
                                    <label for="contact_phone1" class="col-md-12 padding-zero">${properties.phonenumber} *</label>
                                    <input id="contact_phone1" class="col-md-12 form-control" maxlength="13" type="phone" value="+33" name="phone1" data-lbl="Phone">
                                    <span class="error col-md-12"></span>
                                </div>
                        </c:if>
                        
                        <div class="form-group col-xs-12 col-sm-12 col-md-12 padding-zero checkboxOrange" id="changePasswordCheckGrp">	
                            <input type="checkbox" id="changePasswordCheck">
                            <label for="changePasswordCheck"><p>${properties.chagepass}<p></label>							   								  
                        </div> 
                        
                        
					<div id="passwordSection">
						<div class="form-group">
							<label for="pwd" class="pwdMobileAlign">${properties.password}*</label>
                            <a href="#personalDetailsPasswordPopUp" data-toggle="modal"> <img src="${properties.passwordInfoTooltipImage}" class="pwdMobileAlign" data-alt-src="${properties.passwordInfoTooltipHoverImage}" title="${properties.passwordInfoTooltip}" width="25px" alt="${properties.passwordInfoimagealt}"></a>
							<input type="hidden" class="form-control" name="pwd" id="pwd" data-lbl="${properties.password}" autocomplete="off" minlength="8" onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false" maxlength="25" aria-required="true">
							<span class="error col-xs-12 col-sm-12 col-md-12 spaceErrorText text-left"></span>
						</div>
						<div class="form-group">
							<label for="confirmPassword">${properties.confirmpass}*</label>
							<input type="hidden" class="form-control" name="confirmPassword" id="confirmPassword" data-lbl="${properties.confirmpass}" autocomplete="off" minlength="8" onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false" maxlength="25" aria-required="true">
							<span class="error col-xs-12 col-sm-12 col-md-12 spaceErrorText text-left"></span>
						</div>
					</div>

                    </form><!--end Form-->
                </div>
            </div>
            <div class="col-lg-12 padding-zero">
                <hr class="hidden"/>
            </div>
            <!--Personal details component ends here  -->
            
            <!--Address compenent starts here -->
            
            <cq:include path="addressList" resourceType="/apps/adcworkshop/components/content/profileDetailAddresses"/>
            
            <!--Address compenent ends here  -->
            <div class="col-lg-12 padding-zero">
				<hr class="hidden"/>
            </div>
            
            <div class="col-md-12 padding-zero">
                <h2 class="registerDescTitle h4">${properties.notificationTit}</h2>
                <p class="button-center registerDescText">${properties.notificationDes}</p>

                <div class="col-lg-12 padding-zero button-center topSpacing check-boxes" id="regisNotification">

						<div class="form-group col-md-2 col-sm-6 col-xs-6 padding-zero checkboxOrange">	
                            <input type="checkbox" id="EMAIL" value="EMAIL" required="">
                            <label for="EMAIL"><p>${properties.emailAlert}</p></label>							   								  
                        </div>
						<div class="form-group col-md-3 col-sm-6 col-xs-6 padding-zero checkboxOrange">	
                            <input type="checkbox" id="MAIL" value="MAIL" required="">
                            <label for="MAIL"><p>${properties.postmailAlert}</p></label>							   								  
                        </div>
						<div class="form-group col-md-3 col-sm-6 col-xs-6 padding-zero checkboxOrange">	
                            <input type="checkbox" id="PHONE" value="PHONE" required="">
                            <label for="PHONE"><p>${properties.telephoneAlert}</p></label>							   								  
                        </div>
						<div class="form-group col-md-2 col-sm-6 col-xs-6 padding-zero checkboxOrange">	
                            <input type="checkbox" id="SMS" value="SMS" required="">
                            <label for="SMS"><p>${properties.SMSAlert}</p></label>							   								  
                        </div>
                </div>


                <div class="topSpacing col-md-12 hidden-xs hidden-sm padding-zero">
                    <div class="personaldetails-loading">
                        <div class="line-pulse"><div></div><div></div><div></div><div></div></div>
                    </div>
                   <a href="#" class="btn btn-lg button-orange infoSubmit"   role="button" style="background-color:#E4572D;">${properties.button}</a>                    
                </div>
                <div class="col-xs-12 col-sm-12 visible-xs visible-sm text-center">
                    <div class="personaldetails-loading">
                        <div class="line-pulse"><div></div><div></div><div></div><div></div></div>
                    </div>
                    <a href="#" class="btn btn-lg button-orange infoSubmit"   role="button" style="background-color:#E4572D;">${properties.button}</a>
                    
                </div>
            </div>
        </form>
    </div>
</section>
<div id="personalDetailsPasswordPopUp" class="modal fade" tabindex="-1">
    <div class="modal-dialog">        
        <div class="modal-content">
            <div class="modal-header padding-right">
                <button type="button" class="close" aria-label="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body coupontootipBody">
                ${properties.personalpasswordPopup}
            </div>            
        </div>
        
    </div>
</div>