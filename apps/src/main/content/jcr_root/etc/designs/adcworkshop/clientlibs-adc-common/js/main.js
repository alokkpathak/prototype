var loggedInCustomer = false;

app.addPageSpinner = function() {
    $('body').append('<div class="pageSpinner"><div class="page-loading"><div class="line-pulse"><div></div><div></div><div></div><div></div></div></div></div>');
};

app.removePageSpinner = function() {
    $('.pageSpinner').remove();
};

function eqHeight() {
    if ($(window).width() > 991) {
        setTimeout(function() {
            $(".prod-row-desc").show();
            $(".prod-row-desc").css("padding-top", "0px");
            $(".prod-row-desc").css("padding-bottom", "0px");
            $(".banner-painless").css("padding-top", "0px");
            $(".banner-painless").css("padding-bottom", "0px");

            $(".col-eq-height-wrapper").each(function(index) {
                var contentSection = $(this).find('.prod-row-desc');
                var tmp = $(this).height() - $(contentSection).height();
                tmp = tmp / 2;
                $(this).find('.prod-row-desc').css("padding-top", tmp);
            });
            $(".painless").each(function(index) {
                var contentSection = $(this).find('.banner-painless');

                var tmp = $(this).height() - $(contentSection).height();
                tmp = tmp / 2;

                $(this).find('.banner-painless').css("padding-top", tmp);
            });
        }, 100);
    } else if ($(window).width() <= 991 && $(window).width() >= 768) {
        $(".prod-row-desc").show();
        $(".prod-row-desc").css("padding-top", "75px");
        $(".prod-row-desc").css("padding-bottom", "75px");
        $(".banner-painless").css("padding-top", "75px");
        $(".banner-painless").css("padding-bottom", "75px");

    } else {
        $(".prod-row-desc").show();
        $(".prod-row-desc").css("padding-top", "35px");
        $(".prod-row-desc").css("padding-bottom", "35px");
        $(".banner-painless").css("padding-top", "35px");
        $(".banner-painless").css("padding-bottom", "35px");
    }
}

$('.home-site-link').on('click', function() {
    var cname = "isFirstVisit";
    var cvalue = "No";
    var d = new Date();
    d.setTime(d.getTime() + (1 * 24 * 60 * 60 * 1000));
    var expires = "expires=" + d.toGMTString();
    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
    app.analytics.pushEvent('overlay', 'disclaimer overlay', 'disclaimer popup', 'accept');
    $('#disclaimerModal').modal('hide');
});


function alignNavigationBanner() {
    var maxHeightHeaderNav = Math.max.apply(null, $(".nav-links a").map(function() {
        return $(this).height();
    }).get());

    var maxHeightFooterNav = Math.max.apply(null, $('.sub-footer').find('.apply-sensor a').map(function() {
        return $(this).height();
    }).get());

    $(".nav-links a").height(maxHeightHeaderNav);
    $('.sub-footer').find('.apply-sensor a').height(maxHeightFooterNav);
    $(".nav-links .two-navigation-banner .as-banner").css("visibility", "visible");
}

function alignHeroCarouselArrows() {
    var imgHt = $('.heropanel .item.active .hero-carousel-image').height();
    var arrowHt = $('.heropanel .carousel-control img').eq(0).height();
    var arrowPos = Math.floor((imgHt - arrowHt) / 2);
    $('.heropanel .carousel-control.left, .heropanel .carousel-control.right').css({
        'top': arrowPos + 'px'
    });
}

//To show only first three videos on mobile
function hideTutorialsVideo() {
    var btnMore = $('.btnLoadMore a');
    //Do not hide content on resize if Loadmore button is already clicked once
    if ($(window).width() < 991 && $(btnMore).hasClass('expandedTrue') == false) {
        $('.tutorial .col-md-3:gt(2)').hide();
        $('.btnLoadMore a').show();
    } else {
        $('.tutorial .col-md-3:gt(2)').show();
    }
}

function myFunction() {
    // remove the guest user cookie if exists, as user attempts to click sign-in page
    removeCookie('guestUserCookie', '');
    if (readCookie('username') != null && readCookie('username') != '' && loggedInCustomer) {
        // 	show logged in widget - with logout, account overview links
        document.getElementById("myDropdown").classList.toggle("show");
    } else {
        window.location.assign($('#myaccount-url').val());
    }
}
window.onclick = function(event) {
    var matches = event.target.matches ? event.target.matches('.dropbtn') : event.target.msMatchesSelector('.dropbtn');
    if (!matches) {
        var dropdowns = document.getElementsByClassName("dropdown-content");
        var i;
        for (i = 0; i < dropdowns.length; i++) {
            var openDropdown = dropdowns[i];
            if (openDropdown.classList.contains('show')) {
                openDropdown.classList.remove('show');
            }
        }
    }
}
/*Cookie bar top */
function readCookieBar() {
    var cookieAgree = false;
    cookieAgree = readCookie("cookieTopBarAgree");

    if (cookieAgree) {
        $('#cookieBar').addClass('hidden');
    } else {
        $('#cookieBar').removeClass('hidden');
    }
}

$(window).load(function() {
    $("form").each(function() {
        $(this).get(0).reset();
    });

    eqHeight();

    var pageTitle = $(document).attr('title');
    var userIdCookie = readCookie('userid');
    if (userIdCookie != null) {
        app.analytics.pushPage(userIdCookie, 'Loggedin', 'direct', 'Existing customer');
    } else {
        app.analytics.pushPage('', 'Guest', 'direct', 'New customer');
    }
    app.analytics.pushGeneric('AjaxPageLoad', pageTitle);
});

function imgSwp() {
    $(".imgSwap").each(function() {
        if ($(window).width() >= 768) {
            var deskImg = $(this).attr("desk-img");
            $(this).attr("src", deskImg);

        } else {
            var mobImg = $(this).attr("mob-img");
            $(this).attr("src", mobImg);
        }
    });
}


