<%--
* Copyright (c)  Vorwerk POC
* Program Name :  about_us.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  This component will be used to edit and updating our details in the about us page.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 26-Jul-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>



<section class="container-fluid aboutus-text">
	<div class="col-md-offset-2 col-md-8">
			<h1>${properties.ptitle} </h1>
        <img src=${properties.img} class="img-responsive" alt="${properties.imagealt}">
			${properties.richtext2} 
	</div>
</section>