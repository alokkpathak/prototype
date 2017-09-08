<%--
    * Copyright (c)  Vorwerk POC
    * Program Name :  relatedContentPanel.jsp
        * Application  :  Vorwerk POC
            * Purpose      :  See description
                * Description  :  Related content panel component is a two/three column block used across pages in website.
                    * Modification History:
* ---------------------
    *    Date                                Modified by                                       Modification Description
    *-----------                            ----------------                                    -------------------------
    * 19-Jul-2016                  Cognizant Technology solutions            					Initial Creation
    *-----------                           -----------------                                    -------------------------
    --%>
    <%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>


<script>
    
    function hideandshowTabs(field){
        var d = field.findParentByType('tabpanel');	
        d.hideTabStripItem('two_column'); 
        d.hideTabStripItem('three_column');
        var dialog = field.findParentByType('dialog');	
        var drop = dialog.getField("./assets");
        var val = drop.getValue();
        if(val=='two_column'){
            d.unhideTabStripItem('two_column');
            d.hideTabStripItem('three_column');		
        }
        else if(val=='three_column'){
            d.unhideTabStripItem('three_column');
            d.hideTabStripItem('two_column'); 
        }
    }
</script>

<!--Two Column-Orange Background-->
<c:if test="${properties.assets eq 'two_column'}">
    
    <section class="getinTouchWrapper text-center container-fluid">
        <div class="col-md-offset-1 col-md-11">
            <div class="row ">
                <div class="col-md-5 col-xs-12 bg-orange touchBlocks" style="background-color:#E4572D;">
                    <img src="${properties.imagePathColumn1}" class="bg-img imgSwap" alt="${properties.imagealtcolumn1}" desk-img="${properties.imagePathColumn1}" mob-img="${properties.imagePathColumn1Mobile}">
                    ${properties.bodyCopyColumnOne} 
                    <a id="inTouch" href="${properties.buttonPath}" class="btn btn-info btn-lg button-orange inTouchFaq" role="button">${properties.buttonName}</a>  
                </div>
                <div class="col-md-5 col-xs-12  bg-orange text-center touchBlocks" style="background-color:#E4572D;">
                   
			<img src="${properties.imagePathColumn2}" class="bg-img imgSwap" alt="${properties.imagealtcolumn2}" desk-img="${properties.imagePathColumn2}" mob-img="${properties.imagePathColumn2Mobile}">

                    ${properties.bodyCopyColumnTwo}
                </div>

            </div>
        </div>
    </section>
    
</c:if>


<!-- Three Column-Transperant Background -->
<c:if test="${properties.assets eq 'three_column_productPage'}">
    <section class="text-center">
        <div class="gs-row5 text-center padding-zero">
            <div class="col-md-12 apply-help padding-zero">
                
                <div class="col-md-4 text-center">
                    <div class="list-inline  bottom-text helpPanes" style="background: transparent;">
                       ${properties.productBodyCopy1}    
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="list-inline text-center bottom-text helpPanes" style="background: transparent;">
                        ${properties.productBodyCopy2}    
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="list-inline text-center bottom-text helpPanes" style="background: transparent;">
                        ${properties.productBodyCopy3}    
                    </div>
                </div>
            </div>    
            
        </div>
    </section>

</c:if>

<!-- Three Column-Gray Background -->
<c:if test="${properties.assets eq 'three_column_experienceit'}">
    <section class="container-fluid text-center">
        <div class=" container gs-row5 text-center">
		<div class="row">
            <div class="col-md-12 apply-help">
                <h3><strong> ${properties.headline}</strong></h3>
                <div class="col-md-4 text-center">
                    <div class="list-inline  bottom-text experiencePanes " style="background-color: #E1E1E1;">
                       ${properties.experienceItBodyCopy1}
                        <a id="buySupport" href="${properties.linkPath1}" class="btn btn-link "><img src="${properties.imagePath1}"  alt="" desk-img="${properties.imagePath1}" class="imgSwap" mob-img="${properties.mobileimagePath1}"><span class="link-txt ">${properties.linkTitle1}</span></a>
                    </div> 
                </div>
                <div class="col-md-4 ">
                    <div class="list-inline text-center bottom-text experiencePanes " style="background-color: #E1E1E1;">
                        ${properties.experienceItBodyCopy2}
                        <a id="buySupport2" href="${properties.linkPath2}" class="btn btn-link "><img src="${properties.imagePath2}"  alt="" desk-img="${properties.imagePath2}" class="imgSwap" mob-img="${properties.mobileimagePath2}"><span class="link-txt ">${properties.linkTitle2}</span></a>
                    </div>
                </div>
                <div class="col-md-4 ">
                    <div class="list-inline text-center bottom-text experiencePanes " style="background-color: #E1E1E1;">

                        ${properties.experienceItBodyCopy3}
                        <a id="buySupport3" href="${properties.linkPath3}" class="btn btn-link "><img src="${properties.imagePath3}"  alt="" desk-img="${properties.imagePath3}" class="imgSwap" mob-img="${properties.mobileimagePath3}"><span class="link-txt ">${properties.linkTitle3}</span></a>
                    </div>
                </div>
            </div>    
            </div>
        </div>
    </section>    
</c:if>