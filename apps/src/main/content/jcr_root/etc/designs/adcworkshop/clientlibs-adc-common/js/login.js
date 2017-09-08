(function() {
    /*Default constructor */
    var cookieTimeout = new Date();
    var sessionTimeoutMinutes = $('#timeOutVal').val();
    cookieTimeout.setTime(cookieTimeout.getTime() + (sessionTimeoutMinutes * 60 * 1000));
    var idleTime = 0;
    var errorPageURL = $('#errorpage-url').val();
    var unauthorizedURL = $('#unauthorized-url').val();

    //Increment the idle time counter every minute.
    var idleInterval = setInterval(timerIncrement, 60000); // 1 minute

    //Zero the idle timer on mouse movement.
    $(this).mousemove(function(e) {
        idleTime = 0;
    });
    $(this).keypress(function(e) {
        idleTime = 0;
    });

    function timerIncrement() {
        idleTime = idleTime + 1;
        if (sessionTimeoutMinutes != null && sessionTimeoutMinutes != "") {
            if (idleTime > sessionTimeoutMinutes) {
                logoutSession($('#logout_url').val());
            } else {
                extendCookieTimeout();
            }
        }
    }

    function extendCookieTimeout() {
        cookieTimeout = new Date();
        cookieTimeout.setTime(cookieTimeout.getTime() + (sessionTimeoutMinutes * 60 * 1000));
        var userIdCookieVal = readCookie("userid");
        var userNameCookieVal = readCookie("username");
        var productCookieVal = readCookie("productCount");
        if (userNameCookieVal != null && userIdCookieVal != null) {
            addCookie('userid', userIdCookieVal, cookieTimeout);
            addCookie('username', userNameCookieVal, cookieTimeout);
        }
        if (productCookieVal != null) {
            addCookie('productCount', productCookieVal, cookieTimeout);
        }
    }

    function Login() {
		this.bindEvent();
    }

    function getUrlVars() {
        var vars = [],
            hash;
        var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
        for (var i = 0; i < hashes.length; i++) {
            hash = hashes[i].split('=');
            vars.push(hash[0]);
            vars[hash[0]] = hash[1];
        }
        return vars;
    }

    $(".personalLogOut").on('click', function() {
        logoutSession($('#logout_url').val());
    });

    $("#logout").click(function(e) {
        e.stopPropagation();
        logoutSession($('#logout_url').val());
    });

    $('.list-group').each(function() {
        $(this).find('li').on('click', function() {
            var countryLocale = $(this).find('.countryClickHandler').find('input').val();
            var countryName = $(this).find('.flag-name').html();
            var domainNames = $('#domainNames').val();
            var domainNamesSplitarr = domainNames.split(",");
            for (var i = 0; i < domainNamesSplitarr.length; i++) {
                var localeDomain = domainNamesSplitarr[i];
                var localeDomainNameArr = localeDomain.split("::");
                if (countryLocale == localeDomainNameArr[0]) {
                    removeCookie('cookieTopBarAgree', '');
                    removeCookie('cookieAgree', '');
                    app.analytics.pushEvent('CountrySelection', 'change country', 'selection', countryName);
                    logoutSession(localeDomainNameArr[1]);
                    break;
                }
            }
        })
    });

    var logoutRedirectUrl;

    function logoutSession(redirectUrl) {
        logoutRedirectUrl = redirectUrl;
        var sessionUrl = $("#sessiontimeout-url").attr('value');
        app.appGateway.ajaxGet(sessionUrl, successLogout, errorLogout);
    }

    function successLogout(data) {
        app.login.logoutUserSession();
        removeCookie('guestUserCookie', '');
        removeCookie('productCount', '');
        removeCookie('countryCookie', '');
        removeCookie('adcfslId', '');
		removeCookie('apptoken', '');
        window.location.replace(logoutRedirectUrl);
    }

    function errorLogout(e) {
        console.log("Logout failed" + e.status);
    }

	Login.prototype.logoutUserSession = function() {
        removeCookie('userid', '');
        removeCookie('username', '');
        removeCookie('BNES_userid', '');
        removeCookie('BNES_username', '');
	}
	
	Login.prototype.setLoginInfo = function() {
		var usernameLabel = readCookie('username');
		if (usernameLabel != null && usernameLabel != '' && loggedInCustomer) {
			$('#user_name').text(usernameLabel);
			$('.panelUserName').html(' ' + usernameLabel);
			$('#signedOutAccountIcon').hide();
			$('#signedInAccountIcon').show();
			$('#accountLoggedInBar').show();
		} else {
			$('#signedOutAccountIcon').show();
			$('#signedInAccountIcon').hide();
			$('#accountLoggedInBar').hide();
		}
		if ($(window).width() < 768) {
			$('#accountLoggedInBar').hide();
		}
	}
	
	$("#userCheckout").click(function(event) {
		app.analytics.onCheckoutOption('checkoutOption', '1', "standard checkout");
	    if (readCookie('username') != null && readCookie('username') != '' && loggedInCustomer) {
	        // remove the guest user cookie, as the customer is a logged in customer
	        removeCookie('guestUserCookie', '');
	        window.location.replace($('#checkoutUrl').val());
	    } else {
	        // add a cookie to determine the incoming user is a guest/anonymous user
	        addCookie('guestUserCookie', '1');
	        window.location.replace($('#guestCheckoutUrl').val());
	    }
	});
	
    Login.prototype.bindEvent = function() {
        var objValidator = app.utils.validator;
        // password can't be blank
        $('#recover_pwd,#pwd').focusout('input', function() {
            var input = $(this);
            $('#Ajaxpass').addClass("hidden");
            $('#Ajaxfail').addClass("hidden");
            var isValidFormat = objValidator.validatePassword(input);
            objValidator.toggleErrorMsg(input, isValidFormat, "password");
        });
        $('#login_pwd').focusout('input', function() {
            var input = $(this);
            var isValidFormat = objValidator.validateEmptyField(input);
            objValidator.toggleErrorMsg(input, isValidFormat, "password");
        });

        // Email must be an email
        $('#login_email,#register_email,#email,#contact_email, #email_consent').focusout('input', function() {
            var input = $(this);
            $('#Ajaxerror').addClass("hidden");
            var isValidFormat = objValidator.validateEmail(input);
            objValidator.toggleErrorMsg(input, isValidFormat, "email");
        });

        $('#contact_firstName,#contact_lastName').focusout('input', function() {
            var input = $(this);
            var isAlphabetic = objValidator.validateAlbhabetic(input);
            objValidator.toggleErrorMsg(input, isAlphabetic, "alpha");
        });
        $('#contact_Message').focusout('input', function() {
            var input = $(this);
            var isAlbhaNumerictext = objValidator.validateAlbhaNumerictext(input);
            objValidator.toggleErrorMsg(input, isAlbhaNumerictext, "alphanumerictext");
        });
        $('#confirmEmail').focusout('input', function() {
            var email = $('#register_email');
            var isMatched = objValidator.confirmEmail(email, $(this));
            objValidator.toggleErrorMsg($(this), isMatched, "confirm_email");
        });
        $('#contact_clientcode').focusout('input', function() {
            var input = $(this);
            this.value = this.value.toUpperCase();
            var isValidFormat = objValidator.validateSixteenDigit(input);
            objValidator.toggleErrorMsg(input, isValidFormat, "contact_clientcode");
        });
        $("#createAccountLink").click(function(event) {
            if (readCookie('guestUserCookie') == null) {
                window.location.replace($('#registrationPageUrl').val());
            } else {
                window.location.replace($('#guestCheckoutUrl').val());
            }
        });

        $(document).on('click', "#forgot_password_form .mailcancel,#forgot_password_form .mailclose", function(e) {
            //Remove all kind of possible errors and reset popup content to '#before-submit'
            $('#forgot_password_form #email').val('');
            $('#forgot_password_form #email').removeClass('invalid');

             $('#forgot_password_form #email_consent').val('');

            $('#forgot_password_form #email_consent').removeClass('invalid');

            $('#forgot_password_form .email-form-group').find('#4025').addClass('hidden');
            $('#forgot_password_form .email-form-group').find('#4026').addClass('hidden');
            $('#forgot_password_form .email-form-group').find('.error_show').removeClass('error_show').addClass('error');
            $('#forgot_password_form .email-form-group').find('#Ajaxerror').addClass('hidden');
            $('#before-submit').show();
            $('#before-submitcon').show();
            $('#retrieve-pwd').show();
			$('#retrieve-pwdcon').show();
            $('#after-submit').hide();
            $('#after-submitcon').hide();
            $('#after-resend-submit').hide();
            $('#after-resend-submitcon').hide();


        });

        //forgot your password event
        $("#retrieve-pwd,#retrieve-pwdcon").click(function(event) {
            var form = $(this).closest('form');
            var error_free = objValidator.submitForm(form, form);
            if (!error_free) {
                event.preventDefault();
            } else {

                var reset_email;
                var reset_email_consent;

                if($("#retrieve-pwd").is(':visible') )
                {
                    reset_email = $("#email").val();

                    var resetPasswordMailUrl = $("#resetPasswordMailUrl").attr('value');
                	var reset_email_obj = {};
                	reset_email_obj["email"] = reset_email;

                }
                else 
                {
                    reset_email_consent = $("#email_consent").val();

                    var resetPasswordMailUrl = $("#resetPasswordMailUrl").attr('value');
                	var reset_email_obj = {};
                	reset_email_obj["email"] = reset_email_consent;

                }

                
                $("#retrieve-pwd").addClass('disabled');
				$("#retrieve-pwdcon").addClass('disabled');

                $('.forgot-pswd-loading').show();
                app.appGateway.ajaxPut(resetPasswordMailUrl, reset_email_obj, successCallback_resetPassword, errorCallback_resetPassword);
            }
        });


        function successCallback_resetPassword(data) {
            $("#retrieve-pwd").removeClass('disabled');
			$("#retrieve-pwdcon").removeClass('disabled');
            $('.forgot-pswd-loading').hide();
            if (data.messages.allErrors != "") {
                var errorCode = data.messages.error[0].code;
                if (errorCode == 4026) {
                    $("#4026").removeClass("hidden");
                }
                if (errorCode == 4025) {
                    $("#4025").removeClass("hidden");
                }
            } else {
                var json = data.messages.success.message;
                if (json != null) {
                    $('#before-submit').hide();
                    $('#after-submit').show();
                    $('#retrieve-pwd').hide();
					$('#retrieve-pwdcon').hide();

                    $('#before-submitcon').hide();
                    $('#after-submitcon').show();
                    $('#after-resend-submit').hide();
                    $('#after-resend-submitcon').hide();
                }
            }
        }

        function errorCallback_resetPassword(e) {
            $("#resend").removeClass('disabled');
             $("#resendconsent").removeClass('disabled');
            $("#retrieve-pwd").removeClass('disabled');
			$("#retrieve-pwdcon").removeClass('disabled');
            $('.forgot-pswd-loading').hide();
            $("#Ajaxerror").removeClass("hidden");
            window.location.replace(errorPageURL);
        }

        //event to be triggered when resend link is clicked
        $("#resend,#resendconsent").click(function(event) {
            var form = $(this).closest('form');
            var error_free = objValidator.submitForm(form, form);
            if (!error_free) {
                event.preventDefault();
            } else {
                var reset_email;
                var reset_email_consent;
                if($("#resend").is(':visible'))
                {
                    reset_email = $("#email").val();
                    var resetPasswordMailUrl = $("#resetPasswordMailUrl").attr('value');
                var reset_email_obj = {};
                reset_email_obj["email"] = reset_email;

                }else
                {
                    reset_email_consent = $("#email_consent").val();
                    var resetPasswordMailUrl = $("#resetPasswordMailUrl").attr('value');
                var reset_email_obj = {};
                reset_email_obj["email"] = reset_email_consent;

                }

                $("#resend").addClass('disabled');
                 $("#resendconsent").addClass('disabled');
                $('.forgot-pswd-loading').show();
                app.appGateway.ajaxPut(resetPasswordMailUrl, reset_email_obj, successCallback_resend_resetPassword, errorCallback_resetPassword);
            }
        });

        function successCallback_resend_resetPassword(data) {
            $("#resend").removeClass('disabled');
            $("#resendconsent").removeClass('disabled');
            $('.forgot-pswd-loading').hide();
            if (data.messages.allErrors != "") {
                var errorCode = data.messages.error[0].code;
                if (errorCode == 4026) {
                    $("#4026").removeClass("hidden");
                }
            } else {
                var json = data.messages.success.message;
                if (json != null) {
                    $('#after-submit').hide();
                    $('#after-resend-submit').show();

                    $('#after-submitcon').hide();
                    $('#after-resend-submitcon').show();
                }
            }
        }
        //recovery password
        $("#recoverypwd_confirm").click(function(event) {
            var form = $("#recoverPasswordForm");
            var error_free = objValidator.submitForm(form, form);
            var id = getUrlVars()["id"];
            var token = getUrlVars()["token"];

            if (!error_free) {
                event.preventDefault();
            } else {
                var password = $("#pwd").val();
                var repeat_password = $("#recover_repeat_pwd").val();
                var resetPasswordUrl = $("#resetPasswordUrl").attr('value');
                var repeat_password_obj = {};
                repeat_password_obj["password"] = password;
                repeat_password_obj["confirm_password"] = repeat_password;
                repeat_password_obj["customer_id"] = id;
                repeat_password_obj["reset_password_token"] = token;
                $("#recoverypwd_confirm").prop("disabled", true).css("opacity", ".65");
                app.appGateway.ajaxPut(resetPasswordUrl, repeat_password_obj, successCallback_updatePassword, errorCallback_updatePassword);
            }
        });

        function successCallback_updatePassword(data) {
            $("#recoverypwd_confirm").prop("disabled", false).css("opacity", "1");
            if (data.messages.allErrors != "") {
                var errorCode = data.messages.error[0].code;
                if (errorCode == 4018) {
                    $("#4018").removeClass("hidden");
                } else if (errorCode == 4027) {
                    $("#4027").removeClass("hidden");
                    window.location.replace($("#unauthorizedurl").val());
                } else if (errorCode == 4028) {
                    $("#4028").removeClass("hidden");
                } else if (errorCode == 4029) {
                    $("#4029").removeClass("hidden");
                } else {
                    $('#resetfail').removeClass("hidden");
                }
            } else {
                var json = data.messages.success.message;
                var id = getUrlVars()["id"];
                if (json != null) {
                    $('#resetpass').removeClass("hidden");
                    $('#pwd').val("");
                    $('#recover_repeat_pwd').val("");
                    profiledetailsgetsuccessCallback_title_name(data.profileServiceResponse);
                   /* var profiledetailsServiceUrl = $("#profiledetailsServiceUrl").val();
                    profiledetailsServiceUrl = profiledetailsServiceUrl + "/" + id;

                    if (id != null && id != undefined) {
                        setTimeout(function() {
                            app.appGateway.ajaxGet(profiledetailsServiceUrl, profiledetailsgetsuccessCallback_title_name, profiledetailsgeterrorCallback_title_name);
                        }, 5000);
                    }*/
                }
            }
        }

        function profiledetailsgetsuccessCallback_title_name(data) {
            var successCode = data.messages.success.code;
            if (data.messages.allErrors == "") {
                var json = "<font size='2' color='blue'>" + data.messages.success.message + "</font>";
                $('#feedback').html(json);
                if (data.productCount != null) {
                    $('.basketitems').text(data.productCount);
                    addCookie('productCount', data.productCount, cookieTimeout);
                }
                if (data.firstname != null) {
                    addCookie('userid', data.customer_id, cookieTimeout);
                    if (data.prefix != null) {
                        customerLogin(data.prefix + " " + data.firstname + " " + data.lastname, data.qtyExceeded);
                    } else {
                        customerLogin(data.firstname + " " + data.lastname, data.qtyExceeded);
                    }

                    app.analytics.pushEvent("login", "login", "direct login", "success");
                }
            } else {
                var errorCode = data.messages.error[0].code;
                app.analytics.pushEvent("login", "login", "direct login", "failure");
            }

        }

        function profiledetailsgeterrorCallback_title_name(e) {
            window.location.replace(errorPageURL);
        }


        function errorCallback_updatePassword(e) {
            $("#recoverypwd_confirm").prop("disabled", false).css("opacity", "1");
            $('#resetfail').removeClass("hidden");
            window.location.replace(errorPageURL);
        }

        /***********Contact Us*************/

        $("#contact_submit").click(function(event) {
            var form = $("#contact");
            var eventActionName = "Newsletter";
            var error_free = objValidator.submitForm(form, form);
            if (!error_free) {
                if ($('#contact_Message').val() == "") {
                    $('#errormess').addClass('error_show');
                    $('#errormess').removeClass('error');
                    event.preventDefault();
                }
                event.preventDefault();
                $('#lblEmailError').removeClass("hidden");
                $('#error-icon').removeClass("hidden");
            } else {
                $('#lblEmailError').addClass("hidden");
                var contactUsUrl = $("#contactUsUrl").attr('value');
                var contact_us_obj = {}
                contact_us_obj["prefix"] = $("#title option:selected").text();
                contact_us_obj["firstname"] = $("#contact_firstName").val();
                contact_us_obj["lastname"] = $("#contact_lastName").val();
                contact_us_obj["email"] = $("#contact_email").val();
                contact_us_obj["comment"] = $("#contact_Message").val();
                contact_us_obj["inquiry"] = $("#contact_question").val();
                var isChecked = $('#chkYesReceive').prop('checked');
                if (isChecked) {
                    contact_us_obj["contactus_user_isnewsletter"] = 1;
                } else {
                    contact_us_obj["contactus_user_isnewsletter"] = 0;
                }
                $("#contact_submit").prop("disabled", true).css("opacity", ".65");
                $(".ContactUs-loading").show();
                app.appGateway.ajaxPost(contactUsUrl, contact_us_obj, contactUsSuccessCallback, contactUsErrorCallback);
                event.preventDefault();
            }

            function contactUsSuccessCallback(data) {
                $(".ContactUs-loading").hide();
                $("#contact_submit").prop("disabled", false).css("opacity", "1");
                if (data.messages.allErrors != "") {
                    var errorCode = data.messages.error[0].code;
                    var errorCodeMessage = data.messages.error[0].message;
                    if (errorCode == 4059) {
                        $("#4059").removeClass("hidden");
                        $('html, body').animate({
                            scrollTop: $('#4059').offset().top - 30
                        }, 1000);
                    } else if (errorCode == 3001) {
                        $("#3001").removeClass("hidden");
                        $('#3001').html(errorCodeMessage);
                        $('html, body').animate({
                            scrollTop: $('#3001').offset().top - 30
                        }, 1000);
                    }
                    app.analytics.pushEvent("form", "Help", "contact us", "send your message - failure");
                    return false;
                } else {
                    var json = data.messages.success.message;
                    if (json != null) {
                        app.analytics.pushEvent("form", "Help", "contact us", "send your message - success");
                        window.location.replace($("#contactsuccessUrl").val());
                    }
                }
            }

            function contactUsErrorCallback(e) {
                $(".ContactUs-loading").hide();
                $("#contact_submit").prop("disabled", false).css("opacity", "1");
                app.analytics.pushEvent("form", "Help", "contact us", "send your message - failure");
                window.location.replace(errorPageURL);
            }

        });

        $('input').keypress(function(event) {
            if (event.which == 13) {
				$(this).focusout();
                if ($('body').hasClass('loginpage')) {
                    loginAction(event);
                    return false;
                }
            }
        });

        // After Form Submitted Validation
        $("#login_submit button").click(function(event) {
            loginAction(event);
        });

        function loginAction(event) {
            $('#login_submit > button').prop('disabled', true);
            var form = $("#login");
            var error_free = objValidator.submitForm(form, form);
            if (!error_free) {
                event.preventDefault();
                $('#login_submit > button').prop('disabled', false);
                if ($('#login_pwd').val() == "") {
                    $('#passworderror').removeClass('hidden');
                    $(".login-loading").hide();
                } else {
                    $(".login-loading").hide();
                    $('#passworderror').addClass('hidden');
                    event.preventDefault();
                    var search = {}
                    search["password"] = $("#login_pwd").val();
                    search["email"] = $("#login_email").val();
                    var loginUrl = $("#login-url").attr('value');
                    if (search["email"] != "" && $('#login_email').hasClass("valid")) {
                        $(".login-loading").show();
                        app.appGateway.ajaxPost(loginUrl, search, loginSuccessCallback, loginErrorCallback);
                    }
                }
            } else {
                event.preventDefault();
                var search = {}
                search["password"] = $("#login_pwd").val();
                search["email"] = $("#login_email").val();
                var loginUrl = $("#login-url").attr('value');
                $(".login-loading").show();
                app.appGateway.ajaxPost(loginUrl, search, loginSuccessCallback, loginErrorCallback);
            }
        }

        $("#login_email,#login_pwd").change(function() {
            $("#4000").addClass("hidden");
            $("#4005").addClass("hidden");
        });
        $("#email, #email_consent").change(function() {
            $("#4026").addClass("hidden");
            $("#4025").addClass("hidden");
        });

        function loginSuccessCallback(data) {
            $('#login_submit > button').prop('disabled', false);
            if (data.messages.allErrors == "") {
                var json = "<font size='2' color='blue'>" + data.messages.success.message + "</font>";
                $('#feedback').html(json);
                if (data.productCount != null) {
                    $('.basketitems').text(data.productCount);
                    addCookie('productCount', data.productCount, cookieTimeout);
                }
                if (data.firstname != null) {
                    addCookie('userid', data.entity_id, cookieTimeout);
                    $("#4000").addClass("hidden");
                    app.analytics.pushEvent("login", "login", "direct login", "success");
                    if (data.profileServiceResponse != null && data.profileServiceResponse.newsletter_subscription == 1) {
                        var closeBtnCookieTimeout = new Date();
                        closeBtnCookieTimeout.setTime(closeBtnCookieTimeout.getTime() + app.stickyFooter.closeTime);
                        addCookie('stickyfooterAgree', '1', closeBtnCookieTimeout);
                    }

                    if (data.prefix != null) {
                        customerLogin(data.prefix + " " + data.firstname + " " + data.lastname, data.qtyExceeded);
                    } else {
                        customerLogin(data.firstname + " " + data.lastname, data.qtyExceeded);
                    }
                }
            } else {
                var errorCode = data.messages.error[0].code;
                if (errorCode == 4000) {
                    $("#4000").removeClass("hidden");
                    $("#4005").addClass("hidden");
                    enableLoginButton(true);
                    $(".login-loading").hide();
                    if($(window).width() <= 991){
                    	$('html,body').animate({scrollTop: $("#4000").offset().top-75},'fast');
                    }
                } else if (errorCode == 4005 || errorCode == 4004) {
                    $("#4005").removeClass("hidden");
                    $("#4000").addClass("hidden");
                    enableLoginButton(true);
                    $(".login-loading").hide();
                    if($(window).width() <= 991){
                    	$('html,body').animate({scrollTop: $("#4005").offset().top-75},'fast');
                    }
                }
                if($(window).width() >= 992){
					$('html,body').animate({scrollTop: $(".login-container").offset().top},'fast');
                }    
                app.analytics.pushEvent("login", "login", "direct login", "failure");
            }
        }

        function loginErrorCallback(e) {
            $('#login_submit > button').prop('disabled', false);
            app.analytics.pushEvent("login", "login", "direct login", "failure");
            window.location.replace(errorPageURL);
        }

        function customerLogin(username, qtyExceeded) {
            addCookie('username', username, cookieTimeout);
            if (qtyExceeded == true) {
                //faulty products in basket - max qty exceeded. Hence redirecting to basket page for user to correct the selected products.
                window.location.replace($("#viewBasketPageLink").val());
            } else if (readCookie('guestUserCookie') == null || readCookie('guestUserCookie') == '') {
                // redirect to account overview page
                window.location.replace($("#signInPageURL").val());
            } else {
                // remove the guest user cookie if exists, as the customer has logged in
                removeCookie('guestUserCookie', '');
                // redirect to user to continue with the checkout journey
                window.location.replace($("#checkoutUrl").val());
            }
        }

        function enableLoginButton(flag) {
            if (flag === true) {
                $("#login_submit").removeAttr("disabled");
            } else {
                $("#login_submit").attr("disabled", "disabled");
            }
        }


        /*************Registration page***************/

        $("#Registration_submit button").click(function(event) {
            var form = $("#registration");
            var error_free = objValidator.submitForm(form, form);
            if (!error_free) {
                event.preventDefault();
            } else {
                var register = {}
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
                if ($('#chkAcceptReceive').prop('checked') == true) {
                    register["checkout_customer_isnewsletter"] = 1;
                } else {
                    register["checkout_customer_isnewsletter"] = 0;
                }
                var regUrl = $("#registration-url").attr('value');

                $("#reg_submit").attr("disabled", "disabled");
                $("#Registration_submit button").prop("disabled", true).css("opacity", ".65");
                $(".Registration-loading").show();
                app.appGateway.ajaxPost(regUrl, register, regSuccessCallback, regErrorCallback);
                event.preventDefault();
            }
        });


        function regSuccessCallback(data) {
            $(".Registration-loading").hide();
            $("#Registration_submit button").prop("disabled", false).css("opacity", "1");
            if (data.messages.allErrors == "") {
                $("#reg_submit").removeAttr("disabled");
                $("#4001").addClass("hidden");
                $('.registrationSuccess').html('');
                addCookie('registrationSuccessfulCookie', 'regsuccess');
                app.analytics.pushEvent('register', 'register', 'direct register', 'direct register success');
                window.location.replace($("#successPageUrl").val());
            } else {
                var errorCode = data.messages.error[0].code;
                if (errorCode == 4001) {
                    $("#4001").removeClass("hidden");
                    $('html, body').animate({
                        scrollTop: $('#4001').offset().top - 30
                    }, 1000);
                } else if (errorCode == 3001) {
                    $("#4001").addClass("hidden");
                    var errormsg = "<font size='2' color='red'>" +
                        data.messages.error[0].message +
                        "</font>";
                    $('.registrationSuccess').html(errormsg);
                    $('html, body').animate({
                        scrollTop: $('#3001').offset().top - 30
                    }, 1000);
                }
                app.analytics.pushEvent('register', 'register', 'direct register', 'direct register failure');
                return false;
            }
        }

        var regSuccessCookie = readCookie("registrationSuccessfulCookie");
        if (regSuccessCookie != null && regSuccessCookie == 'regsuccess') {
            $("#accountactivationlink").removeClass("hidden");
            removeCookie('registrationSuccessfulCookie', '');
        } else {
            $("#accountactivationlink").addClass("hidden");
        }

        function regErrorCallback(e) {
            $("#Registration_submit button").prop("disabled", false).css("opacity", "1");
            $(".Registration-loading").hide();
            $("#reg_submit").removeAttr("disabled");
            app.analytics.pushEvent('register', 'register', 'direct register', 'direct register failure');
            window.location.replace(errorPageURL);
        }

        // repeat password can't be blank
        $('#recover_repeat_pwd, #confirmPassword').focusout('input', function() {
            var confirmPassword = $(this);
            var password = $(this).parent().siblings().find('#pwd');
            var isValidFormat = objValidator.confirmPassword(password, confirmPassword);
            objValidator.toggleErrorMsg(confirmPassword, isValidFormat, "confirm_password");
        });

        //Added for mandatory checkbox
        $('input[data-mandatory]').change(function() {
            if ($(this).prop('checked')) {
                $(this).parent().find('span').removeClass("error_show").addClass("error");
            }
        });

        if ($('body').hasClass('loginpage')) {
            if (readCookie('username') != null && readCookie('username') != '' && loggedInCustomer) {
                //do not display sign-in page;instead display home page, if someone tries to access the sign-in page for loggedin customers
                window.location.replace($('#logout_url').val());
            }
        }
    }

    app.login = new Login();

})();