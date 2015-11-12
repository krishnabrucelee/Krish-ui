/**
 *
 * loginCtrl
 *
 */
angular.module('homer', []).controller("loginCtrl", function ($scope, $http, globalConfig, $window) {

    $scope.loginForm = function () {
        var username = document.getElementById("username").value;
        var password = document.getElementById("password").value;

        if (username == "user" && password == "user")
        {
             var headers = {
                "x-requested-with": 'sample',
                "x-auth-username": username,
                "x-auth-password": password,
                'Content-Type': 'application/json'
            };

            $http({method: 'POST', url: globalConfig.APP_URL + 'authenticate', headers: headers})
            .success(function (result) {
                $window.sessionStorage.token = result.token;
                window.location.href = "index#/dashboard";
            }).error(function (data, status, headers, config) {
                delete $window.sessionStorage.token;
            });

        } else {
            var target = document.getElementById("errorMsg");
            target.innerHTML = "Invalid Username or Password";
            target.style.display = 'block';
            target.style["margin-bottom"] = '10px';
        }
    }
});