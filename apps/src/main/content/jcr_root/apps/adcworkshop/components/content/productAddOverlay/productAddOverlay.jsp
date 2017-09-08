<%--
* Copyright (c)  Vorwerk POC
* Program Name :  productAddOverlay.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  This component is used for the page where customers can create or login into the account.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 09-Aug-2016                  Cognizant Technology solutions                                                                                 Initial Creation
*-----------                           -----------------                                    -------------------------
--%>
<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<adc:minifyUrlTag  var="productViewCartUrl" actualUrl="${properties.viewBasketCTA}"/>
<input type="hidden" name="productViewCartUrl" id="productViewCartUrl" value="${productViewCartUrl}">
<section class="testimonial">
    <div id="myModal-1" class="modal fade" tabindex="-1">
        <div class="modal-dialog ">
            <div class="modal-content">
                <div class="modal-header padding-zero">
                    <button type="button" class="close" aria-label="close" data-dismiss="modal">&times;</button>
                    
                </div>
                <div class="modal-body ">
                    <h2 class="modal-title text-center h4">${properties.productOverlayTitle}</h2>
                    <div class="col-md-12 col-sm-12 col-xs-12 padding-zero">
                    <div class="col-md-4 col-xs-4">
                        <img src="/content/dam/adc/fsl/images/global/en/view0.jpg" id="prod-img" class="img-responsive pull-left" alt="${properties.productimagealt}" width="150" height="150" />
                    </div>
                    <div class="col-md-5 col-xs-5 padding-nav">
                        <h3><div id="prod-title"></div></h3>
                        <p>${properties.quantitylabel} <span id="prod-quantity">0</span></p>
                    </div> 
                    <div class="col-md-3 col-xs-3 padding-nav">
                        <div class="h3"><span id="prod-price">0</span><span id="prod-priceDec">0</span></div>
                        <span class="vat">${properties.vatlabelText}</span>
                    </div>
                    </div>
                </div>
                <div class="clearfix "></div>
                <div class="modal-footer">
                    <div class="back-to-shop col-xs-12">
                        <a href="#" class="btn btn-lg cancel"  data-dismiss="modal" role="button" >${properties.backToShopButtonText}</a> 
                    </div>
                    <div class="view-basket col-xs-12 padding-zero">
                        <a href="${properties.viewBasketCTA}" class="btn btn-lg button-orange "  style="background-color:#E4572D;">${properties.viewBasketButtonText}</a>
                    </div>
                    
                    <div class="col-md-12 col-xs-12 margin-top" style="background-color:#f4f2f4;">
                        <cq:include path="./dynamicCross" resourceType="adcworkshop/components/content/dynamiccrossselling" />
                    </div>
                    
                    
                </div>
            </div>
        </div>
    </div>

</section>
