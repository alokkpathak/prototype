<%--
* Copyright (c)  Vorwerk POC
* Program Name :  rte.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  rte component will be used to include text editors in multiple sections.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 08-Jul-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>
<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>

<c:set var="text" value="${properties.centertext}"/>
<c:choose>
    <c:when test="${not empty text}">
        
        <section class="container-fluid " style="background-color:#${properties.rteBgColor}">
            <div class="about">
                <div class="row">
                    <div class="col-md-8 col-md-offset-2 text-center banner-margin-registration">
                        ${text}
                    </div>
                    
                </div>
            </div>
        </section>
        
    </c:when>
    <c:otherwise>
        <c:if test="${(globalWCMMode eq 'EDIT') || (globalWCMMode eq 'DESIGN')}">
            <c:out value="Edit the Rte omponent"></c:out>
        </c:if>
    </c:otherwise>
</c:choose>

<c:set var="text" value=""/>

