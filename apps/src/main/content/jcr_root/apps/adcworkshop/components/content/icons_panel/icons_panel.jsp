<%--
* Copyright (c)  Vorwerk POC
* Program Name :  icons_panel.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Displays image,text with some description.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 11-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<%@ page  import="java.util.*" %>

<%

String[] multitextimagelist = {"simpletext", "textarea","image","imagealt","imageMobile"};
pageContext.setAttribute("textimagemultifields", multitextimagelist);

%>


<adc:multicompositefield var="textimageList" fieldNodeName="textimagemulti" fieldPropertyNames="${textimagemultifields}" returnType="List" />

<section class="your-icons">

  <div class="col-md-12 col-xs-12 iconBlock">
      <c:set var="class" value=""></c:set>
      <c:forEach items="${textimageList}" var="tlist" varStatus="i">
          <c:choose>
              <c:when test="${i.index eq 2}">
				<c:set var="class" value="clearfix"></c:set>
              </c:when>
              <c:otherwise>
                 <c:set var="class" value=""></c:set>
              </c:otherwise>
          </c:choose>
          <div class="${class} col-md-2 text-center col-xs-6">
              
              <img src="${tlist.image}"  alt="${tlist.imagealt}" desk-img="${tlist.image}" mob-img="${tlist.imageMobile}" class="imgSwap" >
              <h4 class="text-orange"><b>${tlist.simpletext}</b></h4>
              <p>${tlist.textarea}</p>
              
          </div>
          
          
      </c:forEach>
      </div> 

</section>
