<%--
    * Copyright (c)  Vorwerk POC
    * Program Name :  newletterforfooter.jsp
	* Application  :  Vorwerk POC
	* Purpose      :  See description
	* Description  :  Newsletter component for subscription.
	* Modification History:
	* ---------------------
	*    Date                                Modified by                                       Modification Description
	* -----------                            ----------------                                    -------------------------
	* 28-Aug-2016                  Cognizant Technology solutions            					Initial Creation
	* 31-August-2016                Cognizant Technology solutions                            NewsLetter Service Integration
	* 09-Sep-2016                   Cognizant Technology Solutions                              CSS changes
	*-----------                           -----------------                                    -------------------------
--%>
                    
<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<%@page import="com.vorwerk.adc.workshop.core.util.AdcFSLConstants"%>
<%@page pageEncoding="UTF-8"%>
<input type="hidden" value="${properties.invalidEmailFormat}" id="invalidEmailFormat"/>
<input type="hidden" value="${properties.emptycheckBoxtext}" id="emptycheckBoxtext"/>

<script>
    
    function hideandshowTabs(field){
        var d = field.findParentByType('tabpanel');	
        d.hideTabStripItem('cnewsletter'); 
        d.hideTabStripItem('fnewsletter');
        d.hideTabStripItem('ecnewsletter'); 
        var dialog = field.findParentByType('dialog');	
        var drop = dialog.getField("./newsletterselector");
        var val = drop.getValue();
        if(val=='cnewsletter'){
            d.unhideTabStripItem('cnewsletter');
            d.hideTabStripItem('fnewsletter');
            d.hideTabStripItem('ecnewsletter'); 
        }
        else if(val=='fnewsletter'){
            d.unhideTabStripItem('fnewsletter');
            d.hideTabStripItem('cnewsletter');
            d.hideTabStripItem('ecnewsletter'); 
        }
        else if(val=='ecnewsletter'){
            d.unhideTabStripItem('ecnewsletter');
            d.hideTabStripItem('cnewsletter');
            d.hideTabStripItem('fnewsletter'); 
        }
    }
</script>


<c:if test="${properties.newsletterselector eq 'cnewsletter'}">
    <section class="about">
        <div class="container-fluid">
            
            <div id="receiveNewsletter" class="col-md-offset-1 col-md-10  col-sm-12 about-heading">
                <h4 class="text-center">${properties.cheadlinetext}</h4>
                <div class="col-md-offset-2 col-md-8 col-sm-offset-1 col-sm-10 padding-zero">               
                    <div class="formWrapper">
                        <form class="form-inline" novalidate> 
                            <div class="col-md-offset-2 col-md-10 padding-zero">
                            <div class="form-group col-md-8 col-sm-12 padding-zero">
                                <label for="txtEmail" class="hidden">${properties.fheadlinetext}</label>   
                                <input type="email" class="form-control btn-sharp input-lg " id="txtEmail" placeholder="${properties.cemailaddress}" maxlength="120" aria-required="true">
                            </div>

                             <div class="col-md-4 padding-zero text-left hidden-xs hidden-sm">
                                <button type="button" class="btn btn-sharp btn-lg button-orange btn-validate-email"> ${properties.cbuttonname}</button>
                            </div>
                            </div>
							<span id="lblEmailError" class="lblEmailError col-md-12 col-sm-12 col-xs-12  text-center" tabindex="0"> </span>  
                            <div class="footer-desc-text col-md-12 hidden-xs hidden-sm padding-zero ">        
                                <span>${properties.commonlegaltext}</span>
                            </div>
                            <div class="checkboxOrange divChk col-md-12 col-sm-12 col-xs-12 padding-zero">
                                <input type="checkbox" value="None" id="squaredone" name="check" aria-required="true"/>
                                <label for="squaredone"><p>${properties.ccheckboxtext}</p> </label>          
                            </div>
                            <span id="lblCheckboxError" class="lblEmailError col-md-12 col-sm-12 col-xs-12 text-left" tabindex="0"> </span> 
							<div class="col-sm-12 col-xs-12 padding-zero text-center visible-xs visible-sm">
                                <button type="button" class="btn btn-sharp btn-lg button-orange btn-validate-email"> ${properties.cbuttonname}</button>
                            </div>
                        </form>

                        <div class="footer-desc-text col-xs-12 col-sm-12 visible-xs visible-sm padding-zero padding-nav2">        
                            <span>${properties.commonlegaltext}</span>
                        </div>	
                        
                    </div>
                    <div class="thankyouWrapper text-center">
                        <h3><strong>${properties.subscriptionsuccess}</strong></h3>
                    </div>
                    <div class="thankyouWrappererror text-center <%=AdcFSLConstants.EMAIL_SUBSCRIPTION_FAILED%>">
                        <h3><strong>${properties.subscriptionfailed} </strong></h3>
                    </div>
                    <div class="thankyouWrappererror thankyouWrappemailalreadyexists text-center <%=AdcFSLConstants.SUBSCRIPTION_EMAIL_EXISTS%> <%=AdcFSLConstants.SUBSCRIPTION_EMAIL_EXISTS_GUEST%>">
                        <h3><strong>${properties.emailexists} </strong></h3>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
</c:if>


