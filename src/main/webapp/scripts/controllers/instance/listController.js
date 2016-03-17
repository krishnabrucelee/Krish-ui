/**
 *
 * instanceListCtrl
 *
 */
angular.module('homer').controller('instanceListCtrl', instanceListCtrl)
    .controller('instanceDetailsCtrl', instanceDetailsCtrl)

function instanceListCtrl($scope, $sce, $log, $filter, dialogService, $timeout, promiseAjax, $state,
    globalConfig, crudService, $modal, localStorageService, $window, notify, appService, $stateParams) {
    $scope.instanceList = [];
    $scope.instancesList = [];
    $scope.instance = {};
    $scope.global = crudService.globalConfig;
    $scope.paginationObject = {};
    $scope.sort = appService.globalConfig.sort;
    $scope.changeSorting = appService.utilService.changeSorting;
    $scope.paginationObject.sortOrder = '+';
    $scope.paginationObject.sortBy = 'displayName';
    if ($stateParams.id > 0) {
        var hasServer = appService.crudService.read("virtualmachine", $stateParams.id);
        hasServer.then(function(result) { // this is only run after $http
            $scope.instance = result;
            $scope.networkList = result.network;
            $state.current.data.pageName = result.name;
            $state.current.data.id = result.id;
        });
    }

    $scope.hostList = function() {
        var hashostList = appService.crudService.listAll("host/list");
        hashostList.then(function(result) {
            $scope.hostLists = result;
        });
    };
    $scope.hostList();

    $scope.showConsole = function(vm) {
        var hasServer = appService.crudService.read("virtualmachine", vm.id);
        hasServer.then(function(result) {
            $scope.vm = result;
            var hasVms = crudService.updates("virtualmachine/console", $scope.vm);
            hasVms.then(function(result) {
                var consoleUrl = result.success + "&displayname=" + $scope.vm.displayName;
                window.open($sce.trustAsResourceUrl(consoleUrl), $scope.vm.name + $scope.vm.id, 'width=750,height=460');
            });
        });

    }


    $scope.startVm = function(size, item) {
        if ($scope.global.sessionValues.type === 'ROOT_ADMIN') {
            size = 'md';
        } else {
            size = 'sm';
        }
        appService.dialogService.openDialog("app/views/cloud/instance/start.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
            var vms = {};
            var event = "VM.START";
            $scope.update = function(form) {
                    $scope.formSubmitted = true;
                    if (form.$valid) {
                        var hasServer = appService.crudService.read("virtualmachine", item.id);
                        hasServer.then(function(result) {
                            vms = result;
                            vms.event = event;
                            if ($scope.instance.host != null) {
                                vms.hostUuid = $scope.instance.host.uuid;
                            }
                            var hasVm = appService.crudService.updates("virtualmachine/handleevent/vm", vms);

                            hasVm.then(function(result) {
                                appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.vmEvents.startVm, result.uuid, $scope.global.sessionValues.id);
                                $scope.cancel();
                            }).catch(function(result) {
                                $scope.cancel();
                            });

                        });
                    }

                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };

    $scope.agree = {
        value1: false,
        value2: true
    };
    $scope.stopVm = function(size, item) {
        $scope.item = item;
        appService.dialogService.openDialog("app/views/cloud/instance/stop.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
            $scope.vmStop = function(item) {
                    var event = "VM.STOP";
                    $scope.actionExpunge = true;
                    if ($scope.agree.value1) {
                        var hasServer = appService.crudService.read("virtualmachine", item.id);
                        hasServer.then(function(result) {
                            item = result;
                            item.transForcedStop = $scope.agree.value1;
                            item.event = event;
                            var hasVm = appService.crudService.updates("virtualmachine/handleevent/vm", item);
                            hasVm.then(function(result) {
                                appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.vmEvents.stopVm, result.uuid, $scope.global.sessionValues.id);
                                $scope.cancel();
                            }).catch(function(result) {
                                $scope.cancel();

                            });

                        });
                    } else {
                        var event = "VM.STOP";

                        var hasServer = appService.crudService.read("virtualmachine", item.id);
                        hasServer.then(function(result) {
                            item = result;
                            var hasVm = appService.crudService.vmUpdate("virtualmachine/handlevmevent", item.uuid, event);
                            hasVm.then(function(result) {                                $scope.cancel();
                                appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.vmEvents.stopVm, result.uuid, $scope.global.sessionValues.id);
                                $scope.cancel();
                            }).catch(function(result) {
                                $scope.list($scope.paginationObject.currentPage);
                                $scope.cancel();

                            });
                        });
                    }
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };
    $scope.rebootVm = function(size, item) {
        dialogService.openDialog("app/views/cloud/instance/reboot.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
            $scope.vmRestart = function(item) {
                    var event = "VM.REBOOT";
                    var hasServer = appService.crudService.read("virtualmachine", item.id);
                    hasServer.then(function(result) {
                        item = result;
                        var hasVm = crudService.vmUpdate("virtualmachine/handlevmevent", item.uuid, event);
                        hasVm.then(function(result) {
                            appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.vmEvents.rebootVm, result.uuid, $scope.global.sessionValues.id);
                            $scope.cancel();
                        });
                    });
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };

    // Get domain list
    var hasdomainListView = appService.crudService.listAll("domains/list");
    hasdomainListView.then(function(result) {
        $scope.domainListView = result;
    });

    // Get instance list based on domain selection
    $scope.selectDomainView = function(pageNumber) {
        $scope.list(1, "Expunging");
    };

    // Get instance list based on quick search
    $scope.vmSearch = null;
    $scope.searchList = function(vmSearch) {
        $scope.vmSearch = vmSearch;
        $scope.list(1, "Expunging");
    };

    $scope.vm = {};

    $scope.list = function(pageNumber, status) {
        appService.globalConfig.sort.sortOrder = $scope.paginationObject.sortOrder;
        appService.globalConfig.sort.sortBy = $scope.paginationObject.sortBy;
        if (!angular.isUndefined(status)) {
            $scope.vm.status = status;
            $window.sessionStorage.removeItem("status")
            $window.sessionStorage.setItem("status", status);
        } else {
            $scope.vm.status = $window.sessionStorage.getItem("status");
        }

        $scope.showLoader = true;
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasUsers = {};
        $scope.filter = "";
        if ($scope.domainView == null && $scope.vmSearch == null) {
            hasUsers = promiseAjax.httpTokenRequest(globalConfig.HTTP_GET, globalConfig.APP_URL + "virtualmachine/listByStatus" + "?lang=" + localStorageService.cookie.get('language') + "&status=" + $scope.vm.status + "&sortBy=" + $scope.paginationObject.sortOrder + $scope.paginationObject.sortBy + "&limit=" + limit, $scope.global.paginationHeaders(pageNumber, limit), {
                "limit": limit
            });
        } else {
            if ($scope.domainView != null && $scope.vmSearch == null) {
                $scope.filter = "&domainId=" + $scope.domainView.id + "&searchText=";
            } else if ($scope.domainView == null && $scope.vmSearch != null) {
                $scope.filter = "&domainId=0" + "&searchText=" + $scope.vmSearch;
            } else {
                $scope.filter = "&domainId=" + $scope.domainView.id + "&searchText=" + $scope.vmSearch;
            }
            hasUsers = promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "virtualmachine/listByDomain" + "?lang=" + appService.localStorageService.cookie.get('language') + "&status=" + $scope.vm.status + $scope.filter + "&sortBy=" + globalConfig.sort.sortOrder + globalConfig.sort.sortBy + "&limit=" + limit, $scope.global.paginationHeaders(pageNumber, limit), {
                "limit": limit
            });
        }
        $scope.borderContent = status;
        hasUsers.then(function(result) { // this is only run after $http
            // completes0
            $scope.instanceList = result;
            $scope.instanceList.Count = result.totalItems;
            // For pagination
            $scope.instancesList.Count = 0;
            for (i = 0; i < result.length; i++) {
                if ($scope.instanceList[i].status.indexOf("EXPUNGING") > -1) {
                    $scope.instancesList.Count++;
                }
            }

            // Get the count of the listings
            var hasVmCount = {};
            if ($scope.domainView == null && $scope.vmSearch == null) {
                hasVmCount = crudService.listAll("virtualmachine/vmCounts");
            } else {
                hasVmCount = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL +
                    "virtualmachine/vmCountsByDomain?lang=" +
                    appService.localStorageService.cookie.get('language') + $scope.filter + "&sortBy=" + globalConfig.sort.sortOrder + globalConfig.sort.sortBy);
            }
            hasVmCount.then(function(result) {
                $scope.runningVmCount = result.runningVmCount;
                $scope.stoppedVmCount = result.stoppedVmCount;
                $scope.totalCount = result.totalCount;
            });
            $scope.paginationObject.limit = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
            $scope.showLoader = false;
        });
    };

    $scope.list(1, "Expunging");

    $scope.changeSort = function(sortBy, pageNumber) {
        var sort = globalConfig.sort;
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
        var hasUsers = {};
        if ($scope.domainView == null && $scope.vmSearch == null) {
            hasUsers = promiseAjax.httpTokenRequest(globalConfig.HTTP_GET, globalConfig.APP_URL + "virtualmachine/listByStatus" + "?lang=" + localStorageService.cookie.get('language') + "&status=" + $scope.vm.status + "&sortBy=" + sortOrder + sortBy + "&limit=" + limit, $scope.global.paginationHeaders(pageNumber, limit), {
                "limit": limit
            });
        } else {
            $scope.filter = "";
            if ($scope.domainView != null && $scope.vmSearch == null) {
                $scope.filter = "&domainId=" + $scope.domainView.id + "&searchText=";
            } else if ($scope.domainView == null && $scope.vmSearch != null) {
                $scope.filter = "&domainId=0" + "&searchText=" + $scope.vmSearch;
            } else {
                $scope.filter = "&domainId=" + $scope.domainView.id + "&searchText=" + $scope.vmSearch;
            }
            hasUsers = promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "virtualmachine/listByDomain" + "?lang=" + appService.localStorageService.cookie.get('language') + "&status=" + $scope.vm.status + $scope.filter + "&sortBy=" + $scope.paginationObject.sortOrder + $scope.paginationObject.sortBy + "&limit=" + limit, $scope.global.paginationHeaders(pageNumber, limit), {
                "limit": limit
            });
        }

        $scope.borderContent = $scope.vm.status;
        hasUsers.then(function(result) { // this is only run after $http
            // completes0
            $scope.instanceList = result;
            $scope.instanceList.Count = result.totalItems;
            // For pagination

            $scope.instancesList.Count = 0;
            for (i = 0; i < result.length; i++) {
                if ($scope.instanceList[i].status.indexOf("EXPUNGING") > -1) {
                    $scope.instancesList.Count++;
                }
            }

            $scope.paginationObject.limit = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
            $scope.paginationObject.sortOrder = sortOrder;
            $scope.paginationObject.sortBy = sortBy;
            $scope.showLoader = false;
        });
    };


    $scope.openAddInstance = function(size) {

        var modalInstance = $modal.open({
            templateUrl: 'app/views/cloud/instance/add.jsp',
            controller: 'instanceCtrl',
            size: size,
            backdrop: 'static',
            windowClass: "hmodal-info",
            resolve: {
                items: function() {
                    return $scope.items;
                }
            }
        });

        modalInstance.result.then(function(selectedItem) {
            $scope.selected = selectedItem;
        }, function() {
            $log.info('Modal dismissed at: ' + new Date());
        });

    };

    $scope.showDescription = function(vm) {
        var hasServer = appService.crudService.read("virtualmachine", vm.id);
        hasServer.then(function(result) {
            $scope.instance = result;
            appService.dialogService.openDialog("app/views/cloud/instance/displaynote.jsp", 'sm', $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {

                $scope.cancel = function() {
                    $modalInstance.close();
                };
            }]);
        });

    };

    $scope.addApplication = function(vm) {
        var hasapplicationList = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "applications/domain?domainId=" + vm.domainId)
        hasapplicationList.then(function(result) {
            $scope.applicationLists = result;
        });

        appService.dialogService.openDialog("app/views/cloud/instance/add-application.jsp", 'md', $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {

            var event = "ADD.APPLICATION";
            $scope.addApplicationtoVM = function(form) {
                    $scope.formSubmitted = true;
                    if (form.$valid) {
                        var hasServer = appService.crudService.read("virtualmachine", vm.id);
                        hasServer.then(function(result) {
                            $scope.tempVm = result;
                            $scope.tempVm.application = $scope.application;
                            $scope.tempVm.applicationList = $scope.applications;
                            $scope.tempVm.event = event;
                            var hasVm = appService.crudService.updates("virtualmachine/handleevent/vm", $scope.tempVm);
                            hasVm.then(function(result) {
                                $scope.homerTemplate = 'app/views/notification/notify.jsp';
                                appService.notify({
                                    message: $scope.application + " is adding to this VM",
                                    classes: 'alert-success',
                                    "timeOut": "5000",
                                    templateUrl: $scope.homerTemplate
                                });
                                $scope.list($scope.paginationObject.currentPage);
                                $scope.cancel();
                            }).catch(function(result) {});


                        });
                    }
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };

    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.vmCreate, function() {
        $scope.list($scope.paginationObject.currentPage, "Expunging");
        $scope.borderContent = "Expunging";
    });

    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.startVm, function() {
        $scope.list($scope.paginationObject.currentPage, "Expunging");
        $scope.borderContent = "Expunging";
    });

    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.stopVm, function() {
        $scope.list($scope.paginationObject.currentPage, "Expunging");
        $scope.borderContent = "Expunging";
    });

    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.rebootVm, function() {
        $scope.list($scope.paginationObject.currentPage, "Running");
        $scope.borderContent = "Running";
    });

}

function instanceDetailsCtrl($scope, instance, notify, $modalInstance) {

    $scope.update = function(form) {

        $scope.formSubmitted = true;

        if (form.$valid) {
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            notify({
                message: 'Updated successfully',
                classes: 'alert-success',
                templateUrl: $scope.homerTemplate
            });
            $scope.cancel();
        }
    };
    $scope.instance = instance;
    $scope.cancel = function() {
        $modalInstance.dismiss('cancel');
    };
};