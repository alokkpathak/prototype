
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

<!--Sticky header-->


    <div class="col-md-12 col-sm-12 sticky_header hidden" style="background-color:#212121 ; position:fixed; top:0px;">

    <div class"productHead col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <div class="productTitle col-lg-7 col-md-6 col-sm-5 col-xs-6" style="color:#fff"></div>
            <div class="col-lg-2 col-md-3 col-sm-3 col-xs-3 priceBlock" style="color:white">
                <h3><span class="productPrice"></span>
                    <span class="productPriceDec"></span></h3>
                <span class="inclVat">${properties.includeVatText}</span>
            </div>
            <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3 pull-right productStickyButton">
               <a class="btn pull-right button-orange addbasketSticky addbasket">${properties.buybuttonText}</a>
            </div>
        	<div id="prod-spinnerError" class="prod-spinnerError sticky_error error_show col-md-12 col-sm-12 col-xs-12" ></div>
        </div>  

</div>
<div class="col-md-12 col-sm-12 col-xs-12 sticky_headerMobile hidden" style="background-color:#212121 ; position:fixed; top:0px;">

    <div class"productHead col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <div class="col-sm-8 col-xs-7">
            <div class="productTitle" style="color:#fff"></div>
            <div class="priceBlock" style="color:white">
                <h3><span class="productPrice"></span>
                    <span class="productPriceDec"></span></h3>
            </div>
            </div>
            <div class="col-sm-4 col-xs-4 pull-right productStickyButton">
               <a class="btn pull-right button-orange addbasketSticky addbasket">${properties.buybuttonText}</a>
            </div>
            <div id="prod-spinnerError" class="prod-spinnerError sticky_error error_show col-md-12 col-sm-12 col-xs-12" ></div>
        </div>
</div>

<!--Sticky header end-->

