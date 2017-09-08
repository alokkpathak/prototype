<%--
* Copyright (c)  Vorwerk POC
* Program Name :  cookie_alert_notice.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Describes cookie alert for the page.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 01-Sep-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>

<div id="cookie_directive_container" class="container hidden">
  <nav class="navbar navbar-default navbar-fixed-bottom" style="background-color:#FFC11B">
    <div class="container-fluid">
      <div class="navbar-inner navbar-content-center col-md-12" id="cookie_accept">
        <div class="col-sm-1 col-md-1 pull-right hidden-xs">
            <a class="btn btn-default pull-right cookie-btn">${properties.text4}</a>
        </div>    
       <p class="text-muted col-sm-11 col-md-11">
            <a href="${properties.pathfield1}"><span class="color-white">${properties.text1}</span></a>${properties.text2}<a href="${properties.pathfield2}" ><strong>${properties.text3}</strong></a>
        </p>
        <div class="col-xs-12 visible-xs text-center">
        <a class="btn btn-default cookie-btn">${properties.text4}</a>
        </div>

      </div>
    </div>
  </nav>
</div>