$(document).on('click', "#relatedPhoneButton", function(e) {
    $("#relatedPhoneButton").addClass("hidden");
    $("#relatedPhone").removeClass("hidden");
    app.analytics.pushEvent('Click', 'homepage get in touch', 'questions', 'phone number display');
});
var currentMenu = '';
var windowWidth = $(window).width();
$(window).resize(function() {
    if ($(window).width() != windowWidth) {
        windowWidth = $(window).width();
        imgSwp();
    }
});
$(window).resize(function() {
    if ($(window).width() <= 767) {
        $('.colorbox, .textBottom .img-calque-1').matchHeight();
        $('.mob-twocol-collage .img-calque1, .colorbox-0').matchHeight();
    }
});
$(document).ready(function() {
    resetSubmenu();
    if ($(".nav-links").length > 0 || $('.sub-footer').find('.apply-sensor').length > 0)
        alignNavigationBanner();

    $("#email").keypress(function(event) {
        if (event.keyCode == 13) {
            event.preventDefault();
        }
    });

    if ($(window).width() <= 1024) {
        if ($(".account-overview, .Checkoutpage, .loginpage, .Registration").length) {
            $("#myModal-2, #myModal-1").on("show.bs.modal", function() {
                $('body').addClass("scrollFix");
            });

            $("#myModal-2, #myModal-1").on("hide.bs.modal", function() {
                $('body').removeClass("scrollFix");
            });
        }
    }

    if ($('.heropanel .carousel-control').length > 0) {
        var tmpImg = new Image();
        tmpImg.src = $('.heropanel .item.active .hero-carousel-image').attr('src');
        tmpImg.onload = function() {
            alignHeroCarouselArrows();
        };
    }

    /*Added for HeroPanel carousel - to pause and resume carousel on click of info icon and close button*/

    $('#hero-panel-carousel').find('a[data-toggle=modal]').on('click', function() {
        $("#hero-panel-carousel").carousel('pause');
    });
    $('.heropanel .modal-header button').click(function() {
        $("#hero-panel-carousel").carousel();
    });

    if ($(window).width() >= 992) {
        var count;
        for (count = 1; count < 6; count++) {
            var elemAlign = $("#alignheading" + count);
            if (elemAlign.text().length <= 23) {
                $(".carousel-desc" + count).css("top", "60px");
            } else if (elemAlign.text().length >= 24 && elemAlign.text().length <= 42) {
                $(".carousel-desc" + count).css("top", "43px");
            } else {
                $(".carousel-desc" + count).css("top", "20px");
            }
        }
    }
    $(document).on('click', ".navigatepage", function() {
        var loginPage = $('#loginpage').attr('value')
        var overviewPage = $('#overview').attr('value')
        var username = readCookie('username');
        if (username == "" || username == null) {
            window.location.assign(loginPage);
        } else {
            window.location.assign(overviewPage);
        }
    });

    $("#myModal-1,#myModal-2,#myModal-3,#myModal-4,#myModal-5,#myModal-6,#myModal-7").on("hide.bs.modal", function(e) {
        var $if = $(e.delegateTarget).find("iframe");
        var src = $if.attr("src");
        $if.attr("src", "/empty.html");
        $if.attr("src", src);
    });
    /*SoftwareBlock-DiscoverITPage
    To enable/disable download button on click of checkbox*/
    $('#chkSoftware').on("click", function() {
        if ($(this).prop('checked')) {
            $('#pcbutton').removeClass('disableBtn');
            $('#macbutton').removeClass('disableBtn');
        } else {
            $('#pcbutton').addClass('disableBtn');
            $('#macbutton').addClass('disableBtn');
        }
    });

    $('#pcbutton').on("click", function(e) {
        if ($(this).hasClass('disableBtn')) {
            e.preventDefault();
        }
    });

    $('#macbutton').on("click", function(e) {
        if ($(this).hasClass('disableBtn')) {
            e.preventDefault();
        }
    });

    //Tutorials Page-To show more videos on click of load more
    $('.btnLoadMore a').on('click', function() {
        $(this).hide();
        $(this).addClass('expandedTrue');
        $('.tutorial .col-md-3:gt(2)').slideDown("slow");
    });

    hideTutorialsVideo();
    eqHeight();

    var sourceSwap = function() {
        var $this = $(this);
        var newSource = $this.data('alt-src');
        $this.data('alt-src', $this.attr('src'));
        $this.attr('src', newSource);
    }

    $(function() {
        $('img[data-alt-src]').each(function() {
            new Image().src = $(this).data('alt-src');
        }).hover(sourceSwap, sourceSwap);
    });

    $('.tooltipclass').attr('title', $('#tooltiptextdisplay').val());



    if ($(window).width() <= 767) {
        $('.colorbox, .textBottom .img-calque-1').matchHeight();
        $('.mob-twocol-collage .img-calque1, .colorbox-0').matchHeight();
    }
    $('.thankyouWrapper').hide();
    $('.thankyouWrappererror').hide();
    $('.lblEmailError').hide();
    $('#lblSuccessMsg').hide();
    readCookieBar();
    imgSwp();

    /*=====Cookibar===*/
    $('#cookieLink').click(function() {
        $('#cookieBar').addClass('hidden');
        var cookieTimeout = new Date();
        cookieTimeout.setTime(cookieTimeout.getTime() + (14 * 24 * 60 * 60 * 1000));
        addCookie('cookieTopBarAgree', '1', cookieTimeout);
    });

    var topBarAgreeCookie = readCookie("cookieTopBarAgree");
    if (topBarAgreeCookie == '1') {
        // hide the top bar
        $('#cookieBar').addClass('hidden');
    } else {
        $('#cookieBar').removeClass('hidden');
    }

    /*=====Stickybar close button===*/
    var stickycomeuptime = parseInt($('#stickyfooterTime').val());
    app.stickyFooter = {};
    app.stickyFooter.closeTime = stickycomeuptime;
    $('.closestickyfooter').click(function(e) {
        $('.sticky_footer').addClass('hidden');
        var closeBtnCookieTimeout = new Date();
        closeBtnCookieTimeout.setTime(closeBtnCookieTimeout.getTime() + app.stickyFooter.closeTime);
        addCookie('stickyfooterAgree', '1', closeBtnCookieTimeout);
        e.preventDefault();
    });

    app.stickyFooter.closeBtnCookie = readCookie("stickyfooterAgree");
    if (app.stickyFooter.closeBtnCookie == '1') {
        $('.sticky_footer').addClass('hidden');
    } else {
        $('.sticky_footer').removeClass('hidden');
    }




    $('#redirecthomeUrl').click(function() {
        app.analytics.pushEvent('overlay', 'checkout dismiss overlay', 'checkout dismiss popup', 'leave');
    });
    $('#dismissOk').click(function() {
		var CountryCookieName = readCookie('countryCookie'); 
		if(CountryCookieName == 'TR'){
        var productVal = $('#product-title').val();
        app.analytics.pushEvent('overlay', 'alert leavig site', 'alert popup', 'cancel');
        app.analytics.pushEvent('overlay', 'alert leavig site', 'alert popup:'+ productVal , 'cancel');
        }else{
            app.analytics.pushEvent('overlay', 'checkout dismiss overlay', 'checkout dismiss popup', 'cancel');
        }  
    });

    $('#redirectUrl').click(function() {
		var CountryCookieName = readCookie('countryCookie'); 
        $('#myModal-thirdParty').modal('hide');
		if(CountryCookieName == 'TR'){
        var productVal = $('#product-title').val();
        app.analytics.pushEvent('overlay', 'alert leavig site', 'alert popup', 'ok');
        app.analytics.pushEvent('overlay', 'alert leavig site', 'alert popup:'+ productVal, 'ok');
        }else{
		app.analytics.pushEvent('overlay', 'checkout dismiss overlay', 'checkout dismiss popup', 'leave');
        }  
    });
    $('#bsktDetails,#thirdparty_url').click(function() {
        $('#commonoverlaytext').removeClass('hidden');
        $('#homeoverlaytext').addClass('hidden');
        $('#redirectUrl').removeClass('hidden');
        $('#redirecthomeUrl').addClass('hidden');
        app.analytics.pushEvent('overlay', 'checkout dismiss overlay', 'checkout dismiss popup', 'load');
    });

    $('#headimage').click(function() {
        $('#homeoverlaytext').removeClass('hidden');
        $('#commonoverlaytext').addClass('hidden');
        $('#redirecthomeUrl').removeClass('hidden');
        $('#redirectUrl').addClass('hidden');
        app.analytics.pushEvent('overlay', 'checkout dismiss overlay', 'checkout dismiss popup', 'load');
    });

    $('.submenuClick').click(function(event) {
        if (!event.target.id) {
            redirectUrl = $(this).find('span a').attr('href');
            window.location.href = redirectUrl;
        }
    });
    $('.summary-block').click(function(event) {
        if (!event.target.id) {
            summaryredirectUrl = $(this).find('a').attr('href');
            window.location.href = summaryredirectUrl;
        }
    });


    $(document).on('change', '#termscondCheckId', function() {
        if (this.checked) {
            $('#termCondError').addClass('hidden');
        } else {
            $('#termCondError').removeClass('hidden');
        }
    });

    //Updated for Limiting the Characters in Quantity Spinner.
    $(document).on('keydown', ".prodSpinner", function(e) {
        var keys = [8, 9, 16, 17, 18, 19, 20, 27, 33, 34, 35, 36, 37, 38, 39, 40, 45, 46, 144, 145];
        if ($.inArray(e.keyCode, keys) == -1) {
            if (this.value.length == 2) {
                e.preventDefault();
                e.stopPropagation();
            }
        }
        $('.error_show').html("");
    });

    $(document).on('click', ".prodMenulinks", function(e) {
        setTimeout(
            function() {
                if ($('.in').attr('id') != undefined) {
                    var $container = $("html,body");
                    var $scrollTo = $('.prodMenu');
                    $container.animate({
                        scrollTop: $scrollTo.offset().top - $container.offset().top,
                        scrollLeft: 0
                    }, 300, 'swing', function() {
                        $('.collapsable-wrapper:visible').focus();
                    });
                }
            }, 500);
    });

    if ($('body').hasClass('product-basket')) {
    	$(document).on('blur', ".prodSpinner", function(e) {
			$('.bootstrap-touchspin-up').attr('disabled', false);
            $('.bootstrap-touchspin-down').attr('disabled', false);
    	});
    };

    $(document).on('keyup change', ".prodSpinner", function(e) {
        // disable arrows when manually entering number - else will lead to 500 page
        if ($(this).hasClass('update')) {
            $('.bootstrap-touchspin-up').attr('disabled', true);
            $('.bootstrap-touchspin-down').attr('disabled', true);
        }
        var oldValue = this.defaultValue;
        var selectedElement = this.id;
        var key = parseInt(this.value);
        var max = parseInt(this.max);
        var min = parseInt(this.min);

        var keys = [8, 9, 16, 17, 18, 19, 20, 27, 33, 34, 35, 36, 37, 38, 39, 40, 45, 46, 144, 145];
        if ($.inArray(e.keyCode, keys) == -1) {
            $(".addbasket").removeClass("disabled");

            if ((key < min || isNaN(key) || key >= max)) {
                 if(key >= max ) {
                  if(isNaN(key)){
					$('.' + selectedElement).val(max);
                  }else{
					$('.' + selectedElement).val(max);
                    if ($(this).hasClass('update')) { 
                       $('.prodSpinner').blur();
                    }  
                  }
                 } 
                // In iPad for less than min, the condition is checked after value update.
                // This is to avoid 500 error issue but price not updating only in iPad.
                 if(key < min || isNaN(key)) {
                    if (navigator.appName == 'Microsoft Internet Explorer' || !!(navigator.userAgent.match(/Trident/) || navigator.userAgent.match(/rv:11/)) || (typeof $.browser !== "undefined" && $.browser.msie == 1)) {
                        if ($(this).hasClass('update')) { 
                            $('.prodSpinner').blur();
                        }
                        $('.' + selectedElement).val(min);
                    } else {
                        $('.' + selectedElement).val(min);
                        if ($(this).hasClass('update')) { 
                           $('.prodSpinner').blur();
                        }
                    }
                 }
            } else {
                if (navigator.appName == 'Microsoft Internet Explorer' || !!(navigator.userAgent.match(/Trident/) || navigator.userAgent.match(/rv:11/)) || (typeof $.browser !== "undefined" && $.browser.msie == 1)) {
                    if ($('body').hasClass('productPage')) {
                        $('.' + selectedElement).val(key);
                    }
                    if ($('body').hasClass('product-basket') && isNaN(this.value)) {
                        $('.' + selectedElement).val(key);
                    }
                    if (e.keyCode == '13' && $(this).hasClass('update')) {
                        $('.prodSpinner').blur();         
                    }
                }
                else {
                    $('.' + selectedElement).val(key);
                }
                $('#' + selectedElement + 'Error').html("");
                $('.prodmessage').removeClass('hidden');
            }

            var commaPoint = false;
            var unitPrice = 0;
            var totalprice = $('#totalPrice').val();
            if (totalprice) {
                if ((($('#totalPrice').val()).indexOf(',')) != -1) {
                    commaPoint = true;
                    unitPrice = ($('#totalPrice').val()).replace(",", ".");
                } else {
                    unitPrice = $('#totalPrice').val();

                }

                var total = (parseFloat($('.' + selectedElement).val()) * parseFloat(unitPrice)).toFixed(2);
                var splitedTotal = (total.toString()).split(".");

                $('.prodNum').html($('#totalCurrency').val() + splitedTotal[0]);
                if (commaPoint) {
                    $('.prodDec').html("," + splitedTotal[1]);
                    $('#product-priceDec').attr('value', "," + splitedTotal[1]);
                } else {
                    $('.prodDec').html("." + splitedTotal[1]);
                    $('#product-priceDec').attr('value', "." + splitedTotal[1]);
                }

                $('#product-price').val($('#totalCurrency').val() + total);
                $('#product-priceNum').attr('value', $('#totalCurrency').val() + splitedTotal[0]);
            }

            $("#prod-count").val($('#' + selectedElement).val());
        } else if (isNaN(key)) {
            $(".addbasket").addClass("disabled");
        }

    });


    $(document).on('change', ".prodSpinner", function(e) {
        var oldValue = this.defaultValue;
        if ($(this).hasClass('update')) {
            skuName = this.name;
            $('.prodSpinner').attr('disabled', true);
            $('.bootstrap-touchspin-up').attr('disabled', true);
            $('.bootstrap-touchspin-down').attr('disabled', true);
            app.shoppingBasket.updateQty(skuName, oldValue);
        }
    });

    $(document).on('focus', ".qtySelect", function(e) {
        previous = this.value;
    });


    $(document).on('change', ".qtySelect", function(e) {
        var commaPoint = false;
        var unitPrice = 0;
        var totalprice = $('#totalPrice').val();
        if (totalprice) {

            if (($('#totalPrice').val()).includes(',')) {
                commaPoint = true;
                unitPrice = ($('#totalPrice').val()).replace(",", ".");
            } else {
                unitPrice = $('#totalPrice').val();

            }

            var selectedQty = $(this).val();
            var total = (parseFloat(selectedQty) * parseFloat(unitPrice)).toFixed(2);
            var splitedTotal = (total.toString()).split(".");

            $('.prodNum').html($('#totalCurrency').val() + splitedTotal[0]);
            if (commaPoint) {
                $('.prodDec').html("," + splitedTotal[1]);
                $('#product-priceDec').attr('value', "," + splitedTotal[1]);
            } else {
                $('.prodDec').html("." + splitedTotal[1]);
                $('#product-priceDec').attr('value', "." + splitedTotal[1]);
            }

            $('#product-price').val($('#totalCurrency').val() + total);
            $('#product-priceNum').attr('value', $('#totalCurrency').val() + splitedTotal[0]);
        }

        if ($(this).hasClass('update')) {
            app.shoppingBasket.updateQty(this.name, previous);
        }

    });

    //calling for WD-323 defect
    checkitem();

    $('#shareCarousel').on('slid.bs.carousel', '', checkitem);
    //calling for WD-323 defect

    /*share functionality*/
    $(document).on('click', "#btnProductShare", function(e) {
        e.stopImmediatePropagation();
        $('.pinchShareVideo').attr('href', 'javascript:void(0)'); /* make pinterest icon accessible */
        if ($('#sharefuction').hasClass("hidden")) {
            $('#sharefuction').removeClass('hidden');
        } else {
            $('#sharefuction').addClass('hidden');
        }
    });
    /*video share functionality*/
    $(document).on('click', "#btnVideoShare", function(e) {
        e.stopImmediatePropagation();
        $('.pinchShareVideo').attr('href', 'javascript:void(0)'); /* make pinterest icon accessible */
        if ($('#videofuction').hasClass("hidden")) {
            $('#videofuction').removeClass('hidden');
        } else {
            $('#videofuction').addClass('hidden');
        }
    });

    $(document).on('click', ".discover1", function(e) {
        if (!($('.shareVideoTut').hasClass("hidden"))) {
            $('.shareVideoTut').addClass('hidden');
        }
    });
    /*video share functionality*/
    $(document).on('click', ".btnVideoshareTutStyle", function(e) {
        e.preventDefault();
        e.stopImmediatePropagation();
        $('.pinchShareVideo').attr('href', 'javascript:void(0)'); /* make pinterest icon accessible */
        if ($('.shareVideoTut').hasClass("hidden")) {
            $('.shareVideoTut').removeClass('hidden');
        } else {
            $('.shareVideoTut').addClass('hidden');
        }
    });

    $(document).on('click', ".shareImgPane", function(e) {

        if (!($('.shareVideoTut').hasClass("hidden"))) {
            $('.shareVideoTut').addClass('hidden');
        }
    });

    $(document).on('click', ".btnVideoShare", function(e) {
        e.stopImmediatePropagation();
        $('.pinchShareVideo').attr('href', 'javascript:void(0)'); /* make pinterest icon accessible */
        var item = $(this).closest('.item');
        var sharePopup = $(item).find('.sharePopup');

        if ($(sharePopup).hasClass("hidden")) {
            $(sharePopup).removeClass('hidden');
            $('#shareCarousel').find('.col-xs-12.col-sm-12.col-md-8.iframevideo').css("margin-bottom", "8%");
        } else {
            $(sharePopup).addClass('hidden');
            $('#shareCarousel').find('.col-xs-12.col-sm-12.col-md-8.iframevideo').css("margin-bottom", "8%");

        }
    });

    $("input[type='checkbox']").change(function() {
        if ($(this).is(":checked")) {
            $(this).next().addClass("checked");
        } else {
            $(this).next().removeClass("checked");
        }
    });

    $('#search-button').click(function() {
        var searchOption = $('#searchBar').val();
        if (searchOption != null && searchOption != "") {
            var searchResURL = $('#searchresults-url').val();
            $(location).attr('href', searchResURL + '?q=' + searchOption);
        }
    });


    var curURL = document.location.toString();
    highlightMenu();
    /*To highlight menu when a user is in a section below one of the menu nodes*/
    function highlightMenu() {
        $('#myNavbar').find('span').removeClass('active-menu');
        $('.submenu-panel li a').each(function() {
            if (curURL.indexOf(this.href) != -1) {
                var submenuId = $(this).closest('.submenu-panel').attr('id');
                var mainMenu = $('#myNavbar').find('li[data-target=' + submenuId + ']');
                $(mainMenu).find('span').addClass('active-menu');
                currentMenu = mainMenu;
                return;
            }
        });
    }

    $(document).on('click', "#btnAddQuestion", function() {
        showQuestionPanel();
    });

    $(document).on('click', "#btnDelete", function() {
        removeQuestion($(this));

    });

    $(document).on('click', "#btnSubmitQuestion", function() {
        $('#questionWrapper').empty();
    });

    function showQuestionPanel() {
        var questionCount = $('#questionWrapper').find('.question').length;
        if (questionCount == undefined) {
            questionCount = 0;
        }
        var html =
            '<div class="loopcount question col-xs-12 padding-zero" id="question_' + questionCount + '"><div class="form-group col-xs-10 padding-zero"><label for="txtQuestion_' + questionCount + '">Question:</label><textarea class="form-control"  id="txtQuestion_' + questionCount + '"></textarea></div><div><div class="form-group col-xs-10 padding-zero"><label for="txtAnswer_' + questionCount + '">Answer:</label><textarea class="form-control" rows="8" id="txtAnswer_' + questionCount + '"></textarea></div><div class="form-group col-xs-10 padding-zero"><label for="txtButtontxt_' + questionCount + '">ButtonText:</label><textarea class="form-control" id="txtButtontxt_' + questionCount + '"></textarea></div><div class="form-group col-xs-10 padding-zero"><label for="txtButtonlink_' + questionCount + '">ButtonUrl:</label><textarea class="form-control" id="txtButtonlink_' + questionCount + '"></textarea></div><div class="col-xs-2 "><button type="button" class="btn  btn-lg button-orange" id="btnDelete" >Remove</button></div></div></div>';

        $('#questionWrapper').append(html);

    }

    function removeQuestion(element) {
        var parentFaq = $(element).closest('.question');
        $(parentFaq).remove();

    }

    function clearQuestionPanel(element) {

        $(element).closest('.question').find('#txtQuestion').val('');
        $(element).closest('.question').find('#txtAnswer').val('');
    }

    function removeFaq(element) {
        var parentFaq = $(element).closest('.faq');
        $(parentFaq).remove()

    }

    function resetSubmenu() {
        var isMobile = /Android|webOS|iPhone|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
        if (window.innerWidth <= 767) {
            /*Remove dropdown panel from different container and appending the panel to parent li*/
            var list = $('.menu').find('.nav-pills').find('li');
            $(list).each(function(key, value) {
                var li = $(this);
                var panel = $('#' + $(li).attr('data-target'));
                var panelId = $(li).attr('data-target')
                if ($('#myNavbar').find('#' + panelId).length <= 0)
                    $(panel).clone().insertAfter($(li));
            });
        }

        /*Added hover only for desktop*/
        if (!isMobile && (!/ipad/i.test(navigator.userAgent)) && window.innerWidth > 767) {
            $('.submenu-panel').hover(function() {
                var submenuId = $(this).attr('id');
                var mainMenu = $('#myNavbar').find('li[data-target=' + submenuId + ']');
                $('#myNavbar li span').removeClass('active-menu');
                $(mainMenu).find('span').addClass('active-menu');
            });

            $('.menu').find('.nav-pills').find('li').each(function() {
                var li = $(this),
                    $panel = $('.submenuContainer').find('#' + $(this).attr('data-target')),
                    hide_to = null;
                var hide = function() {
                    // start hide timeout
                    hide_to = window.setTimeout(function() {
                        $panel.removeClass("open");
                        $panel.fadeOut(500);
                    }, 200);
                };

                var show = function() {
                    // clear hide timeout
                    window.clearTimeout(hide_to);
                    if (!$panel.is(".open")) {
                        // open panel, only if it is not open already
                        $('.submenu-panel').removeClass("open");
                        $panel.addClass("open");
                        $panel.fadeIn(500);
                    }
                };

                $(this).mouseenter(function() {
                    show();
                    showSubmenu($(li));
                }).mouseleave(function() {
                    hide();
                    showSubmenu($(li));
                    highlightMenu();
                });

                $panel.mouseenter(function() {
                    show();

                }).mouseleave(function() {
                    hide();
                    showSubmenu($(li));
                    highlightMenu();

                });
            });
        }
        if (window.innerWidth <= 767) {
            $('.menu').find('.nav-pills').find('li').unbind('mouseenter mouseleave hover');
        }
    }
    /*To show menu on click*/

    $('.menu').find('.nav-pills').find('li').click(function(e) {
        showSubmenu($(this));
        if (window.innerWidth <= 767)
            var panel = $('#myNavbar').find('#' + $(this).attr('data-target'));
        else
            var panel = $('.submenuContainer').find('#' + $(this).attr('data-target'));

        $(panel).slideToggle("slow");
    });

    /*To show active menu for desktop and toggle menu arrows up and down for mobile*/

    function showSubmenu(element) {
        var li = $(element);
        var panel = '';
        // var panel = $('#'+$(li).attr('data-target'));
        if (window.innerWidth <= 767) {
            panel = $('#myNavbar').find('#' + $(li).attr('data-target'));
            var menuImg = $(li).find('img.menu-arrow');
            if ($(menuImg).hasClass('arrow-down')) {
                $(menuImg).removeClass('arrow-down').addClass('arrow-up');
                $(menuImg).attr('src', '/content/dam/adc/fsl/images/global/en/mobileImages/menu-arrow-up.png');
            } else {
                $(menuImg).removeClass('arrow-up').addClass('arrow-down');
                $(menuImg).attr('src', '/content/dam/adc/fsl/images/global/en/mobileImages/menu-arrow-down.png');
            }
            $('img.menu-arrow').not(menuImg).addClass('arrow-down').removeClass('arrow-up');
            $('img.menu-arrow').not(menuImg).attr('src', '/content/dam/adc/fsl/images/global/en/mobileImages/menu-arrow-down.png');
        } else /*For desktop, show active menu with a border*/ {
            panel = $('.submenuContainer').find('#' + $(li).attr('data-target'));
            var isCurrentMenu = false;
            if (currentMenu.length > 0) {
                if (currentMenu.attr('id') == $(li).attr('id'))
                    isCurrentMenu = true;
            }
            //do not toggle Active class for the current page menu.
            if (!(isCurrentMenu)) {
                $('.menu').find('.nav-pills').find('li').not($(li)).find('span').removeClass('active-menu');
                $(li).find('span').toggleClass('active-menu');
                if ($(li).find('span').hasClass('active-menu') == false && isIpad)
                    $(currentMenu).find('span').addClass('active-menu');
            } else if (isIpad) {
                $('.menu').find('.nav-pills').find('li').find('span').removeClass('active-menu');
                $(currentMenu).find('span').addClass('active-menu');
            }
        }
        $('.submenu-panel').not(panel).hide();
    }
    $('.btn-validate-email').on('click', function(event) {
        var eventActionValue = this.id,
            eventActionName;
        if (eventActionValue == "footerNews") {
            eventActionName = "Footer";
        }
        if (eventActionValue == "newsletter") {
            eventActionName = "newsletter checkout";
        }
        if (eventActionValue == "stickynews") {
            eventActionName = "scroll sticker";
        }
        var parent = $(this).closest('.formWrapper').parent();
        var email = $(parent).find('#txtEmail').val();
        var isValiemail = validateEmail(email);
        var isChecked = $(parent).find('input[type=checkbox]:checked');
        if (isValiemail && isChecked.length > 0) {
            $(parent).find('#lblEmailError').hide();
            var subscription_email_obj = {};
            subscription_email_obj["email"] = email;
            var checkOutNewsLetterSubscriptionUrl = $(".checkOutNewsLetterSubscriptionUrl").attr('value');
            if (checkOutNewsLetterSubscriptionUrl != null && checkOutNewsLetterSubscriptionUrl != undefined) {
                app.appGateway.ajaxPut(checkOutNewsLetterSubscriptionUrl, subscription_email_obj, newsletter_successCallback, newsletter_errorCallback, eventActionName);
            }
            if ($(this).closest('.formWrapper').attr('data-section') == 'newsletter') {
                $('#lblSuccessMsg').show();
                $(parent).find('#txtEmail').val('');
                $(parent).find('input[type=checkbox]').prop('checked', false);
            } else {
                $(parent).find('.formWrapper').hide();
            }
            event.preventDefault();
        } else {
            if ($.trim(email).length == 0 || isValiemail == false) {
                if (eventActionValue == "stickynews") {
                    $(parent).find('#lblEmailError').text($('#invalidEmailFormatSticky').val());
                    $(parent).find("#txtEmail").focus();
                    $(parent).find('#lblEmailError').show();
                    $(parent).find('#lblCheckboxError').hide();
                } else {
                    $(parent).find('#lblEmailError').text($('#invalidEmailFormat').val());
                    $(parent).find("#txtEmail").focus();
                    $(parent).find('#lblEmailError').show();
                    $(parent).find('#lblCheckboxError').hide();
                }
                app.analytics.pushEvent("Click", "Newsletter", eventActionName, "signup failure");
            } else if (isChecked.length <= 0) {
                $(parent).find('#lblEmailError').hide();
                $(parent).find('#lblCheckboxError').text($('#emptycheckBoxtext').val());
                $(parent).find('#lblCheckboxError').show();
                $('#lblSuccessMsg').hide();
                if (isValiemail) {
                    $(parent).find('input[type=checkbox]').focus();
                }
            }
        }

        function newsletter_successCallback(data) {
            if (data.messages.allErrors != "") {
                var errorCode = data.messages.error[0].code;
                if (errorCode == 4057 || errorCode == 4056) {
                    $(parent).find('.thankyouWrappemailalreadyexists').show();
                    app.analytics.pushEvent("Click", "Newsletter", eventActionName, "signup failure");
                }
            } else {
                var successCode = data.messages.success.code;
                if (successCode == 2046 || successCode == 2029) {
                    $(parent).find('.thankyouWrapper').show();
                }
                app.analytics.pushEvent("Click", "Newsletter", eventActionName, "signup success");
            }
        }

        function newsletter_errorCallback(e) {
            app.analytics.pushEvent("Click", "Newsletter", eventActionName, "signup failure");
            $(parent).find('.thankyouWrappererror').show();
        }
    });
    $('input[type=email]').change(function() {
        $('.lblEmailError').hide();
    });
    $('.infoIcon').on('click', function(e) {
        var offset = $(this).offset();
        var parentOffset = $(this).closest('.container-fluid').offset();
        var relY = e.pageY - parentOffset.top;
        var iconOffset = $(this).offset();
        showInfoModal(this, iconOffset.left, relY);

    });

    function showInfoModal(element, top, left) {
        var infoModalId = $(element).attr('data-target');
        $(infoModalId).modal('show');
        if (!isMobile) {
            $(infoModalId).css('position', 'absolute');
            setTimeout(function() {
                $(infoModalId).css({
                    'top': top - 100,
                    'left': -left
                });
            }, 200);
            $('body').removeClass('modal-open');
        }
    }

    /*********For mandatory dropdown fileds**********/

    $('select[data-mandatory]').change(function() {
        var objValidator = app.utils.validator;
        if ($(this).val() == "select") {
            $(this).parent().find('span.error').addClass("error_show").removeClass("error");
            objValidator.toggleErrorMsg($(this), false, "dropdown");
        } else {
            $(this).parent().find('span.error_show').removeClass("error_show").addClass("error");
        }
    });
    /* ==========================================================================
                  Carousel interval
    ========================================================================== */

    $(document).ready(function() {
        $(document).click(function(evt) {
            if (window.innerWidth >= 767) {
                var el = evt.target;
                if (evt.target.tagName.toLowerCase() != "span") {
                    $('.submenu-panel:visible').hide();
                    $('.menu').find('.nav-pills').find('li').find('span').removeClass('active-menu');
                    $(currentMenu).find('span').addClass('active-menu');
                } else if (evt.target.tagName.toLowerCase() == "span") {
                    if ($(el).closest('#myNavbar') == null) {
                        return;
                    }
                } else
                    $('.submenu-panel:visible').hide();
            }
        });

        $(".mobile_land").hide();
        $(".mobile_port").hide();

        var isPortrait = false;
        var videointervalTime = $('#carouselTimerinterval').val();
        var carouseltime = $('#carouselTime').val();
        var intervalTime = "";
        if (carouseltime != undefined) {
            intervalTime = carouseltime;
        }
        if (videointervalTime != undefined) {
            intervalTime = videointervalTime;
        }
        $('.carousel').carousel({
            interval: intervalTime
        });
        checkPortrait();

    });

    $(window).resize(function() {
        checkPortrait();
        resetSubmenu();
        if (window.innerWidth > 767)
            $('.submenu-panel').hide();

    });

    function checkPortrait() {

        if (window.innerHeight > window.innerWidth) {

            isPortrait = true;
            $(".mobile_land").show();
            $(".mobile_port").hide();
        } else {
            isPortrait = false;
            $(".mobile_port").show();
            $(".mobile_land").hide();
        }
    }

    /* ==========================================================================
                  Scroll up to top of the page
    ========================================================================== */
    //Check to see if the window is top if not then display button
    $(window).scroll(function() {
        if ($(this).scrollTop() > 100) {
            $('.scrollToTop').fadeIn();
        } else {
            $('.scrollToTop').fadeOut();
        }
    });


    //Click event to scroll to top
    $('.scrollToTop').click(function() {
        $('html, body').animate({
            scrollTop: 0
        }, 2000);
        return false;
    });
    /********************************************************
    Applyig sensor - collapsabile panel
    To change arrow up and right on panel collapse and expand
    *********************************************************/
    $('.preparing-skin').find('.panel-collapse').on('hide.bs.collapse', function() {
        var arrowIcon = $(this).closest('.panel-default').find('.glyphicon');
        $(this).closest('.panel-default').find('.pnl-title').toggleClass('active');
        $(arrowIcon).addClass('glyphicon-menu-down');
        $(arrowIcon).removeClass('glyphicon-menu-up');

    });
    $('.preparing-skin').find('.panel-collapse').on('show.bs.collapse', function() {
        var arrowIcon = $(this).closest('.panel-default').find('.glyphicon');
        $(this).closest('.panel-default').find('.pnl-title').toggleClass('active');
        $(arrowIcon).addClass('glyphicon-menu-up');
        $(arrowIcon).removeClass('glyphicon-menu-down');

    });

    var syncToken = readCookie('apptoken');
    var unauthorizedURL = $('#unauthorized-url').val();
    if (syncToken == "null" || syncToken == null || syncToken == undefined || syncToken == '') {
        var tokenUrl = $("#getTokenUrl").attr('value');
        app.appGateway.ajaxGet(tokenUrl, tokenSuccessCallback, tokenErrorCallback);
    }

    function tokenSuccessCallback(data) {}

    function tokenErrorCallback(e) {}

    var countryCookieVal = readCookie('countryCookie');
    if (countryCookieVal == "null" || countryCookieVal == null || countryCookieVal == undefined || countryCookieVal == '') {
        var currentPagePath = $("#currPagePath").attr('value');
        var localecountryUrl = $("#localeCountryServletUrl").attr('value');
        app.appGateway.ajaxSetLocale(localecountryUrl, currentPagePath, localeSuccessCallback, localeErrorCallback);
    }

    function localeSuccessCallback(data) {}

    function localeErrorCallback(e) {
        app.analytics.pushError(e.status, e.responseText, location.href, document.referrer);
    }
	
	if(!($('body').hasClass('Thankyoupage')) && !($('body').hasClass('Checkoutpage'))){
		var isCustURL = $("#isCustUrl").attr('value');
		if (isCustURL != null) {
			app.appGateway.ajaxGet(isCustURL, custSuccessCallback, custErrorCallback);
		}
	}
	function custSuccessCallback(data) {
	    if (data) {
	        loggedInCustomer = true;
			app.login.setLoginInfo();
	    } else {
	        loggedInCustomer = false;
			app.login.logoutUserSession();
	    }
	}
	function custErrorCallback(e) {
	}
	
	
});