<c:if test="${properties.newsletterselector eq 'fnewsletter'}">
    

    <p class="newsfooterlabel">${properties.fheadlinetext}</p> 
    <div class="row">
        <div class="col-md-12 col-xs-12">               
            <div class="formWrapper">
                <form class="form-inline" novalidate>   
                    <div class="form-group col-md-9 col-xs-12 padding-zero">
                        <label for="txtEmail" class="hidden">${properties.fheadlinetext}</label> 
                        <input type="email" class="form-control btn-sharp input-lg " id="txtEmail" placeholder="${properties.femailaddress}" maxlength="120" aria-required="true">
                    </div>
                    <div class="col-md-3 hidden-sm hidden-xs footerbutton">
                        <button id="footerNews" type="button" class="btn  btn-lg button-orange btn-validate-email">${properties.fbuttonname}</button>
                    </div>
					 <span id="lblEmailError" class="lblEmailError col-md-12 col-sm-12 col-xs-12" tabindex="0"></span> 
                    <div class="footer-desc-text hidden-xs hidden-sm col-md-12 padding-zero">        
                        <span>${properties.footerlegaltext}</span>
                    </div>
                    <div class="checkboxOrange divChk col-md-12 col-xs-12 ">
                        <input type="checkbox" value="None" id="squaredThree" name="check" aria-required="true"/>
                        <label for="squaredThree" class="alignrelative"><p>${properties.fcheckboxtext}</p></label>          
                    </div>
                    <span id="lblCheckboxError" class="lblEmailError col-md-12 col-sm-12 col-xs-12 text-left" tabindex="0"> </span> 
					<div class="col-xs-12 col-sm-12 visible-sm visible-xs footerbutton">
                        <button id="footerNews" type="button" class="btn  btn-lg button-orange btn-validate-email">${properties.fbuttonname}</button>
                    </div>
                </form>

            </div>
            <div class="thankyouWrapper">
                <h3><strong>${properties.subscriptionsuccess}</strong></h3>
            </div>
            <div class="thankyouWrappererror text-center <%=AdcFSLConstants.EMAIL_SUBSCRIPTION_FAILED%>">
                <h3><strong>${properties.subscriptionfailed} </strong></h3>
            </div>
            <div class="thankyouWrappererror thankyouWrappemailalreadyexists text-center <%=AdcFSLConstants.SUBSCRIPTION_EMAIL_EXISTS%> <%=AdcFSLConstants.SUBSCRIPTION_EMAIL_EXISTS_GUEST%>">
                <h3><strong>${properties.emailexists} </strong></h3>
            </div>
        </div>
    </div> 
    
    
</c:if>
<c:if test="${properties.newsletterselector eq 'ecnewsletter'}">
    <section class="container-fluid padding-zero">
        <div class="col-md-12" >
            
            <div class="col-md-offset-2 col-md-8 padding-nav text-center">        
                <div class="sub-container " style="background-color:#E4572D;" >
                    <img id="mailId" src="${properties.imagepath}" class="padding-nav" alt="${properties.imagealt}">
                    <h2>${properties.echeadlinetext}</h2>
                    <p>${properties.subtext}</p>
                    <div class=" col-lg-offset-1 col-lg-10 col-md-12 col-sm-12 padding-left">               
                        <div class="formWrapper">
                            <form class="form-inline" >
                                <label for="txtEmail" class="hidden">${properties.fheadlinetext}</label> 
                                <label  for="txtEmail" class="col-md-12 col-sm-12 text-left hidden-xs">${properties.ecemailaddress}</label>
                                <div class="form-group col-md-8 col-sm-8 col-lg-8 padding-left">
                                    
                                    <input type="email" class="form-control btn-sharp input-lg " id="txtEmail" value="" maxlength="120" aria-required="true">
                                </div>
                                <div class="col-md-4 padding-zero col-sm-4 hidden-xs">
                                    <button type="button" id="newsletter" class="btn  btn-lg button-orange btn-validate-email">${properties.ecbuttonname}</button>
                                </div>
                                <span id="lblEmailError" class="lblEmailError col-md-12 col-sm-12 col-xs-12" style="color:white" tabindex="0"></span>
                                <div class="footer-desc-text col-md-12 col-sm-12 hidden-xs"  style="color:white">        
                                    <span>${properties.ecommercelegaltext}</span>
                                </div>
                                <div class="divChk col-md-12 col-sm-12 col-xs-12">
                                    <label for="chkEmail"><input id="chkEmail" class="thankyouAgree" name="chkEmail" type="checkbox" aria-required="true" ></label>
                                    ${properties.ecommerceTermsandConditionsText}     
                                </div>
                                <span id="lblCheckboxError" class="lblEmailError col-md-12 col-sm-12 col-xs-12 text-left" style="color:black" tabindex="0"> </span>
                                <div class=" padding-zero col-xs-12 visible-xs">
                                    <button type="button" id="newsletter" class="btn  btn-lg button-orange btn-validate-email">${properties.ecbuttonname}</button>
                                </div>
                                <div class="footer-desc-text col-xs-12 visible-xs"  style="color:white">        
                                    <span>${properties.ecommercelegaltext}</span>
                                </div>
                                
                            </form>


                        </div>
                        <div class="thankyouWrapper text-center">
                            <h3 style="color:white"><strong>${properties.subscriptionsuccess}</strong></h3>
                        </div>
                        <div class="thankyouWrappererror text-center <%=AdcFSLConstants.EMAIL_SUBSCRIPTION_FAILED%>">
                            <h3 style="color:white"><strong>${properties.subscriptionfailed}</strong></h3>
                        </div>
                        <div class="thankyouWrappererror thankyouWrappemailalreadyexists text-center <%=AdcFSLConstants.SUBSCRIPTION_EMAIL_EXISTS%> <%=AdcFSLConstants.SUBSCRIPTION_EMAIL_EXISTS_GUEST%>">
                            <h3><strong>${properties.emailexists} </strong></h3>
                        </div>
                        
                    </div>
                </div> 
            </div>    
        </div>
    </section>
</c:if>
