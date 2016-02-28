

/**
 *
 * networksCtrl
 *
 */

angular
        .module('homer')
        .controller('networksCtrl', networksCtrl)

function networksCtrl($scope, $sce, $rootScope,filterFilter, $state, $stateParams, $timeout, $window, appService) {

     $scope.$on(appService.globalConfig.webSocketEvents.networkEvents.startVm, function() {
    //    $scope.instanceList = appService.webSocket;
    });
     $scope.$on(appService.globalConfig.webSocketEvents.networkEvents.stopVm, function() {
    //    $scope.instanceList = appService.webSocket;
    });
     $scope.$on(appService.globalConfig.webSocketEvents.networkEvents.rebootVm, function() {
    //    $scope.instanceList = appService.webSocket;
    });
     $scope.$on(appService.globalConfig.webSocketEvents.networkEvents.egressSave, function() {
    //    $scope.instanceList = appService.webSocket;
    });
     $scope.$on(appService.globalConfig.webSocketEvents.networkEvents.ingressSave, function() {
    //    $scope.instanceList = appService.webSocket;
    });
     $scope.$on(appService.globalConfig.webSocketEvents.networkEvents.deleteIngress, function() {
    //    $scope.instanceList = appService.webSocket;
    });
     $scope.$on(appService.globalConfig.webSocketEvents.networkEvents.createnetwork, function() {
    //    $scope.instanceList = appService.webSocket;
    });
     $scope.$on(appService.globalConfig.webSocketEvents.networkEvents.deletenetwork, function() {
    //    $scope.instanceList = appService.webSocket;
    });
     $scope.$on(appService.globalConfig.webSocketEvents.networkEvents.updatenetwork, function() {
    //    $scope.instanceList = appService.webSocket;
    });
     $scope.$on(appService.globalConfig.webSocketEvents.networkEvents.restartnetwork, function() {
    //    $scope.instanceList = appService.webSocket;
    });
     $scope.$on(appService.globalConfig.webSocketEvents.networkEvents.loadbalancerSave, function() {
    //    $scope.instanceList = appService.webSocket;
    });
     $scope.$on(appService.globalConfig.webSocketEvents.networkEvents.editrule, function() {
    //    $scope.instanceList = appService.webSocket;
    });
     $scope.$on(appService.globalConfig.webSocketEvents.networkEvents.configureStickiness, function() {
    //    $scope.instanceList = appService.webSocket;
    });
     $scope.$on(appService.globalConfig.webSocketEvents.networkEvents.editStickiness, function() {
    //    $scope.instanceList = appService.webSocket;
    });
     $scope.$on(appService.globalConfig.webSocketEvents.networkEvents.deletePortRules, function() {
    //    $scope.instanceList = appService.webSocket;
    });
     $scope.$on(appService.globalConfig.webSocketEvents.networkEvents.portforwardSave, function() {
    //    $scope.instanceList = appService.webSocket;
    });

    $scope.global = appService.globalConfig;
    $scope.rulesList = [];
    $scope.rules = [];
    $scope.instanceLists = [];
    $scope.instances ={};
    $scope.portinstance ={};
    $scope.natInstance = {};
    $scope.cancelNat = {};
    $scope.instanceLists.ipAddress = {};
    $scope.portList = [];
    $scope.vmList = [];
    $scope.ipDetails = {};
    $scope.formElements = {};
    $scope.allItemsSelected = false;
    $scope.sort = appService.globalConfig.sort;
    $scope.changeSorting = appService.utilService.changeSorting;
    $scope.paginationObject = {};
    $scope.egressForm = {};
    $scope.ipList = {};
    $scope.loadBalancer = {};
    $scope.loadBalancer.lbPolicy = {};
    $scope.portForward = {};
    $scope.stickiness = {};
    $scope.global = appService.globalConfig;
    $scope.sort = appService.globalConfig.sort;
    $scope.changeSorting = appService.utilService.changeSorting;
    $scope.showLoader = false;

    if ($stateParams.id > 0) {
 	    var hasServer = appService.crudService.read("guestnetwork", $stateParams.id);
        hasServer.then(function (result) {
            $scope.networkBreadCrumb = result;
		    $scope.networkBreadCrumbList = result;
		    $state.current.data.pageName = result.name;
		    $state.current.data.id = result.id;
        });
    }

    // Egress Rule List
    $scope.firewallRulesLists = function (pageNumber) {
        $scope.templateCategory = 'egress';
        $scope.firewallRules = {};
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasFirewallRuless = appService.crudService.listAllByQuery("egress/firewallrules?network=" + $stateParams.id + "&type=egress", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
        hasFirewallRuless.then(function (result) {
	    $scope.egressRuleList = result;

            // For pagination
            $scope.paginationObject.limit = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
        });
    };

    // Egress Rule List
    $scope.firewallRule = function (pageNumber) {
        $scope.templateCategory = 'firewall';
        $scope.firewallRules = {};
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasFirewallRuless = appService.crudService.listAllByQuery("egress/firewallrules?network=" + $stateParams.id1 + "&type=ingress", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
        hasFirewallRuless.then(function (result) {
            $scope.firewallRulesList = result;
            // For pagination
            $scope.paginationObject.limit = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
        });
    };
    // Port forward Rule List
    $scope.portRulesLists = function (pageNumber) {
	$scope.showLoader = true;
        $scope.templateCategory = 'port-forward';
        $scope.firewallRules = {};
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasFirewallRuless = appService.crudService.listAllByQuery("portforwarding/list?ipaddress=" + $stateParams.id1, $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
        hasFirewallRuless.then(function (result) {  // this is only run after
	$scope.showLoader = true;
        $scope.portList = result;
	$scope.showLoader = false;
            // For pagination
            $scope.paginationObject.limit = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
        });
    };


    $scope.hostList = function () {
        var hashostList = appService.crudService.listAll("host/list");
        hashostList.then(function (result) {
            $scope.hostLists = result;
        });
    };
    $scope.hostList();

    $scope.vmLists = function (pageNumber) {
        $scope.templateCategory = 'instance';
        $scope.vmList = [];
	 var networkId = $stateParams.id;
        var hasVms = appService.promiseAjax.httpTokenRequest( appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "nics/listbynetwork?networkid="+networkId +"&lang=" + appService.localStorageService.cookie.get('language')+"&sortBy=-id");
        hasVms.then(function (result) {  // this is only run after $http
									// completes0
        $scope.vmList = result;

        });
    };
 //$scope.vmLists(1);

$scope.selected = {};
    $scope.nicIPList = function (instance) {
	var instanceId = instance;
	$scope.selected = instanceId;
	$scope.instances = instance;
       	var hasNicIP = appService.promiseAjax.httpTokenRequest( appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "nics/listbyvminstances?instanceid="+instanceId +"&lang=" + appService.localStorageService.cookie.get('language')+"&sortBy=-id");
        hasNicIP.then(function (result) {
            $scope.nicIPLists = result;
            $scope.showLoader = false;

        });
    };

    $scope.showConsole = function (vm) {
        $scope.vm = vm;
        var hasVms = appService.crudService.updates("virtualmachine/console", vm);
        hasVms.then(function (result) {
            var consoleUrl = result.success;
            window.open($sce.trustAsResourceUrl(consoleUrl), vm.name + vm.id, 'width=750,height=460');
            /*
			 * var consoleParams = consoleUrl.split("token=");
			 * $window.sessionStorage.setItem("consoleProxy", consoleParams[0]);
			 * $scope.instance = vm; var randomnumber =
			 * Math.floor((Math.random()*100)+1);
			 * window.open("app/console.jsp?token="+consoleParams[1]+"&instance="+
			 * btoa(vm.id), vm.name + vm.id,'width=800,height=580');
			 */			});
    }

    $scope.startVm = function (size, item) {
        $scope.instance = item;
        if($scope.global.sessionValues.type === 'ROOT_ADMIN'){
    		size = 'md';
    	} else {
    		size = 'sm';
    	}
        appService.dialogService.openDialog("app/views/cloud/instance/start.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
                var vms = item;
                var event = "VM.START";
                $scope.update = function (form) {
                    vms.event = event;
                    $scope.formSubmitted = true;
                    if (form.$valid) {
                        vms.hostUuid = $scope.instance.host.uuid;
                        var hasVm = appService.crudService.updates("virtualmachine/handleevent/vm", vms);
                        hasVm.then(function (result) {
			    appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.networkEvents.startVm,result.id,$scope.global.sessionValues.id);
                            $state.reload();
                            $scope.cancel();
                        }).catch(function (result) {
                            if (result.data.globalError[0] != null) {
                                var msg = result.data.globalError[0];
                                appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                                $state.reload();
                                $scope.cancel();
                            }
                        });
                    }
                },
                        $scope.cancel = function () {
                            $modalInstance.close();
                        };
            }]);
    };
    $scope.agree = {
            value1 : false,
            value2 : true
          };

$scope.stopVm = function(size,item) {
   $scope.item =item;
  appService.dialogService.openDialog("app/views/cloud/instance/stop.jsp", size,  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {
          $scope.item = item;
         $scope.vmStop = function(item) {
                 var event = "VM.STOP";
                 $scope.actionExpunge = true;
                 if ($scope.agree.value1) {
                      item.transForcedStop = $scope.agree.value1;
                      item.event = event;
                      var hasVm = appService.crudService.updates("virtualmachine/handleevent/vm", item);
                      hasVm.then(function(result) {
			    appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.networkEvents.stopVm,result.id,$scope.global.sessionValues.id);
                             $state.reload();
                             $scope.cancel();
                      }).catch(function (result) {
                             $state.reload();
                             $scope.cancel();
                      });
                 } else {
                   var event = "VM.STOP";
                         var hasVm = appService.crudService.vmUpdate("virtualmachine/handlevmevent", item.uuid, event);
                         hasVm.then(function(result) {
			    appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.networkEvents.stopVm,result.id,$scope.global.sessionValues.id);
                                 $state.reload();
                                  $scope.cancel();
                         }).catch(function (result) {
                           $state.reload();
                           $scope.cancel();
                         });
                   }
                 },
                   $scope.cancel = function () {
        $modalInstance.close();
    };
}]);
};
    $scope.rebootVm = function (size, item) {
        appService.dialogService.openDialog("app/views/cloud/instance/reboot.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
                $scope.item = item;
                $scope.vmRestart = function (item) {
                    var event = "VM.REBOOT";
                    var hasVm = appService.crudService.vmUpdate("virtualmachine/handlevmevent", item.uuid, event);
                    hasVm.then(function (result) {
			    appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.networkEvents.rebootVm,result.id,$scope.global.sessionValues.id);
                        $state.reload();
                        $scope.cancel();
                    });
                },
                        $scope.cancel = function () {
                            $modalInstance.close();
                        };
            }]);
    };
    $scope.ipLists = function (pageNumber) {
        $scope.templateCategory = 'ip';
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasFirewallRuless = appService.crudService.listAllByQuery("ipAddresses/iplist?network=" + $stateParams.id, $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
        hasFirewallRuless.then(function (result) {  // this is only run after
													// $http completes0
            $scope.ipList = result;

            // For pagination
            $scope.paginationObject.limit = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
        });
    };

    // Open dialogue box to create egress rule
    $scope.firewallRules = {};

    // Create a new egress rule
    $scope.actionRule = false;
    $scope.cidrValidate = false;
    $scope.egressSave = function (form,firewallRules) {
    	$scope.firewallRules.networkId = $stateParams.id;
        $scope.formSubmitted = true;
        if (form.$valid) {
        $scope.showLoader = true;
        var CheckIP = /^([01]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.([01]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.([01]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.([01]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\/([0-9]|[12][0-9]|3[012])$/;
        if ($scope.firewallRules.sourceCIDR && $scope.firewallRules.protocol) {
            if (CheckIP.test($scope.firewallRules.sourceCIDR)) {
                if ($scope.firewallRules.sourceCIDR && $scope.firewallRules.protocol) {
                    if ($scope.firewallRules.protocol == 'TCP' || $scope.firewallRules.protocol == 'UDP') {
                        if ($scope.firewallRules.startPort && $scope.firewallRules.endPort) {
                            var hasServer = appService.crudService.add("egress", firewallRules);
                            hasServer.then(function (result) {  // this is only
			    appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.networkEvents.egressSave,result.id,$scope.global.sessionValues.id);
			      	        $timeout(function(){

                                                $scope.showLoader = true;
                                                $scope.formSubmitted = false;
					        $scope.showLoader = false;
                            appService.notify({message: 'Egress rule added successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                            $scope.firewallRules = {};
                            $scope.firewallRulesLists(1);
                            }, 25000);

                                $scope.formSubmitted = false;
                                $scope.templateCategory = 'egress';
                            }).catch(function (result) {
				$scope.showLoader = false;
                                if (!angular.isUndefined(result.data)) {
                                    if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                                        var msg = result.data.globalError[0];
					$scope.showLoader = false;
                                        appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                                    } else if (result.data.fieldErrors != null) {
                                        angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                                            $scope.egressForm[key].$invalid = true;
					    $scope.showLoader = false;
                                            $scope.egressForm[key].errorMessage = errorMessage;
                                        });
                                    }
                                }
                            });
                        }
                    } else {
                        if ($scope.firewallRules.icmpMessage && $scope.firewallRules.icmpCode) {
                            var hasServer = appService.crudService.add("egress", firewallRules);
                            hasServer.then(function (result) {
			    appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.networkEvents.egressSave,result.id,$scope.global.sessionValues.id);
			     $timeout(function(){

                     $scope.showLoader = true;
                     $scope.formSubmitted = false;
                     $scope.showLoader = false;
                     appService.notify({message: 'Egress rule added successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                     $scope.firewallRules = {};
                     $scope.firewallRulesLists(1);
			     }, 25000);
                                $scope.templateCategory = 'egress';
                            }).catch(function (result) {
					$scope.showLoader = false;
                                if (!angular.isUndefined(result.data)) {
                                    if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                                        var msg = result.data.globalError[0];
					$scope.showLoader = false;
                                        appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                                    } else if (result.data.fieldErrors != null) {
                                        angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                                            $scope.egressForm[key].$invalid = true;
					    $scope.showLoader = false;
                                            $scope.egressForm[key].errorMessage = errorMessage;
                                        });
                                    }
                                }
                            });
                        }
                    }

                }
                $scope.actionRule = false;
            }
            else {
		$scope.showLoader = false;
		appService.notify({message: 'Invalid cidr format ' + $scope.firewallRules.sourceCIDR, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                $scope.actionRule = true;
                $scope.cidrValidate = true;
            }

        }
        else {
            $scope.actionRule = true;
            $scope.cidrValidate = true;
        }
}
    };
    $scope.firewallRuleIngress = {};

    // Create a new egress rule
    $scope.actionRules = false;
    $scope.cidrValidates = false;
    $scope.ingressSave = function (form,firewallRuleIngress) {
    	$scope.firewallRuleIngress.networkId = $stateParams.id;
        $scope.firewallRuleIngress.ipAddressId = $stateParams.id1;
        $scope.formSubmitted = true;
        if (form.$valid) {
        $scope.showLoader = true;
        var CheckIP = /^([01]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.([01]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.([01]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.([01]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\/([0-9]|[12][0-9]|3[012])$/;
        if ($scope.firewallRuleIngress.sourceCIDR && $scope.firewallRuleIngress.protocol && $scope.firewallRuleIngress.startPort && $scope.firewallRuleIngress.endPort) {

            if (CheckIP.test($scope.firewallRuleIngress.sourceCIDR)) {
                if ($scope.firewallRuleIngress.sourceCIDR && $scope.firewallRuleIngress.protocol && $scope.firewallRuleIngress.startPort && $scope.firewallRuleIngress.endPort) {
                    var hasServer = appService.crudService.add("egress/ingress", $scope.firewallRuleIngress);
                    hasServer.then(function (result) {
			    appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.networkEvents.ingressSave,result.id,$scope.global.sessionValues.id);
                        $scope.formSubmitted = false;
                        $timeout(function(){
                           $scope.showLoader = false;
                           $scope.formSubmitted = false;
                           appService.notify({message: 'Firewall rule added successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                           $scope.firewallRuleIngress ={};
                           $scope.firewallRule(1);
                            }, 25000);
                        $scope.firewallRule(1);
                        $scope.templateCategory = 'firewall';
                    }).catch(function (result) {
                        $scope.formSubmitted = false;
			$scope.showLoader = false;
                        if (!angular.isUndefined(result.data)) {
                            if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                                var msg = result.data.globalError[0];
                                appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                            } else if (result.data.fieldErrors != null) {
                                angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                                    $scope.egressForm[key].$invalid = true;
                                    $scope.egressForm[key].errorMessage = errorMessage;
                                });
                            }
                        }
                    });
                }
                $scope.actionRules = false;
            }
            else {
		$scope.showLoader = false;
		appService.notify({message: 'Invalid cidr format ' + $scope.firewallRuleIngress.sourceCIDR, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                $scope.actionRules = true;
                $scope.cidrValidates = true;
            }
        }
        else {
            $scope.actionRules = true;
            $scope.cidrValidates = true;
        }
    }
};
    $scope.cancel = function () {
        $modalInstance.close();
    };

    // Delete the ingress rule
    $scope.deleteIngress = function (size, firewallRules) {
        appService.dialogService.openDialog($scope.global.VIEW_URL + "cloud/network/delete-egress.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
                $scope.deleteObject = firewallRules;
                $scope.ok = function (deleteObject) {
                    $scope.showLoader = true;
                    firewallRules.isActive = false;
                    var hasServer = appService.crudService.softDelete("egress/ingress", deleteObject);
                    hasServer.then(function (result) {
			    appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.networkEvents.deleteIngress,result.id,$scope.global.sessionValues.id);
                        $scope.templateCategory = 'firewall';
                        $scope.firewallRule(1);
                        appService.notify({message: 'Ingress rule deleted successfully', classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                    }).catch(function (result) {
                        if (!angular.isUndefined(result.data)) {
                            if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                                var msg = result.data.globalError[0];
                                appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                            }
                        }
                        $modalInstance.close();
                    });
                    $modalInstance.close();
                },
                        $scope.cancel = function () {
                            $modalInstance.close();
                        };
            }]);
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
			    appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.networkEvents.deleteEgress,result.id,$scope.global.sessionValues.id);
                        $scope.firewallRulesLists(1);
                        appService.notify({message: 'Egress rule deleted successfully', classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                    }).catch(function (result) {
                        if (!angular.isUndefined(result.data)) {
                            if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                                var msg = result.data.globalError[0];
                                appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                            }
                        }
                        $modalInstance.close();
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
                $scope.network = {};
                if ($scope.global.sessionValues.type === 'USER') {
                    var hasDepartments = appService.crudService.read("departments", $scope.global.sessionValues.departmentId);
                    hasDepartments.then(function (result) {
                        $scope.network.department = result;
                    });
                }
                // Create a new Isolated Network
                $scope.save = function (form, network) {
                    $scope.formSubmitted = true;
                    var network = $scope.network;
                    if (form.$valid) {

                        if (!angular.isUndefined($scope.network.domain) && $scope.network.domain != null) {
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

                        $scope.showLoader = true;
                        var hasguestNetworks = appService.crudService.add("guestnetwork", network);
                        hasguestNetworks.then(function (result) {
			    appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.networkEvents.createnetwork,result.id,$scope.global.sessionValues.id);
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
                                }
                                angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                                    $scope.addnetworkForm[key].$invalid = true;
                                    $scope.addnetworkForm[key].errorMessage = errorMessage;
                                });
                            }
                            $modalInstance.close();
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

    // Delete the Network
    $scope.delete = function (size, network) {
        appService.dialogService.openDialog("app/views/cloud/network/confirm-delete.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
                $scope.deleteId = network.id;
                $scope.ok = function (networkId) {
                    $scope.showLoader = true;
                    var hasNetworks = appService.crudService.softDelete("guestnetwork", network);
                    hasNetworks.then(function (result) {
			    appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.networkEvents.deletenetwork,result.id,$scope.global.sessionValues.id);
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
                        $modalInstance.close();
                    });
                },
                        $scope.cancel = function () {
                            $modalInstance.close();
                        };
            }]);
    };
$scope.networkRestart ={};
    // Restart the Network
    $scope.restart = function (size, network) {
        appService.dialogService.openDialog("app/views/cloud/network/restart-network.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
                $scope.ok = function (restart) {
		$scope.networkRestart = restart;
                $scope.showLoader = true;
			var hasServer = appService.crudService.add("guestnetwork/restart/" + network.id, network);
                        hasServer.then(function (result) {  // this is only run after $http completes
			    appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.networkEvents.restartnetwork,result.id,$scope.global.sessionValues.id);
                        	$scope.showLoader = false;
                        	appService.notify({message: 'Restarted successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                            $modalInstance.close();
                            $scope.list(1);
                        }).catch(function (result) {
                            if (!angular.isUndefined(result.data)) {
                                if (result.data.globalError != '' && !angular.isUndefined(result.data.globalError)) {
                                    var msg = result.data.globalError[0];
                                    $scope.showLoader = false;
                                    appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                                } else if (result.data.fieldErrors != null) {
                                    angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                                        $scope.addnetworkForm[key].$invalid = true;
                                        $scope.addnetworkForm[key].errorMessage = errorMessage;
                                    });
                                }
                            }
                            $modalInstance.close();
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

            angular.forEach($scope.networkOfferList, function (obj, key) {
                if (obj.id == $scope.network.networkOffering.id) {
                    $scope.network.networkOffering = obj;
                }
            });
        });

    };
    $scope.editIpaddress = function (ipaddressId) {
        var hasIpaddress = appService.crudService.read("ipAddresses", ipaddressId);
        hasIpaddress.then(function (result) {
            $scope.ipDetails = result;
            appService.localStorageService.set('view', 'details');
        });

    };
    if (!angular.isUndefined($stateParams.id) && $stateParams.id != '') {
        $scope.edit($stateParams.id);
    }
    if (!angular.isUndefined($stateParams.id1) && $stateParams.id1 != '') {
        $scope.editIpaddress($stateParams.id1);
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
   		appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.networkEvents.updatenetwork,result.id,$scope.global.sessionValues.id);
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
                $modalInstance.close();
            });
        }
    };
    $scope.cancel = function () {
        $window.location.href = '#/network/list';
    };
    $scope.networkOfferList = {};
    $scope.networkOfferForm = {};
    $scope.global = appService.globalConfig;

    // Network Offer List

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
        hasZones.then(function (result) {  // this is only run after $http
											// completes0
            $scope.zoneList = result;

        });
    };
    $scope.zoneList();
    $scope.domainList = {};
    $scope.domainList = function () {
        var hasDomains = appService.crudService.listAll("domains/list");
        hasDomains.then(function (result) {  // this is only run after $http
												// completes0
            $scope.domainList = result;
        });
    };
    $scope.domainList();
    $scope.departmentList = function (domain) {
        var hasDepartments = appService.crudService.listAllByFilter("departments/search", domain);
        hasDepartments.then(function (result) {  // this is only run after
													// $http completes0
            $scope.formElements.departmenttypeList = result;
        });
    };

    $scope.projectList = {};
    $scope.getProjectList = function (department) {

	if ($scope.global.sessionValues.type != "USER") {
        var hasProjects = appService.crudService.listAllByObject("projects/department", department);
        hasProjects.then(function (result) {  // this is only run after $http
												// completes0
            $scope.projectList = result;
        });
	}
	if ($scope.global.sessionValues.type == "USER") {
	var hasProjects = appService.crudService.listAllByObject("projects/user", $scope.global.sessionValues);
        hasProjects.then(function (result) {  // this is only run after $http
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


    $scope.networkElements = {actions: [
            {id: 1, name: 'Hours'},
            {id: 2, name: 'Weeks'},
            {id: 3, name: 'Month'}
        ]};

    $scope.protocolList = {
        "0": "TCP",
        "1": "UDP",
        "2": "ICMP",
        "3": "All"
    };
    $scope.protocolLists = {
        "0": "TCP",
        "1": "UDP",
        "2": "ICMP"
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
        views: [
            {id: 1, name: 'Guest Networks'},
            {id: 2, name: 'Security Groups'},
            {id: 3, name: 'VPC'},
            {id: 4, name: 'VPN Customer Gateway'}
        ],
        protocols: [
            {id: 1, name: 'TCP', value: 'TCP'},
            {id: 2, name: 'UDP', value: 'UDP'},
            {id: 3, name: 'ICMP', value: 'ICMP'},
            {id: 4, name: 'All', value: 'All'}

        ],
        portProtocols: [
            {id: 1, name: 'TCP', value: 'TCP'},
            {id: 2, name: 'UDP', value: 'UDP'},
        ],
        fireProtocols: [
            {id: 1, name: 'TCP', value: 'TCP'},
            {id: 2, name: 'UDP', value: 'UDP'},
            {id: 3, name: 'ICMP', value: 'ICMP'}

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
	    delete $scope.firewallRules.icmpMessage;
	    delete  $scope.firewallRules.icmpCode;

        }
        if (selectedItem == 'ICMP') {

            $scope.icmp = true;
            $scope.tcp = false;
            $scope.udp = false;
	    delete  $scope.firewallRules.startPort;
            delete  $scope.firewallRules.endPort;
        }
        if (selectedItem == 'All') {
            $scope.tcp = false;
            $scope.udp = false;
            $scope.icmp = false;
            delete $scope.firewallRules.icmpMessage;
            delete  $scope.firewallRules.icmpCode;
            delete  $scope.firewallRules.startPort;
            delete  $scope.firewallRules.endPort;
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
        //$scope.rulesList.push($scope.newrule);
       // appService.localStorageService.set("rules", $scope.rulesList);
    }
   // $scope.rulesList = appService.localStorageService.get("rules");
    $scope.rules = appService.localStorageService.get("firewall");
    $scope.actionRule = false;
    $scope.cidrValidate = false;
    $scope.addRule = function (type) {
        $scope.rules = appService.localStorageService.get("firewall");
// var CheckIP = /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\/\d{1,2}$/;
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

    $scope.LBlist = function (loadBalancer) {
$scope.rulesvmList ={};
    $scope.stickiness = {};
    $scope.loadBalancer = {};
    $scope.loadFormSubmitted = false;
  var ipAddressId = $stateParams.id1;
 	var hasloadBalancer = appService.promiseAjax.httpTokenRequest( appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL +"loadBalancer/list?ipAddressId="+$stateParams.id1 +"&lang=" + appService.localStorageService.cookie.get('language')+"&sortBy=-id");
  hasloadBalancer.then(function (result) {
          $scope.rulesList = result;
  });
};

if(!angular.isUndefined($stateParams.id1)){
$scope.LBlist(1);
}

$scope.openAddVM = function (form) {

  $scope.loadFormSubmitted = true;
  if (form.$valid) {
      $scope.global.rulesLB[0].name = $scope.loadBalancer.name;
      $scope.global.rulesLB[0].publicPort = $scope.loadBalancer.publicPort;
      $scope.global.rulesLB[0].privatePort = $scope.loadBalancer.privatePort;
      $scope.global.rulesLB[0].algorithm = $scope.loadBalancer.algorithms.value;
      //modalService.trigger('app/views/cloud/network/vm-list.jsp', 'lg');
$scope.loadBalancer.vmIpaddress = [];
appService.dialogService.openDialog("app/views/cloud/network/vm-list.jsp", 'lg' , $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {

 $scope.lbvmLists = function () {

        $scope.lbvmList = [];
	 var networkId = $stateParams.id;
         var hasVms = appService.promiseAjax.httpTokenRequest( appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "nics/listbynetwork?networkid="+networkId +"&lang=" + appService.localStorageService.cookie.get('language')+"&sortBy=-id");
        hasVms.then(function (result) {  // this is only run after $http
        $scope.lbvmList = result;
        });
    };
	$scope.lbvmLists();

  $scope.loadbalancerSave = function(loadBalancer) {
  $scope.loadBalancer = $scope.global.rulesLB[0];
  $scope.formSubmitted = true;
  $scope.showLoader = true;
  $scope.loadBalancer.ipAddressId = $stateParams.id1;
  // var loadBalancer = angular.copy($scope.loadBalancer);
  $scope.loadBalancer.protocol = $scope.loadBalancer.protocol.toUpperCase();
  $scope.loadBalancer.state = $scope.loadBalancer.state.toUpperCase();
	$scope.loadBalancer.state = $scope.loadBalancer.state.toUpperCase();
loadBalancer.vmIpAddress = [];
if (!angular.isUndefined(loadBalancer.vmIpAddress) && loadBalancer.vmIpAddress != null) {
		angular.forEach(loadBalancer, function(obj, key) {
		   if(obj.lbvm && angular.isArray(obj.ipAddress)) { 
			   angular.forEach(obj.ipAddress, function(vmIpAddress, vmIpAddressKey) {
			   	loadBalancer.vmIpAddress.push(vmIpAddress);
			   })
			}
                   
		})
}
 $scope.loadBalancer.vmIpAddress = loadBalancer.vmIpAddress;
$scope.loadBalancer.lbPolicy = {};
	  var loadBalancerParams = ["stickinessMethod", "stickinessName", "stickyTableSize","cookieName","stickyExpires","stickyMode","stickyLength","stickyRequestLearn",
              "stickyPrefix","stickyNoCache","stickyIndirect","stickyPostOnly","stickyCompany"];
	for(var i=0; i < loadBalancerParams.length; i++) {
				if(!angular.isUndefined($scope.stickiness[loadBalancerParams[i]]) && $scope.stickiness[loadBalancerParams[i]] != null){
					$scope.loadBalancer.lbPolicy[loadBalancerParams[i]] = $scope.stickiness[loadBalancerParams[i]];
				}
			}
  var hasLoadBalancer = appService.crudService.add("loadBalancer", $scope.loadBalancer);
  hasLoadBalancer.then(function (result) { // this is only run after
  appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.networkEvents.loadbalancerSave,result.id,$scope.global.sessionValues.id);
  $scope.showLoader = true;
      $scope.formSubmitted = false;
      $scope.showLoader = false;
      $modalInstance.close();
      appService.notify({
  message: 'LoadBalancer rule added successfully ',

          classes: 'alert-success',
          templateUrl: $scope.global.NOTIFICATION_TEMPLATE

      });
      $scope.LBlist(1);
  }).catch(function (result) {

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
          $scope.showLoader = false;
          $modalInstance.close();
          } else if (result.data.fieldErrors != null) {
              $scope.showLoader = false;
              angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                  $scope.loadBalancerForm[key].$invalid = true;
                  $scope.loadBalancerForm[key].errorMessage = errorMessage;
                  $scope.showLoader = false;
                  $modalInstance.close();
              });
          }
      }
}) },
              $scope.cancel = function () {
                  $modalInstance.close();
              };

  }]);

  }
};

