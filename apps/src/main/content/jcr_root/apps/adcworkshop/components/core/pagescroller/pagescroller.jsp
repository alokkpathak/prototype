<%--
* Copyright (c)  Vorwerk POC
* Program Name :  pagescroller.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  For providing next page or previous page link on each page.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 16-Aug-2016                  Cognizant Technology solutions                                                                                 Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<%@ page import="org.apache.jackrabbit.util.Text,
                                                                                java.util.Iterator,
                                                                                com.day.cq.wcm.api.Page,
                     com.day.cq.wcm.api.PageFilter,
                     com.day.cq.wcm.api.PageManager"%>
<% 

                String rootPage= currentPage.getTitle();
                Iterator<Page> childIterator = currentPage.getParent().listChildren();
                Iterator<Page> nextChildIterator = currentPage.getParent().listChildren();
               String nextPage =null;
                                                String prevPage = null;
                String nextPagepath =null;
                                                String prevPagepath = null;
                String rootPagepath= currentPage.getPath();
                                                                String pagename=currentPage.getNavigationTitle() == null ? currentPage.getTitle() : currentPage.getNavigationTitle();


while(childIterator.hasNext()) {
    Page child = childIterator.next();
    if(child.getTitle().equals(rootPage)){
        // out.println("This is working\n");
        while(nextChildIterator.hasNext()){
            Page nextChild = nextChildIterator.next();
            if(nextChild.getTitle().equals(rootPage)){

                if(nextChildIterator.hasNext()){
                    Page newPage=nextChildIterator.next();
                    // nextPage=newPage.getTitle();
                    nextPage=newPage.getNavigationTitle() == null ? newPage.getTitle() : newPage.getNavigationTitle();

                        nextPagepath=newPage.getPath();
                    break;
                }
                else{
                    nextPage=null;
                    nextPagepath=null;
                }
            }


        }
        break;

    }
    else{
        //  prevPage=child.getTitle();
        prevPage=child.getNavigationTitle() == null ? child.getTitle() : child.getNavigationTitle();
            prevPagepath=child.getPath();


    }


    //out.println("child.getNavigationTitle()>>>"+child.getNavigationTitle());
    //String pagename=child.getNavigationTitle() == null ? child.getTitle() : child.getNavigationTitle();

%>
<!--<c:out value="<%=pagename%>"></c:out><br> -->
<% }
%>
<c:set var= "prevPage" value="<%=prevPage%>"></c:set>
<c:set var= "rootPage" value="<%=pagename%>"></c:set>
<c:set var= "nextPage" value="<%=nextPage%>"></c:set>
<c:set var= "prevPagepath" value="<%=prevPagepath%>"></c:set>
<c:set var= "rootPagepath" value="<%=rootPagepath%>"></c:set>
<c:set var= "nextPagepath" value="<%=nextPagepath%>"></c:set>
<c:set var="check" value="${properties.valueselected}"></c:set>
<c:set var="prev" value="${properties.prevcheck}"></c:set>
<c:set var="next" value="${properties.nextcheck}"></c:set>
<c:choose>
    <c:when test="${check eq 'true'}">
        <section class="about nav-links text-center container-fluid" style="background-color:#F4F2F4;">
            <div class="container-fluid">
                <!-- Page banner !-->       
                <div class="row two-navigation-banner">
                    <div class="col-xs-12 visible-xs">          
                        <h1 class="font-orange text-center">${rootPage}</h1>        
                    </div>
                    <c:choose>
                        <c:when test="${not empty prevPage && prev eq 'true'}">
                            <div class="col-sm-3 col-xs-6 as-banner padding-zero">
                                <a class="left-link" href="${prevPagepath}.html">
                                   	<div class="nav-link-arrow">
                                        <img src="${properties.leftarrow}"  class="imgSwap" alt="" desk-img="${properties.leftarrow}" mob-img="${properties.leftarrowMobile}"> 
                                    </div>
                                    <div class="nav-link-text">${prevPage}</div>
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="col-sm-3 col-xs-6">

                            </div>
                        </c:otherwise>
                    </c:choose>

                    <div class="col-sm-6 hidden-xs ">
                        <h1 class="font-orange text-center">${rootPage}</h1>
                    </div>
                    <c:if test="${not empty nextPage && next eq 'true'}">
                        <div class="col-sm-3 col-xs-6 as-banner padding-zero">  
                            <a class="right-link" href="${nextPagepath}.html">
                                <div class="nav-link-text">${nextPage}</div>
								<div class="nav-link-arrow">
                                	<img src="${properties.rightarrow}" class="imgSwap" alt="" desk-img="${properties.rightarrow}" mob-img="${properties.rightarrowMobile}">
                                </div>
                            </a>
                        </div>
                    </c:if>
                </div><!-- ***End of Page banner ***!-->
            </div>
        </section>
    </c:when>
    <c:otherwise>
        <section class="sub-footer container-fluid">
            <div class="col-md-12">
                <div class="row apply-sensor two-navigation-banner">
                    <c:if test="${not empty prevPage  && prev eq 'true'}">
                        <div class="col-xs-6 as-banner padding-zero">
                                <a class="left-link" href="${prevPagepath}.html">
                                   	<div class="nav-link-arrow">
                                        <img src="${properties.leftarrow}"  class="imgSwap" alt="" desk-img="${properties.leftarrow}" mob-img="${properties.leftarrowMobile}"> 
                                    </div>
                                    <div class="nav-link-text">${prevPage}</div>
                                </a>
                            </div>
                      </c:if>
                      <c:if test="${empty prevPage}">
                            <div class="col-xs-6 ">

                            </div>
                        </c:if>
                    <c:if test="${not empty nextPage  && next eq 'true'}">
                        <div class="col-xs-6 as-banner padding-zero">  
                            <a class="right-link" href="${nextPagepath}.html">
                                <div class="nav-link-text">${nextPage}</div>
								<div class="nav-link-arrow">
                                	<img src="${properties.rightarrow}" class="imgSwap" alt="" desk-img="${properties.rightarrow}" mob-img="${properties.rightarrowMobile}">
                                </div>
                            </a>
                        </div>
                    </c:if>
                </div>
            </div>

        </section>
    </c:otherwise>
</c:choose>



