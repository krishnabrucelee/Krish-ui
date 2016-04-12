function webSocket($rootScope, $timeout, webSockets, globalConfig, notify) {
    var webSocket = {};

    $rootScope.messages = '';

    var headers = {};

    var initStompClient = function() {
        webSockets.init(globalConfig.SOCKET_URL + 'socket/ws');
        headers['x-auth-token'] = globalConfig.sessionValues.token;
        webSockets.connect(function(frame) {
            console.log(frame);
            webSockets.subscribe("/topic/test", function(message) {
                console.log(message.body);
            });
        }, function(error) {
            console.log(error);
        });
    };

    webSocket.prepForBroadcast = function(msg, id, userId) {
        this.message = msg;
        this.id = id;
        this.userId = userId;
        webSockets.subscribe("/topic/action.event/" + globalConfig.sessionValues.id, function(message) {
            globalConfig.events = parseInt(globalConfig.events) + 1;
            if ((message.body.indexOf("completed") > -1 || message.body.indexOf("Remote Access") > -1) && (message.body
                    .indexOf("ISO") > -1 || message.body.indexOf("secondary ip") > -1 || message.body
                    .indexOf("Snapshot") > -1 || message.body.indexOf("Nic") > -1 || message.body
                    .indexOf("uploading volume") > -1 || message.body.indexOf("VM snapshot") > -1 || message.body
                    .indexOf("vm snapshots") > -1 || message.body.indexOf("deleting snapshot") > -1 || message.body
                    .indexOf("static nat") > -1 || message.body.indexOf("remote access vpn") > -1 || message.body
                    .indexOf("VPN user") > -1 || message.body.indexOf("secondary ip rules") > -1 || message.body
                    .indexOf("revert") > -1)) {
                notify({
                    message : message.body,
                    classes : 'alert-success',
                    templateUrl : globalConfig.NOTIFICATION_TEMPLATE
                });
                $rootScope.$broadcast(msg, 'action.event', 'sucess', id, userId);
            }
            if (message.body.indexOf("Error") > -1 && (message.body.indexOf("ISO") > -1 || message.body
                    .indexOf("secondary ip") > -1 || message.body.indexOf("Nic") > -1 || message.body
                    .indexOf("uploading volume") > -1 || message.body.indexOf("VM snapshot") > -1 || message.body
                    .indexOf("deleting snapshot") > -1 || message.body.indexOf("vm snapshots") > -1 || message.body
                    .indexOf("static nat") > -1 || message.body.indexOf("remote access vpn") > -1 || message.body
                    .indexOf("VPN user") > -1 || message.body.indexOf("secondary ip rules") > -1 || message.body
                    .indexOf("revert") > -1)) {
                notify({
                    message : message.body,
                    classes : 'alert-danger',
                    templateUrl : globalConfig.NOTIFICATION_TEMPLATE
                });
                $rootScope.$broadcast(msg, 'action.event', 'error', id, userId);
            }
        });

        webSockets.subscribe("/topic/action.event/" + msg + "/" + userId + "/" + id, function(message) {
            if (message.body.indexOf("Successfully") > -1) {
                notify({
                    message : message.body,
                    classes : 'alert-success',
                    templateUrl : globalConfig.NOTIFICATION_TEMPLATE
                });
                $rootScope.$broadcast(msg, 'action.event', 'success', id, userId);
            } else if (message.body.indexOf("Error") > -1) {
                notify({
                    message : message.body,
                    classes : 'alert-danger',
                    templateUrl : globalConfig.NOTIFICATION_TEMPLATE
                });
                if (message.body.indexOf("SSHKey") > -1) {

                } else {
                    $rootScope.$broadcast(msg, 'action.event', 'error', id, userId);
                }
            }
        });
        webSockets
                .subscribe("/topic/async.event/" + msg + "/" + userId + "/" + id, function(message) {
                    if (msg.indexOf("FIREWALL.EGRESS") > -1 || msg.indexOf("NET.IP") > -1 || msg
                            .indexOf("FIREWALL.OPEN") > -1 || msg.indexOf("FIREWALL.CLOSE") > -1 || msg
                            .indexOf("NET.RULEADD") > -1 || msg.indexOf("NET.RULEDELETE") > -1 || msg
                            .indexOf("VM.RESETPASSWORD") > -1 || msg.indexOf("NIC.SECONDARY") > -1 || msg
                            .indexOf("VM.RESETSSHKEY") > -1 || msg.indexOf("VM.RESETPASSWORD") > -1 || msg
                            .indexOf("VOLUME.DETACH") > -1 || msg.indexOf("VOLUME.ATTACH") > -1) {

                    } else {
                        $rootScope.$broadcast(msg, 'async.event', 'success', id, userId);
                    }
                });
        webSockets.subscribe("/topic/error.event/" + msg + "/" + userId + "/" + id, function(message) {
            notify({
                message : message.body,
                classes : 'alert-danger',
                templateUrl : globalConfig.NOTIFICATION_TEMPLATE
            });
            if (msg.indexOf("VM.RESETSSHKEY") > -1) {
                $rootScope.$broadcast(msg + "/ERROR", 'resource.event', 'success', id, userId);
            } else {
                $rootScope.$broadcast(msg, 'resource.event', 'success', id, userId);
            }
        });
        webSockets.subscribe("/topic/resource.event/" + id, function(message) {
            $rootScope.$broadcast(msg, 'resource.event', 'success', id, userId);
        });
    };
    initStompClient();
    return webSocket;
};

/**
 * Pass function into Root Scope
 */
angular.module('homer').factory('webSocket', webSocket);
