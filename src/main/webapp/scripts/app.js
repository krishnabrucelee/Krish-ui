/**
 * HOMER - Responsive Admin Theme
 * Copyright 2015 Webapplayers.com
 *
 */
(function () {
    var myApplication = angular.module('homer', [
        'ui.router',                // Angular flexible routing
        'ngSanitize',               // Angular-sanitize
        'ui.bootstrap',             // AngularJS native directives for Bootstrap
        'angular-flot',             // Flot chart
        'angles',                   // Chart.js
        'angular-peity',            // Peity (small) charts
        'cgNotify',                 // Angular notify
        'ngAnimate',                // Angular animations
        'ui.map',                   // Ui Map for Google maps
        'ui.calendar',              // UI Calendar
        'summernote',               // Summernote plugin
        'ngGrid',                   // Angular ng Grid
        'ui.tree',                  // Angular ui Tree
        'bm.bsTour',                // Angular bootstrap tour
        'datatables',               // Angular datatables plugin
        'xeditable',                // Angular-xeditable
        'ui.select',                // AngularJS ui-select
        'ui.sortable',              // AngularJS ui-sortable
        'LocalStorageModule',       // AngularJs LocalStorage
        'rzModule',                 // RZ
        'angular.filter',		    // Angular filters
        'angular-momentjs',         // AngularJS moment
        'ngCookies'					// Angular cookie

    ]);
    fetchData().then(bootstrapApplication);

    function fetchData() {
        var initInjector = angular.injector(["ng"]);
        var initInjectors = angular.injector(["ngCookies"]);
        var $http = initInjector.get("$http");
        var $cookies = initInjectors.get("$cookies");
        return $http({method:'get', url: 'http://'+ window.location.hostname +':8080/api/'  + 'users/usersessiondetails/'+$cookies.id,
			"headers": {'x-auth-token': $cookies.token, 'x-requested-with': '', 'Content-Type': 'application/json', 'Range': "items=0-9", 'x-auth-login-token': $cookies.loginToken, 'x-auth-remember': $cookies.rememberMe, 'x-auth-user-id': $cookies.id, 'x-auth-login-time': $cookies.loginTime}})
			.then(function(result){
				myApplication.constant("tokens", result.data);
          }, function(errorResponse) {
        	  console.log(errorResponse);
        });
    }

    function bootstrapApplication() {
        angular.element(document).ready(function() {
            angular.bootstrap(document, ["homer"]);
        });
    }
})();
