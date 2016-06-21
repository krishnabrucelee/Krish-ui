angular.module('homer').controller('addVMSnapshotCtrl', addVMSnapshotCtrl).controller('addSnapshotCtrl', addSnapshotCtrl).controller('addConfirmSnapshotCtrl', addConfirmSnapshotCtrl).controller('snapshotListCtrl', snapshotListCtrl)

function addConfirmSnapshotCtrl($scope, globalConfig, $window, appService, notify) {
    $scope.global = globalConfig;
    // Form Field Decleration
    $scope.confirmsnapshot = {};
    $scope.formSubmitted = false;
}

function addSnapshotCtrl($scope, appService, crudService, dialogService, globalConfig, $window, notify) {
    $scope.global = globalConfig;
    // Form Field Decleration
    $scope.snapshot = {};
    $scope.formSubmitted = false
}

function addVMSnapshotCtrl($scope, globalConfig, $window, appService, notify) {
   $scope.global = appService.globalConfig;
	 appService.globalConfig.webSocketLoaders.snapshotLoader = false;
    // Form Field Decleration
    $scope.vmsnapshot = {};
    $scope.formSubmitted = false;
    /* $scope.formElements = {
         instanceList: [
             {id: 1, name: 'North China'},
             {id: 2, name: 'South central china'}

         ]

      };*/
    $scope.validateVMSnapshot = function(form) {
        $scope.formSubmitted = true;
        if (form.$valid) {
            $scope.cancel();
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            notify({
                message: 'VM Snapshot created',
                classes: 'alert-success',
                templateUrl: $scope.homerTemplate
            });
        }
    };

    $scope.validateDeleteSnapshot = function(form) {
        $scope.formSubmitted = true;
        if (form.$valid) {
            $scope.cancel();
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            notify({
                message: 'Deleted successfully',
                classes: 'alert-success',
                templateUrl: $scope.homerTemplate
            });
        }
    };
};

