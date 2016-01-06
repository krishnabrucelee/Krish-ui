/**
 *
 * sshkeyListCtrl
 *
 */

angular
        .module('homer')
        .controller('sshkeyListCtrl', sshkeyListCtrl)

function sshkeyListCtrl($scope, notify, dialogService, crudService) {
    $scope.sshkeyList = {};
    $scope.paginationObject = {};
    $scope.sshkeyForm = {};
    $scope.formElements = [];
    $scope.formElements.departmenttypeList = {};
    $scope.isRoot = false;
    $scope.global = crudService.globalConfig;
    // SSH Key List
    $scope.list = function (pageNumber) {
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasSSHKeys = crudService.list("sshkeys", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
        hasSSHKeys.then(function (result) {  // this is only run after $http completes0
            $scope.sshkeyList = result;
            // For pagination
            $scope.paginationObject.limit = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
        });
    };
    $scope.list(1);

    // Open dialogue box to create SSH Key
    $scope.sshkey = {};
    $scope.formElements = {};

    // Domain List
   $scope.listDomain = function () {
	var hasDomains = crudService.listAll("domains/list");
	hasDomains.then(function (result) {
	      $scope.formElements.domainList = result;

              if(result.length > 1){
		$scope.isRoot = true;
	      } else {
		$scope.isRoot = false;
	      }

	});
};
   $scope.listDomain();

   $scope.departmentList = function (domain) {
              var hasUsers = crudService.listAllByFilter("departments/search", domain);
              hasUsers.then(function (result) {  // this is only run after $http completes0
                       $scope.formElements.departmenttypeList  = result;
               });
           };
           $scope.$watch('sshkey.domain', function (obj) {
        	   if (!angular.isUndefined(obj)) {
        		   $scope.departmentList(obj);
        	   }
           });

	$scope.sshkey.domain = {};
    $scope.createSSHKey = function (size) {
        dialogService.openDialog($scope.global.VIEW_URL + "cloud/sshkeys/add.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
                // Create a new sshkey
                $scope.save = function (form) {
                    $scope.formSubmitted = true;
                    if (form.$valid) {
                        var sshkey = $scope.sshkey;
                        var hasServer = crudService.add("sshkeys", sshkey);
                        hasServer.then(function (result) {  // this is only run after $http completes
 			    $scope.sshkeyss = $scope.sshkeyList[$scope.sshkeyList.length-1];
			    $scope.sshkeyss = result;
			    $scope.sshkeyList[$scope.sshkeyList.length-1] = $scope.sshkeyss;
			    $scope.sshkey.privateKey = result.privatekey;
			$scope.list = function (pageNumber) {
        		var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        		var hasSSHKeys = crudService.list("sshkeys", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
        		hasSSHKeys.then(function (result) {  // this is only run after $http completes0
            		$scope.sshkeyList = result;
			var sshkeyss = $scope.sshkeyList[$scope.sshkeyList.length-1];
		        $scope.sshkeyList[$scope.sshkeyList.length-1] = $scope.sshkeyss;
            		// For pagination
            		$scope.paginationObject.limit = limit;
            		$scope.paginationObject.currentPage = pageNumber;
            		$scope.paginationObject.totalItems = result.totalItems;
       			 });
    			};
    			$scope.list(1);
                            notify({message: 'Added successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                            $modalInstance.close();
                            $scope.sshkey.name = "";
                            $scope.sshkey.publicKey = "";
				$scope.sshkey.privateKey = result.privatekey;
                            $scope.sshkey.domain = {};
                        }).catch(function (result) {
                            if(result.data.globalError[0] != ''){
                           	 var msg = result.data.globalError[0];
                           	 notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                                }
                        });
                    }
                },
                 $scope.cancel = function () {
                     $modalInstance.close();
                 };
            }]);
    };

    // Delete the SSH key
    $scope.delete = function (size, sshkey) {
        dialogService.openDialog($scope.global.VIEW_URL + "cloud/sshkeys/delete.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
        	$scope.deleteId = sshkey.id;
                $scope.ok = function (deleteObject) {
                    var hasServer = crudService.softDelete("sshkeys", sshkey);
                    hasServer.then(function (result) {
                        $scope.list(1);
                        notify({message: 'Deleted successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                    }).catch(function (result) {
                            if(result.data.globalError[0] != ''){
                           	 var msg = result.data.globalError[0];
                           	 notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                                }
                });
		$scope.cancel();
              },
                 $scope.cancel = function () {
                     $modalInstance.close();
                 };
            }]);
    };

};
