(function() {

    var sessTime = new Date();
    var sessionTimeoutMinutes = $('#timeOutVal').val();
    sessTime.setTime(sessTime.getTime() + (sessionTimeoutMinutes * 60 * 1000));
    var errorPageURL = $('#errorpage-url').val();
    var ajaxRetryAttempt = $('#ajaxRetryAttemptVal').val();
    var appGateway = function() {
        this.init();
    }

    appGateway.prototype.init = function() {
        var self = this;
    }

    appGateway.prototype.ajaxSetLocale = function(url, pagepath, successCallback, errorCallback) {
        if (url != null) {
            $.ajax({
                type: "GET",
                data: "callingPage=" + pagepath,
                contentType: "application/json;charset=utf-8",
                url: url,
                dataType: 'json',
                xhrFields: {
                    withCredentials: true
                },
                cache: false,
                async: true,
                timeout: 100000,
                success: successCallback,
                error: errorCallback
            });
        }
    }

    appGateway.prototype.ajaxGet = function(url, successCallback, errorCallback) {
        appGateway.prototype.ajaxGetaSync(url, successCallback, errorCallback, true);
    }

    appGateway.prototype.ajaxGetaSync = function(url, successCallback, errorCallback, async) {
        if (url != null) {
           // alert("ajaxGetaSync call");
            $.ajax({
                type: "GET",
                contentType: "application/json;charset=utf-8",
                url: url,
                dataType: 'json',
                xhrFields: {
                    withCredentials: true
                },
                beforeSend: function(xhr) {
                    var appCookieVal = readCookie("apptoken");
                    setRequestHeaders(xhr, appCookieVal);
                },
                tryCount: 0,
                retryLimit: ajaxRetryAttempt,
                cache: false,
                async: async,
                timeout: 100000,
                success: successCallback,
                error: function(xhr, textStatus, errorThrown) {
                    if (xhr.status == 404 || xhr.status == 500) {
                        //app.analytics.pushError(xhr.status, 'Unable to complete GET::' + xhr.responseText + '::' + textStatus + '::' + errorThrown + '::' + url, location.href, document.referrer);
                        //errorCallback(xhr);
                        return;
                    }
                    if (textStatus != null && (textStatus.toLowerCase() == 'timeout' || textStatus.toLowerCase() == 'error')) {
                        this.tryCount++;
                        if (this.tryCount <= this.retryLimit) {
                            this.beforeSend = function(x) {
                                var appCookieVal = readCookie("apptoken");
                                setRequestHeaders(x, appCookieVal);
                            };
                            //app.analytics.pushError(xhr.status, 'Retrying attempt GET::' + this.tryCount + '::' + url, location.href, document.referrer);
                            //try again
                            $.ajax(this);
                            return;
                        } else {
                            //app.analytics.pushError(xhr.status, 'Max retry reached GET::' + xhr.responseText + '::' + textStatus + '::' + errorThrown + '::' + this.tryCount + '::' + url, location.href, document.referrer);
                            errorCallback(xhr);
                        }
                    } else {
                        //log general errors
                        //app.analytics.pushError(xhr.status, 'Error with GET::' + xhr.responseText + '::' + textStatus + '::' + errorThrown + '::' + url, location.href, document.referrer);
                        errorCallback(xhr);
                    }
                },
                complete: function(xhr, status) {
                    //console.log(status);
                    setResponseHeaders(xhr, status);
                }
            });
            //alert("in get call alert" +status);
        }
    }

    appGateway.prototype.ajaxPost = function(url, postData, successCallback, errorCallback) {
       // alert("url "+url);
       // alert("postData "+JSON.stringify(postData));
        if (url != null) {
            //preValidateAppToken();
            var appCookieVal = readCookie("apptoken");
            if (appCookieVal != "null" && appCookieVal != null && appCookieVal != undefined && appCookieVal != '') {
                $.ajax({
                    type: "POST",
                    contentType: "application/json;charset=utf-8",
                    url: url,
                    data: JSON.stringify(postData),
                    dataType: 'json',
                    xhrFields: {
                        withCredentials: true
                    },
                    tryCount: 0,
                    retryLimit: ajaxRetryAttempt,
                    beforeSend: function(xhr) {
                        setRequestHeaders(xhr, appCookieVal);
                    },
                    cache: false,
                    async: true,
                    timeout: 100000,
                    success: successCallback,
                    error: function(xhr, textStatus, errorThrown) {
                        //alert("in error");
                        if (xhr.status == 404 || xhr.status == 500) {
                            //app.analytics.pushError(xhr.status, 'Unable to complete POST due to 404/500 errors::' + xhr.responseText + '::' + textStatus + '::' + errorThrown + '::' + url, location.href, document.referrer);
                            errorCallback(xhr);
                            return;
                        }
                        if ((textStatus != null && (textStatus.toLowerCase() == 'timeout' || textStatus.toLowerCase() == 'error')) || (xhr.status == 403)) {
                            this.tryCount++;
                            if (this.tryCount <= this.retryLimit) {
                                // get next available token after POST
                               // getAppToken();
                                var newTokenVal = readCookie("apptoken");
                                // check for the validity of the new token. The new token should not be same as old token. If not retry the POST request
                                if ((newTokenVal == "null" || newTokenVal == null || newTokenVal == undefined || newTokenVal == '') || (appCookieVal == newTokenVal)) {
                                    this.beforeSend = function(x) {
                                        // New App Token is  null/different from previous token. Request was not processed successfully.
                                        // setting the old APPTOKEN in the request for RETRY
                                        setRequestHeaders(x, appCookieVal);
                                    };
                                    //app.analytics.pushError(xhr.status, 'Retrying attempt POST::' + this.tryCount + '::' + url, location.href, document.referrer);
                                    //try again
                                    $.ajax(this);
                                    return;
                                } else {
                                    //app.analytics.pushError(xhr.status, 'POST successful at the server, but failed at the client::' + xhr.responseText + '::' + textStatus + '::' + errorThrown + '::' + this.tryCount + '::' + url, location.href, document.referrer);
                                    errorCallback(xhr);
                                }
                            } else {
                                //app.analytics.pushError(xhr.status, 'Max retry reached POST::' + xhr.responseText + '::' + textStatus + '::' + errorThrown + '::' + this.tryCount + '::' + url, location.href, document.referrer);
                                errorCallback(xhr);
                            }
                        } else {
                            //log general errors
                            //app.analytics.pushError(xhr.status, 'Error during POST::' + xhr.responseText + '::' + textStatus + '::' + errorThrown + '::' + url, location.href, document.referrer);
                            errorCallback(xhr);
                        }
                    },
                    complete: function(xhr, status) {
                        //console.log("post data "+status);
                        setResponseHeaders(xhr, status);
                    }
                });
            } else {
                //app.analytics.pushError('500', 'Apptoken is null. Unable to process POST' + url, location.href, document.referrer);
                // redirect to error page
                window.location.replace(errorPageURL);
            }
        }
    }

    appGateway.prototype.ajaxDelete = function(url, successCallback, errorCallback) {
        if (url != null) {
            //preValidateAppToken();
            var appCookieVal = readCookie("apptoken");
            if (appCookieVal != "null" && appCookieVal != null && appCookieVal != undefined && appCookieVal != '') {
                $.ajax({
                    type: "DELETE",
                    contentType: "application/json;charset=utf-8",
                    url: url,
                    dataType: 'json',
                    xhrFields: {
                        withCredentials: true
                    },
                    tryCount: 0,
                    retryLimit: ajaxRetryAttempt,
                    beforeSend: function(xhr) {
                        setRequestHeaders(xhr, appCookieVal);
                    },
                    cache: false,
                    async: true,
                    timeout: 100000,
                    success: successCallback,
                    error: function(xhr, textStatus, errorThrown) {
                        if (xhr.status == 404 || xhr.status == 500) {
                            //app.analytics.pushError(xhr.status, 'Unable to complete DELETE::' + xhr.responseText + '::' + textStatus + '::' + errorThrown + '::' + url, location.href, document.referrer);
                            errorCallback(xhr);
                            return;
                        }
                        if ((textStatus != null && (textStatus.toLowerCase() == 'timeout' || textStatus.toLowerCase() == 'error')) || (xhr.status == 403)) {
                            this.tryCount++;
                            if (this.tryCount <= this.retryLimit) {
                                // get next available token
                               // getAppToken();
                                var newTokenVal = readCookie("apptoken");
                                // check for the validity of the new token. The new token should not be same as old token. If not retry the DELETE request
                                if ((newTokenVal == "null" || newTokenVal == null || newTokenVal == undefined || newTokenVal == '') || (appCookieVal == newTokenVal)) {
                                    this.beforeSend = function(x) {
                                        // New App Token is  null. Request was not processed successfully.
                                        // setting the old APPTOKEN in the request for RETRY
                                        setRequestHeaders(x, appCookieVal);
                                    };
                                    //app.analytics.pushError(xhr.status, 'Retrying attempt DELETE:' + this.tryCount + '::' + url, location.href, document.referrer);
                                    //try again
                                    $.ajax(this);
                                    return;
                                } else {
                                    //app.analytics.pushError(xhr.status, 'DELETE successful at the server, but failed at the client::' + xhr.responseText + '::' + textStatus + '::' + errorThrown + '::' + this.tryCount + '::' + url, location.href, document.referrer);
                                    errorCallback(xhr);
                                }
                            } else {
                                //app.analytics.pushError(xhr.status, 'Max retry reached DELETE::' + xhr.responseText + '::' + textStatus + '::' + errorThrown + '::' + this.tryCount + '::' + url, location.href, document.referrer);
                                errorCallback(xhr);
                            }
                        } else {
                            //log general errors
                            //app.analytics.pushError(xhr.status, 'Error during DELETE::' + xhr.responseText + '::' + textStatus + '::' + errorThrown + '::' + url, location.href, document.referrer);
                            errorCallback(xhr);
                        }
                    },
                    complete: function(xhr, status) {
                        setResponseHeaders(xhr, status);
                    }
                });
            } else {
                //app.analytics.pushError('500', 'Apptoken is null. Unable to process DELETE' + url, location.href, document.referrer);
                // redirect to error page
                window.location.replace(errorPageURL);
            }
        }
    }

    appGateway.prototype.ajaxPut = function(url, postData, successCallback, errorCallback, event) {
        if (url != null) {
            //check for valid apptoken; if token is blank, then attempt to get a new token from appserver
            var eventValue = this.event;
            //preValidateAppToken();
            var appCookieVal = readCookie("apptoken");
            if (appCookieVal != "null" && appCookieVal != null && appCookieVal != undefined && appCookieVal != '') {
                $.ajax({
                    type: "PUT",
                    contentType: "application/json;charset=utf-8",
                    url: url,
                    dataType: 'json',
                    xhrFields: {
                        withCredentials: true
                    },
                    data: JSON.stringify(postData),
                    beforeSend: function(xhr) {
                        setRequestHeaders(xhr, appCookieVal);
                    },
                    tryCount: 0,
                    retryLimit: ajaxRetryAttempt,
                    cache: false,
                    async: true,
                    timeout: 100000,
                    success: successCallback,
                    error: function(xhr, textStatus, errorThrown) {
                        if (xhr.status == 404 || xhr.status == 500) {
                            app.analytics.pushError(xhr.status, 'Unable to complete PUT::' + xhr.responseText + '::' + textStatus + '::' + errorThrown + '::' + url, location.href, document.referrer);
                            errorCallback(xhr);
                            return;
                        }
                        if ((textStatus != null && (textStatus.toLowerCase() == 'timeout' || textStatus.toLowerCase() == 'error')) || (xhr.status == 403)) {
                            this.tryCount++;
                            if (this.tryCount <= this.retryLimit) {
                                // get next available token after PUT
                                //getAppToken();
                                var newTokenVal = readCookie("apptoken");
                                // check for the validity of the new token. The new token should not be same as old token. If not retry the PUT request
                                if ((newTokenVal == "null" || newTokenVal == null || newTokenVal == undefined || newTokenVal == '') || (appCookieVal == newTokenVal)) {
                                    this.beforeSend = function(x) {
                                        // New App Token is  null. Request was not processed successfully.
                                        // setting the old APPTOKEN in the request for RETRY
                                        setRequestHeaders(x, appCookieVal);
                                    };
                                    app.analytics.pushError(xhr.status, 'Retrying attempt PUT:' + this.tryCount + '::' + url, location.href, document.referrer);
                                    //try again
                                    $.ajax(this);
                                    return;
                                } else {
                                    //app.analytics.pushError(xhr.status, 'PUT successful at the server, but failed at the client::' + xhr.responseText + '::' + textStatus + '::' + errorThrown + '::' + this.tryCount + '::' + url, location.href, document.referrer);
                                    errorCallback(xhr);
                                }
                            } else {
                                //app.analytics.pushError(xhr.status, 'Max retry reached PUT::' + xhr.responseText + '::' + textStatus + '::' + errorThrown + '::' + this.tryCount + '::' + url, location.href, document.referrer);
                                errorCallback(xhr);
                            }
                        } else {
                            //log general errors
                            //app.analytics.pushError(xhr.status, 'Error during PUT::' + xhr.responseText + '::' + textStatus + '::' + errorThrown + '::' + url, location.href, document.referrer);
                            errorCallback(xhr);
                        }
                    },
                    complete: function(xhr, status) {
                        setResponseHeaders(xhr, status);
                    }
                });
            } else {
                //app.analytics.pushError('500', 'Apptoken is null. Unable to process PUT' + url, location.href, document.referrer);
                // redirect to error page
                window.location.replace(errorPageURL);
            }
        }
    }

    appGateway.prototype.ajaxCallCheckout = function(httpType, url, postData, successCallback, errorCallback, currentButton) {
        if (url != null) {
            //preValidateAppToken();
            var appCookieVal = readCookie("apptoken");
            if (appCookieVal != "null" && appCookieVal != null && appCookieVal != undefined && appCookieVal != '') {
                $.ajax({
                    type: httpType,
                    contentType: "application/json;charset=utf-8",
                    url: url,
                    dataType: 'json',
                    xhrFields: {
                        withCredentials: true
                    },
                    data: JSON.stringify(postData),
                    beforeSend: function(xhr) {
                        setRequestHeaders(xhr, appCookieVal);
                    },
                    tryCount: 0,
                    retryLimit: ajaxRetryAttempt,
                    cache: false,
                    async: true,
                    timeout: 100000,
                    success: function(data) {
                        //alert("successCallback");
                        successCallback(data, currentButton);
                    },
                    error: function(xhr, textStatus, errorThrown) {
                        if (xhr.status == 404 || xhr.status == 500) {
                            //app.analytics.pushError(xhr.status, 'Unable to complete checkout::' + xhr.responseText + '::' + textStatus + '::' + errorThrown + '::' + url, location.href, document.referrer);
                            errorCallback(xhr);
                            return;
                        }
                        if ((textStatus != null && (textStatus.toLowerCase() == 'timeout' || textStatus.toLowerCase() == 'error')) || (xhr.status == 403)) {
                            this.tryCount++;
                            if (this.tryCount <= this.retryLimit) {
                                // get next available token after POST
                                //getAppToken();
                                var newTokenVal = readCookie("apptoken");
                                // check for the validity of the new token. The new token should not be same as old token. If not retry the POST request
                                if ((newTokenVal == "null" || newTokenVal == null || newTokenVal == undefined || newTokenVal == '') || (appCookieVal == newTokenVal)) {
                                    this.beforeSend = function(x) {
                                        // New App Token is  null. Request was not processed successfully.
                                        // setting the old APPTOKEN in the request for RETRY
                                        setRequestHeaders(x, appCookieVal);
                                    };
                                    //app.analytics.pushError(xhr.status, 'Retrying attempt checkout:' + this.tryCount + '::' + url, location.href, document.referrer);
                                    //try again
                                    $.ajax(this);
                                    return;
                                } else {
                                    //app.analytics.pushError(xhr.status, 'Checkout successful at the server, but failed at the client::' + xhr.responseText + '::' + textStatus + '::' + errorThrown + '::' + this.tryCount + '::' + url, location.href, document.referrer);
                                    errorCallback(xhr);
                                }
                            } else {
                                //app.analytics.pushError(xhr.status, 'Max retry reached Checkout::' + xhr.responseText + '::' + textStatus + '::' + errorThrown + '::' + this.tryCount + '::' + url, location.href, document.referrer);
                                errorCallback(xhr);
                            }
                        } else {
                            //log general errors
                            //app.analytics.pushError(xhr.status, 'Error during Checkout::' + xhr.responseText + '::' + textStatus + '::' + errorThrown + '::' + url, location.href, document.referrer);
                            errorCallback(xhr);
                        }
                    },
                    complete: function(xhr, status) {
                        setResponseHeaders(xhr, status);
                    }
                });
            } else {
                //app.analytics.pushError('500', 'Apptoken is null. Unable to process Checkout method' + url, location.href, document.referrer);
                // redirect to error page
                window.location.replace(errorPageURL);
            }
        }
    }

    function preValidateAppToken() {
        //check for valid apptoken; if token is blank, then attempt to get a new token from appserver
        var appCookieVal = readCookie("apptoken");
        if (appCookieVal == "null" || appCookieVal == null || appCookieVal == undefined || appCookieVal == '') {
           // getAppToken();
        }
    }

    function getAppToken() {
        var tokenUrl = $("#getTokenUrl").attr('value');
        app.appGateway.ajaxGetaSync(tokenUrl, apptokenSuccessCallback, apptokenErrorCallback, false);
    }

    function apptokenSuccessCallback(data) {}

    function apptokenErrorCallback(e) {
        app.analytics.pushError('500', 'Unable to get apptoken from App Server::' + e, location.href, document.referrer);
        // redirect to error page
        window.location.replace(errorPageURL);
    }

    function setRequestHeaders(xhr, appCookieVal) {
        xhr.setRequestHeader("APPTOKEN", appCookieVal);
        var appsessionId = readCookie("adcfslId");
        if (appsessionId != null) {
            xhr.setRequestHeader("adcfslId", appsessionId);
        }
    }

    function setResponseHeaders(xhr, status) {
        if (xhr != null) {
            var tokenVal = xhr.getResponseHeader("APPTOKEN");
            var adcfslId = xhr.getResponseHeader("adcfslId");
            if (tokenVal != null && tokenVal != "null") {
                addCookie('apptoken', tokenVal);
            }
            if (adcfslId != null && adcfslId != "null") {
                addCookie('adcfslId', adcfslId, sessTime);
            }
        }
    }

    app.appGateway = new appGateway();
})();