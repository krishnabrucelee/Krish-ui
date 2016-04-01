/**
 *
 * instanceCtrl
 *
 */

angular
    .module('homer')
    .controller('billingCtrl', billingCtrl)

function billingCtrl($scope, promiseAjax, globalConfig, localStorageService, $window, notify) {

    $scope.global = globalConfig;
    $scope.invoiceList = [];



    localStorageService.set("invoiceList",null);
    if (localStorageService.get("invoiceList") == null) {
        var hasServer = promiseAjax.httpRequest("GET", "api/invoice.json");
        hasServer.then(function (result) {  // this is only run after $http completes
            $scope.invoiceList = result;
            localStorageService.set("invoiceList", result);
        });
    } else {
        $scope.invoiceList = localStorageService.get("invoiceList");
    }

    $scope.save = function(form) {
        $scope.formSubmitted = true;
        if (form.$valid) {
            $scope.invoiceList = localStorageService.get("invoiceList");
            var invoiceCount = $scope.invoiceList.length;

            localStorageService.set("invoiceList", $scope.invoiceList);


        }
    };

    $scope.usageStatistics = [];
    var hasServer = promiseAjax.httpRequest("GET", "http://localhost:8081/api/usage/listUsageByPeriod?fromDate=25-03-2016&toDate=31-03-2016&groupingType=service");
    hasServer.then(function (result) {  // this is only run after $http completes
        $scope.usageStatistics = result;
    });


}