/**
 *
 * volumeCtrl
 *
 */

angular
        .module('homer')
        .controller('volumeCtrl', volumeCtrl)
        .controller('recurringSnapshotCtrl', recurringSnapshotController)
        //.controller('uploadVolumeCtrl', uploadVolumeCtrl)

function volumeCtrl($scope, $state, $stateParams, $timeout, globalConfig,
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

    // Volume List
    $scope.list = function (pageNumber) {
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasVolumes = crudService.list("volumes", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
        hasVolumes.then(function (result) {
            $scope.volumeList = result;
            console.log($scope.volumeList);

            $scope.volumeList.Count = result.totalItems;
            // For pagination
            $scope.paginationObject.limit = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
        });
    };
    $scope.list(1);

    // Attach Volume
    $scope.attach = function (size, volume) {
        $scope.volume = volume;
        dialogService.openDialog("app/views/cloud/volume/attach-volume.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {


            // instance List
        	$scope.instanceList = function (pageNumber) {
                var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
                var hasVolumes = crudService.list("volumes/listvm", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
                hasVolumes.then(function (result) {
                	  $scope.instanceList = result;

                    $scope.paginationObject.limit = limit;
                    $scope.paginationObject.currentPage = pageNumber;
                    $scope.paginationObject.totalItems = result.totalItems;
                });
            };
            $scope.instanceList(1);


                $scope.attachVolume = function (form, volume) {
                    volume.vmInstance = $scope.vmInstance;
                    $scope.formSubmitted = true;
                    if (form.$valid) {
                        var hasServer = crudService.add("volumes/attach/" + volume.id, volume);
                        hasServer.then(function (result) {  // this is only run after $http completes
                            notify({message: 'Attached successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                            $window.location.href = '#/volume/list';
                            $modalInstance.close();
                            $scope.list(1);
                        }).catch(function (result) {
                            if (!angular.isUndefined(result.data)) {
                                if (result.data.globalError != '' && !angular.isUndefined(result.data.globalError)) {
                                    var msg = result.data.globalError[0];
                                    notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                                } else if (result.data.fieldErrors != null) {
                                    angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                                        $scope.attachvolumeForm[key].$invalid = true;
                                        $scope.attachvolumeForm[key].errorMessage = errorMessage;
                                    });
                                }
                            }
                        });
                    }
                };
                $scope.cancel = function () {
                    $modalInstance.close();
                };
            }]);
    };

    // Detach Volume
    $scope.detach = function (size, volume) {
        $scope.volume = volume;
        dialogService.openDialog("app/views/cloud/volume/detach-volume.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
                $scope.instanceList = function () {
                    var hasinstanceList = crudService.listAll("virtualmachine/list");
                    hasinstanceList.then(function (result) {  // this is only run after $http completes0
                        $scope.instanceList = result;
                    });
                };
                $scope.instanceList();
                $scope.detachVolume = function (volume) {
                    console.log(volume);
                    var hasServer = crudService.add("volumes/detach/" + volume.id, volume);
                    hasServer.then(function (result) {  // this is only run after $http completes
                        notify({message: 'Detached successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                        $window.location.href = '#/volume/list';
                        $modalInstance.close();
                        $scope.list(1);
                    }).catch(function (result) {
                        if (!angular.isUndefined(result.data)) {
                            if (result.data.globalError != '' && !angular.isUndefined(result.data.globalError)) {
                                var msg = result.data.globalError[0];
                                notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                            } else if (result.data.fieldErrors != null) {
                                angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                                    $scope.attachvolumeForm[key].$invalid = true;
                                    $scope.attachvolumeForm[key].errorMessage = errorMessage;
                                });
                            }
                        }
                    });
                };
                $scope.cancel = function () {
                    $modalInstance.close();
                };
            }]);
    };

    // Creating snapshot
    $scope.createSnapshot = function (size, volume) {
        $scope.volume = volume;
        $scope.snapshot = {};
        setTimeout(function () {
            dialogService.openDialog("app/views/cloud/snapshot/download-snapshot.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
                    $scope.validateConfirmSnapshot = function (form) {
                        $scope.formSubmitted = true;
                        if (form.$valid) {
                            var snapshot = $scope.snapshot;
                            snapshot.volume = $scope.volume;
                            snapshot.zone = crudService.globalConfig.zone;
                            var hasServer = crudService.add("snapshots", snapshot);
                            hasServer.then(function (result) {
                                notify({message: 'Added successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                                $window.location = "#/snapshot/list";
                                $modalInstance.close();
                            }).catch(function (result) {
                                if (!angular.isUndefined(result) && result.data != null) {
                                    if (result.data.globalError[0] != '') {
                                        var msg = result.data.globalError[0];
                                        notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                                    }
                                    angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                                        $scope.confirmsnapshot[key].$invalid = true;
                                        $scope.confirmsnapshot[key].errorMessage = errorMessage;
                                    });
                                }
                            });
                        }
                    };
                    // Close the dialog box
                    $scope.cancel = function () {
                        $modalInstance.close();
                    };
                }]);
        }, 500);
    };

    $scope.openUploadVolumeContainer = function (size) {
        modalService.trigger('app/views/cloud/volume/upload.jsp', size);
    };

    $scope.openReccuringSnapshot = function (volume) {
        modalService.trigger('app/views/cloud/volume/recurring-snapshot.jsp', 'lg');
    };

    //Resize Volume
    $scope.resizeVolume = function (size, volume) {
        $scope.volume = volume;
        $scope.volume = angular.copy(volume);
        dialogService.openDialog($scope.global.VIEW_URL + "cloud/volume/resize.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
                $scope.diskList = function () {
                    var hasDisks = crudService.listAll("storages/list");
                    hasDisks.then(function (result) {  // this is only run after
                        // $http completes0
                        $scope.volumeElements.diskOfferingList = result;
                    });
                };
                $scope.diskList();

                var size= $scope.volume.diskSize  / $scope.global.Math.pow(2, 30);

                $scope.rsize= size;


                // Resize the Volume
                $scope.update = function (form, volume) {
                    $scope.formSubmitted = true;
                    if (form.$valid) {
                        $scope.volume.zone = $scope.global.zone;
                        var volume = $scope.volume;
                        var hasVolume = crudService.add("volumes/resize/" + volume.id, volume);
                        hasVolume.then(function (result) {
                            $scope.list(1);
                            notify({message: 'Updated successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
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

    //Create volume
    $scope.volume = {};
    $scope.volumeForm = {};
    $scope.addVolume = function (size) {
        dialogService.openDialog($scope.global.VIEW_URL + "cloud/volume/add.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope',
                                                                                                 function ($scope, $modalInstance, $rootScope) {

                $scope.diskList = function (tag) {
                    if (angular.isUndefined(tag)) {
                        tag = "";
                    }
                    	if(tag === null){
                    		tag = "";
                    	}
                    var hasDisks = crudService.listAllByTag("storages/storagesort", tag);
                    hasDisks.then(function (result) {  // this is only run after
                        // $http completes0
                        $scope.volumeElements.diskOfferingList = result;
                    });
                };

                $scope.diskTag = function () {
                    var hasDiskTags = crudService.listAll("storages/storagetags");
                    hasDiskTags.then(function (result) {  // this is only run after
                        // $http completes0

                        $scope.volumeElements.diskOfferingTags = result;
                    });
                };
                $scope.diskTag();

                $scope.$watch('volume.storageTags', function (val) {
                    $scope.diskList(val);
                });
                $scope.volume.name = "";
                $scope.volume.storageTags = "";
                $scope.volume.storageOffering = "";
                // Create a new application
                $scope.save = function (form, volume) {
                    $scope.formSubmitted = true;

                    if (form.$valid) {
                        $scope.volume.zone = $scope.global.zone;
                        var volume = $scope.volume;
                        var hasVolume = crudService.add("volumes", volume);
                        hasVolume.then(function (result) {
                            $scope.list(1);
                            notify({message: 'Added successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                            $modalInstance.close();
                        }).catch(function (result) {
 				if (!angular.isUndefined(result) && result.data != null) {
                                    if (result.data.globalError[0] != '') {
                                        var msg = result.data.globalError[0];
                                        notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                                    }
                            angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                                $scope.volumeForm[key].$invalid = true;
                                $scope.volumeForm[key].errorMessage = errorMessage;
                            });

				}
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
    $scope.download = function () {
        $scope.downloadLoding = true;
        $timeout($scope.downloadActions, 2000);

    };

    $scope.downloadLink = function (url) {
        $window.location.href = url;
        $scope.cancel();
    }

    $scope.downloadActions = function () {
        $scope.downloading = true;
        $scope.downloadLoding = false;

    };

    $scope.confirmSnapshot = function () {
        $scope.cancel();
        $window.location.href = '#volume/snapshot';
    };

    $scope.resetDiskValues = function (volumeType) {
        $scope.volume.type = volumeType;
        $scope.volume.storageOffering = null;
        $scope.volumeElements.storageOffering.diskSize.value = 0;
        $scope.volumeElements.storageOffering.iops.value = 0;
    };


 // Upload volume
//	$scope.volume = {};
//	$scope.volumeForm = {};
	$scope.uploadVolumeCtrl = function (size) {
		dialogService.openDialog($scope.global.VIEW_URL + "cloud/volume/upload.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope',
                                                                                                 function ($scope, $modalInstance, $rootScope) {
    $scope.global = globalConfig;
    // Form Field Decleration
    $scope.volume.name = "";
    $scope.volume.zone = "";
    $scope.volume.storageOffering = "";
    $scope.volume.format = "";
    $scope.volume.md5checksum = "";
    $scope.volume.url = "";

    $scope.formSubmitted = false;
    $scope.formElements = {
        formatList: {
          "0":"RAW",
       	  "1":"VHD",
       	  "2":"VHDX",
       	  "3":"OVA",
       	  "4":"QCOW2"
        }
    };

	$scope.zoneList = {};
	 $scope.zoneList = function () {
	               var hasZones = crudService.listAll("zones/list");
	               hasZones.then(function (result) {  // this is only run
														// after $http
														// completes0
	                       $scope.zoneList = result;
	console.log($scope.zoneList );

	                });
	            };
	            $scope.zoneList();

    $scope.diskList = {};
    $scope.diskList = function () {
                    var hasDisks = crudService.listAll("storages/list");
                    hasDisks.then(function (result) {  // this is only run after
                        // $http completes0
                        $scope.volumeElements.diskOfferingList = result;
                    });
                };
                $scope.diskList();

    $scope.uploadVolume = function (form, volume) {
        $scope.formSubmitted = true;
        if (form.$valid) {
             var volume = $scope.volume;
             if(volume.storageOffering == "") {
            	 delete volume.storageOffering;
             }
             if(volume.md5checksum == "") {
            	 delete volume.md5checksum;
             }
             var hasUploadVolume = crudService.add("volumes/upload", volume);
             hasUploadVolume.then(function (result) {
                 $scope.list(1);
                 $scope.homerTemplate = 'app/views/notification/notify.jsp';
                 notify({message: 'Uploaded successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
                 $modalInstance.close();
             }).catch(function (result) {
  				if (!angular.isUndefined(result) && result.data != null) {
                    if (result.data.globalError[0] != '') {
                        var msg = result.data.globalError[0];
                        notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                    }
            angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                $scope.volumeForm[key].$invalid = true;
                $scope.volumeForm[key].errorMessage = errorMessage;
            });

				}
                        });
                    }
                },
                $scope.cancel = function () {
                    $modalInstance.close();
                };
    }]);
};

//Upload volume from local
$scope.uploadVolumeFromLocalCtrl = function (size) {
	dialogService.openDialog($scope.global.VIEW_URL + "cloud/volume/upload.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope',
                                                                                             function ($scope, $modalInstance, $rootScope) {
$scope.global = globalConfig;
// Form Field Decleration


$scope.formSubmitted = false;
//$scope.formElements = {
//    formatList: [
//        {id: 1, name: 'RAW'},
//        {id: 2, name: 'VHD'},
//        {id: 3, name: 'VHDX'},
//        {id: 4, name: 'OVA'},
//        {id: 5, name: 'QCOW2'}
//    ]
//};

//
$scope.validateVolume = function (form, volume) {

    $scope.formSubmitted = true;
    if (form.$valid) {
    	 $scope.volume.zone = $scope.global.zone;
         var volume = $scope.volume;
         var hasUploadVolume = crudService.add("volumes", volume);
         hasUploadVolume.then(function (result) {
             $scope.list(1);
             $scope.homerTemplate = 'app/views/notification/notify.jsp';
             notify({message: 'Uploaded successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
             $modalInstance.close();
         }).catch(function (result) {
				if (!angular.isUndefined(result) && result.data != null) {
                if (result.data.globalError[0] != '') {
                    var msg = result.data.globalError[0];
                    notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                }
        angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
            $scope.volumeForm[key].$invalid = true;
            $scope.volumeForm[key].errorMessage = errorMessage;
        });

			}
                    });
                }
            },
            $scope.cancel = function () {
                $modalInstance.close();
            };
}]);
};

// Delete the Volume
$scope.delete = function (size, volume) {
    dialogService.openDialog("app/views/common/confirm-delete.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
            $scope.deleteObject = volume;
            $scope.ok = function (volume) {
                var hasServer = crudService.softDelete("volumes", volume);
                hasServer.then(function (result) {
                    $scope.list(1);
                    notify({message: 'Deleted successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                });
                $modalInstance.close();
            },
                    $scope.cancel = function () {
                        $modalInstance.close();
                    };
        }]);
};

};



function recurringSnapshotController($scope, globalConfig, localStorageService, $window, notify) {

    $scope.global = globalConfig;
    $scope.formSubmitted = false;
    // Form Field Decleration
    $scope.recurringSnapshot = {
        minutes: 60,
        hour: 12
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
        hourCount: new Array(12),
        minuteCount: new Array(60),
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
            noOfSnapshots: 1
        },
        {
            time: 1,
            dayOfWeek: "Day 1 of month",
            timeZone: {
                "id": 4,
                "name": "Pacific/Midwa"
            },
            noOfSnapshots: 1
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

    $scope.save = function (form) {
        $scope.formSubmitted = true;
        if (form.$valid) {
            $scope.snapshotList.push($scope.recurringSnapshot);
        }
    };
}


