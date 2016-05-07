/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


/**
 *
 * networkCtrl
 *
 */

angular
    .module('homer')
    .controller('vpcCtrl', vpcCtrl)

function vpcCtrl($scope, $modal, appService, $stateParams, localStorageService, promiseAjax) {

    localStorageService.set("networkList", null);
    if (localStorageService.get("networkList") == null) {
        var hasServer = promiseAjax.httpRequest("GET", "api/vps.json");
        hasServer.then(function (result) {  // this is only run after $http completes
            $scope.networkList = result;
            localStorageService.set("networkList", result);
        });
    } else {
        $scope.networkList = localStorageService.get("networkList");
    }

    // Add the VPC
    $scope.createVpc = function (size) {
        appService.dialogService.openDialog($scope.global.VIEW_URL + "vpc/add.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
            $scope.cancel = function(){
                $modalInstance.close();
            };
            }]);
    };

    $scope.createNetwork = function (size) {
        appService.dialogService.openDialog($scope.global.VIEW_URL + "vpc/create.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
             $scope.cancel = function(){
                $modalInstance.close();
            };
            }]);
    };

    $scope.saveNetwork = function(form, createNetwork) {
        $scope.formSubmitted = true;
        if (form.$valid) {
            //var createNetwork = angular.copy($scope.createNetwork);
            if (!angular.isUndefined($scope.network.domain) && $scope.network.domain != null) {
            	createNetwork.domainId = $scope.network.domain.id;
                delete createNetwork.domain;
            }
            if (!angular.isUndefined($scope.network.department) && $scope.network.department != null) {
            	createNetwork.departmentId = $scope.network.department.id;
                delete createNetwork.department;
            }
            if (!angular.isUndefined($scope.network.project) && $scope.network.project != null) {
            	createNetwork.projectId = $scope.network.project.id;
                delete createNetwork.project;
            }
            createNetwork.zoneId = $scope.network.zone.id;
            createNetwork.networkOfferingId = $scope.network.networkOffering.id;
            $scope.showLoader = true;
appService.globalConfig.webSocketLoaders.networkLoader = true;
            $modalInstance.close();
            var hasguestNetworks = appService.crudService.add("guestnetwork", createNetwork);
            hasguestNetworks.then(function(result) {
                $scope.showLoader = false;
            }).catch(function(result) {
                if (!angular.isUndefined(result) && result.data != null) {
                    if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                        var msg = result.data.globalError[0];
                        $scope.showLoader = false;
                        appService.notify({
                            message: msg,
                            classes: 'alert-danger',
                            templateUrl: $scope.global.NOTIFICATION_TEMPLATE
                        });
                    }
                    angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                        $scope.addnetworkForm[key].$invalid = true;
                        $scope.addnetworkForm[key].errorMessage = errorMessage;
                    });
                }
                $modalInstance.close();
                appService.globalConfig.webSocketLoaders.networkLoader = false;
            });
            $scope.cancel = function() {
                $modalInstance.close();
            };
        }
    },


    $scope.createPrivateGateway = function (size) {
        appService.dialogService.openDialog($scope.global.VIEW_URL + "vpc/add-private-gateway.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
             $scope.cancel = function(){
                $modalInstance.close();
            };
            }]);
    };

    $scope.acquireNewIp = function (size) {
        appService.dialogService.openDialog($scope.global.VIEW_URL + "vpc/acquire-newip.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
             $scope.cancel = function(){
                $modalInstance.close();
            };
            }]);
    };
    $scope.addAcl = function (size) {
        appService.dialogService.openDialog($scope.global.VIEW_URL + "vpc/add-acl.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
             $scope.cancel = function(){
                $modalInstance.close();
            };
            }]);
    };

    $scope.openAddInstance = function(size) {
        appService.dialogService.openDialog("app/views/cloud/instance/add.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
            $scope.cancel = function(){
                $modalInstance.close();
            };
            }]);
    };
}