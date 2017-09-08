<%--
* Copyright (c)  Vorwerk POC
* Program Name :  faqCategories.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Displays a list of faq Categories.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 03-September-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp" %>
<%@page session="false" %>
<%@ page  import="java.util.*" %>

<%
String[] multipleCategories={"categoryname","categorypropertyname","storagepath"};
String[] multipleCategories1={"categoryname1","categorypropertyname1","storagepath1"};
String[] multipleCategories2={"categoryname2","categorypropertyname2","storagepath2"};
pageContext.setAttribute("faqcategories", multipleCategories);
pageContext.setAttribute("faqcategories1", multipleCategories1);
pageContext.setAttribute("faqcategories2", multipleCategories2);
%>

<cq:includeClientLib js="granite.csrf.standalone"/>
<adc:multicompositefield var="faqcategoriesList" fieldNodeName="faqcolumn1" fieldPropertyNames="${faqcategories}" returnType="List" />
<adc:multicompositefield var="faqcategoriesList1" fieldNodeName="faqcolumn2" fieldPropertyNames="${faqcategories1}" returnType="List" />
<adc:multicompositefield var="faqcategoriesList2" fieldNodeName="faqcolumn3" fieldPropertyNames="${faqcategories2}" returnType="List" />
<c:set var="faqcatList1" value="${faqcategoriesList}"/>
<input type="hidden" value="fCategory" id="fcategory">
<input type="hidden" id="faq-category-url" value="/bin/adc/fsl/webshop/faqServlet">
<input type="hidden" value="${properties.nodata}" id="nodata">
<input type="hidden" value="${properties.moredata}" id="moredata">
<input type="hidden" value="${properties.lessdata}" id="lessdata">
<input type="hidden" value="${properties.dprop}" id="dprop">
<input type="hidden" value="${properties.dpage}/jcr:content/contentPage/faq" id="dpage">
<input type="hidden" value="${properties.toptext}" id="toptext">
<input type="hidden" value="${properties.questionstext}" id="questionstext">
<input type="hidden" value="${properties.tenquestion}" id="tenQuestions">
<section class="about " style="background-color:#F4F2F4;" > 
    <div class="container-fluid">
        <div class="col-md-8 col-md-offset-2 col-xs-12 about-heading text-center">
            ${properties.headingrtext}
            <div class="row col-md-12  text-left faq-links">
                <div class="col-md-4 col-xs-12">
                    <ul class="faq-list">
                        <c:forEach items="${faqcategoriesList}" var="column1" varStatus ="i">
                            
                            <li><span class="sr-only">${properties.accesstext}</span><a href="#column1_${i.count}" name="product-faq" id="column1_${i.count}" class="faqscategories">

                               ${column1.categoryname} </a>
                            </li>
                            <input type="hidden" value="${column1.categorypropertyname}" id="column1_${i.count}_prop">
                            <input type="hidden" value="${column1.storagepath}/jcr:content/contentPage/faq" id="column1_${i.count}_page">
                        </c:forEach>
                    </ul>
                </div> 
                <div class="col-md-4 col-xs-12">
                    <ul class="faq-list">
                        <c:forEach items="${faqcategoriesList1}" var="column2" varStatus ="i">
                            <li><span class="sr-only">${properties.accesstext}</span><a href="#column2_${i.count}"  name="product-faq1" id="column2_${i.count}" class="faqscategories">
                                ${column2.categoryname1} </a></li>
                            <input type="hidden" value="${column2.categorypropertyname1}" id="column2_${i.count}_prop">
                            <input type="hidden" value="${column2.storagepath1}/jcr:content/contentPage/faq" id="column2_${i.count}_page">
                        </c:forEach>
                    </ul>
                </div>
                <div class="col-md-4 col-xs-12">
                    <ul class="faq-list">
                        <c:forEach items="${faqcategoriesList2}" var="column3" varStatus ="i">
                            <li><span class="sr-only">${properties.accesstext}</span><a href="#column3_${i.count}"  name="product-faq2" id="column3_${i.count}" class="faqscategories">
                                ${column3.categoryname2} </a></li>
                            <input type="hidden" value="${column3.categorypropertyname2}" id="column3_${i.count}_prop">
                            <input type="hidden" value="${column3.storagepath2}/jcr:content/contentPage/faq" id="column3_${i.count}_page">
                        </c:forEach>
                    </ul>
                </div>

            </div>                     
        </div>                
    </div>
</section> 
<section id="faq-place" class="container preparing-skin text-left ">
</section>
<div class="faqTablePlaceHolder"></div>





