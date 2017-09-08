(function(){
	var analytics = function()
	{
		this.init();
	}

	analytics.prototype.init = function ()
	{
		var self= this;
	}

	analytics.prototype.pushGeneric = function(ajaxpageload, pagename)
	{
		if(dataLayer !=null && dataLayer!=undefined){
			dataLayer.push({
			'event':ajaxpageload,
			'pageName':pagename
			});
		}
	}
	analytics.prototype.pushError = function(httpcode, httpmessage, url, referrer)
	{
		if(dataLayer !=null && dataLayer!=undefined){
			if(httpmessage!=null && httpmessage.trim()!='' && httpmessage!=undefined){
				var eventCategory=httpcode + ":" +httpmessage;
				dataLayer.push({
				'event':'httperror',
				'eventCategory':eventCategory,
				'eventAction':url,
				'eventLabel':referrer
				});
			}
		}
	}
	analytics.prototype.pushPage = function(anonymousid, logintype, logincategory, customertype)
	{
		if(dataLayer !=null && dataLayer!=undefined){
			dataLayer.push({
			'AnonymousID': anonymousid,
			'LoginType': logintype,
			'LoginCategory': logincategory,
			'CustomerType': customertype
			});
		}
	}
	analytics.prototype.pushEvent = function(event,eventcategory,eventaction,eventresult)
	{
		if(dataLayer !=null && dataLayer!=undefined){
			dataLayer.push({
			'event':event,
			'eventCategory':eventcategory,
			'eventAction':eventaction,
			'eventLabel':eventresult
			});
		}
	}
	analytics.prototype.pushVoucher = function(voucher)
	{
		if(dataLayer !=null && dataLayer!=undefined){
			dataLayer.push({
				'voucher':voucher
			});
		}
	}
	analytics.prototype.onCheckoutOption = function (event, step, method)
	{
		if(dataLayer !=null && dataLayer!=undefined){
			dataLayer.push({
			'event': event,
			'checkout method': method,
			'ecommerce': {
				'checkout_option': {
					'actionField': {'step': step, 'option':method}
				}}
			});
		}
	}
	analytics.prototype.onCheckoutShipping = function(event, step, method) {
		if(dataLayer !=null && dataLayer!=undefined){
			dataLayer.push({
				'event' : event,
				'shippingMethod' : method,
				'ecommerce' : {
					'checkout_option' : {
						'actionField' : {
							'step' : step,
							'option' : method
						}
					}
				}
			});
		}
	}
    analytics.prototype.onCheckoutPayment = function (event, step, method)
	{
		if(dataLayer !=null && dataLayer!=undefined){
			dataLayer.push({
			'event': event,
			'payment method': method,
			'ecommerce': {
				'checkout_option': {
					'actionField': {'step': step, 'option':method}
				}}
			});
		}
	}
	analytics.prototype.onCheckout = function(event, virtualurl, pagename, step, productsArray)
	{
		if(dataLayer !=null && dataLayer!=undefined){
			dataLayer.push({
			'event': event,
			'virtualPageURL':virtualurl,
			'pageName' : pagename,
			'ecommerce': {
				'checkout': {
					'actionField': {'step': step, 'option': ''},
					'products': productsArray
							}
						 },
			'eventCallback': function() {
				}
			});
		}
	}
	analytics.prototype.removeCart = function(event,currency,pname,pid,price,quantity)
	{
		if(dataLayer !=null && dataLayer!=undefined){
			dataLayer.push({
			'event': event,
			'ecommerce': {
				'currencyCode': currency,
				'remove': {
					'products': [{
						'name': pname,
						'id': pid,
						'price': price,
						'quantity':quantity
							}]
						}
					}
			});
		}
	}

	analytics.prototype.addCart = function(event,currency,pname,pid,price,quantity)
	{
		if(dataLayer !=null && dataLayer!=undefined){
			dataLayer.push({
			'event': event,
			'ecommerce': {
				'currencyCode': currency,
				'add': {
					'products': [{
						'name': pname,
						'id': pid,
						'price': price,
						'quantity': quantity
							}]
						}
					}
			});
		}
	}

	analytics.prototype.transaction = function(event, currency, tid, revenue, tax, ship, voucher, productArray)
	{
		if(dataLayer !=null && dataLayer!=undefined){
			dataLayer.push({
				'event': event,
				'ecommerce': {
					'currencyCode': currency,
					'purchase': {
						'actionField': {
							'id': tid,
							'revenue': revenue,
							'tax': tax,
							'shipping': ship,
							'coupon': voucher
						},
						'products': productArray
					}
				}
			});
		}
	}
    analytics.prototype.productImpression=function(event, pname, pid, price)
    {
		if(dataLayer !=null && dataLayer!=undefined){
			dataLayer.push({
				'event': event,
				'ecommerce': {
					'detail': {
						'products': [{
							'name': pname,
							'id': pid,
							'price': price
						}]
					}
				}
			});
		}
    }
	app.analytics = new analytics();
	}
)();