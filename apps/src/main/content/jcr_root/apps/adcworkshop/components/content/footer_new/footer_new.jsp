<%--
* Copyright (c)  Vorwerk POC
* Program Name :  footer_new.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  It is main footer component which has sitemap, social links, newsletter subscription and change country option and few other standalone page links.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 14-Jul-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="listroot" value="<%=properties.get("navpath",currentPage.getPath())%>"/>


<%
String[] footerLinksRow1 = {"linkTitle", "linkPath","newtabcheck","displayableLink1"};
String[] footerLinksRow2 = {"linkTitle2", "linkPath2","newtabcheckrow2","displayableLink2"};

pageContext.setAttribute("footerLinksBelowRow1", footerLinksRow1);
pageContext.setAttribute("footerLinksBelowRow2", footerLinksRow2);

%>


<adc:multicompositefield var="infoLinkList1" fieldNodeName="quickLinksBelowRow1" fieldPropertyNames="${footerLinksBelowRow1}" returnType="List" />
<adc:multicompositefield var="infoLinkList2" fieldNodeName="quickLinksBelowRow2" fieldPropertyNames="${footerLinksBelowRow2}" returnType="List" />
<adc:minifyUrlTag  var="myAccountLink" actualUrl="${properties.myAccountLink}"/>
<input type="hidden" name="overview" id="overview" value="${myAccountLink}">
<adc:minifyUrlTag  var="signinLink" actualUrl="${properties.signinpath}"/>
<input type="hidden" name="loginpage" id="loginpage" value="${signinLink}">
<c:set var="showCountryLink" value="${properties.displayChangeCountry}"></c:set>
	<footer class="container-fluid text-center" style="background-color:#2C2C2C;" id="footerid"> 
    <div class="footerContainer"  role="contentinfo">
        <div class="row hidden-xs hidden-sm">
            <a href="#" aria-label="scroll top" class="scrollToTop" style="display: inline;"><img src="${properties.buttonImagePath}" class="pull-right forme hidden-xs imgSwap" alt="${properties.imagealt}" desk-img="${properties.buttonImagePath}" mob-img="${properties.buttonImagePathMobile}"> </a>  
        </div>                   
        <div class="row footerMain">
            <div class="col-md-5 col-md-push-3 footer-center col-xs-12">
                <cq:include path="footer_newsletter" resourceType="/apps/adcworkshop/components/content/newletterforfooter"/>

                 <!--footer links-->
        <div class="footerLinks col-md-12 hidden-sm hidden-xs">
            
            <ul class="list-inline">
                <c:forEach items="${infoLinkList1}" var="list2" varStatus="status">
                    <c:set var="arrLength" value="${fn:length(infoLinkList1)}"/>
					<c:if test="${list2.displayableLink1 eq 'true'}">

                            <c:choose>
                                <c:when test="${list2.newtabcheck eq 'true'}">
                                    
                                    <li ><a id="footer_row1_${status.count}" href="${list2.linkPath}" class=" hidden-xs hidden-sm" target="_blank">${list2.linkTitle}</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li ><a id="footer_row1_${status.count}" href="${list2.linkPath}" class=" hidden-xs hidden-sm">${list2.linkTitle}</a></li>
                                </c:otherwise>
                            </c:choose>

                    </c:if>
                </c:forEach>
                
                
            </ul>
        </div>
    
    <!--End of footer links-->  
                
            </div>
            <div class="col-md-3 col-md-pull-5 footer-left col-xs-6">
                <div class="row">
                    <div class="col-md-12">
                        <%	
    
    Session session=resourceResolver.adaptTo(Session.class);
