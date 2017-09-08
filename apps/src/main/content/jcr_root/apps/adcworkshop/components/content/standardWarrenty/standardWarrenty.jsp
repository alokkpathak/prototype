<%--
* Copyright (c)  Vorwerk POC
* Program Name :  standardWarrenty.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  StandardWarrenty for extending the warranty
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 31-AUG-2016                  Cognizant Technology solutions            					 Initial Creation
*-----------                           -----------------                                    -------------------------
--%>
    <%@include file="/apps/adcworkshop/components/shared/global.jsp" %>
	<%@page session="false" %>
	<%@page import="com.vorwerk.adc.workshop.core.util.AdcFSLConstants"%>
	<%@page import="java.util.* "%>

<adc:restServiceUrl  var="extendWarranty" key="extendWarranty"/>
<input type="hidden" value="${extendWarranty}" id="extendWarrantyServiceUrl"/>
<div class="hidden" id="<%=AdcFSLConstants.INVALID_SERIAL_NUMBER%>" >${properties.invalidSerialNumberMessage}</div>

<section id="stdWarrenty" class="col-lg-12 hidden container-fluid account-details-well">
    <div class="details-container">
        <h2 class="h4">${properties.title}</h2>
        <div id="warrenty-section">
            <p class="button-center">${properties.subtitle}</p>
            <div class="col-lg-12 padding-zero div-hr">
                <hr/>
            </div>
            
            <form id="warrentyForm" action="">
                <div class="hidden" id="<%=AdcFSLConstants.MANDATORY_MESSAGE%>" >${properties.warranty_error_mandatory}</div>
                <div class="hidden" id="<%=AdcFSLConstants.TERMS_AGREE_MESSAGE%>" >${properties.checkboxError}</div>
				

                <div class="topSpacing col-lg-7 padding-zero button-center col-xs-10 col-sm-9">
                    <label for="serialNo" class="topSpacing serialNumberLabel col-lg-12 col-sm-12 col-xs-12 padding-zero button-center">${properties.serno} *</label>      
                    
                    <input id="serialNo" type="text" name="serialNo" class="col-md-12" data-lbl="${properties.serno}" aria-required="true">
                    <span  class="error col-md-12" id="warrantyInvalidMesg" ></span>
                </div>
                
                 <span class="error_show col-lg-7 col-xs-10 col-sm-10 col-md-10" id="<%=AdcFSLConstants.SERIAL_NUMBER_DUPLICATE_WARRANTY%>">
                    ${properties.dupilcateWarrantyErrorMsg}
                </span>
                <span class="hidden error_show col-lg-7 col-xs-10 col-sm-10 col-md-10" id="invalid_warrenty">
                    ${properties.invalidWarrantyErrorMsg}
                </span>
                <div class="form-group col-md-12 col-xs-12 col-sm-12 padding-zero checkboxOrange">	
                    <input type="checkbox" id="Pleaseread" data-mandatory="true" aria-required="true">
                    <label id="Pleasereaduncheck" for="Pleaseread"><p>${properties.accept} <a href="#myModal-account" data-toggle="modal" role="dialog" "${properties.popuplink}"><u>${properties.popup}</u></a><p></label>							   								  
                    <span id="warrantyAccept" class="error col-md-12"></span>
                </div> 
                <c:if test = "${properties.extendwarrentycheckbox1 eq 'Yes'}" >
                    
                    <div class="form-group col-md-12 col-xs-12 col-sm-12 padding-zero checkboxOrange">	
                        <input type="checkbox" id="Pleasecheck" >
                        <label for="Pleasecheck"><p>${properties.ectwarrenty}<p></label>
                        
                    </div>
                </c:if> 
                
                
                <div class="topSpacing col-md-12 hidden-xs hidden-sm padding-zero button-center warrentybutton">
                    <div class="Warrenty-loading">
                        <div class="line-pulse"><div></div><div></div><div></div><div></div></div>
                    </div>
                    <a href="#" id="warrtySubmit" class="btn btn-lg button-orange" role="button" style="background-color:#E4572D;">${properties.buttontext}</a> 
                </div>
                 <div class="topSpacing col-xs-12 col-sm-12 visible-xs visible-sm padding-zero button-center warrentybutton">
                     <div class="Warrenty-loading">
                        <div class="line-pulse"><div></div><div></div><div></div><div></div></div>
                    </div>
                    <a href="#" id="xswarrtySubmit" class="btn btn-lg button-orange" role="button" style="background-color:#E4572D;">${properties.buttontext}</a> 
                </div>

            </form>
        </div>
        <div id="warrenty-success" class="hidden">
            <p>${properties.successText}</p>
            <a href="#" id="warrenty-back" class="" role="button"><u>${properties.enterSerialNumLabel}</u></a> 
        </div>
        
    </div>
</section> <div id="standardWarrentyinfoModal" class="modal fade" tabindex="-1">
<div class="modal-dialog">    
    <div class="modal-content">
        <div class="modal-header padding-right">
            <button type="button" class="close" aria-label="close" data-dismiss="modal">&times;</button>
        </div>
        <div class="modal-body coupontootipBody">
            ${properties.stdPopUpText}
        </div>            
    </div>
    
</div>
</div>

