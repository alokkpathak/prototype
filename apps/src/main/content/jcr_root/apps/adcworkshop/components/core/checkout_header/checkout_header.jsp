<%--
* Copyright (c)  Vorwerk POC
* Program Name :  checkout_header.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Displays header for checkout header.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 26-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp" %>
<%@page session="false" %>
<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", 0);
	response.setHeader("Dispatcher", "no-cache");
%>
<adc:minifyUrlTag  var="logoutUrlLink" actualUrl="${properties.logoutUrl}"/>
<input type="hidden" name="logoutUrl" id="logout_url" value="${logoutUrlLink}">
<adc:minifyUrlTag  var="errorPageUrl" actualUrl="${properties.errorPageURL}"/>
<input type="hidden" name="errorpgurl" id="errorpage-url" value="${errorPageUrl}">
<adc:restServiceUrl  var="getLomacoServiceUrl" key="lomacotokenserviceurl" />
<input type="hidden"  id="getLomacoServiceUrl" value="${getLomacoServiceUrl}">

<header class="container-fluid">
    <div class="header">
       <div class="col-md-12 col-sm-12 col-xs-12 logo_scetion">
       <div class="row">
            <div class="col-xs-6">
               <a href="#myModal-thirdParty" data-toggle="modal" role="dialog"><img src="${properties.logoImage}" id ="headimage" class="imgSwap img-responsive checkout-libre-logo" alt="FreeStyle Libre" desk-img="${properties.logoImage}" mob-img="${properties.logoImagemobile}"></a>
            </div>
				<c:set var="displayCust" value="${properties.displayCust}"></c:set>
					<c:if test="${displayCust eq 'Yes'}">
						<div class="col-md-4">
							<div class="col-md-10 text-center">
								<a href=""> <img
									src="/content/dam/adc/fsl/images/global/fr/desktop/customercare.png"
									class="img-responsive imageGraph" alt="FreeStyle Libre">
								</a>
								<p>
								<span>
									<center>${properties.middletext}</center>
								</span>
								</p>
							</div>
						</div>
					</c:if>

            <div class="col-xs-6 pull-right padding-zero left-header padding-checkout">
                <div class="wrapper"><span> <img src="${properties.iconImage}" class="imgSwap Secure"  alt="Secure Page" desk-img="${properties.iconImage}" mob-img="${properties.iconImagemobile}" /> <div class="secure-copy">${properties.secureText}</div></span> </div>             </div>
            </div>

        </div>    
     </div>
   </div>

  </header>