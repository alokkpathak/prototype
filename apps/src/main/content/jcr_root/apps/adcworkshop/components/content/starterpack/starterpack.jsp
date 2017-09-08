<%--
* Copyright (c)  Vorwerk POC
* Program Name :  starterpack.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  For displaying product details.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 14-Jul-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>


<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%
    String[] selectImages = {"imagePathDesktop","imagePathMobile"};
pageContext.setAttribute("selectImages", selectImages);
%>

<adc:multicompositefield var="infoLinkList1" fieldNodeName="selectProductImages" fieldPropertyNames="${selectImages}" returnType="List" />

<adc:restServiceUrl  var="addToCartUrl" key="addtoCart"/>

<adc:restServiceUrl  var="var" key="productPrice" skuid="${properties.skuId}"/>


<section class="container-fluid">

	<input type="hidden" name="productUrl" id="product-url" value="${var}">
    <input type="hidden" name="skuID" id="product-skuID" value="${properties.skuId}">
    <input type="hidden" name="prodTitle" id="product-title" value="${properties.startertitle}">            
    <input type="hidden" name="prodPrice" id="product-price" value="0.0">
    <input type="hidden" name="prod-count" id="prod-count" value = "1"/>
    <input type="hidden" name="totalPrice" id="totalPrice" value="">
    <input type="hidden" name="totalCurrency" id="totalCurrency" value = ""/>
    <input type="hidden" name="add" id="addCartItemUrl" value="${addToCartUrl}">

    <input type="hidden" name="bundle_option" id="bundle_option" value="">
<input type="hidden" name="maxerrormessage" id="maxErrorMessage" value="${properties.maxerrormessage}">
    <input type="hidden" name="maxallowed" id="maxAllowed">
