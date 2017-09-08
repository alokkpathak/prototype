<%--
* Copyright (c)  Vorwerk POC
* Program Name :  payment_type.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  To choose the payment type.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 18-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>

<adc:restServiceUrl  var="createNewOrder" key="createOrder"/>
<adc:restServiceUrl  var="payonPayPalservice" key="payonandPayPal" skip="true"/>
<adc:minifyUrlTag  var="cancelOrder" actualUrl="${properties.cancelmyorder}" />
<input type="hidden" name="cancelOrder" id="cancelOrder" value="${cancelOrder}">
<input type="hidden" value="${createNewOrder}" id="createorderUrl"/>
<input type="hidden" value="${payonPayPalservice}" id="payonPayPalURL"/>
<adc:restServiceUrl  var="paymentmethod" key="paymentMethods"/>
<input type="hidden" value="${paymentmethod}" id="paymentmethodURL"/>
<input type="hidden" value="${properties.brandlabeltext}" id="brandlabeltext"/>
<input type="hidden" value="${properties.expirylabeltext}" id="expirymonthlabeltext"/>
<input type="hidden" value="${properties.cvvInfoText}" id="cvvInfoText"/>
<div class="row payment-step">
<div class="col-md-12 padding-zero">
 <div class="payment" id="payment" data-section="checkout" data-index="3">
    <div class="col-md-12 padding-zero">
                    <div class="panel panel-default padding-zero">                    
                <div class="panel-heading " role="tab">     
                    <span class="checkout-step pull-left">3</span>
                    <h2 class="panel-title">${properties.paymentnextTitle}<span class="pull-right glyphicon glyphicon-menu-down hidden"></span></h2>
                </div>
                <div class="panel-collapse collapse" role="tabpanel" >
                    <div  id="paymentDetails" class="panel-body">
				<div class="col-md-10 padding-zero">
                    <cq:include path="coupon_voucher" resourceType="/apps/adcworkshop/components/content/coupon" /> 


                         <cq:include path="view_basketpayment" resourceType="/apps/adcworkshop/components/content/viewCheckoutBasket" /> 


                        		
                        </div>  
                    </div>
                    <div class="col-md-12 padding-zero">
                        <div id="condCheckId">
                            <div>
                                <h4>${properties.reviewconditionslabel}</h4>
                            </div>
                            
                            <div class="form-group checkboxOrange col-md-12 padding-zero">								 	
                                
                                <input type="checkbox" id="termscondCheckId" value="None" name="check" >			
                                <label for="termscondCheckId"><p>${properties.conditionslabel} <a x-cq-linkchecker="skip" href ="${cancelOrder}" target="_blank">${properties.termsConditions}</a>${properties.conditionsLabelLine2} <a x-cq-linkchecker="skip" href="${cancelOrder}#cancel-return-policy" onclick="return loadtosection();" >${properties.cancelmyordertext}</a></p></label>	
								<span class="col-xs-12 col-md-12 termscondCheckError error">${properties.notcheckederror}</span>
                                
                            </div> 
				<span class="hidden error_show" id="termCondError">${properties.notcheckederror}</span>
                        </div>
                        <h4 class ="paymenttitle">${properties.paymenttitle}</h4>
                    </div>
                    <div class="col-md-12 text-center hidden" id="paymentCardsLink">
                        <a href="#" data-toggle="modal" class="text-orange" role="dialog">${properties.changepaymenttitle}</a>
                    </div>
                    <div class="payOptions-loading"><div class="line-pulse"><div></div><div></div><div></div><div></div></div></div>
                    <div class="payment-method col-md-12 hidden" id="paymentMethodView">																		
                        <div class="col-md-6 padding-zero">												
                            <p class="text-center">${properties.cctitle}</p>
                            <div class="col-md-12 col-sm-12 col-xs-12 padding-zero paycards nav-justified">
                                <c:set var="cardsarray" value="${properties.ccmulti}"/> 
                                <c:forEach items="${cardsarray}" varStatus="imagelist">
                                    <div class="col-md-3 col-sm-3 col-xs-4  padding-zero">									
                                        <img src="${cardsarray[imagelist.index]}" class="center-block payment-images">
                                    </div>
                                </c:forEach>
                                
                            </div>
                            <div class="col-md-12 text-center">
				<input name="cartType" type="radio" id="payon_cc" class="rad-btn" data-target="paymentCardDetailsView" >
                                <label for="payon_cc"></label>
                            </div>
                            
                        </div>
                        <div class="col-md-3 padding-xs">
                            <p class="text-center">${properties.otmthdtitle}</p>

                                <div class="col-md-12 nav-justified padding-zero paypalcards">
                                    <img src="${properties.paypalimage}" class="center-block payment-images" alt="" >
                                </div>

                             <div class="text-center">
                       <input name="cartType" type="radio" id="payon_paypal" class="rad-btn"  data-target="paypalCardDetailsView">
                                <label for="payon_paypal"></label>
                            </div>
                        </div>										
                    </div>
					<div  class="col-xs-12 col-sm-12 text-center col-md-12 ">
                        <button  class="btn btn-lg button-orange valid zeroorderbutton hidden"  role="button">${properties.zeropricebutton}
						</button>
					</div> 
                </div>
            </div>	
        </div>	
    </div>
</div>	
</div>
<script>
    function loadtosection(){
	var location=$("#cancelOrder").val()+"#cancel-return-policy";
    window.open(location,'_blank');
	return false;
    }

</script>

