<%--
* Copyright (c)  Vorwerk POC
* Program Name :  sitemap.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  To lists all the pages available in the site.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 01-Sep-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>
<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<%@ page import="java.util.Iterator, com.day.cq.wcm.api.PageFilter"%>

<section class="container-fluid sitemap">
<div class="row">
<div class="col-md-8 col-md-offset-2" style="background-color:#E4572D;">

<%
String[] multilinks1 = {"title1","link1","size","showChildPages1"};

pageContext.setAttribute("linkmultifields1", multilinks1);

String[] multilinks2 = {"title2","link2","showChildPages2"};

pageContext.setAttribute("linkmultifields2", multilinks2);

String[] multilinks3 = {"title3","link3","showChildPages3"};

pageContext.setAttribute("linkmultifields3", multilinks3);

%>

<adc:multicompositefield var="linkListarray1" fieldNodeName="multi1" fieldPropertyNames="${linkmultifields1}" returnType="List" />
<adc:multicompositefield var="linkListarray2" fieldNodeName="multi2" fieldPropertyNames="${linkmultifields2}" returnType="List" />
<adc:multicompositefield var="linkListarray3" fieldNodeName="multi3" fieldPropertyNames="${linkmultifields3}" returnType="List" />

<div class="col-md-4">
<c:forEach items="${linkListarray1}" var="llist1">
<c:if test="${llist1.size == 'h3'}">
<a id ="homePage" href="${llist1.link1}.html"><h3>${llist1.title1}</h3></a>
</c:if>
<c:if test="${llist1.size == 'h4'}">
<a id ="discoverIT" href="${llist1.link1}.html"><h4>${llist1.title1}</h4></a>
</c:if>

<c:set var="link1" value="${llist1.link1}" scope="request"/>
    <c:if test="${llist1.showChildPages1 eq 'yes'}">

    <%

String link1=request.getAttribute("link1").toString();
Page rootPage = pageManager.getPage(link1);
if (rootPage != null) {
	Iterator<Page> children = rootPage.listChildren(new PageFilter(request));
	%>
	<ul>
	<%
	while (children.hasNext()) {
		Page child = children.next();
		String title = child.getTitle() == null ? child.getName() : child.getTitle();

		%>

		<a id ="linkValueHit1" href="<%= child.getPath() %>.html"><li><%= title %></li></a>

		<%
	}
	%> </ul><%
}
%>
    </c:if>
</c:forEach>

</div>
<div class="col-md-4">
<c:forEach items="${linkListarray2}" var="llist2">
<a id="buyOnline" href="${llist2.link2}.html"><h3>${llist2.title2}</h3> </a>
<c:set var="link2" value="${llist2.link2}" scope="request"/>
        <c:if test="${llist2.showChildPages2 eq 'yes'}">

<%String link2=request.getAttribute("link2").toString();
Page rootPage2 = pageManager.getPage(link2);
if (rootPage2 != null) {
	%>
	<ul>
	<%
	Iterator<Page> children2 = rootPage2.listChildren(new PageFilter(request));
	while (children2.hasNext()) {
		Page child2 = children2.next();
		String title2 = child2.getTitle() == null ? child2.getName() : child2.getTitle();
		// out.println(child2.getPath()+" "+title2);
		%>
		<a id ="linkValueHit2" href="<%=child2.getPath()%>.html"><li><%=title2%></li></a>
		<%

	}
	%></ul>
	<%
}
%>
    </c:if>

</c:forEach>
</div>
<div class="col-md-4">
<c:forEach items="${linkListarray3}" var="llist3">

<a id="cilentAccount" href="${llist3.link3}.html"><h3>${llist3.title3}</h3> </a>
<c:set var="link3" value="${llist3.link3}" scope="request"/>
    <c:if test="${llist3.showChildPages3 eq 'yes'}">
<%String link3=request.getAttribute("link3").toString();
Page rootPage3 = pageManager.getPage(link3);
if (rootPage3 != null) {
	%>
	<ul>
	<%
	Iterator<Page> children3 = rootPage3.listChildren(new PageFilter(request));
	while (children3.hasNext()) {
		Page child3 = children3.next();
		String title3 = child3.getTitle() == null ? child3.getName() : child3.getTitle();
		//out.println(child3.getPath()+" "+title3);
		%>
		<a id ="linkValueHit3" href="<%=child3.getPath()%>.html"><li><%=title3%></li></a>
		<%
	}
	%>
	</ul>
	<%
}
%>
    </c:if>
</c:forEach>
</div>
</div>
</div>
</section>