function snapshotListCtrl($scope, crudService, $state, $timeout, promiseAjax, globalConfig, localStorageService, $window, dialogService, $stateParams, notify, appService) {
    $scope.confirmsnapshot = {};
    $scope.paginationObject = {};
    $scope.paginationObjects = {};
    $scope.global = globalConfig;
    $scope.global = crudService.globalConfig;
    $scope.global = appService.globalConfig;
	appService.globalConfig.webSocketLoaders.snapshotLoader = false;
        appService.globalConfig.webSocketLoaders.volumeBackupLoader = false;
    $scope.snapshotList = {};
    $scope.vmSnapshotList = {};
    $scope.instanceList = {};
    $scope.sort = appService.globalConfig.sort;
    $scope.changeSorting = appService.utilService.changeSorting;
    $scope.paginationObject.sortOrder = '+';
    $scope.paginationObject.sortBy = 'name';
    $scope.changeSort = function(sortBy, pageNumber) {
        var sort = appService.globalConfig.sort;
        if (sort.column == sortBy) {
            sort.descending = !sort.descending;
        } else {
            sort.column = sortBy;
            sort.descending = false;
        }
        var sortOrder = '-';
        if (!sort.descending) {
            sortOrder = '+';
        }
        $scope.paginationObject.sortOrder = sortOrder;
        $scope.paginationObject.sortBy = sortBy;
        $scope.showLoader = true;
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasSnapshotLists = {};
        if ($scope.domainId == null && ($scope.snapshotSearch == null
        		|| angular.isUndefined($scope.snapshotSearch) || $scope.snapshotSearch == '')) {
        	var hasSnapshotLists = appService.promiseAjax.httpTokenRequest(globalConfig.HTTP_GET, globalConfig.APP_URL + "snapshots/listView" + "?lang=" + localStorageService.cookie.get('language') + "&sortBy=" + sortOrder + sortBy + "&limit=" + limit, $scope.global.paginationHeaders(pageNumber, limit), {
                "limit": limit
            });
        }
		else {
            if ($scope.domainId != null && $scope.snapshotSearch == null) {
                $scope.filter = "&domainId=" + $scope.domainId + "&searchText=";
            }  else if ($scope.domainId == null && $scope.snapshotSearch != null) {
                $scope.filter = "&domainId=0" + "&searchText=" + $scope.snapshotSearch;
            } else  {
                $scope.filter = "&domainId=" + $scope.domainId + "&searchText=" + $scope.snapshotSearch;
            }
            hasSnapshotLists =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "snapshots/listByDomain"+"?lang=" +appService.localStorageService.cookie.get('language')+ encodeURI($scope.filter) +"&sortBy="+$scope.paginationObject.sortOrder +$scope.paginationObject.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
        }
        hasSnapshotLists.then(function(result) { // this is only run after $http
            // completes0
            $scope.snapshotList = result;
            $scope.snapshotList.Count = 0;
            if (result.length != 0) {
                $scope.snapshotList.Count = result.totalItems;
            }
            // For pagination
            $scope.paginationObject.limit = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
            $scope.paginationObject.sortOrder = sortOrder;
            $scope.paginationObject.sortBy = sortBy;
            $scope.showLoader = false;
        });
    };

    $scope.changeSorts = function(sortBy, pageNumber) {
        var sort = appService.globalConfig.sort;
        if (sort.column == sortBy) {
            sort.descending = !sort.descending;
        } else {
            sort.column = sortBy;
            sort.descending = false;
        }
        var sortOrder = '-';
        if (!sort.descending) {
            sortOrder = '+';
        }
        $scope.paginationObject.sortOrder = sortOrder;
        $scope.paginationObject.sortBy = sortBy;
        $scope.showLoader = true;
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasSnapshotLists = {};
        if ($scope.domainId == null && $scope.vmSearch == null) {
        	var hasSnapshotLists = appService.promiseAjax.httpTokenRequest(globalConfig.HTTP_GET, globalConfig.APP_URL + "vmsnapshot/listView" + "?lang=" + localStorageService.cookie.get('language') + "&sortBy=" + sortOrder + sortBy + "&limit=" + limit, $scope.global.paginationHeaders(pageNumber, limit), {
                "limit": limit
            });
        }
		else {
            if ($scope.domainId != null && $scope.vmSearch == null) {
                $scope.filter = "&domainId=" + $scope.domainId + "&searchText=";
            }  else if ($scope.domainId == null && $scope.vmSearch != null) {
                $scope.filter = "&domainId=0" + "&searchText=" + $scope.vmSearch;
            } else  {
                $scope.filter = "&domainId=" + $scope.domainId + "&searchText=" + $scope.vmSearch;
            }
            hasSnapshotLists =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "vmsnapshot/listByDomain"+"?lang=" +appService.localStorageService.cookie.get('language')+ encodeURI($scope.filter) +"&sortBy="+$scope.paginationObject.sortOrder +$scope.paginationObject.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
        }
        hasSnapshotLists.then(function(result) { // this is only run after $http
            // completes0
        	$scope.vmSnapshotList = result;
            $scope.vmSnapshotList.Count = 0;
            if (result.length != 0) {
                $scope.vmSnapshotList.Count = result.totalItems;
            }
            // For pagination
            $scope.paginationObject.limit = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
            $scope.paginationObject.sortOrder = sortOrder;
            $scope.paginationObject.sortBy = sortBy;
            $scope.showLoader = false;
        });
    };

    $scope.list = function(pageNumber) {
        appService.globalConfig.sort.sortOrder = $scope.paginationObject.sortOrder;
        appService.globalConfig.sort.sortBy = $scope.paginationObject.sortBy;
        $scope.showLoader = true;
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? crudService.globalConfig.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasSnapshot = {};
        if ($scope.domainId == null && $scope.snapshotSearch == null) {
        	var hasSnapshot = crudService.list("snapshots/listView", crudService.globalConfig.paginationHeaders(pageNumber, limit), {
                "limit": limit
            });
        }
		else {
            if ($scope.domainId != null && $scope.snapshotSearch == null) {
                $scope.filter = "&domainId=" + $scope.domainId + "&searchText=";
            }  else if ($scope.domainId == null && $scope.snapshotSearch != null) {
                $scope.filter = "&domainId=0" + "&searchText=" + $scope.snapshotSearch;
            } else  {
                $scope.filter = "&domainId=" + $scope.domainId + "&searchText=" + $scope.snapshotSearch;
            }
            hasSnapshot =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "snapshots/listByDomain"+"?lang=" +appService.localStorageService.cookie.get('language')+ encodeURI($scope.filter) +"&sortBy="+globalConfig.sort.sortOrder+globalConfig.sort.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
        }
        hasSnapshot.then(function(result) {
            $scope.showLoader = false;
            $scope.snapshotList = result;
            $scope.snapshotList.Count = 0;
            if (result.length != 0) {
                $scope.snapshotList.Count = result.totalItems;
            }
            // For pagination
            $scope.paginationObject.limit = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
        });
    }
    $scope.list(1);

    $scope.snapshotSearch = null;
    $scope.snapshotSearchList = function(snapshotSearch) {
        $scope.snapshotSearch = snapshotSearch;
        $scope.list(1);
    };

	$scope.vmSearch = null;
    $scope.searchList = function(vmSearch) {
        $scope.vmSearch = vmSearch;
        $scope.lists(1);
    };

    $scope.lists = function(pageNumber) {
        $scope.showLoaderOffer = true;
        var limit = (angular.isUndefined($scope.paginationObjects.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObjects.limit;
        var hasSnapshots = {};
        if ($scope.domainId == null && $scope.vmSearch == null) {
          	hasSnapshots = appService.crudService.list("vmsnapshot/listView", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
        }
		else {
            if ($scope.domainId != null && $scope.vmSearch == null) {
                $scope.filter = "&domainId=" + $scope.domainId + "&searchText=";
            }  else if ($scope.domainId == null && $scope.vmSearch != null) {
                $scope.filter = "&domainId=0" + "&searchText=" + $scope.vmSearch;
            } else  {
                $scope.filter = "&domainId=" + $scope.domainId + "&searchText=" + $scope.vmSearch;
            }
    		hasSnapshots =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "vmsnapshot/listByDomain"+"?lang=" +appService.localStorageService.cookie.get('language')+ encodeURI($scope.filter) +"&sortBy="+globalConfig.sort.sortOrder+globalConfig.sort.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
        }
        hasSnapshots.then(function(result) { // this is only run after
            // $http completes0
            $scope.showLoaderOffer = false;
            $scope.vmSnapshotList = result;
            $scope.vmSnapshotList.Count = 0;
            if (result.length != 0) {
                $scope.vmSnapshotList.Count = result.totalItems;
            }
            // For pagination
            $scope.paginationObjects.limit = limit;
            $scope.paginationObjects.currentPage = pageNumber;
            $scope.paginationObjects.totalItems = result.totalItems;
        });
    };
    $scope.lists(1);

    // Get domain list
    var hasdomainListView = appService.crudService.listAll("domains/list");
    hasdomainListView.then(function(result) {
        $scope.domainListView = result;
    });
    // Get project list based on domain selection
    $scope.domainId = null;
    $scope.selectDomainView = function(pageNumber,domainId) {
        $scope.domainId = domainId;
        $scope.lists(1);
    };

    $scope.domainId = null;
    $scope.selectSnapshotDomainView = function(pageNumber,domainId) {
        $scope.domainId = domainId;
        $scope.list(1);
    };

    $scope.instanceList = {};
    $scope.instanceId = function(pageNumber) {
        var hasUsers = crudService.listByQuery("virtualmachine/list");
        hasUsers.then(function(result) { // this is only run after $http
            // completes0
            $scope.instanceList = result;
$scope.showLoader = false;
        });
    };

   ipCost : {}

 $scope.vmCostList = function () {
        var hasipCost= appService.crudService.listAll("miscellaneous/listvmsnapshot");
        hasipCost.then(function (result) {  // this is only run after $http completes0
            $scope.miscellaneousList = result;
        });

    };
$scope.vmCostList();

    $scope.openAddVMSnapshotContainer = function() {
    	$scope.showLoader = true;
        dialogService.openDialog("app/views/cloud/snapshot/createVm.jsp", 'md', $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
            $scope.instanceId(1);
            $scope.validateVMSnapshot = function(form) {
                    $scope.formSubmitted = true;
                    if (form.$valid) {
                        $scope.showLoaders = true;
                        $scope.vmsnapshot.domainId = $scope.vmsnapshot.vm.domainId;
                        $scope.vmsnapshot.vmId = $scope.vmsnapshot.vm.id;
                        if(angular.isUndefined($scope.vmsnapshot.snapshotMemory)){
                            $scope.vmsnapshot.snapshotMemory = false;
                        }
			appService.globalConfig.webSocketLoaders.snapshotLoader = true;
                        $scope.cancel();
                        var hasVm = crudService.add("vmsnapshot", $scope.vmsnapshot);
                        hasVm.then(function(result) {
                            $scope.showLoaders = false;
                        }).catch(function(result) {
                            $scope.showLoaders = false;
                            $scope.cancel();
			appService.globalConfig.webSocketLoaders.snapshotLoader = false;
                        });

                    }
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };
    // $scope.openAddVMSnapshotContainer = function(vm) {
    // dialogService.openDialog("app/views/cloud/snapshot/createVm.jsp", 'md',
    // $scope, ['$scope', '$modalInstance','$rootScope', function ($scope,
    // $modalInstance , $rootScope) {
    // $scope.vm = vm;
    // $scope.instanceId(1);
    // $scope.validateVMSnapshot= function(form) {
    // var hasVm = crudService.add("vmsnapshot", $scope.vm);
    // hasVm.then(function(result) {
    // $state.reload();
    // $scope.cancel();
    // });
    //
    // },
    // $scope.cancel = function () {
    // $modalInstance.close();
    // };
    // }]);
    // };
    $scope.deleteSnapshots = function(size, snapshotId) {
    	var hasSnapshotRead = appService.crudService.read("vmsnapshot", snapshotId);
    	hasSnapshotRead.then(function (snapshot) {
        dialogService.openDialog("app/views/cloud/snapshot/delete-snapshot.jsp", size, $scope, ['$scope', '$modalInstance', function($scope, $modalInstance) {
            $scope.deleteObject = snapshot;
            $scope.ok = function() {
                    $scope.showLoader = true;
                    var event = "VMSNAPSHOT.DELETE";
		    appService.globalConfig.webSocketLoaders.snapshotLoader = true;
                    $scope.cancel();
                    var hasServer = crudService.vmUpdate("vmsnapshot/event", snapshot.uuid, event);
                    hasServer.then(function(result) {
                        $scope.showLoader = false;
                    }).catch(function(result) {
                        $scope.showLoader = false;
                        $scope.cancel();
			appService.globalConfig.webSocketLoaders.snapshotLoader = false;
                    });
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    });
    };
    $scope.deleteVolumeSnapshot = function(size, snapshotId) {
    	var hasSnapshotRead = appService.crudService.read("snapshots", snapshotId);
    	hasSnapshotRead.then(function (snapshot) {
        dialogService.openDialog("app/views/common/confirm-delete.jsp", size, $scope, ['$scope', '$modalInstance', function($scope, $modalInstance) {
            $scope.deleteObject = snapshot;
            $scope.ok = function(deleteObject) {
		    appService.globalConfig.webSocketLoaders.volumeBackupLoader = true;
                    $scope.cancel();
                    var hasServer = crudService.softDelete("snapshots", deleteObject);
                    hasServer.then(function(result) {
                    }).catch(function(){
appService.globalConfig.webSocketLoaders.volumeBackupLoader = false;
});
                    $scope.cancel();
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    });
    };
    $scope.restoresnapshot = function(vmsnapshotId) {
    	var hasSnapshotRead = appService.crudService.read("vmsnapshot", vmsnapshotId);
    	hasSnapshotRead.then(function (vmsnapshot) {
        dialogService.openDialog("app/views/cloud/snapshot/revert-vmsnapshot.jsp", 'sm', $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
            $scope.ok = function() {
                    $scope.showLoader = true;
                    var event = "VMSNAPSHOT.REVERTTO";
		    appService.globalConfig.webSocketLoaders.snapshotLoader = true;
                    $scope.cancel();
                    var hasVm = crudService.vmUpdate("vmsnapshot/event", vmsnapshot.uuid, event);
                    hasVm.then(function(result) {
                        $scope.showLoader = false;
                    }).catch(function(result) {
                        $scope.showLoader = false;
                        $scope.cancel();
			appService.globalConfig.webSocketLoaders.snapshotLoader = false;
                    });
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    });
    };


 $scope.volumeSnapCostList = function () {
        var hasipSnapCost= appService.crudService.listAll("miscellaneous/listvolumesnapshot");
        hasipSnapCost.then(function (result) {  // this is only run after $http completes0
            $scope.miscellaneousVolumeSnapshotList = result;
        });

    };
$scope.volumeSnapCostList();

    $scope.openAddSnapshotContainer = function() {
        dialogService.openDialog("app/views/cloud/snapshot/create.jsp", "md", $scope, ['$scope', '$modalInstance', function($scope, $modalInstance) {
            $scope.createSnapshot = false;
            $scope.volumesList = {};
            $scope.listVolumes = function() {
                $scope.showLoader = true;
                var hasVolumes = crudService.listAll("volumes/list");
                hasVolumes.then(function(result) {
                    $scope.showLoader = false;
                    $scope.volumesList = result;
                });
            };
            $scope.listVolumes();
            $scope.updatePageStatus = function(size, volume) {
                $scope.createSnapshot = true;
                $scope.volume = volume;
                $scope.snapshot = {};
            };
            // Close the create snapshot page
            $scope.closeCreateSnapshot = function() {
                $scope.createSnapshot = false;
            };
            // Creating snapshot
            $scope.validateConfirmSnapshot = function(form) {
                $scope.formSubmitted = true;
                if (form.$valid) {
                appService.globalConfig.webSocketLoaders.volumeBackupLoader = true;
                $modalInstance.close();
                    var snapshot = $scope.snapshot;
                    snapshot.volume = $scope.volume;
                    snapshot.zone = crudService.globalConfig.zone;
                    var hasServer = crudService.add("snapshots", snapshot);
                    hasServer.then(function(result) {

                    }).catch(function(result) {
                        if (!angular.isUndefined(result.data) && result.data.fieldErrors != null) {
                            angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                                form[key].$invalid = true;
                                form[key].errorMessage = errorMessage;
                            });
                        }

appService.globalConfig.webSocketLoaders.volumeBackupLoader = false;
                    });
                    $scope.cancel = function() {
                        $modalInstance.close();
                    };
                }
            };
            // Close the dialog box
            $scope.cancel = function() {
                if ($scope.createSnapshot) {
                    // Overriding the cancel method for create page
                    $scope.closeCreateSnapshot();
                } else {
                    $modalInstance.close();
                }
            };
        }]);
    };
    $scope.createVolume = function(size, snapshotId) {
    	var hasSnapshotRead = appService.crudService.read("snapshots", snapshotId);
    	hasSnapshotRead.then(function (snapshot) {
        appService.dialogService.openDialog("app/views/cloud/snapshot/create-volume.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope',
            function($scope, $modalInstance, $rootScope) {
                $scope.deleteObject = snapshot;
                $scope.save = function(form, deleteObject) {
                        if (!angular.isUndefined($scope.deleteObject.domain) && ($scope.deleteObject.domain)!= null ) {
                            deleteObject.domainId = $scope.deleteObject.domain.id;
                            delete deleteObject.domain;
                        }
                        if (!angular.isUndefined($scope.deleteObject.department) && $scope.deleteObject.department != null) {
                            deleteObject.departmentId = $scope.deleteObject.department.id;
                            delete deleteObject.department;
                        }
                        if (!angular.isUndefined($scope.deleteObject.volume) && $scope.deleteObject.volume != null) {
                            deleteObject.volumeId = $scope.deleteObject.volume.id;
                            delete deleteObject.volume;
                        }
                        if (!angular.isUndefined($scope.deleteObject.zone) && $scope.deleteObject.zone != null) {
                            deleteObject.zoneId = $scope.deleteObject.zone.id;
                            delete deleteObject.zone;
                        }
                        if (!angular.isUndefined($scope.deleteObject.snapshot) && $scope.deleteObject.snapshot != null) {
                            deleteObject.snapshot = $scope.deleteObject.snapshot.id;
                            delete deleteObject.snapshot;
                        }
			$modalInstance.close();
                        appService.globalConfig.webSocketLoaders.volumeBackupLoader = true;
                        $scope.formSubmitted = true;
                        if (form.$valid) {
                            $scope.showLoader = true;
                            var hasVolume = appService.crudService.add("snapshots/volumesnap", deleteObject);
                            hasVolume.then(function(result) {
                                $scope.showLoader = false;
                            }).catch(function(result) {
                                $scope.showLoader = false;
                                $modalInstance.close();
appService.globalConfig.webSocketLoaders.volumeBackupLoader = false;
                            });
                        }
                    },
                    $scope.cancel = function() {
                        $modalInstance.close();
                    };
            }
        ]);
    });
    };
    $scope.revertSnapshot = function(size, snapshotId) {
    	var hasSnapshotRead = appService.crudService.read("snapshots", snapshotId);
    	hasSnapshotRead.then(function (snapshot) {
        appService.dialogService.openDialog("app/views/cloud/snapshot/revert-snapshot.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope',
            function($scope, $modalInstance, $rootScope) {
                $scope.revertSnapshot = snapshot;
console.log($scope.revertSnapshot);
                $scope.okrevert = function(form, revertSnapshot) {
                        if (!angular.isUndefined($scope.revertSnapshot.domain) && $scope.revertSnapshot.domain != null) {
console.log($scope.revertSnapshot.domain);
                            revertSnapshot.domainId = $scope.revertSnapshot.domain.id;
                            delete revertSnapshot.domain;
                        }
                        if (!angular.isUndefined($scope.revertSnapshot.department) && $scope.revertSnapshot.department != null) {
                            revertSnapshot.departmentId = $scope.revertSnapshot.department.id;
                            delete revertSnapshot.department;
                        }
                        if (!angular.isUndefined($scope.revertSnapshot.volume) && $scope.revertSnapshot.volume != null) {
                            revertSnapshot.volumeId = $scope.revertSnapshot.volume.id;
                            delete revertSnapshot.volume;
                        }
                        if (!angular.isUndefined($scope.revertSnapshot.zone) && $scope.revertSnapshot.zone != null) {
                            revertSnapshot.zoneId = $scope.revertSnapshot.zone.id;
                            delete revertSnapshot.zone;
                        }
                        if (!angular.isUndefined($scope.revertSnapshot.snapshot) && $scope.revertSnapshot.snapshot != null) {
                            revertSnapshot.snapshot = $scope.revertSnapshot.snapshot.id;
                            delete revertSnapshot.snapshot;
                        }
                        $scope.formSubmitted = true;
                        if (form.$valid) {
                            $scope.showLoader = true;
			    $modalInstance.close();
                            appService.globalConfig.webSocketLoaders.volumeBackupLoader = true;
                            var hasVolume = appService.crudService.add("snapshots/revertsnap", revertSnapshot);
                            hasVolume.then(function(result) {
                                $scope.showLoader = false;
                                $scope.list(1);
                            }).catch(function(result) {
                                $scope.showLoader = false;
                            appService.globalConfig.webSocketLoaders.volumeBackupLoader = false;
                                if (!angular.isUndefined(result.data)) {
                                    if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                                        var msg = result.data.globalError[0];
                                        $scope.showLoader = false;
                               appService.globalConfig.webSocketLoaders.volumeBackupLoader = false;
                                        appService.notify({
                                            message: msg,
                                            classes: 'alert-danger',
                                            templateUrl: $scope.global.NOTIFICATION_TEMPLATE
                                        });
                                    }
                                }

                            });
                               appService.globalConfig.webSocketLoaders.volumeBackupLoader = false;
                        }
                    },
                    $scope.cancel = function() {
                        $modalInstance.close();
                    };
            }
        ]);
    });
    };
    $scope.$on(appService.globalConfig.webSocketEvents.snapshotEvents.createvmsnapshot, function(event, args) {
	appService.globalConfig.webSocketLoaders.snapshotLoader = false;
        $scope.lists(1);
    });
    $scope.$on(appService.globalConfig.webSocketEvents.snapshotEvents.deleteSnapshots, function(event, args) {
	appService.globalConfig.webSocketLoaders.snapshotLoader = false;
        $scope.lists(1);
    });
    $scope.$on(appService.globalConfig.webSocketEvents.snapshotEvents.deleteVolumeSnapshot, function(event, args) {
        appService.globalConfig.webSocketLoaders.volumeBackupLoader = false;
        $scope.list(1);
    });
    $scope.$on(appService.globalConfig.webSocketEvents.snapshotEvents.restoresnapshot, function(event, args) {
	appService.globalConfig.webSocketLoaders.snapshotLoader = false;
	$scope.lists(1);

    });
    $scope.$on(appService.globalConfig.webSocketEvents.snapshotEvents.createsnapshot, function(event, args) {
        appService.globalConfig.webSocketLoaders.volumeBackupLoader = false;
        $scope.list(1);
    });
    $scope.$on(appService.globalConfig.webSocketEvents.snapshotEvents.createsnapshotvolume, function(event, args) {
        appService.globalConfig.webSocketLoaders.volumeBackupLoader = false;
        $scope.list(1);
    });
    $scope.$on(appService.globalConfig.webSocketEvents.snapshotEvents.revertSnapshot, function(event, args) {
        appService.globalConfig.webSocketLoaders.volumeBackupLoader = false;
        $scope.list($scope.paginationObject.currentPage);
    });
}
