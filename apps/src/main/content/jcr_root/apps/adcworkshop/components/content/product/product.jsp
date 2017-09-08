<%--
* Copyright (c)  Vorwerk POC
* Program Name :  productHeaderImage.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Displaying product header with image.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 19-Jul-2016                  Cognizant Technology solutions                                                                                    Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="prodetail-buy">
      <c:set var="paramimage" value="${properties.shareimagepath}" scope="request" />
  	 <c:set var="paramimageMobile" value="${properties.shareimageMobile}" scope="request" />
    <c:set var="paramtext" value="${properties.sharebuttonname}" scope="request" />
      <section class="container-fluid c19 padding-zero">

    <cq:include path="./share" resourceType="adcworkshop/components/content/share" />
  </section>
 <div>





  <%
  String[] selectImages = {"imagePathDesktop","imagePathMobile","imagealttxt"};
  pageContext.setAttribute("selectImages", selectImages);
  %>

  <adc:multicompositefield var="infoLinkList1" fieldNodeName="selectProductImages" fieldPropertyNames="${selectImages}" returnType="List" />

  <adc:restServiceUrl  var="addToCartUrl" key="addtoCart"/>

  <adc:restServiceUrl  var="var" key="productPrice" skuid="${properties.skuId}"/>


  <section class="container-fluid padding-zero">

    <input type="hidden" name="productUrl" id="product-url" value="${var}">
    <input type="hidden" name="skuID" id="product-skuID" value="${properties.skuId}">
    <input type="hidden" name="prodTitle" id="product-title" value="${properties.startertitle}">  
    <input type="hidden" name="prodmessage" id="prodmessagelable1" value="${properties.prodmaxmessage1}">
    <input type="hidden" name="prodmessage" id="prodmessagelable2" value="${properties.prodmaxmessage2}">           
    <input type="hidden" name="prodPrice" id="product-price" value="0.0">
     <input type="hidden" name="prodPriceNum" id="product-priceNum" value="0">
      <input type="hidden" name="prodPriceDec" id="product-priceDec" value="0">
    <input type="hidden" name="prod-count" id="prod-count" value = "1"/>
    <input type="hidden" name="totalPrice" id="totalPrice" value="">
    <input type="hidden" name="totalCurrency" id="totalCurrency" value = ""/>
    <input type="hidden" name="add" id="addCartItemUrl" value="${addToCartUrl}">
	<input type="hidden" name="displayPriceQty" id="displayPriceQty" value="${properties.displayPriceQuantity}">
    <input type="hidden" name="bundle_option" id="bundle_option" value="">
    <input type="hidden" name="maxerrormessage" id="maxErrorMessage" value="${properties.maxerrormessage}">
    <input type="hidden" name="maxallowed" id="maxAllowed">
    <input type="hidden" name="productnotavailablemessage" id="productnotavailablemessage" value="${properties.productnotavailablemessage}">
	<c:set var="newTab" value="${properties.newtabcheck}"></c:set>
    <c:choose>
    <c:when test="${empty properties.isBundleProduct}">
    <input type="hidden" name="isBundleProduct" id="isBundleProduct" value="false">
  </c:when>
  <c:otherwise>
  <input type="hidden" name="isBundleProduct" id="isBundleProduct" value="true">
</c:otherwise>
</c:choose>


