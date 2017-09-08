<%--
* Copyright (c)  Vorwerk POC
* Program Name :  countryIndex.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  country index list.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 28-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<%@ page  import="java.util.*" %>

<%
    
    String[] europeCountrylist = {"ecountryname", "eimagepath","eimagepathMobile","ecountryLocale"};
	String[] otherCountryList = {"ocountryname", "oimagepath","oimagepathMobile","ocountryLocale"};

	pageContext.setAttribute("europecountries", europeCountrylist);
	pageContext.setAttribute("othercountries", otherCountryList);


%>
<adc:multicompositefield var="europeCountryList" fieldNodeName="cmulti" fieldPropertyNames="${europecountries}" returnType="List" />
<adc:multicompositefield var="otherCountryList" fieldNodeName="omulti" fieldPropertyNames="${othercountries}" returnType="List" />
<adc:globalSettingsTag  var="domains"  allDomains="true" />
<input type="hidden" value="${domains}" id="domainNames"/>
<section class="testimonial">
    <div id="myModal-country" class="modal fade" tabindex="-1">
        <div class="modal-dialog ">
            <div class="modal-content">
                <div class="modal-header padding-zero">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <div class="modal-body">
                    <div class="col-md-12 col-sm-12" >
                        
                        
                        <div class=" col-md-12 col-sm-12  country-selection">
                            <h3>${properties.etext}</h3>
                            <c:forEach items="${europeCountryList}" var="elist"> 
								<ul class="list-group">

                                    <li class="list-group-item"><span class="countryClickHandler" href="#"><img src="${elist.eimagepath}" alt="${elist.ecountryname}" class="imgSwap" desk-img="${elist.eimagepath}" mob-img="${elist.eimagepathMobile}"/><input type="hidden" id="countryLocale_${elist.ecountryLocale}" value="${elist.ecountryLocale}"></span> <span class="flag-name hidden-xs">${elist.ecountryname}</span></li><span class="visible-xs">${elist.ecountryname}</span>
                                </ul> 
                            </c:forEach> 
                        </div>  
                        <div class="col-md-12 col-sm-12 country-selection">
                            <h3>${properties.otext}</h3>
                            <c:forEach items="${otherCountryList}" var="olist"> 
							 <ul class="list-group">
									
                                    <li class="list-group-item"><span class="countryClickHandler" href="#"><img src="${olist.oimagepath}" alt="${olist.ocountryname}" class="imgSwap" desk-img="${olist.oimagepath}" mob-img="${olist.oimagepathMobile}" /><input type="hidden" id="countryLocale_${olist.ocountryLocale}" value="${olist.ocountryLocale}"></span> <span class="flag-name hidden-xs">${olist.ocountryname}</span></li><span class="visible-xs">${olist.ocountryname}</span>
                                    <li class="list-group-item text-right"><span class="hidden-xs">${properties.other}</span></li><span class="visible-xs">${properties.other}</span>
                                </ul>
                            </c:forEach> 
                        </div> 

                       <div class="col-md-12 col-sm-12 text-center padding-zero">
                            <p>${properties.untext}<a href="${properties.pathLink}" class="text-orange" target="_blank"><span class="sr-only">${properties.untext}${properties.pathtext}</span>${properties.pathtext}</a></p>   

                        </div>

                    </div>
                    
                </div>
                
            </div>
        </div>
    </div>
    
</section>