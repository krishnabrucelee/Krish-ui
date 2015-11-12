/**
 *
 * storageCtrl
 *
 */

angular
    .module('homer')
    .controller('storageCtrl', storageCtrl)

function storageCtrl($scope, $state, $stateParams, filterFilter, localStorageService,
volumeService, modalService, promiseAjax, notify, globalConfig) {
    $scope.global = globalConfig;
    $scope.storageDetails = {};
    $scope.volumeElements = volumeService.volumeElements;
    $scope.volume = {};
    if (localStorageService.get("volumeList") == null) {
        var hasServer = promiseAjax.httpRequest("GET", "api/instance.json");
        hasServer.then(function (result) {  // this is only run after $http completes
            $scope.instanceName = result[$stateParams.id - 1].name;
            $scope.volumeList = result[$stateParams.id - 1].volumeList;
            localStorageService.set("volumeList", $scope.volumeList);
        });
    } else {
        var hasServer = promiseAjax.httpRequest("GET", "api/instance.json");
        hasServer.then(function (result) {
           $scope.instanceName = result[$stateParams.id - 1].name;
        });
        $scope.volumeList = localStorageService.get("volumeList");
    }

    $scope.addVolume = function(size) {
        modalService.trigger('app/views/cloud/instance/add-volume.jsp', 'md')

    };

    $scope.resetDiskValues = function(volumeType) {

        $scope.volume.type = volumeType;
        $scope.volume.diskOfferings = null;
        $scope.volumeElements.diskOffer.diskSize.value = 1;
        $scope.volumeElements.diskOffer.iops.value = 1;
    };


    $scope.save = function(form) {
        $scope.instanceId = $stateParams.id;
        $scope.formSubmitted = true;
        var diskValid = true;
        if($scope.volume.diskOfferings.custom &&
                ($scope.volumeElements.diskOffer.diskSize.value <= 0 || $scope.volumeElements.diskOffer.iops.value <= 0)) {
            diskValid = false;
        }
        if (form.$valid && diskValid) {
            if(filterFilter($scope.volumeList,{'name':$scope.volume.name})[0]== null){
                $scope.volumeList = volumeService.saveByInstance($scope.volume, $scope.instanceId);
                localStorageService.set('volumeList', $scope.volumeList);
                localStorageService.set('instanceViewTab', 'storage');

                $scope.homerTemplate = 'app/views/notification/notify.jsp';
                notify({message: 'Added successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
                $scope.cancel();
                $state.reload();
            }
            else {
                $scope.homerTemplate = 'app/views/notification/notify.jsp';
                notify({message: 'Disk already added', classes: 'alert-danger', templateUrl: $scope.homerTemplate});

            }
        }
    };


}