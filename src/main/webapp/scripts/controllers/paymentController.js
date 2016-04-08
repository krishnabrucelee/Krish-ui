/**
 * http://usejsdoc.org/
 */
angular.module('homer').controller('paymentController', paymentController)

function paymentController($sce, $scope, localStorageService) {
    $scope.data = "";
    $scope.showLoader = true;
    if (!angular.isUndefined(localStorageService.get("payments")) && localStorageService.get("payments") != null) {
        $scope.data = $sce.trustAsHtml(localStorageService.get("payments"));
    }
};

