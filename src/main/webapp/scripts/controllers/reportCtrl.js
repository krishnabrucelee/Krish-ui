/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


angular
        .module('homer')
        .controller('reportCtrl', reportCtrl)


function reportCtrl($scope, globalConfig, notify, $state, $stateParams, modalService, $timeout, promiseAjax) {
    $scope.global = globalConfig;
    $scope.generatedList = [];
    $scope.report = {};



    var hasServer = promiseAjax.httpRequest("GET", "api/reports/report.json");
    hasServer.then(function (result) {  // this is only run after $http completes
        $scope.generatedList = result;
    });





}