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
        buttonEnableflag = false;
        $('#paymentSection').prop('disabled', true);
        $('.proceedPay-loading').show();
        $.when(
            app.appGateway.ajaxCallCheckout(methodType, serviceUrl, addressList, addrSuccessCallback, addrErrorCallback, currentButton)
        ).done(function(ajaxResponse) {});
    }
    buttonEnableflag = true;
}

function addrSuccessCallback(data, currentButton) {
    $('#paymentSection').prop('disabled', false);
    $('.proceedPay-loading').hide();
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
                else if (readCookie('countryCookie') == "LU") {
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
                else if (readCookie('countryCookie') == "LU") {
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
        postalCode = $("#shipping_postCodePrefix").text() +$("#shipping_postCode").val();
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
        postalCode = $("#billing_postCodePrefix").text() +$("#billing_postCode").val();
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