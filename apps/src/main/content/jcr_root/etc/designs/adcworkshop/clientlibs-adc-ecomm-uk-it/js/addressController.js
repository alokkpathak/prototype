var ajaxUrl = "";
var ajaxData = "";
var serviceUrl = "";
var methodType = "";
var shippingSuccessTrans = false;
var billingSuccessTrans = false;
var vatSuccessTrans = false;
var newAddress = false;
var buttonEnableflag = true;
var errorPageURL = $('#errorpage-url').val();
var sortedAddress = "";

function setUserAddress(sortedAddress, currentButton, userType) {

    this.sortedAddress = sortedAddress;
    var billingAddressDifferent = $('#billingDiffers').prop('checked');
    var addressList = {};
    this.newAddress = userType;
    var serviceUrl = $("#setAllAddressUrl").val();
    var methodType = "POST";
    var shippingAddressDetails = fetchShippingAddressDetails();
    var billingAddressDetails = fetchBillingAddressDetails();
    var chkClaimData = $('#chkClaimData').prop('checked');
    var vatFormDetails = fetchVatFormDetails(chkClaimData);
    var selectedAddressIds = fetchSetShippingAddress();

    if (this.newAddress == true) {
        addressList["customerShippingAddressForm"] = shippingAddressDetails;
        if (billingAddressDifferent == true) {
            addressList["customerBillingAddressForm"] = billingAddressDetails;
        } else {
            addressList["customerBillingAddressForm"] = null;
        }
        addressList["vatDeclarationForm"] = vatFormDetails;
        addressList["orderForm"] = selectedAddressIds;
    } else {
        addressList["customerShippingAddressForm"] = null;
        addressList["customerBillingAddressForm"] = null;
        addressList["vatDeclarationForm"] = vatFormDetails;
        addressList["orderForm"] = selectedAddressIds;
    }

    if (buttonEnableflag == true) {
        // alert("setUserAddress");
        buttonEnableflag = false;
        $('#paymentSection').prop('disabled', true);
        $('.proceedPay-loading').show();
        $.when(
            //app.appGateway.ajaxCallCheckout(methodType, "/etc/designs/adresssuccesscallback.json", addressList, addrSuccessCallback, addrErrorCallback, currentButton)
           app.appGateway.ajaxGet("/etc/designs/adresssuccesscallback.json", addrSuccessCallback, addrErrorCallback) 
        ).done(function(ajaxResponse) {});
    }
    buttonEnableflag = true;
}

