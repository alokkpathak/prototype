<%--
* Copyright (c)  Vorwerk POC
* Program Name :  thankyou.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Displays thankyou page on success scenario for order.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 14-Jul-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>
<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%
	response.setHeader("Cache-Control", "no-cache,no-store,private,must-revalidate,max-stale=0,post-check=0,pre-check=0"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader ("Expires", 0);
%>

<adc:restServiceUrl  var="orderStatus" key="orderStatusCheck"/>
<input type="hidden" value="${orderStatus}" id="orderStatusCheckUrl"/>

<adc:restServiceUrl  var="profiledetails" key="profiledetails"/>
<input type="hidden" value="${profiledetails}" id="profiledetailsServiceUrlthankU"/>
<adc:restServiceUrl  var="paymentmethod" key="paymentMethods"/>
<input type="hidden" value="${paymentmethod}" id="paymentmethodURL"/>
<adc:restServiceUrl  var="createNewOrder" key="createOrder"/>
<input type="hidden" value="${createNewOrder}" id="createorderUrl"/>

<div class="order-status-loading">
<p>${properties.orderstatusLoadingMessage}</p>
<div class="line-pulse"><div></div><div></div><div></div><div></div></div>
</div>
<c:set var="success" value="${properties.thankyousuccess}"/>
<c:set var="error" value="${properties.errorthankyou}"/>

        
        <section class="container-fluid " style="background-color:#${properties.rteBgColor}">
            <div class="about">
                <div class="row">
                    <div class="col-md-8 col-md-offset-2 paymentSuccess hidden">
                        ${success}
                    </div>


                     <div class="col-md-8 col-md-offset-2 paymentError hidden ">
                        ${error}
                    </div>

                </div>
            </div>
        </section>

<div class="subscribesuccess hidden">

 <cq:include path="news_subscribe" resourceType="/apps/adcworkshop/components/content/newletterforfooter" /> 

</div>
