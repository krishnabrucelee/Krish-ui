function webSocket($rootScope, $timeout, webSockets, globalConfig, notify) {
    var webSocket = {};

    $rootScope.messages = '';

    var headers = {};

    var initStompClient = function() {
        webSockets.init('http://localhost:8080/socket/ws');
        headers['x-auth-token'] = globalConfig.sessionValues.token;
        webSockets.connect(function(frame) {

            webSockets.subscribe("/topic/action.event/", function(message) {
                notify({
                    message : message.body,
                    classes : 'alert-success',
                    templateUrl : globalConfig.NOTIFICATION_TEMPLATE
                });
            });

            webSockets.subscribe("/topic/async.event/", function(message) {
                var parsed = JSON.parse(message.body);
                parsed.priv = true;
                $rootScope.messages.unshift(parsed);
            });

            webSockets.subscribe("/topic/error.event/", function(message) {
                notify({
                    message : message.body,
                    classes : 'alert-danger',
                    templateUrl : globalConfig.NOTIFICATION_TEMPLATE
                });
            });

            webSockets.subscribe("/topic/resource.event/", function(message) {
                var parsed = JSON.parse(message.body);
                parsed.priv = true;
                $rootScope.messages.unshift(parsed);
            });

            webSockets.subscribe("/topic/alert.event/", function(message) {
                notify({
                    message : message.body,
                    classes : 'alert-success',
                    templateUrl : globalConfig.NOTIFICATION_TEMPLATE
                });
            });

        }, function(error) {
            console.log(error);

        });
    };

    //    webSocket.broadcastItem = function(msg,id,userId) {
    //
    //    	$timeout(function(){
    //
    //    		$rootScope.$broadcast(msg,id,userId);
    //    		},
    //
    //    3000);
    //
    //    };

    webSocket.prepForBroadcast = function(msg, id, userId) {
        this.message = msg;
        this.id = id;
        this.userId = userId;
        webSockets.subscribe("/topic/action.event/" + globalConfig.sessionValues.id, function(message) {
            globalConfig.events = parseInt(globalConfig.events) + 1;
            if (message.body.indexOf("completed") > -1 && (message.body.indexOf("ISO") > -1 || message.body
                    .indexOf("secondary ip") > -1 || message.body.indexOf("Snapshot") > -1)) {
                notify({
                    message : message.body,
                    classes : 'alert-success',
                    templateUrl : globalConfig.NOTIFICATION_TEMPLATE
                });
                $rootScope.$broadcast(msg, id, userId);
            }
            if (message.body.indexOf("Error") > -1 && (message.body.indexOf("ISO") > -1 || message.body
                    .indexOf("secondary ip") > -1 || message.body.indexOf("Snapshot"))) {
                notify({
                    message : message.body,
                    classes : 'alert-danger',
                    templateUrl : globalConfig.NOTIFICATION_TEMPLATE
                });
                $rootScope.$broadcast(msg, id, userId);
            }
        });

        webSockets.subscribe("/topic/action.event/" + msg + "/" + userId + "/" + id, function(message) {
            if (message.body.indexOf("Successfully") > -1) {
                notify({
                    message : message.body,
                    classes : 'alert-success',
                    templateUrl : globalConfig.NOTIFICATION_TEMPLATE
                });
                $rootScope.$broadcast(msg, id, userId);
            } else if (message.body.indexOf("Error") > -1) {
                notify({
                    message : message.body,
                    classes : 'alert-danger',
                    templateUrl : globalConfig.NOTIFICATION_TEMPLATE
                });
                $rootScope.$broadcast(msg, id, userId);
            }
        });
        webSockets.subscribe("/topic/async.event/" + msg + "/" + userId + "/" + id, function(message) {
            $rootScope.$broadcast(msg, id, userId);
        });
        webSockets.subscribe("/topic/error.event/" + msg + "/" + userId + "/" + id, function(message) {
            notify({
                message : message.body,
                classes : 'alert-danger',
                templateUrl : globalConfig.NOTIFICATION_TEMPLATE
            });
        });
        webSockets.subscribe("/topic/resource.event/" + id, function(message) {
            $rootScope.$broadcast(msg, id, userId);
        });

    };

    initStompClient();

    return webSocket;
};

/**
 * Pass function into Root Scope
 */
angular.module('homer').factory('webSocket', webSocket);
