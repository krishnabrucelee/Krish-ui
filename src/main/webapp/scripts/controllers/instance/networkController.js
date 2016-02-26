/**
 *
 * networkCtrl
 *
 */

angular
    .module('homer')
    .controller('networkCtrl', networkCtrl)

function networkCtrl($scope, $modal, $state, $window, $stateParams,appService) {

   $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.addNicToVm, function() {
  //      $scope.nicList = appService.webSocket;
    });
    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.removeNicToVM, function() {
   //     $scope.nicList = appService.webSocket;
    });
    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.updateNicToVM, function() {
    //    $scope.nicList = appService.webSocket;
    });

    $scope.nicIPLists = {};
    $scope.nicForm = {};
    $scope.global = appService.globalConfig;
    $scope.sort = appService.globalConfig.sort;
    $scope.changeSorting = appService.utilService.changeSorting;
    $scope.networkList = [];
    $scope.nic = {};
    $scope.vmIp = {};

    $scope.instanceDetails='';
    if ($stateParams.id > 0) {
        var hasServer = appService.crudService.read("virtualmachine", $stateParams.id);
        hasServer.then(function (result) {  // this is only run after $http
            $scope.instance = result;
            $scope.networkList = result.network;
            $state.current.data.pageName = result.name;
            $state.current.data.id = result.id;
        });
    }
    $scope.networkList = {};
    $scope.paginationObject = {};
    $scope.networkForm = {};
    $scope.global = appService.crudService.globalConfig;
    // Guest Network List
    $scope.list = function (pageNumber) {
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasGuestNetworks = appService.crudService.list("guestnetwork", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
        hasGuestNetworks.then(function (result) {
            $scope.networkList = result;
            $scope.networkList.Count = 0;
            if (result.length != 0) {
                $scope.networkList.Count = result.totalItems;
            }
            // For pagination
            $scope.paginationObject.limit = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
        });
    };
    $scope.list(1);

  //Instance Nic List
	    $scope.instanceNicList = function () {
       	var instanceId = $stateParams.id;
       	var hasNic = appService.promiseAjax.httpTokenRequest( appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "nics/listbyinstances?instanceid="+instanceId +"&lang=" + appService.localStorageService.cookie.get('language')+"&sortBy=-id");
	        hasNic.then(function (result) {
	            $scope.nicList = result;
	            $scope.nicArray = [];
	            angular.forEach($scope.nicList, function(nic, nicKey) {
	            	$scope.nicArray.push(nic.network.id);
	    		})
	        });
	    };
	    if(!angular.isUndefined($stateParams.id)){
	        $scope.instanceNicList();
	    	}

    $scope.addNetworkToVM = function (instance) {
        appService.dialogService.openDialog("app/views/cloud/instance/add-network.jsp", 'md', $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
        	$scope.networkList = function (instance) {
        	var networkAction = "";
	        		if($scope.instance.projectId != null) {
	        			networkAction = "/listall/"+$scope.instance.projectId;
	        		} else {
	        			networkAction = "/list/"+$scope.instance.departmentId;
	        		}
	        		var hasNetworks = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "guestnetwork" + networkAction);
        			hasNetworks.then(function (result) {
        				var networkList = [];
        				$scope.networkList = result;
    					angular.forEach(result, function(network, networkKey) {
        					if($scope.nicArray.indexOf(network.id) < 0) {
        						networkList.push(network);
        					}
        				})
        				$scope.networkList = networkList;
        			});
	        	};
	    	    $scope.networkList(1);

	    	$scope.addNicToVirtualMachine = function (form, network) {
                $scope.formSubmitted = true;
                if (form.$valid) {

                	$scope.nic = {};
                	$scope.nic.vmInstance = $scope.instance;
                	delete $scope.nic.vmInstance.network;
                    $scope.nic.networkId = network.id;
                    delete $scope.nic.network;
                        $scope.showLoader = true;
                        var hasServer = appService.crudService.add("nics", $scope.nic);
                        hasServer.then(function (result) {  // this is only run after $http completes
			appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.vmEvents.addNicToVm,result.id,$scope.global.sessionValues.id);
                        $scope.showLoader = false;
                    	appService.notify({message: 'Attached successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
        			    $state.reload();
                        $modalInstance.close();
                        $state.reload();
                        $scope.instanceNicList();
               }).catch(function (result) {
                        if (!angular.isUndefined(result.data)) {
                             if (result.data.fieldErrors != null) {
                                angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                                    $scope.attachvolumeForm[key].$invalid = true;
                                    $scope.attachvolumeForm[key].errorMessage = errorMessage;
                                });
                            }
                        }
                    });
                }
            },
            $scope.instanceNicList = function () {
             	var instanceId = $stateParams.id;
             	var hasNic = appService.promiseAjax.httpTokenRequest( appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "nics/listbyinstances?instanceid="+instanceId +"&lang=" + appService.localStorageService.cookie.get('language')+"&sortBy=-id");
      	        hasNic.then(function (result) {
      	            $scope.nicList = result;
      	            $scope.nicArray = [];
      	            angular.forEach($scope.nicList, function(nic, nicKey) {
      	            	$scope.nicArray.push(nic.network.id);
      	    		})
      	        });
      	    },
            $scope.cancel = function () {
                $modalInstance.close();
            };
            }]);
    };

    $scope.removeNicToVM = function(nic) {
      	 appService.dialogService.openDialog("app/views/cloud/instance/confirm-delete.jsp", 'md', $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
      		 $scope.deleteId = nic.id;
             $scope.ok = function (nicId) {
		     $scope.showLoader = true;
		     var hasNic = appService.crudService.softDelete("nics", nic);
             hasNic.then(function (result) {
			appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.vmEvents.removeNicToVM,result.id,$scope.global.sessionValues.id);
		       $scope.showLoader = false;
               appService.notify({message: 'NIC deleted successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
               $modalInstance.close();
        	   $scope.instanceNicList();
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

      $scope.updateNicToVM = function(form, nic) {
       	 appService.dialogService.openDialog("app/views/cloud/instance/confirm-update.jsp", 'md', $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
          	var instanceId = $stateParams.id;
                   $scope.ok = function (instanceId) {
                	$scope.showLoader = true;
                    var hasServer = appService.crudService.update("nics", nic);
                    hasServer.then(function (result) {
			appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.vmEvents.updateNicToVM,result.id,$scope.global.sessionValues.id);
                       $scope.showLoader = false;
                       appService.notify({message: 'NIC updated successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
              		 	$state.reload();
                       $modalInstance.close();
                       $scope.instanceNicList();
                    });
                },
                $scope.instanceNicList = function () {
                 	var instanceId = $stateParams.id;
                 	var hasNic = appService.promiseAjax.httpTokenRequest( appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "nics/listbyinstances?instanceid="+instanceId +"&lang=" + appService.localStorageService.cookie.get('language')+"&sortBy=-id");
          	        hasNic.then(function (result) {
          	            $scope.nicList = result;
          	            $scope.nicArray = [];
          	            angular.forEach($scope.nicList, function(nic, nicKey) {
          	            	$scope.nicArray.push(nic.network.id);
          	    		})
          	        });
          	    },
                $scope.cancel = function () {
                $modalInstance.close();
                };
            }]);
       };
     }