/* ==========================================================================
                        Help FAQ page question slide downs
========================================================================== */
jQuery(function($) {
    $('.Question-heading span.clickable').on("click", function(e) {
        if ($(this).hasClass('Question-collapsed')) {
            // expand the panel
            $(this).parents('.Question').find('.Question-body').slideUp();
            $(this).removeClass('Question-collapsed');
            $(this).find('i').removeClass('glyphicon-chevron-up').addClass('glyphicon-chevron-down');
        } else {
            // collapse the panel
            $(this).parents('.Question').find('.Question-body').slideDown();
            $(this).addClass('Question-collapsed');
            $(this).find('i').removeClass('glyphicon-chevron-down').addClass('glyphicon-chevron-up');
        }
    });
});
/* ==========================================================================
                        Email validation
========================================================================== */
function validateEmail(email) {
    var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
    if (filter.test(email)) {
        return true;
    } else {
        return false;
    }
}
/*============================================
video carousal - 2nd iteration - WD-323 defect
============================================*/
function checkitem() // check function
{
    var $this = $('#shareCarousel');
    if ($this.find('.carousel-inner .item:first').hasClass('active')) {
        $this.find('.left.carousel-control').hide();
        $this.find('.right.carousel-control').show();
    } else if ($this.find('.carousel-inner .item:last').hasClass('active')) {
        $this.find('.right.carousel-control').hide();
        $this.find('.left.carousel-control').show();
    } else {
        $this.find('.right.carousel-control').show();
        $this.find('.left.carousel-control').show();

    }
}

