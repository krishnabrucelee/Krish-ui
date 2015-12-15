/**
 *
 * applicationListCtrl
 *
 */

angular
        .module('homer')
        .controller('applicationListCtrl', applicationListCtrl)

function applicationListCtrl($scope, notify, dialogService, crudService) {
    $scope.applicationList = {};
    $scope.paginationObject = {};
    $scope.applicationForm = {};
    $scope.global = crudService.globalConfig;

    // Application List
    $scope.list = function (pageNumber) {
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasApplications = crudService.list("applications", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
        hasApplications.then(function (result) {  // this is only run after $http completes0
            $scope.applicationList = result;

            // For pagination
            $scope.paginationObject.limit = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
        });
    };
    $scope.list(1);

    // Open dialogue box to create application
    $scope.application = {};
    $scope.formElements = {};

    // Domain List
	var hasDomains = crudService.listAll("domains/list");
	hasDomains.then(function (result) {  // this is only run after $http completes0
	      $scope.formElements.domainList = result;
	      console.log(result);
	});

	$scope.application.domain = "";
    $scope.createApplication = function (size) {
        dialogService.openDialog($scope.global.VIEW_URL + "application/add.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
                // Create a new application
                $scope.save = function (form) {
                    $scope.formSubmitted = true;
                    if (form.$valid) {
                        var application = $scope.application;
                        var hasServer = crudService.add("applications", application);
                        hasServer.then(function (result) {  // this is only run after $http completes
                            $scope.list(1);
                            notify({message: 'Added successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                            $modalInstance.close();
                            $scope.application.type = "";
                            $scope.application.description = "";
                            $scope.application.status = "";
                            $scope.application.domain = "";
                        }).catch(function (result) {
            		    if (!angular.isUndefined(result.data)) {
                		if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                  	   	 var msg = result.data.globalError[0];
                	    	notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                    	} else if (result.data.fieldErrors != null) {
                        	angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                            	$scope.applicationForm[key].$invalid = true;
                            	$scope.applicationForm[key].errorMessage = errorMessage;
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

    // Edit the application
    $scope.edit = function (size, application) {
        dialogService.openDialog($scope.global.VIEW_URL + "application/edit.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
                // Update application
                $scope.application = angular.copy(application);
                $scope.update = function (form) {
                    $scope.formSubmitted = true;
                    if (form.$valid) {
                        var application = $scope.application;
                        var hasServer = crudService.update("applications", application);
                        hasServer.then(function (result) {
                            $scope.list(1);
                            notify({message: 'Updated successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                            $modalInstance.close();
                        }).catch(function (result) {
            	if (!angular.isUndefined(result.data)) {
                	if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                  	    var msg = result.data.globalError[0];
                	    notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                    } else if (result.data.fieldErrors != null) {
                        angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                            $scope.applicationForm[key].$invalid = true;
                            $scope.applicationForm[key].errorMessage = errorMessage;
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


    // Delete the application
    $scope.delete = function (size, application) {
        dialogService.openDialog($scope.global.VIEW_URL + "application/delete.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
                $scope.deleteId = application.id;
                $scope.ok = function (id) {
                    application.isActive = false;
                    var hasServer = crudService.update("applications", application);
                    hasServer.then(function (result) {
                        $scope.list(1);
                        notify({message: 'Deleted successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                    }).catch(function (result) {
                    	if (!angular.isUndefined(result.data)) {
                        	if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                          	    var msg = result.data.globalError[0];
                        	    notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                            }
                        }
                    });
                    $modalInstance.close();
                },
                 $scope.cancel = function () {
                     $modalInstance.close();
                 };
            }]);
    };

    $scope.formElements = {
    		statusList: {
                "0":"ENABLED",
                "1":"DISABLED"
            }
    };
};

