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
* 08-Jul-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>

	<c:choose>
		<c:when test="${ (not empty properties.templateType 
				&& properties.templateType eq 'checkoutTemplate') }">
				
			<cq:include path="viewCheckoutBasket" resourceType="adcworkshop/components/content/viewCheckoutBasket" />
			
        	<cq:include path="contentPage" resourceType="foundation/components/parsys"/>
        	
		</c:when>
		 <c:when test="${ (not empty properties.templateType && properties.templateType eq 'profilePageTemplate') }">
        <div class="container-fluid account-details">
            <section class="left-menu col-md-3">
                <cq:include path="leftrail" resourceType="foundation/components/iparsys"/>
            </section>
            <section class="col-md-9 rightAccountView">
                <div class="order-loading">
                    <p>${properties.orderhistoryanimationtext}</p>
				    <div class="line-pulse"><div></div><div></div><div></div><div></div></div>
                </div>
                <cq:include path="right" resourceType="foundation/components/parsys"/>
            </section>    
        </div> 
    <cq:include path="center" resourceType="foundation/components/parsys"/>    
    </c:when>
		<c:otherwise>
			<cq:include path="contentPage" resourceType="foundation/components/parsys"/>
		</c:otherwise>
	</c:choose>