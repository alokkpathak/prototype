<%--
    * Copyright (c)  Vorwerk POC
    * Program Name :  view_order_details.jsp
        * Application  :  Vorwerk POC
            * Purpose      :  See description
                * Description  :  For Viewing the Order details on click of view details button.
                    * Modification History:
* ---------------------
    *    Date                                Modified by                                       Modification Description
    *-----------                            ----------------                                    -------------------------
    * 22-Aug-2016                  Cognizant Technology solutions            					Initial Creation
    *-----------                           -----------------                                    -------------------------
    --%>
    
    <%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>

<adc:restServiceUrl  var="reorderurl" key="reorder" />
<adc:restServiceUrl  var="orderurl" key="orderdetails" />
<adc:restServiceUrl  var="invoicepdfUrl" key="invoicepdf"/>

<adc:imageSkuQueryTag var="skuAndImageMap"  />


<adc:minifyUrlTag  var="unAuthorizedUrl" actualUrl="${properties.unauthAccessUrl}" />
<input type="hidden" name="unauthAccessUrl" id="unauthAccessUrl" value="${unAuthorizedUrl}">
 					<div class="individualorder-loading" style='text-align: center'>
                        <p>${properties.textForLoading}</p>
						<div class="line-pulse"><div></div><div></div><div></div><div></div></div>
                    </div>
<section id="singleOrder" class="col-lg-12 padding-zero  container-fluid hidden">
    <div class="details-container">
        <input type="hidden" name="reorderServiceUrl" id="reorderServiceUrl" value="${reorderurl}">
        <input type="hidden" name="orderDetailUrl" id="orderDetailUrl" value="${orderurl}">
		<adc:minifyUrlTag  var="vwBasketLink" actualUrl="${properties.viewBasketLink}"/>
        <input type="hidden" name="viewBasketLink" id="viewBasketLink" value="${vwBasketLink}">
        
 <c:if test="${not empty skuAndImageMap}">
    <c:forEach items="${skuAndImageMap}" var="list" varStatus="i">

        <input type="hidden" name="sku_images_${i.index}" id="${list.skuid}" value="${list.img}+${list.viewURL}">

    </c:forEach>
</c:if>        
		<input type="hidden" name="orderDetail_order" id="orderDetail_order" value="${properties.orderDetail_order}">
        <input type="hidden" name="orderDetail_qty" id="orderDetail_qty" value="${properties.orderDetail_qty}">
        <input type="hidden" name="orderDetail_total" id="orderDetail_total" value="${properties.orderDetail_total}">
        <adc:restServiceUrl  var="invoicepdfUrl" key="invoicepdf"/>
        <adc:restServiceUrl  var="refundpdfUrl" key="refundpdf"/>
        <adc:restServiceUrl  var="returnpdfUrl" key="returnpdf"/>
        <div class="col-lg-12 clearfix" id="singleTablePlace">
        </div>

        <c:if test = "${properties.bannertext1 eq 'Yes'}" >
        <div class="col-lg-12 topSpacing text-center padding-zero">
            <div class="well singleOrderWell" style="background-color: #E4572D;">
                <p class="letterSpacing headPara">${properties.oldcustomerstext}</p>
            </div>
        </div>
        </c:if>
        
    </div>
</section>

