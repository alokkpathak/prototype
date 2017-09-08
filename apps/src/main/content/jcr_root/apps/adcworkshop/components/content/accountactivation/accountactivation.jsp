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
* 28-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>
<%@include file="/apps/adcworkshop/components/shared/global.jsp" %>
<%@page import="com.vorwerk.adc.workshop.core.util.AdcFSLConstants"%>
<script type="text/javascript" src="/etc/designs/adcworkshop/clientlibs-adc-ecomm/js/accountactivation.js"></script>
<%@page session="false" %>

<adc:restServiceUrl  var="confirmaccount" key="confirmaccount"/>
<input type="hidden" value="${confirmaccount}" id="confirmaccounturl"/>
<adc:restServiceUrl  var="profiledetails" key="profiledetails"/>
<input type="hidden" value="${profiledetails}" id="profiledetailsServiceUrl"/>
<div id="activate" class="hidden text-center" style="color:red">${properties.activatesuccess}</div>
<div id="activatefail" class="hidden text-center" style="color:red">${properties.ajaxfailed}</div>
<input type="hidden" name="signinPageURL" id="signinPageURL" value="${properties.successURL}">
<div class="hidden text-center" id="<%=AdcFSLConstants.FAILED_LOADING_CUST_ID%>" style="color:red">${properties.failedCustomerID}</div>
<div class="hidden text-center" id="<%=AdcFSLConstants.WRONG_CUSTOMER_ACCOUNT_SPECIFIED%>" style="color:red">${properties.wrongCustomerAccount}</div>
<div class="hidden text-center" id="<%=AdcFSLConstants.BAD_REQUEST%>" style="color:red">${properties.badrequest}</div>
<adc:minifyUrlTag  var="unauthorizedurl_account" actualUrl="${properties.unauthorizedurl}" />
<input type="hidden" name="unauthorizedurl_account" id="unauthorizedurl_account" value="${unauthorizedurl_account}">
<adc:minifyUrlTag  var="accountOverview" actualUrl="${properties.successURL}" />
<input type="hidden" name="accountOverview" id="signInPageURL" value="${accountOverview}">
<adc:minifyUrlTag  var="signinregister" actualUrl="${properties.signinregisterurl}" />
<input type="hidden" name="signinregister" id="signinregister" value="${signinregister}">
