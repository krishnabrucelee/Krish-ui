'use strict';

/* Websocket Services */

angular.module('homer').factory('webSockets', [ '$rootScope', 'globalConfig', function($rootScope, globalConfig) {
    var stompClient;
    var headers = {};
    var wrappedSocket = {

    	init : function(url, instanceUuid) {
    	       stompClient = Stomp.over(new SockJS(url));
    	       headers['x-auth-token'] = globalConfig.sessionValues.token;
    	       headers['x-auth-login-token'] = globalConfig.sessionValues.loginToken;
    	       headers['x-auth-user-id'] = globalConfig.sessionValues.id;
    	        if (instanceUuid != null) {
    	                headers['x-uuid'] = instanceUuid;
    		    }
    	            //stompClient.debug = null;
    	},
        connect : function(successCallback, errorCallback) {
            stompClient.connect(headers, function(frame) {
                $rootScope.$apply(function() {
                    successCallback(frame);
                });
            }, function(error) {
                $rootScope.$apply(function() {
                    errorCallback(error);
                });
            });
        },
        subscribe : function(destination, callback) {
            stompClient.subscribe(destination, function(message) {
                $rootScope.$apply(function() {
                    callback(message);
                });
            });
        },
        send : function(destination, headers, object) {
            stompClient.send(destination, headers, object);
        },
        disconnect : function(url) {
            stompClient.disconnect(headers);
        }
    }

    return wrappedSocket;

} ]);
