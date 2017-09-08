<%--
    * Copyright (c)  Vorwerk POC
    * Program Name :  subMenus.jsp
        * Application  :  Vorwerk POC
            * Purpose      :  See description
                * Description  :  Lists childpages of topmenu.
                    * Modification History:
* ---------------------
    *    Date                                Modified by                                       Modification Description
    *-----------                            ----------------                                    -------------------------
    * 08-Jul-2016                  Cognizant Technology solutions            					Initial Creation
    *-----------                           -----------------                                    -------------------------
    --%>
    
    
    <%@include file="/apps/adcworkshop/components/shared/global.jsp" %>
<%@page import="java.util.*"%>

<%
    //out.println("navcount>>"+request.getAttribute("navcount"));
    
    int count1 =(Integer)request.getAttribute("navcount")-1; 

String [] prodProp={"prodLabel","prodLink","prodImage","prodImageMobile","prodImageAlt"};
request.setAttribute("prodPropList",prodProp);

String [] packProp={"packLabel","packLink","packImage","packImageMobile","packImageAlt"};
request.setAttribute("packPropList",packProp);

String [] splOfferProp={"splOfferLabel","splOfferLink","splOfferImage","splOfferImageMobile"};
request.setAttribute("splOfferPropList",splOfferProp);


%>
<adc:multicompositefield var="prodPropList" fieldNodeName="prodConfig" fieldPropertyNames="${prodPropList}" returnType="List" />
<adc:multicompositefield var="packPropList" fieldNodeName="packConfig" fieldPropertyNames="${packPropList}" returnType="List" />
<adc:multicompositefield var="splOfferPropList" fieldNodeName="splOfferConfig" fieldPropertyNames="${splOfferPropList}" returnType="List" />

<c:set var="forEachCount" value="<%=count1%>"/>
<!--****** EXPERIENCE IT dropdown container ************-->



<c:choose>
    
    <c:when test="${properties.subMenuType eq 'generic'}">
        <div class="submenuContainer" role= "navigation">
            <div id="panel_${forEachCount}" class="submenu-panel prod-sub-panel prod-submenu-group">  

                    <ul class="nav nav-justified">

                        <%
    Session session = resourceResolver.adaptTo(Session.class);
String pageName="";
String parentNodePath=currentNode.hasProperty("pagePath")?currentNode.getProperty("pagePath").getString():"";
if(parentNodePath!="")
{
    String[] parentPagePathArray=parentNodePath.split("/");
    pageName=parentPagePathArray[parentPagePathArray.length-1];
}
Node parentNode=null;
Node childNode=null;
if(session.itemExists(parentNodePath))
{
    parentNode = session.getNode(parentNodePath);
}
if(parentNode != null)
{
    Node jcrContentNode = parentNode.getNode("jcr:content");
    NodeIterator itemIterator = parentNode.getNodes();
    int count=1;
    String analyticsid="";
    %><li class="submenuClick dropdown-content-generic">
   <%
    while(itemIterator.hasNext())
    {
        childNode = itemIterator.nextNode();
        
        if(!jcrContentNode.getPath().equals(childNode.getPath()))
        { 

            String childNodePath=childNode.getPath();
            Resource res = resourceResolver.getResource(childNodePath+"/jcr:content");
            ValueMap property = res.adaptTo(ValueMap.class);
            String childPageName = property.get("jcr:title", String.class);
            analyticsid=pageName+"_"+count;
            //if(childPageName.equals("Company Values"))
            //{

            %>



                            <a id="<%=analyticsid%>" href="<%=childNodePath%>.html"><%=childPageName%></a>

                        <%
                count++;

            }
    }%></li>
<%}
%>
                    </ul>


            </div>
        </div>
        
    </c:when>



    <c:when test="${properties.subMenuType eq 'products'}">

        <div class="submenuContainer" role= "navigation">
            <div id="panel_${forEachCount}" class="submenu-panel prod-sub-panel prod-submenu-group">   
                <ul class="nav nav-justified">
                    <c:if test="${fn:length(prodPropList)>0}">

									<li class="dropdown-content">
                                     <c:forEach items="${prodPropList}" var="prodList" varStatus="prod">
                                         <a href="${prodList.prodLink}">${prodList.prodLabel}</a>
                                    </c:forEach></li>


                    </c:if>

                </ul>

          </div>
        </div>

    </c:when>

    
</c:choose>
