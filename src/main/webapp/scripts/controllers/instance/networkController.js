/**
 *
 * networkCtrl
 *
 */

angular
    .module('homer')
    .controller('networkCtrl', networkCtrl)

function networkCtrl($scope, $modal, $state, $window, $stateParams,appService) {

	$scope.nicLists = {};
    $scope.paginationObject = {};
    $scope.nicForm = {};
    $scope.global = appService.globalConfig;
    $scope.sort = appService.globalConfig.sort;
    $scope.changeSorting = appService.utilService.changeSorting;
    $scope.networkList = [];

    $scope.instanceDetails='';
    if ($stateParams.id > 0) {
        var hasServer = appService.crudService.read("virtualmachine", $stateParams.id);
        hasServer.then(function (result) {  // this is only run after $http
            $scope.instance = result;
            console.log( $scope.instance);
            $scope.networkList = result.network;

        });
    }

    // Nic List
    $scope.nicList = function (pageNumber) {
    	$scope.showLoader = true;
        $scope.nic = {};
    	var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasNics = appService.crudService.list("nics", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
        hasNics.then(function (result) {  // this is only run after $http completes0
            $scope.nicLists = result;

            // For pagination
            $scope.paginationObject.limit = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
            $scope.showLoader = false;
        });
    };
    $scope.nicList(1);

 // Add the IP Address
    $scope.acquireNewIP = function (size) {
        appService.dialogService.openDialog($scope.global.VIEW_URL + "cloud/instance/addIP.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
                // Create a new IP
                $scope.saveIP = function (form) {
                    $scope.formSubmitted = true;
                    if (form.$valid) {
                    	$scope.showLoader = true;
                        var hasServer = appService.crudService.add("nics", nic);
                        hasServer.then(function (result) {  // this is only run after $http completes
                            $scope.formSubmitted = false;
                            $modalInstance.close();
                            $scope.showLoader = false;
                            appService.notify({message: 'IP Address acquired successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                            $scope.nicList(1);
                        }).catch(function (result) {
                        	$scope.showLoader = false;
            		    if (!angular.isUndefined(result.data)) {
                		if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                  	   	 var msg = result.data.globalError[0];
                  	   	 $scope.showLoader = false;
                	    	 appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                    	} else if (result.data.fieldErrors != null) {
                       	$scope.showLoader = false;
                        	angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                            	$scope.nicForm[key].$invalid = true;
                            	$scope.nicForm[key].errorMessage = errorMessage;
                        	});
                		}
                	}
            	});
                    	}
                	},
                 	$scope.cancel = function () {
                     	$modalInstance.close();
                 	};
            	}]);
    	};

    	 // Delete the Ip Address
        $scope.deleteIP = function (size, nic) {
        	appService.dialogService.openDialog($scope.global.VIEW_URL + "cloud/instance/deleteIP.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
                    $scope.deleteObject = nic;
                    $scope.ok = function (deleteObject) {
                    	$scope.showLoader = true;
                        nic.isActive = false;
                        var hasServer = appService.crudService.softDelete("nics", deleteObject);
                        hasServer.then(function (result) {
                            $scope.nicList(1);
                            $scope.showLoader = false;
                            appService.notify({message: 'IP deleted successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
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




    // $scope.nicList();
	$scope.nicLists = function (nic, networkList) {
       	var instanceId = $stateParams.id;

       	var hasNic = appService.promiseAjax.httpTokenRequest( appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "nics/listbyinstances?instanceid="+instanceId +"&lang=" + appService.localStorageService.cookie.get('language')+"&sortBy=-id");
		hasNic.then(function (result) {
	            var networkList = [];
		    $scope.nicList = result;

		    if(!angular.isUndefined(networkList)) {
			    angular.forEach($scope.nicList, function(nic, key) {
				angular.forEach(networkList, function(network, networkKey) {
					if(nic.network.id != network.id) {
					   networkList.push(network);
					}
			    	});
			    });
			    $scope.networkList = networkList;
	            }
		});
	    };
	    $scope.nicLists(1);

    $scope.addNetworkToVM = function (instance) {
	var nicList = $scope.nicLists;
        appService.dialogService.openDialog("app/views/cloud/instance/add-network.jsp", 'md', $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {

        $scope.networkList = function (instance) {

	        		if($scope.instance.projectId != null) {
	        			console.log("project " + $scope.instance.projectId);

	        			var hasNetworks = appService.promiseAjax.httpTokenRequest( appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "guestnetwork" + "/listall/"+$scope.instance.projectId);
	        			hasNetworks.then(function (result) {
	        				$scope.networkList = result;
						 //$scope.nicLists(1, result);
	        			});
	        		} else {
	        			console.log("department " + $scope.instance.departmentId);
	        			var hasNetworks = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "guestnetwork" + "/list/"+$scope.instance.departmentId);
	        			hasNetworks.then(function (result) {
	        				$scope.networkList = result;
						// $scope.nicLists(1, result);

	        			});
	        		}
	        	};
	            $scope.networkList(1);

		// Volume List
	    	//nicList(1);

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
                        $scope.showLoader = false;
                    	appService.notify({message: 'NIC attached successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                        $modalInstance.close();
                        $scope.nicLists(1);
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
                }
            },
            $scope.nicLists = function (nic, networkList) {
               	var instanceId = $stateParams.id;

               	var hasNic = appService.promiseAjax.httpTokenRequest( appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "nics/listbyinstances?instanceid="+instanceId +"&lang=" + appService.localStorageService.cookie.get('language')+"&sortBy=-id");
        		hasNic.then(function (result) {
        	            var networkList = [];
        		    $scope.nicList = result;

        		    if(!angular.isUndefined(networkList)) {
        			    angular.forEach($scope.nicList, function(nic, key) {
        				angular.forEach(networkList, function(network, networkKey) {
        					if(nic.network.id != network.id) {
        					   networkList.push(network);
        					}
        			    	});
        			    });
        			    $scope.networkList = networkList;
        	            }
        		    $state.reload();
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

		       $scope.showLoader = false;
               appService.notify({message: 'NIC deleted successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
               $modalInstance.close();
               $scope.nicLists(1);
             });

             },
             $scope.nicLists = function (nic, networkList) {
                	var instanceId = $stateParams.id;

                	var hasNic = appService.promiseAjax.httpTokenRequest( appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "nics/listbyinstances?instanceid="+instanceId +"&lang=" + appService.localStorageService.cookie.get('language')+"&sortBy=-id");
         		hasNic.then(function (result) {
         	            var networkList = [];
         		    $scope.nicList = result;

         		    if(!angular.isUndefined(networkList)) {
         			    angular.forEach($scope.nicList, function(nic, key) {
         				angular.forEach(networkList, function(network, networkKey) {
         					if(nic.network.id != network.id) {
         					   networkList.push(network);
         					}
         			    	});
         			    });
         			    $scope.networkList = networkList;
         	            }
         		    $state.reload();
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

                       $scope.showLoader = false;
                       appService.notify({message: 'NIC updated successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                       $modalInstance.close();
                       $scope.nicLists(1);
                    });

                },
                $scope.nicLists = function (nic, networkList) {
                   	var instanceId = $stateParams.id;

                   	var hasNic = appService.promiseAjax.httpTokenRequest( appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "nics/listbyinstances?instanceid="+instanceId +"&lang=" + appService.localStorageService.cookie.get('language')+"&sortBy=-id");
            		hasNic.then(function (result) {
            	            var networkList = [];
            		    $scope.nicList = result;

            		    if(!angular.isUndefined(networkList)) {
            			    angular.forEach($scope.nicList, function(nic, key) {
            				angular.forEach(networkList, function(network, networkKey) {
            					if(nic.network.id != network.id) {
            					   networkList.push(network);
            					}
            			    	});
            			    });
            			    $scope.networkList = networkList;
            			    $state.reload();
            	            }
            		});
            	    },
                $scope.cancel = function () {
                $modalInstance.close();
                };
            }]);
       };


}
