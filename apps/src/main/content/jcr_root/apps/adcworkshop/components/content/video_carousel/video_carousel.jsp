<%--
* Copyright (c)  Vorwerk POC
* Program Name :  video_carousel.jsp
* Application  :  Vorwerk POC
	* Purpose      :  See description
		* Description  :  For displaying the videos on the carousel basis.
			* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 29-Jul-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>
<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<cq:includeClientLib css="apps.adc.workshop.common"/>

<%@ page  import="java.util.*" %>
<%@page import="java.net.URI,java.io.*"%>

<%
String[] multivideolist = {"videotext","videoname","shareIconPathDesktop","shareIconPathMobile"};
pageContext.setAttribute("videomultifields", multivideolist);
%>
<%
String currentURL=currentPage.getPath();
pageContext.setAttribute("currentURL", currentURL);
%>
<c:set var="scheme" value="${pageContext.request.scheme}"/>
<c:set var="domainName" value="${pageContext.request.serverName}"/>
<adc:minifyUrlTag  var="miniUrl" actualUrl="${currentURL}" />
<c:set var="finalUrl" value="${scheme}://${domainName}${miniUrl}"/>
<%
String tquery= "text="+properties.get("twittertext","twittertext")+(String)pageContext.getAttribute("finalUrl");
URI turl = new URI("http","twitter.com","/intent/tweet",tquery,null);
String tUrl=turl.toASCIIString();
pageContext.setAttribute("tUrl", tUrl);
%>

<adc:multicompositefield var="videoList" fieldNodeName="vmulti" fieldPropertyNames="${videomultifields}" returnType="List" />

