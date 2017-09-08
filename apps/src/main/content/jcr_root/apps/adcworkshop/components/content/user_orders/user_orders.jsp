<%--
    * Copyright (c)  Vorwerk POC
    * Program Name :  user_orders.jsp
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
<%@page import="java.util.Locale,java.util.ResourceBundle,com.day.cq.i18n.I18n,com.day.cq.wcm.api.WCMMode,java.util.*"%>
<%@page session="false" %>
<%
    String[] orderHistoryDuration = {"durationText","durationInMonths"};
pageContext.setAttribute("orderHistoryDuration", orderHistoryDuration);




%>

<adc:multicompositefield var="dropdownDurationList" fieldNodeName="orderHistoryDurationDropdownValues" fieldPropertyNames="${orderHistoryDuration}" returnType="List" />

<adc:restServiceUrl  var="orderHistoryUrl" key="fetchOrderHistoryList"/>
<adc:restServiceUrl  var="particularOrderUrl" key="orderdetails"/>
<adc:restServiceUrl  var="invoicepdfUrl" key="invoicepdf"/>
<adc:restServiceUrl  var="refundpdfUrl" key="refundpdf"/>
<adc:restServiceUrl  var="returnpdfUrl" key="returnpdf"/>
<adc:restServiceUrl  var="ordershipmentTrack" key="ordershipmentTrack"/>


<input type="hidden" id="orderHistoryServiceUrl" value="${orderHistoryUrl}"/>
<input type="hidden" id="particularOrderServiceUrl" value="${particularOrderUrl}"/>
<input type="hidden" id="ordershipmentTrackServiceUrl" value="${ordershipmentTrack}"/>
<input type="hidden" id="orderCount" value="${properties.noOfOrders}"/>
<input type="hidden" name="inclusivetaxLabel" id="inclusivetaxlabel" value="${properties.inclVatText}">
<input type="hidden" name="taxexclusiveLabel" id="taxexclusivelabel" value="${properties.vatexclusiveText}">
<input type="hidden" id="noOrdersHistoryText" value="${properties.noOrdersText}">


