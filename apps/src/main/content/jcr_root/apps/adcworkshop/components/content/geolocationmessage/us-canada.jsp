<%--
* Copyright (c)  Vorwerk POC
* Program Name :  us-canada.jsp
* Application  :  Abott.FreeStyleLibre.Brazil
* Purpose      :  See description
* Description  :  This will display the message to US or Canada users.
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

<div id="myModal" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="container-fluid model">
        <div class="col-md-offset-2 col-md-8 model">
            <div class="row disclaimer text-center">
                <div class="col-md-12 text-center">
                   
                     <img src="${properties.logoImageDesktopUs}" class="img-responsive auto-margin imgSwap" alt="FreeStyle Libre" desk-img="${properties.logoImageDesktopUs}" mob-img="${properties.logoImageMobileUs}">
                    <div class="col-md-offset-1 col-md-10 col-sm-offset-1 col-sm-10 ">

                        ${properties.message}

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
