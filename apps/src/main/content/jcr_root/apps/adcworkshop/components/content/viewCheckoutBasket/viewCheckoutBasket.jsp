<%--
* Copyright (c)  Vorwerk POC
* Program Name :  viewCheckoutBasket.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  View products in checkout page.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 12-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<adc:imageSkuQueryTag var="skuAndImageMap"  />
<c:if test="${not empty skuAndImageMap}">
    <c:forEach items="${skuAndImageMap}" var="list" varStatus="i">

        <input type="hidden" name="sku_images_${i.index}" id="${list.skuid}" value="${list.img}+${list.viewURL}">

    </c:forEach>
</c:if>
<input type="hidden" name="shippingLabel" id="shippinglabel" value="${properties.shippingLabel}">
<input type="hidden" name="totalPriceLabel" id="totalPricelabel" value="${properties.totalPriceLabel}">
<input type="hidden" name="discountLabel" id="discountlabel" value="${properties.discountLabel}">
<input type="hidden" name="inclusivetaxLabel" id="inclusivetaxlabel" value="${properties.inclusivetaxLabel}">
<input type="hidden" name="taxexclusiveLabel" id="taxexclusivelabel" value="${properties.taxexclusiveLabel}">
<input type="hidden" name="quantityLabel" id="quantitylabel" value="${properties.quantityLabel}">
	<c:choose>        
		<c:when test="${properties.basketViewType eq 'viewBasketWithShippingCost'}">
			<cq:include script="/apps/adcworkshop/components/content/viewCheckoutBasket/viewBasketShipping.jsp"/>
		</c:when>			
		<c:otherwise >
			<cq:include script="/apps/adcworkshop/components/content/viewCheckoutBasket/viewBasketRead.jsp" />
		</c:otherwise>
	</c:choose>