<%--
* Copyright (c)  Vorwerk POC
* Program Name : informationPopup.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  : This component is for the infomration button icon overlay.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 1-Oct-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<div id="infoModal" class="modal fade" tabindex="-1">
    <div class="modal-dialog">
        
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" aria-label="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">${properties.infoheader}</h4>
            </div>
            <div class="modal-body" style="height:100px;overflow-y: auto;">
                ${properties.infotext}
            </div>            
        </div>

    </div>
</div>  