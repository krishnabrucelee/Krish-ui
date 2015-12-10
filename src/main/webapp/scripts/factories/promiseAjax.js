/**
 * Panda - Cloud Management Portal
 * Copyright 2015 Assistanz.com
 *
 * Angularjs ajax request with promise.
 * @author - Jamseer N
 */


function promiseAjax($http, $window, globalConfig, notify) {

     var global = globalConfig;
     var httpTokenRequest = function (method, url, headers, data) {

        if(angular.isUndefined(data)) {
            var data = {};
            data.limit = global.CONTENT_LIMIT;
        };
        var loginSession = globalConfig.sessionValues;
        if(loginSession == null) {
        	window.location.href = "login";
        }
        var config = {
            "method": method,
            "data": data,
            "url": url,
            "headers": {'x-auth-token': loginSession.token, 'Content-Type': 'application/json', 'Range': "items=0-9"}
        };


        if(headers != null && !angular.isUndefined(headers) && headers != '') {
            angular.forEach(headers, (function(value, key) {
                config.headers[key] = '';
                config.headers[key] = value;
            }));
        }

        return $http(config).then(function (res) {
            var data = res.data;
            data.loginSession = loginSession;

            // For Pagination
            if(res.headers('Content-Range') && typeof(res.headers('Content-Range')) != 'undefined') {
                var contentRange = res.headers('Content-Range');
                if(!isNaN(contentRange.split("/")[1])) {
                    data.totalItems = contentRange.split("/")[1];

                    var itemsPerPage = contentRange.split("/")[0].split('-')[1];
                    data.itemsPerPage = global.CONTENT_LIMIT;
                }
            }
            return data;
        });
//        .catch(function (result) {
//        	if(result.data.status === 401 && result.data.message === "INVALID_TOKEN") {
//        		notify({
//    				message : "Your session has expired. Please log-in again",
//    				classes : 'alert-danger',
//    				templateUrl : global.NOTIFICATION_TEMPLATE
//    			});
//        		setTimeout(function() {
//        			window.location.href = "login";
//        		}, 2000);
//            }
//        });
    };

    var httpRequest = function(method, url, data) {

        return $http({method:method, url:url}).then(function(result){
            return result.data;
        });
    };
    return { httpRequest: httpRequest, httpTokenRequest: httpTokenRequest };
}


/**
 * Pass function into module
 */
angular
    .module('homer')
    .factory('promiseAjax', promiseAjax)

