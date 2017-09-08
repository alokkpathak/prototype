<%--
* Copyright (c)  Vorwerk POC
* Program Name :  faq.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  To add questions and answers to specific categories.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 03-Sep-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<%@page pageEncoding="UTF-8"%>
<input type="hidden" id="faq-nodepath" value="${properties.faqpath}/jcr:content/contentPage/faq">
<input type="hidden" id="faq-url" value="/bin/adc/fsl/webshop/faqServlet">
<input type="hidden" id="faq-categoryname" value="${properties.categoryname}">
<input type="hidden" id="faq-error" value="${properties.ferror}">
<input type="hidden" id="faq-runMode" value="${runMode}">
<adc:minifyUrlTag  var="faqpublishpage" actualUrl="${properties.redirectpath}"/>
<input type="hidden" id="faqRedirectPageUrl" value="${faqpublishpage}">
<!--  Added the below line for loading in js dont delete below line -->
<input type="hidden" value="fCategory" id="fcategory">
<section id="defualt-questions" class="container preparing-skin text-left ">
    <h1><strong>Add FAQ</strong></h1> 
    <div class="row"> 
        <div class="col-xs-12" id="questionWrapper">

        </div>
        <div class="col-xs-12" style="margin-bottom:20px;">
            
            <button type="button" class="btn  btn-lg button-orange" id="btnAddQuestion" >Add </button>
            
            <button type="button" class="btn  btn-lg button-orange" onclick="createFaq()"id="btnSubmitQuestion" >Submit</button>
        </div>

        
    </div> 
</section>