/* ==========================================================================
                        Sticky Footer
========================================================================== */

$(document).scroll(function() {
    if ($(".productPage").length > 0) {

        if ($(window).width() > 767) {

            var imageSection = $('.product-thumbnail').isOnScreen();
            var buyNowCheck = $('.addbasket').isOnScreen();
            var subMenuCheck = $('.collapsable-wrapper').isOnScreen();

            if (!buyNowCheck && !imageSection && !subMenuCheck) {
                $('.productTitle').html($('#product-title').val());
                $('.productPrice').html($('.prodNum:visible').html());
                $('.productPriceDec').html($('.prodDec:visible').html());
                $('.sticky_header').removeClass('hidden');
                $('.sticky_headerMobile').addClass('hidden');
            } else {
                $('.sticky_header').addClass('hidden');
                $('.sticky_headerMobile').addClass('hidden');
            }
        } else {
            var imageSection = $('.product-thumbnail').isOnScreen();
            var buyNowCheck = $('.addbasketMobile').isOnScreen();
            var subMenuCheck = $('.collapsable-wrapper').isOnScreen();

            var subMenu = $('.header').isOnScreen();
            if (!buyNowCheck && !imageSection && !subMenu && !subMenuCheck) {
                $('.productTitle').html($('#product-title').val());
                $('.productPrice').html($('.prodNum:visible').html());
                $('.productPriceDec').html($('.prodDec:visible').html());
                $('.sticky_headerMobile').removeClass('hidden');
                $('.sticky_header').addClass('hidden');
            } else {
                $('.sticky_headerMobile').addClass('hidden');
                $('.sticky_header').addClass('hidden');
            }
        }

    } else {
        var isFooterVisible = $('footer').isOnScreen();
        var isReceiveNewsletterVisible = $('#receiveNewsletter').isOnScreen();
        var y = $(this).scrollTop();
        if ($(".discoverCarousel").offset() && $(window).scrollTop() >= $(".discoverCarousel").offset().top) {
            if (isFooterVisible || isReceiveNewsletterVisible) {
                $('.stickyFooter').fadeOut();
            } else {
                $('.stickyFooter').fadeIn();
            }
        } else {
            $('.stickyFooter').fadeOut();
        }
    }
});
/* ==========================================================================
                        parallex
========================================================================== */

