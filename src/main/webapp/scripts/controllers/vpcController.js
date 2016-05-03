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