/**
 * http://usejsdoc.org/
 */
function interceptorAPI($q, globalConfig, $injector) {
    var global = globalConfig;
    var promiseInterceptor = {
        request : function(config) {
            config.requestTimestamp = new Date().getTime();
            config.sessionToken = config.headers['x-auth-token'];
            var loginService = $injector.get('loginSession');
            loginService.authLogin(config);
            return config;
        },
        response : function(response) {
            response.config.responseTimestamp = new Date().getTime();
            return response;
        },
        responseError : function(response) {
            if ((response.status === 500 || response.status === 0) && response.config.headers.Accept === 'text/html') {
        		alert("The server could be temporarily unavailable or too busy. Try again in a few moments.");
                window.location.href = "login";
        	} else if (response.data != null && response.status !== 401) {
                if (!angular.isUndefined(response.data.globalError) && response.data.globalError[0] != null) {
                    var msg = response.data.globalError[0];
                    if (msg.indexOf("in progress")>-1) {
                       var appService = $injector.get('appService');
	                    appService.notify({
	                        message : msg,
	                        classes : 'alert-info',
	                        templateUrl : global.NOTIFICATION_TEMPLATE
	                    });
                    } else {     
                    var errorList = msg.split(global.TOKEN_SEPARATOR);
                    if(errorList[0] != global.PAGE_ERROR_SEPARATOR) {
	                    var appService = $injector.get('appService');
	                    appService.notify({
	                        message : msg,
	                        classes : 'alert-danger',
	                        templateUrl : global.NOTIFICATION_TEMPLATE
	                    });
                    }
                 }
                }
            } else if (response.data != null && response.status === 401) {
                if (!angular.isUndefined(response.data.message) && response.data.message != null) {
                    var msg = response.data.message;
                    var appService = $injector.get('appService');
                    appService.notify({
                        message : msg,
                        classes : 'alert-danger',
                        templateUrl : global.NOTIFICATION_TEMPLATE
                    });
                    setTimeout(function() {
                        window.location.href = "login";
                    }, 3000);
                }
            }
            // otherwise
            return $q.reject(response);
        }
    };
    return promiseInterceptor;
};

angular.module('homer').factory('interceptorAPI', interceptorAPI).config([ '$httpProvider', function($httpProvider) {
    $httpProvider.interceptors.push('interceptorAPI');
} ]);
