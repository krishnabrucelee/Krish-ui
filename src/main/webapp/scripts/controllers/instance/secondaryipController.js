/**
 *
 * networkCtrl
 *
 */
angular.module('homer').controller('secondaryIpCtrl', secondaryIpCtrl)

function secondaryIpCtrl($scope, $modal, $state, $window, $stateParams, appService, localStorageService, globalConfig) {
    $scope.nicIPLists = {};
    $scope.paginationObject = {};
    $scope.nicForm = {};
    $scope.global = appService.globalConfig;
    $scope.sort = appService.globalConfig.sort;
    $scope.changeSorting = appService.utilService.changeSorting;
    $scope.networkList = [];
    $scope.nic = {};
    $scope.vmIp = {};
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
        var instanceId = $stateParams.id;
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasIPLists = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "nics/listbyinstanceid?instanceid=" + instanceId + "&lang=" + appService.localStorageService.cookie.get('language') + "&sortBy=" + sortOrder + sortBy);
        hasIPLists.then(function(result) { // this is only run after $http
            // completes0
            $scope.nicIPLists = result;
            // For pagination
            $scope.paginationObject.limit = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
            $scope.paginationObject.sortOrder = sortOrder;
            $scope.paginationObject.sortBy = sortBy;
            $scope.showLoader = false;
        });
    };
    $scope.instanceDetails = '';
    if ($stateParams.id > 0) {
        var hasServer = appService.crudService.read("virtualmachine", $stateParams.id);
        hasServer.then(function(result) { // this is only run after $http
            $scope.instance = result;
            $scope.networkList = result.network;
            setTimeout(function() {
                $state.current.data.pageName = result.name;
                $state.current.data.id = result.id;
            }, 1000)
        });
    }
    // Nic List
    $scope.nicIPList = function(pageNumber) {
        appService.globalConfig.sort.sortOrder = $scope.paginationObject.sortOrder;
        appService.globalConfig.sort.sortBy = $scope.paginationObject.sortBy;
        $scope.showLoader = true;
        $scope.nic = {};
        var instanceId = $stateParams.id;
        $scope.nicip = $stateParams.id1;
<<<<<<< HEAD
        var hasNicIP = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "nics/listbyinstanceid?instanceid=" + instanceId + "&lang=" + appService.localStorageService.cookie.get('language') + "&sortBy=" + appService.globalConfig.sort.sortOrder + appService.globalConfig.sort.sortBy);
=======
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasNicIP = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "nics/listbyvminstances?instanceid=" + instanceId + "&lang=" + appService.localStorageService.cookie.get('language') + "&sortBy=" + appService.globalConfig.sort.sortOrder + appService.globalConfig.sort.sortBy);
>>>>>>> 6f8b53da602e21285bb60ce51358aa38558e987e
        hasNicIP.then(function(result) {
            $scope.nicIPLists = result;
            $scope.showLoader = false;
            // For pagination
            $scope.paginationObject.limit = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
            $scope.showLoader = false;
        });
    };
    $scope.nicIPList();
    // Add the IP Address
    $scope.acquireNewIP = function(size) {
        appService.dialogService.openDialog($scope.global.VIEW_URL + "cloud/instance/addIP.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
            // Create a new IP
            $scope.nic.id = $stateParams.id1;
            $scope.saveIP = function(form, nic) {
                    $scope.formSubmitted = true;
                    if (form.$valid) {
                        $scope.showLoader = true;
                        var hasServer = appService.crudService.add("nics/acquire/" + $scope.nic.id, nic);
                        hasServer.then(function(result) {
                            appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.vmEvents.acquireNewIP, result.uuid, $scope.global.sessionValues.id);
                            $scope.formSubmitted = false;
                            $modalInstance.close();
			           $scope.nicIPList();
                            $scope.showLoader = false;
                        }).catch(function(result) {
                            $scope.showLoader = false;
                            if (!angular.isUndefined(result.data)) {
                                if (result.data.fieldErrors != null) {
                                    $scope.showLoader = false;
                                    angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                                        $scope.nicForm[key].$invalid = true;
                                        $scope.nicForm[key].errorMessage = errorMessage;
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
    // Delete the Ip Address
    $scope.deleteIP = function(size, nic) {
        appService.dialogService.openDialog($scope.global.VIEW_URL + "cloud/instance/deleteIP.jsp", size, $scope, ['$scope', '$modalInstance', function($scope, $modalInstance) {
            $scope.ok = function(deleteObject) {
                    $scope.deleteObject = nic;
                    $scope.showLoader = true;
                    nic.isActive = false;
                    var hasServer = appService.crudService.add("nics/release/" + nic.id, nic);
                    hasServer.then(function(result) {
                        appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.vmEvents.deleteIP, result.uuid, $scope.global.sessionValues.id);
                        $scope.showLoader = false;
			           $scope.nicIPList();
                    }).catch(function(result) {});
                    $modalInstance.close();
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };
    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.acquireNewIP, function() {
        $scope.nicIPList();
    });
    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.deleteIP, function() {
        $scope.nicIPList();
    });
};