<script id="single-order-template" type="text/x-handlebars-template"> 

    {{#order}}
    
    <input type="hidden" name="orderID" id="orderID" value="{{this.increment_id}}">
	<input type="hidden" id="returnPdfLink" value="${returnpdfUrl}/{{this.increment_id}}"> 
        <div class="visible-xs visible-sm">
            <div class="text-center oderIDsHeader"><strong>{{@root.orderText}} {{this.increment_id}}</div>
            <div class="text-center numOfOrders">{{this.total_item_count}}</strong><span><strong>${properties.productstextname}</strong> ${properties.baskettextname}<span></div>
			<div class="Reorder-loading hidden-md hidden-lg text-center">
               <div class="line-pulse"><div></div><div></div><div></div><div></div></div>
        	</div>	
            <div class="text-center"><td><a class="reorderProducts btn btn-lg button-orange" role="button">${properties.reorderbuttonname}</a></div>
            <span class="hidden return-success">${properties.returnSuccessNotification}</span>
</div>
<table class="table">
    <tbody>
        <div class="Reorder-loading hidden-xs hidden-sm text-right">
               <div class="line-pulse"><div></div><div></div><div></div><div></div></div>
         </div>	
        <tr class="hidden-xs hidden-sm OrderHeaderBar"> 
            <td colSpan=2 style="border-top:none" class="oderIDsHeader">{{@root.orderText}} {{this.increment_id}}</br><span class="numOfOrders">{{this.total_item_count}} ${properties.productstextname}</span><span class="orderBasketText"> ${properties.baskettextname}</span></td>
            <td style="border-top:none" class="OrderHeaderBarButton"><a class="reorderProducts btn btn-lg button-orange pull-right" role="button">${properties.reorderbuttonname}</a></td></tr>
            <tr class="hidden hidden-xs hidden-sm return-success"> <td colSpan="3">${properties.returnSuccessNotification}</td></tr>


            {{#each this.order_items}}

            <tr>
                <td><img width="100px" height="100px" src="{{#pickImgForSku  this.sku  ../../skuImgPath}} {{this}} {{/pickImgForSku}}" alt="${properties.imagealt}"></td>
                <td><span class="productSingleOrderText">{{this.name}}</span><br/><span class="productSingleOrderQuant">{{@root.qtyText}}:</span><span class="productSingleOrderQuantNo"> {{this.qty_ordered}}</span></td>
                <td><span>{{@root.currency}}</span><span>{{this.price_incl_tax}}</span><br><span class="vat">{{vatFormCheck ../this.customer_is_diabetic}}</span></td>
                <input type="hidden" name="reorder_sku{{@index}}" id="{{this.sku}}" value="{{this.qty_ordered}}">
				<input type="hidden" name="bundle_options" id="{{this.sku}}_bundle" value="{{this.bundle_option}}">
			</tr>
            {{/each}}
            <tr class="tableHighlight">
                    {{#each this.shipment_status }}

                     <td class="green" style="width:100px; height:100px; text-align: center;">
                       {{#compare this.status null operator="!="}}
                       ${properties.statusLabel}{{this.status}}
                       {{/compare}}
                       {{#compare ../this.order_status_label null operator="!="}}
                       ${properties.statusLabel}</br>{{../../this.order_status_label}}
                       {{/compare}}
					 </td>

                     {{/each}}

                     <td><span class="ordertotalText">{{@root.totalText}}<span> :</td>
                     <td><span>{{@root.currency}}</span><span>{{this.grand_total}}</span><br><span class="vat">{{vatFormCheck this.customer_is_diabetic}}</span></td>
			</tr>
</tbody>
</table>


<div class="col-xs-12 ecom-pdf">
    <ul class="list-unstyled list-inline ecom-finance-links">
        
        {{#if (if_eq this.display_link.invoice '1' ) }}
         <li><a id="particularOrderInvoice" target="_blank" href="${invoicepdfUrl}/{{../this.increment_id}}" onclick="return orderInvoiceFtn();" >${properties.invoiceLabel}</a></li>
         {{/if}}

         {{#if ( if_eq this.display_link.credit_note_pdf  '1') }}
         <li><a id="particularOrderRefund" target="_blank" href="${refundpdfUrl}/{{../this.increment_id}}" onclick="return orderRefundFtn();" >${properties.refundLabel}</a></li>
         {{/if}}
         
         {{#compare this.display_link.return_label_pdf 0 operator="!="}}
         <li><a id="particularOrderReturnPdf" target="_blank" href="${returnpdfUrl}/{{../this.increment_id}}" onclick="return orderReturnPDFFtn();" >${properties.returnPdfLabel}</a></li>
         {{/compare}}
		 
         
         {{#if ( if_eq this.display_link.create_rma '1' ) }}
         <li><a id="particularOrderReturn" class="return-order" onclick="return orderReturnFtn();">${properties.returnLabel}</a></li>
         {{/if}}


         {{#if (if_eq this.display_link.track  '1') }}
         <li><div>
         <a id="trackInfo1" href="#shippingInfo" name="{{../this.increment_id}}" data-toggle="modal" role="dialog">${properties.shipmentLabel}</a></div>
</li>

{{/if}} 
</ul>
</div> 

{{/order}}
</script>
<script type="text/javascript">

	function orderInvoiceFtn() {
		app.analytics.pushEvent('Click', 'MyAccount', 'orders', 'invoice');
	}
	function orderRefundFtn() {
		app.analytics.pushEvent('Click', 'MyAccount', 'orders',
				'Refund acknowledgement');
	}
	function orderReturnPDFFtn() {
		app.analytics.pushEvent('Click', 'MyAccount', 'orders', 'Return (PDF)');
	}
	function orderReturnFtn() {
		app.analytics.pushEvent('Click', 'MyAccount', 'orders', 'Return');
	}
</script>