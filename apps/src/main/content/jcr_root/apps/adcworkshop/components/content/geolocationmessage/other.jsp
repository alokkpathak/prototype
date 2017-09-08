<%--
* Copyright (c)  Vorwerk POC
* Program Name :  other.jsp
* Application  :  Abott.FreeStyleLibre.Brazil
* Purpose      :  See description
* Description  :  This will display the message to users other than US and Canada users.
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
                    <a href="${properties.logoLink}"><img src="${properties.logoImageDesktopOther}" class="home-site-link img-responsive auto-margin imgSwap" alt="FreeStyle Libre" desk-img="${properties.logoImageDesktopOther}" mob-img="${properties.logoImageMobileOther}"></a>
                    
                    <div class="col-md-offset-1 col-md-10 col-sm-offset-1 col-sm-10 ">
                        ${properties.content}
                        <a href="${properties.firstbuttonhyperlink}"  class="home-site-link btn  btn-lg  btnAccept" role="button" style="background-color:#E4572D; color:white">${properties.firstbuttontext}</a><br/>
                        <a href="${properties.secondbuttonhyperlink}" class="btn  btn-lg btn-margin-right" role="button" target="_blank" >${properties.secondbuttontext}</a>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $('.home-site-link').on('click',function(){
        var cname ="isFirstVisit";
        var cvalue="No";

        var d = new Date();
        d.setTime(d.getTime() + (1*24*60*60*1000));
        var expires = "expires=" + d.toGMTString();
        document.cookie = cname + "=" + cvalue+";"+expires+";path=/";

    });
</script>


