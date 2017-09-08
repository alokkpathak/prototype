<%--
* Copyright (c)  Vorwerk POC
* Program Name :  initload.jsp
* Application  :  Vorwerk Freestykelibre
* Purpose      :  See description
* Description  :  Initializes the header and footer properties
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
*  03-Mar-2016                  Cognizant Technology solutions                                 Initial Creation
*-----------                           ----------------                                      -------------------------
--%>
<%@include file="/apps/adcworkshop/components/shared/global.jsp" %>

<adc:osgiConfig var="myProp" pid="com.vorwerk.adc.workshop.core.util.GeoConfigFactory" property ="enablegeolocation"/>

<c:set var="flag" value="${myProp}"/>
<c:if test="${flag}">
<script>
    geoLocation();
    </script></c:if>