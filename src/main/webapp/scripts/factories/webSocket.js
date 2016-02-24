function webSocket($rootScope,$timeout) {
    var webSocket = {};

    webSocket.message = '';

    webSocket.prepForBroadcast = function(msg,id,userId) {
        this.message = msg;
        this.id = id;
        this.userId = userId;
       // this.broadcastItem(msg,id,userId);
    };

//    webSocket.broadcastItem = function(msg,id,userId) {
//
//    	$timeout(function(){
//
//    		$rootScope.$broadcast(msg,id,userId);
//    		},
//
//    1000);
//
//    };

    return webSocket;
};


/**
 * Pass function into Root Scope
 */
angular
    .module('homer')
    .factory('webSocket', webSocket)
