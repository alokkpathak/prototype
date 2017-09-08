<%--
* Copyright (c)  Vorwerk POC
* Program Name :  account_menue.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Displays tabs under user profile.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 24-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>


<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<%@ page  import="java.util.*" %>

<%

    String[] multimenuelist = {"menuetext", "menueoption"};
pageContext.setAttribute("menuemultifields", multimenuelist);

%>
<adc:multicompositefield var="menueList" fieldNodeName="menuemulti" fieldPropertyNames="${menuemultifields}" returnType="List" />
<div class="container account-details padding-zero">


            <div id="details-selector" class="jumbotron hidden-md hidden-lg">
                 <h4 class="text-center topSpacing h4"><span id="leftPaneluserNameLabel" class="panelUserName"></span></h4>
                <div class="text-center">
                    <select class="selectpicker" name="accountView">
                        <c:forEach items="${menueList}" var="mlist">
                            <option value="${mlist.menueoption}">${mlist.menuetext}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="text-center">
                  <a href="#" id="personalLogOut" class="btn btn-lg button-black personalLogOut" role="button"><u>${properties.menuebuttontext}</u></a>
                </div>
            </div>
            <div class="side-menu col-lg-3 col-md-3 col-sm-12 left-nav-bar visible-md visible-lg">
                <div class="person">
                     <h4 class="text-center h4"><span id="leftPaneluserNameLabel" class="panelUserName"></span></h4>
                </div>
                <c:set var="idx" scope="request" value="${not empty param.idx ? param.idx : '0'}"/>
                <ul class="nav">
                    <c:forEach items="${menueList}" var="mlist" varStatus="i">
                        <c:choose>
                            <c:when test="${i.index eq idx}">
                                
                                <li><a id="${mlist.menueoption}_menu" name="${mlist.menueoption}" class="col-lg-12"><span class="accountMenu active col-lg-10 padding-zero text-right" tabindex="0">${mlist.menuetext}</span><img src="/content/dam/adc/fsl/images/global/en/btn-applying sensor-1.png" class="arrow-right col-lg-1" alt="${properties.imagealt}"></a></li>
                                
                            </c:when>
                            <c:otherwise>
                                
                                <li><a id="${mlist.menueoption}_menu" name="${mlist.menueoption}" class="col-lg-12"><span class="accountMenu col-lg-10 padding-zero text-right" tabindex="0">${mlist.menuetext}</span><img src="/content/dam/adc/fsl/images/global/en/btn-applying sensor-1.png" class="hidden arrow-right col-lg-1" alt="${properties.imagealt}"></a></li>
                            </c:otherwise> 
                        </c:choose>
                    </c:forEach>

                </ul>
                <div class="text-center">
                   <a href="#" id="personalLogOut" class="btn btn-lg button-black personalLogOut" role="button">${properties.menuebuttontext}</a>
                </div>
            </div>

</div>

<script>
	var username=readCookie('username');
	if(username=="" || username==null){
		window.location.replace($('#myaccount-url').val());
	}
</script>