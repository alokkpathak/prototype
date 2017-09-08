<%--
* Copyright (c)  Vorwerk POC
* Program Name :  faqs.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  To fetch ecommerce frequently asked questions and answers.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 03-September-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp" %>
<%@page session="false" %>

<input type="hidden" id="faq-category-url" value="/bin/adc/fsl/webshop/faqServlet">
<input type="hidden" value="${properties.ecommercepropertyname}" id="ecommerce_prop">
<input type="hidden" value="${properties.ecommercepagepath}/jcr:content/contentPage/faq" id="ecommerce_page">
<input type="hidden" value="ecommerceCategory" id="ecategory">
<input type="hidden" value="${properties.ecommercenodata}" id="nodata">
<input type="hidden" value="${properties.moredata}" id="ecommercemoredata">
<input type="hidden" value="${properties.lessdata}" id="ecommercelessdata">
<h2><strong>${properties.topquestions}</strong></h2>
<section id="faq-place" class="preparing-skin text-left clearfix">
</section>
<section class="preparing-skin text-left see-all-faqs col-xs-12 col-sm-11">       
        <a href="${properties.allfaqslink}.html"  class="pull-right" aria-controls="see all">${properties.allfaqstext}</a>
</section>


    





