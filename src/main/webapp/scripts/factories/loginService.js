/**
 * Login session checking.
 */
function loginSession(globalConfig, $window, $http, $injector, $moment) {

    return {
	    authLogin: function(config) {
	        if (globalConfig.sessionValues == null) {
	            return config;
	        } else {
	   	        var currentDateTime = moment.unix(Math.floor(Date.now() / 1000)).format('YYYY-MM-DD HH:mm:ss');
	            var currentTimeStamp = moment(moment.tz(currentDateTime, globalConfig.sessionValues.timeZone).format()).unix();
                var currentSession = JSON.parse($window.sessionStorage.getItem("loginSession"));
                if (currentSession != null) {
                	currentSession.loginTime = currentTimeStamp;
                } else {
                	window.location.href = "login";
                }
                $window.sessionStorage.setItem("loginSession", JSON.stringify(currentSession));
                globalConfig.sessionValues = JSON.parse($window.sessionStorage.getItem("loginSession"));
                return config;
	        }
	    }
    }
}

angular.module('homer').factory('loginSession', loginSession);
