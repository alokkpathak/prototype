function createFaq()
{
	var faqUrl;
    var propertyName=$("#faq-categoryname").val();
    var loopcount=$(".loopcount").length;
    var nodePath=$("#faq-nodepath").val();
    var faqerror=$("#faq-error").val();
    var errorurl =$('#faqRedirectPageUrl').val();
    if((propertyName!="")&&(nodePath!="/jcr:content/contentPage/faq")){
        faqUrl=$("#faq-url").val();
	    var quesAns = {  faqQestionAnswers : []   };
        for(var i=0;i<=loopcount-1;i++)
        {

            quesAns.faqQestionAnswers.push({"question":$("#txtQuestion_"+i).val(),"answer":$("#txtAnswer_"+i).val(),"buttontxt":$("#txtButtontxt_"+i).val(),"buttonlink":$("#txtButtonlink_"+i).val()});

        }


    var jsonData=JSON.stringify(quesAns);
	var find = '%';
	var re = new RegExp(find, 'g');
	jsonData = jsonData.replace(re, '%25');
    var propertyName=$("#faq-categoryname").val();
    $.ajax({

        url : faqUrl,
        type : "POST",

        data : "jsondata="+jsonData+"&nodePath="+nodePath+"&propertyName="+propertyName+"&errorurl="+errorurl+"&requestType=FaqDetails",

        datatype : 'json',

        success : function(data)
        {

    }});
    }
else{
		 $('#defualt-questions').append(faqerror);
    }


}
