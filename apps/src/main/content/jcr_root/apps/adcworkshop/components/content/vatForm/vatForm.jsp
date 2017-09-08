<%--
* Copyright (c)  Vorwerk POC
* Program Name :  vatForm.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  VAT form for UK
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 28-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>
	
<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<%@page pageEncoding="UTF-8"%>	
<adc:restServiceUrl  var="createVatDeclarationAddress" key="vatAddress"/>	
<input type="hidden" value="${createVatDeclarationAddress}" id="createVatDeclarationAddressURL"/>
<%

String[] multiVatlist = {"vdescription", "vatItalyPDFPath","vdescriptionlink"};
pageContext.setAttribute("vatmultifields", multiVatlist);
%>
<adc:multicompositefield var="vatList" fieldNodeName="vatmulti" fieldPropertyNames="${vatmultifields}" returnType="List" />
<script>

    function hideandshowTabs(field){
        var d = field.findParentByType('tabpanel');	
        d.hideTabStripItem('uk_tab_open'); 
        d.hideTabStripItem('it_tab_open');
        var dialog = field.findParentByType('dialog');	
        var drop = dialog.getField("./vatCountry");
        var val = drop.getValue();
        if(val=='uk_tab_open'){
            d.unhideTabStripItem('uk_tab_open');
            d.hideTabStripItem('it_tab_open');		
        }
        else if(val=='it_tab_open'){
            d.unhideTabStripItem('it_tab_open');
            d.hideTabStripItem('uk_tab_open'); 
        }
    }
