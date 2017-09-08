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
* 11-Jul-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>
<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>


<%
    String[] heroSlidesDetails = {"headline1","headline2","headline3","infohead","infotext","tooltiptext","img","imagealt","imgMobile","firstbuttonname","firstbuttonlink","secondbuttonname","secondbuttonlink","infoIcon","infoTitle","infoAltText","bottomtext"};
pageContext.setAttribute("heroSlidesDetails", heroSlidesDetails);

%>
<adc:multicompositefield var="heroSlidesList" fieldNodeName="heroMulti" fieldPropertyNames="${heroSlidesDetails}" returnType="List" />


<c:if test="${properties.panelType eq 'heropanel_richtext'}">
   <div class="container-fluid " style="background-color: #EAEDED;">
    <div class="row " >
        <div class="col-md-12 banner-new padding-left padding-right">
            <input type="hidden" id="tooltiptextdisplay" value="${properties.tooltiptext}" >

            <img src=${properties.img} alt="${properties.imagealt}" class="img-responsive imgSwap" desk-img="${properties.img}" mob-img="${properties.imgMobile}" >
            <div class="banner-desc">
                ${properties.richtext1} 
                ${properties.richtext2}
				<c:if test="${not empty properties.firstbuttonname}">
                <a id="discoverAnalytics" href="${properties.firstbuttonlink}" class="btn btn-info" role="button">${properties.firstbuttonname}</a>
				</c:if>
				<c:if test="${not empty properties.secondbuttonname}">
                <a id="buyAnalytics" href="${properties.secondbuttonlink}" class="btn btn-info" role="button" style="background-color:#e4572d; color:#FFFFFF;">${properties.secondbuttonname}</a>
				</c:if>
            </div>      			
        </div>
        <div id="heropanelinfoModal" class="modal fade" tabindex="-1">
            <div class="modal-dialog">

                <div class="modal-content">
                    <div class="modal-header padding-right">
                        <button type="button" class="close" aria-label="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">${properties.infoheader}</h4>
                    </div>
                    <div class="modal-body">
                        ${properties.infotext}
                    </div>            
                </div>

            </div>
        </div>
        </div>
    </div>


</c:if>

<c:if test="${properties.panelType eq 'heropanel_carousel'}">
<c:if test="${fn:length(heroSlidesList)>0}">
<c:forEach items="${heroSlidesList}" var="heroModalList" varStatus="heroModal">
<div id="heropanelinfoModal_${heroModal.count}" class="modal fade heropanelinfo" tabindex="-1">
		<div class="modal-dialog">

			<div class="modal-content">
				<div class="modal-header padding-right">
					<button type="button" class="close" aria-label="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">${heroModalList.infohead}</h4>
				</div>
				<div class="modal-body">
					${heroModalList.infotext}
				</div>            
			</div>

		</div>
	</div>
	</c:forEach>
</c:if>
<div id="hero-panel-carousel" class="carousel slide" data-ride="carousel">
<c:if test="${fn:length(heroSlidesList)>1}">
<ol class="carousel-indicators carousel-rect">


<c:forEach items="${heroSlidesList}" varStatus="slideButtonCount">
<c:choose>
<c:when test="${slideButtonCount.index==0}">
<li data-target="#hero-panel-carousel" data-slide-to="0" class="active"></li>
</c:when>
<c:otherwise>
<li data-target="#hero-panel-carousel" data-slide-to="${slideButtonCount.count-1}"></li>
</c:otherwise>
</c:choose>
</c:forEach>
   </ol>  	
 </c:if>
<div class="carousel-inner">
<c:if test="${fn:length(heroSlidesList)>0}">

<c:forEach items="${heroSlidesList}" var="heroDetails" varStatus="slideCount">
		<c:choose>
		<c:when test="${slideCount.index == 0}">
		<div class="item active">
		</c:when>
		<c:otherwise>
		<div class="item">
		</c:otherwise>
		</c:choose>
<div class="col-md-12 banner-new padding-left padding-right">
	<input type="hidden" id="tooltiptextdisplay" value="${heroDetails.tooltiptext}" >

	<img src=${heroDetails.img} alt="${heroDetails.imagealt}" class="img-responsive imgSwap hero-carousel-image" desk-img="${heroDetails.img}" mob-img="${heroDetails.imgMobile}" >
	<div class="banner-desc heropanel${slideCount.count}">
                <div class="banner-topHeadline"> </div>

		<h1 class="text-orange">${heroDetails.headline1} <span class="img-font">${heroDetails.headline2}</span> <span class="img-fontSecond">${heroDetails.headline3}</span><sup><a href="#heropanelinfoModal_${slideCount.count}" data-toggle="modal"><img src="${heroDetails.infoIcon}"  alt="${heroDetails.infoAltText}"></a></sup></h1>

		<c:if test="${not empty heroDetails.firstbuttonname}">
		<a id="discoverAnalytics" href="${heroDetails.firstbuttonlink}" class="btn btn-info" role="button">${heroDetails.firstbuttonname}</a>
		</c:if>
		<c:if test="${not empty heroDetails.secondbuttonname}">
		<a id="buyAnalytics" href="${heroDetails.secondbuttonlink}" class="btn btn-info" role="button" style="background-color:#e4572d; color:#FFFFFF;">${heroDetails.secondbuttonname}</a>
		</c:if>


	</div> 
     <div class="col-md-12 legalMentionContainer">
	<div class="heroPanelLegalMention">

             ${heroDetails.bottomtext}

        </div>

        </div> 
</div>


</div>

</c:forEach>
    </c:if>
</div>
<c:if test="${fn:length(heroSlidesList)>1}">
<a class="left carousel-control" href="#hero-panel-carousel" role="button" data-slide="prev">
  <img src="/content/dam/adc/fsl/images/global/en/desktopImages/arrow-left1.png" alt="">

<span class="sr-only">Previous</span>
</a>
<a class="right carousel-control" href="#hero-panel-carousel" role="button" data-slide="next">
  <img src="/content/dam/adc/fsl/images/global/en/desktopImages/arrow-right1.png" alt="">

<span class="sr-only">Next</span>
</a>
</c:if>
</div>
    </c:if>
