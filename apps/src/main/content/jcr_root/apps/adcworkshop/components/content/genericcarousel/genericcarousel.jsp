<%--
* Copyright (c)  Vorwerk POC
* Program Name :  genericcarousel.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  To create product slides.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 20-Jul-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>
<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<%@ page  import="java.util.*" %>

<%
    
String[] multiProductlist = {"slidingtextname", "slidingtextdescription","productname","productdescription","buttonname"
    ,"buttonlinkname","imagename","panelbuttoncolor","panelimagealt","imagenameMobile"};
String[] multihelplist = {"helptext", "helpdesc","hbuttonname","hbuttonname"
    ,"hbuttonlinkname","helpmainimage","helpleftimageDesktop","helpleftimageMobile","himagealt","mainimagealt","helpmainimageMobile","buttonDescription","dotselector"};

pageContext.setAttribute("productmultifields", multiProductlist);
pageContext.setAttribute("helpmultifields", multihelplist);

%>

<adc:multicompositefield var="productList" fieldNodeName="pmulti" fieldPropertyNames="${productmultifields}" returnType="List" />
<adc:multicompositefield var="helpList" fieldNodeName="hmulti" fieldPropertyNames="${helpmultifields}" returnType="List" />


<script>

    
    function hideandshowCarouselTabs(field){
        
        var d = field.findParentByType('tabpanel');	
        
        d.hideTabStripItem('productcarousel'); 
        d.hideTabStripItem('helpcarousel');
        var dialog = field.findParentByType('dialog');	
        var drop = dialog.getField("./carouseltypeselector");
        var val = drop.getValue();
        
        if(val=='productcarousel'){

            d.unhideTabStripItem('productcarousel');
            d.hideTabStripItem('helpcarousel');		
        }
        
        else if(val=='helpcarousel'){
            d.unhideTabStripItem('helpcarousel');
            d.hideTabStripItem('productcarousel'); 
        }
    }
        
</script>




<input type="hidden"  value=${properties.carouseltime} id="carouselTimerinterval"/>