function addrSuccessCallback(data, currentButton) {
   // alert("test addrSuccessCallback" );
    $('#paymentSection').prop('disabled', false);
    $('.proceedPay-loading').show();
    $('#payment').find('.checkout-step').addClass('active');

    $($('#payment').find('.panel-default')).append($($.parseHTML('<div id="cardPayment_1375916840474" class="cardPayment cnpContainer cf"><form class="cnpForm card cardStyleSprite style-card cf" action="https://ctpe.net/frontend/ExecutePayment;jsessionid=E48426A45E026B6809079DDBE5627799.prod01-vm-fe04" method="POST" target="_self" lang="en"><div class="customLabel brandLabel">TYPE</div><div class="customSelect brandSelect"><select class="brandSelectBox" name="ACCOUNT.BRAND"><option value="VISA">Visa</option><option value="MASTER">MasterCard</option><option value="AMEX">American Express</option><option value="MAESTRO">Maestro</option></select></div><div class="cardIconSprite brandicon brand-VISA"></div><div class="customLabel cardNumberLabel">Card Number</div><div class="customInput cardNumberInput"><input autocomplete="off" type="tel" class="customInputField cardNumberInputField" ><iframe class="customInputIframe" frameborder="0" id="ccNumber" name="ACCOUNT.NUMBER" scrolling="no" src="https://ctpe.net/frontend/pci/number;jsessionid=E48426A45E026B6809079DDBE5627799.prod01-vm-fe04" style="height: 28px; width: 1136px; margin: 0px; "></iframe></div><div class="customLabel expiryMonthLabel">Expiry Date</div><div class="customSelect expiryMonthSelect"><select class="expiryMonthSelectBox" name="ACCOUNT.EXPIRY_MONTH"><option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option><option value="5">5</option><option value="6">6</option><option value="7">7</option><option value="8">8</option><option value="9">9</option><option value="10">10</option><option value="11">11</option><option value="12">12</option></select></div><div class="customSelect expiryYearSelect"><select class="expiryYearSelectBox" name="ACCOUNT.EXPIRY_YEAR"><option value="2017">2017</option><option value="2018">2018</option><option value="2019">2019</option><option value="2020">2020</option><option value="2021">2021</option><option value="2022">2022</option><option value="2023">2023</option><option value="2024">2024</option><option value="2025">2025</option><option value="2026">2026</option><option value="2027">2027</option><option value="2028">2028</option><option value="2029">2029</option><option value="2030">2030</option><option value="2031">2031</option><option value="2032">2032</option><option value="2033">2033</option><option value="2034">2034</option><option value="2035">2035</option><option value="2036">2036</option><option value="2037">2037</option><option value="2038">2038</option><option value="2039">2039</option><option value="2040">2040</option><option value="2041">2041</option></select></div><div class="customLabel cardHolderLabel">Card holder</div><div class="customInput cardHolderInput"><input autocomplete="off" type="text" name="ACCOUNT.HOLDER" class="customInputField cardHolderInputField" placeholder="Card holder"></div><div class="customLabel cvvLabel">CVV<a href="#" class="cvvInfo"><img class="cvvInfoImg" src="/content/dam/adc/fsl/images/global/en/info-ques-icon.png" alt="CVV Info"></a></div><div class="customInput cvvInput"><input autocomplete="off" type="tel" class="customInputField cvvInputField" ><iframe class="customInputIframe" frameborder="0" id="ccCvv" name="ACCOUNT.VERIFICATION" scrolling="no" src="https://ctpe.net/frontend/pci/cvv;jsessionid=E48426A45E026B6809079DDBE5627799.prod01-vm-fe04" style="height: 28px; width: 680px; margin: 0px; "></iframe></div><div class="customInput submitInput"><button type="submit" name="pay" class="cardSubmitButton">Pay now</button></div><input type="hidden" name="PAYMENT.METHOD" value="CC"><input type="hidden" name="FRONTEND.VERSION" value="4"><input type="hidden" name="FRONTEND.MODE" value="ASYNC"><input type="hidden" name="FRONTEND.RESPONSE_URL" value="http://localhost:4502/content/prototype/shop/countries/gb/en/ecommerce/order-confirmation-shop.html"></form></div>')));
	//$('#payment').find('.cnpForm').removeClass('display');
    var billingAddressDifferent = $('#billingDiffers').prop('checked');
    var vatClaim = $('#chkClaimData').prop('checked');
    if (data.customerShippingAddressResponse != null) {
        if (data.customerShippingAddressResponse.messages.allErrors == "") {
            var user_entity_id = data.customerShippingAddressResponse.address[0].entity_id;
            var magento_message = data.customerShippingAddressResponse.messages.success.message;
            var magento_message_code = data.customerShippingAddressResponse.messages.success.code;

            var shippingAddressHiddenId = "#shippingAddressEntityId";
            $(shippingAddressHiddenId).val(user_entity_id);
            $('.shipping-global-message').html('');
            shippingSuccessTrans = true;
        } else {
            shippingSuccessTrans = false;
            var errorCode = data.customerShippingAddressResponse.messages.error[0].code;
            if (errorCode == 3001) {
                var errormsg = "<font size='2' color='red'>" +
                    data.customerShippingAddressResponse.messages.error[1].message +
                    "</font>";
                $('.shipping-global-message').html(errormsg);
            } else if (errorCode == 400) {
                var errormsg = "<font size='2' color='red'>" +
                    data.customerShippingAddressResponse.messages.error[0].message +
                    "</font>";
                $('.shipping-global-message').html(errormsg);
            }
         $('html, body').animate({scrollTop : $('.shipping-global-message').offset().top-30},1000);   
        }
    }

    var vatClaim = $('#chkClaimData').prop('checked');
    if (data.customerBillingAddressResponse != null) {
        if (data.customerBillingAddressResponse.messages.allErrors == "") {
            var user_entity_id = data.customerBillingAddressResponse.address[0].entity_id;
            var magento_message = data.customerBillingAddressResponse.messages.success.message;
            var magento_message_code = data.customerBillingAddressResponse.messages.success.code;
            var billingAddressHiddenId = "#billingAddressEntityId";
            $(billingAddressHiddenId).val(user_entity_id);
            $('.billing-global-message').html('');
            billingSuccessTrans = true;
        } else {
            billingSuccessTrans = false;
            var errorCode = data.customerBillingAddressResponse.messages.error[0].code;
            if (errorCode == 3001) {
                var errormsg = "<font size='2' color='red'>" +
                    data.customerBillingAddressResponse.messages.error[1].message +
                    "</font>";
                $('.billing-global-message').html(errormsg);
            } else if (errorCode == 400) {
                var errormsg = "<font size='2' color='red'>" +
                    data.customerBillingAddressResponse.messages.error[0].message +
                    "</font>";
                $('.billing-global-message').html(errormsg);
            }
         $('html, body').animate({scrollTop : $('.billing-global-message').offset().top-30},1000);   
        }
    }

    if (data.vatDeclarationResponse != null) {
        if (data.vatDeclarationResponse.messages.allErrors == "") {
            var magento_message = data.vatDeclarationResponse.messages.success.message;
            var magento_message_code = data.vatDeclarationResponse.messages.success.code;
            $('.vatform-global-message').html('');
            vatSuccessTrans = true;
        } else {
            var errorCode = data.vatDeclarationResponse.messages.error[0].code;
            if (errorCode == 3001) {
                var errormsg = "<font size='2' color='red'>" +
                    data.vatDeclarationResponse.messages.error[1].message +
                    "</font>";
                $('.vatform-global-message').html(errormsg);
            } else if (errorCode == 400) {
                var errormsg = "<font size='2' color='red'>" +
                    data.vatDeclarationResponse.messages.error[0].message +
                    "</font>";
                $('.vatform-global-message').html(errormsg);
            }
        $('html, body').animate({scrollTop : $('.vatform-global-message').offset().top-30},1000);     
        }
    }
    if (data.shippingAddressResponse != null) {
        if (data.shippingAddressResponse != null && data.shippingAddressResponse.messages.allErrors == "") {
            if (newAddress == true) {
                if (readCookie('countryCookie') == "GB") {
                    if (shippingSuccessTrans == true && billingAddressDifferent == true && billingSuccessTrans == true && vatSuccessTrans == true) {
                        navigateNextStep(currentButton);
                    } else if (shippingSuccessTrans == true && billingAddressDifferent == false && vatSuccessTrans == true) {
                        navigateNextStep(currentButton);
                    }
                } else if (readCookie('countryCookie') == "IT") {
                    if (shippingSuccessTrans == true && billingAddressDifferent == true && billingSuccessTrans == true) {
                        navigateNextStep(currentButton);
                    } else if (shippingSuccessTrans == true && billingAddressDifferent == false) {
                        navigateNextStep(currentButton);
                    }
                }
            } else {
                if (readCookie('countryCookie') == "GB") {
                    if (vatSuccessTrans == true) {
                        navigateNextStep(currentButton);
                    }
                } else if (readCookie('countryCookie') == "IT") {
                    navigateNextStep(currentButton);
                }
            }
        } else {
            var errorCode = "";
            var message = "";
            if (data.shippingAddressResponse.messages != null && data.shippingAddressResponse.messages.error[0].code != null) {
                errorCode = data.shippingAddressResponse.messages.error[0].code;
                message = data.shippingAddressResponse.messages.error[0].message;
            } else if (data.billingAddressResponse != null && data.billingAddressResponse.messages.error[0].code != null) {
                errorCode = data.billingAddressResponse.messages.error[0].code;
                message = data.billingAddressResponse.messages.error[0].message;
            } else if (data.shippingAddressResponse.billingAddressResponse != null && data.shippingAddressResponse.billingAddressResponse.messages.error[0].code != null) {
                errorCode = data.shippingAddressResponse.billingAddressResponse.messages.error[0].code;
                message = data.shippingAddressResponse.billingAddressResponse.messages.error[0].message;
            }

            if (errorCode == 4021) {
                window.location.replace($('#transactiontimeout').attr('value'));
            } else if (errorCode == 3001) {

                var errormsg = "<font size='2' color='red'>" +
                    message +
                    "</font>";
                $('.setshipping-global-message').html(errormsg);
                 $('html, body').animate({scrollTop : $('.setshipping-global-message').offset().top-30},1000); 
            }
        }
    }
}

