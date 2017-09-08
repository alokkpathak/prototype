<%--
* Copyright (c)  Vorwerk POC
* Program Name :  textimage.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  For adding a Text,Image and Button.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 16-Aug-2016                  Cognizant Technology solutions                                                                                 Initial Creation
*-----------                           -----------------                                    -------------------------
--%>
<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false"%>



<c:if test="${properties.alignmentside eq 'right'}"> 
	<div class="container-fluid">
    <div class="row">
    <section class="clearfix media-text">
    

        <div class="col-md-5  text-center hidden-xs hidden-sm media-image-left">
                <img src="${properties.imagename}" class="imgSwap btn-margin img-responsive" alt="${properties.productimagealt}" desk-img="${properties.imagename}" mob-img="${properties.imagenameMobile}"/>
            </div>
            <div class="col-md-7 col-xs-12 text-left mob-gstext media-text-right">
                       ${properties.textanddesc}
                <c:if test = "${fn:length(properties.buttonname) != 0}">
        <a href="${properties.buttonlink}" class="btn btn-info btn-lg button-orange btn-margin hidden-xs hidden-sm" role="button"  style="background-color:#${properties.buttoncolor};">${properties.buttonname}</a>
                </c:if>
      </div>
      <div class="col-md-5  text-center visible-xs visible-sm">
              <img src="${properties.imagename}" alt="${properties.productimagealt}" desk-img="${properties.imagename}" mob-img="${properties.imagenameMobile}" class="imgSwap img-responsive" />
              <div class="text-center ">
                  <c:if test = "${fn:length(properties.buttonname) != 0}">
              <a href="${properties.buttonlink}" class="btn btn-info btn-lg button-orange btn-margin " role="button"  style="background-color:#${properties.buttoncolor};">${properties.buttonname}</a>
</c:if>
            </div>
            </div>
        
  </section>
   </div> 
   </div>

</c:if>


<c:if test="${properties.alignmentside eq 'left'}"> 
	<div class="container-fluid">
    	<div class="row">
    	<section class="clearfix media-text">

            <div class="col-md-7 text-right mob-gstext media-text-left">
               ${properties.textanddesc}
                <c:if test = "${fn:length(properties.buttonname) != 0}">
              <a href="${properties.buttonlink}" class="btn btn-info btn-lg button-orange btn-margin hidden-xs hidden-sm" role="button"  style="background-color:#${properties.buttoncolor};">${properties.buttonname}</a>
                </c:if>
         </div>
      <div class="col-md-5 text-center media-image-right">
              <img src="${properties.imagename}" class="imgSwap mob-img img-responsive" alt="${properties.productimagealt}" desk-img="${properties.imagename}" mob-img="${properties.imagenameMobile}" />
     </div>
     <div class="visible-xs visible-sm text-center ">
         <c:if test = "${fn:length(properties.buttonname) != 0}">
            <a href="${properties.buttonlink}" class="btn btn-info btn-lg button-orange btn-margin" role="button"  style="background-color:#${properties.buttoncolor};">${properties.buttonname}</a>
         </c:if>
      </div>
       
  </section>
    </div> 
    </div>

</c:if>
