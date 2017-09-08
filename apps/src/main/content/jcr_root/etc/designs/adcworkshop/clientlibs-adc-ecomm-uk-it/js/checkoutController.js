$(document).ready(function() {
   //alert("checkout controller");
    var productsArray = [];
    var errorPageURL = $('#errorpage-url').val();
    var cookieTimeout = new Date();
    var minutes = $('#timeOutVal').val();
    var sortedAddress = "";
    cookieTimeout.setTime(cookieTimeout.getTime() + (minutes * 60 * 1000));

    $("#vatForUK").hide();
    $("#vatForIT").hide();
    var fetchedCountryCookie = readCookie('countryCookie');
    if (fetchedCountryCookie == "GB") {
        $("#vatForUK").show();

    } else if (fetchedCountryCookie == "IT") {
        $("#vatForIT").show();
    }

	if ($('body').hasClass('Checkoutpage')) {
		var isCustURL = $("#isCustUrl").attr('value');
        //alert(isCustURL);
		if (isCustURL != null) {
			app.appGateway.ajaxGet("/etc/designs/customer.json", checkoutCustSuccessCallback, checkoutCustErrorCallback);
		}
	}
	function checkoutCustSuccessCallback(data) {
        //alert("checkoutCustSuccessCallback");
	    if (data) {
           // alert(data);
	        loggedInCustomer = true;
			app.login.setLoginInfo();
			app.expressCheckout.initCustomerCheckout();
	    } else {
	        loggedInCustomer = false;
			app.login.logoutUserSession();
	    }
	}
	function checkoutCustErrorCallback(e) {
		//app.analytics.pushError('500', 'Error occurred in checkout','','');
		loggedInCustomer = false;
		app.login.logoutUserSession();
	}
	
    /* Default constructor */
    function expressCheckout() {
        this.init();
    }

    /* shipping postalcode */
    var QAScheck = $("#QAS-check").val();
    if (QAScheck) {
        $('.QASaddresslookup').removeClass('hidden');

    } else {
        $('.QASaddresslookup').addClass('hidden');
    }

    // generic
    $(document).on('click', "[id*='_FindAddress']", function() {
        var selectedID = (this.id).split("_");
        $('#' + selectedID[0] + '_ManualAddressData').addClass('hidden');
        $('#' + selectedID[0] + '_FindAddressData').removeClass('hidden');
        $('#' + selectedID[0] + '_ManualAddress').removeClass('hidden');
        $('#' + selectedID[0] + '_FindAddress').addClass('hidden');
    });

    $(document).on('click', "[id*='_ManualAddress']", function() {
        var selectedID = (this.id).split("_");
        $('#' + selectedID[0] + '_ManualAddressData').removeClass('hidden');
        $('#' + selectedID[0] + '_FindAddressData').addClass('hidden');
        $('#' + selectedID[0] + '_FindAddress').removeClass('hidden');
        $('#' + selectedID[0] + '_ManualAddress').addClass('hidden');
    });


    var postcode = null;

    $('#shipping_AddresssFind').click(function(event) {
        // to add code
        findSource = "shipping";
        postcode = $("#shipping_contact_postCode").val();
        expressCheckout.prototype.getQASOnDemandAddress(postcode, event);

    });

    $('#Shipping_AddresssFind_overlay').click(
        function(event) {
            // to add code
            findSource = "overlay";
            postcode = $("#contact_postCode_overlay").val();
            expressCheckout.prototype.getQASOnDemandAddress(postcode, event);

        });

    $('#AddresssFind_vat').click(function(event) {
        // to add code
        findSource = "vat";
        postcode = $("#contact_postCode_vat").val();
        expressCheckout.prototype.getQASOnDemandAddress(postcode, event);

    });

    $('#billing_AddresssFind').click(
        function(event) {
            // to add code
            findSource = "billing";
            postcode = $("#billing_contact_postCode").val();
            expressCheckout.prototype.getQASOnDemandAddress(postcode, event);

        });

    $('.qas-address-selection').on('change', function(event) {
        selectedSource = this.id;
        var selectVal = this.value;
        expressCheckout.prototype.getQASAddressByMoniker(selectVal, event);
    });

    expressCheckout.prototype.getQASAddressByMoniker = function(moniker, event) {
        event.preventDefault();
        var search = {}
        search["moniker"] = moniker;
        var qasAddressUrl = $("#QASAddressbyMonikerServiceUrl").val();
        app.appGateway.ajaxPost(qasAddressUrl, search, QASAddresssuccessCallback, QASerrorCallback)
    }

    function QASAddresssuccessCallback(data) {
        if (data != null) {
            if (data.addressline != null) {
                var strArray = data.addressline.split(',');

                var length = 35;
                var Add1 = strArray[0];
                var trimmedAdd1 = Add1.substring(0, length);

                $("." + selectedSource + "_addressFind_one").val(trimmedAdd1);
                $("." + selectedSource + "_addressFind_one").addClass('valid');

                if (strArray[1] != null) {
                    var Add2 = strArray[1];
                    var trimmedAdd2 = Add2.substring(0, length);
                    $("." + selectedSource + "_addressFind_two").val(trimmedAdd2);
                    $("." + selectedSource + "_addressFind_two").addClass('valid');
                }
            }
            if (data.postalcode != null) {
                if (selectedSource == "shipping" || selectedSource == "billing") {
                    $("#" + selectedSource + "_contact_postCode").val(data.postalcode);
                    $("#" + selectedSource + "_contact_postCode").addClass('valid').removeClass('invalid');
                    $('#postalcode_contact_error').addClass('hidden');
                    $("#" + selectedSource + "_contact_postCode").next().html('');
                } else {
                    $("#contact_postCode_" + selectedSource).val(data.postalcode);
                    $("#contact_postCode_" + selectedSource).addClass('valid').removeClass('invalid');
                    $("#contact_postCode_" + selectedSource).next().html('');
                }
            }

            $("." + selectedSource + "_addressFind_city").val(data.town);
            $("." + selectedSource + "_addressFind_city").addClass('valid');
        }
    }

    function QASsuccessCallback(data) {
        var options = [];
        options.push('<option value="">' + $("#QAS-defaultaddrselect")[0].value + '</option>');
        for (var i = 0; i < data.addressLineList.length; i++) {
            options.push('<option value="',
                data.addressLineList[i].moniker, '">',
                data.addressLineList[i].picklist,
                '</option>');
        }
        $(".qas-address-" + findSource).html(options.join(''));
        $('#shipping_ShowAddress').removeClass('hidden');
        $('#Shipping_ShowAddress_overlay').removeClass('hidden');
        $('#ShowAddress_vat').removeClass('hidden');
        $('#billing_ShowAddress').removeClass('hidden');
    }

    function QASerrorCallback(e) {
        $('#shipping_ShowAddress').addClass('hidden');
        $('#Shipping_ShowAddress_overlay').addClass('hidden');
        $('#ShowAddress_vat').addClass('hidden');
        $('#billing_ShowAddress').addClass('hidden');
    }

    expressCheckout.prototype.getQASOnDemandAddress = function(postcode, event) {
        event.preventDefault();
        var search = {}
        search["postalCode"] = postcode;

        var qasAddressUrl = $("#QASAddressServiceUrl").val();
        var qasAddressTargetUrl = qasAddressUrl + "/zipcode/" + postcode;
        app.appGateway.ajaxGet(qasAddressTargetUrl, QASsuccessCallback, QASerrorCallback)
    }

    /* Payment process */

    $('input[name="cartType"]').click(function() {
        if (this.id == "paypalCardId") {
            $('#creditCardDetailsView').addClass('hidden');
            $('#paypalSection').removeClass('hidden');
        } else {
            $('#creditCardDetailsView').removeClass('hidden');
            $('#paypalSection').addClass('hidden');
        }
        $('#paymentMethodView').addClass('hidden');

    });
    $('#paymentCardsLink').click(function() {
        addCookie('changepayment', 'yes');
        window.location.reload(true);
    });

	expressCheckout.prototype.initCustomerCheckout = function() {
        //alert("checkoutcontroller");
        if (readCookie('username') != null && readCookie('username') != '' && loggedInCustomer) {
            $("#create-account").addClass('hidden');
            $("#shipping-address").find('.panel-collapse').collapse('show');
            $("#shipping-address").find('#checkoutnumber').text("1");
            $("#shipping-address").find('#checkoutnumber').addClass("active");
            $("#payment").find('.checkout-step').text("2");
            this.getShipmentTypeDetails();
            this.addressList();
        }
	}

    /*---End payment process----*/
    expressCheckout.prototype.init = function() {
        var self = this;

        $('#contact_postCode_overlay').keyup(function() {
            var val = $('#contact_postCode_overlay').val().trim();
            if (val.length >= 4)
                $('#contact_postCode_overlay').closest('form').find('.AddressBtn').removeAttr("disabled");
            else
                $('#contact_postCode_overlay').closest('form').find('.AddressBtn').attr('disabled', 'disabled');
        });

        $('#contact_postCode_vat').keyup(function() {
            var val = $('#contact_postCode_vat').val().trim();
            if (val.length >= 4)
                $('#contact_postCode_vat').closest('form').find('.AddressBtn').removeAttr("disabled");
            else
                $('#contact_postCode_vat').closest('form').find('.AddressBtn').attr('disabled', 'disabled');
        });
        $('#shipping_contact_postCode').keyup(function() {
            var val = $('#shipping_contact_postCode').val().trim();
            if (val.length >= 4)
                $('#shipping_contact_postCode').closest('form').find('.AddressBtn').removeAttr("disabled");
            else
                $('#shipping_contact_postCode').closest('form').find('.AddressBtn').attr('disabled', 'disabled');
        });

        $('#billing_contact_postCode').keyup(function() {
            var val = $('#billing_contact_postCode').val().trim();
            if (val.length >= 4)
                $('#billing_contact_postCode').closest('form').find('.AddressBtn').removeAttr("disabled");
            else
                $('#billing_contact_postCode').closest('form').find('.AddressBtn').attr('disabled', 'disabled');
        });


        $('input[name="cartType"]').attr('disabled', true);
        // payment check box validation
        $('.paycards,.paypalcards').hover(function() {
            $(this).css('cursor', 'no-drop');
        });
        if ($("#termscondCheckId").not(':checked')) {
            $('.zeroorderbutton').attr('disabled', 'disabled');
            $("#paymentMethodView,.zeroorderbutton").click(function() {
                $("#termCondError").removeClass("hidden");
                $("#termCondError").focus();
            });
        }
        $("#termscondCheckId").click(function() {
            if ($(this).is(':checked')) {
                $("#termCondError").addClass("hidden");
                $('.zeroorderbutton').removeAttr("disabled");
                $("#paymentMethodView,.zeroorderbutton").click(function() {
                    $("#termCondError").addClass("hidden");
                });
            } else {
                $('input[id="payon_cc"]').attr('disabled', true);
                $('input[id="payon_paypal"]').attr('disabled', true);
                $("#paymentMethodView,.zeroorderbutton").click(function() {
                    $("#termCondError").removeClass("hidden");
                    $("#termCondError").focus();
                });
                $('.zeroorderbutton').attr('disabled', 'disabled');
            }
            // $('.paymenttitle').hide();
            if ($(this).prop('checked') == false) {
                $('input[name="cartType"]').attr('checked', false);
                $('input[name="cartType"]').attr('disabled', true);
                $('.paycards,.paypalcards').hover(function() {
                    $(this).css('cursor', 'no-drop');
                });
                $('.cardSubmitButton').attr('disabled', 'disabled').css("opacity", ".65");
                $('.customDirectSubmit').attr('disabled', 'disabled').css("opacity", ".65");
            } else {
                $('input[name="cartType"]').attr('disabled', false);
                $("#termscondCheckId").next().addClass('checked');
                $('.cnpForm').show();
                $('.cardSubmitButton').removeAttr('disabled').css("opacity", "1");
                $('.customDirectSubmit').removeAttr('disabled').css("opacity", "1");
                $('.paycards').hover(function() {
                    $(this).css('cursor', 'pointer');
                });
                $('.paypalcards').hover(function() {
                    $(this).css('cursor', 'pointer');
                });
                $('.paycards').click(function() {
                    $('input[id="payon_cc"]').attr('checked', true);
                    $('input[id="payon_cc"]').attr('disabled', false);
                    var payon = document.getElementById("payon_cc");
                    if (payon.checked) {
                        self.createOrder();
                        $('#creditCardDetailsView').removeClass('hidden');
                        if (this.id == "paypalCardId") {

                        } else {

                            $('#paypalSection').addClass('hidden');
                        }
                        $('#paymentMethodView').addClass('hidden');
                        $('.cnpForm').show();
                    } else {
                        $('.cnpForm').hide();
                    }
                });
                $('.paypalcards').click(function() {
                    $('input[id="payon_paypal"]').attr('checked', true);
                    $('input[id="payon_paypal"]').attr('disabled', false);
                    var paypal = document.getElementById("payon_paypal");
                    if (paypal.checked) {
                        self.createOrder();
                        $('#creditCardDetailsView').removeClass('hidden');
                        if (this.id == "paypalCardId") {} else {

                            $('#paypalSection').addClass('hidden');
                        }
                        $('#paymentMethodView').addClass('hidden');
                        $('.cnpForm').show();
                    } else {
                        $('.cnpForm').hide();
                    }
                });

            }
        });


        // Coupon Code on Payment Page
        $(document).on('click', "#btnCouponOk", function() {
            var is_Coupon = $('#VoucherCode');
            var voucherValue = $('#VoucherCode').val();
            app.analytics.pushVoucher(voucherValue);
            if (is_Coupon.val() == "") {

                $('#vouchercoupon').removeClass('hidden');
                $('.error_invalid').addClass('hidden');
                var errorVal = $('.error_invalid').html();
                app.analytics.pushEvent('Click', 'checkout', 'invalid', is_Coupon);
                app.analytics.pushEvent('Click', 'checkout', errorVal, is_Coupon);
            } else {
                shoppingBasket.prototype.applyCoupon();

            }
        });
        $('.zeroorderbutton').click(function() {

            window.location.replace($('#fullURL').val());

        });

        $(document).on('click', "#persDetails_menu", function() {
            self.personalDetails();
            self.addressList();
        });
        $("input[type='text']").on('input', function() {
            $('#vouchercoupon').addClass('hidden');
        });
        $("input[type='text']").on('input', function() {
            $('#vouchercouponinvalid').addClass('hidden');
        });
        $('input[name="cartType"]').click(function() {
            self.createOrder();
            $('#creditCardDetailsView').removeClass('hidden');
            if (this.id == "paypalCardId") {


            } else {

                $('#paypalSection').addClass('hidden');
            }
            $('#paymentMethodView').addClass('hidden');

        });
        // Prathap End payment CheckBox Validation process----*/

        $('.expand-details').click(function() {
            if ($("#basket-details").hasClass("hidden")) {
                $("#basket-details").removeClass("hidden");
                $(this).children().removeClass("glyphicon-menu-down");
                $(this).children().addClass("glyphicon-menu-up");
            } else {
                $("#basket-details").addClass("hidden");
                $(this).children().removeClass("glyphicon-menu-up");
                $(this).children().addClass("glyphicon-menu-down");
            }
        });

        var firstStep = $('div[data-section="checkout"]')[0];

        $(firstStep).find('.checkout-step').addClass('active');

        $("#chkClaimData").on('click', function() {
            var isChecked = this.checked;
            var input = $(this);
            var vatForm = $(this).closest('.panel-collapse').find('.value-tax')
            if (isChecked) {
                $('.value-tax').show();
                $('#tax_FirstName').focus();
                $('#claimMyself').prop('checked', true);
                self.populateTaxform(vatForm);
            } else {
                $('.value-tax').hide();
            }
        });

        $("#billingDiffers").on('click', function() {
            $('#billing_ShowAddress').addClass('hidden');
            var isChecked = this.checked;
            var input = $(this);
            if (isChecked) {
                $('.billing-address').show();
                $("#billing_title").val($("#contact_title").val());
                $("#billing_firstName").val($("#contact_firstName").val());
                $("#billing_lastName").val($("#contact_lastName").val());
                $("#billing_firstName").addClass('valid');
                $("#billing_lastName").addClass('valid');
                displayBillingAddressView();
            } else {
                $('.billing-address').hide();
            }
        });
        $('.checkout-steps').find('.panel-heading').find('h2').click(function() {
            if ($(this).attr('isExpandPanel')) {

                var parent = $(this).closest('div[data-section]');
                $(parent).find('.panel-collapse').collapse('show');
                $(parent).find('.glyphicon-menu-down').addClass('hidden');
                var otherSection = $('div[data-section]').not(parent);

                $(otherSection).find('.glyphicon-menu-down').removeClass('hidden');
                $(otherSection).find('.panel-collapse').collapse('hide');
                $(otherSection).find('h2.panel-title').removeClass('active');
                $(otherSection).find('.checkout-step').removeClass('active');
                var payonform = $(otherSection)
                    .find('.payonForm');
                if (payonform.length <= 0)
                    payonform = $('.cnpForm');

                $(payonform).hide();
                $(parent).next().find(
                    '.panel-default').find(
                    'h2').removeAttr(
                    'isExpandPanel');

                $(this).addClass('active');
                $(this).closest('div[data-section]').find('.checkout-step').addClass('active');
                var eventLabel = $(this).find('strong').html();
                if (eventLabel != null) {
                    app.analytics.pushEvent('Click', 'Checkout', '/checkout/step1/create_account', 'FSL |Checkout Step 1 | Create account');
                } else {
                    app.analytics.pushEvent('Click', 'Checkout', '/checkout/step2/shipping_address', 'FSL |Checkout Step 2 | Shipping Address');
                }

            }
        });

        self.validateForm();
        self.productsSelected();
        $("#contact_terms").on('click', function() {
            var isChecked = this.checked;
            var input = $(this);
            if (isChecked) {
                input.removeClass("invalid").addClass("valid");
                input.next().removeClass("error_show").addClass("error");
            } else {
                input.removeClass("valid").addClass("invalid");
                input.next().removeClass("error").addClass("error_show");
            }
        });
        $(".claimMyself").on('click', function() {
            var parent = $(this).parents('.value-tax');
            self.populateTaxform(parent);
        });

        $(".btnCheckoutNext").click(function(event) {
            var currentButton = $(this);
            var parent = $(this).closest('div[data-section]');
            var objValidator = app.utils.validator;
            var error_free = objValidator.submitForm($("#checkout-form"), parent);
            var form = $("#checkout-form");
            var sectionId = $(parent).attr('id');
            var serviceUrl = "";
            var methodType = "";

            if (!error_free) {
                event.preventDefault();

            } else {
                event.preventDefault();
                switch (sectionId) {
                    case "create-account":
                        //alert("create-account");
                        currentButton.attr('disabled', 'disabled').css("opacity", ".65");
                        $(".checkout-steps .create-user .agree").css("margin-bottom", "0px");
                        $(".checkout-steps .checkboxOrange.checkboxmarginnotify").css("margin-bottom", "0px");
                        $(".UserRegistration-loading").show();
                        if ($(window).width() < 768) {
                            $("#create-account .nxt-btn").css("margin-top", "50px");
                        };
                        if ($(window).width() < 375) {
                            $(".checkout-steps .checkboxOrange.checkboxmarginnotify").css("margin-bottom", "75px");
                        }; 
                        var register = {}
                        var customerId = readCookie('username');
                        if ((customerId == "") || (customerId == undefined) || (customerId == null)) {
                            serviceUrl = $("#registration-url").attr('value');
                            methodType = "POST";
                            register["prefix"] = $("#contact_title").val();
                            register["firstname"] = $("#contact_firstName").val();
                            register["lastname"] = $("#contact_lastName").val();
                            var clientTaxCode = $("#contact_clientcode").val();
                            if (clientTaxCode != "" && clientTaxCode != null) {
                                register["fiscal_code"] = clientTaxCode;
                            }
                            register["email"] = $("#register_email").val();
                            register["confirmationemail"] = $("#confirmEmail").val();
                            register["password"] = $("#pwd").val();
                            register["confirmationpassword"] = $("#confirmPassword").val();
                            register["in_checkout"] = 1;
                            if ($('#chkAcceptReceive').prop('checked') == true) {
                                register["checkout_customer_isnewsletter"] = 1;
                            } else {
                                register["checkout_customer_isnewsletter"] = 0;
                            }

                        } else {
                            serviceUrl = $("#updatepersonaldetails-url").val();
                            methodType = "PUT";
                            register["prefix"] = $("#contact_title").val();
                            register["firstname"] = $("#contact_firstName").val();
                            register["lastname"] = $("#contact_lastName").val();
                            var clientTaxCode = $("#contact_clientcode").val();
                            if (clientTaxCode != "" && clientTaxCode != null) {
                                register["fiscal_code"] = clientTaxCode;
                            }
                            register["email"] = $("#register_email").val();
                            register["confirmationemail"] = $("#confirmEmail").val();
                            register["new_password"] = $('#confirmPassword').val();
                            if ($('#chkAcceptReceive').prop('checked') == true) {
                                register["comm_channel"] = "EMAIL";
                            } else {
                                register["comm_channel"] = "";
                            }
                        }
                        app.appGateway.ajaxCallCheckout(methodType, serviceUrl, register, accSuccessCallback, accErrorCallback, currentButton);
                        break;
                    case "shipping-address":
                        var newUser = false;
                        if (sortedAddress && sortedAddress.address.length > 0) {
                            newUser = false;
                            setUserAddress(sortedAddress, currentButton, newUser);
                        } else {
                            newUser = true;
                            setUserAddress(sortedAddress, currentButton, newUser);
                        }
                        //alert(newUser);
                        break;
                    case "payment":
                        self.navigate(currentButton);
                        break;
                    default:
                        self.navigate(currentButton);
                        break;
                }
            }
        });

        function accSuccessCallback(data, currentButton) {
            $(".checkout-steps .create-user .agree").css("margin-bottom", "35px");
            $(".checkout-steps .checkboxOrange.checkboxmarginnotify").css("margin-bottom", "60px");
            currentButton.removeAttr('disabled').css("opacity", "1");
            if ($(window).width() < 768) {
                $("#create-account .nxt-btn").css("margin-top", "100px");
            };
            if ($(window).width() < 375) {
				$(".checkout-steps .checkboxOrange.checkboxmarginnotify").css("margin-bottom", "145px");
            }; 
            $(".UserRegistration-loading").hide();
            if (data.messages.allErrors == "") {
                var fetchedUserid = readCookie('username');
                if ((fetchedUserid == "" || fetchedUserid == null) && data.ID != 0) {
                    addCookie('userid', data.ID, cookieTimeout);
                }
                addCookie('username', $("#contact_title").val() + " " + $("#contact_firstName").val() + " " + $("#contact_lastName").val(), cookieTimeout);
                $('.global-message').html('');
                $("#zero-addr").removeClass('hidden');
                $("#4001").addClass("hidden");
                self.getShipmentTypeDetails();
                self.navigate(currentButton);
                $("#shipping_title").val($("#contact_title").val());
                $("#shipping_firstName").val($("#contact_firstName").val());
                $("#shipping_firstName").addClass('valid');
                $("#shipping_lastName").val($("#contact_lastName").val());
                $("#shipping_lastName").addClass('valid');
                displayShippingAddressView();
                app.analytics.pushEvent('checkoutregister', 'checkoutregister', 'direct checkout', 'direct checkout success');
                app.analytics.onCheckout('checkout', "/checkout/step2/Shipping_address", "FSL |Checkout Step 2| Shipping Address", 2, productsArray);
            } else {
                var errorCode = data.messages.error[0].code;
                if (errorCode == 4001) {
                    $("#4001").removeClass("hidden");
                    $(location).attr('href', '#4001');
                } else if (errorCode == 3001) {
                    $("#4001").addClass("hidden");
                    var errormsg = "<font size='2' color='red'>" + data.messages.error[0].message + "</font>";
                    $('.global-message').html(errormsg);
                }
            }
        }

        function accErrorCallback(e, currentButton) {
            $(".checkout-steps .create-user .agree").css("margin-bottom", "35px");
            $(".checkout-steps .checkboxOrange.checkboxmarginnotify").css("margin-bottom", "60px");
            currentButton.removeAttr('disabled').css("opacity", "1");
            if ($(window).width() < 768) {
                $("#create-account .nxt-btn").css("margin-top", "100px");
            };
            if ($(window).width() < 375) {
				$(".checkout-steps .checkboxOrange.checkboxmarginnotify").css("margin-bottom", "145px");
            };    
            $(".UserRegistration-loading").hide();
            app.analytics.pushEvent('checkoutregister', 'checkoutregister', 'direct checkout', 'direct checkout failure');
            window.location.replace(errorPageURL);
        }

        $('input[data-mandatory]').change(function() {
            if ($(this).prop('checked')) {
                $(this).parent().find('span').removeClass("error_show").addClass("error");
            }
        });

        expressCheckout.prototype.getFinalPaymentDetails = function() {
            var finalPaymentUrl = $("#finalPaymentUrl").attr('value');
            //alert("finalPaymentUrl");
            app.appGateway.ajaxGet("/etc/designs/paymentlist.json", successfinalpaymentordersdata, errorfinalpaymentordersdata);
        }

        function mergeJsonData(data) {
            viewCartContent = {}
            viewCartContent["shippingLabelText"] = $("#shippinglabel").val();
            viewCartContent["PaymenttotalText"] = $("#totalPricelabel").val();
            viewCartContent["discountText"] = $("#discountlabel").val();
            viewCartContent["taxLabelTextpayment"] = $("#inclusivetaxlabel").val();
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

        function successfinalpaymentordersdata(data) {
          //  var dataContent = mergeJsonData(data);
            //$.extend(data, dataContent);
            expressCheckout.prototype.handlerFinalPaymentData(data);
        }

        function errorfinalpaymentordersdata(e) {
            //alert("error");
            window.location.replace(errorPageURL);
        }

        expressCheckout.prototype.handlerFinalPaymentData = function(data) {
            //alert("test in checkout handler");
            var checkboxcheck = $('#termscondCheckId').prop('checked');
            if (checkboxcheck == true) {
                $('.cnpForm').show();
            } else {
                //$('.cnpForm').hide();
                $('.cnpForm').show();
            }
            productsArray = [];
			/*if (data.messages.allErrors == ""){
				var productCount = data.productCount;
				var active_step = $(".active").html();
				for (var i = 0; i < data.cart[0].product.length; i++) {
					var eachProd = {
						'name': data.cart[0].product[i].name,
						'id': data.cart[0].product[i].sku,
						'price': data.cart[0].product[i].price_incl_tax,
						'quantity': data.cart[0].product[i].qty
					}
					productsArray.push(eachProd);
				}
				viewCheckoutBasketHTML = Handlebars.templates['viewCheckoutBasket-template'](data);
				$("#basketPlace").html(viewCheckoutBasketHTML);
				viewCheckoutPaymentHTML = Handlebars.templates['viewCheckoutPayment-template'](data);
				$("#tablePlaceshipping").html(viewCheckoutPaymentHTML);
				viewCheckoutPaymentmobileHTML = Handlebars.templates['viewCheckoutPayment-template-mobile'](data);
				$("#tablePlaceMobileshipping").html(viewCheckoutPaymentmobileHTML);
				shoppingBasket.prototype.displayPaymentMethods();
				app.analytics.onCheckout('checkout', "/checkout/step3/payment", "FSL |Checkout Step 3 | Payment", 3, productsArray);
			} else {
				var errorCode = data.messages.error[0].code;
				var errorMessage = data.messages.error[0].message;
				app.analytics.pushError('500', 'Error occurred while fetching cart info at the payment step:' + errorCode + "::" + errorMessage, location.href, document.referrer);
				window.location.replace(errorPageURL);
			}*/
        }

        $("#datepickerIcon").on('click', function() {
            $("#customDatePicker").datepicker("show");
        });

        expressCheckout.prototype.populateTaxform = function(taxform) {
            var parent = $(taxform);
            $('#addrlookupCheck').addClass('hidden');
            $('#vat_FindAddressData').addClass('hidden');
            $('#vat_ManualAddressData').removeClass('hidden');
            if (sortedAddress == "") {
                var vat_firstName = $('#shipping_firstName').val();
                var vat_lastName = $('#shipping_lastName').val();
                
                var vat_address = $('#shipping_address').val();
                var vat_addressOne = $('#shipping_addrss1').val();
                var vat_addressLookUp1 = $('#shipping_addressline_one').val();
                var vat_addressLookUp2 = $('#shipping_addrssline_two').val();
                var vat_addressFull = vat_addressLookUp1 + " " + vat_addressLookUp2;
                var vat_postCode = $('#shipping_postCode').val();
                var vat_postCodeLookUp = $('#shipping_contact_postCode').val();
                var vat_city = $('#shipping_city').val();
                var vat_cityLookUp = $('#shipping_contact_city').val();

                $('#tax_FirstName').val(vat_firstName);
                $('#tax_FirstName').addClass("valid").removeClass("invalid");
				
				 $('#tax_LastName').val(vat_lastName);
                $('#tax_LastName').addClass("valid").removeClass("invalid");

                if ($('#shipping_ManualAddressData').attr('class') == "hidden") {
                    $('#tax_HomeAddress').val(vat_addressLookUp1);
                    $('#tax_HomeAddress').addClass("valid").removeClass("invalid");
                    $('#tax_HomeAddressOne').val(vat_addressLookUp2);
                    $('#tax_HomeAddressOne').addClass("valid").removeClass("invalid");

                    $('#tax_PostalCode').val(vat_postCodeLookUp);
                    $('#tax_PostalCode').addClass("valid").removeClass("invalid");
                    $('#tax_City').val(vat_cityLookUp);
                    $('#tax_City').addClass("valid").removeClass("invalid");
                } else if ($('#shipping_FindAddressData').attr('class') == "hidden") {
                    $('#tax_HomeAddress').val(vat_address);
                    $('#tax_HomeAddress').addClass("valid").removeClass("invalid");
                    $('#tax_HomeAddressOne').val(vat_addressOne);
                    $('#tax_HomeAddressOne').addClass("valid").removeClass("invalid");

                    $('#tax_PostalCode').val(vat_postCode);
                    $('#tax_PostalCode').addClass("valid").removeClass("invalid");
                    $('#tax_City').val(vat_city);
                    $('#tax_City').addClass("valid").removeClass("invalid");

                }
            } else {
                var selectedAddress = $('.shippingAddressPanes').find('.active-address').attr('id');
                var jsonAddress = expressCheckout.prototype.shippingAddress;
                $.each(jsonAddress.address, function(i, val) {
                    if (this.entity_id == selectedAddress) {
                        selectedObj = jsonAddress.address[i];

                        var vatError = $(".error_show");
                        $(".vatForm").find(vatError).html('');

                        $(parent).find("#tax_FirstName").val(selectedObj.firstname);
                        $(parent).find("#tax_FirstName").addClass("valid").removeClass("invalid");
						
						 $(parent).find("#tax_LastName").val(selectedObj.lastname);
                        $(parent).find("#tax_LastName").addClass("valid").removeClass("invalid");

                        if (selectedObj.street[1] == null) {
                            $(parent).find("#tax_HomeAddress").val(selectedObj.street[0]);
                        } else {
                            $(parent).find("#tax_HomeAddress").val(selectedObj.street[0]);
                            $(parent).find("#tax_HomeAddressOne").val(selectedObj.street[1]);
                        }

                        $(parent).find("#tax_HomeAddress").addClass("valid").removeClass("invalid");
                        $(parent).find("#tax_HomeAddressOne").addClass("valid").removeClass("invalid");

                        $(parent).find("#tax_PostalCode").val(selectedObj.postcode);
                        $(parent).find("#tax_PostalCode").addClass("valid").removeClass("invalid");
                        $(parent).find("#tax_City").val(selectedObj.city);
                        $(parent).find("#tax_City").addClass("valid").removeClass("invalid");
                    }
                });
            }
        }

        $(".climBehalf").on('click', function() {
            $('#ShowAddress_vat').addClass('hidden');
            var parent = $(this).parents('.value-tax');
            $('#addrlookupCheck').removeClass('hidden');
            $('#vat_FindAddress').addClass('hidden');
            $('#vat_ManualAddress').removeClass('hidden');
            $('#vat_ManualAddressData').addClass('hidden');
            $('#vat_FindAddressData').removeClass('hidden');
            $('#tax_FirstName').val("");
			 $('#tax_LastName').val("");
            $('#tax_HomeAddress').val("");
            $('#tax_HomeAddressOne').val("");
            $('#tax_PostalCode').val("");
            $('#tax_City').val("");
            $('#tax_day').val("");
            $('#tax_month').val("");
            $('#tax_year').val("");
            $('.value-tax').find('.invalid').removeClass('invalid');
            $('.value-tax').find('.error_show').html('');
            $('#tax_FirstName').removeClass("valid");
			$('#tax_LastName').removeClass("valid");
            $('#tax_HomeAddress').removeClass("valid");

            $('#tax_PostalCode').removeClass("valid");
            $('#tax_City').removeClass("valid");
            $('#tax_day').removeClass("valid");
            $('#tax_month').removeClass("valid");
            $('#tax_year').removeClass("valid");
        });

        $("#datepickerIcon").on('click', function() {
            $("#customDatePicker").datepicker("show");
        });

        var self = this;
        var addrType = "";

        $(document).on("click", ".address-panes .address-select", function() {
            $(".address-panes").find('.active-address').removeClass("active-address");
            $(this).addClass("active-address");
        });

        $(document).on("click", "input", function() {
            addrType = this.name;
            $("." + addrType + "Panes").find('.active-address').removeClass("active-address");
            $("." + addrType + "Panes").find('.hidden').removeClass("hidden");
            $("." + addrType + "Panes").find('.active-border').removeClass("active-border");

            $(this).closest(".radio-border").prev().addClass("active-address");

            $(this).closest(".radio-border").addClass("active-border");
        });

        $(document).on("click", "#removeAddr", function() {
            $("#entity_id").val(this.parentNode.id);
            $(".delete-global-message").addClass('hidden');
        });

        $(document).on("click", "#createAddr", function() {
            $('.AddressBtn').attr('disabled', 'disabled');
            $(".address-global-message").addClass("hidden");
            $("#edit-heading").hide();
            $("#create-heading").show();
            $("#edit-submit").removeClass("editSubmit");
            $("#edit-submit").addClass("createSubmit");
            $("#defaultAddr").removeAttr('disabled');
            $("#defaultAddr").removeAttr('readonly');

            if ($(this).hasClass("billingAddress")) {
                $("#addressType").val("billingAddress");
            } else if ($(this).hasClass("shippingAddress")) {
                $("#addressType").val("shippingAddress");
            }

            $(".error_show").html('');
            $("#defaultAddr").next().removeClass('checked');
            var form_data = $("#updateForm").serializeArray();
            for (var input in form_data) {
                $("#" + form_data[input].name + "").removeClass('invalid');
            }
            if (readCookie('countryCookie') == 'IT') {
                $('#overlay_ManualAddressData').removeClass('hidden');
                $('#overlay_FindAddressData').addClass('hidden');
                $('#overlay_FindAddress').addClass('hidden');
                $('#overlay_ManualAddress').addClass('hidden');
            } else {
                $('#overlay_ManualAddressData').addClass('hidden');
                $('#overlay_FindAddressData').removeClass('hidden');
                $('#overlay_FindAddress').addClass('hidden');
                $('#overlay_ManualAddress').removeClass('hidden');
            }
            self.validateForm();

        });

        $(document).on("click", "#editAddr", function() {
            $('.AddressBtn').attr('disabled', 'disabled');
            $('#contact_postCode_overlay').val('');
            var editFlowCheck = $(this).hasClass('editAddrFlow');
            $(".address-global-message").addClass("hidden");
            $("#edit-heading").show();
            $("#create-heading").hide();

            if ($(this).hasClass("billingAddress")) {
                $("#addressType").val("billingAddress");
            } else if ($(this).hasClass("shippingAddress")) {
                $("#addressType").val("shippingAddress");
            }

            var selected = this.parentNode.id;
            var json = sortedAddress;
            var selectedObj = {};
            var phone = "";

            $("#edit-submit").removeClass("createSubmit");
            $("#edit-submit").addClass("editSubmit");
            $("#entity_id").val(this.parentNode.id);
            $.each(json.address, function(i, val) {
                if (this.entity_id == selected) {

                    var formName = $("#formName").val();

                    var form_data = $("#updateForm").serializeArray();
                    for (var input in form_data) {
                        $("#" + form_data[input].name + "").removeClass('invalid');
                    }

                    selectedObj = json.address[i];
                    $("#" + formName + "_prefix").val(selectedObj.prefix);
                    $("#" + formName + "_prefix").addClass("valid");
                    $("#" + formName + "_firstNameForm").val(selectedObj.firstname);
                    $("#" + formName + "_firstNameForm").addClass("valid");
                    $("#" + formName + "_lastNameForm").val(selectedObj.lastname);
                    $("#" + formName + "_lastNameForm").addClass("valid")
                    $("#" + formName + "_cityForm").val(selectedObj.city);
                    $("#" + formName + "_cityForm").addClass("valid");
                    $("#" + formName + "_postCodeForm").val(selectedObj.postcode);
                    $("#" + formName + "_postCodeForm").addClass("valid");
                    $("#" + formName + "_address_one").val(selectedObj.street[0]);
                    $("#" + formName + "_address_one").addClass("valid");
                    $("#" + formName + "_addrss_two").val(selectedObj.street[1]);
                    $("#" + formName + "_addrss_two").addClass("valid");
                    $("#" + formName + "_AddressName").val(selectedObj.customer_address_label);
                    $("#" + formName + "_AddressName").addClass("valid");
                    $(".error_show").html('');

                    // loading
                    // manual
                    // address
                    // default
                    if (editFlowCheck) {
                        $('#overlay_ManualAddressData').removeClass('hidden');
                        $('#overlay_FindAddressData').addClass('hidden');
                        $('#overlay_FindAddress').removeClass('hidden');
                        $('#overlay_ManualAddress').addClass('hidden');
                    } else {
                        $('#overlay_ManualAddressData').addClass('hidden');
                        $('#overlay_FindAddressData').removeClass('hidden');
                        $('#overlay_FindAddress').addClass('hidden');
                        $('#overlay_ManualAddress').removeClass('hidden');
                    }
                    phone = phone + selectedObj.telephone;
                    $("#" + formName + "_phoneForm").val(phone);
                    $("#" + formName + "_phoneForm").addClass("valid");

                    if (selectedObj.is_default_billing == "1" || selectedObj.is_default_shipping == "1") {
                        $("#defaultAddr").prop('checked', true);
                        $("#defaultAddr").next().addClass('checked');
                        $('#defaultAddr').attr('readonly', true);
                        $("#defaultAddr").attr("disabled", "disabled");
                    } else {
                        $("#defaultAddr").prop('checked', false);
                        $("#defaultAddr").next().removeClass('checked');
                        $("#defaultAddr").removeAttr('disabled');
                        $("#defaultAddr").removeAttr('readonly');
                    }
                }
            });
        });

        $(document).on("click", "#add-address", function() {
            $("#updateForm")[0].reset();
            $('#contact_AddressName').addClass('valid');
            $('.modal-content').find('input').removeClass('valid');

            if ($(this).hasClass('billingCreate')) {
                $('#addressType').val('billingAddress');
            } else {
                $('#addressType').val('shippingAddress');
            }
        });

        return {
            personalDetails: expressCheckout.prototype.personalDetails
        }

    }

    function displayShippingAddressView() {
        if (fetchedCountryCookie == "GB") {
            $('#shipping_addrlookupCheck').removeClass('hidden');
            $('#shipping_ManualAddressData').addClass('hidden');
        } else {
            $('#shipping_addrlookupCheck').addClass('hidden');
            $('#shipping_FindAddressData').addClass('hidden');
            $('#shipping_ManualAddressData').removeClass('hidden');
        }
    }

    function displayBillingAddressView() {
        if (fetchedCountryCookie == "GB") {} else {
            $('#billing_addrlookupCheck').addClass('hidden');
            $('#billing_FindAddressData').addClass('hidden');
            $('#billing_ManualAddressData').removeClass('hidden');
        }
    }


    expressCheckout.prototype.productsSelected = function() {
        //alert("testtdsasf");
        var viewCart = $("#viewCartUrl").attr('value');
        app.appGateway.ajaxGet("/etc/designs/quote.json", viewCartSuccess, viewCartError);
    }

    function viewCartSuccess(data) {
		if (data.messages.allErrors == "") {
			expressCheckout.prototype.handlerData(data);
			if (data.quote_id != null) {
				var voucher = '';
				if (data.cart[0].quote.coupon_code) {
					voucher = data.cart[0].quote.coupon_code;
				}
				if (voucher != null) {
					$('#VoucherCode').attr('value', voucher);
				} else {
					$('#VoucherCode').attr('value', '');
				}
				var countrycheckcookie = readCookie('countryCookie');
				if (data.cart[0].quote.customer_is_diabetic == 1 && countrycheckcookie == "GB") {
					vatformcheckingforentry(data);
				}
			} else {
				window.location.replace($('#transactiontimeout').attr('value'));
			}
		} else {
			var errorCode = data.messages.error[0].code;
			var errorMessage = data.messages.error[0].message;
			app.analytics.pushError('500', 'Error occurred while fetching cart info for checkout header:' + errorCode + "::" + errorMessage, location.href, document.referrer);
			window.location.replace(errorPageURL);
		}
    }

    function viewCartError(e) {
        window.location.replace(errorPageURL);
    }

    expressCheckout.prototype.handlerData = function(resJSON) {
        var dataContent = mergeviewJsonData(resJSON);
        $.extend(resJSON, dataContent);
        var active_step = $(".active").html();
        var productCount = resJSON.productCount;

        productsArray = [];
        if (productCount > 0) {
            for (var i = 0; i < resJSON.cart[0].product.length; i++) {
                var eachProd = {
                    'name': resJSON.cart[0].product[i].name,
                    'id': resJSON.cart[0].product[i].sku,
                    'price': resJSON.cart[0].product[i].price_incl_tax,
                    'quantity': resJSON.cart[0].product[i].qty
                }
                productsArray.push(eachProd);
            }
        }

        var paymentDetails = resJSON.PaymenttotalText;
        if (readCookie('guestUserCookie') != null) {
            app.analytics.onCheckout('checkout', "/checkout/step1/create_account", "FSL |Checkout Step 1| Create account", 1, productsArray);
        }
        if (readCookie('username') != null && loggedInCustomer && paymentDetails != undefined) {
            app.analytics.onCheckout('checkout', "/checkout/step2/Shipping_address", "FSL |Checkout Step 2| Shipping Address", 2, productsArray);
        }
        viewCheckoutBasketHTML = Handlebars.templates['viewCheckoutBasket-template'](resJSON);
        $("#basketPlace").html(viewCheckoutBasketHTML);
    }


    expressCheckout.prototype.validateForm = function() {
        var self = this;
        var objValidator = app.utils.validator;
        var form = $('.checkout-steps');
        var $_field = '';
        /* only alphabetic fields */
        var $_firstName = $(form).find('input[id*=firstName]');
        var $_lastName = $(form).find('input[id*=lastName]');
        var $_fullName = $(form).find('input[id*=fullName]');
        var $_address = $(form).find('input[id*=address]');
        var $_city = $(form).find('input[id*=city]');
        var $_cardHolderName = $(form).find('input[id*=holderName]');
        var $_taxFirstName = $(form).find('.tax_FirstName');
		var $_taxLastName = $(form).find('.tax_LastName');
        var $_taxHomeAddress = $(form).find('.tax_HomeAddress');
        var $_taxHomeAddressOne = $(form).find('.tax_HomeAddressOne');
        var $_taxCity = $(form).find('.tax_City');
        var $_taxPostalCode = $(form).find('.tax_PostalCode');
        var $_day = $(form).find('.tax_day');
        var $_month = $(form).find('.tax_month');
        var $_year = $(form).find('.tax_year');
        /* only numeric fields */
        var $_postCode = $(form).find('input[id*=postCode]');
        var $_phone = $(form).find('input[id*=phone]');
        var $_cardNumber = $(form).find('input[id*=cardNumber]');
        var $_ccv = $(form).find('input[id*=ccv]');
        var $_email = $(form).find('input[id*=email]');
        var $_password = $(form).find('input[id*=pwd]');
        var $_confirmPassword = $(form).find('input[id*=confirmPassword]');
        var $_clientcode = $(form).find('input[id*=clientcode]');

        // ///Add Addres Overlay///////////
        var $_shippingfirstName = $('input[id*=shipping_firstNameForm]');
        var $_shippinglastName = $('input[id*=shipping_lastNameForm]');
        var $_shippingaddressone = $('input[id*=shipping_address_one]');
        var $_shippingaddresstwo = $('input[id*=shipping_addrss_two]');
        var $_shippingPostCode = $('input[id*=shipping_postCodeForm]');
        var $_shippingCity = $('input[id*=shipping_cityForm]');
        var $_shippingPhone = $('input[id*=shipping_phoneForm]');
        var $_shippingAddressName = $('input[id*=shipping_AddressName]');
        var $_shippingphoneForm = $('input[id*=shipping_phoneForm]');
        var $_shippingphone = $('input[id*=shipping_phone]');
        var $_billingphone = $('input[id*=billing_phone]');
        var $_serialNo = $('input[id*=serialNo]');

        // find address section
        var $_contactPostCode = $('input[id*=contact_postCode]');
        var $_addresslineOne = $('input[id*=addressline_one]');
        var $_addresslineTwo = $('input[id*=addressline_two]');
        var $_contactCity = $('input[id*=contact_city]');

        var $_contactFirstname = $('input[id*=contact_firstName]');
        var $_contactEmail = $('input[id*=contact_email]');

        var alphabeticFields = [$_firstName, $_lastName, $_fullName, $_city, $_cardHolderName, $_taxFirstName,$_taxLastName, $_taxCity, $_shippingfirstName,
            $_shippinglastName, $_shippingCity, $_contactCity, $_contactFirstname
        ];
        var $_alphaResult = $();

        $.each(alphabeticFields, function() {
            $_alphaResult = $_alphaResult.add(this);
        });

        var numericFields = [$_phone, $_shippingphoneForm, $_shippingphone, $_billingphone, $_cardNumber, $_ccv, $_day, $_month, $_year];
        var $_numResult = $();
        $.each(numericFields, function() {
            $_numResult = $_numResult.add(this);
        });
        var phonenumberFields = [$_phone, $_shippingphoneForm, $_shippingphone, $_billingphone];
        var $_phonenumResult = $();
        $.each(phonenumberFields, function() {
            $_phonenumResult = $_phonenumResult.add(this);
        });

        /* No format - check only for empty */

        var chkForNullFields = [$_address, $_taxHomeAddress, $_shippingaddressone, $_addresslineOne, $_shippingAddressName, $_serialNo];
        var $_nullFieldResult = $();
        $.each(chkForNullFields, function() {
            $_nullFieldResult = $_nullFieldResult.add(this);
        });

        var alphaNumericFields = [$_postCode, $_taxPostalCode, $_shippingPostCode, $_contactPostCode];
        var $_alphaNumericResult = $();
        $.each(alphaNumericFields, function() {
            $_alphaNumericResult = $_alphaNumericResult.add(this);
        });

        $_nullFieldResult.focusout('input', function() {
            var input = $(this);
            var isEmpty = objValidator.validateEmptyField(input);
            // pass isFormat as true, as there is no format
            // required for address field.
            objValidator.toggleErrorMsg(input, true);

        });
        $($_clientcode).focusout('input', function() {
            var input = $(this);
            var isValidFormat = objValidator.validateSixteenDigit(input);
            objValidator.toggleErrorMsg(input, isValidFormat, "contact_clientcode");
        });
        $($_contactEmail).focusout('input', function() {
            var input = $(this);
            var isValidFormat = objValidator
                .validateEmail(input);
            objValidator.toggleErrorMsg(input, isValidFormat, "email");

        });
        $_alphaResult.focusout('input', function() {
            var input = $(this);
            var isAlphabetic = objValidator.validateAlbhabetic(input);
            objValidator.toggleErrorMsg(input, isAlphabetic, "alpha");

        });

        $_alphaNumericResult.focusout('input', function() {
            var input = $(this);
            var isAlphaNumeric = objValidator.validateAlbhaNumeric(input);
            objValidator.toggleErrorMsg(input, isAlphaNumeric, "postal_code");

        });
        $_numResult.focusout('input', function() {
            var input = $(this);
            var val = input.val();
            var isNumeric = $.isNumeric(val);
            objValidator.toggleErrorMsg(input, isNumeric, "numeric");

        });

        $($_email).focusout('input', function() {
            var input = $(this);
            var isValidFormat = objValidator.validateEmail(input);
            objValidator.toggleErrorMsg(input, isValidFormat, "email");

        });
        $($_password).focusout('input', function() {
            var input = $(this);
            var isValidFormat = objValidator.validatePassword(input);
            objValidator.toggleErrorMsg(input, isValidFormat, "password");

        });
        $($_confirmPassword).focusout('input', function() {
            var confirmPassword = $(this);
            var parent = $(this).parent();
            var password = $(parent).siblings().find('#pwd');
            var isValidFormat = objValidator.confirmPassword(password, confirmPassword);
            objValidator.toggleErrorMsg(confirmPassword, isValidFormat, "confirm_password");
        });

        $($_day).focusout('input', function() {
            var today = new Date();
            var getYear = today.getFullYear() - 4;
            var getMonth = today.getMonth() + 1;
            var getDate = today.getDate();
            var input = $(this);
            var isValidFormat = objValidator.validateDay(input);
            objValidator.toggleErrorMsg(input, isValidFormat, "day");
            if (isValidFormat) {
                var dateField = $('#tax_day');
                var monthField = $('#tax_month');
                var yearField = $('#tax_year');
                if (objValidator.validateDay(dateField) && objValidator.validateMonth(monthField) && objValidator.validateYear(yearField)) {
                    var dateOfBirth = monthField.val() + '/' + dateField.val() + '/' + yearField.val();
                    var presentDay = getMonth + '/' + getDate + '/' + getYear;
                    if (!(objValidator.validateDob(dateOfBirth, presentDay))) {

                        objValidator.toggleErrorMsg($(this), 'false', "futureDate");
                    } else
                        $('.tax_day_error').addClass('error').removeClass('error_show');
                }
            }
        });
        $($_month).focusout('input', function() {
            var today = new Date();
            var getYear = today.getFullYear() - 4;
            var getMonth = today.getMonth() + 1;
            var getDate = today.getDate();
            var input = $(this);
            var isValidFormat = objValidator.validateMonth(input);
            objValidator.toggleErrorMsg(input, isValidFormat, "month");
            var dateField = $('#tax_day');
            var monthField = $('#tax_month');
            var yearField = $('#tax_year');
            if (isValidFormat) {

                if (objValidator.validateDay(dateField) && objValidator.validateMonth(monthField) && objValidator.validateYear(yearField)) {
                    var dateOfBirth = monthField.val() + '/' + dateField.val() + '/' + yearField.val();
                    var presentDay = getMonth + '/' + getDate + '/' + getYear;
                    if (!(objValidator.validateDob(dateOfBirth, presentDay))) {

                        objValidator.toggleErrorMsg($(this), 'false', "futureDate");
                    } else
                        $('.tax_day_error').addClass('error').removeClass('error_show');
                }
            } else {
                //To hide future date error messgae when yearfiled is invalid, if not hidden two error messages are displayed.
                if (objValidator.validateDay(dateField)) {
                    $('.tax_day_error').addClass('error').removeClass('error_show');
                }
            }

        });
        $($_year).focusout('input', function() {
            var today = new Date();
            var getYear = today.getFullYear() - 4;
            var getMonth = today.getMonth() + 1;
            var getDate = today.getDate();
            var input = $(this);
            var isValidFormat = objValidator.validateYear(input);
            objValidator.toggleErrorMsg(input, isValidFormat, "year");
            var dateField = $('#tax_day');
            var monthField = $('#tax_month');
            var yearField = $('#tax_year');
            if (isValidFormat) {

                if (objValidator.validateDay(dateField) && objValidator.validateMonth(monthField) && objValidator.validateYear(yearField)) {
                    var dateOfBirth = monthField.val() + '/' + dateField.val() + '/' + yearField.val();
                    var presentDay = getMonth + '/' + getDate + '/' + getYear;
                    if (!(objValidator.validateDob(dateOfBirth, presentDay))) {

                        objValidator.toggleErrorMsg($(this), 'false', "futureDate");
                    } else
                        $('.tax_day_error').addClass('error').removeClass('error_show');
                }

            } else {
                //To hide future date error messgae when yearfiled is invalid, if not hidden two error messages are displayed.
                if (objValidator.validateDay(dateField)) {
                    $('.tax_day_error').addClass('error').removeClass('error_show');
                }
            }
        });

        $('#confirmEmail').focusout('input', function() {
            var email = $('#register_email');
            var isMatched = objValidator.confirmEmail(email, $(this));
            objValidator.toggleErrorMsg($(this), isMatched, "confirm_email");
        });

        $($_phonenumResult).focusout('input', function() {
            var input = $(this);
            var isValidFormat = objValidator.validatePhoneNumber(input);

            objValidator.toggleErrorMsg(input, isValidFormat, "alpha");

        });

    }

    expressCheckout.prototype.navigate = function(btnNext) {
        var form = $(btnNext).closest('form');
        var currentSection = $(btnNext).closest('div[data-section]');
        $(currentSection).find('.collapse').collapse('hide');
        var currentIndex = $(currentSection).attr('data-index');
        $(currentSection).find('.glyphicon-menu-down').removeClass('hidden');
        var nextSection = $('div[data-index=' + parseInt(parseInt(currentIndex) + 1) + ']');
        $(nextSection).find('.collapse').collapse('show');
        $(nextSection).find('.glyphicon-menu-down').addClass('hidden');
        var currentPanel = $(currentSection).find('.panel-collapse');
        var currentHeader = $(currentSection).find('.panel-heading').find('h2');
        $(currentHeader).removeClass('active');
        $(currentHeader).attr('isExpandPanel', true);
        $(currentSection).find('.checkout-step').removeClass('active');
        $(nextSection).find('.panel-heading').find('h2').addClass('active');
        $(nextSection).find('.checkout-step').addClass('active');
       /* var payonform = $(nextSection).find('.payonForm');
        if (payonform.length <= 0)
            payonform = $('.cnpForm');
        $(payonform).show();

        setTimeout(function() {
            var sectionOffset = $(nextSection).find(
                '.panel-body').offset().top;
            $(window).scrollTop(sectionOffset - 300);
        }, 200);*/
    }

    expressCheckout.prototype.addressList = function() {
        //alert("addressList");
        var addressList = null;
        var listAddressUrl = $("#listAddressServiceUrl").attr('value');
        if (listAddressUrl != null) {
            $('.address-loading').show();
            $('#vatForUK').hide();
            $('.btnCheckoutNext').hide();
            app.appGateway.ajaxGet("/etc/designs/addresslist1.json", listaddrSuccessCallback, listaddrErrorCallback);
        }
    }

    function listaddrSuccessCallback(data) {
        //alert("listaddrSuccessCallback")
        if (data.messages.allErrors == "") {
            $('.address-loading').hide();
            if (readCookie('countryCookie') == "GB") {
                $('#vatForUK').show();
            }
            $('.btnCheckoutNext').show();
            if ($('body').hasClass('Checkoutpage')) {
                if (data.customer_billing_address_id && data.customer_shipping_address_id) {
                    if (readCookie('changepayment') != '' && readCookie('changepayment') == 'yes') {
                        $('.shipping-address').find('.panel-collapse').removeClass('in');
                        $('.shipping-address').find('.checkout-step').removeClass('active');
                        $('.shipping-address').find('h2').attr('isExpandPanel', 'true');
                        $('.shipping-address').find('h2 .glyphicon-menu-down').removeClass('hidden');
                        $('.payment').find('.panel-collapse').addClass('in');
                        $('.payment').find('.checkout-step').addClass('active');
                        $('html,body').animate({
                            scrollTop: document.body.scrollHeight
                        }, 700);
                        removeCookie('changepayment', '');
                        expressCheckout.prototype.getFinalPaymentDetails();
                    }
                }
            }
            if (data.address.length == 0) {
                $("#zero-addr").removeClass('hidden');
                $("#list-addr").addClass('hidden');
                $('#shipping-address').find('.panel-collapse').show();
                $("#shipping-address").find('#checkoutnumber').text("1");
                $("#payment").find('.checkout-step').text("2");
                $(".createNewAddr").show();
                displayShippingAddressView();
            } else {
                expressCheckout.prototype.renderAddressList(data);
                $(".createNewAddr").hide();
            }
        } else {
            var errorCode = data.messages.error[0].code;
            var errorMessage = data.messages.error[0].message;
            app.analytics.pushError('500', 'Error occurred in retrieving address:' + errorCode + "::" + errorMessage, location.href, document.referrer);
            window.location.replace(errorPageURL);
        }
    }

    function listaddrErrorCallback(e) {
        $('.address-loading').hide();
        if (readCookie('countryCookie') == "GB") {
            $('#vatForUK').show();
        }
        $('.btnCheckoutNext').show();
        window.location.replace(errorPageURL);
    }

    expressCheckout.prototype.personalDetails = function() {
        //alert("test personalDetails");
        profiledetailsServiceUrl = $("#profiledetailsServiceUrl").val();
        app.appGateway.ajaxGet("/etc/designs/personaldetails1.json", profiledetailsgetsuccessCallback, profiledetailsgeterrorCallback);
    }

    function profiledetailsgetsuccessCallback(data) {
        if (data.messages.allErrors == "") {
            if (data.comm_channel != null) {
                var chkOptions = $('#regisNotification').find('input[type=checkbox]');
                var arr = data.comm_channel.split(",");
                $.each(chkOptions, function(key, value) {
                    var chkValue = $(value).val();
                    if (jQuery.inArray(chkValue, arr) !== -1) {
                        $(value).prop('checked', 'true');
                        $(value).closest('.checkboxOrange').find('label').addClass('checked');
                    }
                });
            }

            $('#selectTitle').val(data.prefix);
            $('#selectTitle').addClass('valid');
            $('#contact_firstName').val(data.firstname);
            $('#contact_firstName').addClass('valid').removeClass('invalid');
            $('#contact_lastName').val(data.lastname);
            $('#contact_lastName').addClass('valid').removeClass('invalid');
            $('#register_email').val(data.email);
            $('#register_email').addClass('valid').removeClass('invalid');
            $('#confirmEmail').val(data.email);
            $('#confirmEmail').addClass('valid').removeClass('invalid');

            //To hide error span
            $('#personal-details').find('.error_show').removeClass('error_show').addClass('error');
        } else {
            var errorCode = data.messages.error[0].code;
            var errorMessage = data.messages.error[0].message;
            app.analytics.pushError('500', 'Error occurred in retrieving profile:' + errorCode + "::" + errorMessage, location.href, document.referrer);
            window.location.replace(errorPageURL);
        }
    }

    function profiledetailsgeterrorCallback(e) {
        window.location.replace(errorPageURL);
    }

    expressCheckout.prototype.renderAddressList = function(data) {

        var addressLabel;
        if ($('body').hasClass('Checkoutpage')) {
            var template = Handlebars.templates['address-shipping-template'];
            addressLabel = $('#createAddress').val();
        } else {
            addressLabel = $('#adnewaddrslabel').val();
            var template = Handlebars.templates['personalDetails-template'];
        }
        sortedAddress = {
            address: []
        };
        sortedbillAddress = {
            address: []
        };
        sortedAddress.address = data.address[0].list[0].shippingfirst;
        sortedbillAddress.address = data.address[0].list[0].billingfirst;

        sortedAddress.address = (sortedAddress.address).splice(0, 6);

        var billingAddress = JSON.parse(JSON.stringify(sortedbillAddress));
        var shippingAddress = JSON.parse(JSON.stringify(sortedAddress));

        $.each(billingAddress.address, function(i, val) {
            this.type = "billingAddress";
        });

        $.each(shippingAddress.address, function(i, val) {
            this.type = "shippingAddress";
        });
        expressCheckout.prototype.shippingAddress = shippingAddress;

        Handlebars.registerHelper('defaultCheck', function(a,
            b, type, block) {
            if (type == "billingAddress") {
                if (a == "1") {
                    return block.fn(this);
                } else {
                    return block.inverse(this);
                }
            } else {
                if (b == "1") {
                    return block.fn(this);
                } else {
                    return block.inverse(this);
                }
            }
        });
        Handlebars.registerHelper('addresslabel', function(labl) {
            return addressLabel;
        });
        Handlebars.registerHelper('defaultCheckPers', function(
            a, b, type, block) {
            if (a == "1" || b == "1") {
                return block.fn(this);
            } else {
                return block.inverse(this);
            }
        });

        Handlebars.registerHelper('firstDef', function(a, type, block) {
            if (a == "0") {
                return block.fn(this);
            } else {
                return block.inverse(this);
            }
        });
        $('.shippingAddressPanes').html(template(shippingAddress));
        $('.billingAddressPanes').html(template(billingAddress));

        $('.billingAddressPanes #add-address').addClass('billingCreate');
        $('.shippingAddressPanes #add-address').addClass('shippingCreate');

        $('.address-panes').html(template(shippingAddress));

        if (sortedAddress.address.length > 0) {
            $("#zero-addr").addClass('hidden');
            $("#list-addr").removeClass('hidden');
            $("#payment").find('#checkoutpaymentnumber').text("2");
        } else {
            $('#shipping-address').find('.panel-collapse').show();
            $("#shipping-address").find('#checkoutnumber').text("1");
            $("#payment").find('.checkout-step').text("2");
        }

        if (sortedAddress.address.length == 6) {
            $('.billingAddressPanes #add-address').hide();
            $('.shippingAddressPanes #add-address').hide();
            $('.persAddr').hide();
        } else {
            $('.billingAddressPanes #add-address').show();
            $('.shippingAddressPanes #add-address').show();
            $('.persAddr').show();
        }
        if ($('body').hasClass('Checkoutpage')) {
            if (data.customer_billing_address_id && data.customer_shipping_address_id) {
                var billing = $('.billingAddressPanes').find($('input[type="radio"][value="' + data.customer_billing_address_id + '"]'));
                var shipping = $('.shippingAddressPanes').find($('input[type="radio"][value="' + data.customer_shipping_address_id + '"]'));
                $(billing).trigger("click");
                $(shipping).trigger("click");
            }
        }
    }

    $(document).on('click', "#edit-submit", function() {
        var addressUrl = "";
        var address = {};
        var defaultChecked = null;
        var defaultChecked = $('#defaultAddr').prop('checked');
        var addressfield1 = "";
        var addressfield2 = "";
        var postalCode = "";
        var city = "";

        if ($("#overlay_ManualAddressData").hasClass("hidden")) {
            addressfield1 = $('#addressline_one').val();
            addressfield2 = $('#addressline_two').val();
            postalCode = $('#contact_postCode_overlay').val();
            city = $('#contact_city').val();
        } else {
            addressfield1 = $('#shipping_address_one').val();
            addressfield2 = $('#shipping_addrss_two').val();
            postalCode = $('#shipping_postCodeForm').val();
            city = $('#shipping_cityForm').val();
        }
        address["prefix"] = $('#shipping_prefix').val();
        address["firstname"] = $('#shipping_firstNameForm').val();
        address["lastname"] = $('#shipping_lastNameForm').val();
        if (addressfield2 != undefined && addressfield2.trim().length > 0) {
            address["street"] = [addressfield1, addressfield2];

        } else {
            address["street"] = [addressfield1];
        }
        address["postcode"] = postalCode;
        address["city"] = city;
        address["telephone"] = $('#shipping_phoneForm').val();
        address["country_id"] = readCookie('countryCookie');
        address["region_id"] = '1';
        address["customer_address_label"] = $('#shipping_AddressName').val();
        if (defaultChecked) {
            if ($("#addressType").val() == "billingAddress") {
                address["is_default_billing"] = 1;
            } else {
                address["is_default_shipping"] = 1;
            }
        }
        if ($('body').hasClass('account-overview')) {
            // do not send quote id to magento, if the address is getting created via account overview page
            // hence setting myAccountCheckout to 1.
            address["myAccountCheckout"] = 1;
        }

        var parent = $('.edit-address');
        var objValidator = app.utils.validator;
        var error_free = objValidator.submitForm($("#updateForm"), parent);
        if (error_free) {
            disableAddEditAddressBtns();
            if ($(this).hasClass("editSubmit")) {
                addressUrl = $("#updateAddressServiceUrl").attr('value');
                address["addressId"] = $("#entity_id").val();
                app.appGateway.ajaxPut(addressUrl, address, updateAddresssuccessCallback, updateAddresserrorCallback);
            } else if ($(this).hasClass("createSubmit")) {
                addressUrl = $("#createAddressServiceUrl").attr('value');
                app.appGateway.ajaxPost(addressUrl, address, createAddresssuccessCallback, createAddresserrorCallback);
            }
        } else {}

        var form = $("#updateForm");
        app.expressCheckout.validateForm(form);

    });

    function createAddresssuccessCallback(data) {
        enableAddEditAddressBtns();
        if (data.messages.allErrors == "") {
            $('#myModal-2').modal('hide');
            expressCheckout.prototype.addressList();
        } else {
            var errorCode = data.messages.error[0].code;
            if (errorCode == 3001) {
                var errormsg = "<div id='serviceError'><font color='red'>" + data.messages.error[1].message + "</font></div>";

                $('.address-global-message').removeClass('hidden');
                $('.address-global-message').html(errormsg);
                $(location).attr('href', '#serviceError');
            } else if (errorCode == 400) {
                var errormsg = "<div id='serviceError'><font color='red'>" + data.messages.error[0].message + "</font></div>";
                $('.address-global-message').removeClass('hidden');
                $('.address-global-message').html(errormsg);
                $(location).attr('href', '#serviceError');
            }
        }

    }

    function createAddresserrorCallback(e) {
        enableAddEditAddressBtns();
        window.location.replace(errorPageURL);
    }

    function updateAddresssuccessCallback(data) {
        enableAddEditAddressBtns();
        if (data.messages.allErrors == "") {
            $('#myModal-2').modal('hide');
            expressCheckout.prototype.addressList();
        } else {
            var errorCode = data.messages.error[0].code;
            if (errorCode == 3001) {
                var errormsg = "<div id='serviceError'><font color='red'>" + data.messages.error[1].message + "</font></div>";
                $('.address-global-message').removeClass('hidden');
                $('.address-global-message').html(errormsg);
                $(location).attr('href', '#serviceError');
            } else if (errorCode == 400) {
                var errormsg = "<div id='serviceError'><font color='red'>" + data.messages.error[0].message + "</font></div>";
                $('.address-global-message').removeClass('hidden');
                $('.address-global-message').html(errormsg);
                $(location).attr('href', '#serviceError');
            }
        }
    }

    function updateAddresserrorCallback(e) {
        enableAddEditAddressBtns();
        window.location.replace(errorPageURL);
    }
    
    function disableAddEditAddressBtns() {
        $(".EditAddress-loading").show();
        $("#edit-submit").addClass("disabled");
        $("#edit-submit").closest('.modal-footer').find('.cancel').addClass("disabled");
        $("#edit-submit").closest('.modal-content').find('.close').addClass("disabled");
    }
    
    function enableAddEditAddressBtns() {
        $(".EditAddress-loading").hide();
        $("#edit-submit").removeClass("disabled");
        $("#edit-submit").closest('.modal-footer').find('.cancel').removeClass("disabled");
        $("#edit-submit").closest('.modal-content').find('.close').removeClass("disabled");
    }

    $(".infoSubmit").on('click', function(evt) {
        evt.preventDefault();
        var personaldetails = {};
        var resetpwdcheckbox = $('#changePasswordCheck:checked').val();
        $("#pers-success").addClass("hidden");
        $("#pers-failure").addClass("hidden");
        $("#3001").addClass("hidden");
        personaldetails["prefix"] = $('#selectTitle').val();
        personaldetails["firstname"] = $('#contact_firstName').val();
        personaldetails["lastname"] = $('#contact_lastName').val();
        personaldetails["email"] = $('#register_email').val();
        personaldetails["confirmationemail"] = $('#confirmEmail').val();
        if (resetpwdcheckbox == "on") {
            personaldetails["new_password"] = $('#confirmPassword').val();
        }
        var sList = [];
        $('input[type=checkbox]').each(function() {
            if (this.checked) {
                if (this.id != "changePasswordCheck") {
                    sList.push(this.value);
                }
            }
        });
        personaldetails["comm_channel"] = sList.toString();
        personaldetailsUrl = $("#updatepersonaldetailsServiceUrl").attr('value');
        var parent = $('#personal-details');
        var objValidator = app.utils.validator;
        var error_free = objValidator.submitForm($("#detailsForm"), parent);
        if (!error_free) {
            evt.preventDefault();

        } else {
            $(".infoSubmit").addClass("disabled");
            $(".personaldetails-loading").show();
            app.appGateway.ajaxPut(personaldetailsUrl, personaldetails, personaldetailssuccessCallback, personaldetailserrorCallback);
        }
    });

    function personaldetailssuccessCallback(data) {
        $(".personaldetails-loading").hide();
        $(".infoSubmit").removeClass("disabled");
        if (data.messages.allErrors == "") {
            var successCode = data.messages.success.code;
            if (successCode == 2033) {
                $("#pers-success").removeClass("hidden");
                var userNameLabel = $("#selectTitle").val() + " " + $("#contact_firstName").val() + " " + $("#contact_lastName").val();
                addCookie('username', userNameLabel, cookieTimeout);
                $('.panelUserName').html(' ' + userNameLabel);
                $('#user_name').text(userNameLabel);
                $('html, body').animate({scrollTop : $('#pers-success').offset().top-30},1000);
            }
        } else if (data.messages.allErrors != null) {
            var errorCode = data.messages.error[0].code;
            var errorMsg = "<font color='red'>" +
                data.messages.error[1].message +
                "</font>";
            if (errorCode == 3001) {
                $("#3001").removeClass("hidden");
                $("#3001").html(errorMsg);
                $('html, body').animate({scrollTop : $('#3001').offset().top-30},1000);
            } else {
                $("#pers-failure").removeClass("hidden");
                $('html, body').animate({scrollTop : $('#pers-failure').offset().top-30},1000);
            }
        }
    }

    function personaldetailserrorCallback(e) {
        $(".personaldetails-loading").hide();
        $(".infoSubmit").removeClass("disabled");
        $("#pers-failure").removeClass("hidden");
         $('html, body').animate({scrollTop : $('#pers-failure').offset().top-30},1000);
        window.location.replace(errorPageURL);
    }
    $("#remove_address").on('click', function(event) {
        var delAddressUrl = $("#deleteAddressServiceUrl").attr('value');
        var addressId = $("#entity_id").val();
        var delAddressUrl = delAddressUrl + '/' + addressId;
        disableRemoveAddressBtns();
        app.appGateway.ajaxDelete(delAddressUrl, deladdresssuccessCallback, deladdresserrorCallback);
    });

    function deladdresssuccessCallback(data) {
        enableRemoveAddressBtns();
        if (data.messages.allErrors == "") {
            $('#myModal-3').modal('hide');
            expressCheckout.prototype.addressList();
        } else {
            var errorCode = data.messages.error[0].code;
            if (errorCode == 3001) {
                var errormsg = "<font color='red'>" + data.messages.error[1].message + "</font>";
                $('.delete-global-message').removeClass('hidden');
                $('.delete-global-message').html(errormsg);
            } else if (errorCode == 400) {
                var errormsg = "<font color='red'>" + data.messages.error[0].message + "</font>";
                $('.delete-global-message').removeClass('hidden');
                $('.delete-global-message').html(errormsg);
            }

        }
    }

    function deladdresserrorCallback(e) {
        enableRemoveAddressBtns();
        window.location.replace(errorPageURL);
    }
    
    function enableRemoveAddressBtns() {
        $(".RemoveAddress-loading").hide();
        $("#remove_address").removeClass("disabled");
        $("#remove_address").closest('.modal-footer').find('.cancel').removeClass("disabled");
        $("#remove_address").closest('.modal-content').find('.close').removeClass("disabled");
    }
    
    function disableRemoveAddressBtns() {
        $(".RemoveAddress-loading").show();
        $("#remove_address").addClass("disabled");
        $("#remove_address").closest('.modal-footer').find('.cancel').addClass("disabled");
        $("#remove_address").closest('.modal-content').find('.close').addClass("disabled");
    }

    $(document).on('click', "#warrenty-back", function(e) {
        e.preventDefault();
        $(".Warrenty-loading").hide();
        $("#warrenty-success").addClass("hidden");
        $("#warrenty-section").removeClass("hidden");
        $("#serialNo").removeClass("valid");
        $("#Pleasereaduncheck").removeClass("checked");
        $('label[for="Pleasecheck"]').removeClass("checked");
        $("#Pleasecheck").prop('checked', false);
    });

    $("#warrtySubmit,#xswarrtySubmit").on('click', function(evt) {
		evt.preventDefault();	
        $('#serialNOErrorwarrenty').removeClass('hidden');
        $("#4035").addClass("hidden");
        $("#invalid_warrenty").addClass("hidden");
        $('#warrantyAccept').removeClass('hidden');
        var extendWarranty = {};
        extendWarranty["serial_number"] = $('#serialNo').val();
        extendWarrantyServiceUrl = $("#extendWarrantyServiceUrl").attr('value');
        var parent = $('#warrenty-section');
        var objValidator = app.utils.validator;
        var error_free = objValidator.submitForm($("#warrentyForm"), parent);
        if (!error_free) {
            evt.preventDefault();

        } else {
            $("#warrtySubmit").addClass("disabled");
            $("#xswarrtySubmit").addClass("disabled");
            $(".Warrenty-loading").show();
            app.appGateway.ajaxPut(extendWarrantyServiceUrl, extendWarranty, extendedWarrantysuccessCallback, extendedWarrantyerrorCallback);
        }
       var $body = $(document);
        if ($body.scrollTop() !== 0 && $("#serialNo").val()=="") {
            $('html,body').animate({scrollTop: $('#stdWarrenty').offset().top},'fast');
        }

    });
    $("input[type='text']").on('input', function() {
        $('#serialNOErrorwarrenty').addClass('hidden');
    });

    function extendedWarrantysuccessCallback(data) {
        $(".Warrenty-loading").hide();
        $("#warrtySubmit").removeClass("disabled");
        $("#xswarrtySubmit").removeClass("disabled");
        $('html,body').animate({scrollTop: $('#stdWarrenty').offset().top},'slow');
        var jsonSuccessMesg = data.messages.success.message;
        var serialNumber = $('#serialNo').val();
        //app.analytics.pushEvent('Click', 'MyAccount' , 'Standard Warranty' , '');
        if (jsonSuccessMesg != null) {
            $("#warrenty-success").removeClass("hidden");
            $("#warrenty-section").addClass("hidden");
            $("#serialNo").val('');
            $('#Pleaseread').prop('checked', false);
            $('#Pleasecheck').prop('checked', false);
            app.analytics.pushEvent('Click', 'MyAccount', 'Standard Warranty', 'Submit');
        } else if (data.messages.allErrors != null) {
            var jsonErrorcode = data.messages.error[0].code;
            var jsonErrorMsg;
            if (jsonErrorcode == 4035) {
                $("#4035").removeClass("hidden");
                jsonErrorMsg = $("#4035").html();
                app.analytics.pushEvent('Click', 'MyAccount', jsonErrorMsg, serialNumber);
            } else {
                $("#invalid_warrenty").removeClass("hidden");
                jsonErrorMsg = $("#invalid_warrenty").html();
                app.analytics.pushEvent('Click', 'MyAccount', jsonErrorMsg, serialNumber);
            }
        }
    }

    function extendedWarrantyerrorCallback(e) {
        $(".Warrenty-loading").hide();
        $("#warrtySubmit").removeClass("disabled");
        $("#xswarrtySubmit").removeClass("disabled");
        $('html,body').animate({scrollTop: $('#stdWarrenty').offset().top},'slow');
        var serialNumber = $('#serialNo').val();
        $('#serialNOErrorwarrenty').removeClass('hidden');
        app.analytics.pushEvent('Click', 'MyAccount', e, serialNumber);
        window.location.replace(errorPageURL);
    }

    //Prathap Changes for PayPal and Payon and Create Order Service=========================
    expressCheckout.prototype.getPaypalForm = function(token) {
        var plainstyle = '';
        if (fetchedCountryCookie == "IT") {
            plainstyle = "?compressed=false&language=it&style=plain";
        } else {
            plainstyle = "?compressed=false&language=en&style=plain";
        }
        var active_step = $(".active").html();
        var htmlForm = '';
        $('.payonForm').html('');
        var urlSrcString = $("#payonPayPalURL").attr('value');
        var urlString = urlSrcString + token + plainstyle;
        var form = $('.payonForm');
        if (form.length <= 0)
            form = $('.cnpForm');
        if ($('#payon_cc').prop('checked')) {
            if (fetchedCountryCookie == "GB") {
                $(form).html('VISA MASTER AMEX MAESTRO');
            } else if (fetchedCountryCookie == "IT") {
                $(form).html('VISA MASTER AMEX');
            }
            app.analytics.onCheckoutPayment('checkoutOption', 3, 'credit card');
        }
        if ($('#payon_paypal').prop('checked')) {
            $(form).html('PAYPAL');
            app.analytics.onCheckoutPayment('checkoutOption', 3, 'paypal');
        }
        $(form).attr('id', token);
        $('.cnpForm').show();
        addScript(urlString);
        $(".token").attr('src', token);
    }

    function addScript(src) {
        var s = document.createElement('script');
        s.setAttribute('src', src);
        s.async = true;
        document.body.appendChild(s);
    }

    // Prathap Create Order Start here
    expressCheckout.prototype.createOrder = function() {

        $('#termscondCheckId').attr('readonly', 'readonly');
        $('#termscondCheckId').attr('disabled', 'disabled');
        var postdatadetailsoforder = expressCheckout.prototype
            .postdatadetailsoforder();
        var dataParam = postdatadetailsoforder;
        var createorderUrl = $("#createorderUrl").attr('value');
        $('.payOptions-loading').show();
        app.appGateway.ajaxPost(createorderUrl, dataParam,
            createordersuccesscallback,
            createordererrorcallback);
    }

    function createordersuccesscallback(data) {
        if (data.createOrderResponse != null && data.createOrderResponse.messages.allErrors == '') {
            if (data.createOrderResponse.orderCreated) {
                $('.payOptions-loading').hide();
                removeCookie('productCount', '');
                $('.basketitems').text('0');
                $('.paymentSuccess').removeClass('hidden');
                $(".order-status-loading").hide();
                expressCheckout.prototype.googleAnalyticstrnsactionforzero(data);
            } else if (!data.createOrderResponse.orderCreated && (data.transaction == null)) {
                $('.payOptions-loading').hide();
                $('.paymentError').removeClass('hidden');
            } else {
                var transctoken = data.transaction.token;
                expressCheckout.prototype.getPaypalForm(transctoken);
            }
        } else {
            $('.payOptions-loading').hide();
            // unable to create order; Error occurred while creating order
            app.analytics.pushError('Error', data.createOrderResponse.messages.allErrors, location.href, document.referrer);
            window.location.replace($('#transactiontimeout').attr('value'));
        }
    }

    function createordererrorcallback(e) {
        $('.payOptions-loading').hide();
        window.location.replace(errorPageURL);
    }

    //Start of Order Call Creation
    expressCheckout.prototype.postdatadetailsoforder = function() {
        var postdataforordercreation = {};
        if ($("#payon_cc").prop('checked')) {
            postdataforordercreation["payment_method"] = 'payon_cc';
        } else if ($("#payon_paypal").prop('checked')) {
            postdataforordercreation["payment_method"] = 'payon_paypal';
        } else {
            postdataforordercreation["payment_method"] = 'free';
        }
        return postdataforordercreation;
    }

    //Set Shipping Charges
    expressCheckout.prototype.getShipmentTypeDetails = function() {
        //alert("getShipmentTypeDetails testttt");
        var self = this;
        var getshippingchargesURL = $("#getshippingchargesURL").attr('value');
        if (getshippingchargesURL != null) {
            //app.appGateway.ajaxGet("/etc/designs/shippingdetails.json", shipmethodSuccessCallback, shipmethodErrorCallback);
            app.appGateway.ajaxGet("/etc/designs/shippingdetails.json", shipmethodSuccessCallback, shipmethodErrorCallback);
        }
    }

    function shipmethodSuccessCallback(data) {
       // alert("shipmethodSuccessCallback "+JSON.stringify(data));
		if (data.messages.allErrors == ""){
			var fees = data.shipping.list[0].config.express.fees;
			var currency = data.currency;
			var shippingMethodCode = data.shipping.list[0].value;
            //alert("test  "+data.shipping.list[0].value);
			var shippingMethodType = "standard";
			//app.analytics.onCheckoutShipping('checkoutOption', '2', shippingMethodType);
			$(".currency").html(currency);
			$(".shippingfees").html(fees);
			var shippingMethodCodeHidden = "#shippingMethodCode";
			$(shippingMethodCodeHidden).val(shippingMethodCode);

			if ($("#contact_title").val() == "" || $("#contact_title").val() == 'select') {
				var profiledetailsServiceUrl = $("#profiledetailsServiceUrl").val();
				if (readCookie('username') != null && readCookie('username') != '' && loggedInCustomer) {
					app.appGateway.ajaxGet("/etc/designs/personaldetails1.json", profileSuccessCallback, profileFailureCallback);
				}
			}
		} else {
			var errorCode = data.messages.error[0].code;
			var errorMessage = data.messages.error[0].message;
			//app.analytics.pushError('500', 'Error occurred while fetching shipment method type:' + errorCode + "::" + errorMessage, location.href, document.referrer);
			window.location.replace(errorPageURL);
		}
    }

    function profileSuccessCallback(data) {
        //alert(JSON.stringify(data));
		if (data.messages.allErrors == "") {
			var successCode = data.messages.success.code;
			if (successCode == 2042) {
				$("#contact_title").val(data.prefix);
				$("#contact_firstName").val(data.firstname);
				$("#contact_lastName").val(data.lastname);
				$("#shipping_title").val($("#contact_title").val());
				$("#shipping_firstName").val($("#contact_firstName").val());
				$("#shipping_firstName").addClass('valid');
				$("#shipping_lastName").val($("#contact_lastName").val());
				$("#shipping_lastName").addClass('valid');
			}
        } else {
            var errorCode = data.messages.error[0].code;
            var errorMessage = data.messages.error[0].message;
            app.analytics.pushError('500', 'Error occurred in fetching profile data in checkout:' + errorCode + "::" + errorMessage, location.href, document.referrer);
            window.location.replace(errorPageURL);
        }
    }

    function profileFailureCallback(e) {
        window.location.replace(errorPageURL);
    }

    function shipmethodErrorCallback(e) {
        window.location.replace(errorPageURL);
    }

    expressCheckout.prototype.googleAnalyticstrnsactionforzero = function(data) {
        var currency = data.createOrderResponse.order_data.order_currency_code;
        var order = data.createOrderResponse.order_id;
        var grand_total = data.createOrderResponse.order_data.grand_total;
        var tax = 0;
        var temp = '';
        var itemcount = data.createOrderResponse.item_details.length;
        var shipping = data.createOrderResponse.order_data.shipping_incl_tax;
        var coupon = data.createOrderResponse.order_data.coupon_code;
        var productsArray = [];
        if (itemcount > 0) {
            for (var i = 0; i < itemcount; i++) {
                var eachProd = {
                    'name': data.createOrderResponse.item_details[i].name,
                    'id': data.createOrderResponse.item_details[i].product_id,
                    'price': data.createOrderResponse.item_details[i].price_incl_tax,
                    'quantity': data.createOrderResponse.item_details[i].qty_ordered
                }
                productsArray.push(eachProd);
            }
            for (var i = 0; i < data.createOrderResponse.item_details.length; i++) {
                temp = data.createOrderResponse.item_details[i].tax_amount;
                tax = temp + tax;
            }
            app.analytics.transaction('transactionComplete', currency, order, grand_total, tax, shipping, coupon, productsArray);
        }
    }

    app.expressCheckout = new expressCheckout();
});

/* Card Payment Overriding and Additions */
var cnp_Options = {
    onLoad: function() {
        $('#paymentCardsLink').removeClass('hidden');
        $('.payOptions-loading').hide();
        // change brand label to Type
        if ($('#brandlabeltext').val().trim().length > 0) {
            $('.brandLabel').html($('#brandlabeltext').val().trim());
        };
        if ($('#expirymonthlabeltext').val().trim().length > 0) {
            $('.expiryMonthLabel').html($('#expirymonthlabeltext').val().trim());
        };
        // enable terms checkbox
        $('#termscondCheckId').removeAttr('readonly');
        $('#termscondCheckId').removeAttr('disabled');

        // add tooltip next to CVV
        if ($('#cvvInfoText').val().trim().length > 0) {
            $(".cvvLabel").append("<a href='#' class='cvvInfo'><img class='cvvInfoImg' src='/content/dam/adc/fsl/images/global/en/info-ques-icon.png' alt='CVV Info'></a>");
            $(".Checkoutpage").on('click', '.cvvInfo', function(event) {
                event.preventDefault();
                if ($('.cvvTooltip').length !== 1) {
                    $(".cvvLabel").after("<div class='cvvTooltip'>" + $('#cvvInfoText').val() + "</div>");
                }
            });
            $(document).on('click touchstart', 'body', function(event) {
                if (!($(event.target).hasClass('cvvInfo') || $(event.target).hasClass('cvvInfoImg'))) {
                    $(".cvvTooltip").remove();
                }
            });
        }

    }
}