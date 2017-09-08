<%--
* Copyright (c)  Vorwerk POC
* Program Name :  account_overview_panel.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Displays the overview of the user account.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 24-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>


<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<%
    String findlink=properties.get("findlink","findlink");
%>

<section id="accountOverview" class="col-lg-12 col-md-12  container-fluid account-details-well">
    <div class="details-container">
        <h2 class="h4">${properties.welcometext} <span id="rightPaneluserNameLabel" class="panelUserName"></span></h2>
        <div class="row text-center">
            <div class="col-lg-4 col-md-4 text-center">
                <div class="well" style="background-color: #e1e1e1;">
                    <p>${properties.orderdesc}</p>
                     <a class="btn-link accountMenuLink font-fourteen text-orange" role="button" name="orders" style="display:table;">

                    <div class="prsnDetailGridImg">
                        <img  src="/content/dam/adc/fsl/images/global/en/btn-discover.png" />
                    </div>
                    <div class="prsnDetailGrid-content">
                            	${properties.ordertitle}
                    </div>
                    </a>
                </div>
            </div>

            <div class="col-lg-4 col-md-4">
                <div class="well" style="background-color: #e1e1e1;">
                    <p>${properties.registerdesc}</p>

                    <a class="btn-link accountMenuLink font-fourteen text-orange" role="button" name="stdWarrenty" style="display:table;">
                    <div class="prsnDetailGridImg">
                        <img  src="/content/dam/adc/fsl/images/global/en/btn-discover.png" />
                    </div>
                    <div class="prsnDetailGrid-content">
                            	${properties.registertitle}
                    </div>
                    </a>
                </div>
            </div>

            <div class="col-lg-4 col-md-4">
                <div class="well" style="background-color: #e1e1e1;">
                    <p>${properties.checkoutdesc}</p>

                    <a id="persDetails_menu" class="btn-link accountMenuLink font-fourteen text-orange" role="button" name="persDetails" style="display:table;">
                    <div class="prsnDetailGridImg">
                        <img  src="/content/dam/adc/fsl/images/global/en/btn-discover.png" />
                    </div>
                    <div class="prsnDetailGrid-content">
                            	${properties.checkouttitle}
                    </div>
                    </a>
                </div>
            </div>
        </div>	
        <div class="row topSpacing text-center"> 
            <div class="col-lg-12 col-md-12">
                <div class="well" style="background-color: #E4572D; margin-top:35px">
                    <div class="sensor-block">
                        <h2 class="letterSpacing headPara">${properties.packtext}</h2>
                        <p><a href="<%= xssAPI.getValidHref(findlink) %>" id="userInfoSubmit" class="btn btn-lg button-white" role="button">${properties.findbuttontext}</a></p>
                    </div>
                </div>
            </div>
        </div>

    </div>
</section>
