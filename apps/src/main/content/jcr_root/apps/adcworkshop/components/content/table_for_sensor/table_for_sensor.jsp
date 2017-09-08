 <%--
* Copyright (c)  Vorwerk POC
* Program Name :  table_for_sensor.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  For displaying table content.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 18-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<%

    String[] multirowlist = {"row1", "row2","row3","rowsp"};


pageContext.setAttribute("rowmultilist", multirowlist);

%>

<script>

    $(document).ready(function(){
var collapsePanel = $('.sensor-panel').find('.panel-default');
      for(var i=0;i<collapsePanel.length;i++){
         var current=collapsePanel[i];
         var id="collapse_"+i;
          $(current).attr('aria-labelledby','Panel_'+i);
         $(current).find('.panel-title').attr('href','#'+id);
         $(current).find('.panel-title').attr('aria-controls',id);
         var spanArrow =  $(collapsePanel[i]).find('.glyphicon');
          $(spanArrow).attr('href','#'+id);
          $(spanArrow).attr('aria-controls',id);
          var collapseContent =$(current).find('.panel-collapse');
           $(collapseContent).attr('id',id);
          $(collapseContent).attr('aria-controls',id);
      }
});

</script>


<adc:multicompositefield var="rowList" fieldNodeName="multirows" fieldPropertyNames="${rowmultilist}" returnType="List" />
<section class="container preparing-skin">
<div class="sensor-panel">

    <div class="panel panel-default">                    
    <div class="panel-heading text-center" role="tab" id="headingOne">
        <div class="row">
            <div class="col-xs-12">
                <div class="col-md-12 col-xs-12"> 
                    <a class="panel-title" data-toggle="collapse" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo"><span class="pnl-title">${properties.headingoftable}</span></a>
                <span class="glyphicon glyphicon-menu-down pull-right" data-toggle="collapse" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo"></span>
                </div>
            </div>
        </div>
    </div>
<div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
        <div class="panel-body col-md-offset-1 col-md-10">
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th width="25%">${properties.header1}</th>
                        <th>${properties.header2}</th>
                        <th>${properties.header3}</th>                
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items ="${rowList}" var="rlist" varStatus="i" >

                        <c:choose>
                            <c:when test = "${rlist.rowsp gt '1' }" >
                        <tr>
                            <td rowspan="${rlist.rowsp}"> ${rlist.row1}</td>
                             <td>${rlist.row2} </td>       
                            <td>${rlist.row3}</td>     
                        </tr>
                            </c:when>

				<c:when test = "${rlist.rowsp eq '1' }" >
                        <tr>
							<td> ${rlist.row1}</td>
                            <td> ${rlist.row2}</td>
                            <td>${rlist.row3}</td>
                        </tr>
                                </c:when>

                            <c:otherwise>
							<tr>

                            <td> ${rlist.row2}</td>
                            <td>${rlist.row3}</td>
                        </tr>
                            </c:otherwise>
                        </c:choose>

                    </c:forEach>
                    
                </tbody>
            </table>
        </div>
    </div>
    </div>
    </div>
	
</section>