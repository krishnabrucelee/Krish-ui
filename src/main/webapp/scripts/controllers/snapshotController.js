

angular
    .module('homer')
    .controller('addVMSnapshotCtrl', addVMSnapshotCtrl)
    .controller('addSnapshotCtrl', addSnapshotCtrl)
    .controller('addConfirmSnapshotCtrl', addConfirmSnapshotCtrl)
    .controller('snapshotListCtrl', snapshotListCtrl)

    function addConfirmSnapshotCtrl($scope, globalConfig, $window, notify) {

    $scope.global = globalConfig;

    // Form Field Decleration
    $scope.confirmsnapshot = {

    };
    $scope.formSubmitted = false;




    $scope.validateConfirmSnapshot = function(form) {
        $scope.formSubmitted = true;
        if (form.$valid) {
            $scope.cancel();
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            notify({message: 'Snapshot created', classes: 'alert-success', templateUrl: $scope.homerTemplate});
            //$window.location.href = '#/volume/list'
        }
    };

}
    function addSnapshotCtrl($scope,$modal,modalService, globalConfig, $window, notify) {

    $scope.global = globalConfig;

    // Form Field Decleration
    $scope.snapshot = {

    };
    $scope.formSubmitted = false;


     $scope.downloadLink=function(size){
        $scope.cancel();
        setTimeout(function () {
            modalService.trigger('app/views/cloud/snapshot/download-snapshot.jsp', size);
        }, 500);

    };



}

function addVMSnapshotCtrl($scope, globalConfig, $window, notify) {

    $scope.global = globalConfig;

    // Form Field Decleration
    $scope.vmsnapshot = {

    };
    $scope.formSubmitted = false;

    $scope.formElements = {
        instanceList: [
            {id: 1, name: 'North China'},
            {id: 2, name: 'South central china'}


        ]


     };


    $scope.validateVMSnapshot = function(form) {
        $scope.formSubmitted = true;
        if (form.$valid) {
            $scope.cancel();
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            notify({message: 'VM Snapshot created', classes: 'alert-success', templateUrl: $scope.homerTemplate});

        }
    };
    $scope.validateCreateVolume = function(form) {
        $scope.formSubmitted = true;
        if (form.$valid) {
            $scope.cancel();
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            notify({message: 'Created successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});

        }
    };
    $scope.validateDeleteSnapshot = function(form) {
        $scope.formSubmitted = true;
        if (form.$valid) {
            $scope.cancel();
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            notify({message: 'Deleted successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});

        }
    };

};


function snapshotListCtrl($scope, $modal, $log, $timeout, promiseAjax, globalConfig,
localStorageService, $window, modalService, notify) {
    localStorageService.set("snapshotList", null);
    if (localStorageService.get("snapshotList") == null) {
        var hasServer = promiseAjax.httpRequest("GET", "api/snapshot.json");
        hasServer.then(function (result) {  // this is only run after $http completes
            $scope.snapshotList = result;
            localStorageService.set("snapshotList", result);
        });
    } else {
        $scope.snapshotList = localStorageService.get("snapshotList");
    }

     $scope.openAddSnapshotContainer = function(size) {
        modalService.trigger('app/views/cloud/snapshot/create.jsp', size);
    };

    $scope.openAddVMSnapshotContainer = function(size) {
        modalService.trigger('app/views/cloud/snapshot/createVm.jsp', size);
    };
    $scope.createVolume = function(size) {
        modalService.trigger('app/views/cloud/snapshot/create-volume.jsp', size);
    };
    $scope.deleteSnapshot = function(size) {
        modalService.trigger('app/views/cloud/snapshot/delete-snapshot.jsp', size);
    };
}