String parentPagePath=currentNode.hasProperty("sourcePath")?currentNode.getProperty("sourcePath").getString():"";
String title= null;
String showInFooterSitemap=null;
String path=null;
if(parentPagePath!=""){
    Node pathNode=session.getNode(parentPagePath);
    NodeIterator iteratorOne=pathNode.getNodes();
    int count1=1;

    while(iteratorOne.hasNext())
    {
        Node childNode=iteratorOne.nextNode();
        path=childNode.getPath();
        
        if(path!=null && childNode.hasNodes())
        {
            if(childNode.hasNode("jcr:content"))
            {
                Node subNode=childNode.getNode("jcr:content");
                title=subNode.hasProperty("jcr:title")?subNode.getProperty("jcr:title").getString():"";
                showInFooterSitemap=subNode.hasProperty("showInFooter")?subNode.getProperty("showInFooter").getString():"";
                if(showInFooterSitemap.trim().equals("yes"))
                {
                    if(path.endsWith("sign-in") || path.endsWith("registrati")|| path.endsWith("se-connecter")){

                    %>
                        <div class="col-md-6">
                            <ul class="list-unstyled text-left">  
                                <li><a id= "sitemap_<%=count1%>" class ="navigatepage" ><strong><%= title.toUpperCase()%></strong></a></li>
                            </ul>
                        </div>
                    <% 
					}else{

					%>
                        <div class="col-md-6">
                            <ul class="list-unstyled text-left">  
                                <li><a id= "sitemap_<%=count1%>" href="<%= path %>.html"><strong><%= title.toUpperCase()%></strong></a></li>
                            </ul>
                        </div>
					<%
					}
                    		count1++;

                }
            }
            NodeIterator iteratorTwo = childNode.getNodes();
            while(iteratorTwo.hasNext())
            {
                Node subChild=iteratorTwo.nextNode();
                path=subChild.getPath();
                if(subChild.hasNode("jcr:content"))
                {
                    Node subChildNode=subChild.getNode("jcr:content");
                    title=subChildNode.hasProperty("jcr:title")?subChildNode.getProperty("jcr:title").getString():"";
                    showInFooterSitemap=subChildNode.hasProperty("showInFooter")?subChildNode.getProperty("showInFooter").getString():"";
                    if(showInFooterSitemap.equals("yes"))
                    {
                    if(path.endsWith("sign-in") || path.endsWith("registrati")|| path.endsWith("se-connecter")){

                    %>
                        <div class="col-md-6">
                            <ul class="list-unstyled text-left">  
                                <li><a id= "sitemap_<%=count1%>" class='navigatepage' ><strong><%= title.toUpperCase()%></strong></a></li>
                            </ul>
                        </div>
                    <% 
					}else{
                    %>
                        <div class="col-md-6">
                            <ul class="list-unstyled text-left">  
                                <li><a id="sitemap_<%=count1%>"  href="<%= path %>.html"><strong><%= title.toUpperCase()%></strong></a></li>
                            </ul>
                        </div>
                    <% 
						}
							count1++;
							
					}
                }
            }
        }
    }
}


