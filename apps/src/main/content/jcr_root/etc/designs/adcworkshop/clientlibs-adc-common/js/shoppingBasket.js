	/*Default constructor*/
	function shoppingBasket() {
	    this.init();
	};
	var errorPageURL = $('#errorpage-url').val();
	var unauthorizedURL = $('#unauthorized-url').val();
	var cookieTimeout = new Date();
	cookieTimeout.setTime(cookieTimeout.getTime() + (30 * 60 * 1000));
		//alert("test1");
	shoppingBasket.prototype.init = function() {
	    var self = this;

		var displayPriceQtyVal = $('#displayPriceQty').val();
       // alert("displayPriceQtyVal " +displayPriceQtyVal);

		if(displayPriceQtyVal == 'yes'){
			self.getProductViaAjax();
		}
	    if ($('body').hasClass('product-basket')) {
	        self.viewBasketList();
	    }
	    $('.basketitems').text('0');

	    $(".remove").click(function() {
	        self.remove(this.id);
	    });

	    if (readCookie('productCount') != null) {
	        $('.basketitems').text(readCookie('productCount'));
	    } else {
	        $('.basketitems').text('0');
	    }
	}
	
	$(document).ready(function() {
	    $(document).on('click', "#voucher_btn-ok", function(e) {
	        var voucherCode = $('.VoucherCode').val();
	        app.analytics.pushVoucher(voucherCode);
	        e.preventDefault();
	        shoppingBasket.prototype.applyCoupon();
	    });
		
		$('.productTargetLink').click(function() {
			$('#commonoverlaytext').removeClass('hidden');
			$('#homeoverlaytext').addClass('hidden');
			$('#redirectUrl').removeClass('hidden');
			$('#redirecthomeUrl').addClass('hidden');
			$('#redirectUrl').attr("target","_blank");
			//app.analytics.pushEvent('overlay', 'alert leavig site', 'alert popup', 'load');	
		});
	});

	shoppingBasket.prototype.viewBasketList = function() {
	    var viewCart = $("#viewCartUrl").attr('value');
	    if (viewCart != null) {
	        $(".basket-loading").show();
            //alert("viewCart url"+ viewCart);
	        app.appGateway.ajaxGet("/etc/designs/getcart.json", carlistSuccessCallback, carlistErrorCallback);
	    }
	}

	function mergeviewJsonData(data) {
	    viewCartContent = {}
	    viewCartContent["voucherText"] = $("#voucherLabel").val();
	    viewCartContent["totalText"] = $("#totalLabel").val();
	    viewCartContent["voucherDiscountText"] = $("#voucherDiscount").val();
	    viewCartContent["vouchersuccessText"] = $("#voucherSuccessMessage").val();
	    viewCartContent["vouchererrorText"] = $("#voucherError").val();
	    viewCartContent["voucheremptyText"] = $("#voucherEmpty").val();
	    viewCartContent["voucherbuttonText"] = $("#voucherButton").val();
	    viewCartContent["shippingLabelText"] = $("#shippinglabel").val();
	    viewCartContent["PaymenttotalText"] = $("#totalPricelabel").val();
	    viewCartContent["discountText"] = $("#discountlabel").val();
	    viewCartContent["taxLabelText"] = $("#inclusivetaxLabelView").val();
	    viewCartContent["taxLabelTextpayment"] = $("#inclusivetaxlabel").val();
	    viewCartContent["maxExceededMsg"] = $("#maxExceededMsg").val();
	    viewCartContent["voucherTooltipImage"] = $("#voucherTooltipImage").val();
	    viewCartContent["voucherTooltipText"] = $("#voucherTooltipText").val();
	    viewCartContent["taxexclusiveLabelViewText"] = $("#taxexclusiveLabelView").val();
	    viewCartContent["viewBasketRemoveIcon"] = $("#viewBasketRemoveIcon").val();
	    viewCartContent["viewBasketShippingLabel"] = $("#viewBasketShippingLabel").val();
	    viewCartContent["viewProductLabel"] = $("#viewproductLabel").val();
	    viewCartContent["quantitylabel"] = $("#quantitylabel").val();
	    if (data.cart.length != 0) {
	        viewCartContent["customer_is_diabetic"] = data.cart[0].quote.customer_is_diabetic;
	    } else {
	        viewCartContent["customer_is_diabetic"] = '0';
	    }
	    jsonObj = [];
	    $("input[name^='sku_images']").each(function(i, anInput) {

	        var sku = $(anInput).attr('id');
	        var fields = $(anInput).val().split("+");
	        var imgPath = fields[0];
	        var viewUrl = fields[1];

	        var item = {}
	        item["sku"] = sku;
	        item["imagePath"] = imgPath;
	        item["viewUrl"] = viewUrl;

	        jsonObj.push(item);

	    });
	    viewCartContent["skuImgPath"] = jsonObj;
	    return viewCartContent;
	}

	function carlistSuccessCallback(data) {

        app.removePageSpinner();
	    $(".basket-loading").hide();
	    $(".basket-count-label").show();
	    $(".basket-table-desktop").show();
	    $(".basket-table-mobile").show();
	    var isError = false;
		if (data.messages.allErrors == "") {
			if (data.messages.success.code == "2016" || data.cart.length == 0 || data.quote_id == null) {
				$('#cartError').removeClass('hidden');
				isError = true;
			}
			var dataContent = mergeviewJsonData(data);
			$('.basketitems').text(data.productCount);
			addCookie('productCount', data.productCount, cookieTimeout);
            //alert("after addcookie" +data.productCount);
           // alert("data number:" +data.number);
            //alert("after addcookie" +data.productCount);
			shoppingBasket.prototype.handlerDesktopData($.extend(data, dataContent));

			var voucher = '';
			if (data.cart[0].quote.coupon_code) {
				voucher = data.cart[0].quote.coupon_code;
			}
			if (voucher != null) {
				$('.VoucherCode').attr('value', voucher);
			} else {
				$('.VoucherCode').attr('value', '');
			}

			if (isError) {
				setTimeout(focuscartError(), 1000);
			}
		}
		else{
            var errorCode = data.messages.error[0].code;
            var errorMessage = data.messages.error[0].message;
            app.analytics.pushError('500', 'Error occurred in retrieving cart list:' + errorCode + "::" + errorMessage, location.href, document.referrer);
            window.location.replace(errorPageURL);
		}
	}

	function focuscartError() {
	    $("#cartError").focus();
	    $(this).scrollTop(100);
	}

	function carlistErrorCallback(e) {
        app.removePageSpinner();
	    window.location.replace(errorPageURL);
	}

	function applycouponErrorCallback(e) {
	    app.removePageSpinner();
	    var voucherCode = $("#VoucherCode").val();
	    app.analytics.pushEvent('Click', 'checkout', 'invalid', voucherCode);
	    app.analytics.pushEvent('Click', 'checkout', e, voucherCode);
	}

	function applycouponSuccessCallback(data) {
	    app.removePageSpinner();
	    var voucherCode = $("#VoucherCode").val();
	    var dataContent = mergeviewJsonData(data);
	    $.extend(data, dataContent);
	    if (data.messages.allErrors == "") {
	        if (data.messages.error.length == 0) {
	            shoppingBasket.prototype.handlerDesktopData(data);
	            $('.vouchercouponsucess').removeClass('hidden');
	            $('.voucherForm').addClass('hidden');
	            $('#couponform').addClass('hidden');
	            app.analytics.pushEvent('Click', 'checkout', 'valid', voucherCode);

	        } else {
	            $(".error_invalid").removeClass('hidden');
	            $(".vouchercoupon").addClass('hidden');
	            shoppingBasket.prototype.handlerDesktopData(data);
	            var errorVal = $(".error_invalid").html();
	            app.analytics.pushEvent('Click', 'checkout', 'invalid', voucherCode);
	            app.analytics.pushEvent('Click', 'checkout', errorVal, voucherCode);
	        }
	    } else {
	        var errocode = data.messages.error[0].code;
	        var errormessage = data.messages.error[0].message;
			var errorVal = $(".error_invalid").html();                               
	        if ($('body').hasClass('product-basket')) {
	            shoppingBasket.prototype.handlerDesktopData(data);
	        }
	        if (errocode == 4030 || errocode == 4077 || errocode == 4078 || errocode == 4079 || errocode == 4080) {
	            $(".error_invalid").removeClass('hidden');
	            $(".vouchercoupon").addClass('hidden');
	            $(".error_invalid").html($('#voucherinvaliderror').val());
	        } else if (errocode == 4081 || errocode == 4082) {
	            $(".error_invalid").removeClass('hidden');
	            $(".vouchercoupon").addClass('hidden');
	            $(".error_invalid").html($('#voucherexpired').val());
	        } else if (errocode == 4083 || errocode == 4084 || errocode == 4085) {
	            $(".error_invalid").removeClass('hidden');
	            $(".vouchercoupon").addClass('hidden');
	            $(".error_invalid").html($('#voucheralreadyused').val());
	        } else if (errocode == 4086) {
	            $(".error_invalid").removeClass('hidden');
	            $(".vouchercoupon").addClass('hidden');
	            $(".error_invalid").html($('#vouchercannotbeusedforproduct').val());
	        } else {
	            $(".error_invalid").removeClass('hidden');
	            $(".vouchercoupon").addClass('hidden');
	            $(".error_invalid").html(errormessage);
	        }
	        if ($('body').hasClass('Checkoutpage')) {
	            app.expressCheckout.getFinalPaymentDetails();
	        }
	        app.analytics.pushEvent('Click', 'checkout', 'invalid', voucherCode);
	        app.analytics.pushEvent('Click', 'checkout', errorVal, voucherCode);
	    }
	}



	shoppingBasket.prototype.handlerDesktopData = function(resJSON) {

	    if ($('body').hasClass('Checkoutpage')) {

	        var dataContent = mergeviewJsonData(resJSON);
	        $.extend(resJSON, dataContent);
	        if (readCookie('countryCookie') == "GB") {
	            viewCheckoutBasketHTML = Handlebars.templates['viewCheckoutBasket-template'](resJSON);
	            $("#basketPlace").html(viewCheckoutBasketHTML);
	        }
	        viewCheckoutPaymentHTML = Handlebars.templates['viewCheckoutPayment-template'](resJSON);
	        $("#tablePlaceshipping").html(viewCheckoutPaymentHTML);
	        viewCheckoutPaymentMobileHTML = Handlebars.templates['viewCheckoutPayment-template-mobile'](resJSON);
	        $("#tablePlaceMobileshipping").html(viewCheckoutPaymentMobileHTML);
	        shoppingBasket.prototype.displayPaymentMethods();
	    } else {

	        $(".heading").removeClass("hidden");
	        $("#userCheckout").removeClass("hidden");
			viewCartHTML = Handlebars.templates['viewcart'](resJSON);

	        $("#tablePlace").html(viewCartHTML);

	        viewCartMHTML = Handlebars.templates['viewcartmobile'](resJSON);

	        $("#tablePlaceMobile").html(viewCartMHTML);

	        $(".prodSpinner").TouchSpin({
	            verticalbuttons: true,
	            min: 1,
	            stepinterval: 1
	        });
	    }
	    if (resJSON.qtyExceeded == true) {
	        $("#userCheckout").addClass("disabled");
	    } else {
	        $("#userCheckout").removeClass("disabled");
	    }
	    if ($("#couponrequired").val() == 'true') {
	        $(".voucher-section").removeClass("hidden");
	    } else {
	        $(".voucher-section").addClass("hidden");
	    }

	    shoppingBasket.prototype.productTableHandling();

	    $(".remove").click(function() {
	        var cart = {};
	        cart["sku"] = this.id;
	        cart["qty"] = $('.prodSpinner ').val();
	        var pounds = $('#' + this.id + 'Price').find('.pounds').html();
	        var separator = $('#' + this.id + 'Price').find('.separator').html();
	        var pence = $('#' + this.id + 'Price').find('.pence').html();
	        var totalPrice = pounds + separator + pence;
	        cart["productPrice"] = totalPrice;
	        cart["productTitle"] = $(this).closest('td').find('img').attr('alt'); //$('td').find('img').attr('alt');
	        var currency;
	        if (readCookie('countryCookie') == 'GB') {
	            currency = 'GBP';
	        } else {
	            currency = 'EUR';
	        }
	        shoppingBasket.prototype.remove(this.id);
	        app.analytics.removeCart('removeFromCart', currency, cart.productTitle, cart.sku, cart.productPrice, cart.qty);
	    });
	}

	shoppingBasket.prototype.displayPaymentMethods = function() {
           if($('#paymentCardsLink').is(':hidden')) {
	       var payingtypeurl = $('#paymentmethodURL').val();
	       app.appGateway.ajaxGet(payingtypeurl, paymenttypesucesscallback, paymenttypeerrorcallback);
        }
	}

	function paymenttypesucesscallback(data) {
		if (data.messages.allErrors == ""){
			if (data.payment_method != null) {
				var paymentmethodsArray = [];
				for (var i = 0; i < data.payment_method.list.length; i++) {
					paymentmethodsArray.push(data.payment_method.list[i].code);
				}
				if (paymentmethodsArray.indexOf('free') > -1) {
					$('.zeroorderbutton').removeClass('hidden');
					$('.paymenttitle').addClass('hidden');
					$('#paymentMethodView').addClass('hidden');
				} else {
					$('#paymentMethodView').removeClass('hidden');
					$('.paymenttitle').removeClass('hidden');
					$('.zeroorderbutton').addClass('hidden');
				}
			}
		} else {
			var errorCode = data.messages.error[0].code;
			var errorMessage = data.messages.error[0].message;
			app.analytics.pushError('500', 'Error occurred while fetching payment methods at the payment step:' + errorCode + "::" + errorMessage, location.href, document.referrer);
			window.location.replace(errorPageURL);
		}
	}

	function paymenttypeerrorcallback(e) {
	    window.location.replace(errorPageURL);
	}

	shoppingBasket.prototype.remove = function(removedRow) {

	    var removeItem = $("#removeCartUrl").attr('value');
	    var deleteUrl = removeItem + removedRow + '/delete';

	    if (deleteUrl != null) {
            app.addPageSpinner();
	        app.appGateway.ajaxDelete(deleteUrl, carlistSuccessCallback, carlistErrorCallback);
	    }
	}

	shoppingBasket.prototype.applyCoupon = function() {

	    var voucherCode = $("input.VoucherCode:visible").val();

	    var updateCouponUrl = $("#voucherCodeUrl").attr('value');

	    var is_Coupon = $('input.VoucherCode:visible');
	    if (is_Coupon.val() == "") {

	        $('.vouchercoupon').removeClass('hidden');
	        $('.error_invalid').addClass('hidden');

	    } else {
            
	        var cart = {};
	        cart["coupon_code"] = voucherCode;
            app.addPageSpinner();
	        app.appGateway.ajaxPut(updateCouponUrl, cart, applycouponSuccessCallback, applycouponErrorCallback);

	    }
	    $("input[type='text']").on('input', function() {
	        $('.vouchercoupon').addClass('hidden');
	    });
	    $("input[type='text']").on('input', function() {
	        $('.vouchercouponerror').addClass('hidden');
	    });
	}

	shoppingBasket.prototype.updateQty = function(sku, oldValue) {
	    var retVal = false;
	    var updateCartUrl = $("#updateCartUrl").attr('value');

	    if ($(window).width() > 767) {
	        var qty = $("input." + sku + "prod-spinner:visible").val();
	    } else {
	        var qty = $('.' + sku + 'prod-spinner :selected').text();
	    }
	    if (sku != null && qty != null && qty != "" && updateCartUrl != null) {
	        var cart = {};
	        cart["sku"] = sku;
	        cart["qty"] = qty;
	        cart["productTitle"] = $('#' + sku + 'Row').find('.product-name').html();
	        var currency;
	        if (readCookie('countryCookie') == 'GB') {
	            currency = 'GBP';
	        } else if (readCookie('countryCookie') == 'IT' || readCookie('countryCookie') == 'LU') {
	            currency = 'EUR';
	        }
	        var stdPounds = $('#' + sku + 'Price').find('.pounds').html();
	        var stdSeparator = $('#' + sku + 'Price').find('.separator').html();
	        var stdPence = $('#' + sku + 'Price').find('.pence').html();
	        var totalPrice = stdPounds + stdSeparator + stdPence;
	        cart["productPrice"] = totalPrice;
	        if (oldValue <= qty) {
	            app.analytics.addCart('addToCart', currency, cart.productTitle, cart.sku, cart.productPrice, cart.qty);
	        } else {
	            cart["productPrice"] = totalPrice;
	            app.analytics.removeCart('removeFromCart', currency, cart.productTitle, cart.sku, cart.productPrice, cart.qty);
	        }
            app.addPageSpinner();
	        app.appGateway.ajaxPut(updateCartUrl, cart, carlistSuccessCallback, carlistErrorCallback);
	    }
	    return retVal;
	}




	shoppingBasket.prototype.productTableHandling = function() {
	    var products = parseInt($('.basketitems').text(), 0);
	    $('#productCount').html(products);
	    if (products > 1 && readCookie('countryCookie') == "GB") {
	        $('.plural-product').html("products");
	    } else if (products == 1 && readCookie('countryCookie') == "GB") {
	        $('.plural-product').html("product");
	    }
	    if (products > 1 && readCookie('countryCookie') == "IT") {
	        $('.plural-product').html("prodotti");
	    } else if (products == 1 && readCookie('countryCookie') == "IT") {
	        $('.plural-product').html("prodotto");
	    }

	    if (products > 0) {
	        $('#basketHolder').show();
	        $('#noProducts').hide();
	    } else {
	        $('#basketHolder').hide();
	        $('#noProducts').show();
	    }
	}


	/********** added from starter pack START **********/

	$('.addbasket').on('click', function(evt) {
	    if ($(this).hasClass('addbasketSticky')) {
	        isStickyBuy = true;
	    } else {
	        isStickyBuy = false;
	    }
	    shoppingBasket.prototype.addProductToCart();
	});

	$('#myModal-1').on('shown.bs.modal', function(e) {
	    var qtyMobile = $('#qtySelect :selected').text();
	    var qty = $('#prod-count').attr('value');
	    var price = $('#product-priceNum').attr('value');
	    var priceDec = $('#product-priceDec').attr('value');
	    var img = $('#prod_tn_image').attr('src');
	    var title = $("#product-title").attr('value');
	    $('#prod-title').text(title);

	    if ($(window).width() > 767) {
	        $('#prod-quantity').text(qty);
	    } else {
	        $('#prod-quantity').text(qtyMobile);
	    }
	    $('#prod-price').html(price);
	    $('#prod-priceDec').html(priceDec);

	    $('#prod-img').attr('src', img);
	});


	shoppingBasket.prototype.addProductToCart = function() {
	    var cartArr = [];
	    var addCartUrl = $("#addCartItemUrl").attr('value');
	    var theForm = $(this);
	    var cart = {};
	    var parent = $(this).parent();
	    cart["sku"] = $('#product-skuID').attr('value');
	    if ($(window).width() > 767) {
	        cart["qty"] = $('#prod-count').attr('value');

	    } else {
	        cart["qty"] = $('#qtySelect :selected').text();
	    }

	    cart["productTitle"] = $('#product-title').attr('value');
	    cart["thumbnailImagePath"] = $('#prod_tn_image').attr('src');
	    cart["bundle_option"] = $('#bundle_option').attr('value');
	    var currency;
	    if (readCookie('countryCookie') == 'GB') {
	        currency = 'GBP';
	    } else if (readCookie('countryCookie') == 'IT' || readCookie('countryCookie') == 'LU') {
	        currency = 'EUR';
	    }
	    var stdPrice = $('#totalPrice').val();

	    if (addCartUrl != null) {

	        $(".addbasket").addClass("disabled");
	        $(".buynow-loading").show();
	        app.appGateway.ajaxGet("/etc/designs/addcart.json", cartAddSuccess, cartAddError);
	    }
	   // app.analytics.addCart('addToCart', currency, cart.productTitle,
	        //cart.sku, stdPrice, cart.qty);
	}


	function cartAddSuccess(data) {

	    $(".buynow-loading").hide();
	    $(".addbasket").removeClass("disabled");
	    if (data.messages.allErrors == "") {
	        var productCount = data.productCount;
	        if (data.messages.success.code == 2013 && productCount == 0) {
	            $('.basketitems').text(1);
	            addCookie('productCount', 1, cookieTimeout);
	        } else {
	            $('.basketitems').text(productCount);
	            addCookie('productCount', productCount, cookieTimeout);
	        }
	        var options = {
	            "backdrop": "static"
	        }
	        if (isStickyBuy) {
	            window.location.assign($('#productViewCartUrl').val());
	        } else {
	            $('#myModal-1').modal(options);
	        }

	    } else if (data.messages.error[0].code != null) {
	        var maxallowed = $('#maxAllowed').attr('value');
	        var Maxtext = $('#maxErrorMessage').attr('value');
	        $('.prod-spinnerError').html(Maxtext + '&nbsp;' + maxallowed);
	        $('.prod-spinnerError').removeClass('errorHide');
	        $('.prodmessage').addClass('hidden');

	    }
	}

	function cartAddError(e) {
	    $(".buynow-loading").hide();
	    $(".addbasket").removeClass("disabled");
	    $('.prod-spinnerError').html('Service not available');
	    $('.prod-spinnerError').removeClass('errorHide');
	    window.location.replace(errorPageURL);
	}

	shoppingBasket.prototype.getProductViaAjax = function() {

        var appCookieVal = readCookie("apptoken");
	    var productUrl = $("#product-url").attr('value');
       // alert("productUrl " +productUrl);
        //console.log(productUrl);
	    if (productUrl != null) {
	        $(".addbasket").addClass("disabled");
	        $(".product-loading").show();
	        app.appGateway.ajaxGet("/etc/designs/product.json", onSuccess, onError);
	    }
	}

	function onSuccess(data) {
        $(".product-loading").hide();
	    $(".addbasket").removeClass("disabled");
	    var price = data.final_price_inclall;
	    var pid = data.sku;
	    var pname;
	    var url = window.location.href;
	    var urlName = window.location.href.split('/');
        //alert("price: " +price);
		if ((urlName[urlName.length - 1] == 'capteur.html') || (urlName[urlName.length - 1] == 'sensors.html') || (urlName[urlName.length - 1] == 'sensore.html'))
				{
                        pname = 'sensors';
				}
         if ((urlName[urlName.length - 1] == 'lecteur.html') || (urlName[urlName.length - 1] == 'reader.html') || (urlName[urlName.length - 1] == 'lettore.html'))
				{
                        pname = 'reader';
                 }
         if ((urlName[urlName.length - 1] == 'pack-de-demarrage.html') || (urlName[urlName.length - 1] == 'starter-pack.html') || (urlName[urlName.length - 1] == 'starter-kit.html'))
				{
                        pname = 'starter-pack';
                  }
		  if((urlName[urlName.length - 1] == 'capteur.html')){
                                pname = 'capteur';
                }
         if((urlName[urlName.length - 1] == 'lecteur.html')){
                                pname = 'lecteur';
                }
         if((urlName[urlName.length - 1] == 'pack-de-demarrage.html')){
                                pname = 'pack-de-demarrage';
                }	  

	    app.analytics.productImpression('productDetailImpression', pname, pid, price);
	    display(data);
	}

	function onError(e) {
	    $(".addbasket").removeClass("disabled");
	    window.location.replace(errorPageURL);
	}


	function enableSearchButton(flag) {
	    $("#btn-search").prop("disabled", flag);
	}

	function display(data) {
      
	    var separator = data.priceSeparator;
	    var jsonNum = data.currency + data.number;
	    var jsonDec = data.decimal;

	    $('#totalPrice').val(data.final_price_inclall);
	    $('#totalCurrency').val(data.currency);

	    $('.prodNum').html(jsonNum);
	    $('.prodDec').html(separator + jsonDec);

	    $('#product-priceNum').attr('value', jsonNum);
	    $('#product-priceDec').attr('value', separator + jsonDec);
	    $('#product-price').attr('value', jsonNum + separator + data.decimal);

	    if (($('#prodmessagelable1').val()).length > 0 && ($('#prodmessagelable2').val()).length > 0) {
	        $('.prodmessage').html($('#prodmessagelable1').val() + " " + data.max_allowed + " " + $('#prodmessagelable2').val());
	    }
	    if (($('#prodmessagelable1').val()).length > 0 && ($('#prodmessagelable2').val()).length == 0) {
	        $('.prodmessage').html($('#prodmessagelable1').val());
	    }

	    if ($('.product-amount .vat').length > 0) {
	        $('.product-amount .vat').css('display', 'block');
	    }

	    var out_of_stock = data.is_saleable;

	    if (out_of_stock == 0) {

	        $(".addbasket").addClass("hidden");
	        $('.prodSpinner').attr('disabled', "true");
	        $(".bootstrap-touchspin-up").addClass("disabled");
	        $(".bootstrap-touchspin-down").addClass("disabled");
	        $('.prod-spinnerError').html($('#productnotavailablemessage').attr('value'));
	        $('.prod-spinnerError').removeClass('errorHide');
	        $('.prodmessage').addClass('hidden');
	    }

	    if (data.allowed_qty_limit != null) {
	        $(".prodSpinner").attr('max', data.max_allowed);
	        $(".prodSpinner").attr('min', data.min_allowed);
	        $("#maxAllowed").attr('value', data.max_allowed);

	        var qtyTemplate = Handlebars.compile($("#quantityMobile-template").html());
	        $('#qty-place').html(qtyTemplate(data));

	    }
	    if (data.bundle_option != null) {
	        $("#bundle_option").attr('value', data.bundle_option);
	    }
	}


	/********** added from starter pack END **********/


	app.shoppingBasket = new shoppingBasket();