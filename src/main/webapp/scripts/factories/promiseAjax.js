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
            "headers": {'x-auth-token': globalConfig.sessionValues.token, 'x-requested-with': '', 'Content-Type': 'application/json', 'Range': "items=0-9"}
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
        }).catch(function (result) {
            throw result;
        });
    };

    var httpRequest = function(method, url, data) {
        return $http({method:method, url:url}).then(function(result){
            return result.data;
        });
    };

    var httpRequestPing = function(method, url, data) {
    	var config = {
                "method": method,
                "data": data,
                "url": url,
                "headers": {'Content-Type': 'application/json', 'Range': "items=0-9"}
            };
        return $http(config).then(function(result){
            return result.data;
        });
    };

    return { httpRequest: httpRequest, httpTokenRequest: httpTokenRequest, httpRequestPing: httpRequestPing };
}

/**
 * Pass function into module
 */
angular
    .module('homer')
    .factory('promiseAjax', promiseAjax)
