<%--
* Copyright (c)  Vorwerk POC
* Program Name :  share.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  To share information through social medias.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 03-Sep-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp" %>
<%@page session="false" %>
<%@page import="java.net.URI,java.io.*"%>


<%
    String currentURL=currentPage.getPath();
	pageContext.setAttribute("currentURL", currentURL);
%>
<adc:globalSettingsTag  var="domainName"  currentDomain="true" />
<adc:minifyUrlTag  var="miniUrl" actualUrl="${currentURL}" />
<c:set var="finalUrl" value="${domainName}${miniUrl}"/>
<c:set var="fbcheck" value="${properties.fbcheck}"></c:set>
<c:set var="twittercheck" value="${properties.twittercheck}"></c:set>
<c:set var="pincheck" value="${properties.pincheck}"></c:set>
<c:set var="emailcheck" value="${properties.emailcheck}"></c:set>
<%

    String tquery= "text="+properties.get("twittertext","twittertext")+(String)pageContext.getAttribute("finalUrl");
	URI turl = new URI("http","twitter.com","/intent/tweet",tquery,null);
	String tUrl=turl.toASCIIString();
	pageContext.setAttribute("tUrl", tUrl);
%>

<c:if test="${empty properties.hidecomponent}"> 
	<c:choose>
	    <c:when test="${not empty flag}">
			<button id ="btnVideoShare" class="btn btn-lg btnShareVideo hidden-xs"><img src="${properties.shareIconDesktop}" class="img-responsive" alt=""></button> 
			<div class="text-center col-xs-12 visible-xs">
				<button id ="btnVideoShare" class="btn btn-lg btnShareVideo " role="button"><img src="${properties.shareIconMobile}" class="img-responsive" alt=""></button>
			</div>
	        <div class="col-md-12 col-xs-12">
	            <div id="videofuction" class="hidden col-md-1 col-xs-2 col-sm-1 pull-right">
	                <c:if test="${fbcheck eq 'true'}">
						<div data-href="${finalUrl}">
							<a class="fb-xfbml-parse-ignore" id="fbShareVideo" href="https://www.facebook.com/sharer/sharer.php?u=${finalUrl}" target="_blank" title=""><img src="${properties.fbimage}" class="imgSwap img-responsive" alt="${properties.fbimagealt}" desk-img="${properties.fbimage}" mob-img="${properties.fbimageMobile}"><span class="sr-only">${properties.opensnewtab}</span></a>
						</div>
	                </c:if> 
	                <c:if test="${twittercheck eq 'true'}">
	                    <a id="twitShareVideo" href="${tUrl}" target="_blank" title=""><img src="${properties.twitterimage}" class="imgSwap img-responsive" alt="${properties.twitterimagealt}"  desk-img="${properties.twitterimage}" mob-img="${properties.twitterimageMobile}"><span class="sr-only">${properties.opensnewtab}</span></a>
	                </c:if> 
	                <c:if test="${pincheck eq 'true'}">
	                    <a id="pinchShareVideo" class="pinchShareVideo" href="https://www.pinterest.com/pin/create/button/" data-pin-do="buttonBookmark" data-pin-custom="true" title=""><img src="${properties.pinimage}" class="imgSwap img-responsive" alt="${properties.pinimagealt}"  desk-img="${properties.pinimage}" mob-img="${properties.pinimageMobile}"><span class="sr-only">${properties.opensnewtab}</span></a>
	                </c:if> 
	                <c:if test="${emailcheck eq 'true'}">
	                    <a id="emailShareVideo" href="mailto:?body=${properties.emailtext} ${finalUrl}" title=""><img src="${properties.emailimage}" class="imgSwap img-responsive" alt="${properties.emailimagealt}"  desk-img="${properties.emailimage}" mob-img="${properties.emailimageMobile}"><span class="sr-only">${properties.opensnewtab}</span></a>
	                </c:if> 
	            </div>
	        </div>
		</c:when>
	    <c:otherwise>
	        <button id="btnProductShare" class="btn btn-lg button-orange"  style="background-color:#E4572D;">
	            <img src="${properties.paramimage}"  class="imgSwap share-btn" alt="${properties.shareimagealt}" desk-img="${properties.paramimage}" mob-img="${properties.paramimageMobile}">
	    		<c:out value="${properties.paramtext}"/>
			</button>
			<div id="sharefuction" class="hidden col-md-1 col-xs-2 col-sm-1 sharefuction">
				<c:if test="${fbcheck eq 'true'}">
				<div data-href="${finalUrl}">
	    			<a class="fb-xfbml-parse-ignore" id="fbShare" href="https://www.facebook.com/sharer/sharer.php?u=${finalUrl}&amp;src=sdkpreparse" target="_blank" title="${properties.opensnewtab}"><img src="${properties.fbimage}" class="imgSwap img-responsive" alt="${properties.fbimagealt}" desk-img="${properties.fbimage}" mob-img="${properties.fbimageMobile}"><span class="sr-only">${properties.opensnewtab}</span></a>
				</div>			
				</c:if> 
				<c:if test="${twittercheck eq 'true'}">
	    			<a id="twitShare" href="${tUrl}" target="_blank" title=""><img src="${properties.twitterimage}" class="imgSwap img-responsive" alt="${properties.twitterimagealt}" desk-img="${properties.twitterimage}" mob-img="${properties.twitterimageMobile}"><span class="sr-only">${properties.opensnewtab}</span></a>
				</c:if> 
				<c:if test="${pincheck eq 'true'}">
	    			<a id="pinchShare" class="pinchShareVideo" href="https://www.pinterest.com/pin/create/button/" data-pin-do="buttonBookmark" data-pin-custom="true" title=""><img src="${properties.pinimage}" class="imgSwap img-responsive" alt="${properties.pinimagealt}" desk-img="${properties.pinimage}" mob-img="${properties.pinimageMobile}"><span class="sr-only">${properties.opensnewtab}</span></a>
	     		</c:if> 
				<c:if test="${emailcheck eq 'true'}">
                    <a id="emailShare" href="mailto:?body=${properties.emailtext} ${finalUrl}" title=""><img src="${properties.emailimage}" class="imgSwap img-responsive" alt="${properties.emailimagealt}" desk-img="${properties.emailimage}" mob-img="${properties.emailimageMobile}"><span class="sr-only">${properties.opensnewtab}</span></a>
	     		</c:if> 
			</div>
	    </c:otherwise>
	</c:choose>

</c:if>




