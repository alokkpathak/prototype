<%--
    * Copyright (c)  Vorwerk POC
    * Program Name :  shippingInfo.jsp
    * Application  :  Vorwerk POC
    * Purpose      :  See description
    * Description  :  To track the shipping information.
    * Modification History:
* ---------------------
    *    Date                                Modified by                                       Modification Description
    *-----------                            ----------------                                    -------------------------
    * 14-Sep-2016                  Cognizant Technology solutions            					Initial Creation
    *-----------                           -----------------                                    -------------------------
    --%>
    
    <%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<adc:restServiceUrl  var="trackAddress" key="track"/>
<input type="hidden" value="${trackAddress}" name="trackAddressServiceUrl" id="trackAddressServiceUrl"/>

<section class="testimonial">
				<div id="shippingInfo" class="modal fade" tabindex="-1">
				
				  <div class="modal-dialog ">
					  <div class="modal-content" style="padding-left: 20px">
						  <div class="modal-header padding-zero">
							   <button type="button" class="close" aria-label="close" data-dismiss="modal">&times;</button>
							  
						  </div>
						  <div class="modal-body col-md-offset-1">
                              <h4 class="modal-title">${properties.shippinginfo}</h4>
								
								<div class="col-lg-12 padding-zero topSpacing">${properties.status}</div>

								<div class="col-lg-6 topSpacing" style="background-color:#eee; padding:20px"><b>
									<div id="status" class="green">PACKAGE DELIVERED</div> 
									<div class="col-lg-12 padding-zero"><u>DATE</u>: <span id="date"> </span></div>
									<div class="col-lg-12 padding-zero"><u>TIME</u>: <span id="time"> </span></div></b>
								</div>
								
								<div id="status-table" class="col-lg-10 padding-zero"></div>

								<script id="orders-status" type="text/x-handlebars-template"> 
                                    <div class="col-lg-12 padding-zero">${properties.orderstatus}</div>
									<table class="table table-bordered text-center">
										<thead>
											<tr>
												<th class="text-center">STATUS</th>
												<th class="text-center">DATE/TIME</th>
											</tr>	
										<thead>
										<tbody> 
											{{#shipment_track_info}}
												<tr>
													<td>{{status}}</td>
													<td>{{{splitDateTime created_at}}}</td>
												</tr>
											{{/shipment_track_info}} 
										</tbody> 
									</table>
								</script>
						  </div>
						  
						  <div class="modal-footer">
						  </div>
					</div>
					</div>     
			  </div>
		</section>