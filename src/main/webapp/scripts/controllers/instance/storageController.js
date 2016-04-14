/**
 *
 * storageCtrl
 *
 */
angular.module('homer').controller('storageCtrl', storageCtrl)

function storageCtrl($scope, $state, $stateParams, appService, $window, volumeService) {
    $scope.global = appService.globalConfig;
        appService.globalConfig.webSocketLoaders.vmstorageLoader = false;
    $scope.formSubmitted = false;
    // Form Field Decleration
    $scope.volume = {};
    $scope.volumeList = [];
    $scope.paginationObject = {};
    $scope.storageForm = {};
    $scope.volumeElement = {};
    // Load domain
    $scope.domain = {};
    var hasDomains = appService.crudService.listAll("domains/list");
    hasDomains.then(function(result) {
        $scope.volumeElement.domainList = result;
    });
    // Department list load based on the domain
    $scope.domainChange = function() {
        if (!angular.isUndefined($scope.volume.domain)) {
            var hasDisks = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "storages/listbydomain?domainId=" + $scope.volume.domain.id);
            hasDisks.then(function(result) { // this is only run after $http completes0
                $scope.volumeElements.diskOfferingList = result;
            });
        }
    };
    // Volume List
    $scope.list = function(volume) {
        var instanceId = $stateParams.id;
        var hasVolumes = appService.promiseAjax.httpTokenRequest(appService.crudService.globalConfig.HTTP_GET, appService.crudService.globalConfig.APP_URL + "volumes/listbyinstances?instanceid=" + instanceId + "&lang=" + appService.localStorageService.cookie.get('language') + "&sortBy=-id");
        hasVolumes.then(function(result) {
            $scope.volumeList = result;
        });
    };
    $scope.list(1);
    $scope.listVm = function(volume) {
        var instanceId = $stateParams.id;
        var hasInstance = appService.crudService.read("virtualmachine", instanceId);
        hasInstance.then(function(result) {
            $scope.instance = result;
            $scope.instanceName = result.name;
        });
    };
    $scope.listVm(1);
    // Attach Volume
    $scope.attach = function(size, volume) {
        $scope.volume = volume;
        appService.dialogService.openDialog("app/views/cloud/instance/attach-volume.jsp", size, $scope, ['$scope', '$modalInstance', function($scope, $modalInstance) {
            // instance List
            $scope.volumeList = function(instance) {
                if ($scope.instance.projectId != null) {
                    // var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
                    var hasVolumes = appService.promiseAjax.httpTokenRequest(appService.crudService.globalConfig.HTTP_GET, appService.crudService.globalConfig.APP_URL + "volumes" + "/instance/project/" + $scope.instance.projectId);
                    hasVolumes.then(function(result) {
                        $scope.volumeList = result;
                    });
                } else {
                    var hasVolumes = appService.promiseAjax.httpTokenRequest(appService.crudService.globalConfig.HTTP_GET, appService.crudService.globalConfig.APP_URL + "volumes" + "/instance/department/" + $scope.instance.departmentId);
                    hasVolumes.then(function(result) {
                        $scope.volumeList = result;
                    });
                }
            };
            $scope.volumeList(1);
            $scope.attachVolume = function(form, volume) {
                volume.vmInstanceId = $stateParams.id;
                $scope.formSubmitted = true;
                if (form.$valid) {
                    $scope.showLoader = true;
                    if (!angular.isUndefined(volume.vmInstance) && volume.vmInstance != null) {
                        volume.vmInstanceId = volume.vmInstance.id;
                        delete volume.vmInstance;
                    }
                    if (!angular.isUndefined(volume.storageOffering) && volume.storageOffering != null) {
                        volume.storageOfferingId = volume.storageOffering.id;
                        delete volume.storageOffering;
                    }
                    if (!angular.isUndefined(volume.department) && volume.department != null) {
                        volume.departmentId = volume.department.id;
                        delete volume.department;
                    }
                    if (!angular.isUndefined(volume.project) && volume.project != null) {
                        volume.projectId = volume.project.id;
                        delete volume.project;
                    }
                    if (!angular.isUndefined(volume.zone) && volume.zone != null) {
                        volume.zoneId = volume.zone.id;
                        delete volume.zone;
                    }
                    appService.globalConfig.webSocketLoaders.vmstorageLoader = true;
		    $modalInstance.close(); 
                    var hasServer = appService.crudService.add("volumes/attach/" + volume.id, volume);
                    hasServer.then(function(result) { // this is only run after $http completes
                        $scope.showLoader = false;
                    }).catch(function(result) {
                        if (!angular.isUndefined(result.data)) {
                            if (result.data.fieldErrors != null) {
                                angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                                    $scope.attachvolumeForm[key].$invalid = true;
                                    $scope.attachvolumeForm[key].errorMessage = errorMessage;
                                });
                            }
                        }
                        appService.globalConfig.webSocketLoaders.vmstorageLoader = false;
                    });
                }
            };
            $scope.cancel = function() {
                $modalInstance.close();
            };
        }]);
    };
    // Detach Volume
    $scope.detach = function(size, volume) {
        $scope.volume = volume;
        appService.dialogService.openDialog("app/views/cloud/volume/detach-volume.jsp", size, $scope, ['$scope', '$modalInstance', function($scope, $modalInstance) {
            $scope.instanceList = function() {
                var hasinstanceList = appService.crudService.listAll("virtualmachine/list");
                hasinstanceList.then(function(result) { // this is only run after $http completes0
                    $scope.instanceList = result;
                });
            };
            $scope.instanceList();
            $scope.detachVolume = function(volume) {
                $scope.showLoader = true;
                if (!angular.isUndefined(volume.vmInstance) && volume.vmInstance != null) {
                    volume.vmInstanceId = volume.vmInstance.id;
                    delete volume.vmInstance;
                }
                if (!angular.isUndefined(volume.storageOffering) && volume.storageOffering != null) {
                    volume.storageOfferingId = volume.storageOffering.id;
                    delete volume.storageOffering;
                }
                if (!angular.isUndefined(volume.department) && volume.department != null) {
                    volume.departmentId = volume.department.id;
                    delete volume.department;
                }
                if (!angular.isUndefined(volume.project) && volume.project != null) {
                    volume.projectId = volume.project.id;
                    delete volume.project;
                }
                if (!angular.isUndefined(volume.zone) && volume.zone != null) {
                    volume.zoneId = volume.zone.id;
                    delete volume.zone;
                }
 		$modalInstance.close();
                appService.globalConfig.webSocketLoaders.vmstorageLoader = true;
                var hasServer = appService.crudService.add("volumes/detach/" + volume.id, volume);
                hasServer.then(function(result) { // this is only run after $http completes
                    $scope.showLoader = false;
                }).catch(function(result) {
                    if (!angular.isUndefined(result.data)) {
                        if (result.data.fieldErrors != null) {
                            angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                                $scope.attachvolumeForm[key].$invalid = true;
                                $scope.attachvolumeForm[key].errorMessage = errorMessage;
                            });
                        }
                    }
                    appService.globalConfig.webSocketLoaders.vmstorageLoader = false;
                });
            };
            $scope.cancel = function() {
                $modalInstance.close();
            };
        }]);
    };
    // Creating snapshot
    $scope.createSnapshot = function(size, volume) {
        $scope.volume = volume;
        $scope.snapshot = {};
        setTimeout(function() {
            appService.dialogService.openDialog("app/views/cloud/snapshot/download-snapshot.jsp", size, $scope, ['$scope', '$modalInstance', function($scope, $modalInstance) {
                $scope.validateConfirmSnapshot = function(form) {
                    $scope.formSubmitted = true;
                    if (form.$valid) {
                        var snapshot = $scope.snapshot;
                        snapshot.volume = $scope.volume;
                        snapshot.zone = appService.crudService.globalConfig.zone;
                        var hasServer = appService.crudService.add("snapshots", snapshot);
                        hasServer.then(function(result) {
                            $modalInstance.close();
                        }).catch(function(result) {
                            if (!angular.isUndefined(result.data) && result.data.fieldErrors != null) {
                                angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                                    $scope.confirmsnapshot[key].$invalid = true;
                                    $scope.confirmsnapshot[key].errorMessage = errorMessage;
                                });
                            }
                        });
                    }
                };
                // Close the dialog box
                $scope.cancel = function() {
                    $modalInstance.close();
                };
            }]);
        }, 500);
    };
    $scope.openUploadVolumeContainer = function(size) {
        appService.modalService.trigger('app/views/cloud/volume/upload.jsp', size);
    };
    $scope.openReccuringSnapshot = function(volume) {
        appService.modalService.trigger('app/views/cloud/volume/recurring-snapshot.jsp', 'lg');
    };
    //Resize Volume
    $scope.resizeVolume = function(size, volume) {
        $scope.volume = volume;
        $scope.volume = angular.copy(volume);
        appService.dialogService.openDialog($scope.global.VIEW_URL + "cloud/volume/resize.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
            $scope.diskList = function() {
                var hasDisks = appService.crudService.listAll("storages/list");
                hasDisks.then(function(result) { // this is only run after
                    // $http completes0
                    $scope.volumeElements.diskOfferingList = result;
                });
            };
            $scope.diskList();
            var size = $scope.volume.diskSize / $scope.global.Math.pow(2, 30);
            $scope.rsize = size;
            // Resize the Volume
            $scope.update = function(form, volume) {
                    $scope.formSubmitted = true;
                    if (form.$valid) {
                        $scope.showLoader = true;
                        $scope.volume.zone = $scope.global.zone;
                        var volume = $scope.volume;
                        var hasVolume = appService.crudService.add("volumes/resize/" + volume.id, volume);
                        hasVolume.then(function(result) {
                            $scope.showLoader = false;
                            $modalInstance.close();
                        }).catch(function(result) {
                            if (!angular.isUndefined(result.data)) {
                                if (result.data.fieldErrors != null) {
                                    angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                                        $scope.attachvolumeForm[key].$invalid = true;
                                        $scope.attachvolumeForm[key].errorMessage = errorMessage;
                                    });
                                }
                            }
                        });
                    }
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };
    $scope.getDiskList = {};
    $scope.getDiskList = function(domainId, tag) {
        var hasDisks = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "storages/storagesort?tags=" + tag + "&domainId=" + domainId);
        hasDisks.then(function(result) { // this is only run after
            // $http completes0
            $scope.volumeElements.diskOfferingList = result;
        });
    };
    //Create volume
    $scope.volume = {};
    $scope.volumeForm = {};
    $scope.addVolume = function(size) {
        $scope.volume = {};
        $scope.volume.project = $scope.projects;
        $scope.volume.department = $scope.departments;
        if ($scope.global.sessionValues.type === 'USER') {
            var hasDepartments = appService.crudService.read("departments", $scope.global.sessionValues.departmentId);
            hasDepartments.then(function(result) {
                $scope.volume.department = result;
            });
        }
        appService.dialogService.openDialog($scope.global.VIEW_URL + "cloud/instance/add-volume.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope',
            function($scope, $modalInstance, $rootScope) {
                $scope.diskList = function(tag) {
                    if (angular.isUndefined(tag)) {
                        tag = "";
                    }
                    if (tag === null) {
                        tag = "";
                    }
                    $scope.volumeElements.diskOfferingList = {};
                    if ($scope.global.sessionValues.type !== 'ROOT_ADMIN' && !angular.isUndefined($scope.global.sessionValues.domainId)) {
                        $scope.getDiskList($scope.global.sessionValues.domainId, tag);
                    } else if (!angular.isUndefined($scope.instance.domain)) {
                        $scope.getDiskList($scope.instance.domain.id, tag);
                    }
                };
                $scope.diskTag = function() {
                    var hasDiskTags = appService.crudService.listAll("storages/storagetags");
                    hasDiskTags.then(function(result) { // this is only run after
                        // $http completes0
                        $scope.volumeElements.diskOfferingTags = result;
                    });
                };
                $scope.diskTag();
                $scope.$watch('volume.storageTags', function(val) {
                    $scope.diskList(val);
                });
                //                $scope.project = {};
                //                $scope.projectList = function() {
                //                    var hasProjects = appService.promiseAjax.httpTokenRequest(appService.crudService.globalConfig.HTTP_GET, appService.crudService.globalConfig.APP_URL + "projects");
                //                    hasProjects.then(function(result) { // this is only run after $http completes0
                //                        $scope.options = result;
                //                    });
                //                };
                // Get current Department list from instnace id.
                $scope.department = {};
                var hasDepartment = appService.crudService.read("departments", $scope.instance.instanceOwner.departmentId);
                hasDepartment.then(function(result) { // this is only run after $http completes0
                    $scope.volumeElements.departmentList = result;
                });
                // Getting list of projects by department
                $scope.project = {};
                if (angular.isUndefined($scope.instance.projectId) && $scope.instance.projectId != null) {
                    var hasProjects = appService.crudService.read("projects", $scope.instance.projectId);
                    hasProjects.then(function(result) { // this is only run after
                        // $http completes0
                        $scope.options = result;
                    });
                }
                // Create a new application
                $scope.save = function(form, volume) {
                        $scope.formSubmitted = true;
                        if (form.$valid) {
                            $scope.showLoader = true;
                            $scope.volume.zone = $scope.global.zone;
                            var volume = angular.copy($scope.volume);
                            if (!angular.isUndefined($scope.volume.storageOffering) && volume.storageOffering != null) {
                                volume.storageOfferingId = volume.storageOffering.id;
                                if (!volume.storageOffering.isCustomDisk) {
                                    delete volume.diskSize;
                                }
                                delete volume.storageOffering;
                            }
                            if (!angular.isUndefined($scope.volume.department) && volume.department != null) {
                                volume.departmentId = volume.department.id;
                                delete volume.department;
                            }
                            if (!angular.isUndefined($scope.volume.project) && volume.project != null) {
                                volume.projectId = volume.project.id;
                                delete volume.project;
                            }
                            if (!angular.isUndefined($scope.volume.zone) && volume.zone != null) {
                                volume.zoneId = volume.zone.id;
                                delete volume.zone;
                            }
			    
                            appService.globalConfig.webSocketLoaders.vmstorageLoader = true;
                            $modalInstance.close();	
                            var hasVolume = appService.crudService.add("volumes", volume);
                            hasVolume.then(function(result) {
                                $scope.showLoader = false;
                            }).catch(function(result) {
                                $scope.showLoader = false;
                                if (!angular.isUndefined(result.data)) {
                                    if (result.data.fieldErrors != null) {
                                        $scope.showLoader = false;
                                        angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                                            $scope.volumeForm[key].$invalid = true;
                                            $scope.volumeForm[key].errorMessage = errorMessage;
                                        });
                                    }
                                }
                                appService.globalConfig.webSocketLoaders.vmstorageLoader = false;
                            });;
                        }
                    },
                    $scope.cancel = function() {
                        $modalInstance.close();
                    };
            }
        ]);
    };
    $scope.volumeElements = volumeService.volumeElements;
    $scope.downloads = false;
    $scope.download = function() {
        $scope.downloadLoding = true;
        $timeout($scope.downloadActions, 2000);
    };
    $scope.downloadLink = function(url) {
        $window.location.href = url;
        $scope.cancel();
    }
    $scope.downloadActions = function() {
        $scope.downloading = true;
        $scope.downloadLoding = false;
    };
    $scope.confirmSnapshot = function() {
        $scope.cancel();
        $window.location.href = '#volume/snapshot';
    };
    $scope.resetDiskValues = function(volumeType) {
        $scope.volume.type = volumeType;
        $scope.volume.storageOffering = null;
        $scope.volumeElements.storageOffering.diskSize.value = 0;
        $scope.volumeElements.storageOffering.iops.value = 0;
    };
    // Upload volume
    $scope.uploadVolumeCtrl = function(size) {
        appService.dialogService.openDialog($scope.global.VIEW_URL + "cloud/volume/upload.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope',
            function($scope, $modalInstance, $rootScope) {
                $scope.global = appService.globalConfig;
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
                        "0": "RAW",
                        "1": "VHD",
                        "2": "VHDX",
                        "3": "OVA",
                        "4": "QCOW2"
                    }
                };
                $scope.zoneList = {};
                $scope.zoneList = function() {
                    var hasZones = appService.crudService.listAll("zones/list");
                    hasZones.then(function(result) {
                        $scope.zoneList = result;
                    });
                };
                $scope.zoneList();
                //                $scope.diskList = {};
                //                $scope.diskList = function() {
                //                    var hasDisks = appService.crudService.listAll("storages/list");
                //                    hasDisks.then(function(result) { // this is only run after
                //                        // $http completes0
                //                        $scope.volumeElements.diskOfferingList = result;
                //                    });
                //                };
                //                $scope.diskList();
                if ($scope.global.sessionValues.type !== 'ROOT_ADMIN') {
                    if (!angular.isUndefined($scope.global.sessionValues.domainId)) {
                        var hasDisks = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "storages/listbydomain?domainId=" + $scope.global.sessionValues.domainId);
                        hasDisks.then(function(result) { // this is only run after $http completes0
                            $scope.volumeElements.diskOfferingList = result;
                        });
                    }
                }
                $scope.uploadVolume = function(form, volume) {
                        $scope.formSubmitted = true;
                        if (form.$valid) {
                            $scope.showLoader = true;
                            var volume = $scope.volume;
                            if (volume.storageOffering == "") {
                                delete volume.storageOffering;
                            }
                            if (volume.md5checksum == "") {
                                delete volume.md5checksum;
                            }
                            var volume = angular.copy($scope.volume);
                            if (!angular.isUndefined(volume.storageOffering) && volume.storageOffering != null) {
                                volume.storageOfferingId = volume.storageOffering.id;
                                delete volume.storageOffering;
                            }
                            if (!angular.isUndefined(volume.zone) && volume.zone != null) {
                                volume.zoneId = volume.zone.id;
                                delete volume.zone;
                            }
                            var hasUploadVolume = appService.crudService.add("volumes/upload", volume);
                            hasUploadVolume.then(function(result) {
                                $scope.showLoader = false;
                                $modalInstance.close();
                            }).catch(function(result) {
                                if (!angular.isUndefined(result) && result.data != null) {
                                    angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                                        $scope.volumeForm[key].$invalid = true;
                                        $scope.volumeForm[key].errorMessage = errorMessage;
                                    });
                                }
                            });
                        }
                    },
                    $scope.cancel = function() {
                        $modalInstance.close();
                    };
            }
        ]);
    };
    //Upload volume from local
    $scope.uploadVolumeFromLocalCtrl = function(size) {
        appService.dialogService.openDialog($scope.global.VIEW_URL + "cloud/volume/upload.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope',
            function($scope, $modalInstance, $rootScope) {
                $scope.global = appService.globalConfig;
                // Form Field Decleration
                $scope.formSubmitted = false;
                $scope.validateVolume = function(form, volume) {
                        $scope.formSubmitted = true;
                        if (form.$valid) {
                            $scope.volume.zone = $scope.global.zone;
                            var volume = $scope.volume;
                            var hasUploadVolume = appService.crudService.add("volumes", volume);
                            hasUploadVolume.then(function(result) {
                                $scope.list(1);
                                $scope.homerTemplate = 'app/views/notification/notify.jsp';
                                appService.notify({
                                    message: 'Uploaded successfully',
                                    classes: 'alert-success',
                                    templateUrl: $scope.homerTemplate
                                });
                                $modalInstance.close();
                            }).catch(function(result) {
                                if (!angular.isUndefined(result.data) && result.data.fieldErrors != null) {
                                    angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                                        $scope.volumeForm[key].$invalid = true;
                                        $scope.volumeForm[key].errorMessage = errorMessage;
                                    });
                                }
                            });
                        }
                    },
                    $scope.cancel = function() {
                        $modalInstance.close();
                    };
            }
        ]);
    };
    // Delete the Volume
    $scope.delete = function(size, volume) {
        appService.dialogService.openDialog("app/views/common/confirm-delete.jsp", size, $scope, ['$scope', '$modalInstance', function($scope, $modalInstance) {
            $scope.deleteObject = volume;
            $scope.ok = function(volume) {
                    $scope.showLoader = true;
                    if (!angular.isUndefined(volume.domain) && volume.domain != null) {
                        volume.domainId = volume.domain.id;
                        delete volume.domain;
                    }
                    if (!angular.isUndefined(volume.storageOffering) && volume.storageOffering != null) {
                        volume.storageOfferingId = volume.storageOffering.id;
                        delete volume.storageOffering;
                    }
                    if (!angular.isUndefined(volume.department) && volume.department != null) {
                        volume.departmentId = volume.department.id;
                        delete volume.department;
                    }
                    if (!angular.isUndefined(volume.project) && volume.project != null) {
                        volume.projectId = volume.project.id;
                        delete volume.project;
                    }
                    if (!angular.isUndefined(volume.zone) && volume.zone != null) {
                        volume.zoneId = volume.zone.id;
                        delete volume.zone;
                    }
                    volume.id = deleteObject.id;
                    var hasServer = appService.crudService.softDelete("volumes", volume);
                    hasServer.then(function(result) {
                        $scope.showLoader = false;
                    }).catch(function(){
			appService.globalConfig.webSocketLoaders.vmstorageLoader = false;
			$scope.showLoader = false;
        	    });
                    $modalInstance.close();
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };
    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.attachVolume, function(event, args) {
        appService.globalConfig.webSocketLoaders.vmstorageLoader = false;
        $scope.list(1);
    });
    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.detachVolume, function(event, args) {
        appService.globalConfig.webSocketLoaders.vmstorageLoader = false;
        $scope.list(1);
    });
    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.createSnapshot, function(event, args) {
        appService.globalConfig.webSocketLoaders.vmstorageLoader = false;
        $scope.list(1);
        $window.location = "#/snapshot/list";
    });
    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.volumeresize, function(event, args) {
        appService.globalConfig.webSocketLoaders.vmstorageLoader = false;
        $scope.list(1);
    });
    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.volumesave, function(event, args) {
        appService.globalConfig.webSocketLoaders.vmstorageLoader = false;
        $scope.list(1);
    });
    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.uploadVolume, function(event, args) {
        appService.globalConfig.webSocketLoaders.vmstorageLoader = false;
        $scope.list(1);
     });
    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.volumedelete, function(event, args) {
        appService.globalConfig.webSocketLoaders.vmstorageLoader = false;
        $scope.list(1);
    });
    $scope.$on("Volume", function(event, args) {
            if(args.status == 'FAILED'){
	    	appService.globalConfig.webSocketLoaders.vmstorageLoader = false;
        	$scope.list(1);
	    } else {
                appService.globalConfig.webSocketLoaders.vmstorageLoader = false;
        	$scope.list(1);
            }
        });


    // API for storage

    /**
     * Data for Line chart
     */
    function getDateByTime(unixTimeStamp) {
        var date = new Date(unixTimeStamp*1000);
        return date;
    }



    function updateStorageProgeress(volumeList) {
        //angular.forEach(volumeList, function(obj, key) {
            //getStoragePerformanceByFilters(obj.vmInstance.displayName, obj, 0, "/");
            //getStoragePerformanceByFilters(obj.vmInstance.displayName, obj, 1, "/home2");
           // setInterval(function() {
                //$scope.$apply(function () {
                    //getStoragePerformanceByFilters(obj.vmInstance.displayName, obj, 0, "/");
                    //getStoragePerformanceByFilters(obj.vmInstance.displayName, obj, 1, "/home2");
                //});
           // }, 5000);
       // });

    }
    $scope.memoryStyle = [];
    $scope.rootUsage = [];


    function getStoragePerformanceByFilters(vmName, volume, index, mountPoint) {

        vmName = 'monitor-vm';
        var diskSize = 0;
        if(volume.volumeType == 'ROOT' || (volume.volumeType == 'DATADISK' && volume.storageOffering.isCustomDisk)) {
            diskSize = volume.diskSize /  $scope.global.Math.pow(2, 30);
        } else {
            diskSize = volume.storageOffering.diskSize;
        }

        $scope.homeUsage = "";
        var bytesFormulaValue = 1073741824;

        var hasServer = appService.promiseAjax.httpRequest("GET", "http://192.168.1.137:4242/api/query?start=1m-ago&m=sum:linux.disk.fs.space_used{host=" + vmName + ",mount=" + mountPoint + "}");
        hasServer.then(function (result) {
            /*for(var i=0; i < result.length; i++ ) {
                var dataPoints = result[i].dps;
                var dataIndex = 0;
                var currentValue = dataPoints[Object.keys(dataPoints)[Object.keys(dataPoints).length - 1]];
                if(!angular.isUndefined(currentValue) && currentValue != 0) {
                    currentValue = currentValue / (1024 * 1024 * 1024);
                    var usedTotal = (currentValue.toFixed(2) / 3.9) * 100;
                    $scope.memoryStyle = {
                        width : parseInt(usedTotal) + "%"
                    };
                    $scope.usedSpace = usedTotal.toFixed(2);

                }
            }*/

            var usedMemory = "";
            angular.forEach(result[0].dps, function(val, index) {
                usedMemory = val;
            });

            $scope.rootUsage[index] = ((usedMemory / bytesFormulaValue) / 3.9 * 100).toFixed(2);
            $scope.memoryStyle[index] = {
                width : parseInt($scope.rootUsage[index]) + "%"
            };

        });
    }
};
