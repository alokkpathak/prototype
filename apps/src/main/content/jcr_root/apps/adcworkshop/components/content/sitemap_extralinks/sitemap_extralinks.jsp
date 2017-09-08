<%--

sitemap_extralinks component.



--%><%
%><%
%><%@page session="false" %><%
%><%
// TODO add you code here
%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<%
String[] multilinks = {"text","path","newtabcheck1","text2","path2","newtabcheck2"};

pageContext.setAttribute("linkmultifields", multilinks);

%>


<adc:multicompositefield var="linkListarray" fieldNodeName="extralinks" fieldPropertyNames="${linkmultifields}" returnType="List" />


<section class="container-fluid sitemapbottom">
<div class="row">
<div class="col-md-12">
<p class="text-center andAlso"><strong>${properties.title}</strong></p>
</div>
<div class="col-md-8 col-md-offset-2" >
<c:forEach items="${linkListarray}" var="llist">  

<div class="col-md-4">

<ul class="listStyle">

<c:if test="${llist.newtabcheck1 eq 'true'}">
<li><a href="${llist.path}" target=_blank title="${llist.text} opens in new window">${llist.text}</a></li>
</c:if> 
<c:if test="${llist.newtabcheck1 eq 'false'}">
<li><a href="${llist.path}">${llist.text}</a></li>
</c:if>

</ul>

</div>


</c:forEach>


</div>
</div>
</section>