if ($('.parallex').length > 0) {
    $(document).on('ready scroll', function() {
        /*show/hide parallax indicators when parallex is in view*/
        var parallexScrollY = $('.parallex').offset().top - 10;
        var pageScrollY = $(this).scrollTop();
        var parallexHt = $('.parallex').height();
        var slideHt = $('.jarallax').height();
        var bulletListHt = $('.parallex-ol').height();
        /* bullets appear when 1st slide crosses top position of bullet list and disappear when last slide crosses bottom position of bullet list */
        if (pageScrollY >= (parallexScrollY - Math.floor(($(window).height() - bulletListHt) / 2)) && pageScrollY <= (parallexScrollY + parallexHt - Math.floor($(window).height() / 2))) {
            $('.parallex-ol').fadeIn(400, function() {
                /*To set active parallax indicator*/
                var slideDiff = pageScrollY - (parallexScrollY - Math.floor(($(window).height() - bulletListHt) / 2));
                var activeSlide = Math.floor(slideDiff / slideHt);
                $('.parallex-ol').find('li').removeClass('activeLi');
                $('.parallex-ol').find('li').eq(activeSlide).addClass('activeLi');
                if ($('.jarallax').eq(activeSlide).data('list-style') == 'white') {
                    $('.parallex .carousel-indicators').addClass('white');
                } else {
                    $('.parallex .carousel-indicators').removeClass('white');
                }
            });
        } else {
            $('.parallex-ol').fadeOut();
        }
    });
}

