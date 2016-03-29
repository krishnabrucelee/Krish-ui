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
    $scope.global = globalConfig;
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
    /*    $scope.validateCreateVolume = function(form) {
            $scope.formSubmitted = true;
            if (form.$valid) {
                $scope.cancel();
                $scope.homerTemplate = 'app/views/notification/notify.jsp';
                notify({message: 'Created successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});

            }
        };*/
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
        var hasSnapshotLists = appService.promiseAjax.httpTokenRequest(globalConfig.HTTP_GET, globalConfig.APP_URL + "snapshots" + "?lang=" + localStorageService.cookie.get('language') + "&sortBy=" + sortOrder + sortBy + "&limit=" + limit, $scope.global.paginationHeaders(pageNumber, limit), {
            "limit": limit
        });
        hasSnapshotLists.then(function(result) { // this is only run after $http
            // completes0
            $scope.snapshotList = result;
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
        var hasVolumes = crudService.list("snapshots", crudService.globalConfig.paginationHeaders(pageNumber, limit), {
            "limit": limit
        });
        hasVolumes.then(function(result) {
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
    $scope.lists = function(pageNumber) {
        $scope.showLoaderOffer = true;
        var limit = (angular.isUndefined($scope.paginationObjects.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObjects.limit;
        var hasSnapshots = {};
        if ($scope.domainId == null) {
            hasSnapshots = appService.crudService.list("vmsnapshot", $scope.global.paginationHeaders(pageNumber, limit), {
                "limit": limit
            });
        } else {
            hasSnapshots = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "vmsnapshot/listByDomain" + "?lang=" + appService.localStorageService.cookie.get('language') + "&domainId=" + $scope.domainId + "&sortBy=" + globalConfig.sort.sortOrder + globalConfig.sort.sortBy + "&limit=" + limit, $scope.global.paginationHeaders(pageNumber, limit), {
                "limit": limit
            });
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
    $scope.selectDomainView = function(pageNumber, domainId) {
        $scope.domainId = domainId;
        $scope.lists(1);
    };
    $scope.instanceList = {};
    $scope.instanceId = function(pageNumber) {
        var hasUsers = crudService.listByQuery("virtualmachine/list");
        hasUsers.then(function(result) { // this is only run after $http
            // completes0
            $scope.instanceList = result;
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
        dialogService.openDialog("app/views/cloud/snapshot/createVm.jsp", 'md', $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
            $scope.instanceId(1);
            $scope.validateVMSnapshot = function(form) {
                    $scope.formSubmitted = true;
                    if (form.$valid) {
                        $scope.showLoader = true;
                        $scope.vmsnapshot.domainId = $scope.vmsnapshot.vm.domainId;
                        $scope.vmsnapshot.vmId = $scope.vmsnapshot.vm.id;
                        if(angular.isUndefined($scope.vmsnapshot.snapshotMemory)){
                            $scope.vmsnapshot.snapshotMemory = false;
                        }
                        var hasVm = crudService.add("vmsnapshot", $scope.vmsnapshot);
                        hasVm.then(function(result) {
                            appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.snapshotEvents.createvmsnapshot, result.uuid, $scope.global.sessionValues.id);
                            $scope.showLoader = false;
                            $scope.cancel();
                        }).catch(function(result) {
                            $scope.showLoader = false;
                            $scope.cancel();
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
    $scope.deleteSnapshots = function(size, snapshot) {
        dialogService.openDialog("app/views/cloud/snapshot/delete-snapshot.jsp", size, $scope, ['$scope', '$modalInstance', function($scope, $modalInstance) {
            $scope.deleteObject = snapshot;
            $scope.ok = function() {
                    $scope.showLoader = true;
                    var event = "VMSNAPSHOT.DELETE";
                    var hasServer = crudService.vmUpdate("vmsnapshot/event", snapshot.uuid, event);
                    hasServer.then(function(result) {
                        appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.snapshotEvents.deleteSnapshots, result.uuid, $scope.global.sessionValues.id);
                        $scope.showLoader = false;
                        $scope.cancel();
                    }).catch(function(result) {
                        $scope.showLoader = false;
                        $scope.cancel();
                    });
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };
    $scope.deleteVolumeSnapshot = function(size, snapshot) {
        dialogService.openDialog("app/views/common/confirm-delete.jsp", size, $scope, ['$scope', '$modalInstance', function($scope, $modalInstance) {
            $scope.deleteObject = snapshot;
            $scope.ok = function(deleteObject) {
                    var hasServer = crudService.softDelete("snapshots", deleteObject);
                    hasServer.then(function(result) {
                        appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.snapshotEvents.deleteVolumeSnapshot, result.uuid, $scope.global.sessionValues.id);
                    });
                    $scope.cancel();
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };
    $scope.restoresnapshot = function(vmsnapshot) {
        dialogService.openDialog("app/views/cloud/snapshot/revert-vmsnapshot.jsp", 'sm', $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
            $scope.ok = function() {
                    $scope.showLoader = true;
                    var event = "VMSNAPSHOT.REVERTTO";
                    var hasVm = crudService.vmUpdate("vmsnapshot/event", vmsnapshot.uuid, event);
                    hasVm.then(function(result) {
                        appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.snapshotEvents.restoresnapshot, result.uuid, $scope.global.sessionValues.id);
                        $scope.showLoader = false;
                        $scope.cancel();
                    }).catch(function(result) {
                        $scope.showLoader = false;
                        $scope.cancel();
                    });
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };
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
                    var snapshot = $scope.snapshot;
                    snapshot.volume = $scope.volume;
                    snapshot.zone = crudService.globalConfig.zone;
                    var hasServer = crudService.add("snapshots", snapshot);
                    hasServer.then(function(result) {
                        appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.snapshotEvents.createsnapshot, result.uuid, $scope.global.sessionValues.id);
                        $modalInstance.close();
                    }).catch(function(result) {
                        if (!angular.isUndefined(result.data) && result.data.fieldErrors != null) {
                            angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                                form[key].$invalid = true;
                                form[key].errorMessage = errorMessage;
                            });
                        }
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
    $scope.createVolume = function(size, snapshot) {
        appService.dialogService.openDialog("app/views/cloud/snapshot/create-volume.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope',
            function($scope, $modalInstance, $rootScope) {
                $scope.deleteObject = snapshot;
                $scope.save = function(form, deleteObject) {
                        if (!angular.isUndefined($scope.deleteObject.domain)) {
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
                        $scope.formSubmitted = true;
                        if (form.$valid) {
                            $scope.showLoader = true;
                            var hasVolume = appService.crudService.add("snapshots/volumesnap", deleteObject);
                            hasVolume.then(function(result) {
                                appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.snapshotEvents.createsnapshotvolume, result.uuid, $scope.global.sessionValues.id);
                                $scope.showLoader = false;
                                $modalInstance.close();
                            }).catch(function(result) {
                                $scope.showLoader = false;
                                $modalInstance.close();
                            });
                        }
                    },
                    $scope.cancel = function() {
                        $modalInstance.close();
                    };
            }
        ]);
    };
    $scope.revertSnapshot = function(size, snapshot) {
        appService.dialogService.openDialog("app/views/cloud/snapshot/revert-snapshot.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope',
            function($scope, $modalInstance, $rootScope) {
                $scope.revertSnapshot = snapshot;
                $scope.okrevert = function(form, revertSnapshot) {
                        if (!angular.isUndefined($scope.revertSnapshot.domain)) {
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
                            console.log($scope.revertSnapshot);
                            var hasVolume = appService.crudService.add("snapshots/revertsnap", revertSnapshot);
                            hasVolume.then(function(result) {
                                appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.snapshotEvents.revertSnapshot, result.uuid, $scope.global.sessionValues.id);
                                $scope.showLoader = false;
                                $scope.list($scope.paginationObject.currentPage);
                                $modalInstance.close();
                            }).catch(function(result) {
                                $scope.showLoader = false;
                                if (!angular.isUndefined(result.data)) {
                                    if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                                        var msg = result.data.globalError[0];
                                        $scope.showLoader = false;
                                        appService.notify({
                                            message: msg,
                                            classes: 'alert-danger',
                                            templateUrl: $scope.global.NOTIFICATION_TEMPLATE
                                        });
                                    }
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
    $scope.$on(appService.globalConfig.webSocketEvents.snapshotEvents.createvmsnapshot, function() {
        $scope.lists($scope.paginationObjects.currentPage);
        notify({
            message: "VM snapshot created successfully",
            classes: 'alert-success',
            templateUrl: $scope.global.NOTIFICATION_TEMPLATE
        });
    });
    $scope.$on(appService.globalConfig.webSocketEvents.snapshotEvents.deleteSnapshots, function() {
        $scope.lists($scope.paginationObjects.currentPage);
        notify({
            message: 'VM snapshot deleted successfully',
            classes: 'alert-success',
            templateUrl: $scope.global.NOTIFICATION_TEMPLATE
        });
    });
    $scope.$on(appService.globalConfig.webSocketEvents.snapshotEvents.deleteVolumeSnapshot, function() {
        $scope.list($scope.paginationObject.currentPage);
        notify({
            message: 'Volume snapshot deleted successfully ',
            classes: 'alert-success',
            templateUrl: $scope.global.NOTIFICATION_TEMPLATE
        });
    });
    $scope.$on(appService.globalConfig.webSocketEvents.snapshotEvents.restoresnapshot, function() {
        $scope.lists($scope.paginationObjects.currentPage);
        notify({
            message: 'VM snapshot reverted successfully',
            classes: 'alert-success',
            templateUrl: $scope.global.NOTIFICATION_TEMPLATE
        });
    });
    $scope.$on(appService.globalConfig.webSocketEvents.snapshotEvents.createsnapshot, function() {
        $scope.list($scope.paginationObject.currentPage);
        notify({
            message: 'Volume backedup successfully ',
            classes: 'alert-success',
            templateUrl: $scope.global.NOTIFICATION_TEMPLATE
        });
    });
    $scope.$on(appService.globalConfig.webSocketEvents.snapshotEvents.createsnapshotvolume, function() {
        $scope.list($scope.paginationObject.currentPage);
        appService.notify({
            message: 'Volume created successfully',
            classes: 'alert-success',
            templateUrl: $scope.global.NOTIFICATION_TEMPLATE
        });
    });
    $scope.$on(appService.globalConfig.webSocketEvents.snapshotEvents.revertSnapshot, function() {
        $scope.list($scope.paginationObject.currentPage);
    });
}
