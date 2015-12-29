/**
 * Department crud operations done in this controller.
 */

angular
        .module('homer')
        .controller('departmentCtrl', departmentCtrl)

function departmentCtrl($scope, $sce, appService) {
    $scope.departmentList = {};
    $scope.paginationObject = {};
    $scope.departmentForm = {};
    $scope.global = appService.globalConfig;



    // Department List
    $scope.list = function (pageNumber) {
    	$scope.showLoader = true;
    	$scope.department = {}
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasDepartments = appService.crudService.list("departments", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
        hasDepartments.then(function (result) {  // this is only run after $http completes0

            $scope.departmentList = result;

            // For pagination
            $scope.paginationObject.limit  = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
            $scope.showLoader = false;
        });
    };
    $scope.list(1);




    // Open dialogue box to create department
    $scope.department = {};
    $scope.formElements = {};

    // Domain List
	var hasDomains = appService.crudService.listAll("domains/list");
	hasDomains.then(function (result) {  // this is only run after $http completes0
	      $scope.formElements.domainList = result;
	});

	// Add New department
    $scope.createDepartment = function (size) {
        appService.dialogService.openDialog("app/views/department/add.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
                // Create a new department
                $scope.save = function (form) {
                    $scope.formSubmitted = true;
                    if (form.$valid) {
                    	$scope.showLoader = true;
                        var department = angular.copy($scope.department);
                        if(!angular.isUndefined($scope.department.domain)) {
                        	department.domainId = department.domain.id;
                        	delete department.domain;
                        }
                        var hasServer = appService.crudService.add("departments", department);
                        hasServer.then(function (result) {  // this is only run after $http completes
                        	//$rootScope.department={};
                        	$scope.formSubmitted = false;
                            $modalInstance.close();
                            $scope.showLoader = false;
                            appService.notify({message: 'Department added successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                            $scope.list(1);
                        }).catch(function (result) {
                        	if(!angular.isUndefined(result) && result.data != null) {
                        	$scope.showLoader = false;
                        	if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                               	    var msg = result.data.globalError[0];
                             	    appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                                 } else {
                                	 angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                                		 $scope.departmentForm[key].$invalid = true;
                                		 $scope.departmentForm[key].errorMessage = errorMessage;
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

    // Edit the department
    $scope.edit = function (size, department) {
        appService.dialogService.openDialog("app/views/department/edit.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
                // Update department
                $scope.department = angular.copy(department);
                $scope.update = function (form) {
                    $scope.formSubmitted = true;
                    if (form.$valid) {
                    	$scope.showLoader = true;
                        var department = $scope.department;

                        department.domainId = department.domain.id;
                    	delete department.domain;
                        var hasServer = appService.crudService.update("departments", department);
                        hasServer.then(function (result) {
                            $scope.list(1);
                            $scope.showLoader = false;
                            appService.notify({message: 'Department updated successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                            $modalInstance.close();
                        }).catch(function (result) {
                        	if(!angular.isUndefined(result) && result.data != null) {
                        	$scope.showLoader = false;
                        	if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                               	    var msg = result.data.globalError[0];
                             	    appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                                 } else {
                                	 angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
     	                            	$scope.departmentForm[key].$invalid = true;
     	                                $scope.departmentForm[key].errorMessage = errorMessage;
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


    // Delete the department
 // Delete the department
    $scope.delete = function (size, department) {
        appService.dialogService.openDialog("app/views/department/confirm-delete.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
                $scope.deleteObject = department;
                $scope.ok = function (deleteObject) {
                	var domainObject =  deleteObject.domain;
                	deleteObject.domainId = deleteObject.domain.id;
                	delete deleteObject.domain;
                    var hasServer = appService.crudService.softDelete("departments", deleteObject);
                    hasServer.then(function (result) {
                        $scope.list(1);
                        appService.notify({message: 'Department deleted successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                    }).catch(function (result) {

                  	 if(!angular.isUndefined(result) && result.data != null) {
                  		deleteObject.domain = domainObject;
	      		 		   if(result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])){
	                      	 var msg = result.data.globalError[0];
	                      	 appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
	                       }
	                       angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
	                      	$scope.departmentForm[key].$invalid = true;
	                       	$scope.departmentForm[key].errorMessage = errorMessage;
	                       });
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
