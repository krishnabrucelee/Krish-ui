/**
 * Login session checking.
 */
function loginSession(globalConfig, $window, $http, $injector, $moment) {

    return {
	    authLogin: function(config) {
	    	return config;
	    }
    }
}

angular.module('homer').factory('loginSession', loginSession);
