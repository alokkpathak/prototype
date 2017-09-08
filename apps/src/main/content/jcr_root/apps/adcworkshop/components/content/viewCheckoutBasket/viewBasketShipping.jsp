<%--
* Copyright (c)  Vorwerk POC
* Program Name :  viewBasketShipping.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  To view Basket along with shipping charges.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 16-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>


<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>


<adc:restServiceUrl  var="finalPayment" key="viewCart"/>

<input type="hidden" value="${finalPayment}" id="finalPaymentUrl"/>

	<div class="order-summary">
        <h3 class="h4">${properties.ordersummarylabel}</h3>
		<table id="productTable" class="table borderless">
		     <tbody id="tablePlaceshipping">
		       
		     </tbody>
		     </table>
		     
		     <table id="productTableMobile" class="table">
		     <tbody id="tablePlaceMobileshipping">
		       
		     </tbody>
		 </table>
	</div>

		