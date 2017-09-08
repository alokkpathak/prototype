<%--
* Copyright (c)  Vorwerk POC
* Program Name :  breadcrumb.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Shows users the path they have taken down through the hierarchy. 
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 14-Jul-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>

<c:choose>
	<c:when test="${not empty properties.homeTitle}">
		<c:set var="title" value="${properties.homeTitle}"/>
	</c:when>
	<c:otherwise>
		<c:set var="title" value="LIBRE"/>
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${not empty properties.homePage}">
		<adc:minifyUrlTag  var="home" actualUrl="${properties.homePage}" />
	</c:when>
	<c:otherwise>
		<c:set var="home" value="#"/>
	</c:otherwise>
</c:choose>
<adc:minifyUrlTag  var="home" actualUrl="${properties.homePage}" />
<section class="abt-breadcrumb container-fluid hidden-xs hidden-sm padding-right">
	<div class="row ">
		<div class="col-md-11 col-md-offset-1 padding-zero">
			<div class="pull-left">    
				<div class="outer">
					<div class="inner-blue1">
						<div class="inner-blue2">
							<div class="inner-white">
							</div>
						</div>
					</div>
				</div>                   
			</div>
			<div class="parent-breadcrumb " style="background-color:#F4F2F4;">                   
				<div class="btn-group btn-breadcrumb">
					<a x-cq-linkchecker="skip" href="${home}" class="btn btn-default">
						${title}
					</a>
<%

	// get starting point of trail
	long level = properties.get("absParent", 7L);
	long endLevel = properties.get("relParent", 0L);
	int currentLevel = currentPage.getDepth();
	while (level < currentLevel - endLevel) 
	{
		Page trail = currentPage.getAbsoluteParent((int) level);
		if (trail == null) 
		{
			break;
		}
		String title = trail.getTitle();
		if (title == null || title.equals("")) 
		{
			title = trail.getNavigationTitle();
		}
		if (title == null || title.equals("")) 
		{
			title = trail.getName();
		}
%>

					<a href="<%= xssAPI.getValidHref(trail.getPath()+".html") %>" class="btn btn-default">
						<%= xssAPI.encodeForHTML(title) %>
					</a>
<%
		level++;
	}
%>
				</div>
			</div>
		</div>
	</div>
</section>