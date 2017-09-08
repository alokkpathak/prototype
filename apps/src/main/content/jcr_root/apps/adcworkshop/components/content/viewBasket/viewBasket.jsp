<%--
* Copyright (c)  Vorwerk POC
* Program Name :  viewBasket.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  For viewing products in the basket.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 23-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %> 

<%

String[] multifeaturelist = {"featureimage", "featureText","mobilefeatureimage"};

pageContext.setAttribute("featuremultifields", multifeaturelist);

%>
<adc:multicompositefield var="featuresList" fieldNodeName="multifeatures" fieldPropertyNames="${featuremultifields}" returnType="List" />

<adc:restServiceUrl  var="viewCart" key="viewCart"/>

<adc:restServiceUrl  var="removeCartItem" key="removeItem"/>

<adc:restServiceUrl  var="updateCart" key="updateCartQty"/>

<adc:restServiceUrl  var="voucherCodeUrl" key="updateVoucherCode"/>

<adc:imageSkuQueryTag var="skuAndImageMap"  />

<input type="hidden"  id="couponrequired" value="${properties.couponrequiredonviewbasket}">
<input type="hidden" name="maxerrormessage" id="maxErrorMessage" value="${properties.maxerrormessage}">

<div id="basketHolder">
<section class="basket">
		<!-- about section -->
    <section class="about container-fluid text-center margin-bottom">
        <div class="row ">
                <div class="col-md-8 col-md-offset-2 about-heading ">
                    <h1>
                        <strong>${properties.headingText}</strong>
                    </h1>
                    <div class="basket-loading">
                        <p>${properties.viewBasketLoadingMessage}</p>
						<div class="line-pulse"><div></div><div></div><div></div><div></div></div>
                    </div>
                    <p class="basket-count-label">
                        <span class="margin-about">
                            <span id="productCount"></span>
                            <span class="bold-text plural-product">product</span>
                            ${properties.basketQtyDesc}
                        </span>
                    </p>
                </div>
        </div>
    </section>
    <input type="hidden" name="viewCart" id="viewCartUrl" value="${viewCart}">
    <input type="hidden" name="removeCartItem" id="removeCartUrl" value="${removeCartItem}">
	<input type="hidden" name="updateCartUrl" id="updateCartUrl" value="${updateCart}">
	<input type="hidden" name="voucherCodeUrl" id="voucherCodeUrl" value="${voucherCodeUrl}">

	
<c:if test="${not empty skuAndImageMap}">
    <c:forEach items="${skuAndImageMap}" var="list" varStatus="i">

        <input type="hidden" name="sku_images_${i.index}" id="${list.skuid}" value="${list.img}+${list.viewURL}">

    </c:forEach>
</c:if>
	<input type="hidden" name="voucherLabel" id="voucherLabel" value="${properties.voucherLabel}">
    <input type="hidden" name="totalLabel" id="totalLabel" value="${properties.totalLabel}">
    <input type="hidden" name="vouchersuccessmessage" id="voucherSuccessMessage" value="${properties.vouchersuccessmessage}">
    <input type="hidden" name="voucherinvaliderror" id="voucherinvaliderror" value="${properties.voucherinvaliderror}">
    <input type="hidden" name="voucherempty" id="voucherEmpty" value="${properties.voucherempty}">
    <input type="hidden" name="voucherexpired" id="voucherexpired" value="${properties.voucherexpired}">
    <input type="hidden" name="voucheralreadyused" id="voucheralreadyused" value="${properties.voucheralreadyused}">
    <input type="hidden" name="vouchercannotbeusedforproduct" id="vouchercannotbeusedforproduct" value="${properties.vouchercannotbeusedforproduct}">
    <input type="hidden" name="voucherbutton" id="voucherButton" value="${properties.voucherbutton}">
    <input type="hidden" name="voucherdiscount" id="voucherDiscount" value="${properties.voucherdiscount}">
	<input type="hidden" name="vouchertooltipimage" id="voucherTooltipImage" value="${properties.vouchertooltipimage}">
    <input type="hidden" name="vouchertooltiptext" id="voucherTooltipText" value="${properties.vouchertooltiptext}">
	<input type="hidden" name="maxExceededmsg" id="maxExceededMsg" value="${properties.maxExceededMessage}">
	<input type="hidden" name="inclusivetaxLabel" id="inclusivetaxlabel" value="${properties.inclusivetaxLabelView}">
	<input type="hidden" name="taxexclusiveLabel" id="taxexclusivelabel" value="${properties.taxexclusiveLabelView}">
	<input type="hidden" name="viewBasketRemoveIcon" id="viewBasketRemoveIcon" value="${properties.removeIcon}">
	<input type="hidden" name="viewBasketshippinglabel" id="viewBasketShippingLabel" value="${properties.shippingLabelView}">
	<input type="hidden" name="viewproductLabel" id="viewproductLabel" value="${properties.viewproductLabel}">
	
	
    <!-- end of about section -->
    <!-- end of about section -->
    <div class="basket-table-desktop">
      <table id="productTable" class="table borderless">
      <thead>
        <tr>
        <th></th>
        <th></th>
        <th class="heading hidden">${properties.unitPriceLabel}</th>
        <th class="heading hidden">${properties.qtyLabel}</th>
        <th class="heading hidden">${properties.totalPriceLabel}</th>
        <th></th>
        </tr>
      </thead>
      <tbody id="tablePlace">			

</tbody>
      </table>
    </div>

    <div class="basket-table-mobile">
      <table id="productTableMobile" class="table">
      <tbody id="tablePlaceMobile">

      </tbody>
      </table>
    </div>
      <div class="modal" id="couponTooltip" tabindex="-1" aria-labelledby="myModalLabel">
<div class="modal-dialog" role="document">
  <div class="modal-content">
    <div class="modal-header coupontootipHeader" >
   <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
 </div>
 <div class="modal-body coupontootipBody" >
   ${properties.vouchertooltiptext}
      </div>
	  
    </div>
  </div>
</div>
</section>

<section class="basketIcon clearfix">
	<adc:minifyUrlTag  var="checkoutGuestLink" actualUrl="${properties.ctaCheckoutGuestLink}"/>
	<adc:minifyUrlTag  var="ctaCheckoutLink" actualUrl="${properties.ctaCheckoutLink}"/>
    <input type="hidden" name="guestCheckoutUrl" id="guestCheckoutUrl" value="${checkoutGuestLink}">
    <input type="hidden" name="checkoutUrl" id="checkoutUrl" value="${ctaCheckoutLink}">
    	  <div class="checkout-btn-div">
          	<a href="#" class="btn btn-lg button-orange hidden" id="userCheckout" role="button">${properties.checkoutLabel}</a>
		  </div>
		  <div class="icon-list">
              <c:forEach items="${featuresList}" var="flist">
                  <div>
                      <img src="${flist.featureimage}" alt="${flist.featureText}">
                      ${flist.featureText}
                  </div>
			 </c:forEach>
		  </div>
</section>

</div>

	<section id="noProducts" class="container">
    <div class="topSpacing col-lg-12 hidden" id="cartError">
        ${properties.noproductText}				
    </div>
  </section>

