$(window).on('load', function(){
	if($('body').hasClass('Thankyoupage')){
		var isCustURL = $("#isCustUrl").attr('value');
		if (isCustURL != null) {
			app.appGateway.ajaxGet(isCustURL, checkoutConfSuccessCallback, checkoutConfErrorCallback);
		}
	}
});

var errorPageURL=$('#errorpage-url').val();

function checkoutConfSuccessCallback(data) {
	if (data) {
		loggedInCustomer = true;
		app.login.setLoginInfo();
		var payingtypeurl = $('#paymentmethodURL').val();
		if (readCookie('username') != null && readCookie('username') != '' && loggedInCustomer)
		{
			$(".order-status-loading").show();
			app.appGateway.ajaxGet(payingtypeurl,ordertypesucesscallback,ordertypeerrorcallback);
		}
	} else {
		loggedInCustomer = false;
		app.login.logoutUserSession();
		window.location.replace($('#logout_url').val());
	}
}
function checkoutConfErrorCallback(e) {
	$('.paymentError').removeClass('hidden');	
}

function ordertypesucesscallback(data)
{
	var statusURL=$("#orderStatusCheckUrl").val();
	var getProfileURL=$("#profiledetailsServiceUrlthankU").val();
	var paymentmethodsArray = [];
	if(data.messages.allErrors == "" ){
		var userIdCookieVal = readCookie("userid");
		var paylist = data.payment_method.list;
		for (var i = 0; i < data.payment_method.list.length; i++)
		{
			paymentmethodsArray.push(data.payment_method.list[i].code)
		}
		if(!(paymentmethodsArray.indexOf('free') > -1))
		{
			//get status of payments completed in payon
			$.when(
				app.appGateway.ajaxGet(statusURL,thankyousuccess,thankyoufailure),
				app.appGateway.ajaxGet(getProfileURL,profileSuccessCallback,profileFailureCallback)
			).done(function(ajaxResponse ){
			});
			app.analytics.pushEvent('Click', 'Pay On', 'Pay-on Payment Processed::'+userIdCookieVal, 'pay now');			
		}
		else{
			//process free payments; call create order
			$.when(
				app.expressCheckout.createOrder(),
				app.appGateway.ajaxGet(getProfileURL,profileSuccessCallback,profileFailureCallback)
			).done(function(ajaxResponse ){
			});
			app.analytics.pushEvent('Click', 'Free', 'Free Payment Processed::'+userIdCookieVal, 'Complete Order');			
		}
	}
	else
	{
		$('.paymentError').removeClass('hidden');
		app.analytics.pushError(data.messages.allErrors, 'Error in retrieving payment method::' + data, location.href, document.referrer);
	}
}
function ordertypeerrorcallback(e)
{
	$('.paymentError').removeClass('hidden');
}

function thankyousuccess(data)
{
	removeCookie('productCount', '');
	$('.basketitems').text('0');
	$(".order-status-loading").hide();
	if(data.messages.allErrors == "" )
	{
		//Guest user & success call block
		if(data.messages.success.code =="2026" )
		{
			$('.paymentError').addClass('hidden');
			$('.paymentSuccess').removeClass('hidden');

			logTransaction(data);
		}
		else
		{
			$('.paymentError').removeClass('hidden');
		}
	}
	else
	{
		$('.paymentError').removeClass('hidden');
		app.analytics.pushError(data.messages.allErrors, 'Error in retrieving payment status::' + data, location.href, document.referrer);
	}
}
function thankyoufailure(e)
{
	$('.paymentError').removeClass('hidden');
}

function profileSuccessCallback(data)
{
	if (data.messages.allErrors == "")
	{
		var newsletterMailID,subscribeFlag;
		var successCode = data.messages.success.code;
		if (successCode == 2042)
		{
			newsletterMailID=data.email;
			subscribeFlag=data.newsletter_subscription;
			if(subscribeFlag!=null && subscribeFlag==1)
			{
				$('.subscribesuccess').addClass('hidden');
			}
			else
			{
				$('.subscribesuccess').removeClass('hidden');
				$("#txtEmail").val(newsletterMailID);
				$("#txtEmail").attr('readonly','true');
			}
		}
	}
	else{
		$('.subscribesuccess').addClass('hidden');
		app.analytics.pushError(data.messages.allErrors, 'Error in retrieving subscription from user profile::' + data, location.href, document.referrer);
	}
}
function profileFailureCallback(e)
{
	$('.subscribesuccess').addClass('hidden');
}

function logTransaction(data)
{
	var currency = data.order_data.order_currency_code;
	var order = data.order_id;
	var grand_total = data.order_data.grand_total;
	var tax =0;
	var temp ='';
	var itemcount = data.item_details.length;
	var shipping = data.order_data.shipping_incl_tax;
	var coupon = data.order_data.coupon_code;
	var productsArray = [];
	if(itemcount >0)
	{
		for (var i=0; i<itemcount; i++)
		{
			var eachProd =
			{
				'name': data.item_details[i].name,
				'id': data.item_details[i].product_id,
				'price': data.item_details[i].price_incl_tax,
				'quantity': data.item_details[i].qty_ordered
			}
			productsArray.push(eachProd);
		}
		for(var i=0;i<data.item_details.length;i++)
		{
			temp = data.item_details[i].tax_amount;
			tax =temp+tax;
		}
		app.analytics.transaction('transactionComplete',currency,order,grand_total,tax,shipping,coupon,productsArray);
	}
}