$scope.openAddVMlist = function () {
$scope.showLoader = false;
 appService.dialogService.openDialog("app/views/cloud/network/vm-list.jsp", 'lg' , $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
      $scope.ok = function () {

      },
              $scope.cancel = function () {
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
$scope.applyNewRule = function (size, loadBalancer) {
  appService.dialogService.openDialog("app/views/cloud/network/vm-list.jsp", 'lg', $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
	 $scope.lbvmLists = function () {

        $scope.lbvmList = [];
	 var networkId = $stateParams.id;
         var hasVms = appService.promiseAjax.httpTokenRequest( appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "nics/listbynetwork?networkid="+networkId +"&lang=" + appService.localStorageService.cookie.get('language')+"&sortBy=-id");
        hasVms.then(function (result) {  // this is only run after $http
        $scope.lbvmList = result;
        });
    };
	$scope.lbvmLists();

            
	    $scope.loadBalancer = angular.copy(loadBalancer);
            $scope.loadbalancerSave = function (loadBalancerVmList) {
		var loadBalancer = {};
		loadBalancer.id  = $scope.loadBalancer.id;
		loadBalancer.name = $scope.loadBalancer.name;
		loadBalancer.algorithm = $scope.loadBalancer.algorithm;
		loadBalancer.vmIpAddress = [];
		angular.forEach(loadBalancerVmList, function(obj, key) {
		   if(obj.lbvm && angular.isArray(obj.ipAddress)) { 
			   angular.forEach(obj.ipAddress, function(vmIpAddress, vmIpAddressKey) {
			   	loadBalancer.vmIpAddress.push(vmIpAddress);
			   })
			}
                   
		})
                  $scope.showLoader = true;
              var hasServer = appService.crudService.update("loadBalancer", loadBalancer);
              hasServer.then(function (result) {
                  $scope.LBlist(1);
                  appService.notify({message: 'Rules assigned to IP successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                  $modalInstance.close();
                  $scope.showLoader = false;
              }).catch(function (result) {
                  if (!angular.isUndefined(result) && result.data != null) {
                      angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                  		$scope.showLoader = false;
                          $scope.loadBalancerForm[key].$invalid = true;
                          $scope.loadBalancerForm[key].errorMessage = errorMessage;
                      });
                  }

              });

          },
                  $scope.cancel = function () {
                      $modalInstance.close();
                  };
      }]);
};

 $scope.loadBalancer.algorithm = {};
// Edit the load balancer
$scope.editrule = function (size, loadBalancer) {
  appService.dialogService.openDialog("app/views/cloud/network/edit-rule.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
	            $scope.loadBalancer = angular.copy(loadBalancer);		 
 angular.forEach($scope.dropnetworkLists.algorithms, function (obj, key) {
               if (obj.value == $scope.loadBalancer.algorithm) {
                    $scope.loadBalancer.algorithm = obj;
                }
            });
            $scope.updateRule = function (form,loadBalancer) {
	            $scope.loadBalancer = angular.copy(loadBalancer);
		     		$scope.loadBalancer.algorithm = loadBalancer.algorithm.value;
              var loadBalancer = $scope.loadBalancer;
	$scope.formSubmitted = true;
		 if (form.$valid) {
                    	$scope.showLoader = true;
              var hasServer = appService.crudService.update("loadBalancer", loadBalancer);

              hasServer.then(function (result) {
  appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.networkEvents.editrule,result.id,$scope.global.sessionValues.id);
                  $scope.LBlist(1);
                  appService.notify({message: 'Updated successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                  $modalInstance.close();
                  $scope.showLoader = false;
              }).catch(function (result) {
                  if (!angular.isUndefined(result) && result.data != null) {
			                        	 $scope.showLoader = false;
                      angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                          $scope.loadBalancerForm[key].$invalid = true;
                          $scope.loadBalancerForm[key].errorMessage = errorMessage;
                      });
                  }
                  $modalInstance.close();
              });
		}
          },
                  $scope.cancel = function () {
                      $modalInstance.close();
                  };
      }]);
};

