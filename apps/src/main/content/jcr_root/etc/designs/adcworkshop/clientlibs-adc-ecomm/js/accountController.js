$(document).ready(function() {
    var particularOrderList = "";
    var errorPageURL = $('#errorpage-url').val();
    var unauthorizedURL = $('#unauthorized-url').val();
    var today = new Date();
    var getYear = today.getFullYear() - 4;
    var getMonth = today.getMonth();
    var getDate = today.getDate();
    /*Default constructor*/
    function accountController() {
        this.init();
    };

    accountController.prototype.init = function() {
        var self = this;
        var prevSelected = "accountOverview";
        var defaultAddress = "address-one";

        $(document).on('click', ".viewOrder", function(event) {
            $("#orders").addClass("hidden");
            var id = $(this).attr('id');
            $('.individualorder-loading').show();
            accountController.prototype.orderdetail(id);
            app.analytics.pushEvent('Click', 'MyAccount', 'orders', 'View details');
        });
        $(document).on('click', ".reorderProducts", function(event) {
            $(".reorderProducts").addClass("disabled");
            jsonObj = [];
            $("input[name^='reorder_sku']").each(function(i, anInput) {

                var sku = $(anInput).attr('id');
                var qty = $(anInput).val();
                var bundle = $('#' + sku + '_bundle').val();

                var item = {}
                item["sku"] = sku;
                item["qty"] = qty;
                item["bundle_option"] = bundle;

                jsonObj.push(item);

            });
            accountController.prototype.reordercart(jsonObj);
            app.analytics.pushEvent('Click', 'MyAccount', 'orders', 'Re-Order');
        });

        var isMobileSelectedMenu = false;
        var selectedMenu;
        var mobileOption = true;
        $(".accountMenu").click(function() {
            $('.order-loading').hide();
            $("#singleOrder").addClass("hidden");
            $(".return-success").addClass("hidden");
            $("#return-section").addClass("hidden");
            selectedMenu = this.parentElement.name;
            $("#" + prevSelected).addClass("hidden");
            $("#" + selectedMenu).removeClass("hidden");
            $("a[name=" + prevSelected + "]").children().removeClass('active');
            $("a[name=" + prevSelected + "]").children().eq(1).addClass('hidden');

            $(this).siblings().removeClass("hidden");
            $($(this)).addClass('active');

            prevSelected = selectedMenu;
            self.validateForm();
            $("#pers-success").addClass('hidden');
            $("#pers-failure").addClass('hidden');
            $(".persSaveError").addClass('hidden');
            $("#warrantyAccept").addClass('hidden');
            $("#4035").addClass('hidden');
            $("#serialNOErrorwarrenty").addClass('hidden');

            if ($("#warrantyInvalidMesg").hasClass('error_show')) {
                $("#warrantyInvalidMesg").removeClass('error_show');
                $("#warrantyInvalidMesg").addClass('error');
            }

            if ($("#serialNo").hasClass('invalid')) {
                $("#serialNo").removeClass('invalid');
            }
            mobileOption = false;
            if (selectedMenu == "persDetails") {
                app.analytics.pushEvent('Click', 'MyAccount', 'Personal Details');
            }
            if (selectedMenu == "stdWarrenty") {
                app.analytics.pushEvent('Click', 'MyAccount', 'Standard Warranty');
            }
            if (selectedMenu == "orders") {
                $('.order-loading').show();
                app.analytics.pushEvent('Click', 'MyAccount', 'orders');
            }

            if ($(window).width() >= 992) {
                $("select[name='accountView']").val(selectedMenu).change();
            }
        });


        $(".accountMenuLink").click(function() {
            var selectedMenu = this.name;
            prevSelected = selectedMenu;

            $("#accountOverview").addClass("hidden");
            $("#" + selectedMenu).removeClass("hidden");

            $("a[name='accountOverview']").children().removeClass('active');
            $("a[name='accountOverview']").children().eq(1).addClass('hidden');

            $("a[name=" + selectedMenu + "]").children().addClass('active');
            $("a[name=" + selectedMenu + "]").children().eq(1).removeClass("hidden");

            $("select[name='accountView']").val(selectedMenu).change();
        });

        $("select[name='accountView']").change(function() {
            $("#singleOrder").addClass("hidden");
            $(".return-success").addClass("hidden");
            $("#" + prevSelected).addClass("hidden");
            $("#" + this.value).removeClass("hidden");

            if (this.value == "orders") {
                var monthSelected = $("#orderHistoryDuration :selected").val();
                var order_filter_type = "cashpay";
                orderHistoryList(monthSelected, order_filter_type);
            }


            $("#pers-success").addClass('hidden');
            $("#pers-failure").addClass('hidden');
            $(".persSaveError").addClass('hidden');
            $("#warrantyAccept").addClass('hidden');
            $("#4035").addClass('hidden');
            $("#serialNOErrorwarrenty").addClass('hidden');

            if ($("#warrantyInvalidMesg").hasClass('error_show')) {
                $("#warrantyInvalidMesg").removeClass('error_show');
                $("#warrantyInvalidMesg").addClass('error');
            }

            if ($("#serialNo").hasClass('invalid')) {
                $("#serialNo").removeClass('invalid');
            }

            //onclick of orders in mobile view to fetch order history and current order details
            if (this.value == "persDetails" && mobileOption == true) {
                app.expressCheckout.personalDetails();
                app.analytics.pushEvent('Click', 'MyAccount', 'Personal Details');
            }
            if (this.value == "stdWarrenty" && mobileOption == true) {
                app.analytics.pushEvent('Click', 'MyAccount', 'Standard Warranty');
            }
            if (this.value == "orders" && mobileOption == true) {
                app.analytics.pushEvent('Click', 'MyAccount', 'orders');
            }

            if ($(window).width() <= 991) {
                $("a[name=" + prevSelected + "]").children().removeClass('active');
                $("a[name=" + prevSelected + "]").children().eq(1).addClass('hidden');

                if (this.value == "persDetails") {
                    $($("#persDetails_menu img")).removeClass("hidden");
                    $($("#persDetails_menu span")).addClass('active');
                }
                if (this.value == "stdWarrenty") {

                    $($("#stdWarrenty_menu img")).removeClass("hidden");
                    $($("#stdWarrenty_menu span")).addClass('active');
                }
                if (this.value == "orders") {
                    $($("#orders_menu img")).removeClass("hidden");
                    $($("#orders_menu span")).addClass('active');
                }
                if (this.value == "accountOverview") {
                    $($("#accountOverview_menu img")).removeClass("hidden");
                    $($("#accountOverview_menu span")).addClass('active');
                }

            }
            prevSelected = this.value;
            mobileOption = true;
        });

        $(".address-select").click(function() {
            $("#" + defaultAddress).removeClass("active-address");
            $(this).addClass("active-address");
            defaultAddress = this.id;
        });
		
        $('#customDatePicker').datepicker({
            maxDate: new Date(getYear, getMonth, getDate),
            minDate: new Date(1899, 12, 1),
            yearRange: "-200:+0",
            changeMonth: true,
            changeYear: true,
            onSelect: function(dateText, inst) {
                var date = dateText.split('/');
                $('#tax_day').val(date[1]);
                $('#tax_month').val(date[0]);
                $('#tax_year').val(date[2]);

                $('#tax_day').removeClass("invalid").addClass("valid");
                $('#tax_month').removeClass("invalid").addClass("valid");
                $('#tax_year').removeClass("invalid").addClass("valid");

                $('#customDatePicker').closest('.form-group').find('span[class*=_error]').removeClass("error_show").addClass("error");
            }
        });

        $("#passwordSection").hide();
        $("#changePasswordCheck").on('change', function() {
            var checked = $(this).is(':checked');
            var passShow = $("#passwordSection");
            if (checked) {
                $(passShow).show();
                $("#passwordSection :input").attr('type', 'password');
            } else {
                $(passShow).hide();
                $("#passwordSection :input").attr('type', 'hidden');
                $("#pwd,#confirmPassword").val('');
                $("#pwd,#confirmPassword").addClass('valid').removeClass('invalid');
                $('#passwordSection,#confirmPassword').find('span').html('');
            }
        });

        $("#datepickerIcon").on('click', function() {
            $("#customDatePicker").datepicker("show");
        });

        if (getUrlVars() != null && getUrlVars()["idx"] != null) {
            $("#accountOverview").addClass("hidden");
            $("#orders").removeClass("hidden");
            prevSelected = "orders";
            var formattedCurrentDate = "";
            var prevDate = "";
            var order_filter_type = "cashpay";

            var monthSelected = $("#orderHistoryDuration :selected").val();
            orderHistoryList(monthSelected, order_filter_type);

            $("#return-section").addClass("hidden");
            $(".return-success").addClass("hidden");
        }

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

    function reordersuccessCallback(data) {
        if (data) {
            $(".Reorder-loading").hide();
            $(".reorderProducts").removeClass("disabled");
            window.location.assign($('#viewBasketLink').val());
        }
    }

    accountController.prototype.reordercart = function(cartArr) {
        $(".Reorder-loading").show();
        var reorderUrl = $("#reorderServiceUrl").attr('value');
        app.appGateway.ajaxPost(reorderUrl, cartArr, reordersuccessCallback, allOrdererrorCallback);
    }

    var windowWt = $(window).width();
    $(window).resize(function() {

        // iphone - ipad triggers resize on scroll
        if ($(window).width() !== windowWt) {
            windowWt = $(window).width();
            // reset pagination for iPad on orientation change
            allOrdersuccessCallback(globalOderListData);
        }

        if ($(window).width() <= 991) {
            $("#timeFrame").addClass("text-center");
            $("#timeFrame").removeClass("pull-right");
        } else {
            $("#timeFrame").addClass("pull-right");
            $("#timeFrame").removeClass("text-center");
        }
    });

    //order history
    var particularOrderList = "";
    var globalOderListData;

    function allOrdersuccessCallback(data) {
        $('.order-loading').hide();
        $(".Reorder-loading").hide();
        $(".reorderProducts").removeClass("disabled");
        var noOrdersText = $("#noOrdersHistoryText").val();

        var deskTemplate = Handlebars.compile($("#orders-template").html());
        var mobileTemplate = Handlebars.compile($("#orders-template-mobile").html());
        if (data.messages.allErrors == "" || data.messages.error[0].code == 4006) {
            if ((JSON.stringify(data.orders)) != "null") {
                currentOrderDetails(data, deskTemplate, mobileTemplate);
                if (data.orders.list.length > 1) {
                    $('#orderTablePlace').html(deskTemplate(data));
                    $('#orderTablePlaceMobile').html(mobileTemplate(data));
                } else {
                    $('#orderTablePlace').html(noOrdersText);
                    $('#orderTablePlaceMobile').html(noOrdersText);
                    $("#orderHistoryDuration").attr("disabled", "disabled");
                }
                if (data.orders.list.length > 10) {
                    globalOderListData = data;
                    accountController.prototype.pagination();

                    if ($(".orderTablePlaceHolder").hasClass('hidden')) {
                        $(".orderTablePlaceHolder").removeClass("hidden");
                        $(".orderTablePlaceMobileHolder").removeClass("hidden");
                    }
                } else {
                    $(".orderTablePlaceHolder").addClass("hidden");
                    $(".orderTablePlaceMobileHolder").addClass("hidden");
                }
            } else {
                $('#lastOrderTable').html(deskTemplate(""));
                $('#lastOrderTableMobile').html(mobileTemplate(""));
                $('#orderTablePlace').html(deskTemplate(""));
                $('#orderTablePlaceMobile').html(mobileTemplate(""));
                $("#orderHistoryDuration").attr("disabled", "disabled");
            }
        } else {
            var errorCode = data.messages.error[0].code;
            var errorMessage = data.messages.error[0].message;
            app.analytics.pushError('500', 'Error occurred in retrieving all orders:' + errorCode + "::" + errorMessage, location.href, document.referrer);
            window.location.replace(errorPageURL);
        }
    }
    //current order details
    function currentOrderDetails(allOrdersData, ordersDeskTemplate, ordersMobileTemplate) {

        var particularorderUrl = $("#particularOrderServiceUrl").val();
        var currentOrderJsonData = {
            "regionCode": "",
            "currency": "",
            "order_id": "",
            "orders": {
                "list": []
            },
            "ID": "",
            "messages": ""
        };
        if (allOrdersData.hasOwnProperty("regionCode"))
            currentOrderJsonData.regionCode = allOrdersData.regionCode;
        if (allOrdersData.hasOwnProperty("currency"))

            currentOrderJsonData.currency = allOrdersData.currency;
        if (allOrdersData.hasOwnProperty("order_id"))

            currentOrderJsonData.order_id = allOrdersData.order_id;
        if (JSON.stringify(allOrdersData.orders) != "null") {
            if (allOrdersData.orders.hasOwnProperty("list"))

                currentOrderJsonData.orders.list[1] = allOrdersData.orders.list[0];
        }
        if (allOrdersData.hasOwnProperty("ID"))

            currentOrderJsonData.ID = allOrdersData.ID;
        if (allOrdersData.hasOwnProperty("messages"))

            currentOrderJsonData.messages = allOrdersData.messages;
        if ((currentOrderJsonData.orders.hasOwnProperty("list")) && (currentOrderJsonData.orders.list.length > 0)) {
            var currentOrderId = currentOrderJsonData.orders.list[1].increment_id;
            var currentOrderDetailsUrl = particularorderUrl + currentOrderId;
            app.appGateway.ajaxGet(currentOrderDetailsUrl, currentOrderDetailsuccessCallback, allOrdererrorCallback);

            $('#lastOrderTable').html(ordersDeskTemplate(currentOrderJsonData));
            $('#lastOrderTableMobile').html(ordersMobileTemplate(currentOrderJsonData));
        }

    }

    function currentOrderDetailsuccessCallback(currentOrderData) {
        particularOrderList = currentOrderData;
        var subLinksTemplate = Handlebars.compile($("#current-order-subLinks-template").html());
        $('#currentOrderSubLinks').html(subLinksTemplate(currentOrderData));

    }

    function allOrdererrorCallback(e) {
        location.replace(errorPageURL);
    }


    $("#orders_menu").click(function() {
        $("#orders").show();
        $("#return-section").addClass("hidden");
        $(".return-success").addClass("hidden");
    });

    $("#orderHistoryDuration").change(function() {
        var dateRange = "";
        var order_filter_type = "cashpay";
        dateRange = $("#orderHistoryDuration :selected").val();
        orderHistoryList(dateRange, order_filter_type);
        app.analytics.pushEvent('Click', 'MyAccount', 'orders', dateRange);

    });

    function orderHistoryList(dateRange, order_filter_type) {
        var orderssearch = {}
        orderssearch["dateRange"] = dateRange;
        orderssearch["order_filter_type"] = order_filter_type;
        var allOrdersUrl = $('#orderHistoryServiceUrl').val();
        var allOrdersTargetUrl = allOrdersUrl + "/daterange/" + dateRange + "/filter/" + order_filter_type;
        $('.order-loading').show(400, function() {
            app.appGateway.ajaxGet(allOrdersTargetUrl, allOrdersuccessCallback, allOrdererrorCallback);
        });
    }


    //return order
    $(document).on('click', ".return-order", function() {
        $("#orders").hide();

        var return_id = this.id;

        if (return_id == "particularOrderReturn") {
            pdfToBeshown = "#particularOrderReturnPdf";
        } else if (return_id == "return-current-order") {
            pdfToBeshown = "#returnpdf-current-order";
        }

        $("#return-section").removeClass("hidden");
        $("#singleOrder").addClass("hidden");

        var selectedOrderID = $("#orderID").val();
        var returnTemplate = Handlebars.compile($("#return-template").html());
        $('#returnOrderPlace').html(returnTemplate(particularOrderList));

        calculateQtyDropdownValues();
        accountController.prototype.returnValidation();
    });


    $(document).on('change', "input[name=seal]:radio", function() {
        if (this.value == "Yes") {
            $('#myreturnFormSubmitModal').modal('show');
            $("#returnSubmitForm").addClass("hidden");
        } else {
            $("#returnSubmitForm").removeClass("hidden");
            $('#myreturnFormSubmitModal').modal('hide');

        }
    });


    function calculateQtyDropdownValues() {
        var qty = $("#prodReturnName option:selected").val();
        var qtyOption = "";
        for (i = 1; i <= qty; i++) {
            qtyOption += "<option value='" + i + "'>" + i + "</option>";
        }
        $("#prodreturnQty").html(qtyOption);
    }

    $(document).on('change', "#prodReturnName", function() {
        calculateQtyDropdownValues();
    });


    $(document).on('change', "#prodReturnName", function() {
        if ($('#prodReturnName option:selected').val() == "all") {
            $("#prodreturnQty").attr("disabled", true);
        } else {
            $("#prodreturnQty").attr("disabled", false);
        }
    });
	
    $(document).on('click', "#return-submit", function() {

        var parent = $('#return-section');
        var objValidator = app.utils.validator;
        var error_free = objValidator.submitForm($("#returnForm"), parent);

        if (!error_free) {} else {
            var returnUrl = $("#createReturnServiceUrl").val();
            var orderToBeReturned = $("#returnOrderId").val();
            var prodSelForReturn = $("#prodReturnName option:selected").text().replace(/\s/g, '');
            var prodReturnId = "#" + prodSelForReturn;
            var itemIdProdReturn = $(prodReturnId).val();
            var returnQtyRequested = $("#prodreturnQty").val();
            var returnReason = $("#return_reason").val();
            var completeReturnUrl = returnUrl.replace("{1}", orderToBeReturned);
            var orderItems = [];

            if (prodSelForReturn == "All") {
                var bulkProducts = particularOrderList.order.order_items;
                var orderedItemsLength = particularOrderList.order.order_items.length;

                for (var item = 0; item < orderedItemsLength; item++) {
                    var eachitemIdProdReturn = bulkProducts[item].item_id;
                    var eachreturnQtyRequested = bulkProducts[item].qty_ordered;

                    orderItems.push({
                        "order_item_id": eachitemIdProdReturn,
                        "qty_requested": eachreturnQtyRequested,
                        "reason": returnReason
                    });
                }
            } else {
                orderItems.push({
                    "order_item_id": itemIdProdReturn,
                    "qty_requested": returnQtyRequested,
                    "reason": returnReason
                });
            }
            var returnParams = {};
            returnParams["order_id"] = $("#reorderEntityId").val();
            returnParams["items"] = orderItems;
            returnParams["rma_comment"] = $("#return_comments").val();

            app.appGateway.ajaxPost(completeReturnUrl, returnParams, returnOrdersuccessCallback, allOrdererrorCallback);
        }
    });



    function returnOrdersuccessCallback(returnOrderData) {

        var prodContent = mergeProdDetailData();
        $.extend(returnOrderData, prodContent);

        //if return is success
        if (returnOrderData.order != null && returnOrderData.order != undefined) {
            var defURL = $("#returnPdfLink").val();
            var templateSingleOrder = Handlebars.compile($("#single-order-template").html());

            $('#singleTablePlace').html(templateSingleOrder(returnOrderData));
            $(".linkURL").closest("a").attr("href", defURL);

            $("#return-section").addClass("hidden");
            $("#singleOrder").removeClass("hidden");

            $(".return-success").removeClass("hidden");
        } else {
            var templateSingleOrder = Handlebars.compile($("#single-order-template").html());
            var errormsg = returnOrderData.createReturnResponse.messages.error[1].message;
            $(".return-error").html(errormsg);
            $(".return-error").removeClass("hidden");
        }
    }

    function mergeProdDetailData() {
        var voucherText = $("#orderDetail_order").val();
        var totalText = $("#orderDetail_qty").val();

        orderDetailContent = {}
        orderDetailContent["orderText"] = $("#orderDetail_order").val();
        orderDetailContent["qtyText"] = $("#orderDetail_qty").val();
        orderDetailContent["totalText"] = $("#orderDetail_total").val();

        jsonObj = [];

        $("input[name^='sku_images']").each(function(i, anInput) {
            var sku = $(anInput).attr('id');
            var fields = $(anInput).val().split("+");
            var imgPath = fields[0];
            var item = {}
            item["sku"] = sku;
            item["imagePath"] = imgPath;
            jsonObj.push(item);
        });

        orderDetailContent["skuImgPath"] = jsonObj;
        return orderDetailContent;
    }

    //particluar order details
    accountController.prototype.orderdetail = function(orderid) {
        var ordeDetailsUrl = $("#orderDetailUrl").attr('value');
        ordeDetailsUrl = ordeDetailsUrl + orderid;
        app.appGateway.ajaxGet(ordeDetailsUrl, orderDetailsuccessCallback, allOrdererrorCallback);
    }

    function orderDetailsuccessCallback(data) {
        var prodContent = mergeProdDetailData();
        $('.individualorder-loading').hide();
        $("#singleOrder").removeClass("hidden");
        $.extend(data, prodContent);

        particularOrderList = data;

        finalList = JSON.parse(JSON.stringify(data));
        /***************************************/
        Handlebars.registerHelper('if_eq', function(a, b, opts) {
            if (a === b) {
                return true;
            } else {
                return false;
            }
        });
        /****************************************/
        if (data.messages.allErrors == "") {
            var templateSingleOrder = Handlebars.compile($("#single-order-template").html());
            $('#singleTablePlace').html(templateSingleOrder(data));
            $("#return-section").addClass("hidden");
            $("#return-section").addClass("hidden");
            $(".return-success").addClass("hidden");
        } else {
            if (data.messages.error[0].code == 4068) {
                location.replace($('#unauthAccessUrl').val());
            }
        }
    }


    //particular  order shipment track
    /** tracking order details **/

    $(document).on('click', "#trackInfo1", function() {

        var trackurl = $("#ordershipmentTrackServiceUrl").val();
        var orderNum = $(this).attr("name");
        trackurl = trackurl.replace("{1}", orderNum);
        app.appGateway.ajaxGet(trackurl, trackOrdersuccessCallback, trackOrdererrorCallback);
    });

    function trackOrdersuccessCallback(data) {
        orderstatusOverlay(data);
    }


    function trackOrdererrorCallback(e) {
        location.replace(errorPageURL);
    }

    function orderstatusOverlay(data) {
        var shipment_track_info_status = data.shipment_track_info[0].status;
        var timestamp = data.shipment_track_info[0].created_at;
        var dateTime = timestamp.split(" ");
        var date = dateTime[0];
        var time = dateTime[1];
        $("#status").html(shipment_track_info_status);
        $("#date").html(date);
        $("#time").html(time);
        var templateOrderStatus = Handlebars.compile($("#orders-status").html());
        Handlebars.registerHelper('splitDateTime', function(title) {
            var t = title.split(" ");
            return t[0] + " <br/> " + t[1];
        });
        $('#status-table').html(templateOrderStatus(data));
    }

    accountController.prototype.validateForm = function() {
        var self = this;
        var objValidator = app.utils.validator;
        var form = $('#personal-details');
        var $_field = '';
        /*only alphabetic fields*/
        var $_firstName = $(form).find('input[id*=contact_firstName]');
        var $_lastName = $(form).find('input[id*=contact_lastName]');
        var $_email = $(form).find('input[id*=register_email]');
        var $_emailConfirm = $(form).find('input[id*=confirmemail]');

        var alphabeticFields = [$_firstName, $_lastName];
        var $_alphaResult = $();
        $.each(alphabeticFields, function() {
            $_alphaResult = $_alphaResult.add(this);
        });

        $_alphaResult.on('input', function() {
            var input = $(this);
            var isAlphabetic = objValidator.validateAlbhabetic(input);
            objValidator.toggleErrorMsg(input, isAlphabetic, "alpha");

        });

        $($_email).on('input', function() {
            var input = $(this);
            var isValidFormat = objValidator.validateEmail(input);
            objValidator.toggleErrorMsg(input, isValidFormat, "email");

        });

        $($_emailConfirm).on('input', function() {
            var email = $('#register_email');
            var isMatched = objValidator.confirmEmail(email, $(this));
            objValidator.toggleErrorMsg($(this), isMatched, "confirm_email");
        });
    }

    accountController.prototype.pagination = function() {
        $(function() {
            $("div.orderTablePlaceHolder").jPages({
                containerID: "orderTablePlace",
                first: "",
                previous: "",
                next: "",
                last: "",
                perPage: 20,
                delay: 20
            });
            $(".jp-last").html(">>");
            $(".jp-first").html("<<");
            $(".jp-next").html(">");
            $(".jp-previous").html("<");
        });

        $(function() {
            $("div.orderTablePlaceMobileHolder").jPages({
                containerID: "orderTablePlaceMobile",
                first: "",
                previous: "",
                next: "",
                last: "",
                perPage: 20,
                delay: 20
            });
            $(".jp-last").html(">>");
            $(".jp-first").html("<<");
            $(".jp-next").html(">");
            $(".jp-previous").html("<");
        });
    }
    accountController.prototype.returnValidation = function() {
        var objValidator = app.utils.validator;
        var $_reason = $('input[id=return_reason]');

        var alphabeticFields = [$_reason];
        var $_alphaResult = $();
        $.each(alphabeticFields, function() {
            $_alphaResult = $_alphaResult.add(this);
        });

        $_alphaResult.on('input', function() {
            var input = $(this);
            var isAlphabetic = objValidator.validateAlbhaNumerictext(input);
            objValidator.toggleErrorMsg(input, isAlphabetic, "alpha");
        });
    }

    app.accountController = new accountController();
});