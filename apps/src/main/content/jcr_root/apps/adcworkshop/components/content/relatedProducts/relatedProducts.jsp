<%--
* Copyright (c)  Vorwerk POC
* Program Name :  relatedProducts.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Displays related products information on a product page.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 28-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>
<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>

<section class="container-fluid bg-white">
  <div class="col-md-12 related-products">
      <h2 class="text-center">${properties.headline}</h2>
    <div class="col-md-offset-2 col-md-8 col-md-offset-2">          
      <div class="col-md-6 text-center">
          <h3>${properties.title1}</h3>
          <img src="${properties.fileReference1}" class="imgSwap img-responsive center-block" alt="${properties.imagealt1}" desk-img="${properties.fileReference1}" mob-img="${properties.fileReference1Mobile}">
          <a id="prodRelOne" href="${properties.urlLink1}" class="btn btn-lg button-orange" role="button"  style="background-color:#E4572D;">
			${properties.urlLabel1}
			<input type="hidden" id="prodOneRel" value="${properties.title1}">
		  </a>
      </div>
      <div class="col-md-6 text-center">
          <h3>${properties.title2}</h3>
          <img src="${properties.fileReference2}" class="imgSwap img-responsive center-block" alt="${properties.imagealt2}" desk-img="${properties.fileReference2}" mob-img="${properties.fileReference2Mobile}">
          <a id="prodRelTwo" href="${properties.urlLink2}" class="btn btn-lg button-orange" role="button"  style="background-color:#E4572D;">
			${properties.urlLabel2}
			<input type="hidden" id="prodTwoRel" value="${properties.title2}">
		  </a> 
		  
      </div>
    </div>
  </div>
</section>