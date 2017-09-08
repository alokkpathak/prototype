<%--
* Copyright (c)  Vorwerk POC
* Program Name :  downloadPdf.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  To download the available PDF's. 
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 11-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>


<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>

<%
    String [] vatDownloadPDFModal={"vatItalyModalDesc","vatItalyDownloadPDFButtonText","vatItalyPDFPath"};
	pageContext.setAttribute("vatDownloadPDFModal",vatDownloadPDFModal);
%>
 <adc:multicompositefield var="downloadPDF" fieldNodeName="vatDownloadPDF" fieldPropertyNames="${vatDownloadPDFModal}" returnType="List" />

<c:forEach items="${downloadPDF}" var="vatModalShow" varStatus="testCount">
    <div class="modal fade" id="downloadPdfMoadal${testCount.count}" tabindex="-1">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" aria-label="close" data-dismiss="modal">&times;</button>							         
                </div>
                
                <div class="modal-body">
                    ${vatModalShow.vatItalyModalDesc}
                </div>
                
                <div class="modal-footer">
                    <div class="text-center">
                        <a href=" ${vatModalShow.vatItalyPDFPath}" target="_new" class="btn-lg button-orange" role="button" style="background-color:#E4572D;" >${vatModalShow.vatItalyDownloadPDFButtonText}</a>
                    </div>
                </div>					        
            </div>						      
        </div>
    </div>
</c:forEach>