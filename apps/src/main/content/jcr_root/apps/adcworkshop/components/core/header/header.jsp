<%--
* Copyright (c)  Vorwerk POC
* Program Name :  header.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Displays header on the page.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 03-Jul-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>


<%@include file="/apps/adcworkshop/components/shared/global.jsp" %>
<%@page session="false" %>
			
			<adc:minifyUrlTag  var="logoutUrlLink" actualUrl="${properties.logoutUrl}"/>
			<adc:minifyUrlTag  var="accountlink" actualUrl="${properties.accountlink}"/>
			<adc:minifyUrlTag  var="myAccountLink" actualUrl="${properties.myAccountLink}"/>
			<adc:minifyUrlTag  var="basketLink" actualUrl="${properties.basketlink}"/>
			<adc:minifyUrlTag  var="fslLink" actualUrl="${properties.fsllink}"/>
			<adc:minifyUrlTag  var="errorPageUrl" actualUrl="${properties.errorPageURL}"/>
			<adc:minifyUrlTag  var="unauthorizedPageURL" actualUrl="${properties.unauthorizedPageURL}"/>
			<adc:minifyUrlTag  var="searchResUrl" actualUrl="${properties.searchResURL}"/>
			<adc:minifyUrlTag  var="transactionTimeoutUrl" actualUrl="${properties.transactiontimeoutUrl}"/>
			<input type="hidden"  id="transactiontimeout" value="${transactionTimeoutUrl}">
			<input type="hidden" name="errorpgurl" id="errorpage-url" value="${errorPageUrl}">
			<input type="hidden" name="unauthorizedurl" id="unauthorized-url" value="${unauthorizedPageURL}">
			<input type="hidden" name="searchresultsURL" id="searchresults-url" value="${searchResUrl}">
            <input type="hidden" name="logoutUrl" id="logout_url" value="${logoutUrlLink}">
			<input type="hidden" name="myAccountUrl" id="myaccount-url" value="${accountlink}">
			
            <div class="container-fluid header">
                <div class="col-md-12 col-sm-12 col-xs-12 logo_scetion" role="banner">
                    <div class="row">
                        <div class="col-md-4 col-sm-4 col-xs-6">
                             <a x-cq-linkchecker="skip" href="${fslLink}"><img src="${properties.imageleft}" class="imgSwap img-responsive libre-logo" alt="FreeStyle Libre" desk-img="${properties.imageleft}" mob-img="${properties.imageleftMobile}"></a> 
                        </div>
                        <div class="col-md-8 col-sm-8  col-xs-6 profile_head text-center ">
                            <ul class="list-inline pull-right">
                                <c:choose>
									<c:when test="${properties.displayMyAccountLink eq 'yes'}">

								<li class="m-padding dropdown dropbtn" onclick="myFunction()">
									<a>
										<img id="signedOutAccountIcon" src="${properties.cartLogo}" alt="${properties.imagealtMyaccount}" class="imgSwap dropbtn signed-out-account-icon" desk-img="${properties.cartLogo}" mob-img="${properties.cartLogoMobile}" >
										<img id="signedInAccountIcon" src="${properties.myaccountLogoSignedin}" alt="${properties.imagealtMyaccount}" class="imgSwap dropbtn signed-in-account-icon" desk-img="${properties.myaccountLogoSignedin}" mob-img="${properties.cartLogoMobile}" >
										<p class="li-text hidden-xs dropbtn">${properties.text1}</p>
										<div id="accountLoggedInBar" class="account-logged-in-bar"></div>

										<div id="myDropdown" class="dropdown-content col-md-12">
											<div class="arrow-up"></div>
											<p class="col-md-12" id="user_name"></p>

											<a href="#" id="logout" class="btn  btn-lg button-orange " role="button" style="background-color:#E4572D;">${properties.logoutlabel}</a>
											<a x-cq-linkchecker="skip" href="${myAccountLink}" id="myaccount" class="btn  btn-lg button-orange " role="button" style="background-color:white;">${properties.text1}</a>
										</div>
									</a>
								</li>
									</c:when>
								</c:choose>	

                                <c:choose>
									<c:when test="${properties.displayBasketLink eq 'yes'}">
										<li class="m-padding1 shoppingbasket">
											<a x-cq-linkchecker="skip" href="${basketLink}">
												<img src="${properties.myBasket}" alt="${properties.imagealtMyBasket}" class="imgSwap" desk-img="${properties.myBasket}" mob-img="${properties.myBasketMobile}" >
												 
												<p class="li-text hidden-xs">${properties.text2}</p>
											</a>
											<div class="basketitems"></div>
										</li>
									</c:when>
								</c:choose>	
                                <li class="vorwerk-header-logo">
                                    <a href="${properties.vorwerklink}" target="_blank">
									<img src="${properties.imageright}" class="imgSwap img-responsive hidden-xs" alt="vorwerk" desk-img="${properties.imageright}" mob-img="${properties.imagerightMobile}"></a>
								
                                </li>
                                <li>
                                </li>


                            </ul>
                        </div>

                    </div>
                </div>

                <div class=" row menu ">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle humberg" role="navigation" data-toggle="collapse" data-target="#myNavbar">
							<img src="${properties.menubutton}" class="imgSwap visible-xs" alt="menu button" desk-img="${properties.menubutton}" mob-img="${properties.menubuttonMobile}">
                            
                        </button>
                    </div>
                    <div class="col-md-7 col-sm-8 collapse navbar-collapse" id="myNavbar" role="navigation">
                        <ul class="nav nav-pills">
                            <c:forEach items="${properties.subNavTitles}" varStatus="k" var="eachTitle">


                                <li id="flip_${k.index}" data-target="panel_${k.index}">
                                    <span>${eachTitle}</span>
									<img src="${properties.menuarrow}" alt="menu arrow" class="imgSwap menu-arrow arrow-down visible-xs  pull-right" desk-img="${properties.menuarrow}" mob-img="${properties.menuarrowMobile}"/>
                                   
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                    <c:set var="check" value="${properties.select}"></c:set>
                    <c:if test="${check eq 'true'}">
                        <div class="col-md-5 col-sm-4 pull-right hidden-xs">

                            <div class="right-inner-addon col-md-offset-4 col-md-8 col-sm-12">
                                <img id="search-button" src="${properties.search}" class="imgSwap img-responsive" alt="search" desk-img="${properties.search}" mob-img="${properties.searchMobile}">
								
                                <input id="searchBar" type="search" name="q" class="form-control head-form" role="form" placeholder="Search" style="background-color:#E6E6E6;" />
                            </div>
                        </div>

                    </c:if>
                </div>
            </div>
