<%--
* Copyright (c)  Vorwerk POC
* Program Name :  contact_us_success.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Contact Us Success form.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 13-Jul-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
  --%>  

    
<%@include file="/apps/adcworkshop/components/shared/global.jsp" %>
<%@page session="false" %>
<adc:minifyUrlTag  var="homePageUrl" actualUrl="${properties.location}" />
<input type="hidden" name="homePageUrl" id="homePageUrl" value="${homePageUrl}">


   <!-- contact Sucess -->
  <section class="container-fluid text-center">
        <div class="col-md-8 col-md-offset-2 about-heading ">
                            
          <p class="success">${properties.contacttext} </p>
            <button type="submit" name="submit" class="btn btn-lg form-btn" onclick="redirect()">${properties.buttonname}</button>
          
          
        </div>

  </section>
<script>
    function redirect(){
		window.location.replace($("#homePageUrl").val());
    }
</script>