/*=====================================================
Function to check if element is visible in viewport
=========================================================*/
$.fn.isOnScreen = function() {

    var win = $(window);

    var viewport = {
        top: win.scrollTop(),
        left: win.scrollLeft()
    };
    viewport.right = viewport.left + win.width();
    viewport.bottom = viewport.top + win.height();

    var bounds = this.offset();
    if (bounds) {
        bounds.right = bounds.left + this.outerWidth();
        bounds.bottom = bounds.top + this.outerHeight();

        return (!(viewport.right < bounds.left || viewport.left > bounds.right || viewport.bottom < bounds.top || viewport.top > bounds.bottom));
    } else {
        return true;
    }
};

function isPortrait() {
    return window.innerHeight > window.innerWidth;
}
var isIpad = /ipad/i.test(navigator.userAgent);

jQuery(function($) {
    var fetchedCountryCookie = readCookie('countryCookie');
    if (fetchedCountryCookie == "IT") {
        $('body').addClass('italy');
        if ($(".paycards").length > 0) {
            $(".paycards").find('.col-md-3').removeClass('col-md-3').addClass('col-md-4');
        }
    } else
    if (fetchedCountryCookie == "GB" || fetchedCountryCookie == "TR") {
        if ($(".icons_panel").length > 0) {
            $(".icons_panel").find('.col-md-2').removeClass('col-md-2').addClass('col-md-4');
        }
    }
    if (fetchedCountryCookie == "TR") {
		$('body').addClass('turkey');
    }
});