<div class="row starterpack-modal padding-zero" id="product-view" >

  <div class="col-md-8 col-md-offset-3 col-sm-offset-2 prod-container">     
	<div class="col-xs-8 col-xs-offset-2">
      <h1 class="sp-row1-h2 text-center visible-xs"><strong>${properties.startertitle}</strong></h1>
       </div>       
    <div class="col-md-4 col-sm-4 text-center">
      <!-- Product Iamge -->    

      <div mag-thumb="outer" class="product-thumbnail">
        <img src="" alt="${properties.productimagealt}" id="prod_tn_image"/>
      </div>
    </div>
    <!--Drop down content for desktop -->   
    <div class="col-md-8 col-sm-8">
      <div>
      <h1 class="sp-row1-h2 text-left hidden-xs"><strong>${properties.startertitle}</strong></h1>
       </div>    
      <input type="hidden" name="productUrl" id="product-url" value="${var}">
      <div class="spinner-wrapper hidden-xs">   
		<c:choose>
		<c:when test="${properties.displayPriceQuantity eq 'yes'}">
        <div class="product-amount col-md-12 padding-zero">  
         <div class="col-md-2 col-sm-3 padding-zero">
             <label for="prod-spinner" class="hidden">To Increase or Decrease product quantity </label>
           <input min="1" max="1" step="1" value="1" id="prod-spinner" class="prodSpinner prod-spinner" />
         </div>
         <div class="col-md-9 col-sm-9 price-wrapper">
          <div class="product-loading">
              <p>${properties.productLoadingMessage}</p>
              <div class="line-pulse"><div></div><div></div><div></div><div></div></div>
          </div>
          <label class="pr-price-int"><div id="prodNum" class="prodNum"></div></label>
          <label class="pr-price-decimal"><div id="prodDec" class="prodDec"></div></label>  
		  <span class="vat">${properties.vatlabel}</span>             
        </div> 
      </div>
	  
      <div class="buynow-loading">
          <p>${properties.productLoadingMessage}</p>
          <div class="line-pulse"><div></div><div></div><div></div><div></div></div>
      </div>
      <a href="#" data-toggle="modal" id="addbasket" class="addbasket btn btn-lg button-orange" 
      role="button" title="opens a pop-up" >${properties.starterbutton}</a> 
      <div id="prod-spinnerError" class="prod-spinnerError error_show col-md-7 col-sm-10" ></div>
      <div id="prodmessage" class="prodmessage col-md-7 col-sm-7 padding-zero" ></div>
	  </c:when>
	  <c:otherwise>
          <c:set var="priceContent" value="${properties.productpricecontent}"/>
          <c:if test="${not empty priceContent}"> 
          <div class="product-amount col-md-9 col-sm-9 price-wrapper" >
              <label class="pr-price-int"><div class="prodNum">${properties.productpricecontent}</div></label>
              <span class="vat" style="display:BLOCK;">${properties.productpricetext}</span> 
			<div id="prodmessage" class="col-md-7 col-sm-7 padding-zero" style="margin-left: 30px;">${properties.productpricesubtext}</div>			  
          </div>
          </c:if>
			<a id="productTargetLink" data-toggle="modal" href="#myModal-thirdParty" class="btn btn-lg button-orange productTargetLink" 
			role="button" title="opens a new link" >${properties.starterbutton}</a> 
	  </c:otherwise>
	  </c:choose>	
    </div>
    <!--End of Drop down content for desktop -->    
    <!-- Zoom panel for Product View-->       
    <div class="img-zoom-wrapper hidden-xs">
      <div mag-zoom="outer" id="prod_tn_image">
        <img src="" alt="${properties.zoomimagealt}"/>
      </div>          
    </div>
  </div>
</div>
<!-- Image gallery -->
<div class="col-md-8 col-md-offset-3 col-sm-offset-2 lstProductImage">
  <div class="prod-arr-left-mob hidden-md hidden-lg hidden-sm pull-left" >
    <img src="/content/dam/adc/fsl/images/global/en/mobileImages/arrow_left_mobile.png" alt="${properties.arrowleftimagealt}" />
  </div>
  <ul class="list-inline">

    <c:forEach items="${infoLinkList1}"  varStatus="status" var ="list2">
    <c:choose>
    <c:when test="${status.count <= 4}" >
    <li class="col-xs-1 col-sm-1 col-md-1"><img src="${list2.imagePathDesktop}" class="img-responsive img-gallery imgSwap " alt="${list2.imagealttxt}" desk-img="${list2.imagePathDesktop}" mob-img="${list2.imagePathMobile}"/></li>
  </c:when>
  <c:otherwise>

  <li class="col-xs-1 col-sm-1 col-md-1 hidden-xs"><img src="${list2.imagePathDesktop}" class="img-responsive img-gallery imgSwap " alt="${list2.imagealttxt}" desk-img="${list2.imagePathDesktop}" mob-img="${list2.imagePathMobile}"/></li>
</c:otherwise>
</c:choose> 
</c:forEach>

</ul>
<div class="prod-arr-right-mob hidden-md hidden-lg hidden-sm" >
    <c:if test="${fn:length(infoLinkList1) >4}" >
  <img src="/content/dam/adc/fsl/images/global/en/mobileImages/arrow_right_mobile.png" alt="${properties.arrowrightimagealt}" />
        </c:if>
