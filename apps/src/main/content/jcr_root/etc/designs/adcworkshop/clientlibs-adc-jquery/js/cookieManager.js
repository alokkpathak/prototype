
function addCookie(cookieName,cookieValue, cookieExpires) {
	cookieManager.addCookie( { name: cookieName, value: cookieValue, expires:cookieExpires, path: '/' } );
}

function removeCookie(cookieName,cookieValue) {
	cookieManager.removeCookie( { name: cookieName,value: cookieValue, path: '/' } );
}

function readCookie(cookieName) {
	return cookieManager.getCookie(cookieName);
	//cookieManager.getCookies();
}

function clearCookies() {
	cookieManager.clearCookies();
}

function dumpCookies() {
//	console.log("Raw page cookies: " + document.cookie);
//	alert("look at Chrome debugger application tab");
}

/*
	Although it may be tempting to use sessionStorage, session storage does not perist across browser tabs
		so if a user has multiple browser open; the app may behave unexpectedly.  It is equally tempting to use localStorage in place
		of sessionCookies, but that is also a critically flawed decision.  The reason is that if there is no good way of ensuring that localStorage
		is cleared when the browser is forced to quit or crashes.
		When data is stored in sessionCookie if the browser crashes or forced to delete; the sessionCookie is wiped out.
		You now only have obsolete keys which were only to be used for clearing the cookies on manual logout so there is no critical impact.
*/
cookieManager = {};

// Gets common shared cookie storage name
cookieManager.getStorageName = function() {
	return "appCookies";
}

/*
	Gets the JSON key for a given cookie name/path combination
*/
cookieManager.getStorageCookieKeyName = function(cookieName, cookiePath) {
	return "" + cookieName + "||" + cookiePath;
}

/*
	Adds cookie.  Note a page, can set a cookie path for which it is not a part of.  
	That is /test1/index.html can set cookie for "/tes2", but according to API a cookie will not be visible to a page
	if the cookie path is not a parent of the current page path.
	For example API on /test1/index.html can set a cookie called "mycookie" for path "/test2" which the page is not a part of.
	Unless you have a page on that path to dump the cookie, the only way of observing the created cookie is using chrome://settings/cookies
*/
cookieManager.addCookie = function(cookie) {	
	
	if (!cookie.path || cookie.path == "") {
		cookie.path = "/"; // by default apply cookie from root of site	
	}
	
	// if cookie.expires is not defined, it treats as session cookie per "overloaded" method
	// contrary to the document $.cookie takes cookeName, cookieValue, and options object with properties domain, expires, path, and secure
	Cookies.set(cookie.name, cookie.value, { expires: cookie.expires, path: cookie.path } );	
	
	// get current cookie list from permanent storage
	var cookiesString = window.localStorage.getItem( cookieManager.getStorageName() );
	var cookiesJson = null;
	
	if (cookiesString == null || cookiesString == "" ) {
		cookiesString = "{}";
	}
	// convert string to true json object
	cookiesJson = JSON.parse(cookiesString);
	
	/*
		Cookies are stored as json object with properties based on name and path concatenation, so we can easily have direct access
		without iterating (as would be the case if using simple array)
		there shouldn't be any collisions of name and path that somehow overlapped unintentionally since '||' cannot be part of a URL path
	*/	
	cookiesJson[cookieManager.getStorageCookieKeyName(cookie.name, cookie.path)] = { name: cookie.name, path: cookie.path } ; 
	
	// stick back into storage
	window.localStorage.setItem("appCookies", JSON.stringify(cookiesJson));
//	console.log("Added cookie name: " + cookie.name);
//	console.log("Added cookie value: " + cookie.value);
//	console.log("Added cookie path: " + cookie.path);	
//	console.log("Added cookie expiration: " + cookie.expires);	
	
}

/*
	Gets a single cookie by name.
	Cookie must be visible to the current page path.
*/
cookieManager.getCookie = function(name) {
	var cookieValue = Cookies.get(name);
//	console.log("cookie name [" + name + "] value [" + cookieValue + "]");
	
	return cookieValue;
}

/*
	Gets all the cookies visible to this current page.  Note that there appears to be a bug in Cookies API library.
	If the following cookies exist:
	name=cook1; path=/; value=123
	name=cook1; path=/sessionExample; value=xyz
	if invoking getCookies from /sessionExample/index.html getCookie("cook1") returns xyz; but the below method returns 123; whereas raw
	document.cookie will return both values each paired with a cook1 cookie name (cook1=xyz; cook1=123;).  Seems like API only expects 1 value
	and iterates thus overriding the first set cookie name.
*/
cookieManager.getCookies = function() {
	var cookies = Cookies.get();
	//console.log("All visible cookies: " + JSON.stringify(cookies));
}

/*
	Removes cookie.  Note a page can remove a cookie for any arbitrary path, even if it's not part of the path.
*/
cookieManager.removeCookie = function(cookie) {
	
	if (!cookie.path || cookie.path == "") {
		cookie.path = "/"; // by default apply cookie from root of site	
	}
	
	// get current cookie list from permanent storage
	var cookiesString = window.localStorage.getItem(cookieManager.getStorageName());
	var cookiesJson = null;
	
	if (cookiesString == null || cookiesString == "" ) {
		cookiesString = "{}";
	}
	// convert string to true json object
	cookiesJson = JSON.parse(cookiesString);
	
	// remove cookie and remove key from storage
	Cookies.remove(cookie.name, { path: cookie.path });	
	cookiesJson[cookieManager.getStorageCookieKeyName(cookie.name, cookie.path)] = undefined ; 
	window.localStorage.setItem(cookieManager.getStorageName(), JSON.stringify(cookiesJson));
	
//	console.log("Found cookie & path (" + cookie.name + "; " + cookie.path + ") and removed it.");
	
	
}

cookieManager.clearCookies = function() {
	
	
	var cookiesString = window.localStorage.getItem(cookieManager.getStorageName());
	var cookiesJson = null;
	
	if (cookiesString == null || cookiesString == "" ) {
		// nothing to clear as far as cookie manager is aware
		//  cookies created directly via JS then cookieManager cannot help
		exit;
	}
	
	// convert string to true json object
	cookiesJson = JSON.parse(cookiesString);
		
	for (var key in cookiesJson) {
	  if (cookiesJson.hasOwnProperty(key)) {		
		Cookies.remove(cookiesJson[key].name, { path: cookiesJson[key].path });	
		cookiesJson[cookieManager.getStorageCookieKeyName(cookiesJson[key].name, cookiesJson[key].path)] = undefined ; 
		window.localStorage.setItem("appCookies", JSON.stringify(cookiesJson));
	  }
	}
	
}

// localStorage only contains cookie name and not the actual value so if browser is closed
// without logout there is no immediate exposure of data, but we must consider what will happen
// if user has cookienames in local storage and closes browser without logout
// at this point local storage still exists but the actual cookies do not.
// per API docs invoking the cookie delete will not cause any problems as it returns true/false
// and doesn't throw error if cookie doesn't exist.
// When a cookie is added/set it overrides any matching key in local storage instead of appending a duplicate cookiename.


