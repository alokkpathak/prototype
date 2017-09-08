<%--
* Copyright (c)  Vorwerk POC
* Program Name :  video.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Used for including video to showcase product campaign on the landing page.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 14-Jul-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>
<%@include file="/apps/adcworkshop/components/shared/global.jsp" %>
<%@page session="false" %>


<c:set var="flag" value="1" scope="request" />
<c:set var="paramtext" value="${properties.buttonText}" scope="request" />
<section class="videoWrapper container-fluid padding-zero" >
		<div class=" ">
            <div class="col-md-4 videoDescription text-left " style="background-color:#${properties.backColor}">
                <h2>${properties.title}</h2>
					<div class="vdDscription">
                        <p>${properties.description}</p>
					</div>
				</div>
				<div class="col-md-8  col-xs-12">
					<div style="color:gray;">
						<div class="">
							<div class="embed-responsive embed-responsive-16by9 videoContainer">
                                <iframe  id="playerembd" style="display: none;" onload="this.style.display='block';" class="embed-responsive-item" src="${properties.link}?autoplay=0&enablejsapi=1&rel=0" frameborder="0" allowfullscreen="1" sandbox="allow-scripts allow-same-origin allow-popups"></iframe>
					        </div>
                            <cq:include path="./share" resourceType="adcworkshop/components/content/share" />
						</div>
					</div>
				</div>
		</div>
</section>