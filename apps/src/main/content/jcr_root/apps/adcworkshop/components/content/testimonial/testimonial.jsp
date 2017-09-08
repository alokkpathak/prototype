<%--
* Copyright (c)  Vorwerk POC
* Program Name :  testimonial.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  When we click on the links on the testimonial block of grid block component, a pop up opens as an overlay, which displays the testimonial content.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 14-Jul-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<%@page import="java.net.URI,java.io.*"%>
<%@page import="java.util.HashMap, java.util.Map"%>
<%

String [] testimonialList={"testimonialType","share_image_desktop", "share_image_mobile","name","headline","bodyCopy","testimonial_image_desktop","testimonial_image_mobile", "videoUrl","imagealt","testimonialimagealt"};
pageContext.setAttribute("testimonialsList",testimonialList);
%>
<adc:multicompositefield var="testimonialList" fieldNodeName="testimonials" fieldPropertyNames="${testimonialsList}" returnType="List" />
<%
String currentURL=currentPage.getPath();
pageContext.setAttribute("currentURL", currentURL);
%>
<c:set var="scheme" value="${pageContext.request.scheme}"/>
<c:set var="domainName" value="${pageContext.request.serverName}"/>
<adc:minifyUrlTag  var="miniUrl" actualUrl="${currentURL}" />
<c:set var="finalUrl" value="${scheme}://${domainName}${miniUrl}"/>
	<cq:include path="share" resourceType="adcworkshop/components/content/share" />
	
	 <adc:shareProperties  var="shareProp" />
	<c:set var="tweet" value="${shareProp['twittertext']}"/>
	
	<c:if test="${not empty shareProp['twittertext']}" >

	<%

		String tquery= "text="+(String)pageContext.getAttribute("tweet")+(String)pageContext.getAttribute("finalUrl");
		URI turl = new URI("http","twitter.com","/intent/tweet",tquery,null);
		String tUrl=turl.toASCIIString();
		pageContext.setAttribute("tUrl", tUrl);
	%>
	</c:if>

<section class="testimonial">
<c:forEach items="${testimonialList}" var="eachTestimonialItem" varStatus="testCount">
	<div id="myModal-${testCount.count}" class="modal fade" tabindex="-1">
			  <div class="modal-dialog ">
				  <div class="modal-content">
				  <div class="visible-xs col-xs-12 visible-sm col-sm-12">
				  <button type="button" class="btn-link pull-left  mob-popup" aria-label="close" data-dismiss="modal">&#x274c;close</button>
				  </div>
					  <div class="modal-header">
						  <a href="" id="btnVideoshareTut" class="btn btn-lg button-orange btnVideoshareTutStyle  btn-popup" role="button">
							  <img src="${eachTestimonialItem.share_image_desktop}"  class="share-test pull-left imgSwap" alt="${eachTestimonialItem.imagealt}" desk-img="${eachTestimonialItem.share_image_desktop}" mob-img="${eachTestimonialItem.share_image_mobile}"></a>
						  <div class="col-md-12 col-xs-12">
													<div id="videofuction-${testCount.count}" class="hidden shareVideoTut col-md-1 col-xs-2 col-sm-2 pull-right">
														<c:if test="${shareProp['fbcheck'] eq 'true'}">
															<a id="fbShare" href="https://www.facebook.com/sharer/sharer.php?u=${finalUrl}" target="_blank"><img src="${shareProp['fbimage']}" class="img-responsive" alt="${shareProp['fbimagealt']}"><span class="sr-only">${properties.openstestimonialnewtab}</span></a>
														</c:if> 
														<c:if test="${shareProp['twittercheck'] eq 'true'}">
															<a id="twitShare" href="${tUrl}" target="_blank"><img src="${shareProp['twitterimage']}" class="img-responsive" alt="${shareProp['twitterimagealt']}"><span class="sr-only">${properties.openstestimonialnewtab}</span></a>
														</c:if> 
														<c:if test="${shareProp['pincheck'] eq 'true'}">
															<a id="pinchShare" class="pinchShareVideo" href="https://www.pinterest.com/pin/create/button/" data-pin-do="buttonBookmark"
data-pin-custom="true" ><img src="${shareProp['pinimage']}" class="img-responsive" alt="${shareProp['pinimagealt']}"></a>
														</c:if> 
														<c:if test="${shareProp['emailcheck'] eq 'true'}">
															<a id="emailShare" href="mailto:?body=${shareProp['emailtext']} ${finalUrl}"><img src="${shareProp['emailimage']}" class="img-responsive" alt="${shareProp['emailimagealt']}"><span class="sr-only">${properties.openstestimonialnewtab}</span></a>
														</c:if> 
													</div>
												</div>
						  <div class="col-xs-12">
							  <h4 class="modal-title">${eachTestimonialItem.name}</h4>
						  </div>
					  </div>
					   <div class="modal-body">
					<c:if test="${eachTestimonialItem.testimonialType eq 'video'}">
						<iframe id="cartoonVideo" width="560" height="315" src="${eachTestimonialItem.videoUrl}" frameborder="0" allowfullscreen sandbox="allow-scripts allow-same-origin allow-popups"></iframe>
					</c:if>
					<c:if test="${eachTestimonialItem.testimonialType eq 'text'}">
						<img src="${eachTestimonialItem.testimonial_image_desktop}" width="100%" alt="${eachTestimonialItem.testimonialimagealt}" desk-img="${eachTestimonialItem.testimonial_image_desktop}" mob-img="${eachTestimonialItem.testimonial_image_mobile}" class="imgSwap">
					</c:if>
				</div>
					  <div class="modal-footer ">
						  <h4 class="modal-title ">${eachTestimonialItem.heading}</h4>
						  <p class="text-left">${eachTestimonialItem.bodyCopy}</p>
					  </div>
				  </div>
			  </div>
		  </div>
</c:forEach>


</section>
<!-- end of image collage section	 -->
