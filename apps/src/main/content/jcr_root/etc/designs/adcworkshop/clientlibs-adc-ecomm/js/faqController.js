$(window).on('load', function(){
if(( $('#fcategory').val() == 'fCategory') || ( $('#ecategory').val() == 'ecommerceCategory')) {
    var emptydata=$('#nodata').val();
	var  newTemp;var valueofclick=$('#tenQuestions').val();;
var top=$('#toptext').val();var questions=$('#questionstext').val();	


    function faqController(){
        this.init();
    };	

    faqController.prototype.init = function(){
        var self= this;
        var prevSelected= "defualt-questions";
         $("div.faq-links li a").click(function() {
            var selectedMenu = this.id;
            $("#"+prevSelected).removeClass("active");
            $("#"+selectedMenu).addClass("active");
            prevSelected = selectedMenu;
             $('html, body').animate({scrollTop : $('#faq-place').offset().top},1000);
   			 return false; 

        });

        var ques="";
        var ans="";
        var idVal;var idprop;var idpage;
        var categorypropVal=$('#ecommerce_prop,#dprop,#faq-categoryname').val();        
        var categorypageVal=$('#ecommerce_page,#dpage,#faq-nodepath').val();
        var faqCategoryUrl=$("#faq-category-url,#faq-url").val();
		if(categorypropVal!=""){
			self.faqFetch(faqCategoryUrl, categorypropVal, categorypageVal);
		}

        $(".faqscategories").click(function() {
            idVal ="#"+this.id;
            newTemp = idVal.replace(/"/g, '\'');
            valueofclick=$(idVal).html().trim().toUpperCase();
            idprop=idVal+"_prop";
            idpage=idVal+"_page";
            categorypropVal=$(idprop).val();
            categorypageVal=$(idpage).val();
		if((categorypageVal!="/jcr:content/contentPage/faq") && (categorypropVal!="")){
                self.faqFetch(faqCategoryUrl, categorypropVal, categorypageVal);
            }
            else{
                var emptydata=$('#nodata').val();
		$('#faq-place').html(emptydata);

            }

        });
        
    }
    

    faqController.prototype.faqFetch = function(faqCategoryUrl, categorypropVal, categorypageVal){
        $.ajax({
            
            url : faqCategoryUrl,
            type : "GET",
            
            data : "categorypropVal="+categorypropVal+"&categorypageVal="+categorypageVal+"&requestType=FaqCategoryDetails",
            
            datatype : 'json',
            
            success : function(data) 
            {
            faqController.prototype.faqHandler(data);
        },error: function(e){
        },done: function(done){
        }
        
    });


}

        


    faqController.prototype.faqHandler = function(data){
		 if (data === null){
         var emptydata=$('#nodata').val();
		$('#faq-place').html(emptydata);
    }
    else{
        var faqrunmode=$('#faq-runMode').val();
    	var faqpagenotfounderrorUrl=$('#faqRedirectPageUrl').val();
    	if(faqrunmode=="publish")
    	{
			window.location.replace(faqpagenotfounderrorUrl);
    	}
        function showQuestionPanelPreload(ques,ans,buttontxt,buttonurl){
            var questionCount= $('#questionWrapper').find('.question').length;
            if(questionCount==undefined){questionCount=0;}
            var html= 
                '<div class="loopcount question col-xs-12 padding-zero" id="question_'+questionCount+'"><div class="form-group col-xs-10 padding-zero"><label for="txtQuestion_'+questionCount+'">Question:</label><textarea class="form-control"  id="txtQuestion_'+questionCount+'"></textarea></div><div><div class="form-group col-xs-10 padding-zero"><label for="txtAnswer_'+questionCount+'">Answer:</label><textarea class="form-control" rows="8" id="txtAnswer_'+questionCount+'"></textarea></div><div class="form-group col-xs-10 padding-zero"><label for="txtButtontxt_'+questionCount+'">ButtonText:</label><textarea class="form-control" id="txtButtontxt_'+questionCount+'"></textarea></div><div class="form-group col-xs-10 padding-zero"><label for="txtButtonlink_'+questionCount+'">ButtonUrl:</label><textarea class="form-control" id="txtButtonlink_'+questionCount+'"></textarea></div><div class="col-xs-2 "><button type="button" class="btn  btn-lg button-orange" id="btnDelete" >Remove</button></div></div></div>';
            var quesid="#txtQuestion_"+questionCount;
            var ansid="#txtAnswer_"+questionCount;
            var buttonid="#txtButtontxt_"+questionCount;
            var buttonlinkid="#txtButtonlink_"+questionCount;
            
            $('#questionWrapper').append(html);
            $(quesid).val(ques);            
            $(ansid).val(ans);
             $(buttonid).val(buttontxt);            
            $(buttonlinkid).val(buttonurl);

        } 
		if(data.faqQestionAnswers!=null && data.faqQestionAnswers!=undefined){
			var jsonArraylength=data.faqQestionAnswers.length;       
			
			for(i=0;i<jsonArraylength;i++)
			{
				var ques=data.faqQestionAnswers[i].question;
				var ans=data.faqQestionAnswers[i].answer;
                var buttontxt=data.faqQestionAnswers[i].buttontxt;
				var buttonurl=data.faqQestionAnswers[i].buttonlink;
				showQuestionPanelPreload(ques,ans,buttontxt,buttonurl);
			}

		if ($('body').hasClass('product-basket')) {
			var template = Handlebars.templates['faq-template'];
		} else {
			var template = Handlebars.templates['faq-categories-template'];
		}
    var faqResponse = data;	

    if( $('#ecategory').val() == 'ecommerceCategory')
    {

        faqResponse.faqQestionAnswers = data.faqQestionAnswers.slice(0,5);
    }
	Handlebars.registerHelper('breaklines', function(text) {
    text = Handlebars.Utils.escapeExpression(text);
    text = text.replace(/(\r\n|\n|\r)/gm, '<br>');
    return new Handlebars.SafeString(text);
});    
    $('#faq-place').html(template(faqResponse)); 
	$('#topquestions').html(top+" "+valueofclick+" "+questions);	

    var showChar = 1000;
    var ellipsestext = "...";
	var moreData=$('#moredata,#ecommercemoredata').val();
    var lessData=$('#lessdata,#ecommercelessdata').val();
    var moretext = moreData;
    var lesstext = lessData;    
    $('.more').each(function() {
        var content = $(this).html();
        
        if(content.length > showChar) {
            var charCheck = 999;
            for(i=0;i<=4;i++){
                var contentAtLast = content.substr(charCheck,2);
                if(('<b'==contentAtLast)||('br'==contentAtLast)||('r>'==contentAtLast)||('><'==contentAtLast)){
                    charCheck += 1;
                    showChar += 1;
                }
            }
            var c = content.substr(0, showChar);
            var h = content.substr(showChar, content.length - showChar);            
            var html = c + '<span class="moreellipses">' + ellipsestext+ '&nbsp;</span><span class="morecontent">' + h +'</span><div class="moreSection"><a href="" class="btn morelink">' + moretext + '</a></div>';
            $(this).html(html);
        }

    });

    $(".morelink").click(function(){
        if($(this).hasClass("less")) {
            $(this).removeClass("less");
            $(this).html(moretext);
            $(".moreellipses").show();
            
        } else {
            $(this).addClass("less");
            $(this).html(lesstext);
            $(".moreellipses").hide();
        }
        $(this).parent().prev().toggle();
        $(this).prev().toggle();
        return false;
    });
    }
    $('.preparing-skin').find('.panel-collapse').on('hide.bs.collapse', function () {
        var arrowIcon = $(this).closest('.panel-default').find('.glyphicon');
        $(this).closest('.panel-default').find('.pnl-title').toggleClass('active');
        $(arrowIcon).removeClass('glyphicon-menu-down');
        $(arrowIcon).addClass('glyphicon-menu-right');
    });
    $('.preparing-skin').find('.panel-collapse').on('show.bs.collapse', function () {
        var questionTrim = $('.faqscategories.active').html(),		
          questionSection,		
            pageNavigation,		
        	questionLabel;		
        if(questionTrim == undefined){		
            questionSection="Top 10";		
        }else{		
            questionSection= $.trim(questionTrim);		
        }		
		 pageNavigation = $('.jp-current').html();
            if(pageNavigation == undefined){		
				pageNavigation= 1;		
            }		
		 questionLabel = $(this).closest('.panel-default').find('.pnl-title').html(); 		
		var arrowIcon = $(this).closest('.panel-default').find('.glyphicon');
        $(this).closest('.panel-default').find('.pnl-title').toggleClass('active');
        $(arrowIcon).removeClass('glyphicon-menu-right');
        $(arrowIcon).addClass('glyphicon-menu-down');
        app.analytics.pushEvent('Click','FAQ', questionSection, pageNavigation+'-'+questionLabel);
    });
    if(data.faqQestionAnswers!=null && data.faqQestionAnswers!=undefined){
    if(data.faqQestionAnswers.length>10){
       	 $('.faqTablePlaceHolder' ).removeClass('hidden');
         $("div.faqTablePlaceHolder").jPages({
          containerID : "faq-tableplace",
          first : "",
          previous : "", 
          next : "",
          last : "",  
          perPage : 10, 
          startRange: 1,
          delay : 20  
        });
        $(".jp-last").html(">>");
        $(".jp-first").html("<<");
        $(".jp-next").html(">");
        $(".jp-previous").html("<");
        
    }
        else{

		 $('.faqTablePlaceHolder' ).addClass('hidden');

        }
	}
	}

}

app.faqController = new faqController();
}

});