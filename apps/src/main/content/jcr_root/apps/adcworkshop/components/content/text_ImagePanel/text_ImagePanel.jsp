<%--
* Copyright (c)  Vorwerk POC
* Program Name :  text_ImagePanel.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  For displaying text and image.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 16-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>
<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>

<section class="prod-two-column container-fluid">
    <div class="row">
        <div class="col-md-12 col-eq-height-wrapper padding-zero">
            <div class="col-md-7 col-xs-12 col-eq-height padding-zero">
                <img src="${properties.pbackgroundimage}" alt="${properties.pbackgroundimagealt}" desk-img="${properties.pbackgroundimage}" mob-img="${properties.pbackgroundimageMobile}" class="imgSwap img-responsive" width="100%">
            </div>
            <div class="col-md-5 col-xs-12 col-eq-height padding-zero" style="background:#${properties.backgroundcolor};">
                <c:set var="check" value="${properties.valueSelected}"></c:set>
                <c:if test="${check eq 'true'}">
                    <a href="#" id="btnProductShare" class="btn btn-lg button-orange" role="button" style="background-color:#E4572D;">
					<img src="${properties.shareicon}"  class="imgSwap" desk-img="${properties.shareicon}" mob-img="${properties.shareiconmobile}"alt="${properties.imagealt}">${properties.button}</a>
                </c:if>
                <div class="pull-right text-center prod-row-desc">
                   <h3>${properties.ptitle}</h3>
                    ${properties.pdesc}
                </div>  
            </div>        
        </div>
    </div>
</section>