<section id="orders" class="col-lg-12 padding-zero  container-fluid hidden ">
    
    <div class="details-container">
        <h2 class="h4">${properties.currentOrderTitle}</h2>
        <div id="last-order-place">
            <table id="lastOrderTable" class="table">
                <tbody id="lastOrderPlace">
                </tbody>
            </table>
            <table id="lastOrderTableMobile" class="table mobileContent">
                <tbody id="lastOrderPlaceMobile">
                </tbody>
            </table>
        </div>
        
        <div class="col-xs-12 ecom-pdf" id="currentOrderSubLinks">
            
        </div>
        
        
        <h2 class="h4">${properties.orderHistoryTitle}</h2>
        <p class="button-center col-lg-8 padding-zero">${properties.orderHistoryDesc}</p>
        <div id="timeFrame" class="text-center col-lg-4">
            <select id="orderHistoryDuration" name="timeFrame">
                <c:forEach items="${dropdownDurationList}" var="eachOrderHistoryDuration">
                    <option value="${eachOrderHistoryDuration.durationInMonths}">${eachOrderHistoryDuration.durationText}</option>
                </c:forEach>
            </select>
        </div>

       <script id="current-order-subLinks-template" type="text/x-handlebars-template"> 
            {{#if .}}
            {{#order}}
            <input type="hidden" id="current_orderID" value="{{this.increment_id}}">
                <ul class="list-unstyled list-inline ecom-finance-links" >
                     {{#compare this.display_link.invoice 1 operator="=="}}
                     <li><a  id="currentOrderInvoice" target="_blank" href="${invoicepdfUrl}/{{../this.increment_id}}" onclick="return theFunction();">${properties.invoiceLabel}</a></li>
                     {{/compare}}          
                     {{#compare this.display_link.credit_note_pdf 1 operator="=="}}
                     <li><a id="currentOrderRefund" target="_blank" href="${refundpdfUrl}/{{../this.increment_id}}" onclick="return refundFunction();">${properties.refundLabel}</a></li>
                     {{/compare}}                   

                     {{#compare this.display_link.return_label_pdf 0 operator="!="}}
                     <li><a id="returnpdf-current-order" target="_blank" href="${returnpdfUrl}/{{../this.increment_id}}">${properties.returnPdfLabel}</a></li>
                     {{/compare}}  
                     
                     {{#compare this.display_link.create_rma 1 operator="=="}}
                     <li><a id="return-current-order" class="return-order">${properties.returnLabel}</a></li>
                     {{/compare}} 


                     {{#compare this.display_link.track 1 operator="=="}}
                     <li><div><a id="trackInfo1" href="#shippingInfo" name="{{../this.increment_id}}" data-toggle="modal" role="dialog" onclick="return shipmentFunction();">${properties.shipmentLabel}</a></div></li>
                     {{/compare}}                        
                        
        </ul>
        {{/order}} 
        {{/if}}
        
        </script>
        <script id="orders-template" type="text/x-handlebars-template"> 
            <table class="orders-table-temp">
                <tbody> 
                    {{#if .}}
                     {{#orders}}

                     {{#each this.list}}
                     {{#if @first}}
                     {{else}}
                     <tr class="text-center">
                         <td><div class="well padding-zero"><p>N&#176; {{this.increment_id}}</p></div></td>
                         <td>{{fetchDateFromDateTime this.created_at}}</br>{{this.total_item_count}} ${properties.productname}</td>
                         <td><span class="orderprice-symbol">{{@root.currency}}</span><span  class="orderprice">{{this.grand_total}}</span><br><span class="vat">{{vatFormCheck this.customer_is_diabetic}}</span></td>

                         {{#each this.shipment_status }}

                         <td id="order_status">
                             {{#compare ../../this.estimated_delivery null operator="!="}}
                              <span>${properties.estimatedDeliveryLabel}<b>{{fetchDateFromDateTime ../../this.estimated_delivery}}</b></span>
                              <br>
                                  {{/compare}}
                                   {{#compare this.status null operator="!="}}

                                   <span class="green"><b>${properties.statusLabel}<br>{{this.status}}</b></span><br/>
                                   {{/compare}}
								   {{#compare ../../this.order_status_label null operator="!="}}

                                   <span><b>${properties.orderStatusLabel}<br>{{../../this.order_status_label}}</b></span>
                                   {{/compare}}
								   </td>
                                   {{/each}}
        </tr>
        <tr style="border-top:none">
            <td><a href="#" class="viewOrder btn btn-lg button-orange " id="{{this.increment_id}}" role="button">${properties.OrderHistoryButtonText}</a></td>
            <td colSpan=3></td>
        </tr>
        {{/if}}

        {{/each}}
        {{/orders}} 
        {{else}}
         ${properties.noOrdersText}     
         {{/if}}
        </tbody>
        </table>
        </script>
        <script id="orders-template-mobile" type="text/x-handlebars-template"> 
            <table>
                <tbody> 
                    {{#if .}}
                     {{#orders}}
                     {{#each this.list}}
                     {{#if @first}}
                     {{else}}
                     <tr>
                         <td style="padding-top: 50px;" rowSpan=3><div class="well padding-zero"><p>N&#176; {{this.increment_id}}</p></div></td>
                         <td style="padding-top: 50px;">{{{fetchDateFromDateTime this.created_at}}}</br>{{this.total_item_count}} ${properties.productname}</td>
        </tr>
        <tr style="border-top:none">
            <td><span class="orderprice-symbol">{{@root.currency}}</span><span class="orderprice">{{this.grand_total}}</span><br><span class="vat">{{vatFormCheck this.customer_is_diabetic}}</span></td>
        </tr>
        <tr style="border-top:none">
            
            {{#each this.shipment_status }}
             <td id="order_status">
             {{#compare ../../this.estimated_delivery null operator="!="}}
             
             <span>${properties.estimatedDeliveryLabel}<b>{{fetchDateFromDateTime ../../this.estimated_delivery}}</b></span>
             <br>
                 {{/compare}}
                  {{#compare this.status null operator="!="}}
                  <span class="green"><b>${properties.statusLabel}<br>{{this.status}}</b></span>
                  {{/compare}}
				  {{#compare ../../this.order_status_label null operator="!="}}
					<span><b>${properties.statusLabel}<br>{{../../this.order_status_label}}</b></span>
                  {{/compare}}
				  </td>
                  {{/each}}
        </tr>
        <tr style="border-top:none">
            <td><a class="viewOrder btn btn-lg button-orange " id="{{this.increment_id}}" role="button">${properties.OrderHistoryButtonText}</a></td>
            <td></td>
        </tr>
        {{/if}}
        
        {{/each}}
        {{/orders}}  
        {{else}}
         ${properties.noOrdersText}     
         {{/if}}
        </tbody>   
        </table>
        </script>
        <table id="orderTable" class="table">
            <tbody id="orderTablePlace">
            </tbody> 
        </table>
<div class="orderTablePlaceHolder"></div>

        <table id="orderTableMobile" class="table">
            <tbody id="orderTablePlaceMobile">
            </tbody>
        </table>
        <div class="orderTablePlaceMobileHolder"></div>
    </div>

</section>
<script type="text/javascript">
    function theFunction () {
      app.analytics.pushEvent('Click', 'MyAccount' ,'orders' , 'invoice');
    }
    function refundFunction() {
		app.analytics.pushEvent('Click', 'MyAccount' ,'orders' , 'Refund acknowledgement');
    }
	    function shipmentFunction() {
app.analytics.pushEvent('Click', 'MyAccount' ,'orders' , 'Shipment information');
    }

</script>
<cq:include path="view_order_details" resourceType="/apps/adcworkshop/components/content/view_order_details" />


