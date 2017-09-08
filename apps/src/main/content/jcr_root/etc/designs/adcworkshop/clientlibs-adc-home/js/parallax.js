$(document).ready(function(){
    /* init Jarallax */
    $('.jarallax').jarallax({
        speed: 0.5,
        imgWidth: 1366,
        imgHeight: 768
    });

    $('.parallex-ol').find('li').click(function(){
       var target = $(this).attr('data-target');
       // $('.parallex-ol').find('li').removeClass('active');
       $('.parallex-ol').find('li').removeClass('activeLi');

        //$(this).addClass('active');
       $(this).addClass('activeLi');

       $('#'+target).animatescroll({scrollSpeed:300});
          return false;
    });

    /*bind mouse event for parallax */
    /* commented below code - because it is causing mouse scroll issue over parallax */
    /*
    $('.parallex').bind('mousewheel', function(e){
        scrollParallax(e);
    });
    */

 function scrollParallax(e){
        $(".parallex").unbind("mousewheel", scrollParallax);
        var preventScroll = false;

        var ua = window.navigator.userAgent;
        var msie = ua.indexOf("MSIE ");
        var scrollDown=false;

        if (msie > 0 || ua.indexOf("rv:11") ) {
          if(e.deltaY <0) scrollDown = true;
        }
        else
        {
          if(e.originalEvent.wheelDelta < 0) scrollDown=true;
        }
        if(scrollDown) {
            var activeParallax = $('.parallex-ol').find('li.activeLi').attr('data-target');
            var nextParallax = $('#'+activeParallax).next();
            if($(nextParallax).hasClass('jarallax')) {
                $(nextParallax).animatescroll();
                preventScroll= true;
            }
          }
        else{
            var activeParallax = $('.parallex-ol').find('li.activeLi').attr('data-target');
            var prevParallax = $('#'+activeParallax).prev();
            if($(prevParallax).hasClass('jarallax')) {
                $(prevParallax).animatescroll();
                preventScroll= true ;
            }

           }
          $('.parallex').bind('mousewheel', scrollParallax);
           //prevent page fom scrolling
           if(preventScroll)
              return false;
    }

});





