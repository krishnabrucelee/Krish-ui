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
    $scope.ipList = {};
    $scope.ipDetails = {};

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

 /** // VPC Network List
    $scope.listVpcNetworkForLB = function(vpcId) {
    	var listVpcNetworksLB = appService.crudService.listAllByID("guestnetwork/vpcNetworkList?vpcId=" + vpcId);
        listVpcNetworksLB.then(function(result) {
            $scope.vpcNetworkListForLB = result;
        });
    };**/

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

$scope.portRulesLists = function(pageNumber) {
        $scope.showLoader = true;
        $scope.templateCategory = 'port-forward';
        $scope.firewallRules = {};
			$scope.portForward = {};
       var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
      /**  var hasFirewallRuless = appService.crudService.listAllByQuery("portforwarding/list?ipaddress=" + $stateParams.id1, $scope.global.paginationHeaders(pageNumber, limit), {
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
        });**/
    };

 // Load balancer
 $scope.LBlist = function(loadBalancer) {
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
        if (form.$valid) {
            $scope.global.rulesLB[0].name = $scope.loadBalancer.name;
            $scope.global.rulesLB[0].publicPort = $scope.loadBalancer.publicPort;
            $scope.global.rulesLB[0].privatePort = $scope.loadBalancer.privatePort;
            $scope.global.rulesLB[0].algorithm = $scope.loadBalancer.algorithms.value;
            //modalService.trigger('app/views/cloud/network/vm-list.jsp', 'lg');
            $scope.loadBalancer.vmIpaddress = [];
            appService.dialogService.openDialog("app/views/vpc/vm-list.jsp", 'lg', $scope, ['$scope', '$modalInstance', function($scope, $modalInstance) {
                $scope.lbvmLists = function() {
                    $scope.lbvmList = [];
                    var networkId = $stateParams.id;
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
                        $scope.loadBalancer.ipAddressId = $stateParams.id1;
                        // var loadBalancer = angular.copy($scope.loadBalancer);
                        $scope.loadBalancer.protocol = $scope.loadBalancer.protocol.toUpperCase();
                        $scope.loadBalancer.state = $scope.loadBalancer.state.toUpperCase();
                        $scope.loadBalancer.state = $scope.loadBalancer.state.toUpperCase();
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
                var networkId = $stateParams.id;
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
        appService.dialogService.openDialog("vpc/edit-rule.jsp", size, $scope, ['$scope', '$modalInstance', function($scope, $modalInstance) {
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
        appService.dialogService.openDialog("vpc/delete-rule.jsp", 'sm', $scope, ['$scope', '$modalInstance', function($scope, $modalInstance) {
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
        /*
         * networkOffers: [ { "id": 1, "name": "Advanced Network", "networkID":
         * "f6dfee50-690c-4210-b77c-c9bf3179b159", "networkType": { "id": 2,
         * "name": "Isolated" }, "ip": "10.1.10.92", "gateway": "10.1.1.1",
         * "netmask": "255.255.255.0", "isDefault": "No" }, { "id": 2, "name":
         * "Custom Network", "networkID":
         * "f6dfee50-690c-4210-b77c-c9bf31734e59", "networkType": { "id": 1,
         * "name": "Shared Network" }, "ip": "10.2.2.92", "gateway": "10.2.2.1",
         * "netmask": "255.255.255.0", "isDefault": "NO" }, { "id": 3, "name":
         * "Default Network", "networkID":
         * "f6dfee50-690c-4210-b77c-m4fd452321e3", "networkType": { "id": 2,
         * "name": "Isolated" }, "ip": "10.1.10.92", "gateway": "10.1.1.1",
         * "netmask": "255.255.255.0", "isDefault": "NO" } ],
         */
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

    $scope.editIpaddress = function(ipaddressId) {
        var hasIpaddress = appService.crudService.read("ipAddresses", ipaddressId);
        hasIpaddress.then(function(result) {
            $scope.ipDetails = result;
            $scope.vpnUserList($scope.ipDetails);
            appService.localStorageService.set('view', 'ipdetails');
        });
    };

    $scope.ipLists = function(pageNumber) {
        appService.localStorageService.set('views', 'ip');
        $scope.tabViews = appService.localStorageService.get('views');
        $scope.templateCategorys = $scope.tabViews;
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

    if (!angular.isUndefined($stateParams.id1) && $stateParams.id1 != null && $stateParams.id > 0) {
        if(angular.isUndefined(appService.localStorageService.get('view')) || appService.localStorageService.get('view') == null){
            appService.localStorageService.set('view', $state.current.data.networkTabs);
        }
        $scope.tabView = appService.localStorageService.get('view');
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
}
