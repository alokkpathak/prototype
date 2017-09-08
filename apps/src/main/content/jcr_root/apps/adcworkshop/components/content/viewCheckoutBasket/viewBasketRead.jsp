<%--
* Copyright (c)  Vorwerk POC
* Program Name :  viewbasketRead.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Display products for order review.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 18-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>


<adc:restServiceUrl  var="viewCart" key="viewCart"/>


<!-- about section -->
	    <section class="about container-fluid text-center" style="background-color:#F4F2F4;">
	        <div class="row ">
	                <div class="col-md-10 col-md-offset-1 about-heading ">
	                    <h1>
	                        ${properties.headingText}
	                    </h1>

	                </div>
	        </div>
	    </section>
	    <!-- end of about section -->

	<input type="hidden" name="viewCart" id="viewCartUrl" value="${viewCart}">
		<section class="container checkout-container">
			<div class="row">
				<div class="col-md-12 checkout-banner">
					<div class="col-md-9 col-sm-6 col-xs-12 text-center">
						<a href="#myModal-thirdParty" data-toggle="modal" role="dialog" id="bsktDetails" class="pull-left"><span class="glyphicon glyphicon-menu-left"></span><span class="back">${properties.ctaBackLabel}</span></a>
					</div>
					<div class="col-md-3 col-sm-6 col-xs-12 text-center">
                        <a id="bsktDetailsView" class="expand-details details">${properties.seeBasketLabel}<span class="glyphicon glyphicon-menu-down"></span></a>
					</div>					
				</div>
			</div>
			<div id="basket-details" class="hidden">
				<table class="table">
					<tbody id="basketPlace">
					</tbody>
				</table>
              </div>
		</section>
		