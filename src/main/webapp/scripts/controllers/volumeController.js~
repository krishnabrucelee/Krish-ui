/**
 *
 * volumeCtrl
 *
 */

angular
    .module('homer')
    .controller('volumeCtrl', volumeCtrl)
    .controller('volumeResizeCtrl', volumeResizeCtrl)
//    .controller('volumeListCtrl', volumeListCtrl)
    .controller('recurringSnapshotCtrl', recurringSnapshotController)
    .controller('uploadVolumeCtrl', uploadVolumeCtrl)
    .controller('volumeViewCtrl', volumeViewCtrl)

function volumeCtrl($scope, $state, $stateParams, $timeout,globalConfig,
volumeService, localStorageService, $window, notify, dialogService, crudService) {

 $scope.global = globalConfig;
    $scope.formSubmitted = false;
    // Form Field Decleration
    $scope.volume = {

    };

    $scope.volumeList = {};

    $scope.paginationObject = {};
    $scope.storageForm = {};
    $scope.global = crudService.globalConfig;


	 $scope.list = function (pageNumber) {
	        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
	        var hasVolumes = crudService.list("volumes", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
	        hasVolumes.then(function (result) {  // this is only run after $http
													// completes0

	            $scope.volumeList = result;
	            console.log($scope.volumeList);

	            $scope.volumeList.Count = 0;
	            if(result.length != 0) {
	            	$scope.volumeList.Count = result.length;
	            }

	            // For pagination
	            $scope.paginationObject.limit = limit;
	            $scope.paginationObject.currentPage = pageNumber;
	            $scope.paginationObject.totalItems = result.totalItems;
	        });
	    };
	    $scope.list(1);



    $scope.detachVolume = function(size) {
        modalService.trigger('app/views/cloud/volume/detach.jsp', size);
    };



    $scope.createSnapshot=function(size, volume){
	    	$scope.volume = volume;
	    	$scope.snapshot = {};
		        setTimeout(function () {
	       	 	dialogService.openDialog("app/views/cloud/snapshot/download-snapshot.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
	       	 	// Creating snapshot
	       	 		$scope.validateConfirmSnapshot = function(form) {

		       	 		$scope.formSubmitted = true;
		       	        if (form.$valid) {
			       	 		var snapshot = $scope.snapshot;
	    		       	 	snapshot.volume = $scope.volume;
	    		       	 	snapshot.zone = crudService.globalConfig.zone ;
			       	 		var hasServer = crudService.add("snapshots", snapshot);
	                        hasServer.then(function (result) {
	                        	notify({message: 'Added successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
	                        	$window.location = "#/snapshot/list";
	                            $modalInstance.close();
	                        }).catch(function (result) {
	                        	if(!angular.isUndefined(result) && result.data != null) {
	                        		if(result.data.globalError[0] != ''){
		                               	 var msg = result.data.globalError[0];
		                               	 notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
	                                }
		                            angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
		                            	$scope.confirmsnapshot[key].$invalid = true;
		                                $scope.confirmsnapshot[key].errorMessage = errorMessage;
		                            });
	                        	}

	                        });
		       	        }
	       	 		};

	       	 		// Close the dialog box
		       	 	$scope.closeCreateSnapshot = function () {
			    		$modalInstance.close();
		            };


	       	 	}]);
	        }, 500);

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

//==========================================

//===========================================

$scope.volume = {};
    $scope.addVolume = function (size) {

        dialogService.openDialog($scope.global.VIEW_URL + "cloud/volume/add.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {




          $scope.diskList = function (tag) {
              var hasDisks = crudService.listAllByTag("storages/storagesort",tag);
              hasDisks.then(function (result) {  // this is only run after $http completes0
                     $scope.volumeElements.diskOfferingList = result;
               });
           };



          $scope.diskTag = function () {
              var hasDiskTags = crudService.listAll("storages/storagetags");
              hasDiskTags.then(function (result) {  // this is only run after $http completes0

                     $scope.volumeElements.diskOfferingTags = result;
               });
           };
           $scope.diskTag();

 $scope.$watch('volume.storageTags', function (val) {
     $scope.diskList(val);
      });





                // Create a new application
                $scope.save = function (form) {

                    $scope.formSubmitted = true;


/**        var diskValid = true;

        if(($scope.volume.storageOffering.isCustomDisk && $scope.volume.diskSize <= 0) || ($scope.volume.storageOffering.isCustomizedIops && $scope.volume.diskMinIops <= 0)) {
            diskValid = false;
        }
alert(diskValid); */
        if (form.$valid) {
			$scope.volume.zone = $scope.global.zone;

                      var volume = $scope.volume;

                        var hasVolume = crudService.add("volumes", volume);
                        hasVolume.then(function (result) {  // this is only run after $http completes
                            $scope.list(1);
                            notify({message: 'Added successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                            $modalInstance.close();
                        }).catch(function (result) {
                            angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                                $scope.applicationForm[key].$invalid = true;
                                $scope.applicationForm[key].errorMessage = errorMessage;
                            });
                        });
                    }
                },
                        $scope.cancel = function () {
                            $modalInstance.close();
                        };
            }]);
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