function addrErrorCallback(e) {
    $('#paymentSection').prop('disabled', false);
    $('.proceedPay-loading').hide();
    console.log(e);
    window.location.replace(errorPageURL);
}

function navigateNextStep(currentButton) {
    var objCheckout = app.expressCheckout;
    objCheckout.getFinalPaymentDetails();
    objCheckout.navigate(currentButton);
}

function fetchShippingAddressDetails() {
    var newUserShippingDetails = {};
    var shippingAddressEntityId = $("#shippingAddressEntityId").val();
    var addressfield1 = "";
    var addressfield2 = "";
    var postalCode = "";
    var addressTitle = $("#default_shippingaddr").val();
    var city = "";
    if (shippingAddressEntityId != null) {
        newUserShippingDetails["addressId"] = shippingAddressEntityId;
    }

    if ($("#shipping_ManualAddressData").hasClass("hidden")) {
        addressfield1 = $('#shipping_addressline_one').val();
        addressfield2 = $('#shipping_addrssline_two').val();
        postalCode = $('#shipping_contact_postCode').val();
        city = $('#shipping_contact_city').val();
    } else {
        addressfield1 = $("#shipping_address").val();
        addressfield2 = $("#shipping_addrss1").val();
        postalCode = $("#shipping_postCode").val();
        city = $("#shipping_city").val();
    }

    newUserShippingDetails["prefix"] = $("#shipping_title").val();
    newUserShippingDetails["firstname"] = $("#shipping_firstName").val();
    newUserShippingDetails["lastname"] = $("#shipping_lastName").val();
    newUserShippingDetails["country_id"] = readCookie('countryCookie');
    newUserShippingDetails["region_id"] = "1";
    if (addressfield2 != undefined && addressfield2.trim().length > 0) {
        newUserShippingDetails["street"] = [addressfield1, addressfield2];
    } else {
        newUserShippingDetails["street"] = [addressfield1];
    }
    newUserShippingDetails["city"] = city;
    newUserShippingDetails["postcode"] = postalCode;
    newUserShippingDetails["customer_address_label"] = addressTitle;
    newUserShippingDetails["telephone"] = $("#shipping_phone").val();

    var billingAddressDifferent = $('#billingDiffers').prop('checked');
    if (billingAddressDifferent == false) {
        newUserShippingDetails["is_default_billing"] = 1;
        newUserShippingDetails["is_default_shipping"] = 1;
    } else {
        newUserShippingDetails["is_default_billing"] = 0;
        newUserShippingDetails["is_default_shipping"] = 1;
    }

    return newUserShippingDetails;
}

