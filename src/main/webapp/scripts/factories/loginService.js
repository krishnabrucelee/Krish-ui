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
	         	var lastAccessTime = globalConfig.sessionValues.loginTime + 14400;
	         	var updateSessionTime = globalConfig.sessionValues.loginTime + 30;

	         	if (lastAccessTime <= currentTimeStamp) {
	         		$window.sessionStorage.removeItem("pandaUserSession");
	         		window.location.href = "login";
	         	} else if (updateSessionTime <= currentTimeStamp) {
	         		var currentSession = JSON.parse($window.sessionStorage.getItem("pandaUserSession"));
	             	currentSession.loginTime = currentTimeStamp;
	             	$window.sessionStorage.setItem("pandaUserSession", JSON.stringify(currentSession));
	             	globalConfig.sessionValues = JSON.parse($window.sessionStorage.getItem("pandaUserSession"));
	             	return config;
	         	}

	         	return config;
	       }
	    }
    }
}

angular.module('homer').factory('loginSession', loginSession);
