/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * vpcCtrl
 *
 */

angular.module('homer').controller('vpcCtrl', vpcCtrl)

function vpcCtrl($scope,$rootScope, $modal, appService, filterFilter, $stateParams,$state, localStorageService, promiseAjax, $window, $location) {
    $scope.global = appService.globalConfig;
    $scope.vpc = {};
    $scope.formElements = {};
    $scope.showLoader = false;
    $scope.paginationObject = {};
    $scope.sort = appService.globalConfig.sort;
    $scope.changeSorting = appService.utilService.changeSorting;
    appService.globalConfig.webSocketLoaders.vpcLoader = false;
    appService.globalConfig.webSocketLoaders.vpnLoader = false;
    appService.globalConfig.webSocketLoaders.ipLoader = false;
    $scope.paginationObject.sortOrder = '+';
    $scope.paginationObject.sortBy = 'name';
    $scope.vpcList = [];
    $scope.portList = [];
    $scope.vpcForm = {};
    $scope.portvmList = {};
    $scope.vpcPersist = {};
    $scope.vpcCreateNetwork = {};
    $scope.vpcNetworkList = {};
    $scope.ipList = {};
    $scope.ipDetails = {};
    $scope.vpnUsersList = {};
    $scope.instances = {};
    $scope.natInstance = {};
    $scope.vpcNetworkNatList = {};
    $scope.instanceLists = [];
    $scope.instanceLists.ipAddress = {};
    $scope.networkIdu = {};
    $scope.templateCategory = $scope.tabview;
    $scope.portForward = {};
    $scope.portform = {};

    $scope.type = $stateParams.view;
    // VPC Offer List
    $scope.listVpcOffer = function() {
        var listVpcOffers = appService.promiseAjax
                .httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "vpcoffering/list" + "?lang=" + appService.localStorageService.cookie
                        .get('language') + "&sortBy=-id");
        listVpcOffers.then(function(result) {
            $scope.networkOfferList = result;
        });
    };
    if ($stateParams.id > 0  && $location.path() == '/vpc/view/' + $stateParams.id ) {
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
            $scope.listVpcNetwork($stateParams.id);
            $scope.listVpcNetworkByPortforwarding($stateParams.id);
            $scope.listVpcNetworkForLB($scope.vpc.id);
            $scope.vpcTiers($stateParams.id);
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
    	if (!angular.isUndefined($stateParams.id)) {
        var hasDomains = appService.promiseAjax.httpTokenRequest(appService.crudService.globalConfig.HTTP_GET, appService.crudService.globalConfig.APP_URL + "vpcacl"  +"/list/"+$stateParams.id);
        hasDomains.then(function(result) { // this is only run after $http
            // completes0
            $scope.aclList = result;
        });
      }
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

   // VPC Network List
    $scope.listVpcNetworkByPortforwarding = function(vpcId) {
    	var listVpcNetworks = appService.promiseAjax.httpTokenRequest( appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "guestnetwork/vpcNetworkLists?vpcId=" + vpcId + "&type=" +"PortForwarding" +"&sortBy=-id");
        listVpcNetworks.then(function(result) {
            $scope.vpcNetworkListByPortforwarding = result;
        });
    };

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
            appService.localStorageService.set('view', null);
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


$scope.dropnetworkLists = {
        views: [{
            id: 1,
            name: 'Guest Networks'
        }, {
            id: 2,
            name: 'Security Groups'
        }, {
            id: 3,
            name: 'VPC'
        }, {
            id: 4,
            name: 'VPN Customer Gateway'
        }],
        protocols: [{
            id: 1,
            name: 'TCP',
            value: 'TCP'
        }, {
            id: 2,
            name: 'UDP',
            value: 'UDP'
        }, {
            id: 3,
            name: 'ICMP',
            value: 'ICMP'
        }, {
            id: 4,
            name: 'All',
            value: 'All'
        }],
        portProtocols: [{
            id: 1,
            name: 'TCP',
            value: 'TCP'
        }, {
            id: 2,
            name: 'UDP',
            value: 'UDP'
        }, ],
        fireProtocols: [{
            id: 1,
            name: 'TCP',
            value: 'TCP'
        }, {
            id: 2,
            name: 'UDP',
            value: 'UDP'
        }, {
            id: 3,
            name: 'ICMP',
            value: 'ICMP'
        }],
        algorithms: [{
            id: 1,
            name: 'Round-robin',
            value: 'roundrobin'
        }, {
            id: 2,
            name: 'Least connections',
            value: 'leastconn'
        }, {
            id: 3,
            name: 'Source',
            value: 'source'
        }]
    };
    $scope.tcp = true;
    $scope.udp = true;
    $scope.selectProtocol = function(selectedItem) {
        if (selectedItem == 'TCP' || selectedItem == 'UDP') {
            $scope.tcp = true;
            $scope.udp = true;
            $scope.icmp = false;
            delete $scope.firewallRules.icmpMessage;
            delete $scope.firewallRules.icmpCode;
        }
        if (selectedItem == 'ICMP') {
            $scope.icmp = true;
            $scope.tcp = false;
            $scope.udp = false;
            delete $scope.firewallRules.startPort;
            delete $scope.firewallRules.endPort;
        }
        if (selectedItem == 'All') {
            $scope.tcp = false;
            $scope.udp = false;
            $scope.icmp = false;
            delete $scope.firewallRules.icmpMessage;
            delete $scope.firewallRules.icmpCode;
            delete $scope.firewallRules.startPort;
            delete $scope.firewallRules.endPort;
        }
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
                            appService.notify({
                                message: "Added successfully",
                                classes: 'alert-success',
                                templateUrl: $scope.global.NOTIFICATION_TEMPLATE
                            });
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

    // Delete the Network
    $scope.deleteNetwork = function(size, network) {
        appService.dialogService.openDialog("app/views/cloud/network/confirm-delete.jsp", size, $scope, ['$scope', '$modalInstance', function($scope, $modalInstance) {
            $scope.deleteId = network.id;
            $scope.ok = function(networkId) {
                    $scope.showLoader = true;
                    appService.globalConfig.webSocketLoaders.networkLoader = true;
                    $modalInstance.close();
                    var hasNetworks = appService.crudService.softDelete("guestnetwork", network);
                    hasNetworks.then(function(result) {
                        $scope.showLoader = false;
                    }).catch(function(result) {
                        if (!angular.isUndefined(result.data) && result.data.fieldErrors != null) {
                            angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                                $scope.addnetworkForm[key].$invalid = true;
                                $scope.addnetworkForm[key].errorMessage = errorMessage;
                            });
                        }
                        $modalInstance.close();
                        $scope.showLoader = false;
                        appService.globalConfig.webSocketLoaders.networkLoader = false;
                    });
                        $window.location.href = '#/vpc/view/' + $stateParams.id + '/config-vpc/';
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };

   $scope.updateNetwork = function(form) {
alert("++++++++");
        $scope.formSubmitted = true;
        if (form.$valid) {
            var network = $scope.network;
            $scope.showLoader = true;
            if (!angular.isUndefined($scope.network.domain)) {
                network.domainId = $scope.network.domain.id;
                delete network.domain;
            }
            if (!angular.isUndefined($scope.network.department) && $scope.network.department != null) {
                network.departmentId = $scope.network.department.id;
                delete network.department;
            }
            if (!angular.isUndefined($scope.network.project) && $scope.network.project != null) {
                network.projectId = $scope.network.project.id;
                delete network.project;
            }
            network.zoneId = $scope.network.zone.id;
            network.networkOfferingId = $scope.network.networkOffering.id;
            delete network.zone;
            delete network.networkOffering;
            appService.globalConfig.webSocketLoaders.networkLoader = true;
            var hasNetwork = appService.crudService.update("guestnetwork", network);
            hasNetwork.then(function(result) {
                $scope.showLoader = false;
                $scope.formSubmitted = false;
            }).catch(function(result) {
                if (!angular.isUndefined(result.data) && result.data.fieldErrors != null) {
                    angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                        $scope.addnetworkForm[key].$invalid = true;
                        $scope.addnetworkForm[key].errorMessage = errorMessage;
                    });
                }
                $scope.showLoader = false;
                appService.globalConfig.webSocketLoaders.networkLoader = false;
            });
        }
    };

    if ($stateParams.idNetwork > 0) {
        $scope.showLoader = true;
        $scope.showLoaderOffer = true;

            var hasServer = appService.crudService.read("guestnetwork", $stateParams.idNetwork);
        hasServer.then(function(result) {
            $scope.showLoader = false;

            $scope.network = result;
   
        });
    }
        $scope.type = $stateParams.view;

    $scope.networkRestart = {};
    // Restart the Network
    $scope.restartNetwork = function(size, network) {
        appService.dialogService.openDialog("app/views/cloud/network/restart-network.jsp", size, $scope, ['$scope', '$modalInstance', function($scope, $modalInstance) {
            $scope.ok = function(restart) {
                    $scope.networkRestart = restart;
                    $scope.showLoader = true;
                    appService.globalConfig.webSocketLoaders.networkLoader = true;
                    $modalInstance.close();
                    var hasServer = appService.crudService.add("guestnetwork/restart/" + network.id, network);
                    hasServer.then(function(result) { // this is only run after $http completes
                        $scope.showLoader = false;
                    }).catch(function(result) {
                        if (!angular.isUndefined(result.data)) {
                            if (result.data.fieldErrors != null) {
                                angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                                    $scope.addnetworkForm[key].$invalid = true;
                                    $scope.addnetworkForm[key].errorMessage = errorMessage;
                                });
                            }
                        }
                        $scope.showLoader = false;
                        appService.globalConfig.webSocketLoaders.networkLoader = false;
                        $modalInstance.close();
                    });
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };



if (!angular.isUndefined($stateParams.id2) && $stateParams.id2 > 0) {
  var listVpcOffers = appService.promiseAjax
                .httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "nics/listbynetwork"+"?networkid="+$stateParams.id2 );
        listVpcOffers.then(function(result) {
            $scope.vpcVmList = result;
});
}

 // VPC Network List
    $scope.listVpcNetworkForLB = function(vpcId) {
    	var listVpcNetworksLB = appService.promiseAjax.httpTokenRequest( appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "guestnetwork/vpcNetworkLists?vpcId=" + vpcId + "&type=" +"Lb" +"&sortBy=-id");
        listVpcNetworksLB.then(function(result) {
            $scope.vpcNetworkListForLB = result;
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

 // Load balancer
 $scope.LBlist = function(loadBalancer) {
        $scope.templateCategory = 'load-balance';
        $scope.rulesvmList = {};
        $scope.stickiness = {};
        $scope.loadBalancer = {};
        $scope.loadFormSubmitted = false;
        var ipAddressId = $stateParams.id1;
if (!angular.isUndefined($stateParams.id1)) {
        var hasloadBalancer = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "loadBalancer/list?ipAddressId=" + $stateParams.id1 + "&lang=" + appService.localStorageService.cookie.get('language') + "&sortBy=-id");
        hasloadBalancer.then(function(result) {
            $scope.rulesList = result;
        });
    };
}
 $scope.LBlist();

    $scope.openAddVM = function(form) {
        $scope.loadFormSubmitted = true;
        if (form.$valid ) {
            $scope.global.rulesLB[0].name = $scope.loadBalancer.name;
            $scope.global.rulesLB[0].publicPort = $scope.loadBalancer.publicPort;
            $scope.global.rulesLB[0].privatePort = $scope.loadBalancer.privatePort;
            $scope.global.rulesLB[0].algorithm = $scope.loadBalancer.algorithms.value;
            //modalService.trigger('app/views/cloud/network/vm-list.jsp', 'lg');
	   
            $scope.loadBalancer.vmIpaddress = [];

            appService.dialogService.openDialog("app/views/vpc/vm-list.jsp", 'lg', $scope, ['$scope', '$modalInstance', function($scope, $modalInstance) {
                $scope.lbvmLists = function() {
                    $scope.lbvmList = [];
                    var networkId = $scope.loadBalancer.vpcnetwork.id;
                    var hasVms = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "nics/listbynetwork?networkid=" + networkId + "&lang=" + appService.localStorageService.cookie.get('language') + "&sortBy=-id");
                    hasVms.then(function(result) { // this is only run after $http
                        $scope.lbvmList = result;
                    });
                };
                $scope.lbvmLists();
 $scope.loadbalancerSave = function(loadBalancer) {
                        loadBalancer.vmIpAddress = [];
                        $scope.loadBalancer = $scope.global.rulesLB[0];
                        $scope.showLoader = true;
			//state-param id to be changed
                        $scope.loadBalancer.ipAddressId = $stateParams.id1;
                        // var loadBalancer = angular.copy($scope.loadBalancer);
                        $scope.loadBalancer.protocol = $scope.loadBalancer.protocol.toUpperCase();
                        $scope.loadBalancer.state = $scope.loadBalancer.state.toUpperCase();
                        $scope.loadBalancer.state = $scope.loadBalancer.state.toUpperCase();
			$scope.loadBalancer.networkId = loadBalancer[0].networkId;
	var hasError = true;
	var assignedVmIpCount = 0;
	var selectedVmCount = 0;
                            angular.forEach(loadBalancer, function(obj, key) {
	  if(!angular.isUndefined(obj.lbvm))
		selectedVmCount++;
		if(angular.isArray(obj.ipAddress)) {
			assignedVmIpCount++;
		   	angular.forEach(obj.ipAddress, function(vmIpAddress, vmIpAddressKey) {
                                        loadBalancer.vmIpAddress.push(vmIpAddress);
                                    })
                                }
	  	})

		if(selectedVmCount == 0) {
			$scope.homerTemplate = 'app/views/notification/notify.jsp';
            		appService.notify({message: 'Please choose atleast one VM Instance and associated Ip Address from given List', classes: 'alert-danger', "timeOut": "1000", templateUrl: $scope.homerTemplate});
			          $scope.showLoader = false;
		}
		else if(assignedVmIpCount != selectedVmCount) {
			$scope.homerTemplate = 'app/views/notification/notify.jsp';
            		appService.notify({message: 'Please assign Ip Address for all the selected VM Instances', classes: 'alert-danger', "timeOut": "1000", templateUrl: $scope.homerTemplate});
				$scope.showLoader = false;
		}
		else {
                            $scope.loadBalancer.vmIpAddress = loadBalancer.vmIpAddress;
                            $scope.loadBalancer.lbPolicy = {};
                            var loadBalancerParams = ["stickinessMethod", "stickinessName", "stickyTableSize", "cookieName", "stickyExpires", "stickyMode", "stickyLength", "stickyRequestLearn", "stickyPrefix", "stickyNoCache", "stickyIndirect", "stickyPostOnly", "stickyCompany"];
                            for (var i = 0; i < loadBalancerParams.length; i++) {
                                if (!angular.isUndefined($scope.stickiness[loadBalancerParams[i]]) && $scope.stickiness[loadBalancerParams[i]] != null) {
                                    $scope.loadBalancer.lbPolicy[loadBalancerParams[i]] = $scope.stickiness[loadBalancerParams[i]];
                                }
                            }
                            delete $scope.loadBalancer.lbPolicy.stickyTableSize;
                            delete $scope.loadBalancer.lbPolicy.stickyExpires;
                            delete $scope.loadBalancer.lbPolicy.stickyMode;
                            delete $scope.loadBalancer.lbPolicy.stickyLength;
                            delete $scope.loadBalancer.lbPolicy.stickyHoldTime;
                            delete $scope.loadBalancer.lbPolicy.cookieName;
                            delete $scope.loadBalancer.lbPolicy.stickyRequestLearn;
                            delete $scope.loadBalancer.lbPolicy.stickyPrefix;
                            delete $scope.loadBalancer.lbPolicy.stickyPostOnly;
                            delete $scope.loadBalancer.lbPolicy.stickyIndirect;
                            delete $scope.loadBalancer.lbPolicy.stickyNoCache;
                            appService.globalConfig.webSocketLoaders.loadBalancerLoader = true;
                              $modalInstance.close();
                            var hasLoadBalancer = appService.crudService.add("loadBalancer", $scope.loadBalancer);
                            hasLoadBalancer.then(function(result) { // this is only run after
                                $scope.formSubmitted = false;
                                $scope.showLoader = false;
                            }).catch(function(result) {
                                $scope.showLoader = false;
                                $modalInstance.close();
                                if (!angular.isUndefined(result.data)) {
                                    if (result.data.fieldErrors != null) {
                                        $scope.showLoader = false;
                                        angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                                            $scope.loadBalancerForm[key].$invalid = true;
                                            $scope.loadBalancerForm[key].errorMessage = errorMessage;
                                            $scope.showLoader = false;
                                            $modalInstance.close();
                                        });
                                    }
                                }
                                appService.globalConfig.webSocketLoaders.loadBalancerLoader = false;
                            })
                        }
                    },
                    $scope.cancel = function() {
                        $modalInstance.close();
                    };
            }]);
        }
    };
    $scope.openAddVMlist = function() {
        $scope.showLoader = false;
        appService.dialogService.openDialog("app/views/vpc/vm-list.jsp", 'lg', $scope, ['$scope', '$modalInstance', function($scope, $modalInstance) {
            $scope.ok = function() {},
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
        $scope.global.rulesLB[0].name = $scope.loadBalancer.name;
        $scope.global.rulesLB[0].publicPort = $scope.loadBalancer.publicPort;
        $scope.global.rulesLB[0].privatePort = $scope.loadBalancer.privatePort;
        // $scope.global.rulesLB[0].algorithm = $scope.loadBalancer.algorithms.value;
    };
    $scope.instance = {};
    // apply rule to new vm
    $scope.applyNewRule = function(size, loadBalancer) {
        appService.dialogService.openDialog("app/views/vpc/vm-list.jsp", 'lg', $scope, ['$scope', '$modalInstance', function($scope, $modalInstance) {
            $scope.lbvmLists = function() {
                $scope.lbvmList = [];
                var networkId = $scope.loadBalancer.vpcnetwork.id;
                var hasVms = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "nics/listbynetwork?networkid=" + networkId + "&lang=" + appService.localStorageService.cookie.get('language') + "&sortBy=-id");
                hasVms.then(function(result) { // this is only run after $http
                    $scope.lbvmList = result;
                });
            };
            $scope.lbvmLists();
            $scope.loadBalancer = angular.copy(loadBalancer);
            $scope.loadbalancerSave = function(loadBalancerVmList) {
                    var loadBalancer = {};
                    loadBalancer.id = $scope.loadBalancer.id;
                    loadBalancer.name = $scope.loadBalancer.name;
                    loadBalancer.algorithm = $scope.loadBalancer.algorithm;
                    loadBalancer.vmIpAddress = [];
                    angular.forEach(loadBalancerVmList, function(obj, key) {
                        if (obj.lbvm && angular.isArray(obj.ipAddress)) {
                            angular.forEach(obj.ipAddress, function(vmIpAddress, vmIpAddressKey) {
                                loadBalancer.vmIpAddress.push(vmIpAddress);
                            })
                        }
                    })
                    if (loadBalancer.algorithm == $scope.global.STICKINESS.NONE) {
                        delete loadBalancer.algorithm;
                    }
                    $scope.showLoader = true;
                    var hasServer = appService.crudService.update("loadBalancer", loadBalancer);
                    hasServer.then(function(result) {
                        $scope.LBlist(1);
                        appService.notify({
                            message: 'Rules assigned to IP successfully ',
                            classes: 'alert-success',
                            templateUrl: $scope.global.NOTIFICATION_TEMPLATE
                        });
                        $modalInstance.close();
                        $scope.showLoader = false;
                    }).catch(function(result) {
                        if (!angular.isUndefined(result) && result.data != null) {
                            angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                                $scope.showLoader = false;
                                $scope.loadBalancerForm[key].$invalid = true;
                                $scope.loadBalancerForm[key].errorMessage = errorMessage;
                            });
                        }
                    });
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };
    $scope.loadBalancer.algorithm = {};
    // Edit the load balancer
    $scope.editrule = function(size, loadBalancer) {
        appService.dialogService.openDialog("app/views/vpc/edit-rule.jsp", size, $scope, ['$scope', '$modalInstance', function($scope, $modalInstance) {
            $scope.loadBalancer = angular.copy(loadBalancer);
            angular.forEach($scope.dropnetworkLists.algorithms, function(obj, key) {
                if (obj.value == $scope.loadBalancer.algorithm) {
                    $scope.loadBalancer.algorithm = obj;
                }
            });
            $scope.updateRule = function(form, loadBalancer) {
                    $scope.loadBalancer = angular.copy(loadBalancer);
                    $scope.loadBalancer.algorithm = loadBalancer.algorithm.value;
                    var loadBalancer = $scope.loadBalancer;
                    $scope.formSubmitted = true;
                    if (form.$valid) {
                        $scope.showLoader = true;
                        $modalInstance.close();
                        appService.globalConfig.webSocketLoaders.loadBalancerLoader = true;
                        var hasServer = appService.crudService.update("loadBalancer", loadBalancer);
                        hasServer.then(function(result) {
                            $modalInstance.close();
                            $scope.showLoader = false;
                           appService.globalConfig.webSocketLoaders.loadBalancerLoader = true;
                        }).catch(function(result) {
                            if (!angular.isUndefined(result) && result.data != null) {
                                $scope.showLoader = false;
                                angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                                    $scope.loadBalancerForm[key].$invalid = true;
                                    $scope.loadBalancerForm[key].errorMessage = errorMessage;
                                });
                            }
                            $modalInstance.close();
                            appService.globalConfig.webSocketLoaders.loadBalancerLoader = false;
                        });
                    }
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };
    $scope.deleteRules = function(size, loadBalancer) {
        appService.dialogService.openDialog("app/views/vpc/delete-rule.jsp", 'sm', $scope, ['$scope', '$modalInstance', function($scope, $modalInstance) {
            $scope.deleteObject = loadBalancer;
            $scope.delete = function(deleteObject) {
                    appService.globalConfig.webSocketLoaders.loadBalancerLoader = true;
                    var hasServer = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_DELETE, appService.globalConfig.APP_URL + "loadBalancer/delete/" + loadBalancer.id + "?lang=" + appService.localStorageService.cookie.get('language'), '', loadBalancer);
                    hasServer.then(function(result) {
                   }).catch(function(result) {
                        if (!angular.isUndefined(result) && result.data != null) {
                            angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                                $scope.domainForm[key].$invalid = true;
                                $scope.domainForm[key].errorMessage = errorMessage;
                            });
                        }
                        $modalInstance.close();
                        appService.globalConfig.webSocketLoaders.loadBalancerLoader = false;
                    });
                    $modalInstance.close();
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };

  // Create a new sticky policy
    //Add the sticky policy
    $scope.createStickiness = function(size) {
        appService.dialogService.openDialog($scope.global.VIEW_URL + "vpc/stickiness.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
            //Assign loadbalancer stickiness in object
            $scope.addStickiness = function(form, stickiness) {
                    $scope.stickiness = stickiness;
                    $scope.formSubmitted = true;
                    if ($scope.stickiness.stickinessMethod == $scope.global.STICKINESS.NONE) {
                        $modalInstance.close();
                    }
                    if (form.$valid) {
                        appService.notify({
                            message: 'Configured sticky policy successfully',
                            classes: 'alert-success',
                            templateUrl: $scope.global.NOTIFICATION_TEMPLATE
                        });
                        $modalInstance.close();
                    }
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };
    $scope.stickyLoadBalancer = {};
    $scope.configureStickiness = function(size, loadBalancer) {
        appService.dialogService.openDialog($scope.global.VIEW_URL + "vpc/stickiness.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
            $scope.stickyLoadBalancer = loadBalancer;
            //Assign loadbalancer stickiness in object
            $scope.addStickiness = function(form, stickiness) {
                    $scope.stickyLoadBalancer.lbPolicy = {};
                    $scope.formSubmitted = true;
                    if (!angular.isUndefined($scope.stickyLoadBalancer.id) && $scope.stickyLoadBalancer.id != null) {
                        var loadBalancerParams = ["stickinessMethod", "stickinessName", "stickyTableSize", "cookieName", "stickyExpires", "stickyMode", "stickyLength", "stickyRequestLearn", "stickyPrefix", "stickyNoCache", "stickyIndirect", "stickyPostOnly", "stickyCompany"];
                        if (angular.isUndefined($scope.stickiness.stickinessName) || $scope.stickiness.stickinessName == null) {
                            $scope.showLoader = false;
                        }
                        if ($scope.stickiness.stickinessMethod == $scope.global.STICKINESS.NONE) {
                            $modalInstance.close();
                        } else {
                            if (form.$valid) {
                                for (var i = 0; i < loadBalancerParams.length; i++) {
                                    if (!angular.isUndefined(stickiness[loadBalancerParams[i]]) && stickiness[loadBalancerParams[i]] != null) {
                                        $scope.stickyLoadBalancer.lbPolicy[loadBalancerParams[i]] = $scope.stickiness[loadBalancerParams[i]];
                                    }
                                }
                                delete $scope.stickyLoadBalancer.stickyTableSize;
                                delete $scope.stickyLoadBalancer.stickyExpires;
                                delete $scope.stickyLoadBalancer.cookieName;
                                delete $scope.stickyLoadBalancer.domain;
                                $scope.showLoader = true;
                                $modalInstance.close();
                                var hasServer = appService.crudService.update("loadBalancer", $scope.stickyLoadBalancer);
                                hasServer.then(function(result) {
                                    $scope.formSubmitted = false;
                                    $scope.showLoader = false;
                                    $scope.stickiness = {};
				    //appService.globalConfig.webSocketLoaders.loadBalancerLoader = true;
                                }).catch(function(result) {
                                    appService.globalConfig.webSocketLoaders.loadBalancerLoader = false;
                                });
                            }
                        }
                    }
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                    $scope.formElements = {};
                };
        }]);
    };
    $scope.formElements = {
        stickinessList: [{
            id: 1,
            name: ''
        }, {
            id: 2,
            name: 'SourceBased'
        }, {
            id: 3,
            name: 'AppCookie'
        }, {
            id: 4,
            name: 'LbCookie'
        }, ]
    };
    //Add the sticky policy
    $scope.editStickiness = function(size, loadBalancer) {
            $scope.stickyLoadBalancer = loadBalancer;
            appService.dialogService.openDialog($scope.global.VIEW_URL + "vpc/edit-stickiness.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
                var loadBalancerParams = ["stickinessMethod", "stickinessName", "stickyTableSize", "cookieName", "stickyExpires", "stickyMode", "stickyLength", "stickyRequestLearn", "stickyPrefix", "stickyNoCache", "stickyIndirect", "stickyPostOnly", "stickyCompany"];
                angular.forEach($scope.formElements.stickinessList, function(value, key) {
                    for (var i = 0; i < loadBalancerParams.length; i++) {
                        if (!angular.isUndefined(loadBalancer[loadBalancerParams[i]]) && loadBalancer[loadBalancerParams[i]] != null) {
                            $scope.stickiness[loadBalancerParams[i]] = loadBalancer[loadBalancerParams[i]];
                        }
                    }
                });
                $scope.editStickinessPolicy = function(form, loadBalancer) {
                    $scope.showLoader = true;
                    $scope.formSubmitted = true;
                    if ($scope.stickiness.stickinessMethod == $scope.global.STICKINESS.NONE) {
                        $modalInstance.close();
                    } else {
                        for (var i = 0; i < loadBalancerParams.length; i++) {
                            if (!angular.isUndefined(loadBalancer[loadBalancerParams[i]]) && loadBalancer[loadBalancerParams[i]] != null) {
                                $scope.stickyLoadBalancer[loadBalancerParams[i]] = loadBalancer[loadBalancerParams[i]];
                            }
                        }
                        delete $scope.stickyLoadBalancer.stickyTableSize;
                        delete $scope.stickyLoadBalancer.stickyExpires;
                        delete $scope.stickyLoadBalancer.stickyMode;
                        delete $scope.stickyLoadBalancer.stickyLength;
                        delete $scope.stickyLoadBalancer.stickyHoldTime;
                        delete $scope.stickyLoadBalancer.cookieName;
                        delete $scope.stickyLoadBalancer.stickyRequestLearn;
                        delete $scope.stickyLoadBalancer.stickyPrefix;
                        delete $scope.stickyLoadBalancer.stickyPostOnly;
                        delete $scope.stickyLoadBalancer.stickyIndirect;
                        delete $scope.stickyLoadBalancer.stickyNoCache;
                        $scope.showLoader = true;
                        $modalInstance.close();
                        appService.globalConfig.webSocketLoaders.loadBalancerLoader = true;
                        var hasServer = appService.crudService.update("LbStickinessPolicy", $scope.stickyLoadBalancer);
                        hasServer.then(function(result) {
                            $scope.stickiness = {};
                            $scope.showLoader = false;
                        }).catch(function(result) {
                            $modalInstance.close();
                            $scope.showLoader = false;
                            appService.globalConfig.webSocketLoaders.loadBalancerLoader = false;
                        });
                    }
                }, $scope.cancel = function() {
                    $modalInstance.close();
                };
            }]);
        },
        $scope.formElements = {
            stickinessList: [
                $scope.global.STICKINESS.NONE,
                $scope.global.STICKINESS.SOURCEBASED,
                $scope.global.STICKINESS.APPCOOKIE,
                $scope.global.STICKINESS.LBCOOKIE
            ],
        };

$scope.removeRule = function(size, vmIpAddress, loadBalancer) {
        appService.dialogService.openDialog("app/views/cloud/instance/confirm-delete.jsp", 'md', $scope, ['$scope', '$modalInstance', function($scope, $modalInstance) {
                $scope.ok = function(deleteObject) {
                    loadBalancer.vmIpAddress = [];
                    loadBalancer.vmIpAddress.push(vmIpAddress);
                    $scope.deleteObject = loadBalancer;
                    $scope.showLoader = true;
                    $modalInstance.close();
                    appService.globalConfig.webSocketLoaders.networkLoader = true;
                    var hasNic = appService.crudService.updates("loadBalancer/removerule/", $scope.deleteObject);
                    hasNic.then(function(result) {
                        $scope.showLoader = false;
                    }).catch(function(result) {
                            if (result.data.fieldErrors != null) {
                                angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                                    $scope.attachvolumeForm[key].$invalid = true;
                                    $scope.attachvolumeForm[key].errorMessage = errorMessage;
                                });
                            }
                            appService.globalConfig.webSocketLoaders.networkLoader = false;
                    });
            },
            $scope.cancel = function() {
                $modalInstance.close();
            };
        }]);
};

$scope.dropnetworkLists = {
        views: [{
            id: 1,
            name: 'Guest Networks'
        }, {
            id: 2,
            name: 'Security Groups'
        }, {
            id: 3,
            name: 'VPC'
        }, {
            id: 4,
            name: 'VPN Customer Gateway'
        }],
        protocols: [{
            id: 1,
            name: 'TCP',
            value: 'TCP'
        }, {
            id: 2,
            name: 'UDP',
            value: 'UDP'
        }, {
            id: 3,
            name: 'ICMP',
            value: 'ICMP'
        }, {
            id: 4,
            name: 'All',
            value: 'All'
        }],
        portProtocols: [{
            id: 1,
            name: 'TCP',
            value: 'TCP'
        }, {
            id: 2,
            name: 'UDP',
            value: 'UDP'
        }, ],
        fireProtocols: [{
            id: 1,
            name: 'TCP',
            value: 'TCP'
        }, {
            id: 2,
            name: 'UDP',
            value: 'UDP'
        }, {
            id: 3,
            name: 'ICMP',
            value: 'ICMP'
        }],
        algorithms: [{
            id: 1,
            name: 'Round-robin',
            value: 'roundrobin'
        }, {
            id: 2,
            name: 'Least connections',
            value: 'leastconn'
        }, {
            id: 3,
            name: 'Source',
            value: 'source'
        }]
    };

    $scope.createPrivateGateway = function(size) {
        appService.dialogService.openDialog($scope.global.VIEW_URL + "vpc/add-private-gateway.jsp", size, $scope, [
                '$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
                    $scope.cancel = function() {
                        $modalInstance.close();
                    };
                } ]);
    };
    $scope.vpnUserList = function(ipDetatils) {
        var domainId = ipDetatils.vpc.domainId;
        if(ipDetatils.vpc.departmentId != null){
            var departmentId = ipDetatils.vpc.departmentId;
            $scope.showLoader = true;
            var hasVpnUser = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "vpnUser/listbyvpnuser?domainId=" + domainId + "&departmentId=" + departmentId + "&lang=" + appService.localStorageService.cookie.get('language') + "&sortBy=-id");
            hasVpnUser.then(function(result) {
                $scope.vpnUsersList = result;
                $scope.showLoader = false;
            });
        }
        else {
            var projectId = ipDetatils.vpc.projectId;
            $scope.showLoader = true;
            var hasVpnUser = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "vpnUser/listbyvpnusers?domainId=" + domainId + "&projectId=" + projectId + "&lang=" + appService.localStorageService.cookie.get('language') + "&sortBy=-id");
            hasVpnUser.then(function(result) {
                $scope.vpnUsersList = result;
                $scope.showLoader = false;
            });
        }
    };

    $scope.editIpaddress = function(ipaddressId) {
        var hasIpaddress = appService.crudService.read("ipAddresses", ipaddressId);
        hasIpaddress.then(function(result) {
            $scope.ipDetails = result;
            $scope.vpnUserList($scope.ipDetails);
            appService.localStorageService.set('view', 'ipdetails');
        });
    };

    $scope.ipLists = function(pageNumber) {
        appService.localStorageService.set('view', 'ipdetails');
        $scope.tabview = appService.localStorageService.get('view');
        $scope.templateCategory = $scope.tabview;
        $scope.active = true;
        //var networkId = $stateParams.id;
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        if (!angular.isUndefined($stateParams.id)) {
        var hasFirewallRuless = appService.crudService.listAllByQuery("ipAddresses/vpc/iplist?vpc=" + $stateParams.id, $scope.global.paginationHeaders(pageNumber, limit), {
            "limit": limit
        });
        hasFirewallRuless.then(function(result) { // this is only run after
            // $http completes0
            $scope.ipList = result;
            /*$state.current.data.publicIpAddress = result[0].publicIpAddress;
            console.log($state.current.data.publicIpAddress);
            console.log(result[0].publicIpAddress);*/
            // For pagination
            $scope.paginationObject.limit = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
        });
        }
    };
    $scope.ipLists(1);

        $scope.tabview = appService.localStorageService.get('view');

    if (!angular.isUndefined($stateParams.id1) && $stateParams.id1 != null && $stateParams.id > 0) {
        if(angular.isUndefined(appService.localStorageService.get('view')) || appService.localStorageService.get('view') == null){
            appService.localStorageService.set('view', $state.current.data.networkTabs);
        }
        $scope.tabview = appService.localStorageService.get('view');
        $scope.editIpaddress($stateParams.id1);
    }

    $scope.openAddIP = function(size, vpc) {
        appService.dialogService.openDialog("app/views/vpc/acquire-IP.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
            $scope.acquire = function(vpc) {
                    $scope.actionAcquire = true;
                    if ($scope.agree == true) {
                        $scope.acquiringIP = true;
                        var hasIP = appService.crudService.listByQuery("ipAddresses/vpc/acquireip?vpc=" + $stateParams.id);
                        hasIP.then(function(result) {
                            $scope.acquiringIP = false;
                            $scope.cancel();
                        }).catch(function(result) {
                            $scope.acquiringIP = false;
                            $scope.showLoader = false;
                            appService.globalConfig.webSocketLoaders.ipLoader = false;
                            $modalInstance.close();
                        });
                    }
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };

    $scope.releaseIP = function(size, ipAddress) {
        $scope.ipAddress = angular.copy(ipAddress);
        appService.dialogService.openDialog("app/views/vpc/release-ip.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
            $scope.release = function(ipAddress) {
                    $scope.showLoader = true;
                    appService.globalConfig.webSocketLoaders.ipLoader = true;
                    $scope.cancel();
                    var hasIP = appService.crudService.listByQuery("ipAddresses/vpc/dissociate?ipuuid=" + ipAddress.uuid);
                    hasIP.then(function(result) {
                        $scope.showLoader = false;
                    }).catch(function(result) {
                        $scope.cancel();
                        appService.globalConfig.webSocketLoaders.ipLoader = false;
                    });
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };

    $scope.webeditIpaddress = function(ipaddressId) {
        var hasIpaddress = appService.crudService.read("ipAddresses", ipaddressId);
        hasIpaddress.then(function(result) {
            $scope.ipDetails = result;
            $scope.vpnUserList($scope.ipDetails);
            appService.localStorageService.set('view', 'ipdetails');
        });
    };

    $scope.vpcTiers = function(vpcId) {
        var listVpcNetworks = appService.promiseAjax.httpTokenRequest( appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "guestnetwork/vpcNetworkLists?vpcId=" + vpcId + "&type=" + "StaticNat" + "&sortBy=-id");
        listVpcNetworks.then(function(result) {
            $scope.vpcNetworkNatList = result;
        });
    };
    $scope.portIPList = function(instance, portvmList, index) {
        angular.forEach(portvmList, function(obj, key) {
                if(key == index) {
                        obj.port = true;
                } else {
                        obj.port = false;
                 }
        })
        var instanceId = instance;
$scope.vmPortId = instance;
        $scope.selected = instanceId;
        $scope.instances = instance;

        var hasPortIP = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "nics/listbynicandinstances?instanceid=" + instanceId + "&lang=" + appService.localStorageService.cookie.get('language') + "&sortBy=-id");
        hasPortIP.then(function(result) {
            $scope.portIPLists = result;
            $scope.showLoader = false;
        });
    };

    $scope.staticNat = function(size, vpc) {
        appService.dialogService.openDialog("app/views/vpc/enable-static-nat.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
                $scope.enableStaticNat = function(network) {
                $scope.actionEnable = true;
                appService.dialogService.openDialog("app/views/vpc/vm-list-enable-nat.jsp", "lg", $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
                    $scope.vmLists = function(network) {
                        $scope.templateCategory = 'instance';
                        $scope.portvmList = [];
                        var networkId = network.id;
                        $scope.networkIdu = network.uuid;
                        var hasVms = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "virtualmachine/network?networkId=" + networkId + "&lang=" + appService.localStorageService.cookie.get('language') + "&sortBy=-id");
                        hasVms.then(function(result) { // this is only run after $http
                            $scope.portvmList = result;
                        });
                    },
                    $scope.enableStaticNatSave = function(natInstance) {
                        $scope.staticNat = $scope.global.rulesPF[0];
                        $scope.formSubmitted = true;
                        $scope.showLoader = true;
                        $scope.staticNat.vmInstanceId = $scope.natInstance.id;
                        $scope.staticNat.networkId = $stateParams.id;
                        $scope.staticNat.vmGuestIp = $scope.natInstance.ipAddress;
                        $scope.vmIpAddress = {};
                                $scope.instance = {};
                                var hasError = true;
                var assignedVmIpCount = 0;
                var selectedVmCount = 0;

                angular.forEach(natInstance, function(obj, key) {
                   if(obj.port== true) {
                selectedVmCount++;
             }
                        if(!angular.isUndefined(obj.port) && !angular.isUndefined(obj.ipAddress)) {
                                $scope.vmId = obj.id;
                                $scope.vmIpAddress = obj.ipAddress;
                                assignedVmIpCount = 1;
                           }
                        })
                        if(selectedVmCount == 0) {
                                        $scope.homerTemplate = 'app/views/notification/notify.jsp';
                                        appService.notify({message: 'Please choose atleast one VM Instance and associated Ip Address from given List', classes: 'alert-danger', "timeOut": "1000", templateUrl: $scope.homerTemplate});
                                          $scope.showLoader = false;
                        }
                        else if(assignedVmIpCount != selectedVmCount) {
                                $scope.homerTemplate = 'app/views/notification/notify.jsp';
                                        appService.notify({message: 'Please assign Ip Address for all the selected VM Instances', classes: 'alert-danger', "timeOut": "1000", templateUrl: $scope.homerTemplate});
                                        $scope.showLoader = false;
                        }
                        else {
                        $scope.staticNat.ipAddressId = $stateParams.id1;

                        appService.globalConfig.webSocketLoaders.ipLoader = true;
                        $modalInstance.close();
                        $scope.cancelInst();
                       var hasStaticNat = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "ipAddresses/vpc/nat?ipaddress=" + $scope.staticNat.ipAddressId +
                                "&vm=" + $scope.vmId + "&guestip=" + $scope.vmIpAddress + "&type=" + "enable&networkId=" + $scope.networkIdu  + "&lang=" + appService.localStorageService.cookie.get('language') + "&sortBy=-id");
                        hasStaticNat.then(function(result) {
                            $scope.formSubmitted = false;
                            $scope.showLoader = false;
                        }).catch(function(result) {
                            $scope.showLoader = false;
                            if (!angular.isUndefined(result.data)) {
                                if (result.data.fieldErrors != null) {
                                    $scope.showLoader = false;
                                    angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                                        $scope.staticNatForm[key].$invalid = true;
                                        $scope.staticNatForm[key].errorMessage = errorMessage;
                                        $modalInstance.close();
                                    });
                                }
                            }
                            $modalInstance.close();
                            appService.globalConfig.webSocketLoaders.ipLoader = false;
                        });
                        }

                    },
                    $scope.cancel = function() {
                        $modalInstance.close();
                    };
                }]);
            },
            $scope.cancelInst = function() {
                $modalInstance.close();
            };
        }]);
    };

    $scope.disableNat = function(size, vpc) {
        appService.dialogService.openDialog("app/views/vpc/disable-static-nat.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
            $scope.disableStaticNat = function(natInstance) {
                    var network = "1";
                    $scope.instances = natInstance;
                    $scope.staticNat = $scope.global.rulesPF[0];
                    $scope.formSubmitted = true;
                    $scope.showLoader = true;
                    $modalInstance.close();
                    appService.globalConfig.webSocketLoaders.ipLoader = true;
                    var hasStaticNat = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "ipAddresses/vpc/nat?ipaddress=" + $stateParams.id1 + "&vm=1&guestip=10.0.1.1&type=" + "disable&networkId=" + network + "&lang=" + appService.localStorageService.cookie.get('language') + "&sortBy=-id");
                    hasStaticNat.then(function(result) {
                        $scope.formSubmitted = false;
                        $scope.showLoader = false;
                    }).catch(function(result) {
                        $scope.showLoader = false;
                        if (!angular.isUndefined(result.data)) {
                            if (result.data.fieldErrors != null) {
                                $scope.showLoader = false;
                                angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                                    $scope.staticNatForm[key].$invalid = true;
                                    $scope.staticNatForm[key].errorMessage = errorMessage;
                                });
                            }
                        }
                        $modalInstance.close();
                        appService.globalConfig.webSocketLoaders.ipLoader = false;
                    });
                    $scope.cancel = function() {
                        $modalInstance.close();
                    };
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };

   $scope.selectTab = function(type) {
        if (type == 'loadBalance') {
            appService.localStorageService.set('view', 'load-balance');
        }
        if (type == 'portForward') {
            appService.localStorageService.set('view', 'port-forward');
        }
        $scope.tabview = appService.localStorageService.get('view');
        $state.reload();
    }

    $scope.enableVpn = function(size, ipAddress) {
        $scope.ipAddress = angular.copy(ipAddress);
        appService.dialogService.openDialog("app/views/vpc/enable-vpn.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
            $scope.enableVpnAccess = function(network) {
                    $scope.showLoader = true;
                    var hasVpn = appService.crudService.listByQuery("ipAddresses/enablevpn?uuid=" + $scope.ipAddress.uuid);
                    hasVpn.then(function(result) {
                        $scope.ipDetails = result;
                        $scope.showLoader = false;
                        $scope.cancel();
                        appService.globalConfig.webSocketLoaders.ipLoader = true;
                       if(($location.path() == '/vpc/view/' + $stateParams.id+'/config-vpc/public-ip'))
                        {
                        appService.localStorageService.set('view', 'vpn-details');
                        $scope.tabview = appService.localStorageService.get('view');
                        $scope.templateCategory = $scope.tabview;
                        $window.location.href = '#/vpc/view/' + $stateParams.id + '/config-vpc/public-ip/ip-address/' + $scope.ipDetails.id;
                        }
                    }).catch(function(result) {
                        $scope.showLoader = false;
                        appService.globalConfig.webSocketLoaders.ipLoader = false;
                        $scope.cancel();
                    });
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };
    $scope.disableVpn = function(size, ipAddress) {
        $scope.ipAddress = angular.copy(ipAddress);
        appService.dialogService.openDialog("app/views/vpc/disable-vpn.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
            $scope.enableVpnAccess = function(network) {
                    $scope.showLoader = true;
                    $scope.cancel();
                    appService.globalConfig.webSocketLoaders.ipLoader = true;
                    var hasVpn = appService.crudService.listByQuery("ipAddresses/disablevpn?uuid=" + $scope.ipAddress.uuid);
                    hasVpn.then(function(result) {
                        $scope.ipDetails = result;
                        $scope.showLoader = false;
                        $scope.ipLists(1);
                    }).catch(function(result) {
                        appService.globalConfig.webSocketLoaders.ipLoader = false;
                        $scope.cancel();
                    });
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };

    $scope.addVpnUser = function(form, user) {
        $scope.vpnFormSubmitted = true;
        if (form.$valid) {
            appService.globalConfig.webSocketLoaders.vpnLoader = true;
            var newUser = user;
            var oldUser;
            if (newUser) { //This will avoid empty data
                angular.forEach($scope.vpnUsersList, function(eachuser) { //For loop
                    if (angular.equals(newUser.userName.toLowerCase(), eachuser.userName.toLowerCase())) { // this line will check whether the data is existing or not
                        oldUser = true;
                        appService.notify({
                            message: 'User already exist',
                            classes: 'alert-danger',
                            templateUrl: $scope.global.NOTIFICATION_TEMPLATE
                        });
                        appService.globalConfig.webSocketLoaders.vpnLoader = false;
                    }
                });
                if (!oldUser) {
                    $scope.showLoader = true;
                    user.domainId = $scope.ipDetails.vpc.domainId;
                    user.departmentId = $scope.ipDetails.vpc.departmentId;
                    if($scope.ipDetails.vpc.projectId != null) {
                        user.projectId = $scope.ipDetails.vpc.projectId;
                    }
                    var hasServer = appService.crudService.add("vpnUser", user);
                    hasServer.then(function(result) {
                        user.userName = "";
                        user.password = "";
                        $scope.vpnFormSubmitted = false;
                        $scope.showLoader = false;
                        $scope.vpnUserList($scope.ipDetails);
                        appService.globalConfig.webSocketLoaders.vpnLoader = false;
                        appService.localStorageService.set('view', 'vpn-details');
                    }).catch(function(result) {
                        appService.globalConfig.webSocketLoaders.vpnLoader = false;
                    });
                }
            }
        }
        $scope.showLoader = false;
    }
    $scope.deleteVpnUser = function(size, user) {
        appService.dialogService.openDialog("app/views/vpc/confirm-delete.jsp", size, $scope, ['$scope', '$modalInstance', function($scope, $modalInstance) {
            $scope.ok = function(deleteVpnUser) {
                    var deleteId = user.id;
                    $scope.showLoader = true;
                    var hasUser = appService.crudService.delete("vpnUser", user.id);
                    hasUser.then(function(result) {
                        $scope.showLoader = false;
                        $scope.editIpaddress($stateParams.id1);
                        appService.localStorageService.set('view', 'vpn-details');
                        $modalInstance.close();
                        //appService.globalConfig.webSocketLoaders.vpnLoader = true;
                    }).catch(function(result) {
                        appService.globalConfig.webSocketLoaders.vpnLoader = false;
                        $modalInstance.close();
                    });
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
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
            $scope.vmlist(1, "Expunging");
            $scope.borderContent = "Expunging";
        });
    };

   $scope.addVM = function(form) {
        $scope.portFormSubmitted = true;
        if (form.$valid) {
            $scope.global.rulesPF[0].privateStartPort = $scope.portForward.privateStartPort;
            $scope.global.rulesPF[0].privateEndPort = $scope.portForward.privateEndPort;
            $scope.global.rulesPF[0].publicStartPort = $scope.portForward.publicStartPort;
            $scope.global.rulesPF[0].publicEndPort = $scope.portForward.publicEndPort;
            $scope.global.rulesPF[0].protocolType = $scope.portForward.protocolType;
            appService.dialogService.openDialog("app/views/vpc/vm-list-port.jsp", "lg", $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
                $scope.portvmLists = function() {
                    $scope.templateCategory = 'instance';
                    $scope.portvmList = [];
                    var networkId = $scope.portForward.vpcnetwork.id;     
                    var hasVms = appService.promiseAjax.httpTokenRequest( appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "nics/listbynetwork?networkid="+networkId +"&lang=" + appService.localStorageService.cookie.get('language')+"&sortBy=-id");
                    hasVms.then(function(result) { // this is only run after $http
                        $scope.portvmList = result;
                    });
                };
                $scope.portvmLists();
                $scope.portforwardSave = function(portinstance) {
                    $scope.instances = portinstance;
                    $scope.portForward = $scope.global.rulesPF[0];
                    $scope.formSubmitted = true;
                    $scope.showLoader = true;
                    $scope.portForward.networkId = portinstance[0].networkId;
                    $scope.vmIpAddress = {};
		    $scope.instance = {};
                    var hasError = true;
	            var assignedVmIpCount = 0;
	            var selectedVmCount = 0;
   	            angular.forEach(portinstance, function(obj, key) {
	  		if(obj.port== true) {
			    selectedVmCount++;
	     		}
			if(!angular.isUndefined(obj.port) && !angular.isUndefined(obj.ipAddress.guestIpAddress)) {
			    $scope.vmIpAddress = obj.ipAddress.guestIpAddress;
			    assignedVmIpCount = 1;
		        }
	  	    })

		if(selectedVmCount == 0) {
			$scope.homerTemplate = 'app/views/notification/notify.jsp';
            		appService.notify({message: 'Please choose atleast one VM Instance and associated Ip Address from given List', classes: 'alert-danger', "timeOut": "1000", templateUrl: $scope.homerTemplate});
			$scope.showLoader = false;
		}
		else if(assignedVmIpCount != selectedVmCount) {
			$scope.homerTemplate = 'app/views/notification/notify.jsp';
            		appService.notify({message: 'Please assign Ip Address for all the selected VM Instances', classes: 'alert-danger', "timeOut": "1000", templateUrl: $scope.homerTemplate});
				$scope.showLoader = false;
		}
		else {
                    $scope.portForward.vmGuestIp = $scope.vmIpAddress;
                    $scope.portForward.vmInstanceId = $scope.vmPortId;
                    $scope.portForward.ipAddressId = $stateParams.id1;
                    $scope.portForward.protocolType = $scope.portForward.protocolType.name;
                    $modalInstance.close();
                    appService.globalConfig.webSocketLoaders.portForwardLoader = true;
                    var hasPortForward = appService.crudService.add("portforwarding", $scope.portForward);
                    hasPortForward.then(function(result) {
                    $scope.formSubmitted = false;
                        $modalInstance.close();
                        $scope.showLoader = false;
                    }).catch(function(result) {
                        $scope.showLoader = false;
                        if (!angular.isUndefined(result.data)) {
                            if (result.data.fieldErrors != null) {
                                $scope.showLoader = false;
                                angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                                    $scope.portForwardForm[key].$invalid = true;
                                    $scope.portForwardForm[key].errorMessage = errorMessage;
                                    $modalInstance.close();
                                });
                            }
                        }
                        $modalInstance.close();
                        appService.globalConfig.webSocketLoaders.portForwardLoader = false;
                    });
}
                };
                 $scope.cancel = function() {
                    $modalInstance.close();
                };
            }]);
        }
    }

   $scope.portRulesLists = function(pageNumber) {

        $scope.showLoader = true;
        $scope.templateCategory = 'port-forward';
        $scope.firewallRules = {};
        $scope.portForward = {};
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasFirewallRuless = appService.crudService.listAllByQuery("portforwarding/list?ipaddress=" + $stateParams.id1, $scope.global.paginationHeaders(pageNumber, limit), {
            "limit": limit
        });
        hasFirewallRuless.then(function(result) { // this is only run after
            $scope.showLoader = true;
            $scope.portList = result;
            $scope.showLoader = false;
            // For pagination
            $scope.paginationObject.limit = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
            appService.localStorageService.set('view', 'port-forward');
            $scope.tabview = appService.localStorageService.get('view');
        });
    };

    $scope.showVpnKey = function(ipDetails) {
        var ipAddressId = ipDetails.id;
        var hasVpn = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "ipAddresses/getvpnkey?id=" + ipAddressId + "&lang=" + appService.localStorageService.cookie.get('language') + "&sortBy=-id");
        hasVpn.then(function(result) {
            $scope.vpnKey = result;
            appService.dialogService.openDialog("app/views/cloud/network/show-vpn-key.jsp", 'md', $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
                $scope.cancel = function() {
                    $modalInstance.close();
                };
            }]);
        });
    };

     if ($stateParams.id > 0  && $location.path() == '/vpc/view/' + $stateParams.id +'/config-vpc' ) {
        $scope.listVpcNetwork($stateParams.id);
    }

    if ($stateParams.id1 > 0  && $location.path() == '/vpc/view/' + $stateParams.id +'/config-vpc/public-ip/ip-address/'+$stateParams.id1){
        $scope.listVpcNetwork($stateParams.id);
        $scope.listVpcNetworkByPortforwarding($stateParams.id);
            $scope.listVpcNetworkForLB($stateParams.id);
        $scope.vpcTiers($stateParams.id);
    }
    
    $scope.deletePortRules = function(size, portForward) {
        appService.dialogService.openDialog("app/views/vpc/confirm-delete.jsp", size, $scope, ['$scope', '$modalInstance', function($scope, $modalInstance) {
            $scope.deleteId = portForward.id;
            $scope.ok = function(deleteId) {
                    $scope.showLoader = true;
                    var hasStorage = appService.crudService.delete("portforwarding", portForward.id);
                    hasStorage.then(function(result) {
                        $scope.showLoader = false;
                    appService.globalConfig.webSocketLoaders.portForwardLoader = true;
                    }).catch(function(result) {
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
                        appService.globalConfig.webSocketLoaders.portForwardLoader = false;
                    });
                    $modalInstance.close();
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };

  $scope.portIPList = function(instance, portvmList, index) {
	angular.forEach(portvmList, function(obj, key) {
		if(key == index) {
		    	obj.port = true;
		} else {
			obj.port = false;
                 }
	})
        var instanceId = instance;
$scope.vmPortId = instance;
        $scope.selected = instanceId;
        $scope.instances = instance;

        var hasPortIP = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "nics/listbynicandinstances?instanceid=" + instanceId + "&lang=" + appService.localStorageService.cookie.get('language') + "&sortBy=-id");
        hasPortIP.then(function(result) {
            $scope.portIPLists = result;
            $scope.showLoader = false;
        });
    };


    $scope.$on(appService.globalConfig.webSocketEvents.vpcEvents.createVPC, function(event, args) {
        appService.globalConfig.webSocketLoaders.vpcLoader = false;
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
    $scope.$on(appService.globalConfig.webSocketEvents.networkEvents.ipAquire, function(event, args) {
        appService.globalConfig.webSocketLoaders.ipLoader = false;
        $scope.ipLists(1);
    });
    $scope.$on(appService.globalConfig.webSocketEvents.networkEvents.enableStaticNat, function(event, args) {
        appService.globalConfig.webSocketLoaders.ipLoader = false;
        if (!angular.isUndefined($stateParams.id1) && $stateParams.id1 > 0) {
           $scope.webeditIpaddress($stateParams.id1);
        }
    });
    $scope.$on(appService.globalConfig.webSocketEvents.networkEvents.disableStaticNat, function(event, args) {
        appService.globalConfig.webSocketLoaders.ipLoader = false;
        if (!angular.isUndefined($stateParams.id1) && $stateParams.id1 > 0) {
            $scope.webeditIpaddress($stateParams.id1);
        }
    });
    $scope.$on(appService.globalConfig.webSocketEvents.networkEvents.ipRelease, function(event, args) {
        appService.globalConfig.webSocketLoaders.ipLoader = false;
        $scope.ipLists(1);
    });

    $scope.$on(appService.globalConfig.webSocketEvents.networkEvents.loadbalancerSave, function(event, args) {
    appService.globalConfig.webSocketLoaders.loadBalancerLoader = false;
    $scope.LBlist(1);
});

    $scope.$on(appService.globalConfig.webSocketEvents.networkEvents.assignRule, function(event, args) {
    appService.globalConfig.webSocketLoaders.loadBalancerLoader = false;
    $scope.LBlist(1);
    });

    $scope.$on(appService.globalConfig.webSocketEvents.networkEvents.configureStickiness, function(event, args) {
    appService.globalConfig.webSocketLoaders.loadBalancerLoader = false;
    $scope.LBlist(1);
    });

$scope.$on(appService.globalConfig.webSocketEvents.networkEvents.editrule, function(event, args) {
    appService.globalConfig.webSocketLoaders.loadBalancerLoader = false;
    $scope.LBlist(1);
});
$scope.$on(appService.globalConfig.webSocketEvents.networkEvents.deleteRules, function(event, args) {
    appService.globalConfig.webSocketLoaders.loadBalancerLoader = false;
    appService.globalConfig.webSocketLoaders.networkLoader = false;
    $scope.LBlist(1);
});
$scope.$on(appService.globalConfig.webSocketEvents.networkEvents.editStickiness, function(event, args) {
    appService.globalConfig.webSocketLoaders.loadBalancerLoader = false;
    $scope.LBlist(1);
});

$scope.$on(appService.globalConfig.webSocketEvents.networkEvents.vpnCreate, function(event, args) {
        appService.globalConfig.webSocketLoaders.vpnLoader = false;
        appService.globalConfig.webSocketLoaders.ipLoader = false;
        $scope.ipLists(1);
    });
    $scope.$on(appService.globalConfig.webSocketEvents.networkEvents.vpnDestroy, function(event, args) {
        appService.globalConfig.webSocketLoaders.vpnLoader = false;
        appService.globalConfig.webSocketLoaders.ipLoader = false;
        $scope.ipLists(1);
    });
    
    $scope.$on(appService.globalConfig.webSocketEvents.networkEvents.deletePortRules, function(event, args) {
    appService.globalConfig.webSocketLoaders.portForwardLoader = false;
    $scope.portRulesLists(1);
});
$scope.$on(appService.globalConfig.webSocketEvents.networkEvents.portforwardSave, function(event, args) {
    appService.globalConfig.webSocketLoaders.portForwardLoader = false;
    $scope.portRulesLists(1);
});
    
    $scope.$on(appService.globalConfig.webSocketEvents.networkEvents.vpnUserAdd, function(event, args) {
        appService.globalConfig.webSocketLoaders.vpnLoader = false;
        appService.localStorageService.set('view', 'vpn-details');
    });
    $scope.$on(appService.globalConfig.webSocketEvents.networkEvents.vpnUserDelete, function(event, args) {
       appService.globalConfig.webSocketLoaders.vpnLoader = false;
        appService.localStorageService.set('view', 'vpn-details');
        if (!angular.isUndefined($stateParams.id1) && $stateParams.id1 > 0) {
           $scope.webeditIpaddress($stateParams.id1);
           appService.localStorageService.set('view', 'vpn-details');
        }
    });

    $scope.trafficTypeList = {
            "0": "Ingress",
            "1": "Egress"
        };

    $scope.actionList = {
            "0": "Allow",
            "1": "Deny"
        };

    $scope.protocolList = {
            "0": "TCP",
            "1": "UDP",
            "2": "ICMP",
            "3": "ALL",
            "4": "Protocol Number"
        };
    $scope.tcp = true;
    $scope.udp = true;
    $scope.selectProtocol = function(selectedItem) {
    	console.log(selectedItem);
        if (selectedItem == 'TCP' || selectedItem == 'UDP') {
            $scope.tcp = true;
            $scope.udp = true;
            $scope.icmp = false;
        }
        if (selectedItem == 'ICMP') {
            $scope.icmp = true;
            $scope.tcp = false;
            $scope.udp = false;
        }
        if (selectedItem == 'ALL') {
            $scope.tcp = false;
            $scope.udp = false;
            $scope.icmp = false;
        }
    };

        //Add acl
    $scope.addAcl = function(size) {
        appService.dialogService.openDialog($scope.global.VIEW_URL + "vpc/add-acl.jsp", size, $scope, [ '$scope',
                '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
        	// Create a new application
            $scope.save = function (form, networkAcl) {
                $scope.formSubmitted = true;
                if (form.$valid) {
                	$scope.showLoader = true;
			$modalInstance.close();
                    var hasNetworkAcl = appService.crudService.add("vpcacl/addAcl/" + $stateParams.id, networkAcl);
                    hasNetworkAcl.then(function (result) {
                    	$scope.showLoader = false;
                    	$state.reload();
                    }).catch(function (result) {
                    	$scope.showLoader = false;
            		    if (!angular.isUndefined(result.data)) {
                		 if (result.data.fieldErrors != null) {
                       	$scope.showLoader = false;
                        	angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                            	$scope.networkAclForm[key].$invalid = true;
                            	$scope.networkAclForm[key].errorMessage = errorMessage;
                        	});
                		}
                	}
            		    appService.globalConfig.webSocketLoaders.volumeLoader = false;
            	});
                }
            },
                    $scope.cancel = function() {
                        $modalInstance.close();
                    };
                } ]);
    };

    $scope.vpcAclRulesList = {};
    $scope.vpcAclRulesList = function() {
    	if (!angular.isUndefined($stateParams.id3)) {
        var hasDomains = appService.promiseAjax.httpTokenRequest(appService.crudService.globalConfig.HTTP_GET, appService.crudService.globalConfig.APP_URL + "vpcnetworkacl"  +"/networkAclList/"+$stateParams.id3);
        hasDomains.then(function(result) { // this is only run after $http
            // completes0
            $scope.vpcAclRulesList = result;
        });
      }
    };
     $scope.vpcAclRulesList();

     $scope.networkAclList = {};
     $scope.networkAclList = function() {
     	if (!angular.isUndefined($stateParams.id3)) {
         var hasDomains =  appService.crudService.read("vpcacl" , $stateParams.id3);
         hasDomains.then(function(result) { // this is only run after $http
             // completes0
             $scope.networkAclList = result;
         });
       }
     };
      $scope.networkAclList();

    //Add vpc list
    $scope.saveAclList = function (form, vpcAcl) {
        $scope.formSubmitted = true;
        if (form.$valid) {
        	$scope.showLoader = true;
            var hasNetworkAcl = appService.crudService.add("vpcnetworkacl/addNetworkAcl/" + $stateParams.id3, vpcAcl);
            hasNetworkAcl.then(function (result) {
            	$scope.showLoader = false;
            	$state.reload();
            }).catch(function (result) {
            	$scope.showLoader = false;
    		    if (!angular.isUndefined(result.data)) {
        		 if (result.data.fieldErrors != null) {
               	$scope.showLoader = false;
                	angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                    	$scope.vpcAclForm[key].$invalid = true;
                    	$scope.vpcAclForm[key].errorMessage = errorMessage;
                	});
        		}
        	}
    		    appService.globalConfig.webSocketLoaders.volumeLoader = false;
    	});
        }
    },
            $scope.cancel = function() {
                $modalInstance.close();
            };

         // Delete the Vpc acl
            $scope.deleteAclList = function (size, networkAcl) {
            	appService.dialogService.openDialog("app/views/vpc/delete-vpcAcl.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
                       $scope.acl = networkAcl;
            		$scope.ok = function (networkAcl) {
                        	console.log($scope.acl);
                        	$scope.showLoader = true;
                            $modalInstance.close();
                            var hasServer = appService.crudService.softDelete("vpcacl", $scope.acl);
                            hasServer.then(function (result) {
            		$scope.showLoader = false;
            		$state.reload();
                            }).catch(function (result) {
                                if (!angular.isUndefined(result) && result.data != null) {
                                	$scope.showLoader = false;
                                    angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                                        $scope.addnetworkForm[key].$invalid = true;
                                        $scope.addnetworkForm[key].errorMessage = errorMessage;
                                    });
                                }
                                appService.globalConfig.webSocketLoaders.volumeLoader = false;
                            });

                        },
                                $scope.cancel= function () {
                                    $modalInstance.close();
                                };
                    }]);
            };

            // Delete the Vpc acl
            $scope.deleteNetworkAcl = function (size, vpcAcl) {
            	appService.dialogService.openDialog("app/views/vpc/delete-vpcAcl.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
                       $scope.acl = vpcAcl;
            		$scope.ok = function (vpcAcl) {
                        	console.log($scope.acl);
                        	$scope.showLoader = true;
                            $modalInstance.close();
                            var hasServer = appService.crudService.softDelete("vpcnetworkacl", $scope.acl);
                            hasServer.then(function (result) {
            		$scope.showLoader = false;
            		$state.reload();
                            }).catch(function (result) {
                                if (!angular.isUndefined(result) && result.data != null) {
                                	$scope.showLoader = false;
                                    angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                                        $scope.addnetworkForm[key].$invalid = true;
                                        $scope.addnetworkForm[key].errorMessage = errorMessage;
                                    });
                                }
                                appService.globalConfig.webSocketLoaders.volumeLoader = false;
                            });

                        },
                                $scope.cancel= function () {
                                    $modalInstance.close();
                                };
                    }]);
            };
}
