<%--
    * Copyright (c)  Vorwerk POC
    * Program Name :  getsoftware.jsp
        * Application  :  Vorwerk POC
            * Purpose      :  See description
                * Description  :  Gives description about the software.
                    * Modification History:
* ---------------------
    *    Date                                Modified by                                       Modification Description
    *-----------                            ----------------                                    -------------------------
    * 11-Jul-2016                  Cognizant Technology solutions            					Initial Creation
    *----------- 
    -----------------                                    -------------------------                     -----------------                                    -------------------------
    --%>
    <%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %> 

<c:set var="listroot" value="<%=properties.get("navpath",currentPage.getPath())%>"/>

<%
    
    String[] multiiconlist = {"icontext", "iconimagename","iconimagenameMobile","iconimagealt"};

pageContext.setAttribute("iconmultifields", multiiconlist);


%>
<adc:multicompositefield var="iconList" fieldNodeName="multiicons" fieldPropertyNames="${iconmultifields}" returnType="List" />
<section class="container-fluid" style="background:#0385A6;">
    <div class=" row gs-row3 text-center getSoftware">
        <div class="col-md-offset-2 col-md-8 col-xs-12">
            <h2 class="hidden-xs"><strong>${properties.ptitle}</strong></h2>
            <h2 class="visible-xs"><strong>${properties.ptitle}</strong></h2>
            <p class="gs-subheading">${properties.pdesc}</p> 
        </div>      
        <div class="col-md-12 col-xs-12 col-sm-12">
            <div class="col-md-6 ">
                <div class="col-md-12 ">
                    <img src="${properties.imagename1}" alt="${properties.imagealt}" class="imgSwap getAppimg img-responsive" desk-img="${properties.imagename1}" mob-img="${properties.imagename1Mobile}">
                </div>
                <div class="col-md-12 ">
                    <a href="#myModal-download" data-toggle="modal" class="btn btn-info  gs-btn btn-margin" >${properties.buttonname}</a>
                </div>
            </div>
            <div class="col-md-6  text-left margin-bottom col-xs-12">
                <c:forEach items="${iconList}" var="ilist" varStatus="i">
                    <div class="media ">
                        <div class="media-left ">
                            <img src="${ilist.iconimagename}" alt="${ilist.	
iconimagealt}" class="imgSwap" desk-img="${ilist.iconimagename}" mob-img="${ilist.iconimagenameMobile}">
                        </div>
                        <div class="media-body">
                            <h5>${ilist.icontext}</h5>
                            
                        </div>
                    </div>
                </c:forEach>
            </div>

            
        </div>
    </div>
</section>
<cq:include path="downloadOverlay" resourceType="/apps/adcworkshop/components/content/downloadnowOverlay"/>

