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


}