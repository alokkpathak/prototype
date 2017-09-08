<%--
    * Copyright (c)  Vorwerk POC
    * Program Name :  image_text_bullet.jsp
        * Application  :  Vorwerk POC
            * Purpose      :  See description
                * Description  :  Displays text and image with the bullets.
                    * Modification History:
* ---------------------
    *    Date                                Modified by                                       Modification Description
    *-----------                            ----------------                                    -------------------------
    * 26-Jul-2016                  Cognizant Technology solutions            					Initial Creation
    *-----------                           -----------------                                    -------------------------
    --%> 
    
    <%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %> 
<c:set var="listroot" value="<%=properties.get("navpath",currentPage.getPath())%>"/>

<%
    String[] multiProp = {"lefttitlename", "leftimagename","leftimagealt","leftimagenameMobile"};
pageContext.setAttribute("multiFieldSet1", multiProp);
%>

<adc:multicompositefield var="leftradiobuttonList" fieldNodeName="leftmulti" fieldPropertyNames="${multiFieldSet1}" returnType="List" />

<c:set var="check" value="${properties.valueSelected1}"></c:set>

<c:choose>
    <c:when test="${check eq 'true'}">
        <section class="as-list container">
            <div class="row">
                <div class="col-md-12">
                    <div class="col-md-5">
                        <div class="visible-xs visible-sm choosing-mobile-desc text-center">
                            ${properties.richtext2} 
                        </div>
                        <img src="${properties.imagename1}"  class="imgSwap img-choosing-site hidden-xs img-responsive" alt="${properties.imagealt}" desk-img="${properties.imagename1}" mob-img="${properties.imagename1Mobile}"/>
                        <img src="${properties.imagename1}"  class="imgSwap visible-xs img-responsive" alt="${properties.imagealt}" desk-img="${properties.imagename1}" mob-img="${properties.imagename1Mobile}">
                    </div>
                    <div class="col-md-7">
                        ${properties.richtext1} 
                        <c:forEach items="${leftradiobuttonList}" var="list" varStatus="i">
                            <div class="media">
                                <div class="media-left">
                                    <img src=${list.leftimagename} class="imgSwap ellipse-as" alt="${list.leftimagealt}" desk-img="${list.leftimagename}" mob-img="${list.leftimagenameMobile}"/>
                                </div>  
                                <div class="media-body">
                                    <p>${list.lefttitlename} </p>
                                </div>
                            </div>
                        </c:forEach>
                        
                        <c:set var="newTab" value="${properties.newtabcheck}"></c:set>                      
                        <c:set var="modal" value="${properties.typeOfButton}"></c:set>
                        <c:set var="noButton" value="${properties.typeOfButton}"></c:set>
                        <c:set var="button" value="${properties.typeOfButton}"></c:set>
                        <c:choose>
                            
                            <c:when test="${button eq 'button'}">
                                
                                <c:if test="${newTab eq 'true'}">
                                    <a id="getSoftware" href="${properties.link}" class="btn btn-lg button-orange " role="button" target="_blank" style="background-color:#E4572D;">${properties.button}</a>
                                </c:if>
                                <c:if test="${newTab eq 'false'}">							
                                    <a id="getSoftware" href="${properties.link}" class="btn btn-lg button-orange " role="button" style="background-color:#E4572D;">${properties.button}</a>
                                </c:if>
                            </c:when>
                            
                            <c:when test="${modal eq 'modal'}">
                                <a id="getSoftware"  class="btn btn-lg button-orange btn-padding" href="#myModal-download" data-toggle="modal" style="margin-top:20px">${properties.button}</a>  
                            </c:when>
                            
                        </c:choose>
                    </div>
                </div>
            </div>
        </section>
    </c:when>
    
    
    <c:otherwise>
        <section class="as-list container-fluid">
            <div class="row">
                <div class="col-md-offset-2 col-md-8 text-left ">          
                    
                    ${properties.richtext1}
                    <c:forEach items="${leftradiobuttonList}" var="list" varStatus="i">
                        <div class="media medialist">
                            <div class="media-left listcude">
                                <img src=${list.leftimagename} class="imgSwap ellipse-as" alt="${list.leftimagealt}" desk-img="${list.leftimagename}" mob-img="${list.leftimagenameMobile}"/>
                            </div>  
                            <div class="media-body">
                                <p>${list.lefttitlename} </p>
                            </div>
                        </div>
                    </c:forEach>
                    
                    
                    <div id="medicalVistGetBtn " class="text-center">
                        
                        <c:set var="newTab" value="${properties.newtabcheck}"></c:set>                      
                        <c:set var="modal" value="${properties.typeOfButton}"></c:set>
                        <c:set var="noButton" value="${properties.typeOfButton}"></c:set>
                        <c:set var="button" value="${properties.typeOfButton}"></c:set>
                        <c:choose>
                            
                            <c:when test="${button eq 'button'}">
                                
                                <c:if test="${newTab eq 'true'}">
                                    <a id="getSoftware" href="${properties.link}" class="btn btn-lg button-orange " role="button" target="_blank" style="background-color:#E4572D;">${properties.button}</a>
                                </c:if>
                                <c:if test="${newTab eq 'false'}">							
                                    <a id="getSoftware" href="${properties.link}" class="btn btn-lg button-orange " role="button" style="background-color:#E4572D;">${properties.button}</a>
                                </c:if>
                            </c:when>
                            
                            <c:when test="${modal eq 'modal'}">
                                <a id="getSoftware"  class="btn btn-lg button-orange btn-padding" href="#myModal-download" data-toggle="modal">${properties.button}</a>  
                            </c:when>
                            
                        </c:choose>
                    </div> 
                    
                </div>
            </div>
        </section>
    </c:otherwise>
</c:choose>