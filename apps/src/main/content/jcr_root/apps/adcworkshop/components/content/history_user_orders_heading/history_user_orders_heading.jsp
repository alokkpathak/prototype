<%--
* Copyright (c)  Vorwerk POC
* Program Name :  history_user_orders_heading.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  To display history of user orders.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 18-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page import="java.util.Locale,java.util.ResourceBundle,com.day.cq.i18n.I18n"%>

<h4>
    
    ${properties.historytitle}</h4>


<p class="button-center col-lg-8 padding-zero">${properties.historyDescription} </p>


<div id="timeFrame" class="text-center col-lg-4">
    <c:set var="histroryduration" value="${properties.duration}" />
    <select name="timeFrame">
        <c:forEach items="${histroryduration}"  varStatus="durstatus">
            
            <option value="${durstatus.count}">${histroryduration[durstatus.index]}</option>
            
        </c:forEach>
    </select>
</div>