function fetchBillingAddressDetails() {
    var newUserBillingDetails = {};
    var billingAddressEntityId = $("#billingAddressEntityId").val();
    var addressfield1 = "";
    var addressfield2 = "";
    var addressTitle = $("#default_billingaddr").val();
    var postalCode = "";
    var city = "";
    if (billingAddressEntityId != null) {
        newUserBillingDetails["addressId"] = billingAddressEntityId;
    }

    if ($("#billing_ManualAddressData").hasClass("hidden")) {
        addressfield1 = $('#billing_addressline_one').val();
        addressfield2 = $('#billing_addrssline_two').val();
        postalCode = $('#billing_contact_postCode').val();
        city = $('#billing_contact_city').val();
    } else {
        addressfield1 = $("#billing_address").val();
        addressfield2 = $("#billing_addrss1").val();
        postalCode = $("#billing_postCode").val();
        city = $("#billing_city").val();
    }

    newUserBillingDetails["prefix"] = $("#billing_title").val();
    newUserBillingDetails["firstname"] = $("#billing_firstName").val();
    newUserBillingDetails["lastname"] = $("#billing_lastName").val();
    newUserBillingDetails["country_id"] = readCookie('countryCookie');
    newUserBillingDetails["region_id"] = "1";
    if (addressfield2 != undefined && addressfield2.trim().length > 0) {
        newUserBillingDetails["street"] = [addressfield1, addressfield2];
    } else {
        newUserBillingDetails["street"] = [addressfield1];
    }
    newUserBillingDetails["city"] = city;
    newUserBillingDetails["postcode"] = postalCode;
    newUserBillingDetails["customer_address_label"] = addressTitle;
    newUserBillingDetails["telephone"] = $("#billing_phone").val();
    newUserBillingDetails["is_default_shipping"] = 0;
    newUserBillingDetails["is_default_billing"] = 1;

    return newUserBillingDetails;
}

