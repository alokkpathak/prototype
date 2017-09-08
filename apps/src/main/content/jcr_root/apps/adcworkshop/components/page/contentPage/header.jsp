<%--
* Copyright (c)  Vorwerk POC
* Program Name :  header.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Used to load the header of all pages based on BoilerPlate Template.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 08-Jul-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<cq:include script="/apps/adcworkshop/components/page/contentPage/initload.jsp"/>
<adc:initAnalytics/>
<adc:globalSettingsTag  var="varfbappid" key="fbappid"/>
	<c:if test="${not empty properties.enablePintrest}"> 		
		<script type="text/javascript">
			(function(d){
			    var f = d.getElementsByTagName('SCRIPT')[0], p = d.createElement('SCRIPT');
			    p.type = 'text/javascript';
			    p.async = true;
			    p.src = '//assets.pinterest.com/js/pinit.js';
			    f.parentNode.insertBefore(p, f);
			}(document));
		</script>

		<script>
		var fbapplid = '${varfbappid}';
		if (fbapplid!=null && fbapplid!=''){
		  window.fbAsyncInit = function() {
			FB.init({
			  appId      : '${varfbappid}',
			  xfbml      : true,
			  version    : 'v2.8'
			});
			FB.AppEvents.logPageView();
		  };
		}
		  (function(d, s, id){
			 var js, fjs = d.getElementsByTagName(s)[0];
			 if (d.getElementById(id)) {return;}
			 js = d.createElement(s); js.id = id;
			 js.src = "//connect.facebook.net/en_US/sdk.js";
			 fjs.parentNode.insertBefore(js, fjs);
		   }(document, 'script', 'facebook-jssdk'));
		</script>
	</c:if>
	
	
<adc:globalSettingsTag  var="timeOut" key="sessionTimeout"/>
<input type="hidden" value="${timeOut}" id="timeOutVal">
<adc:globalSettingsTag  var="ajaxRetryAttempts" key="ajaxRetryAttempts"/>
<input type="hidden" value="${ajaxRetryAttempts}" id="ajaxRetryAttemptVal">
<adc:restServiceUrl var="sessionTimeoutUrl" key="timeoutService" />
<input type="hidden" name="sessionTimeoutUrl" id="sessiontimeout-url" value="${sessionTimeoutUrl}">
<adc:restServiceUrl  var="checkOutNewsLetterSubscription" key="checkOutNewsLetterSubscription"/>
<input type="hidden" value="${checkOutNewsLetterSubscription}" class="checkOutNewsLetterSubscriptionUrl">
<adc:restServiceUrl  var="tokenurl" key="getToken" />
<input type="hidden" name="getTokenUrl" id="getTokenUrl" value="${tokenurl}">
<c:set var="pagePath" value="<%=properties.get("navpath",currentPage.getPath())%>"/>
<input type="hidden" name="localeCountryServletUrl" id="localeCountryServletUrl" value="/bin/adc/fsl/webshop/localeServlet">
<input type="hidden" name="currPagePath" id="currPagePath" value="${pagePath}">
<adc:restServiceUrl  var="isCust" key="isCustomer"/>
<input type="hidden" name="isCustUrl" id="isCustUrl" value="${isCust}">

<%
	String headerrootpath =currentPage.getAbsoluteParent(6).getPath();
%>

<c:choose>
    <c:when test="${ (not empty properties.templateType && properties.templateType eq 'checkoutTemplate') }">

<%
String checkoutheaderBoilerPlateNodePath = "";

if(headerrootpath != null && !headerrootpath.equalsIgnoreCase("")){
    checkoutheaderBoilerPlateNodePath = headerrootpath + "/utilities/boilerPlate/headers/checkoutHeader/jcr:content/par/checkOutHeader";
}
Resource checkoutHeaderBoilerplateResource = resourceResolver.getResource(checkoutheaderBoilerPlateNodePath);

if(checkoutHeaderBoilerplateResource != null){ 
%>

<%slingRequest.setAttribute(ComponentContext.BYPASS_COMPONENT_HANDLING_ON_INCLUDE_ATTRIBUTE, true);%>
<sling:include resource="<%=checkoutHeaderBoilerplateResource%>"/>        
<% slingRequest.removeAttribute(ComponentContext.BYPASS_COMPONENT_HANDLING_ON_INCLUDE_ATTRIBUTE);  %>
<% 
}%>      </c:when>
    <c:otherwise>
<!-- HEADER -->
<%
String globalHeaderBoilerPlateNodePath = "";

if(headerrootpath != null && !headerrootpath.equalsIgnoreCase("")){
    globalHeaderBoilerPlateNodePath = headerrootpath + "/utilities/boilerPlate/headers/globalHeader/jcr:content/par/headercontainer";
}
Resource globalHeaderBoilerplateResource = resourceResolver.getResource(globalHeaderBoilerPlateNodePath);

if(globalHeaderBoilerplateResource != null){ 
%>

<%slingRequest.setAttribute(ComponentContext.BYPASS_COMPONENT_HANDLING_ON_INCLUDE_ATTRIBUTE, true);%>
<sling:include resource="<%=globalHeaderBoilerplateResource%>"/>        
<% slingRequest.removeAttribute(ComponentContext.BYPASS_COMPONENT_HANDLING_ON_INCLUDE_ATTRIBUTE);  %>
<% 
}%>        
    </c:otherwise>
    
</c:choose>
<div id="content" role="main"></div>

