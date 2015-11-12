/**
 *
 * volumeCtrl
 *
 */

angular
    .module('homer')
    .controller('volumeCtrl', volumeCtrl)
    .controller('volumeResizeCtrl', volumeResizeCtrl)
    .controller('volumeListCtrl', volumeListCtrl)
    .controller('recurringSnapshotCtrl', recurringSnapshotController)
    .controller('uploadVolumeCtrl', uploadVolumeCtrl)
    .controller('volumeViewCtrl', volumeViewCtrl)

function volumeCtrl($scope, $state, $stateParams, $timeout,globalConfig,
volumeService, localStorageService, $window, notify) {

    $scope.global = globalConfig;
    $scope.formSubmitted = false;
    // Form Field Decleration
    $scope.volume = {

    };

    $scope.volumeElements = volumeService.volumeElements;

    $scope.downloads = false;
     $scope.download = function() {
        $scope.downloadLoding = true;
        $timeout($scope.downloadActions, 2000);

    };
    $scope.downloadLink=function(url){
            $window.location.href=url;
            $scope.cancel();
    }

    $scope.downloadActions = function() {
        $scope.downloading = true;
        $scope.downloadLoding = false;

    };

      $scope.detach = function () {
        $scope.homerTemplate = 'app/views/notification/notify.jsp';
        notify({message: 'Detached successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
        $scope.cancel();
    };

    $scope.confirmSnapshot = function () {
        $scope.cancel();
        $window.location.href = '#volume/snapshot';
    };

    $scope.save = function(form) {
        $scope.formSubmitted = true;

        var diskValid = true;
        if($scope.volume.diskOfferings.custom &&
                ($scope.volumeElements.diskOffer.diskSize.value <= 0 || $scope.volumeElements.diskOffer.iops.value <= 0)) {
            diskValid = false;
        }
        if (form.$valid && diskValid) {

            var instanceVolumeList = localStorageService.get("volumeList");
            $scope.volumeList = instanceVolumeList.volumeList;

            $scope.volumeLists = localStorageService.get("volumeList");
            //console.log($scope.volumeLists);
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            notify({message: 'Added successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
            $scope.cancel();

            if(angular.isUndefined($stateParams.id)) {
                $window.location.href = '#/volume/list';
            } else {
                //$state.reload();
                //$window.location.href = '#instance/list/view/'+instanceId;
            }
        }
    };


    $scope.resetDiskValues = function(volumeType) {
        $scope.volume.type = volumeType;
        $scope.volume.diskOfferings = null;
        $scope.volumeElements.diskOffer.diskSize.value = 0;
        $scope.volumeElements.diskOffer.iops.value = 0;
    };

};

function volumeResizeCtrl($scope,volume, $stateParams, $modalInstance, promiseAjax, globalConfig, localStorageService, $window, notify) {

    $scope.global = globalConfig;
    $scope.formSubmitted = {};
    $scope.formSubmitted = false;
    // Form Field Decleration

     $scope.volume = volume;

    $scope.volumeElements = {
        diskOfferingList: [
            {id: 1, name: 'Small', size: "5 GB", price: 0.10, custom:false},
            {id: 2, name: 'Medium', size: "10 GB", price: 0.20, custom:false},
            {id: 3, name: 'Large', size: "15 GB", price: 0.40, custom:false},
            {id: 4, name: 'Custom', size: "15 GB", price: 0.40, custom:true}
        ],
        diskOffer: {
            category : 'static',
            diskSize: {
                floor: 0,
                ceil: 1024,
                value: 1
            },
            iops: {
                floor: 0,
                ceil: 500,
                value: 1
            },
            isOpen:false

        },

         type: [
            {id: 1, name: "Performance"},
            {id: 2, name: "Capacity"}
        ]
    };

    var hasServer = promiseAjax.httpRequest("GET", "api/volume.json");
    hasServer.then(function (result) {  // this is only run after $http completes
        var volumeId = $scope.volume.id - 1;
        $scope.volume = result[volumeId];
        angular.forEach($scope.volumeElements.diskOfferingList, function (diskOffer, index) {
            if (diskOffer.id == $scope.volume.plan.id) {
                $scope.volume.diskOfferings = $scope.volumeElements.diskOfferingList[index];
            }
        });




    });



    $scope.save = function(form) {
        $scope.formSubmitted = true;
        if (form.$valid) {
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            notify({message: 'Updated successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
            $scope.cancel();
            $window.location.href = '#/volume/list'
        }
    };

    $scope.ok = function () {
        $modalInstance.close();
    };

    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };


    $scope.resetDiskValues = function(volumeType) {
        $scope.volume.type = volumeType;
        $scope.volume.diskOfferings = null;
        $scope.volumeElements.diskOffer.diskSize.value = 1;
        $scope.volumeElements.diskOffer.iops.value = 1;
    };
}

function volumeListCtrl($scope,$document, $modal, $log, $timeout, promiseAjax, globalConfig,
localStorageService, $window, modalService, notify) {
    localStorageService.set("volumeList", null);
    if (localStorageService.get("volumeList") == null) {
        var hasServer = promiseAjax.httpRequest("GET", "api/volume.json");
        hasServer.then(function (result) {  // this is only run after $http completes
            $scope.volumeList = result;
            localStorageService.set("volumeList", result);
        });
    } else {
        $scope.volumeList = localStorageService.get("volumeList");
    }

    $scope.detachVolume = function(size) {
        modalService.trigger('app/views/cloud/volume/detach.jsp', size);
    };



    $scope.downloadVolume = function(size) {
        modalService.trigger('app/views/cloud/volume/download-snapshot.jsp', size);
    };


    $scope.openAddVolumeContainer = function(size) {
        modalService.trigger('app/views/cloud/volume/add.jsp', size);

    };

    $scope.openUploadVolumeContainer = function(size) {
        modalService.trigger('app/views/cloud/volume/upload.jsp', size);
    };


    $scope.openReccuringSnapshot = function(volume) {
        modalService.trigger('app/views/cloud/volume/recurring-snapshot.jsp', 'lg');
    };

    $scope.resizeVolume =  function(volume) {
        var modalInstance = $modal.open({
            animation: $scope.animationsEnabled,
            templateUrl: 'app/views/cloud/volume/resize.jsp',
            controller: 'volumeResizeCtrl',
            size: 'md',
            backdrop : 'static',
            windowClass: "hmodal-info",
            resolve: {
                volume: function () {
                    return angular.copy(volume);
                }
            }
        });

        modalInstance.result.then(function (selectedItem) {
            $scope.selected = selectedItem;

        }, function () {
            $log.info('Modal dismissed at: ' + new Date());
        });
    };


}


function recurringSnapshotController($scope, globalConfig, localStorageService, $window, notify) {

    $scope.global = globalConfig;
    $scope.formSubmitted = false;
    // Form Field Decleration
    $scope.recurringSnapshot = {
        minutes: 60,
        hour:12
    };

    $scope.getNumber = {};

    $scope.formElements = {
        timeZoneList: [
            {
            "id": 1,
            "name": "Etc/GMT+12"
            },
            {
            "id": 2,
            "name": "Pacific/Midwa"
            },
            {
            "id": 3,
            "name": "Pacific/Niue"
            },
            {
            "id": 4,
            "name": "Pacific/Pago_Pago"
            },
            {
            "id": 5,
            "name": "Pacific/Samoa"
            },
            {
            "id": 6,
            "name": "US/Samoa"
            },
            {
            "id": 7,
            "name": "America/Adak"
            }
        ],

        hourCount : new Array(12),
        minuteCount : new Array(60),
        dayOfMonth: new Array(28)

    };

    $scope.snapshotList = [
        {
            time: 1,
            dayOfWeek: "Every Sunday",
            timeZone: {
            "id": 4,
            "name": "Pacific/Pago_Pago"
            },
            noOfSnapshots:1
        },
        {
            time: 1,
            dayOfWeek: "Day 1 of month",
            timeZone: {
            "id": 4,
            "name": "Pacific/Midwa"
            },
            noOfSnapshots:1
        },
    ];

    $scope.number = 5;
    $scope.getNumber = function (num) {
        return new Array(num);
    }

    $scope.mytime = new Date();

    $scope.hstep = 1;
    $scope.mstep = 15;

    $scope.options = {
        hstep: [1, 2, 3],
        mstep: [1, 5, 10, 15, 25, 30]
    };

    $scope.ismeridian = true;
    $scope.toggleMode = function () {
        $scope.ismeridian = !$scope.ismeridian;
    };


    $scope.save = function(form) {
        $scope.formSubmitted = true;
        if (form.$valid) {
            $scope.snapshotList.push($scope.recurringSnapshot);
//            $scope.homerTemplate = 'app/views/notification/notify.jsp';
//            notify({message: 'Created successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
//            $scope.cancel();
            //$window.location.href = '#/volume/list'
        }
    };


}

function uploadVolumeCtrl($scope, globalConfig, $window, notify) {

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


    $scope.validateVolume = function(form) {
        $scope.formSubmitted = true;
        if (form.$valid) {
            $scope.cancel();
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            notify({message: 'Uploaded successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
            //$window.location.href = '#/volume/list'
        }
    };

}

function volumeViewCtrl($scope, $http, $state, $stateParams, localStorageService, promiseAjax) {
    if ($stateParams.id > 0) {
        var hasServer = promiseAjax.httpRequest("GET", "api/volume.json");
        hasServer.then(function (result) {  // this is only run after $http completes
            var volumeId = $stateParams.id - 1;
            $scope.volume = result[volumeId];
            $state.current.data.pageTitle = result[volumeId].name + " #" + $stateParams.id;
        });
    }
}