</script>
<div class="value-tax col-md-12 col-xs-12">
<div class="vatform-global-message"></div>
<c:if test="${properties.vatCountry eq 'uk_tab_open'}">
    
    <p>${properties.vatDesc}</p>
    <div class="form-group  col-md-12">
        <div class=" col-md-6">
            <label for="claimMyself">
                <input type="radio" id="claimMyself" name="claimGroup" value="0" class="claimMyself valid"> ${properties.checkBoxSelf}
            </label>
        </div>
        <div class="col-md-6 ">
            <label for="climBehalf">
                <input type="radio" id="climBehalf" name="claimGroup" value="1" class="climBehalf valid"> ${properties.checkBoxOthers}
            </label>
        </div>
    </div>
    <div class="col-md-7">
        <div class="form-group ">
            <label for="tax_FirstName" class="col-md-12 padding-zero">${properties.vatFirstName}*</label>
            <input id="tax_FirstName" class="col-md-8 form-control tax_FirstName" type="text" name="tax_FirstName" data-lbl="${properties.vatFirstName}" maxlength="50" aria-required="true">
            <span class="error col-md-12"></span>
        </div>

        <div class="form-group ">
            <label for="tax_LastName" class="col-md-12 padding-zero">${properties.vatLastName}*</label>
            <input id="tax_LastName" class="col-md-8 form-control tax_LastName" type="text" name="tax_LastName" data-lbl="${properties.vatLastName}" maxlength="50" aria-required="true">
            <span class="error col-md-12"></span>
        </div>

        <!-- Added for QAS On Demand Address START -->
        <div class="hidden" id="addrlookupCheck">
            <div class="form-group col-md-12 padding-left text-orange " id="vat_FindAddress">
                <span class="Addfind">${properties.findMyAddressLabel}</span>
            </div>
            <div class="form-group col-md-12 padding-left text-orange hidden" id="vat_ManualAddress">
                <span class="Addfind">${properties.enterAddressManuallyLabel}</span>
            </div>
        </div>
        <!-- Added for QAS On Demand Address END -->
        
        <div class="hidden" id="vat_ManualAddressData">
            <div class="form-group">
                <label for="tax_HomeAddress" class="col-md-12 padding-zero">${properties.vatFormAddress}*</label>
                <input id="tax_HomeAddress" class="col-md-8 form-control tax_HomeAddress" type="text"  name="tax_HomeAddress" data-lbl="${properties.vatFormAddress}" placeholder="${properties.addressPlaceHolder1}" maxlength="35" aria-required="true">
                <span class="error col-md-12"></span>
            </div>
            <div class="form-group">
                <label for="tax_HomeAddressOne" class="col-md-12 padding-zero">${properties.vatFormAddress1}</label>
                <input id="tax_HomeAddressOne" class="col-md-8 form-control tax_HomeAddressOne valid" type="text" name="tax_HomeAddressOne" data-lbl="${properties.vatFormAddress1}" placeholder="${properties.addressPlaceHolder2}" maxlength="35" aria-required="true">
            </div>
            <div class="form-group ">
                <div class="col-md-5 col-xs-6 padding-left">
                    <label for="tax_PostalCode" class="col-md-12 padding-zero">${properties.vatPostalCodeLabel}*</label>
                    <input id="tax_PostalCode" class="col-md-12 form-control tax_PostalCode" type="text" name="tax_PostalCode" data-lbl="${properties.vatPostalCodeLabel}" maxlength="10" aria-required="true">
                    <span class="error col-md-12 postalcode_tax_error_text"></span>
                </div>
                <div class="col-md-7 col-xs-6 padding-zero">
                    <label for="tax_City" class="col-md-12 padding-zero">${properties.vatCityField}*</label>
                    <input id="tax_City" class="col-md-7 form-control tax_City" type="text" name="tax_City" data-lbl="${properties.vatCityField}" maxlength="50" aria-required="true"> 
                    <span class="error col-md-12 tax_city_error_text"></span>
                </div>
                <div class="row"><div class="col-md-12"><span class="error" id="postalcode_tax_error"></span></div></div>
 				<div class="row"><div class="col-md-12"><span class="error" id="tax_city_error"></span></div></div>
                </div>
        </div> 
        
        <!-- Added for QAS On Demand Address START -->
        <div class="hidden" id="vat_FindAddressData">
            <div class="form-group" >
                <div class="col-md-4 col-xs-6 padding-left">
                    <label for="contact_postCode_vat" class="col-md-12 padding-zero">${properties.vatPostalCodeLabel}*</label>
                    <input id="contact_postCode_vat" class="col-md-12 form-control"  type="text" name="postCode" data-lbl="${properties.vatPostalCodeLabel}" autocomplete="off" minlength="4" maxlength="10" aria-required="true">
                    <span class="error col-md-12"></span>
                </div>
                <div class="col-md-8 col-xs-6 padding-left">
                    <div class="col-md-6 padding-left">
                        <a class="btn btn-lg AddressBtn" disabled="disabled" id="AddresssFind_vat">${properties.findAddressButton}</a>
                    </div>
                </div>

            </div>
            <div class="hidden " id="ShowAddress_vat">
                <div class="form-group">
                    <label class="col-md-12 col-sm-12 col-xs-12 padding-zero">${properties.selectAddressLabel}</label>
                    <select class="valid col-md-12 form-control qas-address-selection qas-address-vat" id="vat" name="address">
                        <option value="select">${properties.selectAddressOptionsDropDown}</option>

                    </select>
                </div>
                <div class="form-group">
                    <label for="vat_addressline_one" class="col-md-12 padding-zero">${properties.vatFormAddress}*</label>
                    <input id="vat_addressline_one" class="col-md-12 form-control vat_addressFind_one" type="text" name="addressline_one" data-lbl="${properties.vatFormAddress}" placeholder="${properties.addressPlaceHolder1}" maxlength="35" aria-required="true">
                    <span class="error col-md-12"></span>
                </div>
                <div class="form-group">
                    <label for="vat_addressline_two" class="col-md-12 padding-zero">${properties.vatFormAddress1}</label>
                    <input id="vat_addrssline_two" class="col-md-12 form-control vat_addressFind_two valid" type="text" name="addressline_two" data-lbl="${properties.vatFormAddress}" placeholder="${properties.addressPlaceHolder1}" maxlength="35" aria-required="true">
                    <span class="error col-md-12"></span>
                </div>
                <div class="form-group">
                    <label for="vat_contact_city" class="col-md-12 padding-zero">${properties.vatCityField}*</label>
                    <input id="vat_contact_city" class="col-md-12 form-control vat_addressFind_city" type="text" name="city" data-lbl="${properties.vatCityField}" maxlength="50" aria-required="true">
                    <span class="error col-md-12"></span>
                </div>
            </div>
        </div>
        <!-- Added for QAS On Demand Address END -->
        <div class="form-group vatDateOfBirth ">
            <label for="contact_date" class="col-md-12 col-xs-12 padding-zero">${properties.vatDOBField}*</label>
            <div class="col-md-2 col-xs-3 padding-left topSpacing">
                
                <input id="tax_day" class="col-md-12 form-control tax_day" type="text" name="tax_day" data-lbl="DD" placeholder="DD" maxlength="2" aria-required="true">                
            </div>
            <div class="col-md-2 col-xs-3 padding-left topSpacing">
                <input id="tax_month" class="col-md-12 form-control tax_month" type="text" name="tax_month" data-lbl="MM" placeholder="MM" maxlength="2" aria-required="true">               
            </div> 
            <div class="col-md-3 col-xs-4 padding-left topSpacing">
                <input id="tax_year" class="col-md-4 form-control tax_year" type="text" name="tax_year" data-lbl="YYYY" placeholder="YYYY" maxlength="4" aria-required="true">             
            </div>
            <input type="text" id="customDatePicker" style="display:none;">
            <img src="${properties.calendarIconImage}" id="datepickerIcon" class="col-md-2 col-xs-2 imgSwap img-responsive" desk-img="${properties.calendarIconImageDesktop}" mob-img="${properties.calendarIconImageMobile}"></img>
			
            <span class="error col-md-12 col-xs-12"></span>
			<span class="error col-md-12 tax_day_error col-xs-12 dateFields" id="tax_day"></span>
			<span class="error col-md-12 tax_month_error col-xs-12 dateFields" id="tax_month"></span>
			<span class="error col-md-12 tax_year_error col-xs-12 dateFields" id="tax_year"></span>         
        </div> 

        <div class="form-group col-md-12 col-xs-12 padding-zero" style="position:relative" >
            <div class="checkboxOrange">
                <input type="checkbox" id="Receive" value="None" name="check" value="1" aria-required="true" disabled="disabled" checked="checked">
                <label for="Receive" class="checked"><p>${properties.checkBoxPur}</p></label>
            </div>
            </div>

        
        <div class="form-group col-md-12 col-xs-12 padding-zero checkboxOrange savedata ">

            <input type="checkbox" id="chkSaveDataone" value="None" name="check" aria-required="true" disabled="disabled" checked="checked" >	
            <label for="chkSaveDataone" class="checked"><p>${properties.checkBoxDis}</p></label>
        </div>
        </div>
    </c:if>
    </div>



<c:if test="${properties.vatCountry eq 'it_tab_open'}">
   <div class="row divInfo" id="vatForIT">
        <div class="col-xs-12 col-sm-12 col-md-12 vatWrapit">
            <p><img src="${properties.imagePathVAT}" class="icon-info vatinfowrap img-responsive" alt="${properties.vatimagealt}"/>
                <c:forEach items="${vatList}" var="vatlist" varStatus="i">
                    <c:choose>
                        <c:when test="${i.index==0}">
                            ${vatlist.vdescription}<a href="${vatlist.vatItalyPDFPath}" target="_blank">${vatlist.vdescriptionlink}</a></p>
                    </c:when>
                    <c:otherwise>
                        <p>${vatlist.vdescription}<a href="${vatlist.vatItalyPDFPath}" target="_blank">${vatlist.vdescriptionlink}</a></p>
                    </c:otherwise>
                </c:choose>	  

            	</c:forEach>
        </div>
    </div>

    
</c:if>