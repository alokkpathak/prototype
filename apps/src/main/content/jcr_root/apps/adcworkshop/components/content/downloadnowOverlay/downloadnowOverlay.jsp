<%--
* Copyright (c)  Vorwerk POC
* Program Name : downloadnowOverlay.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  : This overlay is for the download button in getting started page.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 23-Sep-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<section class="testimonial">
    <div id="myModal-download" class="modal fade" tabindex="-1">
        <form>
            <div class="modal-dialog ">
                <div class="modal-content">
                    <div class="modal-header padding-zero">
                        <button type="button" class="close" data-dismiss="modal" aria-label="close">&times;</button>                        
                    </div>                    
                    <div class="modal-body text-center">
                        ${properties.richtextcontent}                   
						 <a href="${properties.downloadforpclink}" id="pcbutton" class="btn btn-lg button-orange btn-padding graph" role="button" style="background-color:#E4572D;">${properties.downloadforpc}</a>
                        <a href="${properties.downloadformaclink}" id="macbutton" class="btn btn-lg button-orange graph" role="button" style="background-color:#E4572D;">${properties.downloadformac}</a>
                   	</div>
                    <div class="modal-footer ">
                        
                        
                    </div>
                </div>
            </div>
        </form>
    </div>
    
</section>