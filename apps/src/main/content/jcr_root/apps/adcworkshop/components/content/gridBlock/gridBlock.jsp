<%--
    * Copyright (c)  Vorwerk POC
    * Program Name :  gridBlock.jsp
        * Application  :  Vorwerk POC
            * Purpose      :  See description
                * Description  :  To display tiles component on homepage. 
                    * Modification History:
* ---------------------
    *    Date                                Modified by                                       Modification Description
    *-----------                            ----------------                                    -------------------------
    * 19-Jul-2016                  Cognizant Technology solutions            					Initial Creation
    *-----------                           -----------------                                    -------------------------
    --%>
    <%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<script>   
    
    function hideandshowGroup2Tab(field){
        
        var tabParent = field.findParentByType('tabpanel');	
        
        tabParent.unhideTabStripItem("row_3");
        
        var dialog = field.findParentByType('dialog');	
        var drop1 = dialog.getField("./needGroup2");
        
        var val1 = drop1.getValue();
        
        if(val1=='yes'){
            
            tabParent.unhideTabStripItem("row_3");
        }
        
        else if(val1=='no'){
            tabParent.hideTabStripItem("row_3"); 
        }
    }
    
</script>
<!-- image collage section -->
<section class="image-collage">
    <div class="container">    
        <div class="row">
            <!--ROW 1 STARTS-->
            
            <!--photo block1-->
            <div class="col-sm-7 col-xs-12 padding-zero">   
                <img src="${properties.bckgdImagePhotoBlock1}" class="img-responsive img-calque imgSwap pull-right" alt="${properties.imagealt}" desk-img="${properties.bckgdImagePhotoBlock1}" mob-img="${properties.bckgdImagePhotoBlock1_mobile}"/>
                <!--<p class="text-on-image">${properties.headlineText1}</p>-->
                <h3 class="text-on-image">${properties.headlineText1}<sup><a href="#legalinfoModal" data-toggle="modal"><img src="${properties.infoicon}"   class="text-orange" alt="${properties.infoimagealt}"></a></sup></h3>
                <c:if test="${not empty  properties.ctaLinkText1}">
                    <a href="${properties.ctaLink1}" class="readmore"><img src="${properties.photoArrowDesktop1}" alt="${properties.readimagealt}" desk-img="${properties.photoArrowDesktop1}" mob-img="${properties.photoArrowMobile1}" class="img-read imgSwap">${properties.ctaLinkText1}</a>
                </c:if>
                <div id="legalinfoModal" class="modal fade" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header padding-right">
                                <button type="button" class="close" aria-label="close" data-dismiss="modal">&times;</button>
                            </div>
                            <div class="modal-body">
                                ${properties.infotext}
                            </div>            
                        </div>
                    </div>
                </div>   
                
            </div>
            <!--color block1-->
            <c:set var="pdfLink" value="${properties.typeOfLinkRow1}"></c:set>
            <c:set var="normalLink" value="${properties.typeOfLinkRow1}"></c:set>
            <div class="col-sm-5 col-xs-6 padding-zero colorbox-0 text-center" style="background-color:#${properties.bgcolour1}"> 
                <div class="bg-watermark">
                    <c:if test="${not empty  properties.thumbnailImage1}">
                        
                        <img class = "img-responsive img-circle round-img img-thumbnail imgSwap" src="${properties.thumbnailImage1}" alt="${properties.thumbimagealt}" desk-img="${properties.thumbnailImage1}" mob-img="${properties.thumbnailImage1_mobile}">
                    </c:if>
                    
                    <h3 class="name" >${properties.headline1}</h3>
                    <p >${properties.bodyText1}</p>
                    <c:choose>
                        <c:when test="${normalLink eq 'testimonialrow1'}" >
                            
                            <a href="#myModal-1" data-toggle="modal" class="btn"><img src="${properties.colorArrowDesktop1}" desk-img="${properties.colorArrowDesktop1}" mob-img="${properties.colorArrowMobile1}"  class="imgSwap" alt="${properties.discoverimagealt}"><span class="discover1">${properties.ctaLinkText2}</span></a>
                        </c:when>
                        <c:when test="${pdfLink eq 'pdfLinkrow1'}">
                            <a href="${properties.ctaLinkpdfrow1}" target="_blank" class="btn"><img src="${properties.colorArrowDesktop1}" desk-img="${properties.colorArrowDesktop1}" mob-img="${properties.colorArrowMobile1}"  class="imgSwap" alt="${properties.discoverimagealt}"><span class="discover1">${properties.ctaLinkText2}</span></a>
                        </c:when>
                    </c:choose>
                </div>
            </div>
            <!-- ROW 1 ENDS-->
            
            <!--ROW 2 STARTS-->
            <div class="col-sm-5 col-xs-6 mob-twocol-collage">
                <div class="row">
                    <!-- photo block left-->
                    <img src="${properties.stackedPhotoBlock1}" class="img-responsive img-calque1 imgSwap pull-right" alt="${properties.stackedimagealt}" desk-img="${properties.stackedPhotoBlock1}" mob-img="${properties.stackedPhotoBlock1_mobile}"/>
                    <h3 class="text-on-image">${properties.stackedHeadline1}</h3>
                    <c:if test="${not empty  properties.ctaLinkText1}">
                        
                        <a href="${properties.stackedCtaLink1}" class="readmore readmoreMobile"><img src="${properties.stackPhotoArrowDesktop1}"  desk-img="${properties.stackPhotoArrowDesktop1}" mob-img="${properties.stackPhotoArrowMobile1}" alt="${properties.readimagealt}" class="img-read imgSwap"/>${properties.stackedCtaLinkText1}</a>
                    </c:if>
                    
                </div>
                <!-- row 2 color block left desktop-->
                
                <c:set var="pdfLink2" value="${properties.typeOfLinkrow2}"></c:set>
                <c:set var="normalLink2" value="${properties.typeOfLinkrow2}"></c:set>
                <div class="row colorbox text-center hidden-xs" style="background-color:#${properties.stackedBgcolour}">
                    <div class="bg-watermark">
                        <c:if test="${not empty  properties.stackedthumbnailImage}">
                            <img class = "img-responsive img-circle round-img img-thumbnail imgSwap" src="${properties.stackedthumbnailImage}" alt="${properties.stackedthumbimagealt}" 
                            width="100" desk-img="${properties.stackedthumbnailImage}" mob-img="${properties.stackedthumbnailImage_mobile}"/>
                        </c:if>
                        <h3 class="name" >${properties.stackedHeadline}</h3>
                        <p>${properties.stackedBodyText}</p>
                        <c:choose>
                            <c:when test="${normalLink2 eq 'testimonialrow2'}" >
                                <a href="#myModal-2" data-toggle="modal" class="btn"><img src="${properties.colorArrowDesktop1}"  alt="${properties.discoverimagealt}" desk-img="${properties.colorArrowDesktop1}" mob-img="${properties.colorArrowMobile1}" class="imgSwap"><span class="discover1">${properties.stackedCtaLinkText2}</span></a>
                            </c:when>
                            <c:when test="${pdfLink2 eq 'pdfLinkrow2'}">
                                <a href="${properties.ctaLinkpdfrow2}" target="_blank" class="btn"><img src="${properties.colorArrowDesktop1}" desk-img="${properties.colorArrowDesktop1}" mob-img="${properties.colorArrowMobile1}"  class="imgSwap" alt="${properties.discoverimagealt}"><span class="discover1">${properties.stackedCtaLinkText2}</span></a>
                            </c:when>
                        </c:choose>
                        
                    </div>
                </div>
            </div>        
            
            <!-- ROW 2 photo block RIGHT-->
            
            <div class="col-sm-7 col-xs-12 padding-zero textBottom" >
                
                <img src="${properties.bckgdImageHeroBlock}" class="img-responsive img-calque2 imgSwap" alt="${properties.heroimagealt}"
                desk-img="${properties.bckgdImageHeroBlock}" mob-img="${properties.bckgdImageHeroBlock_mobile}"/>
                
                <h3>${properties.heroHeadlineText}</h3>
                <c:if test="${not empty  properties.heroCtaLinkText1}">
                    <a href="${properties.heroCtaLink1}" class="readmore"><img src="${properties.heroArrowDesktop1}" desk-img="${properties.heroArrowDesktop1}" mob-img="${properties.heroArrowMobile1}" alt="${properties.readimagealt}" class="img-read imgSwap">${properties.heroCtaLinkText1}</a>
                </c:if>
            </div>
            
            
            
            <c:if test="${properties.needGroup2 eq 'yes'}">
                <!-- ROW 3 photo block left-->
                
                <div class="col-sm-5 col-xs-6 padding-zero mob-twocol-collage textBottom">      
                    <img src="${properties.bckgdImagePhotoBlock3}" class="img-responsive img-calque-1 imgSwap pull-right" alt="${properties.bckgdImagePhotoBlock3}" desk-img="${properties.bckgdImagePhotoBlock3}" mob-img="${properties.bckgdImagePhotoBlock3_mobile}"/>
                    <h3>${properties.headlineText}</h3>
                    <c:if test="${not empty  properties.ctaLink3}">
                        <a href="${properties.ctaLink3}" class="readmore"><img src="${properties.photoArrowDesktop3}" desk-img="${properties.photoArrowDesktop3}" mob-img="${properties.photoArrowMobile3}" alt="${properties.readimagealt}" class="img-read imgSwap"/>${properties.ctaLinkText3}</a>
                    </c:if>
                </div>
                
                <!-- row 2 color block left mobile-->
                <c:set var="pdfLink2" value="${properties.typeOfLinkrow2}"></c:set>
                <c:set var="normalLink2" value="${properties.typeOfLinkrow2}"></c:set>
                <div class="col-sm-5 col-xs-6 visible-xs">
                    <div class="row colorbox text-center" style="background-color:#${properties.stackedBgcolour}"> 
                        <div class="bg-watermark">
                            <c:if test="${not empty  properties.stackedthumbnailImage}">
                                <img class = "img-responsive img-circle round-img img-thumbnail imgSwap" src="${properties.stackedthumbnailImage}" alt="${properties.stackedthumbimagealt}" desk-img="${properties.stackedthumbnailImage}" mob-img="${properties.stackedthumbnailImage_mobile}"/>
                            </c:if>    
                            <h3 class="name" >${properties.stackedHeadline}</h3>
                            <p>${properties.stackedBodyText}</p>
                            <c:choose>
                                <c:when test="${normalLink2 eq 'testimonialrow2'}" >
                                    <a href="#myModal-2" data-toggle="modal" class="btn"><img src="${properties.stackColorArrowDesktop1}"  alt="${properties.discoverimagealt}" desk-img="${properties.stackColorArrowDesktop1}" mob-img="${properties.stackColorArrowMobile1}" class="imgSwap"><span class="discover1">${properties.stackedCtaLinkText2}</span></a>
                                </c:when>
                                <c:when test="${pdfLink2 eq 'pdfLinkrow2'}">
                                    <a href="${properties.ctaLinkpdfrow2}" target="_blank" class="btn"><img src="${properties.stackColorArrowDesktop1}"  alt="${properties.discoverimagealt}" desk-img="${properties.stackColorArrowDesktop1}" mob-img="${properties.stackColorArrowMobile1}" class="imgSwap"><span class="discover1">${properties.stackedCtaLinkText2}</span></a>
                                </c:when>
                            </c:choose>
                        </div> 
                    </div>
                </div>
            </c:if>
            
            <c:if test="${properties.needGroup2 eq 'no'}">
                <!-- row 2 color block left mobile without group 2-->
                <c:set var="pdfLink2" value="${properties.typeOfLinkrow2}"></c:set>
                <c:set var="normalLink2" value="${properties.typeOfLinkrow2}"></c:set>
                <div class="col-sm-12 col-xs-12 visible-xs">
                    <div class="row colorbox text-center" style="background-color:#${properties.stackedBgcolour}"> 
                        <img class = "img-responsive img-circle round-img img-thumbnail imgSwap" src="${properties.stackedthumbnailImage}" alt="${properties.stackedthumbimagealt}" desk-img="${properties.stackedthumbnailImage}" mob-img="${properties.stackedthumbnailImage_mobile}"/>
                        <h3 class="name" >${properties.stackedHeadline}</h3>
                        <p>${properties.stackedBodyText}</p>
                        <c:choose>
                            <c:when test="${normalLink2 eq 'testimonialrow2'}" >
                                
                                <a href="#myModal-2" data-toggle="modal" class="btn"><img src="${properties.stackColorArrowDesktop1}"  alt="${properties.discoverimagealt}" desk-img="${properties.stackColorArrowDesktop1}" mob-img="${properties.stackColorArrowMobile1}" class="imgSwap"><span class="discover1">${properties.stackedCtaLinkText2}</span></a>
                            </c:when>
                            <c:when test="${pdfLink2 eq 'pdfLinkrow2'}">
                                <a href="${properties.ctaLinkpdfrow2}" target="_blank" class="btn"><img src="${properties.stackColorArrowDesktop1}"  alt="${properties.discoverimagealt}" desk-img="${properties.stackColorArrowDesktop1}" mob-img="${properties.stackColorArrowMobile1}" class="imgSwap"><span class="discover1">${properties.stackedCtaLinkText2}</span></a>
                            </c:when>
                        </c:choose>
                        
                        
                    </div>
                </div>
            </c:if>
            <!-- row 2-->
            <!-- ROW 3 COLOR BLOCK STARTS-->
            <c:set var="pdfLink3" value="${properties.typeOfLinkrow3}"></c:set>
            <c:set var="normalLink3" value="${properties.typeOfLinkrow3}"></c:set>
            <c:if test="${properties.needGroup2 eq 'yes'}">
                <div class="col-sm-7 col-xs-12 colorbox-1 padding-zero text-left" id="discoverStortyLinkBtn" style="background-color: #${properties.bgcolour3}">         
                    <h3>${properties.headline3}</h3>
                    <p>${properties.bodyText3}<br>
                        <c:choose>
                            <c:when test="${normalLink3 eq 'testimonialrow3'}">
                                <a href="#myModal-3" data-toggle="modal" class="btn" alt="About Diabeties control"><img src="${properties.colorArrowDesktop3}" class="imgSwap" desk-img="${properties.colorArrowDesktop3}" mob-img="${properties.colorArrowMobile3}" alt="${properties.imagealt3}"><span class="padding-disc">${properties.ctaLinkText4}</span></a>
                            </c:when> 
                            <c:when test="${pdfLink3 eq 'pdfLinkrow3'}">
                                <a href="${properties.ctaLinkpdfrow3}" target="_blank" class="btn"><img src="${properties.colorArrowDesktop3}" desk-img="${properties.colorArrowDesktop3}" mob-img="${properties.colorArrowMobile3}"  class="imgSwap" alt="${properties.imagealt3}"><span class="padding-disc">${properties.ctaLinkText4}</span></a>
                            </c:when>
                        </c:choose>
                    </div>
            </c:if>
            <!-- ROW 3 COLOR BLOCK ENDS-->
        </div>
    </div>    
</section>

