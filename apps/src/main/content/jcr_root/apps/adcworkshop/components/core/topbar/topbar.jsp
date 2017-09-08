<%--
* Copyright (c)  Vorwerk POC
* Program Name :  topbar.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  To include country specific disclaimer and options.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 29-Jul-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>


<div class="row header_top hidden-xs hidden" style="background-color:#${properties.topBarBgColor}" id="cookieBar">
       <div class="col-md-12 col-sm-12">
           <div class="col-lg-8 col-md-8 col-sm-9 text-left "><p class="color-white">${properties.title1} <a id="cookieLink" href="#">${properties.title2}</a></p></div>
        <!-- Showing country change link -->
		<c:set var="showCountryLink" value="${properties.displayChangeCountry}"></c:set>
		<c:if test="${showCountryLink eq 'true'}">
			<div class="col-lg-4 col-md-4 col-sm-3 text-right ">
				<a href="#myModal-country" title="${properties.title3}" data-toggle="modal" role="dialog">${properties.title3}</a>
			</div>
		</c:if>
     </div>
	 </div>