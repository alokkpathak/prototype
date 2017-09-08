<%--
* Copyright (c)  Vorwerk POC
* Program Name :  gettheapp.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  It gives description about software and how to download software in the mobile. 
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 11-Jul-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<c:set var="listroot" value="<%=properties.get("navpath",currentPage.getPath())%>"/>

<%
			String[] multiProp = {"rightimagename", "righttitlename", "righttitledescription","rightimagealt","rightimagenameMobile"};
			pageContext.setAttribute("multiFieldSet1", multiProp);
%>
<adc:multicompositefield var="rightradiobuttonList" fieldNodeName="rightmulti" fieldPropertyNames="${multiFieldSet1}" returnType="List" />

<section class="container-fluid" style="background:#FFC11B;">
  <div class="row gs-row3 text-center getapp">
	<div class="col-md-offset-2 col-md-8 col-xs-12">  
	<h3>${properties.ptitle}</h3>
	<p class="gs-subheading">${properties.pdesc}</p>
	</div>   
	<div class="col-md-12 ">
	<div class="col-md-5 visible-xs visible-sm">
		<div class="col-md-12">
			<img  src="${properties.imagename1}"  class="imgSwap getAppimg img-responsive" alt="${properties.imagealt}" desk-img="${properties.imagename1}" mob-img="${properties.imagename1Mobile}"/>  
		</div>
		<div class="col-md-12 ">
			
				<c:set var="googlePlayLink" value="${properties.typeOfLink}"></c:set>
				<c:set var="normalLink" value="${properties.typeOfLink}"></c:set>
				<c:choose>

				<c:when test="${normalLink eq 'normalLink'}">

					<c:if test="${properties.newTab eq 'no'}">
						<a href="${properties.buttonlink}" class="btn btn-info  gs-btn downloadAndroid " role="button">${properties.richtext1}</a>
					</c:if>

					<c:if test="${properties.newTab eq 'yes'}">
						<a href="${properties.buttonlink}" target="_blank" class="btn btn-info  gs-btn downloadAndroid " role="button">${properties.richtext1}</a>
					</c:if>

				</c:when>

					<c:when  test="${googlePlayLink eq 'googlePlayLink'}" >
						<a href="${properties.googlePlayRedirectionLink}" target="_blank"> <img src="${properties.googlePlayImageLink}" /> </a>
					</c:when>

				</c:choose>
				<p class="soon">${properties.comment}</p> 
		</div>     
	  </div>
	  <div class="col-md-offset-1 col-md-6 margin-bottom">  
		<c:forEach items="${rightradiobuttonList}" var="rightlist" varStatus="i">
		<div class="media media-app ">
		  <div class="media-left pull-right ">
			<img src="${rightlist.rightimagename}" alt="${rightlist.rightimagealt}" class="imgSwap" desk-img="${rightlist.rightimagename}"mob-img="${rightlist.rightimagenameMobile}"/>
		  </div>
		  <div class="media-body text-right">
			<h5>${rightlist.righttitlename}</h5>
			<p>${rightlist.righttitledescription}</p>
		  </div>
		</div>
		 </c:forEach>
	</div>        
	  <div class="col-md-5 hidden-xs hidden-sm">
		<div class="col-md-12">
		<img  src="${properties.imagename1}"  class="imgSwap getAppimg img-responsive" alt="${properties.imagealt}" desk-img="${properties.imagename1}" mob-img="${properties.imagename1Mobile}"/>  
		</div>
		<div class="col-md-12 ">
			
			<c:set var="googlePlayLink" value="${properties.typeOfLink}"></c:set>
				 <c:set var="normalLink" value="${properties.typeOfLink}"></c:set>
				<c:choose>

				<c:when test="${normalLink eq 'normalLink'}">

					<c:if test="${properties.newTab eq 'no'}">
						<a href="${properties.buttonlink}" class="btn btn-info  gs-btn downloadAndroid " role="button">${properties.richtext1}</a>
					</c:if>

					<c:if test="${properties.newTab eq 'yes'}">
						<a href="${properties.buttonlink}" target="_blank" class="btn btn-info  gs-btn downloadAndroid " role="button">${properties.richtext1}</a>
					</c:if>

				</c:when>

					<c:when  test="${googlePlayLink eq 'googlePlayLink'}" >
						<a href="${properties.googlePlayRedirectionLink}" target="_blank"> <img src="${properties.googlePlayImageLink}" /> </a>
					</c:when>

				</c:choose>
		<p class="soon">${properties.comment}</p> 
		</div>     
	  </div>
	</div> 
</div>
</section>  