<input type="hidden" name="productnotavailablemessage" id="productnotavailablemessage" value="${properties.productnotavailablemessage}">
    <c:choose>
	    <c:when test="${empty properties.isBundleProduct}">
	        <input type="hidden" name="isBundleProduct" id="isBundleProduct" value="false">
	    </c:when>
	    <c:otherwise>
	       <input type="hidden" name="isBundleProduct" id="isBundleProduct" value="true">
	    </c:otherwise>
	</c:choose>


    <div class="row starterpack-modal" id="product-view" style="background-color:white;">
      <div class="col-md-12">           
        <h2 class="sp-row1-h2 text-center"><strong>${properties.startertitle}</strong></h2>
        <div class="col-md-4 col-md-offset-2 col-sm-4 col-sm-offset-2 text-center">
        <!-- Product Iamge -->                    
          <div mag-thumb="outer" class="product-thumbnail">
              <img src="" alt="${properties.productimagealt}" id="prod_tn_image"/>
          </div>
        </div>
        <!--Drop down content for desktop -->   
        <div class="col-md-6 col-sm-6">   
            <input type="hidden" name="productUrl" id="product-url" value="${var}">
          <div class="spinner-wrapper hidden-xs col-md-10 col-sm-10">   
            <div class="product-amount col-md-12 padding-zero">                
             
                <div class="col-md-4 col-sm-4 padding-zero">

                   <input min="1" max="1" step="1" value="1" id="prod-spinner" class="prodSpinner prod-spinner" />
              </div>
                <div class="col-md-8 col-sm-8 padding-zero">
                <label class="pr-price-int"><div id="prodNum" class="prodNum"></div></label>
              <label class="pr-price-decimal"><div id="prodDec" class="prodDec"></div></label>               
            </div> 
              </div>
            <a href="#" data-toggle="modal" id="addbasket" class="addbasket btn btn-lg button-orange" 
            		role="button" title="opens a pop-up" style="background-color:#E4572D;">${properties.starterbutton}</a> 
              <div id="prod-spinnerError" class="prod-spinnerError error_show" ></div>
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
      <div class="col-lg-11 col-lg-offset-1 col-xs-12 col-md-12 lstProductImage">
        <div class="prod-arr-left-mob hidden-md hidden-lg hidden-sm pull-left" >
            <img src="/content/dam/adc/fsl/images/global/en/arrow_left_mobile.png" alt="${properties.arrowleftimagealt}" />
        </div>
        <ul class="list-inline">

			<c:forEach items="${infoLinkList1}"  varStatus="status" var ="list2">
                    <c:choose>
                        <c:when test="${status.count <= 4}" >
                            <li class="col-xs-3 col-sm-2 col-md-2"><img src="${list2.imagePathDesktop}" class="img-responsive img-gallery imgSwap " alt="${properties.multiimagealt}" desk-img="${list2.imagePathDesktop}" mob-img="${list2.imagePathMobile}"/></li>
                        </c:when>
                        <c:otherwise>

                            <li class="col-xs-3 col-sm-2 col-md-2 hidden-xs"><img src="${list2.imagePathDesktop}" class="img-responsive img-gallery imgSwap " alt="${properties.multiimagealt}" desk-img="${list2.imagePathDesktop}" mob-img="${list2.imagePathMobile}"/></li>
                        </c:otherwise>
                    </c:choose> 
			 </c:forEach>

        </ul>
        <div class="prod-arr-right-mob hidden-md hidden-lg hidden-sm" >
            <img src="/content/dam/adc/fsl/images/global/en/arrow_right_mobile.png" alt="${properties.arrowrightimagealt}" />
        </div>
      </div>
      <!-- end of Image gallery-->
      <!--Drop down content for mobile -->
      <div class="col-xs-12 visible-xs text-center">
        <div class="spinner-wrapper-mob">   
            <div class="product-amount">                
             
                <div class="col-xs-4 padding-zero">
                  <input id="prod-spinner" min="1" max="1" value="1" name="prod-spinner" class="prodSpinner prod-spinner">
                </div>
                <div class="col-xs-8">
              <label class="pr-price-int"><div id="prodNum" class="prodNum"></div></label>
              <label class="pr-price-decimal"><div id="prodDec" class="prodDec"></div></label>               
            </div> 
            </div>
			<div class="col-xs-12 text-center">
				<a href="#" data-toggle="modal" id="addbasket" class="addbasket btn btn-lg button-orange" 
            		role="button" title="opens a pop-up"  style="background-color:#E4572D;">${properties.starterbutton}</a> 
			</div>
			<div id="prod-spinner-mobileError" class="prod-spinnerError error_show" ></div>            
        </div>
      </div>
      <!--End of Drop down content for mobile -->
      <!-- Product menu -->
      <div class="col-md-12 col-xs-12 prodMenu">        
        <ul class="list-inline font-uppercase">
		    <c:set var="linkarr" value="${properties.starterpacklinks}"/> 
                <c:forEach items="${linkarr}" varStatus="linkstatus">
           <c:if test="${linkstatus.count eq 1}">
           <li class="col-xs-3 col-md-3"><a data-toggle="collapse"  href="#product_${linkstatus.count}"   aria-controls="${linkarr[linkstatus.index]}">${linkarr[linkstatus.index]}</a></li>
                    </c:if>
			<c:if test="${linkstatus.count gt 1}">
                     <li class="col-xs-3  col-md-3"><a data-toggle="collapse" href="#product_${linkstatus.count}" aria-expanded="false" aria-controls="${linkarr[linkstatus.index]}">${linkarr[linkstatus.index]}</a></li>
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

            </button>      
         </div>
         <div class = "modal-body text-center">
             <img src="" class="img-responsive" alt="${properties.modalimagealt}"/>
         </div>
      </div>    
   </div>
</div>


<section class="collapsable content container-fluid">

 <div class="row bg-white" id="prodMenuContent">
    <div class="col-md-12">
    <c:forEach begin="1" end="4" varStatus="loopCount">
        <cq:include path="dropdown_content_${loopCount.count}" resourceType="/apps/adcworkshop/components/content/drop_down_content"/>
    </c:forEach>
     </div>
    </div>

</section>


