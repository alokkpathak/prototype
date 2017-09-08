<%--
* Copyright (c)  Vorwerk POC
* Program Name :  footer.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Includes the Structure and Conditions to display the Content on the Footer.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 08-Jul-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>

<%String footerrootpath =currentPage.getAbsoluteParent(6).getPath();
%>
<c:choose>
    <c:when test="${ (not empty properties.templateType && properties.templateType eq 'checkoutTemplate') }">

<%

String checkoutfooterrBoilerPlateNodePath = "";

if(footerrootpath != null && !footerrootpath.equalsIgnoreCase("")){
    checkoutfooterrBoilerPlateNodePath = footerrootpath + "/utilities/boilerPlate/footers/checkoutFooter/jcr:content/par/checkOutFooter";
}
Resource checkoutFooterBoilerplateResource = resourceResolver.getResource(checkoutfooterrBoilerPlateNodePath);

if(checkoutFooterBoilerplateResource != null){ 
%>

<%slingRequest.setAttribute(ComponentContext.BYPASS_COMPONENT_HANDLING_ON_INCLUDE_ATTRIBUTE, true);%>
<sling:include resource="<%=checkoutFooterBoilerplateResource%>"/>        
<% slingRequest.removeAttribute(ComponentContext.BYPASS_COMPONENT_HANDLING_ON_INCLUDE_ATTRIBUTE);  %>
<% 
}%>    </c:when>
    <c:otherwise>
<!-- HEADER -->
<%

String globalfooterrBoilerPlateNodePath = "";

if(footerrootpath != null && !footerrootpath.equalsIgnoreCase("")){
    globalfooterrBoilerPlateNodePath = footerrootpath + "/utilities/boilerPlate/footers/globalfooter/jcr:content/par/footer_new";
}
Resource globalFooterBoilerplateResource = resourceResolver.getResource(globalfooterrBoilerPlateNodePath);

if(globalFooterBoilerplateResource != null){ 
%>

<%slingRequest.setAttribute(ComponentContext.BYPASS_COMPONENT_HANDLING_ON_INCLUDE_ATTRIBUTE, true);%>
<sling:include resource="<%=globalFooterBoilerplateResource%>"/>        
<% slingRequest.removeAttribute(ComponentContext.BYPASS_COMPONENT_HANDLING_ON_INCLUDE_ATTRIBUTE);  %>
<% 
}%>          
    </c:otherwise>
    
</c:choose>


