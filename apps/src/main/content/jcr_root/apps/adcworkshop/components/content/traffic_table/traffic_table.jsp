<%--
* Copyright (c)  Vorwerk POC
* Program Name :  traffic_table.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  This component describes the risk involved in readings obtained in the reader and what action to be performed based on the readings.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 16-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp" %>
<%@page session="false" %>
<%

    String[] multirowlist = {"image","row1", "row2","row3","imagealt","imgMobile"};
	pageContext.setAttribute("rowmultilist", multirowlist);

%>

<adc:multicompositefield var="rowList" fieldNodeName="multirows" fieldPropertyNames="${rowmultilist}" returnType="List" />

<section class="prod-spec-table container uym">
  <div class="col-md-offset-1 col-md-10">                    
    <table class="table table-bordered">
      <thead>
        <tr>
            <th>${properties.heading1}</th>
            <th>${properties.heading2}</th>
            <th>${properties.heading3}</th>
        </tr>
      </thead>
      <tbody>
       <c:forEach items ="${rowList}" var="rlist" varStatus="i" >
        <tr>
          <td><img src="${rlist.image}" alt="${rlist.imagealt}" class="imgSwap" desk-img="${rlist.image}" mob-img="${rlist.imgMobile}" > ${rlist.row1}</td>
          <td>${rlist.row2}</td>
          <td>${rlist.row3}</td> 
        </tr> 
          </c:forEach>
      </tbody>
    </table>
  </div>
</section>