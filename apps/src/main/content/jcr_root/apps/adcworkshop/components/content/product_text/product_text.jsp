<%--
* Copyright (c)  Vorwerk POC
* Program Name :  product_text.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Displays product text.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 08-Jul-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>  
    
<%@include file="/apps/adcworkshop/components/shared/global.jsp" %>
<%@page session="false" %>

<div class="about text-center container-fluid" style="background:#${properties.backgroundcolor};">

  <div class="row sp-product-yellow">
	<div class="col-md-12">
	  <h2><strong>${properties.ptitle}</strong></h2>
	  <p>${properties.pdesc}</p>
	</div>        
  </div>

</div>

