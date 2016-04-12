'use strict';

/* Websocket Services */

angular.module('homer').factory('webSockets', [ '$rootScope', 'globalConfig', function($rootScope, globalConfig) {
    var stompClient;
    var headers = {};
    var wrappedSocket = {

        init : function(url) {
            stompClient = Stomp.over(new SockJS(url));
            // stompClient.debug = null;
        },
        connect : function(successCallback, errorCallback) {
            stompClient.connect({}, function(frame) {
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
        }
    }

    return wrappedSocket;

} ]);
