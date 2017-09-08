<%--
* Copyright (c)  Vorwerk POC
* Program Name :  product_text_Image_nobgc.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  For displaying product text,image without background.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 20-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp" %>
<%@page session="false" %>

<c:choose>
	<c:when test="${not empty properties.cssCompClass}"> 	
		<div class="${properties.cssCompClass}">
	</c:when>
</c:choose>
 <div class="painless container-fluid padding-zero" style="background-color: #${properties.backgroundColor};" >
      <div class="col-md-12 padding-zero">
            <img src=${properties.pbackgroundimage} alt="${properties.backgroundimagealt}" class="imgSwap img-responsive mob-img1" desk-img="${properties.pbackgroundimage}" mob-img="${properties.pbackgroundimageMobile}" >
          <div class="banner-painless text-center" >
              <h3>${properties.ptitle}</h3>
              ${properties.pdesc}
           </div>            
      </div>            
  </div>
<c:choose>
	<c:when test="${not empty properties.cssCompClass}"> 	
		</div>
	</c:when>
</c:choose>
  