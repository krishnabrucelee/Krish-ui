/**
 * http://usejsdoc.org/
 */
angular.module('homer').controller('paymentController', paymentController)

function paymentController($sce, $window, $scope, localStorageService) {
    $scope.data = "";
    $scope.showLoader = true;
    if (!angular.isUndefined(localStorageService.get("payments")) && localStorageService.get("payments") != null) {
        $scope.data = $sce.trustAsHtml(localStorageService.get("payments"));
        localStorageService.set("payments", null);
    } else {
        $window.location.href = '#/billing/payments';
    }
};

