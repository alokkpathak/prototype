<%--
* Copyright (c)  Vorwerk POC
* Program Name :  contact_us_page.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Contact Us Form. 
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 27-September-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp" %>
<%@page session="false" %>
<%@page import="com.vorwerk.adc.workshop.core.util.AdcFSLConstants"%>
<%@page import="java.util.* "%>
<%@page pageEncoding="UTF-8"%>
<adc:restServiceUrl  var="contactUs" key="contactUs"/>
<input type="hidden" value="${contactUs}" id="contactUsUrl"/>
<adc:minifyUrlTag  var="contactsuccessPageUrl" actualUrl="${properties.contactsuccessUrl}" />
<input type="hidden" name="contactsuccessUrl" id="contactsuccessUrl" value="${contactsuccessPageUrl}">



<!-- contact form -->
    <section class="contact-form container">
		<div class ="col-md-12 text-right required-field">
                <p class="text-orange"><label style="color:red;">*</label> ${properties.requiredfield}</p>
        </div>
        <p class="hidden text-center ContactError" id="3001"></p>
        <div class="col-md-offset-2 col-md-8">
        
        <div class="row">
            <!--begin HTML Form-->
            <form class="form-horizontal contact-horizontal" id="contact" role="form" method="post">
			<div class="hidden" id="<%=AdcFSLConstants.INVALID_CONTACTUS_REQUEST%>" >${properties.invalidrequest}</div>
                 <div class="hidden" id="<%=AdcFSLConstants.MANDATORY_MESSAGE%>" >${properties.is_mandatory}</div>
         		 <div class="hidden" id="<%=AdcFSLConstants.SELECT_VALID_OPTION_MESSAGE%>" >${properties.selectValidOption}</div>
                <div class="hidden" id="<%=AdcFSLConstants.INVALID_CHARACTER_MESSAGE%>" >${properties.invalidCharacterError}</div>
                <div class="hidden" id="<%=AdcFSLConstants.TERMS_AGREE_MESSAGE%>" >${properties.checkboxerror}</div>
                <div class="hidden" id="<%=AdcFSLConstants.EMAIL_ERROR_MESSAGE%>" >${properties.emailErrorCheck}</div>

            <div class="form-group">
                <div id="error-icon"  class="col-sm-1 col-md-1 text-right hidden">   </div>
                <div class="col-sm-9 col-md-11 removeSpace">
                    <div id="lblEmailError" class="col-md-offset-4 col-md-8  hidden contactGlobalError"><div class="col-md-1 col-sm-1 col-xs-1 padding-zero"><img src="/content/dam/adc/fsl/images/global/en/desktopImages/error-icon.png" alt="error icon" width="25px"/></div><div class="col-md-11 col-xs-11 col-sm-11 padding-zero">${properties.errortext}</div></div>
                </div>
               
            </div>

            <div class="form-group">
                <label for="title" class="col-sm-3 text-right margin-title" name="title" >${properties.title} <label style="color:red;">*</label></label>
                <div class="col-sm-9">
                     <select class="form-control " id="title" aria-required="true" data-mandatory="true"  data-lbl="${properties.title}">
                        <option value="select">${properties.defaultoption}</option>
						 <c:forEach items="${properties.option}" varStatus="count+1" var="eachOption">
						 <option value="count.index">${eachOption}</option>
                         </c:forEach> 
                      </select>
                    <span class="error col-sm-12"></span>
                </div>
               
            </div> 


            <div class="form-group">
                <label for="contact_firstName" class="col-sm-3 text-right" >${properties.firstname} <label style="color:red;">*</label></label>
                <div class="col-sm-9 ">
                   <input type="text" class="form-control" id="contact_firstName" name="firstName" data-lbl="${properties.firstname}"  maxlength="25" aria-required="true"/>
                   <span class="error col-sm-12"></span>
                </div>

            </div>
                <div class="form-group">
                <label for="contact_lastName" class="col-sm-3 text-right">${properties.lastname} <label style="color:red;">*</label></label>
                <div class="col-sm-9 ">
                    <input type="text" class="form-control" id="contact_lastName" name="lastName" data-lbl="${properties.lastname}" maxlength="25" aria-required="true"/>
                    <span class="error col-sm-12"></span>
                </div>
                
            </div>
            <div class="form-group">
                <label for="contact_email" class="col-sm-3 text-right">${properties.emailaddr} <label style="color:red;">*</label></label>
                <div class="col-sm-9">
                    <input type="email" class="form-control " id="contact_email" name="email" data-lbl="${properties.emailaddr}"  maxlength="120" aria-required="true"/>
                    <span class="error col-sm-12"></span>
                </div>
            </div>

            <div class="form-group">
                <label for="contact_question" class="col-sm-3 text-right" >${properties.question} <label style="color:red;">*</label> </label>
                <div class="col-sm-9">
                    <select class="form-control " id="contact_question" name="question" data-mandatory="true" aria-required="true" data-lbl="${properties.question}">
                        <option value="select">${properties.defaultoption}</option>
                        <c:forEach items="${properties.option1}" varStatus="count" var="eachOption">
                            <option value="${count.index+1}">${eachOption}</option>
                            </c:forEach> 
                      </select>
                      <span class="error col-sm-12"></span>
                </div>

            </div>

            <div class="form-group">
                <label for="contact_Message" class="col-sm-3 text-right">${properties.message} <label style="color:red;">*</label></label>
                <div class="col-sm-9 ">
                    <textarea class="form-control" type="text" rows="10" id="contact_Message" name="Message" data-lbl="${properties.message}"  maxlength="1000" aria-required="true"></textarea>
                    <span id="errormess" class="error col-sm-12">Message ${properties.is_mandatory}</span>
                    <div class="hidden" id="<%=AdcFSLConstants.INVALID_CONTACT_US_MESSAGE%>" >${properties.alphnumericError}</div>

                </div>
            </div>

            <div class="form-group col-md-12 padding-zero checkboxOrange">
            <input type="checkbox" id="chkYesReceive" data-mandatory="true" >
                <label for="chkYesReceive"  aria-required="true" class="chkYesReceive">${properties.confirmtext} </label>
                 <span class="col-md-offset-3 col-sm-offset-3 error" id="contactcheckboxerrorspan"></span>

            </div>
            <div class="form-group">
                <div class="col-md-offset-3 col-md-9 col-sm-12  col-xs-12" >
                    <div class="ContactUs-loading">
                        	<div class="line-pulse"><div></div><div></div><div></div><div></div></div>
                   		 </div>
                    <input type="submit" id="contact_submit" class="btn-lg form-btn" value="${properties.submittext}" />
					
                </div>
				<span class="error"></span>
            </div>

            </form><!--end Form-->
        </div>
        
    </div><!--end col block-->

    </section>
