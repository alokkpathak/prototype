<%--
* Copyright (c)  Vorwerk POC
* Program Name :  content.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Used for including the type of components that can be place like parsys,iparsys etc.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 11-Jul-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>
<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>

<c:if test="${empty properties.hideProduct}"> 
	<cq:include path="product_par_main" resourceType="adcworkshop/components/content/product" />
</c:if>
<c:if test="${empty properties.hideProductStickyHeaderComponent}"> 
	<cq:include path="product_overlay" resourceType="adcworkshop/components/content/product_StickyHeader" />
</c:if>
<cq:include path="productPage" resourceType="foundation/components/parsys"/>