<c:if test="${properties.carouseltypeselector eq 'helpcarousel'}">
    
    <!-- Start For Desktop-->

    <section class="parallex carousel hidden-xs hidden-sm"> 
        <div class="parallex-ol">
            <div id="parallax-landingpage" class="carousel slide" data-ride="carousel">
                
                <ol class="carousel-indicators">
                    <li data-target="parallax1"  ></li>
                    <li data-target="parallax2"  ></li>
                    <li data-target="parallax3"  ></li>
                    <li data-target="parallax4"  ></li>
                    <li data-target="parallax5" ></li>
                </ol>
            </div>


        </div>


        <c:forEach items="${helpList}" var="hlist" varStatus="i">
            <div class="jarallax" id="parallax${i.count}" data-list-style="${hlist.dotselector}" style="background-image: url(${hlist.helpmainimage});">
                <div class="vertical_line hidden-xs hidden-sm"></div>
                <img class="v-img" src="${hlist.helpleftimageDesktop}"  alt="${hlist.himagealt}"/>
                <div class="vertical_line2 hidden-xs hidden-sm"></div>
                <div class="carousel-desc carousel-desc${i.count}">
                    <h3 class="font-uppercase" id="alignheading${i.count}">${hlist.helptext}</h3>
                    <p>${hlist.helpdesc}</p>
					
                    <a href="${hlist.hbuttonlinkname}" class="btn btn-info" role="button" >${hlist.hbuttonname}<span class="sr-only">${hlist.buttonDescription}</span></a>                        
                </div>
                
            </div>
        </c:forEach>
    </section>

    <!-- END For Desktop -->

    <!---Start For Mobile-->
    
    
    <section class="carousel-1 visible-sm visible-xs" >              
        
        <div id="crsl-landingpage" class="carousel slide" data-ride="carousel">
            
            <ol class="carousel-indicators">
                <li data-target="#crsl-landingpage" data-slide-to="0" class="active"></li>
                <li data-target="#crsl-landingpage" data-slide-to="1" ></li>
                <li data-target="#crsl-landingpage" data-slide-to="2" ></li>
                <li data-target="#crsl-landingpage" data-slide-to="3" ></li>
                <li data-target="#crsl-landingpage" data-slide-to="4" ></li>
            </ol>
            <div class="carousel-inner" >
                <c:forEach items="${helpList}" var="hlist" varStatus="i">
                    <c:choose>
                        <c:when test="${i.index==0}">
                            <div class="item active">
                            </c:when>
                            <c:otherwise>
                                <div class="item">
                                    
                                </c:otherwise>
                            </c:choose>	  
                            
                            <div class="col-md-11 col-md-offset-1 col-xs-12 padding-right">

                                <div class="bothdesktopmobile">

                                    <img src="${hlist.helpmainimageMobile}"  class="carsl-img img-responsive" alt="${hlist.mainimagealt}" />
                                </div>


                                <div class="vertical_line hidden-xs hidden-sm"></div>
                                <img class="v-img" src="${hlist.helpleftimageMobile}" alt="${hlist.himagealt}" />
                                <div class="vertical_line2 hidden-xs hidden-sm"></div>
                                <div class="carousel-desc">
                                    <h3 class="font-uppercase">${hlist.helptext}</h3>
                                    <p>${hlist.helpdesc}</p>
                                    <a href="${hlist.hbuttonlinkname}" class="btn btn-info" role="button">${hlist.hbuttonname}</a>                        
                                </div>
                            </div>
                        </div>
                        
                        
                    </c:forEach>
                    <div class="visible-xs visible-sm nav-crsl-landingpage">
                        <a class="left carousel-control" href="#crsl-landingpage" role="button" data-slide="prev">
                            <img src="/content/dam/adc/fsl/images/global/en/arrow-left1.png" alt="">
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="right carousel-control" href="#crsl-landingpage" role="button" data-slide="next">
                            <img src="/content/dam/adc/fsl/images/global/en/arrow-right1.png" alt="">
                            <span class="sr-only">Next</span>
                        </a>
                    </div>
                </div>
            </div>
            
        </section>                               

        
        <!-- End of Mobile -->
        
        
        
    </c:if>
    
    
    
    <c:if test="${properties.carouseltypeselector eq 'productcarousel'}">
        
        <div class="container-fluid" style="background-color:#${properties.bgcolor};">
            <div class="discoverCarousel" >
                <div id="prodCarousel" class="carousel slide" data-ride="carousel">
                    
                    <ol class="carousel-indicators carousel-rect">
                        <li data-target="#prodCarousel" data-slide-to="0" class="active"></li>
                        <li data-target="#prodCarousel" data-slide-to="1" class=""></li>
                        <li data-target="#prodCarousel" data-slide-to="2" class=""></li>            
                    </ol>
                    <div class="carousel-inner">
                        <c:forEach items="${productList}" var="list" varStatus="i">
                            
                            <c:choose>
                                <c:when test="${i.index==0}">
                                    <div class="item active" >
                                    </c:when>
                                    <c:otherwise>
                                        <div class="item" >
                                        </c:otherwise>
                                    </c:choose>

                                    <div class="container">	      				
                                        <div class="col-md-12 col-xs-12">
                                            <div class="carouselCaption text-center">
                                                <h3> ${list.slidingtextname}  </h3>
                                                <p> ${list.slidingtextdescription}</p>
                                                <div class="media">
                                                    <a class="media-left" href="${list.buttonlinkname}">
                                                        <img class="media-object imgSwap img-responsive" src=${list.imagename} alt="${list.panelimagealt}" desk-img="${list.imagename}" mob-img="${list.imagenameMobile}">

                                                    </a>
                                                    <div class="media-body text-left" >
                                                        <h3 class="media-heading">${list.productname}</h3>
                                                        <p>${list.productdescription}</p>
                                                        <div >
                                                            <a href="${list.buttonlinkname}" class="btn btn-info btn-lg " role="button" style="background-color:#${list.panelbuttoncolor};">${list.buttonname}</a>
                                                            
                                                        </div>
                                                        
                                                    </div>
                                                </div>
                                            </div>
                                            
                                        </div>
                                    </div>	
                                </div>
                            </c:forEach>

                            <a class="left carousel-control " href="#prodCarousel" role="button" data-slide="prev">
                                <img src="${properties.leftarrowimage}" alt="">
                                <span class="sr-only">Previous</span>
                            </a>
                            <a class="right carousel-control" href="#prodCarousel" role="button" data-slide="next">
                                <img src="${properties.rightarrowimage}" alt="">
                                <span class="sr-only">Next</span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            
            
            
        </c:if>
        
        

        
        