<input type="hidden"  value=${properties.vcarouseltime} id="carouselTime"/>
<c:set var="flag" value="videoCarousel" scope="request"/>
<div class="container-fluid" style="background-color:#${properties.vbgcolor};">
<div class="expCarousel" >
<div id="shareCarousel" class="carousel slide projectOverviewCarousel" data-ride="carousel">
	<!-- Indicators -->
	<c:if test="${fn:length(videoList) gt 1}">
	
		<ol class="carousel-indicators expcarousel-rect carousel-rect ">
	
			<c:forEach items="${videoList}"  var="vlist" varStatus="j" >
		
				<c:choose>
					<c:when test= "${j.index == 0}" >
						<li data-target="#shareCarousel" data-slide-to="${j.index}" class="active"></li>
					</c:when>
					<c:otherwise>
					<li data-target="#shareCarousel" data-slide-to="${j.index}" class=""></li>
					</c:otherwise>
				</c:choose>
		
			</c:forEach>
	
		</ol>
		
	</c:if>
	<div class="carousel-inner">
		<c:forEach items="${videoList}"  var="vlist" varStatus="i" >
			
			<c:choose>
				<c:when test= "${i.index == 0}" >
					<div class="item active" >
					</c:when>
					<c:otherwise>
						<div class="item" >
						</c:otherwise>
					</c:choose>  
					<div class="">	
						
						<div class="col-md-12">		
							
							<div class="col-xs-12 col-sm-12 col-md-4 pull-left text-left hdcontent">
								<div class="hdcontentMinHeight">
									${vlist.videotext} 
								</div>
								<div class="hidden-xs hidden-sm" >
									<button  class="btn btn-lg btnShareApp btnVideoShare" id="videocar_${i.count}" role="button"><img src="${vlist.shareIconPathDesktop}" class="img-responsive" alt=""></button>
								</div>
                                <div class="hidden-xs hidden-sm">
                                    <div id="sharefuction_${i.count}" class="hidden col-md-1 col-xs-6 col-sm-2 sharePopup sharePopupDesktop ">
                                        <a id="fbShareVideo" href="https://www.facebook.com/sharer/sharer.php?u=${finalUrl}" target="_blank"><img src="${properties.fbimage}" class="imgSwap img-responsive" alt="${properties.fbimagealt}"desk-img="${properties.fbimage}" mob-img="${properties.fbimageMobile}"><span class="sr-only">${properties.opensvideonewtab}</span></a>
                                        <a id="twitShareVideo" href="${tUrl}" target="_blank"><img src="${properties.twitterimage}" class="imgSwap img-responsive" alt="${properties.twitterimagealt}" desk-img="${properties.twitterimage}" mob-img="${properties.twitterimageMobile}"><span class="sr-only">${properties.opensvideonewtab}</span></a>
                                        <a id="pinchShareVideo" class="pinchShareVideo" href="https://www.pinterest.com/pin/create/button/" data-pin-do="buttonBookmark" data-pin-custom="true" ><img src="${properties.pinimage}" class="imgSwap img-responsive" alt="${properties.pinimagealt}"desk-img="${properties.pinimage}" mob-img="${properties.pinimageMobile}"></a>
                                        <a id="emailShareVideo" href="mailto:?Body=${properties.emailtext} ${finalUrl}"><img src="${properties.emailimage}" class="imgSwap img-responsive" alt="${properties.emailimagealt}" desk-img="${properties.emailimage}" mob-img="${properties.emailimageMobile}"><span class="sr-only">${properties.opensvideonewtab}</span></a>
                                    </div>
								</div>
								
							</div>
							
							<div class="col-xs-12 col-sm-12 col-md-8  iframevideo video_mask">
								<iframe width="100%" height="460" src="${vlist.videoname}?autoplay=0&rel=0" frameborder="0" allowfullscreen="1" sandbox="allow-scripts allow-same-origin allow-popups"></iframe>
							</div>												
							<div class="visible-xs visible-sm text-center col-xs-12 col-sm-12" >
								<a  class="btn btn-lg btnShareApp btnShareMob btnVideoShare" id="videocar_${i.count}" role="button"><img src="${vlist.shareIconPathMobile}" class="img-responsive" alt=""></a>
							</div>
							
							<div class="visible-xs visible-sm col-md-4 col-xs-12 carouselShareVideoDiv">
								<div id="sharefuction_${i.count}" class="hidden col-md-offset-2 col-md-1 col-xs-offset-6 col-xs-6 col-sm-2 sharePopup ">
									<a id="fbShareVideo" href="https://www.facebook.com/sharer/sharer.php?u=${finalUrl}" target="_blank"><img src="${properties.fbimage}" class="imgSwap img-responsive" alt="${properties.fbimagealt}"desk-img="${properties.fbimage}" mob-img="${properties.fbimageMobile}"><span class="sr-only">${properties.opensvideonewtab}</span></a>
									<a id="twitShareVideo" href="${tUrl}" target="_blank"><img src="${properties.twitterimage}" class="imgSwap img-responsive" alt="${properties.twitterimagealt}" desk-img="${properties.twitterimage}" mob-img="${properties.twitterimageMobile}"><span class="sr-only">${properties.opensvideonewtab}</span></a>
									<a id="pinchShareVideo" class="pinchShareVideo" href="https://www.pinterest.com/pin/create/button/" data-pin-do="buttonBookmark" data-pin-custom="true" ><img src="${properties.pinimage}" class="imgSwap img-responsive" alt="${properties.pinimagealt}"desk-img="${properties.pinimage}" mob-img="${properties.pinimageMobile}"></a>
									<a id="emailShareVideo" href="mailto:?Body=${properties.emailtext} ${finalUrl}"><img src="${properties.emailimage}" class="imgSwap img-responsive" alt="${properties.emailimagealt}" desk-img="${properties.emailimage}" mob-img="${properties.emailimageMobile}"><span class="sr-only">${properties.opensvideonewtab}</span></a>
								</div>
							</div>
							
						</div>
						
					</div>	
					
				</div>
				
			</c:forEach>
			
			<c:forEach items="${videoList}"  var="vlist" varStatus="k" >
				
				
				<c:if test= "${k.index gt 0}" >
					<a class="right carousel-control hidden-xs" href="#shareCarousel" role="button" data-slide="next">
						<img src="/content/dam/adc/fsl/images/global/en/arrow-right.png" alt="">
						<span class="sr-only">Next</span>
					</a>
					
					<a class="left carousel-control hidden-xs" href="#shareCarousel" role="button" data-slide="prev">
						<img src="/content/dam/adc/fsl/images/global/en/arrow-left.png" alt="">
						<span class="sr-only">prev</span>
					</a>
				</c:if>
				
			</c:forEach>
		</div>
	</div>
</div>
</div>     

