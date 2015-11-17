

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




    $scope.validateConfirmSnapshot = function(form) {
        $scope.formSubmitted = true;
        if (form.$valid) {
            $scope.cancel();
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            notify({message: 'Snapshot created', classes: 'alert-success', templateUrl: $scope.homerTemplate});
            //$window.location.href = '#/volume/list'
        }
    };

}
    function addSnapshotCtrl($scope,$modal,modalService, globalConfig, $window, notify) {

    $scope.global = globalConfig;

    // Form Field Decleration
    $scope.snapshot = {

    };
    $scope.formSubmitted = false;


     $scope.downloadLink=function(size){
        $scope.cancel();
        setTimeout(function () {
            modalService.trigger('app/views/cloud/snapshot/download-snapshot.jsp', size);
        }, 500);

    };



}

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


function snapshotListCtrl($scope, $modal, $log, $timeout, promiseAjax, dialogService, globalConfig,crudService,$window, modalService, notify) {
	$scope.global = globalConfig;
	$scope.global = crudService.globalConfig;
	$scope.vmSnapshotList = {};
	$scope.vmSnapshot = function(pageNumber){
		  var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
	        var hasSnapshots = crudService.list("vmsnapshot", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
	        hasSnapshots.then(function (result) {  // this is only run after $http completes0
	            $scope.vmSnapshotList = result;
	            // For pagination
	            $scope.paginationObject.limit  = limit;
	            $scope.paginationObject.currentPage = pageNumber;
	            $scope.paginationObject.totalItems = result.totalItems;
	        });
		};
		$scope.vmSnapshot(1);
		$scope.instanceList = {};
     $scope.openAddSnapshotContainer = function(size) {
        modalService.trigger('app/views/cloud/snapshot/create.jsp', size);
    };
    $scope.instanceId = function(pageNumber) {
		var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
		var hasUsers = crudService.listAll("virtualmachine/list");
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



    $scope.openAddVMSnapshotContainer = function(vm) {
    	 dialogService.openDialog("app/views/cloud/snapshot/createVm.jsp", 'md',  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {
    		 $scope.vm = vm;
    		 $scope.instanceId(1);
	  		 $scope.validateVMSnapshot= function(form) {
		  				var hasVm = crudService.add("vmsnapshot", $scope.vm);
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
    $scope.createVolume = function(size) {
        modalService.trigger('app/views/cloud/snapshot/create-volume.jsp', size);
    };
    $scope.deleteSnapshot = function(size) {
        modalService.trigger('app/views/cloud/snapshot/delete-snapshot.jsp', size);
    };

    // Revert the VM Snapshot
    $scope.restoresnapshot = function (size, vmsnapshot) {
        dialogService.openDialog("app/views/cloud/snapshot/revert-vmsnapshot.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {

            }]);
    };

    // Delete the VM Snapshot
    $scope.delete = function (size, vmsnapshot) {
        dialogService.openDialog("app/views/common/confirm-delete.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
//                $scope.deleteObject = department;
//                $scope.ok = function (deleteObject) {
//                    var hasServer = crudService.softDelete("departments", deleteObject);
//                    hasServer.then(function (result) {
//                        $scope.list(1);
//                        notify({message: 'Deleted successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
//                    });
//                    $modalInstance.close();
//                },
//                        $scope.cancel = function () {
//                            $modalInstance.close();
//                        };
            }]);
    };










}

