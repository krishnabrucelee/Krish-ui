/**
 *
 * loginCtrl
 *
 */
angular.module('homer', ['ngCookies']).controller("loginCtrl", function ($scope, $http, globalConfig, $window, $remember, $cookies) {

        $scope.loginForm = function () {
    	if (angular.isUndefined($scope.user_remember)) {
    		$scope.user_remember = "false";
    	}

        var headers = {
            "x-requested-with": $scope.user_domain,
            "x-auth-username": $scope.user_name,
            "x-auth-password": $scope.user_password,
            "x-auth-remember": $scope.user_remember,
            "x-force-login" : "false",
            'Content-Type': 'application/json'
        };

        $http({method: 'POST', url: globalConfig.APP_URL + 'authenticate', headers: headers})
            .success(function (result) {
               $window.sessionStorage.token = result.token;
               $window.sessionStorage.setItem("loginSession", JSON.stringify(result));
           	   if (result.rememberMe == "true") {
           	       $cookies.token = result.token;
           	       $cookies.loginToken = result.loginToken;
           	       $cookies.id = result.id;
           	       $cookies.loginTime = result.loginTime;
           	       $cookies.rememberMe = result.rememberMe;
               } else {
            	   $cookies.token = result.token;
            	   $cookies.loginToken = result.loginToken;
            	   $cookies.id = result.id;
            	   $cookies.loginTime = result.loginTime;
            	   $cookies.rememberMe = result.rememberMe;
               }
               if(result.userStatus == "SUSPENDED") {
                   window.location.href = globalConfig.BASE_UI_URL + "index#/billing/usage";
               } else {
                   window.location.href = globalConfig.BASE_UI_URL + "index#/dashboard";
               }
           }).catch(function (result) {
                  if (!angular.isUndefined(result.data)) {
            	      if(result.data.message == "error.already.exists") {
            		  $scope.forceLogin = function() {
            		      if (confirm("Already user is logged In. Are you sure want to do Force Login?") == true) {
            		    	  var headers = {
            		    	            "x-requested-with": $scope.user_domain,
            		    	            "x-auth-username": $scope.user_name,
            		    	            "x-auth-password": $scope.user_password,
            		    	            "x-auth-remember": $scope.user_remember,
            		    	            "x-force-login" : "true",
            		    	            'Content-Type': 'application/json'
            		    	        };
            		          $http({method: 'POST', url: globalConfig.APP_URL + 'authenticate', headers: headers})
            		              .success(function (result) {
            		            	  $window.sessionStorage.token = result.token;
            		                  $window.sessionStorage.setItem("loginSession", JSON.stringify(result));
            		              	   if (result.rememberMe == "true") {
            		              	       $cookies.token = result.token;
            		              	       $cookies.loginToken = result.loginToken;
            		              	       $cookies.id = result.id;
            		              	       $cookies.loginTime = result.loginTime;
            		              	       $cookies.rememberMe = result.rememberMe;
            		                  } else {
            		               	       $cookies.token = result.token;
            		               	       $cookies.loginToken = result.loginToken;
            		               	       $cookies.id = result.id;
            		               	       $cookies.loginTime = result.loginTime;
            		               	       $cookies.rememberMe = result.rememberMe;
            		                  }
            		                  if(result.userStatus == "SUSPENDED") {
            		                      window.location.href = globalConfig.BASE_UI_URL + "index#/billing/usage";
            		                  } else {
            		                      window.location.href = globalConfig.BASE_UI_URL + "index#/dashboard";
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
            		  }
            		  $scope.forceLogin();
            		  } else {
                    	  $window.sessionStorage.removeItem("loginSession");
                    	  var target = document.getElementById("errorMsg");
                          target.innerHTML = result.data.message;
                          target.style.display = 'block';
                          target.style["margin-bottom"] = '10px';
                      }
                  }
           });

    }

});
