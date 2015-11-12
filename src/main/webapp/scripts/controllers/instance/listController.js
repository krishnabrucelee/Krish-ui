/**
 *
 * instanceListCtrl
 *
 */

angular.module('homer').controller('instanceListCtrl', instanceListCtrl)
		.controller('instanceDetailsCtrl', instanceDetailsCtrl)

function instanceListCtrl($scope, $log, $filter, dialogService, promiseAjax, $state,
		globalConfig, crudService,$modal, localStorageService, $window, notify) {
	$scope.instanceList = [];
	$scope.instancesList = [];
    $scope.global = crudService.globalConfig;

	$scope.paginationObject = {};
	$scope.sort = {
		column : '',
		descending : false
	};



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

	$scope.instanceId = function(pageNumber) {
		var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
		var hasUsers = crudService.list("virtualmachine/list", $scope.global
				.paginationHeaders(pageNumber, limit), {
			"limit" : limit
		});
		hasUsers.then(function(result) { // this is only run after $http
			// completes0
			$scope.instanceList = result;
			// For pagination

                        $scope.instancesList.Count = 0;
           		 for (i = 0; i < result.length; i++) {
            		 if($scope.instanceList[i].status.indexOf("Running") > -1) {
            		 $scope.instancesList.Count++;
           		  }
           		 }
			$scope.paginationObject.limit = limit;
			$scope.paginationObject.currentPage = pageNumber;
			$scope.paginationObject.totalItems = result.totalItems;
		});
	};

	$scope.instanceId(1);


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
