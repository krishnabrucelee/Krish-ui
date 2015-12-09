/**
 *
 * networkCtrl
 *
 */

angular
    .module('homer')
    .controller('networkCtrl', networkCtrl)

function networkCtrl($scope, $modal, $window, $stateParams,globalConfig, localStorageService, promiseAjax,dialogService,notify, crudService) {

    $scope.networkList = [];

    $scope.instanceDetails='';
    if ($stateParams.id > 0) {
        var hasServer = crudService.read("virtualmachine", $stateParams.id);
        hasServer.then(function (result) {  // this is only run after $http
            $scope.instance = result;
            console.log( $scope.instance);
            $scope.networkList = result.network;

        });
    }

    $scope.networkList = {};
    $scope.paginationObject = {};
    $scope.networkForm = {};
    $scope.global = crudService.globalConfig;
    // Guest Network List
    $scope.list = function (pageNumber) {
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasGuestNetworks = crudService.list("guestnetwork", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
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

    $scope.addNetworkToVM = function () {
        dialogService.openDialog("app/views/cloud/instance/add-network.jsp", 'md', $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
        	$scope.listNetwork = function () {
            	var instanceId = $stateParams.id;
            	var hasGuestNetworks =  promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "guestnetwork/list/instance?instanceid="+instanceId +"&lang=" + localStorageService.cookie.get('language')+"&sortBy=-id");
                   hasGuestNetworks.then(function (result) {  // this is only run after $http
                       $scope.networkList = result;
                       console.log($scope.networkList);
                   });
               };
           	$scope.listNetwork();
            $scope.addNicToVirtualMachine = function (form, network) {
                $scope.formSubmitted = true;
                if (form.$valid) {
                	$scope.instance.network.push(network);
                	$scope.instance.networkUuid = network.uuid;
                    $scope.showLoader = true;
                    var hasServer = crudService.add("nics", $scope.instance);
                    hasServer.then(function (result) {  // this is only run after $http completes
                        $scope.showLoader = false;
                    	notify({message: 'Attached successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                        $modalInstance.close();
                    }).catch(function (result) {
                        if (!angular.isUndefined(result.data)) {
                            if (result.data.globalError != '' && !angular.isUndefined(result.data.globalError)) {
                                var msg = result.data.globalError[0];
                                $scope.showLoader = false;
                                notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                            } else if (result.data.fieldErrors != null) {
                                angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                                    $scope.attachvolumeForm[key].$invalid = true;
                                    $scope.attachvolumeForm[key].errorMessage = errorMessage;
                                });
                            }
                        }
                    });
                }
            };
            $scope.cancel = function () {
                $modalInstance.close();
            };
            }]);
    };

    $scope.removeNicToVM = function(form, network) {
      	 dialogService.openDialog("app/views/common/confirm-delete.jsp", 'md', $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
         	var instanceId = $stateParams.id;
         	$scope.instance.nicUuid = network.uuid;
      		 $scope.deleteObject = $scope.instance;
        	//$scope.instance.network.push(network);

               $scope.ok = function (deleteObject) {
            	   var hasServer = promiseAjax.httpTokenRequest( globalConfig.HTTP_DELETE , globalConfig.APP_URL + "virtualmachine/removenic/"+deleteObject.id+"?lang=" + localStorageService.cookie.get('language'), '', deleteObject);
                   hasServer.then(function (result) {
                       $scope.list(1);
                       notify({message: 'Deleted successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                   });
                   $modalInstance.close();
               },
               $scope.cancel = function () {
                   $modalInstance.close();
               };
           }]);
      };

      $scope.updateNicToVM = function(form, network) {
       	 dialogService.openDialog("app/views/cloud/instance/confirm-update.jsp", 'md', $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
          	var instanceId = $stateParams.id;
        	$scope.instance.nicUuid = network.uuid;

                $scope.ok = function (instance) {
                    var hasServer = crudService.update("virtualmachine/updatenic/", vmInstance.nicUuid);
                    hasServer.then(function (result) {
                        $scope.list(1);

                        notify({message: 'Updated successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                    });
                    $modalInstance.close();
                },
                $scope.cancel = function () {
                    $modalInstance.close();
                };
            }]);
       };


}