</div>
</div>
<!-- end of Image gallery-->
<!--Drop down content for mobile -->
<div class="col-xs-12 visible-xs">
  <div class="spinner-wrapper-mob col-xs-12 padding-zero">
	<c:choose>
	<c:when test="${properties.displayPriceQuantity eq 'yes'}">
    <div class="product-loading">
        <p>${properties.productLoadingMessage}</p>
        <div class="line-pulse"><div></div><div></div><div></div><div></div></div>
    </div>
	
    <div class="product-amount">                
      <div class="col-xs-4 padding-zero">
        <label for="prod-spinner" class="hidden">To Increase or Decrease product quantity </label>
          <div id="qty-place" class="text-center"></div>

      </div>
      <div class="col-xs-8 padding-zero price-wrapper">
        <label class="pr-price-int"><div id="prodNum" class="prodNum"></div></label>
        <label class="pr-price-decimal"><div id="prodDec" class="prodDec"></div></label>  
        <span class="vat">${properties.vatlabel}</span>
      </div> 
    </div>
	
    <div class="buynow-loading">
          <p>${properties.productLoadingMessage}</p>
          <div class="line-pulse"><div></div><div></div><div></div><div></div></div>
    </div>
	<div class="col-xs-12 text-center padding-zero">
		<a href="#" data-toggle="modal" id="addbasket" title="buynow button" class="addbasket addbasketMobile btn btn-lg button-orange" 
		role="button" title="opens a pop-up" >${properties.starterbutton}</a> 
	</div>
    <div id="prod-spinner-mobileError" class="prod-spinnerError errorHide error_show col-md-7 col-sm-10 col-xs-12" ></div> 
    <div id="prodmessage" class="prodmessage col-md-7 col-sm-7 col-xs-12 padding-zero" ></div>          
		</c:when>
		<c:otherwise>
              <c:set var="priceContent" value="${properties.productpricecontent}"/> 
              <c:if test="${not empty priceContent}"> 
         	 <div class="product-amount col-md-9 col-sm-9 price-wrapper" >
              <label class="pr-price-int"><div class="prodNum">${properties.productpricecontent}</div></label>
              <span class="vat" style="display:block;">${properties.productpricetext}</span> 
			<div id="prodmessage" class="col-md-7 col-sm-7 padding-zero" style="padding-top: 15px; padding-left: 31px">${properties.productpricesubtext}</div>			  
          </div>
          </c:if>  
			<div class="col-xs-12 text-center padding-zero">
				<a id="productTargetLink" data-toggle="modal" href="#myModal-thirdParty" class="btn btn-lg button-orange productTargetLink" 
				role="button" title="opens a new link" >${properties.starterbutton}</a> 
			</div>
		</c:otherwise>
	</c:choose>	
  </div>
</div>
<!--End of Drop down content for mobile -->
<!-- Product menu -->
<div class="col-md-12 col-xs-12 prodMenu">        
  <ul class="list-inline font-uppercase">
    <c:set var="linkarr" value="${properties.starterpacklinks}"/> 
    <c:forEach items="${linkarr}" varStatus="linkstatus">
    <c:if test="${linkstatus.count eq 1}">
    <li class="col-xs-3 col-md-3"><a data-toggle="collapse" class="prodMenulinks"  href="#product_${linkstatus.count}"   aria-controls="${linkarr[linkstatus.index]}">${linkarr[linkstatus.index]}</a></li>
  </c:if>
  <c:if test="${linkstatus.count gt 1}">
  <li class="col-xs-3 col-md-3"><a data-toggle="collapse" class="prodMenulinks" href="#product_${linkstatus.count}" aria-expanded="false" aria-controls="${linkarr[linkstatus.index]}">${linkarr[linkstatus.index]}</a></li>
</c:if>
</c:forEach>                               
</ul> 



</div>
<!-- End of Product menu -->
    
</div>

</section>

<cq:include path="./productOverlay" resourceType="adcworkshop/components/content/productAddOverlay" />

<div id="enlargemodal" class="modal fade" tabindex="-1" aria-labelledby="enlargemodal" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
     <div class = "modal-header">
      <button type = "button" class = "close" aria-label="close" data-dismiss = "modal" aria-hidden = "true">
		&times;
      </button>      
    </div>
    <div class = "modal-body text-center">
     <img src="" class="img-responsive" alt="${properties.modalimagealt}"/>
   </div>
 </div>    
</div>
</div>

<div class="collapsable-wrapper" tabindex="0">
	<section class="row collapsable content">

	  <div class="bg-white" id="prodMenuContent">
		<div class="">
		  <c:forEach begin="1" end="4" varStatus="loopCount">
		  <cq:include path="dropdown_content_${loopCount.count}" resourceType="/apps/adcworkshop/components/content/drop_down_content"/>
		</c:forEach>
	  </div>
	</div>

	</section>
</div>


<div class="about text-center container-fluid">

  <div class="row sp-product-yellow">
    <div class="col-md-offset-2 col-md-8">
      ${properties.ptitle}
      ${properties.pdesc}
    </div>        
  </div>

</div>

</div>


</div>
<script id="quantityMobile-template" type="text/x-handlebars-template">
    <select class="qtySelect" id="qtySelect">
        {{#each allowed_qty_limit}}
            <option value="{{{this}}}">{{this}}</option>
        {{/each}}
	</select>
</script>