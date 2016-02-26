/**
 *
 * networkCtrl
 *
 */

angular
    .module('homer')
    .controller('secondaryIpCtrl', secondaryIpCtrl)

function secondaryIpCtrl($scope, $modal, $state, $window, $stateParams,appService) {

    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.acquireNewIP, function() {
  //      $scope.nicIPLists = appService.webSocket;
    });
    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.deleteIP, function() {
    //    $scope.nicIPLists = appService.webSocket;
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
            setTimeout(function() {
	        $state.current.data.pageName = result.name;
		$state.current.data.id = result.id;
	    }, 1000)
        });
    }

     // Nic List
    $scope.nicIPList = function () {
    	$scope.showLoader = true;
        $scope.nic = {};
        var instanceId = $stateParams.id;
	$scope.nicip=$stateParams.id1;
       	var hasNicIP = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "nics/listbyvminstances?instanceid="+instanceId +"&lang=" + appService.localStorageService.cookie.get('language')+"&sortBy=-id");
        hasNicIP.then(function (result) {
            $scope.nicIPLists = result;
            $scope.showLoader = false;

        });
    };
    $scope.nicIPList();

 // Add the IP Address
    $scope.acquireNewIP = function (size) {
        appService.dialogService.openDialog($scope.global.VIEW_URL + "cloud/instance/addIP.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
                // Create a new IP
                $scope.nic.id = $stateParams.id1;
                $scope.saveIP = function (form,nic) {
                    $scope.formSubmitted = true;
                    if (form.$valid) {
                    	$scope.showLoader = true;
                        var hasServer = appService.crudService.add("nics/acquire/" + $scope.nic.id,nic);
                        hasServer.then(function (result) {
			   appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.vmEvents.acquireNewIP,result.id,$scope.global.sessionValues.id);
                            $scope.formSubmitted = false;
                            $modalInstance.close();
                            $scope.showLoader = false;
                            appService.notify({message: 'IP Address acquired successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                            $scope.nicIPList();
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

                    $scope.ok = function (deleteObject) {
                        $scope.deleteObject = nic;
                    	$scope.showLoader = true;
                    	nic.isActive = false;
 			var hasServer =  appService.crudService.add("nics/release/" + nic.id,nic);
                        hasServer.then(function (result) {
			   appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.vmEvents.deleteIP,result.id,$scope.global.sessionValues.id);
                            $scope.showLoader = false;
                            appService.notify({message: 'IP deleted successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
			    $scope.nicIPList();
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

};
