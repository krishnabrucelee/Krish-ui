

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

    $scope.formElements = {
        instanceList: [
            {id: 1, name: 'North China'},
            {id: 2, name: 'South central china'}

        ]

     };
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


function snapshotListCtrl($scope, crudService, $timeout, promiseAjax, globalConfig,
localStorageService, $window, dialogService, notify) {
	$scope.snapshotList = {};
    $scope.list = function(pageNumber) {
	    var limit = (angular.isUndefined($scope.paginationObject.limit)) ? crudService.globalConfig.CONTENT_LIMIT : $scope.paginationObject.limit;
	    var hasVolumes = crudService.list("snapshots", crudService.globalConfig.paginationHeaders(pageNumber, limit), {"limit": limit});
	    hasVolumes.then(function (result) {
	        $scope.snapshotList = result;
	        $scope.paginationObject.limit  = limit;
	        $scope.paginationObject.currentPage = pageNumber;
	        $scope.paginationObject.totalItems = result.totalItems;
	        console.log($scope.paginationObject);
	    });
    },$scope.cancel = function () {
        $modalInstance.close();
    };
    $scope.list(1);


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

    $scope.paginationObject = {};
     $scope.openAddSnapshotContainer = function(size) {
    	 dialogService.openDialog("app/views/cloud/snapshot/create.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
    		 $scope.createSnapshot = false;
    		 	$scope.volumesList = {};
    		    $scope.listVolumes = function(pageNumber) {
    			    var limit = (angular.isUndefined($scope.paginationObject.limit)) ? crudService.globalConfig.CONTENT_LIMIT : $scope.paginationObject.limit;
    			    var hasVolumes = crudService.list("volumes", crudService.globalConfig.paginationHeaders(pageNumber, limit), {"limit": limit});
    			    hasVolumes.then(function (result) {
    			        $scope.volumesList = result;
    			        $scope.paginationObject.limit  = limit;
    			        $scope.paginationObject.currentPage = pageNumber;
    			        $scope.paginationObject.totalItems = result.totalItems;
    			    });
    		    };

    		    $scope.listVolumes(1);

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
                        	 $scope.listSnapshots(1);
                        	notify({message: 'Added successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                            $modalInstance.close();
                        }).catch(function (result) {
                        	if(!angular.isUndefined(result) && result.data != null) {
                        		if(result.data.globalError[0] != ''){
	                               	 var msg = result.data.globalError[0];
	                               	 notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                                }
	                            angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
	                            	$scope.confirmsnapshot[key].$invalid = true;
	                                $scope.confirmsnapshot[key].errorMessage = errorMessage;
	                            });
                        	}

                        });
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
//    		       	 	}]);
//    		        }, 500);

//    		    };

         }]);
        //modalService.trigger('app/views/cloud/snapshot/create.jsp', size);
    };

    $scope.openAddVMSnapshotContainer = function(size) {
        modalService.trigger('app/views/cloud/snapshot/createVm.jsp', size);
    };
    $scope.createVolume = function(size) {
        modalService.trigger('app/views/cloud/snapshot/create-volume.jsp', size);
    };

}
