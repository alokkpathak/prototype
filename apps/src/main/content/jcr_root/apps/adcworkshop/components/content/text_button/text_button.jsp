<%--
* Copyright (c)  Vorwerk POC
* Program Name :  text_button.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  To display richtext with button.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 16-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>
   
<%@include file="/apps/adcworkshop/components/shared/global.jsp" %>
<%@page session="false" %>


<section class="about  text-center">
    <div class="container">
        <div class="row">
            <div class="col-md-10 col-md-offset-1 inside">
                ${properties.richtext}
            </div>
            
            
            <c:set var="check" value="${properties.valueSelected}"></c:set>
            <c:if test="${check eq 'true'}">
                <a href="#" class="btn btn-lg button-orange " role="button" style="background-color:#E4572D;">${properties.buttonname}</a>
                
            </c:if>  
            
        </div>
    </div>
</section>