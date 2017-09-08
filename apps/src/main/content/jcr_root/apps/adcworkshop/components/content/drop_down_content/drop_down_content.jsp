<%--
    * Copyright (c)  Vorwerk POC
    * Program Name :  drop_down_content.jsp
    * Application  :  Vorwerk POC
    * Purpose      :  See description
    * Description  :  Drop down content is a component which describes the product features.
    * Modification History:
* ---------------------
    *    Date                                Modified by                                       Modification Description
    *-----------                            ----------------                                    -------------------------
    * 08-Jul-2016                  Cognizant Technology solutions            					Initial Creation
    *-----------                           -----------------                                    -------------------------
    --%>
    
    <%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%
    
    String[] textImageList = {"textpath", "imagepath","mobileimagepath"};
	pageContext.setAttribute("imagetext", textImageList);

%>
<adc:multicompositefield var="imageTextlist" fieldNodeName="softwaremulti" fieldPropertyNames="${imagetext}" returnType="List" />
<script>
    
    
    function hideandshowRichtextTabs(field){
        
        var d = field.findParentByType('tabpanel');	
        
        d.hideTabStripItem('howitworks'); 
        d.hideTabStripItem('specifications');
        d.hideTabStripItem('softwarepanel'); 
        d.hideTabStripItem('deliveryreturn');
        var dialog = field.findParentByType('dialog');	
        var drop = dialog.getField("./richtexttypeselector");
        var val = drop.getValue();
        
        if(val=='howitworks'){
            
            d.unhideTabStripItem('howitworks');
            d.hideTabStripItem('specifications');
            d.hideTabStripItem('softwarepanel');
            d.hideTabStripItem('deliveryreturn');
        }
        
        else if(val=='specifications'){
            d.hideTabStripItem('howitworks');
            d.unhideTabStripItem('specifications');
            d.hideTabStripItem('softwarepanel');
            d.hideTabStripItem('deliveryreturn');
        }
        else if(val=='softwarepanel'){
            d.hideTabStripItem('howitworks');
            d.hideTabStripItem('specifications');
            d.unhideTabStripItem('softwarepanel');
            d.hideTabStripItem('deliveryreturn'); 
        }
        else if(val=='deliveryreturn'){
            d.hideTabStripItem('howitworks');
            d.hideTabStripItem('specifications');
            d.hideTabStripItem('softwarepanel');
            d.unhideTabStripItem('deliveryreturn'); 
        }
    }
    
</script>




<section class="collapsable content container-fluid">
    <div class="row bg-white" id="prodMenuContent">
        <div class="col-md-12 padding-zero">
            
            <c:if test="${properties.richtexttypeselector eq 'howitworks'}" >
                <div id="product_1" class="collapse text-center">                    
                    <div class="prod-steps">        
                        ${properties.howitworkstext}
                        <a href="#product-view" class="btn btn-info close-product " role="button">${properties.howitworksbutton}</a>
                    </div>
                </div>
            </c:if>
            
            <c:if test="${properties.richtexttypeselector eq 'specifications'}" >
                <div id="product_2" class="collapse text-center">
                    <div class="prod-spec-table">
                        ${properties.specificationstext}
                    </div>
                    <a href="#product-view" class="btn btn-info close-product" role="button">${properties.specificationsclosebutton}</a> 
                </div>
            </c:if> 
            <c:if test="${properties.richtexttypeselector eq 'softwarepanel'}" >
                <div id="product_3" class="collapse text-center">
                    <div class="prod-steps">
                        ${properties.softwaretext}
                        <c:forEach items="${imageTextlist}" var="itlist"> 
                            <img src="${itlist.imagepath}" alt="" class="imgSwap" desk-img="${itlist.imagepath}" mob-img="${itlist.mobileimagepath}" ><br>
                            <span class="text-orange textupper ">${itlist.textpath}</span><br>
                        </c:forEach> 
                        ${properties.softwaretext1}
                    </div>
                    <div class="text-center">
                        <a href="${properties.downloadforpcurl}" class="btn btn-lg doenloadPc"  role="button" id="forpc" style="background-color: #E4572D;margin-bottom:0px;color:white;padding-left: 35px;
padding-right: 35px;">${properties.downloadforpc}</a>
                    </div>
                    <div class="text-center">
                        <a href="${properties.downloadformacurl}" class="btn btn-lg"  role="button" style="background-color: #E4572D;color:white;">${properties.downloadformac}</a>
                    </div>
                    <a href="#product-view" class="btn btn-info close-product closeSoftware" role="button" style="padding-left:41px;padding-right: 41px;">${properties.softclosebutton}</a>
                </div>
            </c:if>
            <c:if test="${properties.richtexttypeselector eq 'deliveryreturn'}" >
                <div id="product_4" class="collapse text-center">
                    <div class="prod-steps">
                        ${properties.deliveryreturntext}
                        <a href="#product-view" class="btn btn-info close-product " role="button">${properties.deliveryreturnbutton}</a>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</section>
