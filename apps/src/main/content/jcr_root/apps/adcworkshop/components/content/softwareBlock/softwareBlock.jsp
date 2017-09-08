<%--
* Copyright (c)  Vorwerk POC
* Program Name :  softwareBlock.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Displays information corresponding to FSL Software and provide links for download of the software.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 26-Jul-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>


<%@include file="/apps/adcworkshop/components/shared/global.jsp" %>
<%@page session="false" %>
<section class="about text-center">
    <div class="container-fluid">
        <div class="col-md-offset-2 col-md-8 inside ">
          <h3 class="color-head">
              <strong>${properties.headline}</strong>
          </h3>
            <div style="color:#4f4f4f">${properties.description}</div>

        </div>
		<div class="col-md-12 col-xs-12">
            <a  class="btn btn-lg button-orange btn-padding" id="getSoftware" href="#myModal-download" data-toggle="modal" aria-label="${properties.opensmodal}" style="margin-top:20px">${properties.text1}</a>  

        </div> 


      </div>
</section>
<cq:include path="downloadOverlay" resourceType="/apps/adcworkshop/components/content/downloadnowOverlay"/>