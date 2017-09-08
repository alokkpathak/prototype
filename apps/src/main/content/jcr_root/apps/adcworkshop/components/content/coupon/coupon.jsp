<%--
* Copyright (c)  Vorwerk POC
* Program Name :  coupon.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Applying coupons for a product.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 01-Sep-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>



<adc:restServiceUrl  var="voucherCodeUrl" key="updateVoucherCode"/>


	<input type="hidden" name="voucherCodeUrl" id="voucherCodeUrl" value="${voucherCodeUrl}">
<input type="hidden" name="voucherexpired" id="voucherexpired" value="${properties.voucherexpired}">
    <input type="hidden" name="voucheralreadyused" id="voucheralreadyused" value="${properties.voucheralreadyused}">
    <input type="hidden" name="vouchercannotbeusedforproduct" id="vouchercannotbeusedforproduct" value="${properties.vouchercannotbeusedforproduct}">
<c:set var="checkcouponrequired" value="${properties.couponrequired}"></c:set>
<c:if test="${checkcouponrequired eq 'true'}">
                <h3 class="h4">  ${properties.couponTitle}</h3>
    <div class="form-group" id="couponform">
        <p>${properties.coupondesc}</p>
        <div class="coupon-loading">
			<div class="line-pulse"><div></div><div></div><div></div><div></div></div>
        </div>
        <label for="payment-coupon"></label>
        <input type="text" class="VoucherCode" id="VoucherCode">
    <button  id="btnCouponOk" class="btn" role="button">${properties.okbuttonlabel}</button>
    <img src="${properties.tooltipimage}"  title="${properties.tooltip}" alt="${properties.imagealt}" href="#modal_infoModal" data-toggle="modal" data-target="#couponTooltip"  role="dialog">		
    <span class="col-md-12 col-xs-12 col-sm-12 hidden error_show vouchercoupon" id="vouchercoupon">${properties.emptyerrormsg}</span>
    <span class="col-md-12 col-xs-12 col-sm-12 hidden error_show error_invalid" id="vouchercouponinvalid" >${properties.voucherinvaliderror}</span>
</div>
<span class="col-md-12 padding-zero hidden vouchercouponsucess" id="vouchercouponsucess" style="color:green">${properties.couponsuccess}</span>
</c:if>
<div class="modal" id="couponTooltip" tabindex="-1" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header coupontootipHeader" >
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <div class="modal-body coupontootipBody">
        ${properties.tooltip}
      </div>
	  
    </div>
  </div>
</div>