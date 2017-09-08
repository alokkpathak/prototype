jQuery(function($) {

    readCookieAgree();

    function readCookieAgree()    {
        var cookieAgree =false;
        cookieAgree = readCookie("cookieAgree");

        if(cookieAgree){
            $('#cookie_directive_container').addClass('hidden');
        }else{
            $('#cookie_directive_container').removeClass('hidden');
        }
    }

    $("#cookie_accept .cookie-btn").click(function(){
		var cookieTimeout = new Date();
		cookieTimeout.setTime(cookieTimeout.getTime() + (14*24*60*60*1000));	
		addCookie('cookieAgree','true',cookieTimeout);
         $('#cookie_directive_container').addClass('hidden');
    });

});