function maxLengthCheck(object) {
    if (object.value.length > object.max.length)
        object.value = object.value.slice(0, object.max.length)
}

function isNumeric(evt) {
    var theEvent = evt || window.event;
    var key = theEvent.keyCode || theEvent.which;
    key = String.fromCharCode(key);
    var regex = /[0-9]|\./;
    if (!regex.test(key)) {
        theEvent.returnValue = false;
        if (theEvent.preventDefault) theEvent.preventDefault();
    }
}


$(function() {
    $("#btnProductShare, #btnVideoshareTut").click(function() {
        var currValue = $(this).attr('aria-expanded');
        if (currValue == 'true') {
            currValue = 'false';
        } else {
            currValue = 'true';
        }
        $(this).attr('aria-expanded', currValue);
    });

});

$(window).resize(function() {
    if ($(window).width() < 768) {
        $('.sticky_header').addClass('hidden');
        $('#accountLoggedInBar').hide();
        if ($(".account-overview, .Checkoutpage, .loginpage, .Registration").length) {
            $("#myModal-2,#myModal-1").on("show.bs.modal", function() {
                $('body').addClass("scrollFix");
            });
            $("#myModal-2, #myModal-1").on("hide.bs.modal", function() {
                $('body').removeClass("scrollFix");
            });
        }
    } else {
        if (readCookie('username') != null && readCookie('username') != '' && loggedInCustomer) {
            $('#accountLoggedInBar').show();
        }
    }
    eqHeight();
    hideTutorialsVideo();
    if ($('.heropanel .carousel-control').length > 0) {
        alignHeroCarouselArrows();
    }

    //To align datepicker on resize
    var datePicker = $("#customDatePicker");
    if ($(datePicker).datepicker("widget").is(":visible")) {
        $(datePicker).datepicker('hide').datepicker('show');
    }

    if ($(".nav-links").length > 0 || $('.sub-footer').find('.apply-sensor').length > 0)
        alignNavigationBanner();

    if ($(window).width() <= 1024 && $(window).width() >= 768) {
        if ($(".account-overview, .Checkoutpage, .loginpage, .Registration").length) {
            $("#myModal-2, #myModal-1").on("show.bs.modal", function() {
                $('body').addClass("scrollFix");
            });
            $("#myModal-2, #myModal-1").on("hide.bs.modal", function() {
                $('body').removeClass("scrollFix");
            });
        }
    }
});

$('#customAclForm_submit').click(function(event) {
    var count = $(this).data('count');
    var customAclFormData = {
        aclData: []
    };
    for (var i = 1; i <= count; i++) {
        customAclFormData.aclData.push({
            "resPath": $("#respath_" + i).val(),
            "groupName": $("#groupname_select_" + i).val(),
            "permission": $("#permission_select_" + i).val()
        });

    }
    var jsonData = JSON.stringify(customAclFormData);

    $.ajax({
        url: ".fslwebshop.accessControl.json",
        type: "POST",
        data: "jsondata=" + jsonData,
        datatype: 'json',
        success: $.proxy(function(data) {

        }, this),
        error: $.proxy(function(data) {

        }, this)
    });
});

$(document).ready(function(){	
		var pathname = window.location.pathname;
  		var url      = window.location.href; 
		result = url.split('?');
		if( result[result.length-1]=="mode=postmigrate"){
			$("#myModaltest").modal('show');
		}
	});
