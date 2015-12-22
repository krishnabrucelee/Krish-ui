/**
 *
 * instanceListCtrl
 *
 */

angular.module('homer').controller('instanceListCtrl', instanceListCtrl)
		.controller('instanceDetailsCtrl', instanceDetailsCtrl)

function instanceListCtrl($scope, $sce, $log, $filter, dialogService, promiseAjax, $state,
		globalConfig, crudService,$modal, localStorageService, $window, notify) {
	$scope.instanceList = [];
	$scope.instancesList = [];
        $scope.global = crudService.globalConfig;
	$scope.paginationObject = {};
	$scope.sort = {
		column : '',
		descending : false
	};

//	  $scope.showConsole = function(vm) {
//		  $scope.vm = vm;
//		  var hasVms = crudService.updates("virtualmachine/console", vm);
//			hasVms.then(function(result) {
//				console.log(result);
//				 $window.open(result.success, 'VM console', 'width=500,height=400');
//			});
//	  }

	$scope.showConsole = function(vm) {
		  $scope.vm = vm;
		  var hasVms = crudService.updates("virtualmachine/console", vm);
			hasVms.then(function(result) {
				$scope.consoleUrl = $sce.trustAsResourceUrl(result.success);
				//$scope.consoleUrl = $sce.trustAsResourceUrl("http://192.168.1.152/console/?token=MTkyLjE2OC4xLjE1MnxpLTItNjktVk18bm92bmN0ZXN0");
				$scope.instance = vm;
				 window.open($scope.consoleUrl, 'Console', 'width=750,height=580');
		        /*dialogService.openDialog("app/views/cloud/instance/view-console.jsp", 'lg', $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
		          $scope.cancel = function () {
	  	               $modalInstance.close();
	  	           };
		        }]);*/


			});


	  }

	$scope.startVm = function(size, item) {
		  dialogService.openDialog("app/views/cloud/instance/start.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
			  $scope.item =item;
			  $scope.vmStart = function(item) {
					var event = "VM.START";
					var hasVm = crudService.vmUpdate("virtualmachine/event", item.uuid, event);
					hasVm.then(function(result) {
						$state.reload();
						 $scope.cancel();
					});
				},
			  $scope.cancel = function () {
                  $modalInstance.close();
              };
          }]);
    };
    $scope.stopVm = function(size,item) {
    	 dialogService.openDialog("app/views/cloud/instance/stop.jsp", size, $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance, $rootScope) {
    		 $scope.item =item;
    		 $scope.vmStop = function(item) {
    				var event = "VM.STOP";
    				var hasVm = crudService.vmUpdate("virtualmachine/event", item.uuid, event);
    				hasVm.then(function(result) {
    					$state.reload();
    					 $scope.cancel();
    				});
    			},
			  $scope.cancel = function () {
                 $modalInstance.close();
             };
         }]);
    };
    $scope.rebootVm = function(size,item) {
    	 dialogService.openDialog("app/views/cloud/instance/reboot.jsp", size,  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {
    		 $scope.item =item;
    		 $scope.vmRestart = function(item) {
    				var event = "VM.REBOOT";
    				var hasVm = crudService.vmUpdate("virtualmachine/event", item.uuid, event);
    				hasVm.then(function(result) {
    					$state.reload();
    					 $scope.cancel();
    				});
    			},
			  $scope.cancel = function () {
                 $modalInstance.close();
             };
         }]);
    };

	$scope.changeSorting = function(column) {

		var sort = $scope.sort;

		if (sort.column == column) {
			sort.descending = !sort.descending;
		} else {
			sort.column = column;
			sort.descending = false;
		}
		return sort.descending;
	};

	$scope.vm = {};

	$scope.list = function(pageNumber, status) {
	if(!angular.isUndefined(status)) {
	$scope.vm.status = status;
 	$window.sessionStorage.removeItem("status")
 	$window.sessionStorage.setItem("status",status);
	} else {
	$scope.vm.status=$window.sessionStorage.getItem("status");
        }
		$scope.showLoader = true;
		var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;

		var hasUsers =  promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "virtualmachine/listByStatus" +"?lang=" + localStorageService.cookie.get('language') + "&status="+$scope.vm.status+"&sortBy=+name&limit="+limit,  $scope.global.paginationHeaders(pageNumber, limit), {
			"limit" : limit
		})

		$scope.borderContent = status
		hasUsers.then(function(result) { // this is only run after $http
			// completes0

			$scope.instanceList = result;
			// For pagination

                $scope.instancesList.Count = 0;
           		 for (i = 0; i < result.length; i++) {
            		 if($scope.instanceList[i].status.indexOf("Expunging") > -1) {
            		 $scope.instancesList.Count++;
           		  }
           		 }

           		 // Get the count of the listings
           		var hasVmCount =  crudService.listAll("virtualmachine/vmCounts");
           		hasVmCount.then(function(result) {
           			$scope.runningVmCount = result.runningVmCount;
           			$scope.stoppedVmCount = result.stoppedVmCount;
           			$scope.totalCount = result.totalCount;
        		});
			$scope.paginationObject.limit = limit;
			$scope.paginationObject.currentPage = pageNumber;
			$scope.paginationObject.totalItems = result.totalItems;
			$scope.showLoader = false;
		});
	};

	$scope.list(1, "Expunging");


	$scope.openAddInstance = function(size) {

		var modalInstance = $modal.open({
			templateUrl : 'app/views/cloud/instance/add.jsp',
			controller : 'instanceCtrl',
			size : size,
			backdrop : 'static',
			windowClass : "hmodal-info",
			resolve : {
				items : function() {
					return $scope.items;
				}
			}
		});

		modalInstance.result.then(function(selectedItem) {
			$scope.selected = selectedItem;
		}, function() {
			$log.info('Modal dismissed at: ' + new Date());
		});

	};

	$scope.showDescription = function(instance) {
		var modalInstance = $modal.open({
			animation : $scope.animationsEnabled,
			templateUrl : 'app/views/cloud/instance/displaynote.jsp',
			controller : 'instanceDetailsCtrl',
			size : 'sm',
			backdrop : 'static',
			windowClass : "hmodal-info",
			resolve : {
				instance : function() {
					return angular.copy(instance);
				}
			}
		});

		modalInstance.result.then(function(selectedItem) {
			$scope.selected = selectedItem;

		}, function() {
			$log.info('Modal dismissed at: ' + new Date());
		});
	};

}
function instanceDetailsCtrl($scope, instance, notify, $modalInstance) {

	$scope.update = function(form) {

		$scope.formSubmitted = true;

		if (form.$valid) {
			$scope.homerTemplate = 'app/views/notification/notify.jsp';
			notify({
				message : 'Updated successfully',
				classes : 'alert-success',
				templateUrl : $scope.homerTemplate
			});
			$scope.cancel();
		}
	};
	$scope.instance = instance;
	$scope.cancel = function() {
		$modalInstance.dismiss('cancel');
	};
};
