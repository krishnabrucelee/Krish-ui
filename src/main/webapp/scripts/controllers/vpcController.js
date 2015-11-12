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

function vpcCtrl($scope, $modal, $stateParams, localStorageService, promiseAjax) {

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

}