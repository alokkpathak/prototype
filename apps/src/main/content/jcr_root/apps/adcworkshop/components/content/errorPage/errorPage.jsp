<%--
* Copyright (c)  Vorwerk POC
* Program Name :  errorPage.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Display error messages.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 26-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>
<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>

<section class="abouterror" style="background-color:#F4F2F4;"> 
		<div class="container-fluid">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 about-heading text-center">
                <img src="${properties.errorimg}" alt="${properties.imagealt}">     
                ${properties.errormsg}                 
			</div>
		</div>
	</section>
<section class="abouterrorcontent"> 
		<div class="container-fluid">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 about-heading text-center errorPageText" >
				<p class="text-center">
                    ${properties.errortxt}<a class="text-orange" onclick="history.go(-1);" >${properties.errortxt1} </a>${properties.errortxt2} <a href="${properties.homepath}" class="text-orange">${properties.errortxt3}</a></p>                  
			</div>         

		</div>
	</section>

<script type="text/javascript">
	var errorCode='<%=response.getStatus()%>';
	if(errorCode==404){
		app.analytics.pushError(errorCode,'page not found' ,location.href, document.referrer);
	}	
</script>