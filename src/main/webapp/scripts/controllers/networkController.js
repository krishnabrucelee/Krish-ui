/**
 *
 * instanceCtrl
 *
 */

angular
        .module('homer')
        .controller('networksCtrl', networksCtrl)
        .controller('networkViewCtrl', networkViewCtrl)

function networksCtrl($scope,$rootScope,filterFilter,$state, $stateParams,modalService, $timeout,$window,appService) {

	//$scope.quickSearch = "";
    $scope.global = appService.globalConfig;
    $scope.rulesList = [];
    $scope.rules = [];
    $scope.portList = [];
    $scope.vmList = [];
    $scope.formElements = {};
    $scope.allItemsSelected = false;
    $scope.sort = appService.globalConfig.sort;
    $scope.changeSorting = appService.utilService.changeSorting;

    $scope.firewallRulesList = {};
    $scope.paginationObject = {};
    $scope.egressForm = {};
    $scope.global = appService.globalConfig;
    $scope.sort = appService.globalConfig.sort;
    $scope.changeSorting = appService.utilService.changeSorting;

    // Egress Rule List
    $scope.firewallRulesList = function (pageNumber) {
        $scope.firewallRules = {};
    	var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasFirewallRuless = appService.crudService.list("egress", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
        hasFirewallRuless.then(function (result) {  // this is only run after $http completes0
            $scope.egressRuleList = result;

            // For pagination
            $scope.paginationObject.limit = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
        });
    };
    $scope.firewallRulesList(1);

    // Open dialogue box to create egress rule
    $scope.firewallRules = {};

    // Create a new egress rule
    $scope.egressSave = function (firewallRules) {
    //$scope.formSubmitted = true;
    //if ($scope.firewallRules.cidr || $scope.firewallRules.protocolName || $scope.firewallRules.startPort || $scope.firewallRules.endPort == null) {
        var hasServer = appService.crudService.add("egress", firewallRules);
        hasServer.then(function (result) {  // this is only run after $http completes
            $scope.formSubmitted = false;
            $modalInstance.close();
            appService.notify({message: 'Egress rule added successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
            $scope.firewallRulesList(1);
            }).catch(function (result) {
            	if (!angular.isUndefined(result.data)) {
                    if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                	    var msg = result.data.globalError[0];
                	    appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                    	} else if (result.data.fieldErrors != null) {
                        	angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                            	$scope.egressForm[key].$invalid = true;
                            	$scope.egressForm[key].errorMessage = errorMessage;
                        	});
                		}
                	}
            });
    //}
    };
    $scope.cancel = function () {
        $modalInstance.close();
    };

    // Delete the egress rule
    $scope.deleteEgress = function (size, firewallRules) {
    	appService.dialogService.openDialog($scope.global.VIEW_URL + "cloud/network/delete-egress.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
                $scope.deleteObject = firewallRules;
                $scope.ok = function (deleteObject) {
                	$scope.showLoader = true;
                	firewallRules.isActive = false;
                    var hasServer = appService.crudService.softDelete("egress", deleteObject);
                    hasServer.then(function (result) {
                        $scope.list(1);
                        $scope.showLoader = false;
                        appService.notify({message: 'Egress rule deleted successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                    }).catch(function (result) {
                    	if (!angular.isUndefined(result.data)) {
                        	if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                          	    var msg = result.data.globalError[0];
                        	    appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                            }
                        }
                    });
                    $modalInstance.close();
                },
                 $scope.cancel = function () {
                     $modalInstance.close();
                 };
            }]);
    };

    $scope.openAddIsolatedNetwork = function (size) {
        appService.dialogService.openDialog("app/views/cloud/network/add.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {

                // Create a new Isolated Network
                $scope.save = function (form, network) {


                    $scope.formSubmitted = true;
                    if (form.$valid) {
                   	 $scope.showLoader = true;

                        var guestnetwork = $scope.guestnetwork;
                        if (!angular.isUndefined($scope.network.domain)) {
                            network.domainId = $scope.network.domain.id;
			 delete network.domain;
			}
			 if (!angular.isUndefined($scope.network.department)) {
			network.departmentId = $scope.network.department.id;
			delete network.department;
			}

			 if (!angular.isUndefined($scope.network.project)) {
			network.projectId = $scope.network.project.id;
			delete network.project;
			}

                        network.zoneId = $scope.network.zone.id;
                        network.networkOfferingId = $scope.network.networkOffering.id;

                        delete network.zone;
                        delete network.networkOffering;


                        var hasguestNetworks = appService.crudService.add("guestnetwork", network);
                        hasguestNetworks.then(function (result) {
                            $scope.list(1);
                       	 $scope.showLoader = false;
                            appService.notify({message: 'Added successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                            $modalInstance.close();
                        }).catch(function (result) {
                            if (!angular.isUndefined(result) && result.data != null) {
                                if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                                    var msg = result.data.globalError[0];
                               	 $scope.showLoader = false;

                                    appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
//                                    $modalInstance.close();
                                }
                                angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                                    $scope.addnetworkForm[key].$invalid = true;
                                    $scope.addnetworkForm[key].errorMessage = errorMessage;
                                });
                            }
                        });
                        $scope.cancel = function () {
                            $modalInstance.close();
                        };
                    }
                },
                        $scope.$watch('network.domain', function (obj) {
                            if (!angular.isUndefined(obj)) {
                                $scope.departmentList(obj);
                            }
                        }),
                        $scope.$watch('network.department', function (obj) {
                            if (!angular.isUndefined(obj)) {
                                $scope.getProjectList(obj);
                            }
                        }),

                        $scope.cancel = function () {
                            $modalInstance.close();
                        };
            }]);
    };


    $scope.networkList = [];
    $scope.paginationObject = {};
    $scope.networkForm = {};
    $scope.global = appService.globalConfig;
    // Guest Network List
    $scope.list = function (pageNumber) {
   	 $scope.showLoader = true;

        $scope.type = $stateParams.view;
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasGuestNetworks = appService.crudService.list("guestnetwork", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
        hasGuestNetworks.then(function (result) {
        	$scope.showLoader = true;
            $scope.networkList = angular.copy(result);
            $scope.networkList.Count = 0;
            if (result.length != 0) {
                $scope.networkList.Count = result.totalItems;
            }
            $scope.showLoader = false;
            // For pagination
            $scope.paginationObject.limit = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
       	 $scope.showLoader = false;
        });


    };
    $scope.filteredCount = $scope.networkList;
    $scope.list(1);



    // Delete the Network
    $scope.delete = function (size, network) {
        appService.dialogService.openDialog("app/views/cloud/network/confirm-delete.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
                $scope.deleteId = network.id;
                $scope.ok = function (networkId) {
                	 $scope.showLoader = true;
                    var hasNetworks = appService.crudService.softDelete("guestnetwork", network);
                    hasNetworks.then(function (result) {
                        $scope.homerTemplate = 'app/views/notification/notify.jsp';
                        appService.notify({message: 'Deleted successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
                        $scope.showLoader = false;
                        $modalInstance.close();
                        $window.location.href = '#/network/list';
                        $scope.list(1);
                    }).catch(function (result) {
                        if (!angular.isUndefined(result) && result.data != null) {
                            if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                                var msg = result.data.globalError[0];
                                $scope.showLoader = false;
                                appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                                $modalInstance.close();

                            }
                            angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                                $scope.addnetworkForm[key].$invalid = true;
                                $scope.addnetworkForm[key].errorMessage = errorMessage;
                            });
                        }
                    });
                },
                        $scope.cancel = function () {
                            $modalInstance.close();
                        };
            }]);
    };


    // Edit Network
    $scope.edit = function (networkId) {
        var hasnetwork = appService.crudService.read("guestnetwork", networkId);
        hasnetwork.then(function (result) {
            $scope.network = result;
            appService.localStorageService.set('view', 'details');

            angular.forEach($scope.networkList, function(obj, key) {
	    		if(obj.id == $scope.network.networkOffering.id) {
	    			$scope.network.networkOffering = obj;
	    		}
	    	});

        });

    };

    if (!angular.isUndefined($stateParams.id) && $stateParams.id != '') {
        $scope.edit($stateParams.id);
    }

    // Update the Network
    $scope.update = function (form) {
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


            var hasNetwork = appService.crudService.update("guestnetwork", network);
            hasNetwork.then(function (result) {
                $scope.showLoader = false;
                $scope.homerTemplate = 'app/views/notification/notify.jsp';
                appService.notify({message: 'Updated successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
                $window.location.href = '#/network/list';
            }).catch(function (result) {
                if (!angular.isUndefined(result) && result.data != null) {
                    if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                        var msg = result.data.globalError[0];
                        $scope.showLoader = false;
                        appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                    }
                    angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                        $scope.addnetworkForm[key].$invalid = true;
                        $scope.addnetworkForm[key].errorMessage = errorMessage;
                    });
                }
            });
        }
    };
    $scope.cancel = function () {
        $modalInstance.close();
        $window.location.href = '#/network/list';
    };

    $scope.networkOfferList = {};
    $scope.networkOfferForm = {};
    $scope.global = appService.globalConfig;

    //  Network Offer List

    $scope.listNetworkOffer = function () {
        var hasNetworks = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "networkoffer/isolated" + "?lang=" + appService.localStorageService.cookie.get('language') + "&sortBy=-id");
        hasNetworks.then(function (result) {
            $scope.networkOfferList = result;
        });
    };
    $scope.listNetworkOffer();

    $scope.zoneList = {};
    $scope.zoneList = function () {
        var hasZones = appService.crudService.listAll("zones/list");
        hasZones.then(function (result) {  // this is only run after $http completes0
            $scope.zoneList = result;

        });
    };
    $scope.zoneList();

    $scope.domainList = {};
    $scope.domainList = function () {
        var hasZones = appService.crudService.listAll("domains/list");
        hasZones.then(function (result) {  // this is only run after $http completes0
            $scope.domainList = result;

        });
    };
    $scope.domainList();

    $scope.departmentList = function (domain) {
        var hasDepartments = appService.crudService.listAllByFilter("departments/search", domain);
        hasDepartments.then(function (result) {  // this is only run after $http completes0
            $scope.formElements.departmenttypeList = result;

        });
    };

    $scope.projectList = {};
    $scope.getProjectList = function (department) {
        var hasProjects = appService.crudService.listAllByObject("projects/department", department);
        hasProjects.then(function (result) {  // this is only run after $http completes0
        	$scope.projectList = result;

        });
    };

    if($scope.global.sessionValues.type != "ROOT_ADMIN") {
    	var department = {};
    	department.id = $scope.global.sessionValues.departmentId;
    	$scope.getProjectList(department);
    }

    //appService.localStorageService.clearAll();
    //appService.localStorageService.set("rules",null);
    /*   appService.localStorageService.set("networkList", null);
     if (appService.localStorageService.get("networkList") == null) {
     var hasServer = appService.promiseAjax.httpRequest("GET", "api/network.json");
     hasServer.then(function (result) {  // this is only run after $http completes
     $scope.networkList = result;
     appService.localStorageService.set("networkList", result);
     });
     } else {
     $scope.networkList = appService.localStorageService.get("networkList");
     }*/
    /* $scope.selectView=function(selectedItem){

     if(selectedItem == 'Guest Networks' || selectedItem==null ){
     var hasServer = appService.promiseAjax.httpRequest("GET", "api/network.json");
     hasServer.then(function (result) {  // this is only run after $http completes
     $scope.networkList = result;
     appService.localStorageService.set("networkList", result);
     });
     }
     if(selectedItem == 'VPC'){
     var hasServer = appService.promiseAjax.httpRequest("GET", "api/vpc.json");
     hasServer.then(function (result) {  // this is only run after $http completes
     $scope.networkList = result;
     appService.localStorageService.set("networkList", result);
     });
     }
     if(selectedItem == 'Security Groups'){
     var hasServer = appService.promiseAjax.httpRequest("GET", "api/securityGroups.json");
     hasServer.then(function (result) {  // this is only run after $http completes
     $scope.networkList = result;
     appService.localStorageService.set("networkList", result);
     });
     }
     if(selectedItem == 'VPN Customer Gateway'){
     var hasServer = appService.promiseAjax.httpRequest("GET", "api/vpn.json");
     hasServer.then(function (result) {  // this is only run after $http completes
     $scope.networkList = result;
     appService.localStorageService.set("networkList", result);
     });
     }
     };


     $scope.selectedNetwork=function(selectedItem){

     if(selectedItem == 'Guest Networks' || selectedItem==null ){
     var hasServer = appService.promiseAjax.httpRequest("GET", "api/network.json");
     hasServer.then(function (result) {  // this is only run after $http completes
     $scope.networkList = result;
     appService.localStorageService.set("networkList", result);
     });
     }
     if(selectedItem == 'VPC'){
     var hasServer = appService.promiseAjax.httpRequest("GET", "api/vpc.json");
     hasServer.then(function (result) {  // this is only run after $http completes
     $scope.networkList = result;
     appService.localStorageService.set("networkList", result);
     });
     }
     if(selectedItem == 'Security Groups'){
     var hasServer = appService.promiseAjax.httpRequest("GET", "api/securityGroups.json");
     hasServer.then(function (result) {  // this is only run after $http completes
     $scope.networkList = result;
     appService.localStorageService.set("networkList", result);
     });
     }
     if(selectedItem == 'VPN Customer Gateway'){
     var hasServer = appService.promiseAjax.httpRequest("GET", "api/vpn.json");
     hasServer.then(function (result) {  // this is only run after $http completes
     $scope.networkList = result;
     appService.localStorageService.set("networkList", result);
     });
     }
     };*/

    $scope.networkElements = {actions: [
            {id: 1, name: 'Hours'},
            {id: 2, name: 'Weeks'},
            {id: 3, name: 'Month'}
        ]};

    $scope.dropnetworkLists = {
        /* networkOffers: [
         {
         "id": 1,
         "name": "Advanced Network",
         "networkID": "f6dfee50-690c-4210-b77c-c9bf3179b159",
         "networkType": {
         "id": 2,
         "name": "Isolated"
         },
         "ip": "10.1.10.92",
         "gateway": "10.1.1.1",
         "netmask": "255.255.255.0",
         "isDefault": "No"
         },
         {
         "id": 2,
         "name": "Custom Network",
         "networkID": "f6dfee50-690c-4210-b77c-c9bf31734e59",
         "networkType": {
         "id": 1,
         "name": "Shared Network"
         },
         "ip": "10.2.2.92",
         "gateway": "10.2.2.1",
         "netmask": "255.255.255.0",
         "isDefault": "NO"
         },
         {
         "id": 3,
         "name": "Default Network",
         "networkID": "f6dfee50-690c-4210-b77c-m4fd452321e3",
         "networkType": {
         "id": 2,
         "name": "Isolated"
         },
         "ip": "10.1.10.92",
         "gateway": "10.1.1.1",
         "netmask": "255.255.255.0",
         "isDefault": "NO"
         }
         ],*/
        views: [
            {id: 1, name: 'Guest Networks'},
            {id: 2, name: 'Security Groups'},
            {id: 3, name: 'VPC'},
            {id: 4, name: 'VPN Customer Gateway'}
        ],
       protocols: [
         {id: 1, name: 'TCP', value: 'tcp'},
         {id: 2, name: 'UDP', value: 'udp'},
         {id: 3, name: 'ICMP', value: 'icmp'},
         {id: 4, name: 'All', value: 'all'}

         ],
         portProtocols: [
         {id: 1, name: 'TCP', value: 'tcp'},
         {id: 2, name: 'UDP', value: 'udp'},
         ],
         fireProtocols: [
         {id: 1, name: 'TCP', value: 'tcp'},
         {id: 2, name: 'UDP', value: 'udp'},
         {id: 3, name: 'ICMP', value: 'icmp'}

         ],
         algorithms: [
         {id: 1, name: 'Round-robin', value: 'roundrobin'},
         {id: 2, name: 'Least connections', value: 'leastconn'},
         {id: 3, name: 'Source', value: 'source'}
         ]
    };

    $scope.tcp = true;
    $scope.udp = true;

     $scope.selectProtocol = function (selectedItem) {
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
     if (selectedItem == 'All') {
     $scope.tcp = false;
     $scope.udp = false;
     $scope.icmp = false;
     }
     };
     if (appService.localStorageService.get("firewall") == null) {
     $scope.newrule = {
     'name': 'test',
     'id': 0, 'cidr': '10.0.0.1/24',
     'protocol': 'tcp',
     'algorithm': 'roundrobin',
     'startPort': '70',
     'endPort': '120',
     'icmpType': '',
     'icmpCode': '',
     'privateStart': '90',
     'privateEnd': '120', 'vms': []
     };
     $scope.rules.push($scope.newrule);
     appService.localStorageService.set("firewall", $scope.rules);
     }
     if (appService.localStorageService.get("rules") == null) {
     $scope.newrule = {
     'name': 'test',
     'id': 0, 'cidr': '10.0.0.1/24',
     'protocol': 'tcp',
     'algorithm': 'roundrobin',
     'startPort': '70',
     'endPort': '120',
     'icmpType': '',
     'icmpCode': '',
     'privateStart': '90',
     'privateEnd': '120', 'vms': []
     };
     $scope.rulesList.push($scope.newrule);
     appService.localStorageService.set("rules", $scope.rulesList);
     }
     if (appService.localStorageService.get("ports") == null) {
     $scope.newport = {
     'name': 'test',
     'id': 0, 'cidr': '10.0.0.1/24',
     'protocol': 'tcp',
     'algorithm': 'roundrobin',
     'startPort': '70',
     'endPort': '120',
     'icmpType': '',
     'icmpCode': '',
     'privateStart': '90',
     'privateEnd': '120',
     'vms': []
     };
     $scope.portList.push($scope.newport);
     appService.localStorageService.set("ports", $scope.portList);
     }
    $scope.portList = appService.localStorageService.get("ports");
    $scope.rulesList = appService.localStorageService.get("rules");
    $scope.rules = appService.localStorageService.get("firewall");
    $scope.actionRule = false;
    $scope.cidrValidate = false;
    $scope.addRule = function (type) {
        $scope.rules = appService.localStorageService.get("firewall");
//        var CheckIP = /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\/\d{1,2}$/;
        var CheckIP = /^([01]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.([01]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.([01]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.([01]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\/([1-9]|[12][0-9]|3[012])$/;
        if ($scope.cidr != null && $scope.cidr != '') {

            if (CheckIP.test($scope.cidr)) {
                $scope.rules.push({'id': $scope.rules.length + 1, 'algorithm': 'roundrobin', 'name': '', 'cidr': $scope.cidr, 'protocol': $scope.protocolName.name, 'startPort': $scope.startPort, 'endPort': $scope.endPort, 'icmpType': $scope.icmpType, 'icmpCode': $scope.icmpCode, 'privateStart': '90', 'privateEnd': '120', 'vms': []});
                appService.localStorageService.set("firewall", $scope.rules);
                if (type == 'firewall') {
                    appService.localStorageService.set('view', 'firewall');
                }
                $scope.actionRule = false;
                $scope.startPort = '';
                $scope.endPort = '';
                $scope.icmpType = '';
                $scope.icmpCode = '';
                $scope.id = '';
                $scope.name = '';
            }
            else {
                $scope.actionRule = true;
                $scope.cidrValidate = true;
            }
        }
        else {
            $scope.actionRule = true;
            $scope.cidrValidate = true;
        }
    };

    $scope.removeRule = function (id, type) {
        $scope.rules = appService.localStorageService.get("firewall");

        var index = -1;
        var comArr = eval($scope.rules);
        for (var i = 0; i < comArr.length; i++) {
            if (comArr[i].id === id) {
                index = i;
                break;
            }
        }
        if (index === -1) {
            alert("Something gone wrong");
        }
        $scope.rules.splice(index, 1);
        if (type == 'firewall') {
            appService.localStorageService.set('view', 'firewall');
        }
        appService.localStorageService.set("firewall", $scope.rules);

        $state.reload();
        $scope.cancel();
    };

    $scope.acquiringIP = false;
    $scope.ok = function () {
        $timeout(function () {
            $scope.acquiringIP = true
        }, 5);
        $timeout(function () {
            $scope.acquiringIP = true
        }, 5);
        $window.location.href = '#network/list/view/' + $stateParams.id;
    };
    $scope.actionAcquire = false;
    $scope.deleteRule = false;

    $scope.acquire = function () {
        $scope.actionAcquire = true;
        if ($scope.agree == true) {
            $scope.acquiringIP = true;
            $timeout($scope.ok, 3000);
        }
    }

    $scope.deleteRules = function (id, type) {
        appService.localStorageService.set('deleteRule', {'id': id, 'type': type});
        modalService.trigger('app/views/cloud/network/delete-rule.jsp', 'md');

    }

    $scope.doDelete = function () {

        $scope.deleteRule = true;
        $timeout($scope.deletes, 500);
    }

    $scope.deletes = function () {
        var id = appService.localStorageService.get('deleteRule').id;
        var type = appService.localStorageService.get('deleteRule').type;

        $timeout(function () {
            $scope.deleteRule = true
        }, 5);

        if (type == 'LB') {
            $scope.removeLB(id);
        }
        if (type == 'Egress') {
            $scope.removeRule(id, '');
            appService.localStorageService.set('view', 'egress');
        }
        if (type == 'Port') {
            $scope.removePort(id);
        }
        if (type == 'Firewall') {
            $scope.removeRule(id, 'firewall');
        }
    };

    $scope.openAddVM = function (form) {
        $scope.loadFormSubmitted = true;
        if (form.$valid) {
            $scope.global.rulesLB[0].name = $scope.load.name;
            $scope.global.rulesLB[0].publicPort = $scope.publicPort;
            $scope.global.rulesLB[0].privatePort = $scope.privatePort;
            $scope.global.rulesLB[0].algorithm = $scope.algorithms.value;
            modalService.trigger('app/views/cloud/network/vm-list.jsp', 'lg');
        }
    };
    $scope.lbCheck = false;
    $scope.vmlerror = false;
    $scope.addLB = function () {
        $scope.ruleList = appService.localStorageService.get("rules");
        $scope.vms = appService.localStorageService.get("vms");

        if ($scope.vms == '') {
            $scope.vmlerror = true;
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            appService.notify({message: 'Select atleast one VM', classes: 'alert-danger', "timeOut": "1000", templateUrl: $scope.homerTemplate});
        }
        else {
            appService.localStorageService.set("vms", null);
            $scope.addedRule = {'id': $scope.ruleList.length + 1, 'algorithm': $scope.global.rulesLB[0].algorithm, 'name': $scope.global.rulesLB[0].name, 'cidr': '', 'protocol': '', 'startPort': $scope.global.rulesLB[0].publicPort, 'endPort': $scope.global.rulesLB[0].privatePort, 'icmpType': '', 'icmpCode': '', 'privateStart': '', 'privateEnd': '', 'vms': $scope.vms};
            $scope.ruleList.push($scope.addedRule);
            appService.localStorageService.set("rules", $scope.ruleList);

            appService.notify({message: 'Rule added successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
            $scope.cancel();
            appService.localStorageService.set('view', 'load-balance');
            $state.reload();
        }
    }
    $scope.vmperror = false;
    $scope.addPort = function () {
        $scope.portList = appService.localStorageService.get("ports");
        $scope.vms = appService.localStorageService.get("vmsPort");
        if ($scope.vms == '') {
            $scope.vmperror = true;
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            appService.notify({message: 'Select atleast one VM', classes: 'alert-danger', "timeOut": "1000", templateUrl: $scope.homerTemplate});
        }
        else {
            appService.localStorageService.set("vmsPort", null);
            $scope.addedRule = {'id': $scope.portList.length + 1, 'algorithm': '', 'name': '', 'cidr': '', 'protocol': $scope.global.rulesLB[0].protocol, 'startPort': $scope.global.rulesLB[0].publicPort, 'endPort': $scope.global.rulesLB[0].publicEndPort, 'icmpType': '', 'icmpCode': '', 'privateStart': $scope.global.rulesLB[0].privatePort, 'privateEnd': $scope.global.rulesLB[0].privateEndPort, 'vms': $scope.vms};
            $scope.portList.push($scope.addedRule);
            appService.localStorageService.set("ports", $scope.portList);
            appService.notify({message: 'Rule added successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
            $scope.cancel();
            appService.localStorageService.set('view', 'port-forward');
            $state.reload();
        }
    }

    $scope.addVM = function (form) {
        $scope.portFormSubmitted = true;
        if (form.$valid) {
            $scope.global.rulesLB[0].publicPort = $scope.publicStartPort;
            $scope.global.rulesLB[0].privatePort = $scope.privateStartPort;
            $scope.global.rulesLB[0].privateEndPort = $scope.privateEndPort;
            $scope.global.rulesLB[0].publicEndPort = $scope.publicEndPort;
            $scope.global.rulesLB[0].protocol = $scope.protocolName.value;
            modalService.trigger('app/views/cloud/network/vm-list1.jsp', 'lg');
        }
    }

    $scope.removeLB = function (id) {
        $scope.ruleList = appService.localStorageService.get("rules");
        var comArr = eval($scope.ruleList);
        var index = -1;
        for (var i = 0; i < comArr.length; i++) {
            if (comArr[i].id === id) {
                index = i;
                break;
            }
        }
        if (index === -1) {
            alert("Something gone wrong");
        }
        $scope.ruleList.splice(index, 1);
        appService.localStorageService.set("rules", $scope.ruleList);
        appService.localStorageService.set('view', 'load-balance');
        $scope.cancel();
        $state.reload();
    }

    $scope.removePort = function (id) {
        $scope.ports = appService.localStorageService.get("ports");
        var comArr = eval($scope.ports);
        var index = -1;
        for (var i = 0; i < comArr.length; i++) {
            if (comArr[i].id === id) {
                index = i;
                break;
            }
        }
        if (index === -1) {
            alert("Something gone wrong");
        }
        $scope.ports.splice(index, 1);
        appService.localStorageService.set("ports", $scope.ports);
        appService.localStorageService.set('view', 'port-forward');
        $scope.cancel();
        $state.reload();
    }
    $scope.rulesList = appService.localStorageService.get("rules");
    $scope.portList = appService.localStorageService.get("ports");

    if (appService.localStorageService.get("instanceList") == null) {
        var hasServer = appService.promiseAjax.httpRequest("GET", "api/instance.json");
        hasServer.then(function (result) {  // this is only run after $http completes
            $scope.instanceList = result;
            appService.localStorageService.set("instanceList", result);
        });
    } else {
        $scope.instanceList = appService.localStorageService.get("instanceList");
    }

    $scope.selectVM = function () {
        appService.localStorageService.set("vms", filterFilter($scope.instanceList, {selected: true}));
        return filterFilter($scope.instanceList, {selected: true});
    };

    // watch fruits for changes
    $scope.$watch('instanceList|filter:{selected:true}', function (nv) {
        $scope.vmList = nv.map(function (vm) {
            return vm;
        });
        appService.localStorageService.set("vms", $scope.vmList);
        appService.localStorageService.set("vmsPort", $scope.vmList);
    }, true);
//
//        if (!$scope.instanceList[id].isChecked) {
//            $scope.vmList.push($scope.instanceList[id]);
//            appService.localStorageService.set("vms", $scope.vmList);
//            $scope.allItemsSelected = false;
//            return;
//        }

    $scope.selectVMPort = function () {
        appService.localStorageService.set("vmsPort", filterFilter($scope.instanceList, {selected: true}));
        return filterFilter($scope.instanceList, {selected: true});
    };

    $scope.tabview = appService.localStorageService.get('view');





//    $scope.global = appService.globalConfig;
//    $scope.networkList = [];
//    $scope.network = [];
//    $scope.ipList = [];
//    $scope.ipDetails = [];
//    $scope.tabview = '';

    /*if ($stateParams.id > 0) {
     var hasServer = appService.promiseAjax.httpRequest("GET", "api/network.json");
     hasServer.then(function (result) {  // this is only run after $http completes
     var networkId = $stateParams.id - 1;
     $scope.network = result[networkId];
     $scope.global.networks.name = result[networkId].name;
     if (appService.localStorageService.get("networkIP") != '') {
     if($scope.global.networks.name!=''){
     appService.localStorageService.set("networkIP", $scope.global.networks.name);}
     }
     $state.current.data.pageTitle = result[networkId].name;
     appService.localStorageService.set('view','details');
     });
     }

     if ($stateParams.id1 > 0) {
     var hasServer = appService.promiseAjax.httpRequest("GET", "api/ipaddress.json");
     hasServer.then(function (result) {  // this is only run after $http completes
     var ipId = $stateParams.id1 - 1;
     $scope.ipDetails = result[ipId];
     $state.current.data.pageTitle = result[ipId].ipaddress;
     appService.localStorageService.set('view','details');
     });

     }*/

    /**
     * Data for Line chart
     */
    $scope.lineData = {
        labels: ["10.00", "10.05", "10.10", "10.15", "10.20", "10.25", "10.30"],
        datasets: [
            {
                label: "vCpu %",
                fillColor: "#E56919",
                strokeColor: "#E56919",
                pointColor: "#E56919",
                pointStrokeColor: "#fff",
                pointHighlightFill: "#fff",
                pointHighlightStroke: "rgba(220,220,220,1)",
                data: [52, 44, 37, 43, 46, 45, 32]
            },
            {
                label: "Memory %",
                fillColor: "#16658D",
                strokeColor: "#16658D",
                pointColor: "#16658D",
                pointStrokeColor: "#fff",
                pointHighlightFill: "#fff",
                pointHighlightStroke: "rgba(26,179,148,1)",
                data: [37, 39, 29, 36, 32, 23, 28]
            }
        ]
    };
    $scope.networkElements = {actions: [
            {id: 1, name: 'Hours'},
            {id: 2, name: 'Weeks'},
            {id: 3, name: 'Month'}
        ]};

    $scope.openAddIP = function (size) {
        modalService.trigger('app/views/cloud/network/acquire-IP.jsp', size);
        $scope.cancel = function () {
            $modalInstance.close();
        };
    };

    /**
     * Options for Line chart
     */
    $scope.lineOptions = {
        scaleShowGridLines: true,
        scaleGridLineColor: "rgba(0,0,0,.05)",
        scaleGridLineWidth: 1,
        bezierCurve: true,
        bezierCurveTension: 0.4,
        pointDot: true,
        pointDotRadius: 4,
        pointDotStrokeWidth: 1,
        pointHitDetectionRadius: 20,
        datasetStroke: true,
        datasetStrokeWidth: 1,
        datasetFill: false,
//        responsive: true,
//        maintainAspectRatio: true
    };

    $scope.selectTab = function (type) {

        if (type == 'firewall') {
            appService.localStorageService.set('view', 'firewall');
        }
        if (type == 'loadBalance') {
            appService.localStorageService.set('view', 'load-balance');
        }
        if (type == 'portForward') {
            appService.localStorageService.set('view', 'port-forward');
        }

        $scope.tabview = appService.localStorageService.get('view');
        $state.reload();
    }
    $scope.tabview = appService.localStorageService.get('view');

//Add the sticky policy
$scope.createStickiness = function (size) {
    appService.dialogService.openDialog($scope.global.VIEW_URL + "cloud/network/stickiness.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
            // Create a new sticky policy
            $scope.addStickiness = function (form) {
                $scope.formSubmitted = true;
                if (form.$valid) {
                	appService.notify({message: 'Configured sticky policy successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                	$modalInstance.close();
                }
            	},
             	$scope.cancel = function () {
                 	$modalInstance.close();
             	};
        	}]);
	};

	 $scope.formElements = {
			 stickinessList: [
			              {id: 1, name: 'None'},
			              {id: 2, name: 'SourceBased'},
			              {id: 3, name: 'AppCookie'},
			              {id: 4, name: 'LbCookie'},
			          ]
	    };

	 $scope.healthCheck = function (form) {
	        $scope.loadFormSubmitted = true;
	        if (form.$valid) {
	            $scope.global.rulesLB[0].name = $scope.load.name;
	            $scope.global.rulesLB[0].publicPort = $scope.publicPort;
	            $scope.global.rulesLB[0].privatePort = $scope.privatePort;
	            modalService.trigger('app/views/cloud/network/healthCheck.jsp', 'md');
	        }
	    };

	};

function networkViewCtrl($scope, $http, notify, globalConfig, localStorageService, modalService, $log, $state, $stateParams, promiseAjax) {


		$scope.global = globalConfig;
	    $scope.networkList = [];
	    $scope.network = [];
	    $scope.ipList = [];
	    $scope.ipDetails = [];
	    $scope.tabview='';
	    if ($stateParams.id > 0) {

	        var hasServer = promiseAjax.httpRequest("GET", "api/network.json");
	        hasServer.then(function (result) {  // this is only run after $http completes
	            var networkId = $stateParams.id - 1;
	            $scope.network = result[networkId];
	            $scope.global.networks.name = result[networkId].name;
	            if (localStorageService.get("networkIP") != '') {
	                if($scope.global.networks.name!=''){
	                localStorageService.set("networkIP", $scope.global.networks.name);}
	            }
	            $state.current.data.pageTitle = result[networkId].name;
	            localStorageService.set('view','details');
	        });
	    }

	    if ($stateParams.id1 > 0) {

	        var hasServer = promiseAjax.httpRequest("GET", "api/ipaddress.json");
	        hasServer.then(function (result) {  // this is only run after $http completes
	            var ipId = $stateParams.id1 - 1;
	            $scope.ipDetails = result[ipId];
	            $state.current.data.pageTitle = result[ipId].ipaddress;
	            localStorageService.set('view','details');
	        });

	    }


	                $scope.selectTab=function(type){

	                   if(type=='firewall') {localStorageService.set('view','firewall'); }
	                   if(type=='loadBalance'){localStorageService.set('view','load-balance'); }
	                   if(type=='portForward'){localStorageService.set('view','port-forward');}

	                $scope.tabview=localStorageService.get('view');
	                $state.reload();
	                }
	          $scope.tabview=localStorageService.get('view');
	};

