
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

	var customerloginurl = $("#customerloginurl").attr('value');
	var credential = {};
	credential["login_token"]=getUrlVars()["token"];
	$.when(
		app.appGateway.ajaxPost(customerloginurl,credential,successCallback_customerLogin,errorCallback_customerLogin)
	).done(function(ajaxResponse){
	});

    function successCallback_customerLogin(data){
		if(data.messages.allErrors==""){
			var successCode = data.messages.success.code;
			if(successCode ==2042){
				$('#customerloginsuccess').removeClass("hidden");
				profiledetailsgetsuccessCallback_title_name(data.profileServiceResponse);
				/*profiledetailsServiceUrl=$("#profiledetailsServiceUrl").val();
				if(data.entity_id!=null){
					profiledetailsServiceUrl=profiledetailsServiceUrl+"/"+data.entity_id;
					app.appGateway.ajaxGet(profiledetailsServiceUrl,profiledetailsgetsuccessCallback_title_name,profiledetailsgeterrorCallback_title_name);
				}*/
			}
		}else{
            var errorCode = data.messages.error[0].code;
            if(errorCode==4060){
                $("#4060").removeClass("hidden");
                window.location.replace($("#unauthorizedurl_mbo").val());
            }
            else if(errorCode==4039){
                $("#4039").removeClass("hidden");
            }
            else if(errorCode==4040){
                $("#4040").removeClass("hidden");
                window.location.replace($('#unauthorizedurl_mbo').val());
            }
            else if(errorCode==4041){
                $("#4041").removeClass("hidden");
                window.location.replace($('#unauthorizedurl_mbo').val());
            }
        }
    }
    function errorCallback_customerLogin(e){
        $('#customerloginfailed').removeClass("hidden");
    }



	function profiledetailsgetsuccessCallback_title_name(data) {
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