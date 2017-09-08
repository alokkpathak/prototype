<%--
    * Copyright (c)  Vorwerk POC
    * Program Name :  shippingAddress.jsp
    * Application  :  Vorwerk POC
    * Purpose      :  See description
    * Description  :  Lists User address details
    * Modification History:
* ---------------------
    *    Date                                Modified by                                       Modification Description
    *-----------                            ----------------                                    -------------------------
    * 28-Aug-2016                  Cognizant Technology solutions            					Initial Creation
    *-----------                           -----------------                                    -------------------------
    --%>
    
    <%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>

<adc:restServiceUrl  var="listAddress" key="listAddress"/>
<input type="hidden" value="${listAddress}" name="listAddressServiceUrl" id="listAddressServiceUrl"/>
<adc:restServiceUrl  var="setShippingAddress" key="setShipping"/>
<input type="hidden" value="${setShippingAddress}" id="setShippingaddressUrl"/>

<adc:restServiceUrl  var="setAllAddress" key="createUpdateAddress"/>
<input type="hidden" value="${setAllAddress}" id="setAllAddressUrl"/>

<adc:restServiceUrl  var="profiledetails" key="profiledetails"/>
<input type="hidden" value="${profiledetails}" id="profiledetailsServiceUrl"/>
<div class="hidden" id="phone_invalid">${properties.phoneNumberInvalid1}</div>

<div class="shipping-address" id="shipping-address" data-section="checkout" data-index="2">
    <div class="col-md-12 padding-zero">
        <div class="panel panel-default padding-zero">                    
            <div class="panel-heading " role="tab">               
                
                <span class="checkout-step pull-left" id="checkoutnumber">2</span>
                <h2 class="panel-title">${properties.panelText}<span class="pull-right glyphicon glyphicon-menu-down hidden"></span></h2>
            </div>
            <div class="panel-collapse collapse  " id="tabpanel" role="tabpanel">      
                <div id="shippingDetails" class="panel-body">  
                    <div class="address-loading">
                        <p>${properties.addressLoadingMessage}</p>
						<div class="line-pulse"><div></div><div></div><div></div><div></div></div>
                    </div>
                    <div class="shipping form col-md-12 padding-zero">
                        
                        
                        <div id="zero-addr" class="hidden"><cq:include script="shippingAddress_new_customer.jsp"/></div>
                        <div id="list-addr" class="hidden"><cq:include script="shippingAddress_existing_customer.jsp"/></div>
                        
                    </div>	
                    
                    
                    <!-- =======================================VAT form===================================================-->
                    
                    <div id="vatForUK" class="col-xs-12 col-sm-12 col-md-12 padding-zero">
                    <h4><u>${properties.vatformheading}</u></h4>
                    <div class="form-group col-xs-12 col-sm-12 col-md-12 checkboxOrange">
                        
                        <input type="checkbox" id="chkClaimData" name="check" value="None">	
                        <label for="chkClaimData" class="label-checkbox" >${properties.vatFormCheckBoxText}</label>
                    </div>
                    </div>

                        <cq:include path="vatFormComp" resourceType="/apps/adcworkshop/components/content/vatForm"/> 

                    <div class="proceedPay-loading">
						<div class="line-pulse"><div></div><div></div><div></div><div></div></div>
                    </div>
                    <div class="col-xs-12 col-sm-12 col-md-12 nxt-btn">
                        <button type="submit" href="#payment" id="paymentSection" class=" btn btn-lg button-orange  btnCheckoutNext valid" role="button" style="background-color:#E4572D;">${properties.nextButtonText}</button> 
                    </div>
                </div>
            </div> 
            
            
        </div>   
        
        
    </div>
</div>



