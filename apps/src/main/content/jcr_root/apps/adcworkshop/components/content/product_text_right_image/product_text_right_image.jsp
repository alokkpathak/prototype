<%--
* Copyright (c)  Vorwerk POC
* Program Name :  produc_text_image.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  For displaying product text image.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 19-Jul-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp" %>
<%@page session="false" %> 

<c:set var="paramimage" value="${properties.shareimagepath}" scope="request" />
<c:set var="paramimageMobile" value="${properties.shareimageMobile}" scope="request" />
<c:set var="paramtext" value="${properties.button}" scope="request" />
<!-- Panel starts here -->
<c:choose>
	<c:when test="${not empty properties.cssCompClass}"> 	
		<div class="${properties.cssCompClass}">
	</c:when>
</c:choose>
<section class="prod-two-column container-fluid">
    <div class="row">
        <div class="col-md-12 col-xs-12 col-eq-height-wrapper padding-zero">
            <c:if test="${properties.alignmentside eq 'right'}"> 
            <div class="col-md-7 col-xs-12 col-eq-height padding-zero">
                <img src="${properties.pbackgroundimage}" alt="${properties.pbackgroundimagealt}" class="imgSwap img-responsive" desk-img="${properties.pbackgroundimage}" mob-img="${properties.pbackgroundimageMobile}" width="100%">
            </div>
            
            <div class="col-md-5 col-xs-12 col-eq-height padding-zero" style="background:#${properties.backgroundcolor};">
                
                <div class="pull-right text-center prod-row-desc">
                    <h2 class="text-center">${properties.ptitle}</h2>
                    ${properties.pdesc}
                    <c:set var="newTab" value="${properties.newTab}"></c:set>                      
                        <c:set var="modal" value="${properties.typeOfButton}"></c:set>
                        <c:set var="noButton" value="${properties.typeOfButton}"></c:set>
                        <c:set var="button" value="${properties.typeOfButton}"></c:set>
                        <c:choose>
                            
                            <c:when test="${button eq 'button'}">
                                
                                <c:if test="${newTab eq 'yes'}">
                                    <a href="${properties.oneMoreButtonLink}" class="btn btn-info" role="button" target="_blank" >${properties.oneMoreButton}</a>
                                </c:if>
                                <c:if test="${newTab eq 'no'}">							
                                    <a href="${properties.oneMoreButtonLink}" class="btn btn-info" role="button" >${properties.oneMoreButton}</a>
                                </c:if>
                            </c:when>
                            
                            <c:when test="${modal eq 'modal'}">
                                <a class="btn btn-info" href="#myModal-download" data-toggle="modal" style="margin-top:20px">${properties.oneMoreButton}</a>  
                            </c:when>
                            
                        </c:choose>


                </div>  
            </div> 
            </c:if>
            <c:if test="${properties.alignmentside eq 'left'}"> 
                <div class="col-md-5 col-xs-12 col-eq-height padding-zero" style="background:#${properties.backgroundcolor};">
                
                <div class="pull-right text-center prod-row-desc">
                    <h2 class="text-center">${properties.ptitle}</h2>
                    ${properties.pdesc}
                    <c:set var="newTab" value="${properties.newTab}"></c:set>                      
                        <c:set var="modal" value="${properties.typeOfButton}"></c:set>
                        <c:set var="noButton" value="${properties.typeOfButton}"></c:set>
                        <c:set var="button" value="${properties.typeOfButton}"></c:set>
                        <c:choose>
                            
                            <c:when test="${button eq 'button'}">
                                
                                <c:if test="${newTab eq 'yes'}">
                                    <a href="${properties.oneMoreButtonLink}" class="btn btn-info twoColumn" role="button" target="_blank" >${properties.oneMoreButton}</a>
                                </c:if>
                                <c:if test="${newTab eq 'no'}">							
                                    <a href="${properties.oneMoreButtonLink}" class="btn btn-info twoColumn" role="button" >${properties.oneMoreButton}</a>
                                </c:if>
                            </c:when>

                            <c:when test="${modal eq 'modal'}">
                                <a class="btn btn-info twoColumn" href="#myModal-download" data-toggle="modal" style="margin-top:20px">${properties.oneMoreButton}</a>  
                            </c:when>
                            
                        </c:choose>


                </div>  
            </div> 

                <div class="col-md-7 col-xs-12 col-eq-height padding-zero">
                <img src="${properties.pbackgroundimage}" alt="${properties.pbackgroundimagealt}" class="imgSwap img-responsive" desk-img="${properties.pbackgroundimage}" mob-img="${properties.pbackgroundimageMobile}" width="100%">
            </div>
            </c:if>
            <c:set var="check" value="${properties.valueSelected}"></c:set>
            <c:if test="${check eq 'true'}">
                <cq:include path="./share" resourceType="adcworkshop/components/content/share" />
            </c:if>                   
        </div>
    </div>
</section>
<c:choose>
	<c:when test="${not empty properties.cssCompClass}"> 	
		</div>
	</c:when>
</c:choose>

<!-- end of panel section -->