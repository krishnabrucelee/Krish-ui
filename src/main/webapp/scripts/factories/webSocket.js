function webSocket($rootScope, $timeout, webSockets, globalConfig, notify) {
    var webSocket = {};

    $rootScope.messages = '';
    $rootScope.initiateConnection = 0;

    var headers = {};

    var initStompClient = function() {
        webSockets.init(globalConfig.SOCKET_URL + 'socket/ws', null);
        headers['x-auth-token'] = globalConfig.sessionValues.token;
        $rootScope.initiateConnection++;
        webSockets
                .connect(function(frame) {
                    $rootScope.initiateConnection = 0;
                    eventSubscribe();
                }, function(error) {
                    if ($rootScope.initiateConnection < 5) {
                        $timeout(function() {
                            initStompClient();
                        }, 5000);
                    } else {
                        alert("The websocket server could be temporarily unavailable or too busy. Try again in a few moments.");
                        window.location.href = "login";
                    }
                });
    };
    var eventSubscribe = function() {
        webSockets.subscribe("/topic/action.event/" + globalConfig.sessionValues.id, function(message) {
            if (JSON.parse(message.body).resourceUuid !== null) {
                notify({
                    message : JSON.parse(message.body).message,
                    classes : 'alert-success',
                    templateUrl : globalConfig.NOTIFICATION_TEMPLATE
                });
            }
        });
        webSockets.subscribe("/topic/async.event/VM/" + globalConfig.sessionValues.id, function(message) {
            $rootScope.$broadcast(JSON.parse(message.body).event, JSON.parse(message.body));
        });
        webSockets.subscribe("/topic/async.event/VPC/" + globalConfig.sessionValues.id, function(message) {
            $rootScope.$broadcast(JSON.parse(message.body).event, JSON.parse(message.body));
        });
        webSockets.subscribe("/topic/async.event/NIC/" + globalConfig.sessionValues.id, function(message) {
            $rootScope.$broadcast(JSON.parse(message.body).event, JSON.parse(message.body));
        });
        webSockets.subscribe("/topic/async.event/NET/" + globalConfig.sessionValues.id, function(message) {
            $rootScope.$broadcast(JSON.parse(message.body).event, JSON.parse(message.body));
        });
        webSockets.subscribe("/topic/async.event/ISO/" + globalConfig.sessionValues.id, function(message) {
            $rootScope.$broadcast(JSON.parse(message.body).event, JSON.parse(message.body));
        });
        webSockets.subscribe("/topic/async.event/VMSNAPSHOT/" + globalConfig.sessionValues.id, function(message) {
            $rootScope.$broadcast(JSON.parse(message.body).event, JSON.parse(message.body));
        });
        webSockets.subscribe("/topic/async.event/VOLUME/" + globalConfig.sessionValues.id, function(message) {
            $rootScope.$broadcast(JSON.parse(message.body).event, JSON.parse(message.body));
        });
        webSockets.subscribe("/topic/async.event/SNAPSHOT/" + globalConfig.sessionValues.id, function(message) {
            $rootScope.$broadcast(JSON.parse(message.body).event, JSON.parse(message.body));
        });
        webSockets.subscribe("/topic/async.event/SNAPSHOTPOLICY/" + globalConfig.sessionValues.id, function(message) {
            $rootScope.$broadcast(JSON.parse(message.body).event, JSON.parse(message.body));
        });
        webSockets.subscribe("/topic/async.event/FIREWALL/" + globalConfig.sessionValues.id, function(message) {
            $rootScope.$broadcast(JSON.parse(message.body).event, JSON.parse(message.body));
        });
        webSockets.subscribe("/topic/async.event/NETWORK/" + globalConfig.sessionValues.id, function(message) {
            $rootScope.$broadcast(JSON.parse(message.body).event, JSON.parse(message.body));
        });
        webSockets.subscribe("/topic/async.event/LB/" + globalConfig.sessionValues.id, function(message) {
            $rootScope.$broadcast(JSON.parse(message.body).event, JSON.parse(message.body));
        });
        webSockets.subscribe("/topic/async.event/VPN/" + globalConfig.sessionValues.id, function(message) {
            $rootScope.$broadcast(JSON.parse(message.body).event, JSON.parse(message.body));
        });
        webSockets.subscribe("/topic/async.event/STATICNAT/" + globalConfig.sessionValues.id, function(message) {
            $rootScope.$broadcast(JSON.parse(message.body).event, JSON.parse(message.body));
        });
        webSockets.subscribe("/topic/async.event/REGISTER/" + globalConfig.sessionValues.id, function(message) {
            $rootScope.$broadcast(JSON.parse(message.body).event, JSON.parse(message.body));
        });
        webSockets.subscribe("/topic/async.event/PROJECT/" + globalConfig.sessionValues.id, function(message) {
            $rootScope.$broadcast(JSON.parse(message.body).event, JSON.parse(message.body));
        });
        webSockets.subscribe("/topic/async.event/USER/" + globalConfig.sessionValues.id, function(message) {
            $rootScope.$broadcast(JSON.parse(message.body).event, JSON.parse(message.body));
        });
        webSockets.subscribe("/topic/async.event/USER/" + globalConfig.sessionValues.id, function(message) {
            $rootScope.$broadcast(JSON.parse(message.body).event, JSON.parse(message.body));
        });
        webSockets.subscribe("/topic/async.event/ACCOUNT/" + globalConfig.sessionValues.id, function(message) {
            $rootScope.$broadcast(JSON.parse(message.body).event, JSON.parse(message.body));
        });
        webSockets.subscribe("/topic/async.event/DOMAIN/" + globalConfig.sessionValues.id, function(message) {
            $rootScope.$broadcast(JSON.parse(message.body).event, JSON.parse(message.body));
        });
        webSockets.subscribe("/topic/async.event/SERVICE/" + globalConfig.sessionValues.id, function(message) {
            $rootScope.$broadcast(JSON.parse(message.body).event, JSON.parse(message.body));
        });
        webSockets.subscribe("/topic/async.event/DISK/" + globalConfig.sessionValues.id, function(message) {
            $rootScope.$broadcast(JSON.parse(message.body).event, JSON.parse(message.body));
        });
        webSockets.subscribe("/topic/async.event/TEMPLATE/" + globalConfig.sessionValues.id, function(message) {
            $rootScope.$broadcast(JSON.parse(message.body).event, JSON.parse(message.body));
        });
        webSockets.subscribe("/topic/error.event/" + globalConfig.sessionValues.id, function(message) {
            notify({
                message : JSON.parse(message.body).message,
                classes : 'alert-danger',
                templateUrl : globalConfig.NOTIFICATION_TEMPLATE
            });
            $rootScope.$broadcast(JSON.parse(message.body).event, JSON.parse(message.body));
        });
        webSockets.subscribe("/topic/resource.event/Volume", function(message) {
            $rootScope.$broadcast(JSON.parse(message.body).event, JSON.parse(message.body));
        });
        webSockets.subscribe("/topic/resource.event/VirtualMachine", function(message) {
            $rootScope.$broadcast(JSON.parse(message.body).event, JSON.parse(message.body));
        });
        webSockets.subscribe("/topic/resource.event/Network", function(message) {
            $rootScope.$broadcast(JSON.parse(message.body).event, JSON.parse(message.body));
        });
    }
    initStompClient();
    return webSocket;
};

/**
 * Pass function into Root Scope
 */
angular.module('homer').factory('webSocket', webSocket);
