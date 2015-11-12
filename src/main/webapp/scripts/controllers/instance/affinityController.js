/**
 *
 * affinityCtrl
 *
 */

angular
    .module('homer')
    .controller('affinityCtrl', affinityCtrl)

function affinityCtrl($scope, $modalInstance, globalConfig, $window, notify) {

    $scope.global = globalConfig;

    // Form Field Decleration
    $scope.volume = {

    };
    $scope.formSubmitted = false;

    $scope.formElements = {
        formatList: [
            {id: 1, name: 'RAW'},
            {id: 2, name: 'VHD'},
            {id: 3, name: 'VHDX'},
            {id: 4, name: 'OVA'},
            {id: 5, name: 'QCOW2'}
        ]
    };

    $scope.formSubmitted = false;
    $scope.save = function(form) {
        $scope.formSubmitted = true;
        if (form.$valid) {
            $scope.cancel();
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            notify({message: 'Added successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
            //$window.location.href = '#/volume/list'
        }
    };

    $scope.ok = function () {
        $modalInstance.close();
    };

    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };
}