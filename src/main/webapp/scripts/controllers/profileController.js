
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

angular
        .module('homer')
        .controller('profileCtrl', profileCtrl)


function profileCtrl($scope, appService) {

    $scope.global = appService.globalConfig;
    $scope.profile = {};
    $scope.status = {};

        $scope.status.basic = true;
        $scope.status.password = true;
        $scope.status.api = true;

    // User List
    $scope.list = function (pageNumber) {
    	$scope.showLoader = true;
        var hasProfileUsers = appService.promiseAjax.httpTokenRequest(appService.crudService.globalConfig.HTTP_GET,
    			appService.crudService.globalConfig.APP_URL + "users"  +"/uservalidlist/"+$scope.global.sessionValues.id);
        hasProfileUsers.then(function (result) {  // this is only run after $http completes0
            $scope.profile = result;
            $scope.showLoader = false;
        });
    };
    $scope.list(1);

    $scope.updatePassword = function (form, profile) {
        $scope.formSubmitted = true;
        if (form.$valid) {
        	$scope.showLoader = true;
        	if(profile.newPassword != profile.confirmPassword) {
        		appService.notify({message: 'Password did not match', classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
            } else {
            	profile.password = profile.oldPassword;
            	profile.confirmPassword = profile.confirmPassword;
            var hasUpdatePassword = appService.crudService.add("users/updatePassword", profile);
            $scope.formSubmitted = false;
            hasUpdatePassword.then(function (result) {
            	$scope.showLoader = false;
                appService.notify({message: 'Added successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                $scope.list(1);
            }).catch(function (result) {
            	$scope.showLoader = false;
    		    if (!angular.isUndefined(result.data)) {
                if (result.data.fieldErrors != null) {
                    angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                    	$scope.showLoader = false;
                        $scope.profileForm[key].$invalid = true;
                        $scope.profileForm[key].errorMessage = errorMessage;
                    });
        		}
        	}
    	});
    }
    }
    }
//
//    var hasServer = appService.promiseAjax.httpRequest("GET", "api/accounts.json");
//    hasServer.then(function (result) {
//        $scope.accountList = result;
//    });
//
//
//
//
//    $scope.checkAccount = function (item) {
//        item.isSelected = true;
//        $scope.checkOne(item);
//
//    }
//
//
//
//    $scope.addUser = function (form) {
//        $scope.formSubmitted = true;
//        if (form.$valid) {
//            $scope.cancel();
//            $scope.homerTemplate = 'views/notification/notify.html';
//            appService.notify({message: 'Account created successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
//            //$window.location.href = '#/volume/list'
//        }
//    };
//
//    $scope.status = {};
//
//    $scope.status.basic = true;
//
//    $scope.saveUser = function (form) {
//        $scope.formSubmitted = true;
//        if (form.$valid) {
//            $scope.cancel();
//            $scope.homerTemplate = 'views/notification/notify.html';
//            appService.notify({message: 'Account updated successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
//            //$window.location.href = '#/volume/list'
//        }
//    };

//    $scope.profile={
//        "name":"user",
//        "user":"user",
//        "email":"user@assistanz.com",
//        "telephone":"123456789",
//        "password":"xxxxx",
//        "newpassword":"xxxxx",
//        "confirm":"xxxxx",
//        "company":"Assistanz",
//        "userId":"122-332302-#42323",
//        "projectId":"04233-332233302-#42323"
//    };

}