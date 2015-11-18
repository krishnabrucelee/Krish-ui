/**
 *
 * loginCtrl
 *
 */
angular.module('homer', []).controller("loginCtrl", function ($scope, $http, globalConfig, $window) {

    $scope.loginForm = function () {
        var username = document.getElementById("username").value;
        var password = document.getElementById("password").value;
        var domain = document.getElementById("domain").value;

        var headers = {
            "x-requested-with": domain,
            "x-auth-username": username,
            "x-auth-password": password,
            'Content-Type': 'application/json'
        };

        $http({method: 'POST', url: globalConfig.APP_URL + 'authenticate', headers: headers})
            .success(function (result) {
               $window.sessionStorage.token = result.token;
               window.location.href = "index#/dashboard";
           }).catch(function (result) {
       	       delete $window.sessionStorage.token;
                  if (!angular.isUndefined(result.data)) {
        	          var target = document.getElementById("errorMsg");
                      target.innerHTML = result.data.message;
                      target.style.display = 'block';
                      target.style["margin-bottom"] = '10px';
                  }
           });

    }
});
