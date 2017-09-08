<%--
* Copyright (c)  Vorwerk POC
* Program Name :  geolocationmessage.jsp
* Application  :  Abott.FreeStyleLibre.Brazil
* Purpose      :  See description
* Description  :  This is geo location message component which displays location based information.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
*  15-Jul-2016                  Cognizant Technology solutions                                 Initial Creation
*-----------                           ----------------                                      -------------------------

--%> 
<%@include file="/apps/adcworkshop/components/shared/global.jsp"%><%
%><%@page session="false" %><%
%>

<!--Disclaimer JSP -->
<div id="disclaimerModal" tabindex="-1" class="modal disclaimerDetails">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body"> 
                <div class="row disclaimer text-center">
                    <div class="col-md-12 text-center">
                        <a class="home-site-link"><img src="${properties.logoImageDesktopOther}" class="img-responsive auto-margin imgSwap" alt="FreeStyle Libre" desk-img="${properties.logoImageDesktopOther}" mob-img="${properties.logoImageMobileOther}"></a>

                        <div class="col-md-offset-1 col-md-10 col-sm-offset-1 col-sm-10 ">
                            ${properties.content}
                            <a class="home-site-link btn  btn-lg  btnAccept" role="button" style="background-color:#E4572D; color:white">${properties.firstbuttontext}</a><br/>
                            <a href="${properties.secondbuttonhyperlink}" class="btn  btn-lg btn-margin-right" role="button" target="_blank" >${properties.secondbuttontext}</a>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Block page content-->
<div id="blockpageModal" tabindex="-1" class="modal disclaimerDetails">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body"> 
                <div class="row disclaimer text-center">
                    <div class="col-md-12 text-center">

                         <img src="${properties.logoImageDesktopUs}" class="img-responsive auto-margin imgSwap" alt="FreeStyle Libre" desk-img="${properties.logoImageDesktopUs}" mob-img="${properties.logoImageMobileUs}">
                        <div class="col-md-offset-1 col-md-10 col-sm-offset-1 col-sm-10 ">

                            ${properties.blockMessage}

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Monocco Block page-->
<div id="monoccoBlockpageModal" tabindex="-1" class="modal disclaimerDetails">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body"> 
                <div class="row disclaimer text-center">
                    <div class="col-md-12 text-center">

                         <img src="${properties.logoImageDesktopUs}" class="img-responsive auto-margin imgSwap" alt="FreeStyle Libre" desk-img="${properties.logoImageDesktopUs}" mob-img="${properties.logoImageMobileUs}">
                        <div class="col-md-offset-1 col-md-10 col-sm-offset-1 col-sm-10 ">

                            ${properties.mcBlockMessage}

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
