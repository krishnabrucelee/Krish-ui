/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * networkCtrl
 *
 */

angular.module('homer').controller('vpcCtrl', vpcCtrl)

function vpcCtrl($scope, $modal, appService, filterFilter, $stateParams,$state, localStorageService, promiseAjax) {
    $scope.global = appService.globalConfig;
    $scope.vpc = {};
    $scope.formElements = {};
    $scope.showLoader = false;
    $scope.paginationObject = {};
    $scope.sort = appService.globalConfig.sort;
    $scope.changeSorting = appService.utilService.changeSorting;
    appService.globalConfig.webSocketLoaders.vpcLoader = false;
    $scope.paginationObject.sortOrder = '+';
    $scope.paginationObject.sortBy = 'name';
    $scope.vpcList = [];
    $scope.vpcForm = {};
    $scope.vpcPersist = {};
    $scope.vpcCreateNetwork = {};
    $scope.vpcNetworkList = {};

    // VPC Offer List
    $scope.listVpcOffer = function() {
        var listVpcOffers = appService.promiseAjax
                .httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "vpcoffering/list" + "?lang=" + appService.localStorageService.cookie
                        .get('language') + "&sortBy=-id");
        listVpcOffers.then(function(result) {
            $scope.networkOfferList = result;
        });
    };
    if ($stateParams.id > 0) {
        console.log($stateParams.id);
        $scope.showLoader = true;
        $scope.showLoaderOffer = true;
        $state.current.data.pageName = "";
        $state.current.data.id = "";
        var hasServer = appService.crudService.read("vpc", $stateParams.id);
        hasServer.then(function(result) {
            $scope.showLoader = false;
            $scope.showLoaderOffer = false;
            $scope.vpc = result;
            $scope.vpcPersist = result;
            $scope.listVpcNetwork($scope.vpc.id);
            if ($state.current.data.pageTitle === "view VPC") {
                $state.current.data.pageName = result.name;
                $state.current.data.id = result.id;
            } else {
                $state.$current.parent.data.pageName = result.name;
                $state.$current.parent.data.id = result.id;
            }
        });
    }

    $scope.listVpcOffer();
    $scope.zoneList = {};
    $scope.zoneList = function() {
        var hasZones = appService.crudService.listAll("zones/list");
        hasZones.then(function(result) { // this is only run after $http completes0.
            $scope.zoneList = result;
        });
    };
    $scope.zoneList();
    $scope.domainList = {};
    $scope.domainList = function() {
        var hasDomains = appService.crudService.listAll("domains/list");
        hasDomains.then(function(result) { // this is only run after $http
            // completes0
            $scope.domainList = result;
        });
    };
    $scope.domainList();
    $scope.aclList = {};
    $scope.aclList = function() {
        var hasDomains = appService.crudService.listAll("vpcacl/list");
        hasDomains.then(function(result) { // this is only run after $http
            // completes0
            $scope.aclList = result;
        });
    };
     $scope.aclList();

     // VPC network Offer List
     $scope.listNetworkOffer = function() {
         var listNetworkOffers = appService.promiseAjax
                 .httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "networkoffer/vpcList" + "?lang=" + appService.localStorageService.cookie
                         .get('language') + "&sortBy=-id");
         listNetworkOffers.then(function(result) {
             $scope.vpcNetworkOfferList = result;
         });
     };
     $scope.listNetworkOffer();

    $scope.departmentList = function(domain) {
        var hasDepartments = appService.crudService.listAllByFilter("departments/search", domain);

        hasDepartments.then(function(result) { // this is only run after
            // $http completes0
            $scope.formElements.departmenttypeList = result;
        });
    };

    $scope.getProjectList = function(department) {
        if ($scope.global.sessionValues.type != "USER") {
            var hasProjects = appService.crudService.listAllByObject("projects/department", department);
            hasProjects.then(function(result) { // this is only run after $http
                // completes0
                $scope.projectList = result;
            });
        }
        if ($scope.global.sessionValues.type == "USER") {
            var hasProjects = appService.crudService.listAllByObject("projects/user", $scope.global.sessionValues);
            hasProjects.then(function(result) { // this is only run after $http
                // completes0
                $scope.projectList = result;
            });
        }
    };

    if ($scope.global.sessionValues.type != "ROOT_ADMIN") {
        var department = {};
        department.id = $scope.global.sessionValues.departmentId;
        $scope.getProjectList(department);
    }

    $scope.changedomain = function(obj) {
        $scope.vpc.project = {};
        if (!angular.isUndefined(obj)) {
            $scope.departmentList(obj);
            //$scope.projectList = [];
        }
    }

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
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT
                : $scope.paginationObject.limit;
        var hasVpcLists = {};
        if ($scope.domainView == null && $scope.vpcSearch == null) {
            hasVpcLists = appService.promiseAjax.httpTokenRequest( appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "vpc" +"?lang=" + localStorageService.cookie.get('language') +"&sortBy="+sortOrder+sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});

        }  else {
            $scope.filter = "";
            if ($scope.domainView != null && $scope.vpcSearch == null) {
                $scope.filter = "&domainId=" + $scope.domainView.id + "&searchText=";
            } else if ($scope.domainView == null && $scope.vpcSearch != null) {
                $scope.filter = "&domainId=0" + "&searchText=" + $scope.vpcSearch;
            } else {
                $scope.filter = "&domainId=" + $scope.domainView.id + "&searchText=" + $scope.vpcSearch;
            }
            hasVpcLists =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "vpc/listByDomain"
				+"?lang=" +appService.localStorageService.cookie.get('language')+ $scope.filter+"&sortBy="+$scope.paginationObject.sortOrder +$scope.paginationObject.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
        }
        hasVpcLists.then(function(result) { // this is only run after $http
            // completes0
            $scope.vpcList = result;
            $scope.vpcList.Count = 0;
            if (result.length != 0) {
                $scope.vpcList.Count = result.totalItems;
            }
            // For pagination
            $scope.paginationObject.limit = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
            $scope.paginationObject.sortOrder = sortOrder;
            $scope.paginationObject.sortBy = sortBy;
            $scope.showLoader = false;
            appService.localStorageService.set('views', null);
        });
    };

    $scope.list = function(pageNumber) {
        $scope.global.sort.sortOrder = $scope.paginationObject.sortOrder;
        $scope.global.sort.sortBy = $scope.paginationObject.sortBy;
        $scope.showLoader = true;
        $scope.type = $stateParams.view;
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasGuestNetworks = {};
        if ($scope.domainView == null && $scope.vpcSearch== null) {
		    hasGuestNetworks = appService.crudService.list("vpc", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
	} else {
	    if ($scope.domainView != null && $scope.vpcSearch == null) {
		$scope.filter = "&domainId=" + $scope.domainView.id + "&searchText=";
            } else if ($scope.domainView == null && $scope.vpcSearch != null) {
	    	$scope.filter = "&domainId=0" + "&searchText=" + $scope.vpcSearch;
            } else {
		$scope.filter = "&domainId=" + $scope.domainView.id + "&searchText=" + $scope.vpcSearch;
	    }
	    hasGuestNetworks =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "vpc/listByDomain"
					+"?lang=" +appService.localStorageService.cookie.get('language')+ encodeURI($scope.filter)+"&sortBy="+appService.globalConfig.sort.sortOrder+appService.globalConfig.sort.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
	}
        hasGuestNetworks.then(function(result) {
            $scope.showLoader = true;
            $scope.vpcList = angular.copy(result);
            $scope.vpcList.Count = 0;
            if (result.length != 0) {
                $scope.vpcList.Count = result.totalItems;
            }
            $scope.showLoader = false;
            // For pagination
            $scope.paginationObject.limit = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
            $scope.showLoader = false;
        });
    };
    $scope.filteredCount = $scope.vpcList;
    $scope.list(1);

    // Get department list based on domain selection
    $scope.selectDomainView = function(pageNumber) {
    	$scope.list(1);
    };

   // Get instance list based on quick search
    $scope.vpcSearch = null;
    $scope.searchList = function(vpcSearch) {
        $scope.vpcSearch = vpcSearch;
        $scope.list(1);
    };

    // Add the VPC
    $scope.createVpc = function(size) {
        appService.dialogService.openDialog($scope.global.VIEW_URL + "vpc/add.jsp", size, $scope, [ '$scope',
                '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
            $scope.vpc = {};
            if ($scope.global.sessionValues.type === 'USER') {
                var hasDepartments = appService.crudService.read("departments", $scope.global.sessionValues.departmentId);
                hasDepartments.then(function(result) {
                    $scope.vpc.department = result;
                });
            }
            // Create a new Isolated Network
            $scope.save = function(form, vpc) {
                    $scope.formSubmitted = true;
                    if (form.$valid) {
                        var vpc = angular.copy($scope.vpc);
                        if (!angular.isUndefined($scope.vpc.domain) && $scope.vpc.domain != null) {
                            vpc.domainId = $scope.vpc.domain.id;
                            delete vpc.domain;
                        }
                        if (!angular.isUndefined($scope.vpc.department) && $scope.vpc.department != null) {
                            vpc.departmentId = $scope.vpc.department.id;
                            delete vpc.department;
                        }
                        if (!angular.isUndefined($scope.vpc.project) && $scope.vpc.project != null) {
                            vpc.projectId = $scope.vpc.project.id;
                            delete vpc.project;
                        }
                        vpc.zoneId = $scope.vpc.zone.id;
                        vpc.vpcofferingid = $scope.vpc.vpcoffering.id;
                        $scope.showLoader = true;
                        appService.globalConfig.webSocketLoaders.vpcLoader = true;
                        var hasVpcs = appService.crudService.add("vpc", vpc);
                        hasVpcs.then(function(result) {
                            $scope.showLoader = false;
                            $scope.list(1);
                            $modalInstance.close();
                        }).catch(function(result) {
                            if (!angular.isUndefined(result) && result.data != null) {
                                if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                                    var msg = result.data.globalError[0];
                                    $scope.showLoader = false;
                                    appService.notify({
                                        message: msg,
                                        classes: 'alert-danger',
                                        templateUrl: $scope.global.NOTIFICATION_TEMPLATE
                                    });
                                    $modalInstance.close();
                                }
                                angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                                    $scope.addvpcForm[key].$invalid = true;
                                    $scope.addvpcForm[key].errorMessage = errorMessage;
                                });
                            }
                            appService.globalConfig.webSocketLoaders.vpcLoader = false;
                        });

                    }
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                },

        $scope.changedomain = function(obj) {
        $scope.vpc.project = {};
        if (!angular.isUndefined(obj)) {
            $scope.departmentList(obj);
        //$scope.projectList = [];
        }
    },
               $scope.$watch('vpc.department', function(obj) {
        $scope.vpc.project = null;
                    if (!angular.isUndefined(obj)) {
                        $scope.getProjectList(obj);
                    }
                }),
                $scope.cancel = function() {
                    $modalInstance.close();
                };
                } ]);
    };

    $scope.update = function(form) {
        $scope.formSubmitted = true;
        if (form.$valid) {
            var vpc = $scope.vpc;
            $scope.showLoader = true;
            if (!angular.isUndefined($scope.vpc.domain)) {
                vpc.domainId = $scope.vpc.domain.id;
                delete vpc.domain;
            }
            if (!angular.isUndefined($scope.vpc.department) && $scope.vpc.department != null) {
                vpc.departmentId = $scope.vpc.department.id;
                delete vpc.department;
            }
            if (!angular.isUndefined($scope.vpc.project) && $scope.vpc.project != null) {
                vpc.projectId = $scope.vpc.project.id;
                delete vpc.project;
            }
            vpc.zoneId = $scope.vpc.zone.id;
            vpc.vpcOfferingid = $scope.vpc.vpcOffering.id;
            delete vpc.zone;
            delete vpc.vpcOffering;
            appService.globalConfig.webSocketLoaders.vpcLoader = true;
            var hasNetwork = appService.crudService.update("vpc", vpc);
            hasNetwork.then(function(result) {
                $scope.showLoader = false;
                $scope.formSubmitted = false;
                $scope.list(1);
            }).catch(function(result) {
                if (!angular.isUndefined(result.data) && result.data.fieldErrors != null) {
                    angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                        $scope.addvpcForm[key].$invalid = true;
                        $scope.addvpcForm[key].errorMessage = errorMessage;
                    });
                }
                $scope.showLoader = false;
                appService.globalConfig.webSocketLoaders.vpcLoader = false;
            });
        }
    };

 // Delete the Network
    $scope.delete = function(size, vpc) {
        appService.dialogService.openDialog("app/views/vpc/confirm-delete.jsp", size, $scope, ['$scope', '$modalInstance', function($scope, $modalInstance) {
            $scope.deleteId = vpc.id;
            $scope.ok = function(vpcId) {
                    $scope.showLoader = true;
                    appService.globalConfig.webSocketLoaders.vpcLoader = true;
                    $modalInstance.close();
                    var hasVpcs = appService.crudService.softDelete("vpc", vpc);
                    hasVpcs.then(function(result) {
                        $scope.showLoader = false;
                        $scope.list(1);
                    }).catch(function(result) {
                        if (!angular.isUndefined(result.data) && result.data.fieldErrors != null) {
                            angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                                $scope.addvpcForm[key].$invalid = true;
                                $scope.addvpcForm[key].errorMessage = errorMessage;
                            });
                        }
                        $modalInstance.close();
                        $scope.showLoader = false;
                        appService.globalConfig.webSocketLoaders.vpcLoader = false;
                    });
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };
    $scope.networkRestart = {};
    // Restart the Network
    $scope.restart = function(size, vpc) {
        $scope.vpc = vpc;
        appService.dialogService.openDialog("app/views/vpc/restart-vpc.jsp", size, $scope, ['$scope', '$modalInstance', function($scope, $modalInstance) {
            $scope.ok = function(cleanup,makeredunt) {
                    var vpc = angular.copy($scope.vpc);
                    if(cleanup){
                        vpc.cleanUpVPC = cleanup;
                    }
                    if(makeredunt){
                        vpc.redundantVPC = makeredunt;
                    }
                    $scope.showLoader = true;
                    appService.globalConfig.webSocketLoaders.vpcLoader = true;
                    $modalInstance.close();
                    var hasVpcs = appService.crudService.add("vpc/restart/" + vpc.id, vpc);
                    hasVpcs.then(function(result) { // this is only run after $http completes
                        $scope.showLoader = false;
                        $scope.list(1);
                    }).catch(function(result) {
                        if (!angular.isUndefined(result.data)) {
                            if (result.data.fieldErrors != null) {
                                angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                                    $scope.addvpcForm[key].$invalid = true;
                                    $scope.addvpcForm[key].errorMessage = errorMessage;
                                });
                            }
                        }
                        $scope.showLoader = false;
                        appService.globalConfig.webSocketLoaders.vpcLoader = false;
                        $modalInstance.close();
                    });
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };

    // VPC Network List
    $scope.listVpcNetwork = function(vpcId) {
    	var listVpcNetworks = appService.crudService.listAllByID("guestnetwork/vpcNetworkList?vpcId=" + vpcId);
        listVpcNetworks.then(function(result) {
            $scope.vpcNetworkList = result;
        });
    };

    $scope.createNetwork = function(size) {
        appService.dialogService.openDialog($scope.global.VIEW_URL + "vpc/create.jsp", size, $scope, [ '$scope',
                '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
        	$scope.saveNetwork = function(form, vpcCreateNetwork) {
                $scope.formSubmitted = true;
                if (form.$valid) {
                	vpcCreateNetwork.domainId = $scope.vpc.domainId;
                	vpcCreateNetwork.departmentId = $scope.vpc.departmentId;
                	vpcCreateNetwork.project = $scope.vpc.project;
                	vpcCreateNetwork.projectId = $scope.vpc.projectId;
                	vpcCreateNetwork.zone = $scope.vpc.zone;
                	vpcCreateNetwork.zoneId = $scope.vpc.zoneId;
                	if (!angular.isUndefined($scope.vpcCreateNetwork.acl)) {
                	    vpcCreateNetwork.aclId = $scope.vpcCreateNetwork.acl.id;
                    }
                	vpcCreateNetwork.vpcId = $scope.vpc.id;
                	vpcCreateNetwork.displayText = $scope.vpcCreateNetwork.name;
                    vpcCreateNetwork.networkOfferingId = $scope.vpcCreateNetwork.networkOffering.id;
                    $scope.showLoader = true;
                    appService.globalConfig.webSocketLoaders.networkLoader = true;
                    var hasguestNetworks = appService.crudService.add("guestnetwork", vpcCreateNetwork);
                    hasguestNetworks.then(function(result) {
                        $scope.showLoader = false;
                        $scope.listVpcNetwork($scope.vpc.id);
                        $modalInstance.close();
                        appService.notify({message: 'VPC Network Added Successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                    }).catch(function(result) {
                        if (!angular.isUndefined(result) && result.data != null) {
                            if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                                var msg = result.data.globalError[0];
                                $scope.showLoader = false;
                                appService.notify({
                                    message: msg,
                                    classes: 'alert-danger',
                                    templateUrl: $scope.global.NOTIFICATION_TEMPLATE
                                });
                            }
                            angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                                $scope.addnetworkForm[key].$invalid = true;
                                $scope.addnetworkForm[key].errorMessage = errorMessage;
                            });
                        }
                        $modalInstance.close();
                        appService.globalConfig.webSocketLoaders.networkLoader = false;
                    });
                }
            },
            $scope.cancel = function() {
                $modalInstance.close();
            };
        }]);
    };

    $scope.createPrivateGateway = function(size) {
        appService.dialogService.openDialog($scope.global.VIEW_URL + "vpc/add-private-gateway.jsp", size, $scope, [
                '$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
                    $scope.cancel = function() {
                        $modalInstance.close();
                    };
                } ]);
    };

    $scope.acquireNewIp = function(size) {
        appService.dialogService.openDialog($scope.global.VIEW_URL + "vpc/acquire-newip.jsp", size, $scope, [ '$scope',
                '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
                    $scope.cancel = function() {
                        $modalInstance.close();
                    };
                } ]);
    };
    $scope.addAcl = function(size) {
        appService.dialogService.openDialog($scope.global.VIEW_URL + "vpc/add-acl.jsp", size, $scope, [ '$scope',
                '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
                    $scope.cancel = function() {
                        $modalInstance.close();
                    };
                } ]);
    };

    $scope.openAddInstance = function(size) {
        appService.dialogService.openDialog("app/views/cloud/instance/add.jsp", size, $scope, [ '$scope',
                '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
                    $scope.cancel = function() {
                        $modalInstance.close();
                    };
                } ]);
    };

    $scope.$on(appService.globalConfig.webSocketEvents.vpcEvents.createVPC, function(event, args) {
        appService.globalConfig.webSocketLoaders.vpcLoader = false;
        appService.notify({
            message: "VPC created successfully",
            classes: 'alert-success',
            templateUrl: $scope.global.NOTIFICATION_TEMPLATE
        });
        $scope.list(1);
    });
    $scope.$on(appService.globalConfig.webSocketEvents.vpcEvents.editVPC, function(event, args) {
        appService.globalConfig.webSocketLoaders.vpcLoader = false;
        $scope.type = "view";
        if (!angular.isUndefined($stateParams.id) && $stateParams.id > 0) {
            $scope.edit($stateParams.id);
            $window.location.href = '#/vpc/view-vpc/' + $stateParams.id;
        }
    });
    $scope.$on(appService.globalConfig.webSocketEvents.vpcEvents.restartVPC, function(event, args) {
        appService.globalConfig.webSocketLoaders.vpcLoader = false;
        $scope.list(1);
    });
    $scope.$on(appService.globalConfig.webSocketEvents.vpcEvents.deleteVPC, function(event, args) {
        appService.globalConfig.webSocketLoaders.vpcLoader = false;
        $scope.list(1);
    });
}
