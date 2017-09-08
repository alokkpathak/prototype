<%--
* Copyright (c)  Vorwerk POC
* Program Name :  help_resources.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Resources of the help page.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 01-Sep-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>
<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>



<section class="about " style="background-color:#F4F2F4;" > 
        <div class="container-fluid">
                <div class="col-md-8 col-md-offset-2 col-xs-12 about-heading text-center">
				${properties.richtext}
                    <div class="col-xs-12 visible-xs visible-sm hidden">
                   <div class="row text-center">
                       <a href="${properties.path1}.html" class="resource-padding text-orange">${properties.text1}</a>
                       <a href="${properties.path2}.html" >${properties.text2}</a>
                    </div>
                  </div>
                </div>
                <div class="col-md-2 resource-top hidden-xs hidden-sm hidden">
                   <div class="row text-center">
                      <a href="${properties.path1}.html" class="resource-padding text-orange">${properties.text1}</a>
                       <a href="${properties.path2}.html">${properties.text2}</a>

                    </div>
                  </div>
                
            </div>
    </section>

