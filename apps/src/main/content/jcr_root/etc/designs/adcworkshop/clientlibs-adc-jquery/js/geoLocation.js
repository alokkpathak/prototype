function geoLocation (){
	function setCookie(cname, cvalue, exdays) {
        var d = new Date();
        d.setTime(d.getTime() + (exdays*24*60*60*1000));
        var expires = "expires=" + d.toGMTString();
		document.cookie = cname + "=" + cvalue + ";"+expires+";path=/";
    }

    function getCookie(cname) {
        var name = cname + "=";
        var ca = document.cookie.split(';');
        for(var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') {
                c = c.substring(1);
            }
            if (c.indexOf(name) == 0) {
                return c.substring(name.length, c.length);
            }
        }
        return "";
    }

    var firstVisit=getCookie("isFirstVisit");
    if(firstVisit=='' || firstVisit==null ){
        $.ajax({
            url: "/bin/adc/fsl/webshop/findmylocation",
            type: "GET",
            async:true,
        	success: function(fResult) {
				if(fResult == 'home'){
				   setCookie("isFirstVisit","No",1);
				}
				else{
				   setCookie("isFirstVisit","",1);
				}
				
				$(function(){ 
					if(fResult=='show-disclaimer'){
						// display overlay with disclaimer popup
						app.analytics.pushEvent('overlay', 'disclaimer overlay' ,'disclaimer popup' , 'load'); 
						$('#blockpageModal').modal('hide');
                        $('#monoccoBlockpageModal').modal('hide');
						$('#disclaimerModal').modal({ backdrop: 'static',keyboard: false });
					}
					else if(fResult=='show-block-page'){
						// display overlay with block page
						app.analytics.pushEvent('blockpage', 'blockpage overlay' ,'blockpage popup' , 'load');  
						$('#disclaimerModal').modal('hide');
                        $('#monoccoBlockpageModal').modal('hide');
						$('#blockpageModal').modal({ backdrop: 'static',keyboard: false });
					}
					else if(fResult=='show-mc-block-page'){
						// display overlay with mc block page
						app.analytics.pushEvent('blockpage', 'blockpage overlay' ,'blockpage popup' , 'load');   
						$('#disclaimerModal').modal('hide');
                        $('#blockpageModal').modal('hide');
						$('#monoccoBlockpageModal').modal({ backdrop: 'static',keyboard: false });
					}
				});
			},
			error: function(err) {
			}
		});
    }
}