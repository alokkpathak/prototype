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
* 19-Jul-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>

<c:set var="paramimage" value="${properties.shareimagepath}" scope="request" />
<c:set var="paramimageMobile" value="${properties.shareimageMobile}" scope="request" />
<c:set var="paramtext" value="${properties.sharebuttonname}" scope="request" />
<section class="container-fluid c19 padding-zero">
    <img src="${properties.productimagename}" class="imgSwap img-responsive mob-img1" width="100%" alt="${properties.prodimagealt}" desk-img="${properties.productimagename}" mob-img="${properties.productimagenameMobile}" />
      
     <cq:include path="./share" resourceType="adcworkshop/components/content/share" />
</section>