%>
                        
                    </div>
                </div>
                <!-- social network-->
            <c:set var="displaySocialLinks" value="${properties.displaySocialLinks}"></c:set>
            <c:if test="${displaySocialLinks eq 'Yes'}">
            <div class="col-md-12 socialNetwork hidden-sm hidden-xs">
                <span class=" col-md-5 text-orange">${properties.followText}</span>
                <div class="footer-images col-md-7">            
                    <a href="${properties.facebookLink}" target=_blank><img src="${properties.facebookImagePath}" alt="${properties.fbimagealt}" desk-img="${properties.facebookImagePath}" mob-img="${properties.facebookImagePathMobile}" class="imgSwap imgfb"></a>
                    <a href="${properties.twitterLink}" target=_blank><img src="${properties.twitterImagePath}" alt="${properties.twitterimagealt}" desk-img="${properties.twitterImagePath}" mob-img="${properties.twitterImagePathMobile}" class="imgSwap"></a>
					<a href="${properties.youtubeLink}" target=_blank><img src="${properties.youtubeImagePath}" alt="${properties.youtubeimagealt}" desk-img="${properties.youtubeImagePath}" mob-img="${properties.youtubeImagePathMobile}" class="imgSwap imgfb"></a> </div>
            </div>
			</c:if>
            </div>
            <div class="col-md-2 footer-right col-md-offset-1 hidden-xs hidden-sm">
                <div class="text-left">
                    <span>${properties.presentCountry}</span>
                </div>
				<c:if test="${showCountryLink eq 'true'}">
                <div class="text-left chngCountry">        
                    <a href="#myModal-country" title="${properties.changeCountry}" data-toggle="modal" role="dialog">${properties.changeCountry}</a>
                </div> 
				</c:if>
                <!-- vorwerk logo-->
            <div class="col-md-12 hidden-xs hidden-sm footerlogo">        
                <a href="${properties.logoLink}" target=_blank><img src="${properties.logoPath}" alt="${properties.logoimagealt}"></a>
            </div> 
            </div>
            <div class="col-md-2 footer-right col-md-offset-1 hidden-xs hidden-sm"></div>
            <div class="col-md-2 footer-right col-md-offset-1 hidden-xs hidden-sm"></div>          
	<!-- social network-->
            <c:set var="displaySocialLinks" value="${properties.displaySocialLinks}"></c:set>
            <c:if test="${displaySocialLinks eq 'Yes'}">
            <div class="socialNetwork visible-sm visible-xs">
                <span class="text-orange">${properties.followText}</span>
                <div class="footer-images">            
                    <a href="${properties.facebookLink}" target=_blank><img src="${properties.facebookImagePath}" alt="${properties.fbimagealt}" desk-img="${properties.facebookImagePath}" mob-img="${properties.facebookImagePathMobile}" class="imgSwap imgfb"></a>
                    <a href="${properties.twitterLink}" target=_blank><img src="${properties.twitterImagePath}" alt="${properties.twitterimagealt}" desk-img="${properties.twitterImagePath}" mob-img="${properties.twitterImagePathMobile}" class="imgSwap"></a>
					<a href="${properties.youtubeLink}" target=_blank><img src="${properties.youtubeImagePath}" alt="${properties.youtubeimagealt}" desk-img="${properties.youtubeImagePath}" mob-img="${properties.youtubeImagePathMobile}" class="imgSwap imgfb"></a>
                </div>
            </div>
            </c:if>

        </div> 
        <!-- change country site for mobile-->
        <div class="row visible-xs mob-chng-country visible-sm">
            <div class="col-xs-12">
                <div class="col-xs-12 text-center m-forme">
                    <a href="#" class="scrollToTop " style="display: inline;"><img src="${properties.buttonImagePath}" alt="${properties.imagealt}"></a>
                </div>
                <div class="col-xs-12 padding-zero">
                    
                    <span>${properties.presentCountry}
						<c:if test="${showCountryLink eq 'true'}">
							<a href="#myModal-country" title="${properties.changeCountry}"data-toggle="modal" role="dialog">${properties.changeCountry}</a>
						</c:if>	
					</span>
                    
                    
                </div>              
            </div>   
        </div>
    </div>     
          <!--footer links-->
        <div class="footerLinks col-xs-12 col-sm-12 visible-sm visible-xs">
            
            <ul class="list-inline">
                <c:forEach items="${infoLinkList1}" var="list2" varStatus="status">
                    <c:set var="arrLength" value="${fn:length(infoLinkList1)}"/>
					<c:if test="${list2.displayableLink1 eq 'true'}">

                            <c:choose>
                                <c:when test="${list2.newtabcheck eq 'true'}">
                                    
                                    <li ><a id="footer_row1_${status.count}" href="${list2.linkPath}"  target="_blank">${list2.linkTitle}</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li ><a id="footer_row1_${status.count}" href="${list2.linkPath}" >${list2.linkTitle}</a></li>
                                </c:otherwise>
                            </c:choose>

                    </c:if>
                </c:forEach>
            </ul>
        </div>
    
    <!--End of footer links--> 

    <!--vorwerk logo-->
    <div class="col-xs-12 visible-xs visible-sm">
        <div class="text-center m-logo">        
            <a href="${properties.logoLink}" target=_blank><img src="${properties.logoPath}" alt="${properties.logoimagealt}" desk-img="${properties.logoPath}" mob-img="${properties.logoPathMobile}" class="imgSwap img-responsive"></a>
        </div>
        <div class="footer-desc-text-mob">        
            <span>${properties.flegaltext}</span>
        </div>
    </div>
      <div class="col-md-offset-3 col-md-6 col-sm-12 col-xs-12 footerIT" >
        <p>${properties.footerSectionITone}</p>	
	</div>

    <div class="col-md-offset-1 col-md-10 col-sm-12 col-xs-12 footerITsecond">
		<p >${properties.footerSectionITtwo}</p>
		<div class="col-md-offset-3 col-md-6">
				<p>${properties.footerSectionITthree}</p>	
		</div>
    </div> 

</footer>
<cq:include path="cookiePolicyComp" resourceType="/apps/adcworkshop/components/content/cookie_alert_notice"/> 