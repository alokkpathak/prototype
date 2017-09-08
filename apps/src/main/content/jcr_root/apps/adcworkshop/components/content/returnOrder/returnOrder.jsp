<%--
    * Copyright (c)  Vorwerk POC
    * Program Name :  returnOrder.jsp
        * Application  :  Vorwerk POC
            * Purpose      :  See description
                * Description  :  For displaying user orders.
                    * Modification History:
* ---------------------
    *    Date                                Modified by                                       Modification Description
    *-----------                            ----------------                                    -------------------------
    * 18-Aug-2016                  Cognizant Technology solutions            					Initial Creation
    *-----------                           -----------------                                    -------------------------
    --%>
    
    
    <%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page import="com.vorwerk.adc.workshop.core.util.AdcFSLConstants"%>
<%@page session="false" %>
<%@page pageEncoding="UTF-8"%>

<adc:restServiceUrl  var="createReturnUrl" key="createReturn"/>



<adc:minifyUrlTag  var="returnpolicyUrl" actualUrl="${properties.returnpolicylink}" />
<input type="hidden" name="returnpolicyUrl" id="returnpolicyUrl" value="${returnpolicyUrl}">
<input type="hidden" value="${createReturnUrl}" id="createReturnServiceUrl"/>
<section id="return-section" class="col-lg-9 padding-zero hidden container-fluid">
    <div class="details-container">
        
        <div id="returnOrderPlace"></div>
        <script id="return-template" type="text/x-handlebars-template">
            
            <form id="returnForm" action="">
                <div class="hidden" id="<%=AdcFSLConstants.MANDATORY_MESSAGE%>" >${properties.mandatoryMessage}</div>
                <div class="hidden" id="<%=AdcFSLConstants.TERMS_AGREE_MESSAGE%>" >${properties.mandatoryMessage}</div>	
                {{#order}}
                <input type="hidden" id="returnOrderId" value="{{this.increment_id}}" />
                    <input type="hidden" id="reorderEntityId" value="{{this.entity_id}}" />
                        <div class="col-lg-10 col-md-8 col-sm-8 padding-zero">
                            <h4>${properties.orderNumberLabel}{{this.increment_id}}</h4>
                            <p>${properties.cancellationDescription}</p>
                            <div class="return-error"></div>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 padding-zero">
            <hr/>
        </div>
            <div class="col-lg-6 col-sm-8 col-md-8  padding-zero">
                <h4>${properties.accountDetailsLabel}</h4>
                <div class="col-lg-12 padding-zero">
                    <div class="returnFields">
                        <span class="col-lg-12 padding-zero"><b>${properties.orderIdLabel}</b></span>
                        <span>{{this.increment_id}}</span>
        </div>	
        {{#each this.addresses}}
        {{#compare this.address_type "shipping" operator="=="}}
        <div class="returnFields">
            <span class="col-lg-12 padding-zero"><b>${properties.customerNameLabel}</b></span>
            <span>{{this.prefix}} {{this.firstname}} {{this.lastname}}</span>
        </div>
        <div class="returnFields">	
            <span class="col-lg-12 padding-zero"><b>${properties.shippingAddressLabel}</b></span>
            <span>{{this.street}}</span>
        </div>
        <div class="returnFields">
            <span class="col-lg-12 padding-zero"><b>${properties.emailAddressLabel}</b></span>
            <span>{{this.email}}</span>
        </div>
        {{/compare}}
        {{/each}}
        <div class="returnFields">
            <span class="col-lg-12 padding-zero"><b>${properties.productSealBrokenLabel}</b></span>    
        </div>
         <div class="col-xs-12">
          <span class="col-lg-12 padding-zero">${properties.asterisktextLabel}</span>
        </div>
        <div class="returnFields">
            <p>
                <input type="radio" name="seal" value="Yes"> ${properties.yesLabel}
          <input type="radio" name="seal" value="No" data-lbl="${properties.productSealBrokenLabel}" data-mandatory="true"> ${properties.noLabel}
          
          <span class="error col-md-12"></span>  
          
          
        </p>
        </div>
        </div>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 padding-zero">
            <hr/>
        </div>







            <div id="returnSubmitForm" class="hidden col-lg-6 col-md-8 col-sm-8 padding-zero">
                <h4>${properties.itemInfoLabel}</h4>
                <div class="form-group topSpacing">
                    <label for="item" class="padding-zero col-lg-12">${properties.itemLabel}</label>
                        <select id="prodReturnName" name="item" class="form-control" data-lbl="${properties.itemLabel}" data-mandatory="true">
                        
                    {{#each this.order_items}}
                        <option value="{{this.qty_ordered}}">{{this.name}}</option>
                    {{/each}}
                        <option value="all">All</option>
                        
                        
                        
        </select>
                    {{#each this.order_items}}
                        <input type="hidden" value="{{this.item_id}}" id="{{trimProductName this.name}}"/>
                    {{/each}}
                        
                        <span class="error col-md-12"></span>        
        </div>
                        
                        <div class="form-group topSpacing">
                        <label for="return-qty" class="padding-zero col-lg-12">${properties.quantityForReturnLabel}</label>
                        <select id="prodreturnQty" name="return-qty" class="form-control" data-lbl="${properties.quantityForReturnLabel}" data-mandatory="true">
                        
                        
        </select>
                        <span class="error col-md-12"></span>        
        </div>
                        
                        
                        <div class="form-group topSpacing">
                        <label for="return_comments" class="padding-zero">${properties.comments}</label>
                        <input id="return_comments" class="form-control valid" type="text" name="comments" data-lbl="${properties.comments}">
                        <span class="error col-md-12"></span>        
        </div>
		<div class="form-group topSpacing">
                        <span class="faceAdjust">${properties.disclaimertext}</span>

        </div>
                        
                        <a href="#" class="btn btn-lg button-orange" id="return-submit" style="background-color:#E4572D;">${properties.submitButtonLabel}</a>
        </div>

        </form>

                        
                        <div id="myreturnFormSubmitModal" class="modal fade" tabindex="-1">
                        <div class="modal-dialog ">
                        <div class="modal-content text-center">
                        <div class="col-xs-12 returnInfoWrap">
                        <button type="button" class="btn-link pull-right returnClose" aria-label="close" data-dismiss="modal">&#x274c;</button>
        </div>
                        <div class="modal-header">
                        
        </div>
                        
                        <div class="modal-body returnOrderBody">
                        ${properties.productSealBrokenNotification}
                        
        </div> <p><a href="${returnpolicyUrl}" target="_blank" onclick="return loadtosection();">${properties.returnpolicytext}</a></p>
                        <div class="modal-footer returnOrderFooter">

        </div>
        </div>
        </div>
        </div>

                    {{/order}}
        </script>
		<script>
    function loadtosection(){
	var location=$("#returnpolicyUrl").val()+"#legal-rights";
    window.open(location,'_blank');
	return false;
    }

</script>
    </div>
</section>