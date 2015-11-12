function modalService($modal,$document, $modalStack) {
    return {
        trigger: function(template,size, title) {
            $modal.open({
                templateUrl: template,
                size: size,
                controller: function($scope, $modalInstance) {
                    $scope.modalTitle = title;
                    $scope.ok = function() {
                        $modalInstance.close($scope.selected.item);
                    };
                    $scope.cancel = function() {
                        $modalInstance.dismiss('cancel');
                    };
                },
                backdrop : 'static',
            });
        },
        close: function(reason) {
            $modalStack.dismissAll(reason);
        }
    };
};


/**
 * Pass function into module
 */
angular
    .module('homer')
    .factory('modalService', modalService)