//    $scope.save = function(form) {
//        $scope.formSubmitted = true;
//
//        var diskValid = true;
//        if($scope.volume.diskOfferings.custom &&
//                ($scope.volumeElements.diskOffer.diskSize.value <= 0 || $scope.volumeElements.diskOffer.iops.value <= 0)) {
//            diskValid = false;
//        }
//        if (form.$valid && diskValid) {
//
//            var instanceVolumeList = localStorageService.get("volumeList");
//            $scope.volumeList = instanceVolumeList.volumeList;
//
//            $scope.volumeLists = localStorageService.get("volumeList");
//            //console.log($scope.volumeLists);
//            $scope.homerTemplate = 'app/views/notification/notify.jsp';
//            notify({message: 'Added successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
//            $scope.cancel();
//
//            if(angular.isUndefined($stateParams.id)) {
//                $window.location.href = '#/volume/list';
//            } else {
//                //$state.reload();
//                //$window.location.href = '#instance/list/view/'+instanceId;
//            }
//        }
//    };

/**    $scope.volume = {};


    $scope.addVolume = function (size) {


        dialogService.openDialog($scope.global.VIEW_URL + "cloud/volume/add.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
                // Create a new Volume
                $scope.save = function (form) {
                    $scope.formSubmitted = true;
                    if (form.$valid) {
                        var volume = $scope.volume;
                        var hasVolume = crudService.add("volumes", volume);
                        hasVolume.then(function (result) {  // this is only run after $http completes
                            $scope.list(1);
                            notify({message: 'Added successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                            $modalInstance.close();
                        }).catch(function (result) {
                            angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                                $scope.applicationForm[key].$invalid = true;
                                $scope.applicationForm[key].errorMessage = errorMessage;
                            });
                        });
                    }
                },
                        $scope.cancel = function () {
                            $modalInstance.close();
                        };
            }]);
    };
*/

    $scope.resetDiskValues = function(volumeType) {
        $scope.volume.type = volumeType;
        $scope.volume.storageOffering = null;
        $scope.volumeElements.storageOffering.diskSize.value = 0;
        $scope.volumeElements.storageOffering.iops.value = 0;
    };

};

function volumeResizeCtrl($scope,volume, $stateParams, $modalInstance, promiseAjax, globalConfig, localStorageService, $window, notify) {

    $scope.global = globalConfig;
    $scope.formSubmitted = {};
    $scope.formSubmitted = false;
    // Form Field Decleration

     $scope.volume = volume;

  /**  $scope.volumeElements = {
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
    };*/

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

//function volumeListCtrl($scope,$document, $modal, $log, $timeout, promiseAjax, globalConfig, crudService,
//localStorageService, $window, modalService, notify,dialogService) {


//}


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
