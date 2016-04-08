/**
 * http://usejsdoc.org/
 */
angular.module('homer').controller('paymentController', paymentController)

function paymentController($sce, $scope, appService, globalConfig, localStorageService, $window, notify) {
    $scope.data = "";
    $scope.showLoader = true;
    console.log(appService.localStorageService.get("payments"));
    if (!angular.isUndefined(appService.localStorageService.get("payments")) && appService.localStorageService
            .get("payments") != null) {
        $scope.data = $sce.trustAsHtml(appService.localStorageService.get("payments"));
    }
};

