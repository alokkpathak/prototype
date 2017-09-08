$(window).load(function() {

	var cookieTimeout = new Date();
	var minutes = 30;
	cookieTimeout.setTime(cookieTimeout.getTime() + (minutes * 60 * 1000));

	function getUrlVars()
	{
		var vars = [], hash;
		var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
		for(var i = 0; i < hashes.length; i++)
		{
			hash = hashes[i].split('=');
			vars.push(hash[0]);
			vars[hash[0]] = hash[1];

		}
		return vars;
	}
	var id=getUrlVars()["id"];
	var confirmaccounturl = $("#confirmaccounturl").attr('value');
	var credential = {};
	credential["customer_id"] = getUrlVars()["id"];
	credential["account_confirm_token"]=getUrlVars()["key"];
	$.when(
		app.appGateway.ajaxPut(confirmaccounturl,credential,successCallback_confirmAccount,errorCallback_confirmAccount)
	).done(function(ajaxResponse){
	});

    function successCallback_confirmAccount(data){
        if(data.messages.allErrors==""){
			var successCode = data.messages.success.code;
			if(successCode ==2036){
				$('#activate').removeClass("hidden");
				profiledetailsgetsuccessCallback_title_name(data.profileServiceResponse);
				/*profiledetailsServiceUrl=$("#profiledetailsServiceUrl").val();
				profiledetailsServiceUrl=profiledetailsServiceUrl+"/"+id;

				if(id!=null&&id!=undefined){
					app.appGateway.ajaxGet(profiledetailsServiceUrl,profiledetailsgetsuccessCallback_title_name,profiledetailsgeterrorCallback_title_name);
				}*/
			}
		}else{
            var errorCode = data.messages.error[0].code;
            if(errorCode==4039){
                $("#4039").removeClass("hidden");
				window.location.replace($('#signinregister').val());
            }
            else if(errorCode==4040){
                $("#4040").removeClass("hidden");
                window.location.replace($('#unauthorizedurl_account').val());
            }
            else if(errorCode==4041){
                $("#4041").removeClass("hidden");
				window.location.replace($('#signinregister').val());

            }
        }
    }
    function errorCallback_confirmAccount(e){
        $('#activatefail').removeClass("hidden");
    }



	function profiledetailsgetsuccessCallback_title_name(data) {
        var successCode = data.messages.success.code;
          if(data.messages.allErrors == "")
            {
                var json = "<font size='2' color='blue'>"+ data.messages.success.message + "</font>";
                $('#feedback').html(json);
                if(data.productCount != null)
                {
                  	$('.basketitems').text(data.productCount);
					addCookie('productCount', data.productCount,cookieTimeout);
                }
                if(data.firstname != null)
                {
					addCookie('userid',data.customer_id,cookieTimeout);
					if(data.prefix!=null){
						customerLogin(data.prefix + " " + data.firstname + " " + data.lastname , data.qtyExceeded);
					}
					else{
						customerLogin(data.firstname + " " + data.lastname , data.qtyExceeded);
					}

					app.analytics.pushEvent("login", "login", "direct login", "success");
                }
            }
            else
            {
                var errorCode = data.messages.error[0].code;
				app.analytics.pushEvent("login", "login", "direct login", "failure");
            }
	}
     function customerLogin(username, qtyExceeded){
			addCookie('username', username,cookieTimeout);
            if (readCookie('guestUserCookie') == null || readCookie('guestUserCookie') == ''){
                window.location.replace($("#signInPageURL").val());
            }

        }
	function profiledetailsgeterrorCallback_title_name(e) {
	}
});