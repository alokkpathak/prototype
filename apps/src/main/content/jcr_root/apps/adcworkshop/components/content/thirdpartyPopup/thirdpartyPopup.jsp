<%--
* Copyright (c)  Vorwerk POC
* Program Name : thirdpartyPopup.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  : this page will give the popup for the thirdParty URL Permissions.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 23-Sep-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<section class="testimonial">
<div id="myModal-thirdParty" class="modal fade" tabindex="-1">
<form>
                  <div class="modal-dialog ">
                      <div class="modal-content">
                          <div class="modal-header padding-zero">
                               <button type="button" class="close" data-dismiss="modal" aria-label="close">&times;</button>

                          </div>

                          <div class="modal-body text-center hidden" id="homeoverlaytext">
                              <h2 class="modal-title hidden">${properties.homerichtextcontent}</h2>
                          </div>
                          <div class="modal-body text-center hidden" id="commonoverlaytext">
                           <h2 class="modal-title hidden">${properties.richtextcontent}</h2>
                           </div>
                          <div class="modal-footer ">
                              <a id="dismissOk" href="#" class="btn btn-lg cancel"  data-dismiss="modal" role="button">${properties.okbutton}</a> 
                              <a href="${properties.redirectingurl}" id="redirectUrl" class="btn btn-lg button-orange hidden" role="button" style="background-color:#E4572D;">${properties.redirectbutton}</a>
                              <a href="${properties.homeurl}" id="redirecthomeUrl" class="btn btn-lg button-orange hidden" role="button" style="background-color:#E4572D;">${properties.homeredirect}</a>
                          </div>
                      </div>
                  </div>
                  </form>
              </div>
  
</section>