var loginApp = angular.module("homer");


   /**
    * This service is called to remember user's credentials
    *
    */
   loginApp.factory('$remember', function (globalConfig) {
       function fetchValue(name) {
           var gCookieVal = document.cookie.split("; ");
           for (var i = 0; i < gCookieVal.length; i++) {
               var gCrumb = gCookieVal[i].split(":");
               if (name === gCrumb[0]) {
                   var value = '';
                   try {
                       value = angular.fromJson(gCrumb[1]);
                   } catch (e) {
                       value = unescape(gCrumb[1]);
                   }
                   return value;
               }
           }
           // a cookie with the requested name does not exist
           return null;
       }
       return function (name, values) {
           if (arguments.length === 1) return fetchValue(name);
           var cookie = name + ':';
           if (typeof values === 'object') {
               var expires = '';
               cookie += (typeof values.value === 'object') ? angular.toJson(values.value) + ';' : values.value + ';';
               if (values.expires) {
                   var date = new Date();
                   date.setTime(date.getTime() + (values.expires * globalConfig.loginRemeberMeTimeout));
                   expires = date.toGMTString();
               }
               cookie += (!values.session) ? 'expires=' + expires + ';' : '';
               cookie += (values.path) ? 'path=' + values.path + ';' : '';
               cookie += (values.secure) ? 'secure;' : '';
           } else {
               cookie += values + ';';
           }
           document.cookie = cookie;
       }
   });


   loginApp.factory('cookieInfo', function($cookies) {

	    // function that gets json object and stores it inside a cookie
	    this.storeInCookie = function(responseObject) {

	        console.log(responseObject);

	        //set the cookie
	        var cookieObj = {
	            currentUser: {
	                userType: responseObject.auth.userType,
	                username: responseObject.auth.email,
	                token: responseObject.auth.token
	            }
	        };


	        console.log(cookieObj);
	        //set up header, in case we need auth token inside it for later
	        //$http.defaults.headers.common['Authorization'] = 'Basic ' + authdata;
	        //store inside of cookie


	        return $cookies.putObject('globals', cookieObj);

	    };

	    //function to get cookie
	    this.getCookie = function(cookieName) {

	        //get cookie
	        return $cookies.getObject(cookieName);

	    };

	});