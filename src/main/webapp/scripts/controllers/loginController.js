/**
 *
 * loginCtrl
 *
 */
angular.module('homer', []).controller("loginCtrl", function ($scope, $http, globalConfig, $window, $remember) {

    $scope.loginForm = function () {

        if ($scope.user_remember) {
            $remember('user_name', $scope.user_name);
            $remember('user_password', $scope.user_password);
            $remember('user_domain', $scope.user_domain);
        }

        var headers = {
            "x-requested-with": $scope.user_domain,
            "x-auth-username": $scope.user_name,
            "x-auth-password": $scope.user_password,
            'Content-Type': 'application/json'
        };

        $http({method: 'POST', url: globalConfig.APP_URL + 'authenticate', headers: headers})
            .success(function (result) {
                console.log("User", result.userStatus);
               //$window.sessionStorage.token = result.token;
               $window.sessionStorage.setItem("loginSession", JSON.stringify(result));
               if(result.userStatus == "SUSPENDED") {
                   window.location.href = "index#/billing/invoice";
               } else {
                   window.location.href = "index#/dashboard";
               }
           }).catch(function (result) {
               $window.sessionStorage.removeItem("loginSession")
                  if (!angular.isUndefined(result.data)) {
                      var target = document.getElementById("errorMsg");
                      target.innerHTML = result.data.message;
                      target.style.display = 'block';
                      target.style["margin-bottom"] = '10px';
                  }
           });

    }

    //Set remember me option
    $scope.rememberMe = function() {
        if ($scope.user_remember) {
            $remember('user_name', $scope.user_name);
            $remember('user_password', $scope.user_password);
            $remember('user_domain', $scope.user_domain);
        } else {
            $remember('user_name', '');
            $remember('user_password', '');
            $remember('user_domain', '');
        }
    };

    //Load cookie user name and password
    $scope.user_remember = false;
    if ($remember('user_name') && $remember('user_password') ) {
        $scope.user_remember = true;
        $scope.user_name = $remember('user_name');
        $scope.user_password = $remember('user_password');
        $scope.user_domain = $remember('user_domain');
    }

});
