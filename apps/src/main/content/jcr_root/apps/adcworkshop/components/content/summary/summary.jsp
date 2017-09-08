<%--
* Copyright (c)  Vorwerk POC
* Program Name :  summary.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Displays grid component in summary page.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 23-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>
<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>

<%@ page import="java.util.Iterator,
        com.day.cq.wcm.api.PageFilter"
    %>
<section class="container-fluid text-center grid-summary">
  <div class="row">
    <div class="col-md-8 col-md-offset-2">

<%
    String listroot = properties.get("rootPath", String.class);
	Page rootPage = pageManager.getPage(listroot);
    if (rootPage != null) {
        Iterator<Page> children = rootPage.listChildren(new PageFilter(request));
        while (children.hasNext()) {
            Page child = children.next();
            String title = child.getTitle() == null ? child.getName() : child.getTitle();
            %>
	<div class="col-md-4">
    <div class="summary-block"><a href="<%= xssAPI.getValidHref(child.getPath())%>.html"><%= xssAPI.encodeForHTML(title) %></a></div>
    </div>
<%

        }
    }
    %>
  </div>
  </div>
</section>

