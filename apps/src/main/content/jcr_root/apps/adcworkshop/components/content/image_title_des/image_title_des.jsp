<%--
* Copyright (c)  Vorwerk POC
* Program Name :  image_title_des.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Displays text and image with detailed description.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 26-Jul-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %> 
<c:set var="listroot" value="<%=properties.get("navpath",currentPage.getPath())%>"/>

<%
                String[] multiProp1 = {"lefttitlename1", "leftdesname1", "leftimagename1","leftimagealt1","leftimagename1Mobile"};
				String[] multiProp2 = {"righttitlename2", "rightdesname2", "rightimagename2","rightimagealt2","rightimagename2Mobile"};
                pageContext.setAttribute("multiFieldSet1", multiProp1);
				pageContext.setAttribute("multiFieldSet2", multiProp2);
%>

    <adc:multicompositefield var="leftradiobuttonList" fieldNodeName="leftmulti" fieldPropertyNames="${multiFieldSet1}" returnType="List" />
	<adc:multicompositefield var="rightradiobuttonList" fieldNodeName="rightmulti" fieldPropertyNames="${multiFieldSet2}" returnType="List" />

 <section class="care-block container-fluid" style="background:#FFC11B;">
    <div class="row text-center">
      <div class="col-md-offset-1 col-md-10">
        ${properties.ptitle}
          <div class="col-md-6 applysensorTop">
		   <c:forEach items="${leftradiobuttonList}" var="list" varStatus="i">
              <div class="media">
                <div class="media-left">
                  <img src="${list.leftimagename1}" alt="${list.leftimagealt1}" desk-img="${list.leftimagename1}" mob-img="${list.leftimagename1Mobile}" class="imgSwap" />                
                </div>
                <div class="media-body text-left">
                  <h4>${list.lefttitlename1}</h4>
                  <p>${list.leftdesname1}</p>
                </div>
              </div>
			  </c:forEach>

            </div>
			
            <div class="col-md-6 applysensorTop">
			 <c:forEach items="${rightradiobuttonList}" var="list" varStatus="i">
              <div class="media">
                <div class="media-left">
                  <img src="${list.rightimagename2}" alt="${list.rightimagealt2}" desk-img="${list.rightimagename2}" mob-img="${list.rightimagename2Mobile}" class="imgSwap"/>                
                </div>
                <div class="media-body text-left">
                 <h4>${list.righttitlename2}</h4>
                  <p>${list.rightdesname2}</p>
				</div>
              </div>
			    </c:forEach>

            </div>
      </div>
    </div>

  </section>
