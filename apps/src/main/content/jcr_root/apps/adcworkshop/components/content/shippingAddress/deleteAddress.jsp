<%--
* Copyright (c)  Vorwerk POC
* Program Name :  deleteAddresses.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  DeleteAddresses for deleting the use address
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 31-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>



<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>

<adc:restServiceUrl  var="deleteUserAddress" key="deleteAddress"/>
<input type="hidden" value="${deleteUserAddress}" id="deleteAddressServiceUrl"/>

<section class="testimonial">
    <div id="myModal-3" class="modal fade" tabindex="-1">
		
        <div class="modal-dialog ">
            <div class="modal-content">
                <div class="modal-header padding-zero">
                    <button type="button" class="close" aria-label="close" data-dismiss="modal">&times;</button>
                    
                </div>
				<div class="delete-global-message"></div>
                <div class="modal-body text-center">
                    <h2 class="modal-title h3">${properties.deletaddoverlayheading}</h2>
                </div>
                <input id="entity_id" val="" type="hidden"/>
                <div class="modal-footer" >
                    <div class="col-md-offset-5 col-md -7 hidden-xs hidden-sm RemoveAddress-loading">
                        	<div class="line-pulse"><div></div><div></div><div></div><div></div></div>
                   		 </div>
                    <div class="col-md-offset-2 col-md-3 text-left">
                        <a href="#" class="btn btn-lg cancel" data-dismiss="modal">${properties.cancelbtn}</a>
                    </div>
                    <div class="col-md-7 text-left ">
                        <div class="RemoveAddress-loading hidden-md hidden-lg">
                        	<div class="line-pulse"><div></div><div></div><div></div><div></div></div>
                   		 </div>
                        <a href="#" class="btn btn-lg button-orange"  id="remove_address" style="background-color:#E4572D;">${properties.dltbtn}</a>
                    </div>
                    
                </div>
            </div>
        </div>     
    </div>
</section>
<!--delete  address-->

