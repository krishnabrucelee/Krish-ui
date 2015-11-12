/**
 * Department crud operations done in this controller.
 */

angular
        .module('homer')
        .controller('departmentCtrl', departmentCtrl)

function departmentCtrl($scope, notify, promiseAjax, dialogService, crudService) {
    $scope.departmentList = {};
    $scope.paginationObject = {};
    $scope.departmentForm = {};
    $scope.global = crudService.globalConfig;



    // Department List
    $scope.list = function (pageNumber) {
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasDepartments = crudService.list("departments", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
        hasDepartments.then(function (result) {  // this is only run after $http completes0

            $scope.departmentList = result;

            // For pagination
            $scope.paginationObject.limit  = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
        });
    };
    $scope.list(1);




    // Open dialogue box to create department
    $scope.department = {};
    $scope.formElements = {};

    // Domain List
	var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
	var hasDomains = crudService.list("domains", $scope.global.paginationHeaders(1, limit), {"limit": limit});
	hasDomains.then(function (result) {  // this is only run after $http completes0
	      $scope.formElements.domainList = result;
	      console.log(result);
	});

	// Add New department
    $scope.createDepartment = function (size) {
        dialogService.openDialog("app/views/department/add.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
                // Create a new department
                $scope.save = function (form) {
                    $scope.formSubmitted = true;
                    if (form.$valid) {

                        var department = angular.copy($scope.department);
                        department.domainId = department.domain.id;
                        //delete department["domain"]["id"];
                        var hasServer = crudService.add("departments", department);
                        hasServer.then(function (result) {  // this is only run after $http completes
                        	//$rootScope.department={};
                            $scope.list(1);
                            notify({message: 'Added successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                            $modalInstance.close();

                            $scope.department.userName = "";
                            $scope.department.description = "";
                            $scope.department.domain = "";
                            $scope.department.firstName = "";
                            $scope.department.lastName = "";
                            $scope.department.email = "";
                            $scope.department.password = "";
                            $scope.department.confirmPassword = "";
                        }).catch(function (result) {
                        	if(!angular.isUndefined(result) && result.data != null) {
	                            angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
	                            	$scope.departmentForm[key].$invalid = true;
	                                $scope.departmentForm[key].errorMessage = errorMessage;
	                            });
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
        dialogService.openDialog("app/views/department/edit.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
                // Update department
                $scope.department = angular.copy(department);
                $scope.update = function (form) {
                    $scope.formSubmitted = true;
                    if (form.$valid) {
                        var department = $scope.department;
                        department.domainId = department.domain.id;
                        var hasServer = crudService.update("departments", department);
                        hasServer.then(function (result) {
                        	$scope.department={};
                            $scope.list(1);
                            notify({message: 'Updated successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                            $modalInstance.close();
                        }).catch(function (result) {
                        	if(!angular.isUndefined(result) && result.data != null) {
	                            angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
	                            	$scope.departmentForm[key].$invalid = true;
	                                $scope.departmentForm[key].errorMessage = errorMessage;
	                            });
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
    $scope.delete = function (size, department) {
        dialogService.openDialog("app/views/common/confirm-delete.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
                $scope.deleteObject = department;
                $scope.ok = function (deleteObject) {
                    var hasServer = crudService.softDelete("departments", deleteObject);
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
};
