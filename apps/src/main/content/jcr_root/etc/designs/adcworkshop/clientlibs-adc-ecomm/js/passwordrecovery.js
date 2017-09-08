$(window).load(function() {
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
	var token = getUrlVars()["token"];
	var profiledetailsValidateServiceUrl=$("#profiledetailsValidateServiceUrl").val();
	var profileValidate = {};
	profileValidate["customer_id"] = id;
	profileValidate["reset_password_token"] = token;
	if(id!=null){
		app.appGateway.ajaxPut(profiledetailsValidateServiceUrl, profileValidate, profiledetailsgetsuccessCallback_title_name, profiledetailsgeterrorCallback_title_name);
	}else{
		window.location.replace($('#unauthorizedurl').val());
	 }


	function profiledetailsgetsuccessCallback_title_name(data) {
		if (data.messages.allErrors != "") {
			$('.reset-recovery-container').hide();
			var errorCode = data.messages.error[0].code;
			if (errorCode == 4029) {
				$("#greeting-recovery-text").text(data.messages.error[0].message);
			}
		}else if(data.profileServiceResponse!=null){
			var successCode = data.profileServiceResponse.messages.success.code;
			if(successCode == 2042){
				var customer_name=data.profileServiceResponse.prefix+" "+data.profileServiceResponse.firstname+" "+data.profileServiceResponse.lastname;
				$("#cusName").html(customer_name);
			}
		}
	}
	function profiledetailsgeterrorCallback_title_name(e) {
	}
});