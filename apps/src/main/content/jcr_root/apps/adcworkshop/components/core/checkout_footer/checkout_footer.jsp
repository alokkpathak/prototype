<%--
* Copyright (c)  Vorwerk POC
* Program Name :  checkout_footer.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Displays header for checkout footer.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 26-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>


<%@include file="/apps/adcworkshop/components/shared/global.jsp" %>
<%@page session="false" %>

  <footer class="container-fluid text-center checkoutfooter"> 
              

   <!--footer links-->
     <div class="container">
          <div class="row footerLinks-secure">
                <ul class="list-inline col-md-offset-2 col-md-8 col-xs-12">
                    <li ><a href="${properties.linkpolicy}.html" target=_blank>${properties.policytext} </a></li>
                    <li ><a href="${properties.linksale}.html" target=_blank>${properties.textsale}</a></li>
                    <li><a href="${properties.linkuse}.html" target=_blank>${properties.textuse}</a></li>
                    <li><a href="${properties.linkcontact}.html" target=_blank>${properties.contacttext}</a></li>
                                                                         
                </ul>
            </div>
        </div>
    <
<!--End of footer links-->                             
    </footer>