function fetchVatFormDetails(chkClaimData) {
    var vatFormDetails = null;
    var addressfield1 = "";
    var addressfield2 = "";
    var postalCode = "";
    var city = "";
    var is_diabetic = "";

    if (readCookie('countryCookie') == "GB") {
        vatFormDetails = {};
        if ($("#vat_ManualAddressData").hasClass("hidden")) {
            addressfield1 = $('#vat_addressline_one').val();
            addressfield2 = $('#vat_addrssline_two').val();
            postalCode = $('#contact_postCode_vat').val();
            city = $('#vat_contact_city').val();
        } else {
            addressfield1 = $("#tax_HomeAddress").val();
            addressfield2 = $("#tax_HomeAddressOne").val();
            postalCode = $("#tax_PostalCode").val();
            city = $("#tax_City").val();
        }

        if (chkClaimData == true) {
            vatFormDetails["certificate_on_behalf"] = $('input[name=claimGroup]:checked').val();
            vatFormDetails["firstname"] = $("#tax_FirstName").val();
			vatFormDetails["lastname"] = $("#tax_LastName").val();
            vatFormDetails["country_id"] = readCookie('countryCookie');
            vatFormDetails["region_id"] = "1";
            if (addressfield2 != undefined && addressfield2.trim().length > 0) {
                vatFormDetails["street"] = [addressfield1, addressfield2];

            } else {
                vatFormDetails["street"] = [addressfield1];
            }
            vatFormDetails["city"] = city;
            vatFormDetails["postcode"] = postalCode;
            vatFormDetails["vatdob"] = $("#tax_day").val() + "-" + $("#tax_month").val() + "-" + $("#tax_year").val();
            vatFormDetails["is_diabetic"] = 1;
        } else {
            vatFormDetails["is_diabetic"] = 0;
        }
    }
    return vatFormDetails;
}

function fetchSetShippingAddress() {
   // alert("fetchSetShippingAddress");
    var customerShippingAddressId = "";

    if (sortedAddress) {
        customerShippingAddressId = $(".shippingAddressPanes").find('.active-address').attr('id');
    } else {
        customerShippingAddressId = $("#shippingAddressEntityId").val();
    }
    var setshippingaddress = {};
    setshippingaddress["customer_shipping_address_id"] = customerShippingAddressId;
    setshippingaddress["customer_billing_address_id"] = billingaddress();
    setshippingaddress["shipping_method"] = $("#shippingMethodCode").val();
    return setshippingaddress;
}

function billingaddress() {
	var customerBillingAddressId;
	if (sortedAddress) {
        customerBillingAddressId = $(".billingAddressPanes").find('.active-address').attr('id');
	} else {
        var billingAddressDifferent = $('#billingDiffers').prop('checked');
        if (billingAddressDifferent == true) {
            customerBillingAddressId = $("#billingAddressEntityId").val();
        } else {
            customerBillingAddressId = $("#shippingAddressEntityId").val();
        }
	}
    return customerBillingAddressId;
}