<%--
* Copyright (c)  Vorwerk POC
* Program Name :  customRichtext.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Creates richtext with different styles.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 26-July-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<%@ page  import="java.util.*" %>

<%
    String[] multibuttonlist = {"buttontext", "buttonpath", "newtab","typeOfButton"};
pageContext.setAttribute("buttonmultifields", multibuttonlist);

%>

<adc:multicompositefield var="buttonList" fieldNodeName="buttonmulti" fieldPropertyNames="${buttonmultifields}" returnType="List" />
<script>


    function hideandshowRichtextTabs(field){

        var d = field.findParentByType('tabpanel');  

        d.hideTabStripItem('buttonrichtext'); 
        d.hideTabStripItem('plainrichtext');
        var dialog = field.findParentByType('dialog');              
        var drop = dialog.getField("./selectrichtext");
        var val = drop.getValue();

        if(val=='buttonrichtext'){

            d.unhideTabStripItem('buttonrichtext');
            d.hideTabStripItem('plainrichtext');                             
        }
        
        else if(val=='plainrichtext'){
            d.unhideTabStripItem('plainrichtext');
            d.hideTabStripItem('buttonrichtext'); 
        }
    }
    


</script>


<c:if test="${properties.selectrichtext eq 'plainrichtext'}">



<c:set var="text" value="${properties.plaintext}"/>
<c:choose>
    <c:when test="${not empty text}">

        <section class="about" style="background-color:#${properties.backgndcolor}">
            <div class="container-fluid">
                <div class="row">
                    <div class="text-center col-md-8 col-md-offset-2">
                        ${text}
                        <c:if test="${fn:length(properties.image) != 0}">
						<img src="${properties.image}"  class="imgyourdata imgSwap img-responsive" alt="${properties.imageAlt}" desk-img="${properties.image}" mob-img="${properties.imageMobile}"/> 
                        </c:if>                            
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

</c:if> 

<c:if test="${properties.selectrichtext eq 'buttonrichtext'}">


    <section class="about  text-center">

    <div class="container">
      <div class="row">
        <div class="col-md-8 col-md-offset-2">
            ${properties.textfield}
        </div>
		<c:forEach items="${buttonList}" var="blist">
		<c:set var="modal" value="${blist.typeOfButton}"></c:set>
        <c:set var="noButton" value="${blist.typeOfButton}"></c:set>
        <c:set var="button" value="${blist.typeOfButton}"></c:set>
          </c:forEach>
		<c:choose>
		<c:when test="${button eq 'button'}">
        <c:forEach items="${buttonList}" var="blist">
            <c:if test="${blist.newtab eq 'true'}">
				<a href="${blist.buttonpath}" class="btn btn-lg button-orange " target="_blank" role="button" style="background-color:#E4572D;">${blist.buttontext}</a>
			</c:if>
            <c:if test="${blist.newtab eq 'false'}">
               <a href="${blist.buttonpath}" class="btn btn-lg button-orange " role="button" style="background-color:#E4572D;">${blist.buttontext}</a>
            </c:if>
		</c:forEach>
		</c:when>
		<c:when test="${modal eq 'modal'}">
			<c:forEach items="${buttonList}" var="blist">
              <a class="btn btn-lg button-orange " href="#myModal-download" data-toggle="modal" style="background-color:#E4572D;">${blist.buttontext}</a>
			</c:forEach>
        </c:when>
		</c:choose>
      </div>
    </div>

    </section>

</c:if>

