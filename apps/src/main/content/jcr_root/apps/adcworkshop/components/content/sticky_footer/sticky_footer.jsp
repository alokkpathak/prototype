<%--
* Copyright (c)  Vorwerk POC
* Program Name :  sticky_footer.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Sticky footer is a sticky bar that follows users as they scroll down the page, allowing them to subscribe in one click.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 11-Jul-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<%@page import="com.vorwerk.adc.workshop.core.util.AdcFSLConstants"%>
<input type="hidden" value="${properties.invalidEmailFormat}" id="invalidEmailFormatSticky"/>
<input type="hidden"  value="${properties.timeOutSeconds}" id="stickyfooterTime"/>
<!--Sticky footer links-->
<div class="container-fluid stickyFooter hidden-md hidden-xs hidden-sm">
    <div class="row">
        <div class="col-md-12 "> 
            <button class="pull-right closestickyfooter">&times;</button>
            <h2>${properties.headlinetext}</h2>             
            <div class="formWrapper">
                <form class="form-inline" novalidate>   
                    <div class="form-group col-md-4 ">
                        <label for="txtEmail" class="hidden">Please Enter Your Email ID</label>
                        <input type="email" class="form-control btn-sharp input-lg pull-right" id="txtEmail" placeholder="${properties.placeHolderText}" maxlength="120" aria-required="true">
                    </div>
                    <div class="checkboxOrange divChk col-md-5">
                        <input type="checkbox" value="None" id="squaredTwo" name="check" aria-required="true"/>
                        <label for="squaredTwo"><p>${properties.checkboxDesc}</p></label>          
                    </div>
                    <div class="col-md-3">
                        <button id="stickynews" type="button" class="btn  btn-lg button-orange btn-validate-email">${properties.buttonText}</button>
                    </div>
                    <div class="footer-desc-text col-md-10 padding-left" >        
                        <span>${properties.stickyfootlegaltext}</span>
                	</div>
                </form>
                <span id="lblEmailError" class=" col-md-12 lblEmailError stickyFooterlblEmailError" tabindex="0" ></span>
                <span id="lblCheckboxError" class="col-md-12 text-center lblEmailError stickyFooterlblEmailError" tabindex="0" ></span>
                
            </div>
            <div class="thankyouWrapper text-center">
                <h3><strong>${properties.subscriptionsuccess}</strong></h3>
            </div>
            <div class="thankyouWrappererror text-center <%=AdcFSLConstants.EMAIL_SUBSCRIPTION_FAILED%> ">
                <h3><strong>${properties.subscriptionfailed}</strong></h3>
            </div>
            <div class="thankyouWrappererror thankyouWrappemailalreadyexists text-center <%=AdcFSLConstants.SUBSCRIPTION_EMAIL_EXISTS%> <%=AdcFSLConstants.SUBSCRIPTION_EMAIL_EXISTS_GUEST%>">
                <h3><strong>${properties.semailexists} </strong></h3>
            </div>
        </div>
    </div>            
</div>
<!--Sticky footer links end-->