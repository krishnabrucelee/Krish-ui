

angular
    .module('homer')
    .controller('addVMSnapshotCtrl', addVMSnapshotCtrl)
    .controller('addSnapshotCtrl', addSnapshotCtrl)
    .controller('addConfirmSnapshotCtrl', addConfirmSnapshotCtrl)
    .controller('snapshotListCtrl', snapshotListCtrl)

    function addConfirmSnapshotCtrl($scope, globalConfig, $window, notify) {

    $scope.global = globalConfig;

    // Form Field Decleration
    $scope.confirmsnapshot = {

    };
    $scope.formSubmitted = false;

}
    function addSnapshotCtrl($scope, crudService, dialogService, globalConfig, $window, notify) {

    $scope.global = globalConfig;

    // Form Field Decleration
    $scope.snapshot = {

    };
    $scope.formSubmitted = false}

function addVMSnapshotCtrl($scope, globalConfig, $window, notify) {

    $scope.global = globalConfig;

    // Form Field Decleration
    $scope.vmsnapshot = {

    };
    $scope.formSubmitted = false;

   /* $scope.formElements = {
        instanceList: [
            {id: 1, name: 'North China'},
            {id: 2, name: 'South central china'}

        ]

     };*/
    $scope.validateVMSnapshot = function(form) {
        $scope.formSubmitted = true;
        if (form.$valid) {
            $scope.cancel();
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            notify({message: 'VM Snapshot created', classes: 'alert-success', templateUrl: $scope.homerTemplate});

        }
    };
    $scope.validateCreateVolume = function(form) {
        $scope.formSubmitted = true;
        if (form.$valid) {
            $scope.cancel();
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            notify({message: 'Created successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});

        }
    };
    $scope.validateDeleteSnapshot = function(form) {
        $scope.formSubmitted = true;
        if (form.$valid) {
            $scope.cancel();
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            notify({message: 'Deleted successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});

        }
    };

};
function snapshotListCtrl($scope, crudService,$state, $timeout, promiseAjax, globalConfig,
localStorageService, $window, dialogService, notify) {
	$scope.confirmsnapshot = {};
	$scope.global = globalConfig;
	$scope.global = crudService.globalConfig;
	$scope.snapshotList = {};
	$scope.vmSnapshotList = {};
	$scope.instanceList = {};
    $scope.list = function(pageNumber) {
    	$scope.showLoader = true;
	    var limit = (angular.isUndefined($scope.paginationObject.limit)) ? crudService.globalConfig.CONTENT_LIMIT : $scope.paginationObject.limit;
	    var hasVolumes = crudService.list("snapshots", crudService.globalConfig.paginationHeaders(pageNumber, limit), {"limit": limit});
	    hasVolumes.then(function (result) {
	    	$scope.showLoader = false;
	        $scope.snapshotList = result;
	        $scope.paginationObject.limit  = limit;
	        $scope.paginationObject.currentPage = pageNumber;
	        $scope.paginationObject.totalItems = result.totalItems;

	    });
    }
    $scope.list(1);

	$scope.vmSnapshot = function(pageNumber){
		  var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
	        var hasSnapshots = crudService.list("vmsnapshot", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
	        hasSnapshots.then(function (result) {  // this is only run after
													// $http completes0
	            $scope.vmSnapshotList = result;
	            // For pagination
	            $scope.paginationObject.limit  = limit;
	            $scope.paginationObject.currentPage = pageNumber;
	            $scope.paginationObject.totalItems = result.totalItems;
	        });
		};
		$scope.vmSnapshot(1);
		$scope.instanceList = {};


    $scope.instanceId = function(pageNumber) {
		var hasUsers = crudService.listAll("virtualmachine/list");
		hasUsers.then(function(result) { // this is only run after $http
			// completes0
			$scope.instanceList = result;

		});
	};
	$scope.openAddVMSnapshotContainer = function() {
	  	 dialogService.openDialog("app/views/cloud/snapshot/createVm.jsp", 'md',  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance, $rootScope) {
	  		$scope.instanceId(1);
	  		 $scope.validateVMSnapshot= function(form) {
		  			$scope.formSubmitted = true;
                   if (form.$valid) {
                   	$scope.vmsnapshot.domainId = $scope.vmsnapshot.vm.domainId;
                   	$scope.vmsnapshot.vmId = $scope.vmsnapshot.vm.id;
		  				var hasVm = crudService.add("vmsnapshot",$scope.vmsnapshot);
		  				hasVm.then(function(result) {
		  					$state.reload();
		  					 $scope.cancel();
		  				}).catch(function (result) {
		  				  $scope.homerTemplate = 'app/views/notification/notify.jsp';
		                     notify({message: result.data.globalError[0], classes: 'alert-danger', "timeOut": "5000", templateUrl: $scope.homerTemplate});

                       });
                   }
	  			},
				  $scope.cancel = function () {
	               $modalInstance.close();
	           };
	       }]);
	  };

// $scope.openAddVMSnapshotContainer = function(vm) {
// dialogService.openDialog("app/views/cloud/snapshot/createVm.jsp", 'md',
// $scope, ['$scope', '$modalInstance','$rootScope', function ($scope,
// $modalInstance , $rootScope) {
// $scope.vm = vm;
// $scope.instanceId(1);
// $scope.validateVMSnapshot= function(form) {
// var hasVm = crudService.add("vmsnapshot", $scope.vm);
// hasVm.then(function(result) {
// $state.reload();
// $scope.cancel();
// });
//
// },
// $scope.cancel = function () {
// $modalInstance.close();
// };
// }]);
// };
    $scope.createVolume = function(size) {
        modalService.trigger('app/views/cloud/snapshot/create-volume.jsp', size);
    };
    $scope.deleteSnapshots = function(size, snapshot) {
    	 dialogService.openDialog("app/views/snapshot/delete-snapshot.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
             $scope.deleteObject = snapshot;
             $scope.ok = function () {
            	 var event = "VMSNAPSHOT.DELETE";
				 var hasServer = crudService.vmUpdate("vmsnapshot/event", snapshot.uuid, event);
                 hasServer.then(function (result) {
                	 $scope.cancel();
                	 $scope.list(1);
                     notify({message: 'Deleting '+snapshot.name, classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});

                 }).catch(function (result) {

			         if(result.data.globalError[0] != null){
			        	 var msg = result.data.globalError[0];
			        	 notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
			         }
                  });
             },
             $scope.cancel = function () {
                 $modalInstance.close();
             };
         }]);
    };

    $scope.deleteSnapshot = function(size, snapshot) {
   	 dialogService.openDialog("app/views/common/confirm-delete.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
            $scope.deleteObject = snapshot;
            $scope.ok = function (deleteObject) {
                var hasServer = crudService.softDelete("snapshots", deleteObject);
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
    $scope.restoresnapshot = function(vmsnapshot) {
   	 dialogService.openDialog("app/views/cloud/snapshot/revert-vmsnapshot.jsp", 'sm',  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {

   	     $scope.ok = function () {
   	    	    var event = "VMSNAPSHOT.REVERTTO";
				var hasVm = crudService.vmUpdate("vmsnapshot/event", vmsnapshot.uuid, event);
				hasVm.then(function(result) {
				  $state.reload();
				  $scope.cancel();
				  notify({message: 'Reverting snapshot in VM '+vmsnapshot.vm.name, classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
				}).catch(function (result) {

			         if(result.data.globalError[0] != null){
			        	 var msg = result.data.globalError[0];
			        	 notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
			         }
                   });
   	     },
   	  $scope.cancel = function () {
             $modalInstance.close();
         };
   	 }]);
   };
     $scope.openAddSnapshotContainer = function() {
    	 dialogService.openDialog("app/views/cloud/snapshot/create.jsp", "md", $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
    		 $scope.createSnapshot = false;
    		 	$scope.volumesList = {};
    		    $scope.listVolumes = function() {
    		    	$scope.showLoader = true;
    			    var hasVolumes = crudService.listAll("volumes/list");
    			    hasVolumes.then(function (result) {
    			    	$scope.showLoader = false;
    			        $scope.volumesList = result;
    			    });
    		    };

    		    $scope.listVolumes();
    		    $scope.updatePageStatus=function(size, volume){
    		    	$scope.createSnapshot=true;
    		    	$scope.volume = volume;
    		    	$scope.snapshot = {};
    		    };
    		    // Close the create snapshot page
    		    $scope.closeCreateSnapshot = function() {
    		    	$scope.createSnapshot=false;
    		    };
    		    // Creating snapshot
       	 		$scope.validateConfirmSnapshot = function(form) {
	       	 		$scope.formSubmitted = true;
	       	        if (form.$valid) {
		       	 		var snapshot = $scope.snapshot;
    		       	 	snapshot.volume = $scope.volume;
    		       	 	snapshot.zone = crudService.globalConfig.zone ;
		       	 		var hasServer = crudService.add("snapshots", snapshot);
                        hasServer.then(function (result) {
                        	 $scope.list(1);
                        	notify({message: 'Added successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                            $modalInstance.close();
                        }).catch(function (result) {
                        	if(!angular.isUndefined(result) && result.data != null) {
                        		if(result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])){
	                               	 var msg = result.data.globalError[0];
	                               	 notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                                }
	                            angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
	                            	form[key].$invalid = true;
	                            	form[key].errorMessage = errorMessage;
	                            });
                        	}
                        });

                    	$scope.cancel = function () {
     		               $modalInstance.close();
     		           };
	       	        }
       	 		};

       	 		// Close the dialog box
	       	 	$scope.cancel = function () {
			    	if($scope.createSnapshot) {
			    		// Overriding the cancel method for create page
			    		$scope.closeCreateSnapshot();
			    	} else {
			    		$modalInstance.close();
			    	}
	            };
         }]);
    };

    $scope.createVolume = function(size) {
        modalService.trigger('app/views/cloud/snapshot/create-volume.jsp', size);
    };
}
