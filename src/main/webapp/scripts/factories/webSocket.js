function webSocket($rootScope,$timeout) {
    var webSocket = {};

    webSocket.message = '';

    webSocket.prepForBroadcast = function(msg,id) {
        this.message = msg;
        this.id = id;
        this.broadcastItem(msg,id);
    };

//    webSocket.broadcastItem = function(msg,id) {
//
//    	$timeout(function(){
//
//    		$rootScope.$broadcast(msg);
//    		},
//
//    3000);

  //  };

    return webSocket;
};


/**
 * Pass function into Root Scope
 */
angular
    .module('homer')
    .factory('webSocket', webSocket)
