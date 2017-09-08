<%--
* Copyright (c)   Vorwerk POC
* Program Name :  accountactivation.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Account Activation for Users.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 28-September-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>
<%@include file="/apps/adcworkshop/components/shared/global.jsp" %>
<%@page import="com.vorwerk.adc.workshop.core.util.AdcFSLConstants"%>
<script type="text/javascript" src="/etc/designs/adcworkshop/clientlibs-adc-ecomm/js/customerlogin.js"></script>

<%@page session="false" %>
<adc:restServiceUrl  var="customerlogin" key="customerlogin"/>
<input type="hidden" value="${customerlogin}" id="customerloginurl"/>
<adc:restServiceUrl  var="profiledetails" key="profiledetails"/>
<input type="hidden" value="${profiledetails}" id="profiledetailsServiceUrl"/>
<div id="customerloginsuccess" class="hidden text-center" style="color:blue">${properties.customerloginsuccess}</div>
<div id="customerloginfailed" class="hidden text-center" style="color:red">${properties.customerloginfailed}</div>
<input type="hidden" name="signinPageURL" id="signinPageURL" value="${properties.successURL}">
<div class="hidden text-center" id="<%=AdcFSLConstants.INVALID_CUSTOMER_LOGIN_TOKEN%>" style="color:red">${properties.tokeninvalid}</div>
<div class="hidden text-center" id="<%=AdcFSLConstants.FAILED_LOADING_CUST_ID%>" style="color:red">${properties.failedCustomerID}</div>
<div class="hidden text-center" id="<%=AdcFSLConstants.WRONG_CUSTOMER_ACCOUNT_SPECIFIED%>" style="color:red">${properties.wrongCustomerAccount}</div>
<div class="hidden text-center" id="<%=AdcFSLConstants.BAD_REQUEST%>" style="color:red">${properties.badrequest}</div>
<adc:minifyUrlTag  var="unauthorizedurl_mbo" actualUrl="${properties.unauthorizedurl}" />
<input type="hidden" name="unauthorizedurl_mbo" id="unauthorizedurl_mbo" value="${unauthorizedurl_mbo}">
<adc:minifyUrlTag  var="accountOverview" actualUrl="${properties.successURL}" />
<input type="hidden" name="accountOverview" id="signInPageURL" value="${accountOverview}">
