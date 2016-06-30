/**
 *
 * loginCtrl
 *
 */
angular.module('homer', ['ngCookies', 'LocalStorageModule'])
.filter('to_trusted', ['$sce', function($sce){
            return function(text) {
                return $sce.trustAsHtml(text);
            };
        }])
.controller("loginCtrl", function ($scope, $http, globalConfig, $window, $remember, $cookies, localStorageService) {

      $scope.showImage = function() {
            $scope.backgroundImage =   REQUEST_PROTOCOL+ $window.location.hostname +':8080/'  + 'resources/' + 'theme_background.jpg';
    }
    $scope.showImage();



    $scope.languageSettingList = function () {
        return $http({method:'get', url: REQUEST_PROTOCOL  + $window.location.hostname +':8080/home/generalConfiguration'})
        .then(function(result){
            $scope.generalconfiguration = result;
            if ($scope.generalconfiguration.data.defaultLanguage == 'Chinese') {
                localStorageService.cookie.set('language', 'zh');
            } else {
                localStorageService.cookie.set('language', 'en');
            }
            window.location.href = globalConfig.BASE_UI_URL;
        });
    };
    if(localStorageService.cookie.get('language') == null) {
        $scope.languageSettingList();
    }

    $scope.themeSettingList = function () {
        return $http({method:'get', url:  REQUEST_PROTOCOL+ $window.location.hostname +':8080/home/list'})
        .then(function(result){
            $scope.themeSettings = result.data;
            localStorageService.cookie.set('themeSettings', $scope.themeSettings);
             $scope.welcomeContentUser = result.data.welcomeContentUser;
             $scope.footerContent = result.data.footerContent;
             $scope.splashTitleUser= result.data.splashTitleUser;
             $cookies.splashTitleUser = result.data.splashTitleUser;

             // Used for pageTitle
             localStorageService.set('themeSettings', $scope.themeSettings);
             if($scope.themeSettings != null) {
                 document.getElementById("pandaAppPageTitle").innerHTML = $scope.themeSettings.headerTitle;
             }


        });
    };
    $scope.themeSettingList();

	 $scope.captchaList = function () {
			return $http({method:'get', url:  REQUEST_PROTOCOL+ $window.location.hostname +':8080/home/generalConfiguration'}).
then(function(result){
			$scope.captcha = result;
			$scope.enableCaptcha = result.data.enableCaptcha;
       		});
    };
$scope.captchaList();


    //For remember login functionality.
    if ((localStorageService.get('rememberMe') == "true" || localStorageService.get('rememberMe') == true)) {
        return $http({method:'get', url:  REQUEST_PROTOCOL+ $window.location.hostname +':8080/api/'  + 'users/usersessiondetails/'+localStorageService.get('id'),
            "headers": {'x-auth-token': localStorageService.get('token'), 'x-requested-with': '', 'Content-Type': 'application/json', 'Range': "items=0-9", 'x-auth-login-token': localStorageService.get('loginToken'), 'x-auth-remember': localStorageService.get('rememberMe'), 'x-auth-user-id': localStorageService.get('id'), 'x-auth-login-time': localStorageService.get('loginTime')}})
            .then(function(result){
                $window.location.href = "index#/dashboard";
          }, function(errorResponse) {
              localStorageService.set('rememberMe', "false");
              $cookies.rememberMe = "false";
              $window.location.reload();
        });
    }

   $scope.refreshCaptcha = function() {
	     //$('#captchaImg').attr('src', '').attr('src', '${pageContext.request.contextPath}/captcha')
	   	document.getElementById("captchaImg").setAttribute("src", 'CaptchaServlet')
   }


        $scope.loginForm = function () {


        	if (!angular.isUndefined($scope.answer) && $scope.answer != null)
        	 {
        	 var headers = {
        			 "x-answer" : $scope.answer
        	 }
       $http({method: 'POST', url : REQUEST_PROTOCOL + window.location.hostname + REQUEST_PORT + REQUEST_FOLDER + 'CaptchaServlet', headers: headers})
       .success(function (result) {
           if(result.result == 'success'){
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
        $scope.showLoader = true;
        $http({method: 'POST', url: globalConfig.APP_URL + 'authenticate', headers: headers})
            .success(function (result) {
               $scope.showLoader = false;
               $window.sessionStorage.token = result.token;
               $window.sessionStorage.setItem("loginSession", JSON.stringify(result));
               localStorageService.set('token', result.token);
               localStorageService.set('loginToken', result.loginToken);
               localStorageService.set('id', result.id);
               localStorageService.set('loginTime', result.loginTime);
               localStorageService.set('rememberMe', result.rememberMe);
               $cookies.rememberMe = result.rememberMe;
               if(result.userStatus == "SUSPENDED") {
                   window.location.href = globalConfig.BASE_UI_URL + "index#/billing/usage";
               } else {
                   window.location.href = globalConfig.BASE_UI_URL + "index#/dashboard";
               }
           }).catch(function (result) {
        	      $scope.showLoader = false;
                  if (!angular.isUndefined(result.data) && result.data != null) {
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
            		    	  $scope.showLoader = true;
            		          $http({method: 'POST', url: globalConfig.APP_URL + 'authenticate', headers: headers})
            		              .success(function (result) {
            		            	  $scope.showLoader = false;
            		            	  $window.sessionStorage.token = result.token;
            		                  $window.sessionStorage.setItem("loginSession", JSON.stringify(result));
            		                  localStorageService.set('token', result.token);
            		                  localStorageService.set('loginToken', result.loginToken);
            		                  localStorageService.set('id', result.id);
            		                  localStorageService.set('loginTime', result.loginTime);
            		                  localStorageService.set('rememberMe', result.rememberMe);
            		                  $cookies.rememberMe = result.rememberMe;
            		                  if(result.userStatus == "SUSPENDED") {
            		                      window.location.href = globalConfig.BASE_UI_URL + "index#/billing/usage";
            		                  } else {
            		                      window.location.href = globalConfig.BASE_UI_URL + "index#/dashboard";
            		                  }
            		          }).catch(function (result) {
            		        	  $scope.showLoader = false;
            		        	  $window.sessionStorage.removeItem("loginSession")
            		        	  if (!angular.isUndefined(result.data)) {
            		        		  var target = document.getElementById("errorMsgs");
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
                    	  var target = document.getElementById("errorMsgs");
                          target.innerHTML = result.data.message;
                          target.style.display = 'block';
                          target.style["margin-bottom"] = '10px';
                      }
                  } else {
                	  $window.sessionStorage.removeItem("loginSession")
    	        	  if (!angular.isUndefined(result.data)) {
    	        		var target = document.getElementById("errorMsgs");
    	                target.innerHTML = "The server could be temporarily unavailable. Try again in a few moments.";
    	                target.style.display = 'block';
    	                target.style["margin-bottom"] = '10px';
    	        	  }
                  }
           });
           } else {
        	   if(!angular.isUndefined(result.result) || result.result == "failure") {
        	   var target = document.getElementById("errorMsgs");
               target.innerHTML = "Invalid captcha.";
               target.style.display = 'block';
              target.style["margin-bottom"] = '10px';
        	   }
           }
           });
        		}
        }

        $scope.loginFormWithoutCaptcha = function () {

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
        $scope.showLoader = true;
        $http({method: 'POST', url: globalConfig.APP_URL + 'authenticate', headers: headers})
            .success(function (result) {
               $scope.showLoader = false;
               $window.sessionStorage.token = result.token;
               $window.sessionStorage.setItem("loginSession", JSON.stringify(result));
               localStorageService.set('token', result.token);
               localStorageService.set('loginToken', result.loginToken);
               localStorageService.set('id', result.id);
               localStorageService.set('loginTime', result.loginTime);
               localStorageService.set('rememberMe', result.rememberMe);
               $cookies.rememberMe = result.rememberMe;
               if(result.userStatus == "SUSPENDED") {
                   window.location.href = globalConfig.BASE_UI_URL + "index#/billing/usage";
               } else {
                   window.location.href = globalConfig.BASE_UI_URL + "index#/dashboard";
               }
           }).catch(function (result) {
                  $scope.showLoader = false;
                  if (!angular.isUndefined(result.data) && result.data != null) {
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
                              $scope.showLoader = true;
                              $http({method: 'POST', url: globalConfig.APP_URL + 'authenticate', headers: headers})
                                  .success(function (result) {
                                      $scope.showLoader = false;
                                      $window.sessionStorage.token = result.token;
                                      $window.sessionStorage.setItem("loginSession", JSON.stringify(result));
                                      localStorageService.set('token', result.token);
                                      localStorageService.set('loginToken', result.loginToken);
                                      localStorageService.set('id', result.id);
                                      localStorageService.set('loginTime', result.loginTime);
                                      localStorageService.set('rememberMe', result.rememberMe);
                                      $cookies.rememberMe = result.rememberMe;
                                      if(result.userStatus == "SUSPENDED") {
                                          window.location.href = globalConfig.BASE_UI_URL + "index#/billing/usage";
                                      } else {
                                          window.location.href = globalConfig.BASE_UI_URL + "index#/dashboard";
                                      }
                              }).catch(function (result) {
                                  $scope.showLoader = false;
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
                  } else {
                      $window.sessionStorage.removeItem("loginSession")
                      if (!angular.isUndefined(result.data)) {
                        var target = document.getElementById("errorMsg");
                        target.innerHTML = "The server could be temporarily unavailable. Try again in a few moments.";
                        target.style.display = 'block';
                        target.style["margin-bottom"] = '10px';
                      }
                  }
           });
        }
});
