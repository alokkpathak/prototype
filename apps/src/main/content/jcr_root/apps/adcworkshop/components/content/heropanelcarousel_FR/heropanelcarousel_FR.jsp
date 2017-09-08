<%--
    * Copyright (c)  Vorwerk POC
    * Program Name :  heropanel.jsp
    * Application  :  Vorwerk POC
    * Purpose      :  See description
    * Description  :  Gives more description about the product.
	* Modification History:
	* ---------------------
    *    Date                                Modified by                                       Modification Description
    *-----------                            ----------------                                    -------------------------
    * 11-Jul-2016                  Cognizant Technology solutions                                                                                    Initial Creation
    *-----------                           -----------------                                    -------------------------
--%>
    <%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<%
String[] carouseldetaillist = {"carouselimage","topheadline","subheadline","headlinefirstpart","headlinesecondpart","headlinethirdpart","headlinefourthpart","descriptionone","descriptiontwo","firstbuttontext","firstbuttonlink","secondbuttontext","secondbuttonlink"};
pageContext.setAttribute("carouselmultifields",carouseldetaillist);

%>
<adc:multicompositefield var="carouselList" fieldNodeName="carouseldetails" fieldPropertyNames="${carouselmultifields}" returnType="List" />
<adc:minifyUrlTag var="renewOrderUrl" actualUrl="${properties.renewOrderUrl}" />
<input type="hidden" id="renewOrderUrl" value="${renewOrderUrl}" />
<adc:restServiceUrl  var="isCust" key="isCustomer"/>
<input type="hidden" name="isCustUrl" id="isCustUrl" value="${isCust}">
<adc:minifyUrlTag  var="checkoutUrl" actualUrl="${properties.checkoutUrl}" />
<input type="hidden" name="checkoutUrl" id="checkoutUrl" value="${checkoutUrl}">
<adc:minifyUrlTag  var="guestCheckoutUrl" actualUrl="${properties.guestCheckoutUrl}" />
<input type="hidden" name="guestCheckoutUrl" id="guestCheckoutUrl" value="${guestCheckoutUrl}">
<adc:restServiceUrl  var="reimbursementOrders" key="reimbursementOrders"/>
<input type="hidden" value="${reimbursementOrders}" id="reimbursementOrders"/>
<adc:minifyUrlTag  var="errorPageUrl" actualUrl="${properties.errorPageUrl}"/>
<input type="hidden" name="errorPageUrl" id="errorPageUrl" value="${errorPageUrl}">
<adc:minifyUrlTag  var="signInPageUrl" actualUrl="${properties.signInPageUrl}"/>
<input type="hidden" name="signinPageUrl" id="signinPageUrl" value="${signInPageUrl}">
<div class="container-fluid " style="background-color: #EAEDED;">
<adc:restServiceUrl var="rspReimbursement" key="rspReimbursement" />
<input type="hidden" id="rspReimbursement" value="${rspReimbursement}"> 
        
    <div class="row " >
        <div class="col-md-12 banner-new padding-left padding-right">
            
            
            <!-- <img src=${properties.img} alt="${properties.imagealt}" class="img-responsive " >-->
            <!-- demo -->
            
            <div id="myCarousel" class="carousel slide" data-ride="carousel">
                <ol class="carousel-indicators bottom_margin_10pix">
                    <c:forEach items="${carouselList}" var="carsllist" varStatus="i">
                        <c:if test="${fn:length(carouselList) gt 1}">
                            <c:if test="${i.index eq 0}">
                                <li data-target="#myCarousel" data-slide-to="<c:out value='${i.index}'/>" class="active"></li>
                            </c:if>
                            <c:if test="${i.index gt 0}">
                                <li data-target="#myCarousel" data-slide-to="<c:out value='${i.index}'/>"></li>
                            </c:if>
                        </c:if>
                    </c:forEach>
                </ol>




                <!-- Wrapper for slides -->
                <div class="carousel-inner">
                    <c:forEach items="${carouselList}" var="carsllist" varStatus="i">
                        <c:set var="firstbuttoname" value="${carsllist.firstbuttontext}"/>
                        <c:set var="secondbuttoname" value="${carsllist.secondbuttontext}"/>
                        <c:set var="imagepathws" value="${carsllist.carouselimage}"/>
                        <c:set var="imagepath" value="${fn:trim(imagepathws)}"/>
                        <adc:minifyUrlTag var="secondbuttonLink" actualUrl="${carsllist.secondbuttonlink}" />
                        <input type="hidden" value="${secondbuttonLink}" id="secondbuttonLink"/>
                        
                        
                        <c:if test="${i.index eq 0}">
                            <div class="item active">
                            </c:if>
                            <c:if test="${i.index gt 0}">
                                <div class="item">
                                </c:if>
                                <c:if test="${empty imagepath}">
                                    <img src="/content/dam/adc/fsl/images/fr/fr/desktopimages/libre-user.jpg" alt="Carousel Image">
                                </c:if>
                                <c:if test="${not empty imagepath}">
                                    <img src="${carsllist.carouselimage}" alt="Carousel Image">
                                </c:if>
                                <div class="banner-desc">
                                	<div class='banner-desc-france'>
                                    <c:if test="${carsllist.topheadline != null}">
                                        <h1>${carsllist.topheadline}</h1>
                                    </c:if>
                                    <c:if test="${carsllist.topheadline != null}">
                                        <p>${carsllist.subheadline}</p>
                                    </c:if>
                                    <c:if test="${carsllist.topheadline == null}">
                                        <h1>${carsllist.subheadline}</h1>
                                    </c:if>
                                    <h2><span class="text-orange">${carsllist.headlinefirstpart} <span class="text-orange img-font">${carsllist.headlinesecondpart}</span>                                 
                                        <span>${carsllist.headlinethirdpart}</span> ${carsllist.headlinefourthpart}</span>

                                            

                                    </h2>
                                    <span class="banner_text_fr" >${carsllist.descriptionone}</span>                            
                                    
                                </div>
                                <div class="col-md-12 buttonmargin padding-zero">
                                    <c:if test="${firstbuttoname != null}">
                                        <a id="discoverAnalytics" href="${carsllist.firstbuttonlink}.html" class="btn btn-info" >${carsllist.firstbuttontext}</a>
                                    </c:if>
                                    <c:if test="${secondbuttoname != null}">
                                        <a id="buyAnalytics" href="${carsllist.secondbuttonlink}.html" class="btn btn-info" style="background-color:#e4572d; color:#FFFFFF;">${carsllist.secondbuttontext}</a> 
                                    </c:if>
                                </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                
                <!-- Left and right controls -->
                <c:if test="${fn:length(carouselList) gt 1}">
                    <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                        <img src="${properties.arrowSliderLeftImg}" class="icon-arrow-prev" aria-hidden="true">
                        <span class="sr-only">${properties.carouselPrevious}</span>
                    </a>
                    <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                        <img src="${properties.arrowSliderRightImg}" class="icon-arrow-next" aria-hidden="true">
                        <span class="sr-only">${properties.carouselNext}</span>
                    </a>
                </c:if>

            </div>
            

            <!-- demo end -->

            

        </div>
    </div>
</div>    
    

    
    