$scope.deleteRules = function (size, loadBalancer) {
  appService.dialogService.openDialog("app/views/cloud/network/delete-rule.jsp", 'sm', $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
          $scope.deleteObject = loadBalancer;
          $scope.delete = function (deleteObject) {
              var hasServer = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_DELETE, appService.globalConfig.APP_URL + "loadBalancer/delete/" + loadBalancer.id + "?lang=" + appService.localStorageService.cookie.get('language'), '', loadBalancer);
              hasServer.then(function (result) {
  appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.networkEvents.deleteRules,result.id,$scope.global.sessionValues.id);
                  $scope.LBlist(1);
                  appService.notify({message: 'Deleted successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
              }).catch(function (result) {

                  if (!angular.isUndefined(result) && result.data != null) {
                      if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                          var msg = result.data.globalError[0];
                          appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                      }
                      angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                          $scope.domainForm[key].$invalid = true;
                          $scope.domainForm[key].errorMessage = errorMessage;
                      });
                  }
                  $modalInstance.close();
              });
              $modalInstance.close();
          },
                  $scope.cancel = function () {
                      $modalInstance.close();
                  };
      }]);
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




    $scope.addVM = function (form) {
        $scope.portFormSubmitted = true;
        if (form.$valid) {

            $scope.global.rulesPF[0].privateStartPort = $scope.portForward.privateStartPort;
            $scope.global.rulesPF[0].privateEndPort = $scope.portForward.privateEndPort;
            $scope.global.rulesPF[0].publicStartPort = $scope.portForward.publicStartPort;
            $scope.global.rulesPF[0].publicEndPort = $scope.portForward.publicEndPort;
            $scope.global.rulesPF[0].protocolType = $scope.portForward.protocolType;

            appService.dialogService.openDialog("app/views/cloud/network/vm-list-port.jsp", "lg", $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {

    $scope.portvmLists = function () {
        $scope.templateCategory = 'instance';
        $scope.portvmList = [];
     	 var networkId = $stateParams.id;
         var hasVms = appService.promiseAjax.httpTokenRequest( appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "nics/listbynetwork?networkid="+networkId +"&lang=" + appService.localStorageService.cookie.get('language')+"&sortBy=-id");
        hasVms.then(function (result) {  // this is only run after $http
        $scope.portvmList = result;
        });
    };
$scope.portvmLists ();

 $scope.portforwardSave = function (portinstance) {
			$scope.instances = portinstance;

                        $scope.portForward = $scope.global.rulesPF[0];
                        $scope.formSubmitted = true;
                        $scope.showLoader = true;
                        $scope.portForward.vmInstanceId = $scope.instances.id;
                        $scope.portForward.networkId = 	$stateParams.id;
if(angular.isUndefined($scope.instanceLists.ipAddress.guestIpAddress)){
                        $scope.portForward.vmGuestIp = $scope.instances.ipAddress;
} else
{
$scope.portForward.vmGuestIp = $scope.instanceLists.ipAddress.guestIpAddress;
}
                        $scope.portForward.ipAddressId = $stateParams.id1;
                        $scope.portForward.protocolType = $scope.portForward.protocolType.name;

                        var hasPortForward = appService.crudService.add("portforwarding", $scope.portForward);
                        hasPortForward.then(function (result) {
  appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.networkEvents.portforwardSave,result.id,$scope.global.sessionValues.id);
                            $scope.formSubmitted = false;
                            $modalInstance.close();
                            $scope.showLoader = false;
                            appService.notify({
                                message: 'Rule added successfully',
                                classes: 'alert-success',
                                templateUrl: $scope.global.NOTIFICATION_TEMPLATE
                            });
			$scope.portRulesLists(1);

                        }).catch(function (result) {
                            $scope.showLoader = false;
                            if (!angular.isUndefined(result.data)) {
                                if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                                    var msg = result.data.globalError[0];
                                    $scope.showLoader = false;
                                    if (msg === "0") {
                                        $scope.formSubmitted = false;
                                        $modalInstance.close();
                                        appService.notify({message: 'Rule added successfully.', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                                        $scope.portRulesLists(1);
                                    } else {
                                        appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                                        $modalInstance.close();
                                    }
                                } else if (result.data.fieldErrors != null) {
                                    $scope.showLoader = false;
                                    angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                                        $scope.portForwardForm[key].$invalid = true;
                                        $scope.portForwardForm[key].errorMessage = errorMessage;
                                        $modalInstance.close();
                                    });
                                }
                            }
                            $modalInstance.close();
                        });

  };

//$scope.portForward.privateStartPort = '';
//$scope.portForward.privateEndPort = '';
//$scope.portForward.publicStartPort = '';
//$scope.portForward.publicEndPort = '';
//$scope.portForward.protocolType = '';

                            $scope.cancel = function () {

                                $modalInstance.close();
                            };
                }]);
             }

    }

    $scope.deletePortRules = function (size, portForward) {
        appService.dialogService.openDialog("app/views/cloud/network/confirm-delete.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
                $scope.deleteId = portForward.id;
                $scope.ok = function (deleteId) {
                    $scope.showLoader = true;
                    var hasStorage = appService.crudService.delete("portforwarding", portForward.id);
                    hasStorage.then(function (result) {
  appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.networkEvents.deletePortRules,result.id,$scope.global.sessionValues.id);
                        $scope.showLoader = false;
                        appService.notify({message: 'Deleted successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                        $scope.portRulesLists(1);
                    }).catch(function (result) {
                        if (!angular.isUndefined(result.data)) {
                            if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                                var msg = result.data.globalError[0];
                                $scope.showLoader = false;
                                appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
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
        hasServer.then(function (result) {  // this is only run after $http
											// completes
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

//
// if (!$scope.instanceList[id].isChecked) {
// $scope.vmList.push($scope.instanceList[id]);
// appService.localStorageService.set("vms", $scope.vmList);
// $scope.allItemsSelected = false;
// return;
// }

    $scope.selectVMPort = function () {
        appService.localStorageService.set("vmsPort", filterFilter($scope.instanceList, {selected: true}));
        return filterFilter($scope.instanceList, {selected: true});
    };

    $scope.tabview = appService.localStorageService.get('view');
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

    $scope.openAddIP = function (size, network) {
        appService.dialogService.openDialog("app/views/cloud/network/acquire-IP.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
                $scope.acquire = function (network) {
                    $scope.actionAcquire = true;
                    if ($scope.agree == true) {
                        $scope.acquiringIP = true;
                        var hasIP = appService.crudService.listByQuery("ipAddresses/acquireip?network=" + $stateParams.id);
                        hasIP.then(function (result) {
			$timeout(function(){ $scope.ipLists(1);
                                appService.notify({message: 'Public IP acquired successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                            $scope.acquiringIP = false;$scope.cancel(); }, 5000);


                        }).catch(function (result) {
                            $scope.acquiringIP = false;
				$scope.showLoader = false;
                            if (result.data.globalError[0] != null) {
                                var msg = result.data.globalError[0];
                                appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                                $scope.cancel();
                            }
                            $modalInstance.close();
                        });

                    }
                },
                        $scope.cancel = function () {
                            $modalInstance.close();
                        };
            }]);
    };

    $scope.staticNat = function (size, network) {
        appService.dialogService.openDialog("app/views/cloud/network/enable-static-nat.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {

        	$scope.enableStaticNat = function (network) {
                $scope.actionEnable = true;

                    appService.dialogService.openDialog("app/views/cloud/network/vm-list-enable-nat.jsp", "lg", $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
                        $scope.portvmLists = function () {
                            $scope.templateCategory = 'instance';
                            $scope.portvmList = [];
                         	 var networkId = network.id;
                            var hasVms = appService.promiseAjax.httpTokenRequest( appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "virtualmachine/network?networkId="+networkId +"&lang=" + 	appService.localStorageService.cookie.get('language')+"&sortBy=-id");
                            hasVms.then(function (result) {  // this is only run after $http
                            $scope.portvmList = result;

                            });
                        };
                    $scope.portvmLists ();
                     $scope.enableStaticNatSave = function (natInstance) {
                    			$scope.instances = natInstance;

                                            $scope.staticNat = $scope.global.rulesPF[0];
                                            $scope.formSubmitted = true;
                                            $scope.showLoader = true;
                                            $scope.staticNat.vmInstanceId = $scope.natInstance.id;
                                            $scope.staticNat.networkId = 	$stateParams.id;

                    if(angular.isUndefined($scope.instanceLists.ipAddress.guestIpAddress)){
                    	$scope.staticNat.vmGuestIp = $scope.instances.ipAddress;
                    } else {
                    	$scope.staticNat.vmGuestIp = $scope.instanceLists.ipAddress.guestIpAddress;
                    }
                                            $scope.staticNat.ipAddressId = $stateParams.id1;

                                            var hasStaticNat = appService.promiseAjax.httpTokenRequest( appService.globalConfig.HTTP_GET,
                                            		appService.globalConfig.APP_URL + "ipAddresses/nat?ipaddress="+$scope.staticNat.ipAddressId +
                                            		"&vm="+ natInstance.id + "&guestip="+ $scope.staticNat.vmGuestIp + "&type="+"enable" + "&lang=" +
                                            		appService.localStorageService.cookie.get('language')+"&sortBy=-id");

                                            hasStaticNat.then(function (result) {
                                                $scope.formSubmitted = false;
                                                $modalInstance.close();
                                                $state.reload();
                                                $scope.showLoader = false;
                                                appService.notify({
                                                    message: 'Static Nat Enabled successfully',
                                                    classes: 'alert-success',
                                                    templateUrl: $scope.global.NOTIFICATION_TEMPLATE
                                                });
                                                $modalInstance.close();

                                                $scope.cancel();
                                                $scope.ipLists(1);
                                                $state.reload();

                                            }).catch(function (result) {
                                                $scope.showLoader = false;
                                                if (!angular.isUndefined(result.data)) {
                                                    if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                                                        var msg = result.data.globalError[0];
                                                        $scope.showLoader = false;
                                                       } else if (result.data.fieldErrors != null) {
                                                        $scope.showLoader = false;
                                                        angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                                                            $scope.staticNatForm[key].$invalid = true;
                                                            $scope.staticNatForm[key].errorMessage = errorMessage;
                                                            $modalInstance.close();
                                                        });
                                                    }
                                                }
                                                $modalInstance.close();
                                            });

                      };
                 }]);
                    $scope.cancel = function () {
                        $modalInstance.close();


                    };
            }
            $scope.cancel = function () {
                $modalInstance.close();
            };

            }]);


    };
    $scope.disableNat = function (size, natInstance) {
        appService.dialogService.openDialog("app/views/cloud/network/disable-static-nat.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
                $scope.disableStaticNat = function (natInstance) {
                    			$scope.instances = natInstance;

                                            $scope.staticNat = $scope.global.rulesPF[0];
                                            $scope.formSubmitted = true;
                                            $scope.showLoader = true;
                                            $scope.staticNat.vmInstanceId = $scope.natInstance.id;
                                            $scope.staticNat.networkId = 	$stateParams.id;

                    if(angular.isUndefined($scope.instanceLists.ipAddress.guestIpAddress)){
                    	$scope.staticNat.vmGuestIp = $scope.instances.ipAddress;
                    } else {
                    	$scope.staticNat.vmGuestIp = $scope.instanceLists.ipAddress.guestIpAddress;
                    }
                                            $scope.staticNat.ipAddressId = $stateParams.id1;

                                            var hasStaticNat = appService.promiseAjax.httpTokenRequest( appService.globalConfig.HTTP_GET,
                                            		appService.globalConfig.APP_URL + "ipAddresses/nat?ipaddress="+$scope.staticNat.ipAddressId +
                                            		"&vm="+ natInstance.id + "&guestip="+ $scope.staticNat.vmGuestIp + "&type="+"disable" + "&lang=" +
                                            		appService.localStorageService.cookie.get('language')+"&sortBy=-id");
                                            hasStaticNat.then(function (result) {
                                                $scope.formSubmitted = false;
                                                $modalInstance.close();
                                                $scope.showLoader = false;
                                                appService.notify({
                                                    message: 'Static Nat Disabled successfully',
                                                    classes: 'alert-success',
                                                    templateUrl: $scope.global.NOTIFICATION_TEMPLATE
                                                });
                                                $state.reload();
                                                $scope.ipLists(1);
                                                $state.reload();
                                                $window.location.href = '#/network/list/view/' + $stateParams.id +'/ip-address/' + $scope.staticNat.ipAddressId;

                                            }).catch(function (result) {
                                                $scope.showLoader = false;
                                                if (!angular.isUndefined(result.data)) {
                                                    if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                                                        var msg = result.data.globalError[0];
                                                    } else if (result.data.fieldErrors != null) {
                                                        $scope.showLoader = false;
                                                        angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                                                            $scope.staticNatForm[key].$invalid = true;
                                                            $scope.staticNatForm[key].errorMessage = errorMessage;
                                                        });
                                                    }
                                                }
                                                $modalInstance.close();
                                            });
                                            $state.reload();
                                                $scope.cancel = function () {

                                                    $modalInstance.close();
                                                };

            },
                        $scope.cancel = function () {
                            $modalInstance.close();
                        };
            }]);
    };



      $scope.releaseIP = function (size, ipAddress) {
	$scope.ipAddress = angular.copy(ipAddress);
        appService.dialogService.openDialog("app/views/cloud/network/release-ip.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
                $scope.release = function (network) {
			$scope.showLoader = true;
                        var hasIP = appService.crudService.listByQuery("ipAddresses/dissociate?ipuuid=" + $scope.ipAddress.uuid);
                        hasIP.then(function (result) {
				$timeout(function(){  $scope.ipLists(1);
                                appService.notify({message: 'Public IP released successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});$scope.showLoader = false;$scope.cancel();}, 5000);

                        }).catch(function (result) {
                        });

                },
                        $scope.cancel = function () {
                            $modalInstance.close();
                        };
            }]);
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
// responsive: true,
// maintainAspectRatio: true
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
                // Create a new sticky policy

//Add the sticky policy
$scope.createStickiness = function (size) {
    appService.dialogService.openDialog($scope.global.VIEW_URL + "cloud/network/stickiness.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope',function ($scope, $modalInstance, $rootScope) {
	    //Assign loadbalancer stickiness in object
            $scope.addStickiness = function (form,stickiness) {
 		$scope.stickiness = stickiness;
                    $scope.formSubmitted = true;
                    if ($scope.stickiness.stickinessMethod == $scope.global.STICKINESS.NONE) {
                     $modalInstance.close();
                    }
                    if (form.$valid) {
                        appService.notify({message: 'Configured sticky policy successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                        $modalInstance.close();
                    }
                },
                     $scope.cancel = function () {
                 	$modalInstance.close();
                        };
            }]);
    };

$scope.configureStickiness = function (size, loadBalancer) {
    appService.dialogService.openDialog($scope.global.VIEW_URL + "cloud/network/stickiness.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope',function ($scope, $modalInstance, $rootScope) {
	$scope.stickyLoadBalancer = loadBalancer;
	    //Assign loadbalancer stickiness in object
          $scope.addStickiness = function(form, stickiness) {
              $scope.formSubmitted = true;
              if (!angular.isUndefined($scope.stickyLoadBalancer.id) && $scope.stickyLoadBalancer.id != null) {
	      var loadBalancerParams = ["stickinessMethod", "stickinessName", "stickyTableSize","cookieName","stickyExpires","stickyMode","stickyLength","stickyRequestLearn",
              "stickyPrefix","stickyNoCache","stickyIndirect","stickyPostOnly","stickyCompany"];
                 if (angular.isUndefined($scope.stickiness.stickinessName) || $scope.stickiness.stickinessName == null) {
                     $scope.showLoader = false;
                 }
                 if ($scope.stickiness.stickinessMethod == $scope.global.STICKINESS.NONE) {
                     $modalInstance.close();
                 }
                 else {
                 if(form.$valid){
		 for(var i=0; i < loadBalancerParams.length; i++) {
		     if(!angular.isUndefined(stickiness[loadBalancerParams[i]]) && stickiness[loadBalancerParams[i]] != null){
		         $scope.stickyLoadBalancer.lbPolicy[loadBalancerParams[i]] = stickiness[loadBalancerParams[i]];
		     }
		 }
		    delete $scope.stickyLoadBalancer.stickyTableSize;
			delete $scope.stickyLoadBalancer.stickyExpires;
			delete $scope.stickyLoadBalancer.cookieName;
			delete $scope.stickyLoadBalancer.domain;
			   $scope.showLoader = true;
                        var hasServer = appService.crudService.update("loadBalancer", $scope.stickyLoadBalancer);
			  hasServer.then(function (result) {
  appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.networkEvents.configureStickiness,result.id,$scope.global.sessionValues.id);
                            $scope.formSubmitted = false;
			    $modalInstance.close();
			    $scope.showLoader = false;
                         appService.notify({message: 'Policy added successfully.', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                             $state.reload();
			    $scope.LBlist(1);
                            $scope.stickiness.stickinessMethod = "";
    			    $scope.stickiness.stickinessName = "";
    			    $scope.stickiness.stickyTableSize = "";
    			    $scope.stickiness.stickyExpires = "";
                            $scope.stickiness.cookieName = "";
                            $scope.stickiness.stickyMode = "";
                            $scope.stickiness.stickyLength = "";
                            $scope.stickiness.stickyHoldTime = "";
                            $modalInstance.close();
                        }).catch(function (result) {
                    		if(result.data.globalError[0] != ''){
                    			var msg = result.data.globalError[0];
                    			appService.notify({message: msg, classes: 'alert-danger',
                    				templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                    			$modalInstance.close();
                            	}
                    	});
              }}
		}
		},

                     $scope.cancel = function () {
                 	$modalInstance.close(); $scope.formElements = {
	    };
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

  //Add the sticky policy
$scope.editStickiness = function (size,loadBalancer) {
	$scope.stickyLoadBalancer = loadBalancer;
    appService.dialogService.openDialog($scope.global.VIEW_URL + "cloud/network/edit-stickiness.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope',function ($scope, $modalInstance, $rootScope) {
	   		var loadBalancerParams = ["stickinessMethod", "stickinessName", "stickyTableSize","cookieName","stickyExpires","stickyMode","stickyLength","stickyRequestLearn",
"stickyPrefix","stickyNoCache","stickyIndirect","stickyPostOnly","stickyCompany"];
		 angular.forEach($scope.formElements.stickinessList, function(value, key){
			for(var i=0; i < loadBalancerParams.length; i++) {
				if(!angular.isUndefined(loadBalancer[loadBalancerParams[i]]) && loadBalancer[loadBalancerParams[i]] != null){
					$scope.stickiness[loadBalancerParams[i]] = loadBalancer[loadBalancerParams[i]];
				}
			}
    		});

                $scope.editStickinessPolicy = function (form, loadBalancer) {
                        $scope.showLoader = true;
                        $scope.formSubmitted = true;
                     if ($scope.stickiness.stickinessMethod == $scope.global.STICKINESS.NONE) {
                     $modalInstance.close();
                 }
                     else {
			for(var i=0; i < loadBalancerParams.length; i++) {
				if(!angular.isUndefined(loadBalancer[loadBalancerParams[i]]) && loadBalancer[loadBalancerParams[i]] != null){
					$scope.stickyLoadBalancer[loadBalancerParams[i]] = loadBalancer[loadBalancerParams[i]];

				}
			}
		    delete $scope.stickyLoadBalancer.stickyTableSize;
			delete $scope.stickyLoadBalancer.stickyExpires;
			delete $scope.stickyLoadBalancer.cookieName;
                        $scope.showLoader = true;
                        var hasServer = appService.crudService.update("loadBalancer", $scope.stickyLoadBalancer);
                        hasServer.then(function (result) {
  appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.networkEvents.editStickiness,result.id,$scope.global.sessionValues.id);
                            appService.notify({message: 'Policy updated successfully.', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                            $modalInstance.close();
                            $scope.showLoader = false;
                        }).catch(function (result) {
                    		if(result.data.globalError[0] != ''){
                    			var msg = result.data.globalError[0];
                    			appService.notify({message: msg, classes: 'alert-danger',
                    				templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                    			$modalInstance.close();
                            	}
                    	});
                        }

                },  $scope.cancel = function () {
                            $modalInstance.close();
                        };
		 }]);
	},

	 $scope.formElements = {
			 stickinessList : [
	    		 $scope.global.STICKINESS.NONE,
            	 $scope.global.STICKINESS.SOURCEBASED,
           		 $scope.global.STICKINESS.APPCOOKIE,
	    		 $scope.global.STICKINESS.LBCOOKIE
	                  ],
	    };

    $scope.healthCheck = function (form) {
        $scope.loadFormSubmitted = true;
        if (form.$valid) {
            $scope.global.rulesLB[0].name = $scope.load.name;
            $scope.global.rulesLB[0].publicPort = $scope.publicPort;
            $scope.global.rulesLB[0].privatePort = $scope.privatePort;
            modalService.trigger('app/views/cloud/network/healthCheck.jsp', 'sm');
        }
    };

    $scope.removeRule= function(size,vmIpAddress, loadBalancer) {
      	 appService.dialogService.openDialog("app/views/cloud/instance/confirm-delete.jsp", 'md', $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
$scope.ok = function(deleteObject) {
		loadBalancer.vmIpAddress = [];
		loadBalancer.vmIpAddress.push(vmIpAddress);

		$scope.deleteObject = loadBalancer;
      	     $scope.showLoader = true;
		var hasNic = appService.crudService.updates("loadBalancer/removerule/",$scope.deleteObject);
             hasNic.then(function (result) {
		       $scope.showLoader = false;
               appService.notify({message: 'Rule removed from Ip successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
               $modalInstance.close();
                  $scope.LBlist(1);
             }).catch(function (result) {
                 if (!angular.isUndefined(result.data)) {
                     if (result.data.globalError != '' && !angular.isUndefined(result.data.globalError)) {
                         var msg = result.data.globalError[0];
                         $scope.showLoader = false;
                         appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                     } else if (result.data.fieldErrors != null) {
                         angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                             $scope.attachvolumeForm[key].$invalid = true;
                             $scope.attachvolumeForm[key].errorMessage = errorMessage;
                         });
                     }
                 }
             });
             },
             $scope.cancel = function () {
                  $modalInstance.close();
             };
           }]);
};


    $scope.healthChecklist = function () {

        appService.dialogService.openDialog("app/views/cloud/network/healthChecklist.jsp", 'md', $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
                $scope.ok = function () {

                },
                        $scope.cancel = function () {
                            $modalInstance.close();
                        };
            }]);
    };

    };

