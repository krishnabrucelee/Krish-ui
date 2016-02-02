/**
 *
 * sshkeyListCtrl
 *
 */

angular
        .module('homer')
        .controller('sshkeyListCtrl', sshkeyListCtrl)

function sshkeyListCtrl($scope,appService,$state) {
    $scope.sshkeyList = {};
    $scope.paginationObject = {};
    $scope.sshkeyForm = {};
    $scope.formElements = [];
    $scope.formElements.departmenttypeList = {};
    $scope.global = appService.globalConfig;
    $scope.sort = appService.globalConfig.sort;
    $scope.changeSorting = appService.utilService.changeSorting;
    // SSH Key List
    $scope.list = function (pageNumber) {
        $scope.showLoader = true;
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT :
        	$scope.paginationObject.limit;
        var hasSSHKeys = appService.crudService.list("sshkeys", $scope.global.paginationHeaders(pageNumber, limit),
            {"limit": limit});
        hasSSHKeys.then(function (result) {
            $scope.sshkeyList = result;
            // For pagination
            $scope.paginationObject.limit = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
            $scope.showLoader = false;
        });
    };
    $scope.list(1);

    // Open dialogue box to create SSH Key
    $scope.sshkey = {};
    $scope.formElements = {};

    // Domain List
    $scope.listDomain = function () {
	var hasDomains = appService.crudService.listAll("domains/list");
	hasDomains.then(function (result) {
	    $scope.formElements.domainList = result;
	});
   };
   $scope.listDomain();

   $scope.departmentList = function (domain) {
	   if (!angular.isUndefined(domain) && domain != "") {
		   var hasUsers = appService.crudService.listAllByFilter("departments/search", domain);
		   hasUsers.then(function (result) {
			   $scope.formElements.departmenttypeList  = result;
		   });
       }
   };

   $scope.$watch('sshkey.domain', function (obj) {
	   if (!angular.isUndefined(obj) && obj != "") {
		   $scope.departmentList(obj);
       }
   });

   $scope.createSSHKey = function (size) {
       appService.dialogService.openDialog($scope.global.VIEW_URL + "cloud/sshkeys/add.jsp", size, $scope, ['$scope',
                 '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
       // Create a new sshkey
       $scope.save = function (form,sshkey) {
    	   $scope.formSubmitted = true;
           if (form.$valid) {
        	   $scope.showLoader = true;
			   var domainObj = {};
			   var departmentObj = {};
               var sshkey = angular.copy($scope.sshkey);
               if (!angular.isUndefined($scope.sshkey.domain) && $scope.sshkey.domain != null) {
            	   sshkey.domainId = sshkey.domain.id;
				   domainObj = sshkey.domain;
                   delete sshkey.domain;
               }
               if (!angular.isUndefined($scope.sshkey.department) && $scope.sshkey.department != null) {
            	   sshkey.departmentId = sshkey.department.id;
				   departmentObj = sshkey.department;
                   delete sshkey.department;
               }
               $scope.sshkey.publicKey = sshkey.publicKey;
               var hasServer = appService.crudService.add("sshkeys", sshkey);
               hasServer.then(function (result) {
            	   $scope.sshkeyss = $scope.sshkeyList[$scope.sshkeyList.length];
			       $scope.sshkeyss = result;
			       if ($scope.global.sessionValues.type === 'USER') {
			           var departments = [];
			           var hasDepartments = appService.crudService.read("departments",
			        		   $scope.global.sessionValues.departmentId);
			           hasDepartments.then(function (result) {
			               $scope.sshkeyss.department = result;
			           });
                       var domains = [];
			           var hasDomains = appService.crudService.read("domains", $scope.global.sessionValues.domainId);
			           hasDomains.then(function (result) {
			               $scope.sshkeyss.domain = result;
			           });
			       }
			       $scope.sshkeyss.domain = domainObj;
				   $scope.sshkeyss.department = departmentObj;
			       $scope.sshkeyList[$scope.sshkeyList.length] = $scope.sshkeyss;
			       $scope.sshkey.privateKey = result.privatekey;
			       $scope.list = function (pageNumber) {
			           var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT :
			        	   $scope.paginationObject.limit;
			           var hasSSHKeys = appService.crudService.list("sshkeys",
			        		   $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
			               hasSSHKeys.then(function (result) {
			                   $scope.sshkeyList = result;
			                	   var sshkeyss = $scope.sshkeyList[$scope.sshkeyList.length];
			                	   $scope.sshkeyList[$scope.sshkeyList.length] = $scope.sshkeyss;
			                	   // For pagination
			                	   $scope.paginationObject.limit = limit;
			                	   $scope.paginationObject.currentPage = pageNumber;
			                	   $scope.paginationObject.totalItems = result.totalItems;
			                   });
			           };
			                $scope.formSubmitted = false;
			                $modalInstance.close();
			                $scope.showLoader = false;
			                appService.notify({message: 'SSH key created successfully', classes: 'alert-success',
			                	templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
			                $scope.list(1);
			                $scope.sshkey.name = "";
			                $scope.sshkey.publicKey = "";
			                $scope.sshkey.privateKey = result.privatekey;
			                $scope.sshkey.domain = "";
			                $scope.sshkey.department = "";
                        	}).catch(function (result) {
                        		if(result.data.globalError[0] != ''){
                        			var msg = result.data.globalError[0];
                        			appService.notify({message: msg, classes: 'alert-danger',
                        				templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                        			$modalInstance.close();
                        			$state.reload();
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
    	appService.dialogService.openDialog($scope.global.VIEW_URL + "cloud/sshkeys/delete.jsp", size, $scope,
    			['$scope', '$modalInstance', function ($scope, $modalInstance) {
    		$scope.deleteObject = sshkey;
            $scope.ok = function (deleteObject) {
            	var domainObject =  deleteObject.domain;
                if(!angular.isUndefined(deleteObject.domain) && deleteObject.domain != null) {
                	deleteObject.domainId = deleteObject.domain.id;
                    delete deleteObject.domain;
                }
                var departmentObject =  deleteObject.department;
                if(!angular.isUndefined(deleteObject.department) && deleteObject.department != null) {
                	deleteObject.departmentId = deleteObject.department.id;
                    delete deleteObject.department;
                }
                $scope.showLoader = true;
                sshkey.isActive = false;
                var hasServer = appService.crudService.softDelete("sshkeys", sshkey);
                hasServer.then(function (result) {
                    $scope.list(1);
                    $scope.showLoader = false;
                    appService.notify({message: 'SSH key deleted successfully', classes: 'alert-success',
                    	templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                }).catch(function (result) {
                	if(result.data.globalError[0] != ''){
                		var msg = result.data.globalError[0];
                        appService.notify({message: msg, classes: 'alert-danger',
                        	templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
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
