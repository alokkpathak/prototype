<%--
* Copyright (c)  Vorwerk POC
* Program Name :  video_panel.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  This component will be used to show videos on the page.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 14-Jul-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp" %>
<%@page session="false" %>
<%@page import="java.net.URI,java.io.*"%>
<%@page import="java.util.HashMap, java.util.Map"%>

<% 
    String[] multiProp = {"path","mobilepath","title","icon","mobileicon","titleHeader","link","titleFooter","text","iconimagealt","imagealt"};
 	pageContext.setAttribute("multiFieldSet1", multiProp);
%>

<adc:multicompositefield var="var" fieldNodeName="details" fieldPropertyNames="${multiFieldSet1}" returnType="List" />

<section class="text-center container-fluid" style="background:#FFC11B;">
	<div class="help-video">
		<!-- about section -->
		<div class="row">
			<div class="about container text-center">			
				<div class="col-md-8 col-md-offset-2 ">
					<h2>
						<strong>${properties.headline}</strong>
					</h2>									
					<p>${properties.description}</p>
				</div>
			</div>
		</div>
        <%
    String currentURL=currentPage.getPath();
	pageContext.setAttribute("currentURL", currentURL);
%>
<c:set var="scheme" value="${pageContext.request.scheme}"/>
<c:set var="domainName" value="${pageContext.request.serverName}"/>
<adc:minifyUrlTag  var="miniUrl" actualUrl="${currentURL}" />
<c:set var="finalUrl" value="${scheme}://${domainName}${miniUrl}"/>
<c:set var="showshare" value="${properties.showshareicon}"/>
        <c:if test="${showshare eq 'true'}">
        <cq:include path="./share" resourceType="adcworkshop/components/content/share" />
		</c:if>
		 <adc:shareProperties  var="shareProp" />
        <c:set var="tweet" value="${shareProp['twittertext']}"/>
		<c:set var="shareinclude" value="${shareProp['hidecomponent']}"/>
		<c:if test="${not empty shareProp['twittertext']}" >

        <%

			String tquery= "text="+(String)pageContext.getAttribute("tweet")+(String)pageContext.getAttribute("finalUrl");
			URI turl = new URI("http","twitter.com","/intent/tweet",tquery,null);
			String tUrl=turl.toASCIIString();
			pageContext.setAttribute("tUrl", tUrl);
		%>
    	</c:if>


		<!-- end of about section -->
		<div class="v-padding-top">	
			<div class="row">	
				<div class="col-md-10 col-md-offset-1 tutorial">
					<c:forEach var="item" items="${var}" varStatus="i">
						<div class="col-md-3">
							<div class="bs-example">
                                <a href="#myModal-${i.count}" data-toggle="modal"><img src="${item.path}" class="imgSwap shareImgPane" desk-img="${item.path}"mob-img="${item.mobilepath}" width="100%" alt="${item.imagealt}"></a>
								<h2>${item.title}</h2>
								<div id="myModal-${i.count}" class="modal fade" tabindex="-1">
									<div class="modal-dialog ">
										<div class="modal-content">
											<div class="visible-xs visible-sm">
												<button type="button" class="btn-link pull-left  mob-popup" aria-label="close"  data-dismiss="modal">&#x274c;close</button>
											</div>
											<div class="modal-header">
												<c:if test="${shareinclude eq 'true'}">
											<c:if test="${not empty item.icon}">
                                                <a href="#" id="btnVideoshareTut" class="btn btn-lg button-orange btnVideoshareTutStyle  btn-popup" role="button">                                                
                                                <img src="${item.icon}"  class="imgSwap share-test pull-left" alt="${item.iconimagealt}" desk-img="${item.icon}"mob-img="${item.mobileicon}">${properties.sharetext}</a>
                                                    	</c:if>
														</c:if>
                                                	<div class="col-md-12 col-xs-12">
											            <div id="videofuction-${i.count}" class="hidden shareVideoTut col-md-1 col-xs-2 col-sm-1 pull-right">
											                <c:if test="${shareProp['fbcheck'] eq 'true'}">
                                                                <a id="fbShareVideo" href="https://www.facebook.com/sharer/sharer.php?u=${finalUrl}" target="_blank" title=""><img src="${shareProp['fbimage']}" class="imgSwap img-responsive" alt="${shareProp['fbimagealt']}" desk-img="${shareProp['fbimage']}" mob-img="${shareProp['fbimageMobile']}"><span class="sr-only">${shareProp['opensnewtab']}</span></a>
											                </c:if> 
											                <c:if test="${shareProp['twittercheck'] eq 'true'}">
                                                                <a id="twitShareVideo" href="${tUrl}" target="_blank" title=""><img src="${shareProp['twitterimage']}" class="imgSwap img-responsive" alt="${shareProp['twitterimagealt']}" desk-img="${shareProp['twitterimage']}" mob-img="${shareProp['twitterimageMobile']}"><span class="sr-only">${shareProp['opensnewtab']}</span></a>
											                </c:if> 
											                <c:if test="${shareProp['pincheck'] eq 'true'}">
											                    <a id="pinchShareVideo" class="pinchShareVideo" href="https://www.pinterest.com/pin/create/button/" data-pin-do="buttonBookmark"
   data-pin-custom="true" title=""><img src="${shareProp['pinimage']}" class="imgSwap img-responsive" alt="${shareProp['pinimagealt']}" desk-img="${shareProp['pinimage']}" mob-img="${shareProp['pinimageMobile']}"><span class="sr-only">${shareProp['opensnewtab']}</span></a>
											                </c:if> 
											                <c:if test="${shareProp['emailcheck'] eq 'true'}">
                                                                <a id="emailShareVideo" href="mailto:?body=${shareProp['emailtext']} ${finalUrl}" title=""><img src="${shareProp['emailimage']}" class="imgSwap img-responsive" alt="${shareProp['emailimagealt']}" desk-img="${shareProp['emailimage']}" mob-img="${shareProp['emailimageMobile']}"><span class="sr-only">${shareProp['opensnewtab']}</span></a>
											                </c:if> 
											            </div>
											        </div>
												<h4 class="modal-title word-title">${item.titleHeader}</h4>
											</div>
											<div class="modal-body">
												<iframe id="cartoonVideo" width="100%" src="${item.link}?autoplay=0&rel=0" frameborder="0" allowfullscreen sandbox="allow-scripts allow-same-origin allow-popups"></iframe>
											</div>
											<div class="modal-footer ">
												<h4 class="modal-title ">${item.titleFooter}</h4>
												<p class="text-left">${item.text}</p>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div> 
					</c:forEach>
					<div class="text-center btnLoadMore visible-sm visible-xs">
                        <a class="btn btn-lg">${properties.loadMoreBtn}</a>
                    </div>
				</div>
			</div>
		</div>
	</div>	
</section>