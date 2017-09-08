<%--
* Copyright (c)  Vorwerk POC
* Program Name :  terms_and_conditions.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  For displaying terms and condition overlay across pages in website.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 16-Aug-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<script>

    function hideandshowRichtextTabs(field){

        var d = field.findParentByType('tabpanel');  

        d.hideTabStripItem('tcs'); 
        d.hideTabStripItem('privacypolicy');
        d.hideTabStripItem('acctcs');
        d.hideTabStripItem('regtcs');
        var dialog = field.findParentByType('dialog');              
        var drop = dialog.getField("./popselectrichtext");
        var val = drop.getValue();

        if(val=='tcs'){

            d.unhideTabStripItem('tcs');
            d.hideTabStripItem('privacypolicy');   
            d.hideTabStripItem('regtcs');
            d.hideTabStripItem('acctcs');
        }

        else if(val=='privacypolicy'){
            d.unhideTabStripItem('privacypolicy');
            d.hideTabStripItem('tcs'); 
            d.hideTabStripItem('regtcs');
             d.hideTabStripItem('acctcs');
        }
        else if(val=='regtcs'){
            d.unhideTabStripItem('regtcs');
            d.hideTabStripItem('tcs'); 
            d.hideTabStripItem('privacypolicy');
            d.hideTabStripItem('acctcs');
        }
        else if(val=='acctcs'){
            d.unhideTabStripItem('acctcs');
            d.hideTabStripItem('tcs'); 
            d.hideTabStripItem('privacypolicy');
            d.hideTabStripItem('regtcs');
        }
    }



</script>




<c:if test="${properties.popselectrichtext eq 'tcs'}">
    <section class="testimonial">
        <div id="myModal-terms" class="modal fade" tabindex="-1">
            <div class="modal-dialog ">
                <div class="modal-content">
                    <div class="modal-header padding-zero">
                        <button type="button" class="close" aria-label="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <h4 class="modal-title">${properties.tcheadline}</h4>
                        ${properties.tctext}
                    </div>
                    
                    
                    
                </div>
                
            </div>
            
        </div>
        
    </section>
</c:if> 
<c:if test="${properties.popselectrichtext eq 'regtcs'}">
    
    <section class="testimonial">
        
        <div id="myModal-registration" class="modal fade">
            <div class="modal-dialog ">
                <div class="modal-content">
                    <div class="modal-header padding-zero">
                        <button type="button" class="close" aria-label="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <h4 class="modal-title">${properties.rheadline}</h4>
                        ${properties.rtext}
                    </div>
                    
                    
                    
                </div>
                
            </div>
            
        </div>
        
        
        
    </section>
</c:if> 
<c:if test="${properties.popselectrichtext eq 'acctcs'}">
    <section class="testimonial">
        
        <div id="myModal-account" class="modal fade">
            <div class="modal-dialog ">
                <div class="modal-content">
                    <div class="modal-header padding-zero">
                        <button type="button" class="close" aria-label="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">${properties.aheadline}</h4>
                    </div>
                    <div class="modal-body" style="height:250px;overflow-y: auto;">
                        <div id="before-submit">
                            ${properties.atext}
                        </div>
                        
                    </div>
                    
                </div>
            </div>
        </div>
        
        
    </section>
</c:if> 

<c:if test="${properties.popselectrichtext eq 'privacypolicy'}">
    <section class="testimonial">
        
        <div id="myModal-privacy" class="modal fade">
            <div class="modal-dialog ">
                <div class="modal-content">
                    <div class="modal-header padding-zero">
                        <button type="button" class="close" aria-label="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">${properties.ppheadline}</h4>
                    </div>
                    <div class="modal-body">
                        <div id="before-submit">
                            ${properties.pptext}
                        </div>

                    </div>
                    
                </div>
            </div>
        </div>
        
        
    </section>
</c:if> 