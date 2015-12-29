/**
 *
 * applicationListCtrl
 *
 */

angular
        .module('homer')
        .controller('applicationListCtrl', applicationListCtrl)

function applicationListCtrl($scope, appService) {
    $scope.applicationList = {};
    $scope.paginationObject = {};
    $scope.applicationForm = {};
    $scope.global = appService.globalConfig;

    // Application List
    $scope.list = function (pageNumber) {
    	$scope.showLoader = true;
    	var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasApplications = appService.crudService.list("applications", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
        hasApplications.then(function (result) {  // this is only run after $http completes0
            $scope.applicationList = result;

            // For pagination
            $scope.paginationObject.limit = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
            $scope.showLoader = false;
        });
    };
    $scope.list(1);

    // Open dialogue box to create application
    $scope.application = {};
    $scope.formElements = {};

    // Domain List
	var hasDomains = appService.crudService.listAll("domains/list");
	hasDomains.then(function (result) {  // this is only run after $http completes0
	      $scope.formElements.domainList = result;
	      console.log(result);
	});

	$scope.application.domain = "";
    $scope.createApplication = function (size) {
        appService.dialogService.openDialog($scope.global.VIEW_URL + "application/add.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
                // Create a new application
                $scope.save = function (form) {

                    $scope.formSubmitted = true;
                    if (form.$valid) {
                    	$scope.showLoader = true;
                        var application = angular.copy($scope.application);
                        if(!angular.isUndefined($scope.application.domain)) {
                        	application.domainId = application.domain.id;
                        	delete application.domain;
                        }
                        var hasServer = appService.crudService.add("applications", application);
                        hasServer.then(function (result) {  // this is only run after $http completes
                            $scope.list(1);
                        	$scope.showLoader = false;
                            appService.notify({message: 'Application added successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                            $modalInstance.close();
                            $scope.application.type = "";
                            $scope.application.description = "";
                            $scope.application.domain = "";
                        }).catch(function (result) {
            		    if (!angular.isUndefined(result.data)) {
                		if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                  	   	 var msg = result.data.globalError[0];
                  	   	 $scope.showLoader = false;
                	    	 appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                    	} else if (result.data.fieldErrors != null) {
                       	$scope.showLoader = false;
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
        appService.dialogService.openDialog($scope.global.VIEW_URL + "application/edit.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
                // Update application
                $scope.application = angular.copy(application);
                $scope.update = function (form) {
                    $scope.formSubmitted = true;
                    if (form.$valid) {
                    	$scope.showLoader = true;
                        var application = angular.copy($scope.application);
                        application.domainId = application.domain.id;
                    	delete application.domain;
                        var hasServer = appService.crudService.update("applications", application);
                        hasServer.then(function (result) {
                            $scope.list(1);
                            $scope.showLoader = false;
                            appService.notify({message: 'Application updated successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                            $modalInstance.close();
                        }).catch(function (result) {
            	if (!angular.isUndefined(result.data)) {
                	if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                  	    var msg = result.data.globalError[0];
                  	    $scope.showLoader = false;
                	    appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                    } else if (result.data.fieldErrors != null) {
                    $scope.showLoader = false;
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
    	appService.dialogService.openDialog($scope.global.VIEW_URL + "application/delete.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
                $scope.deleteObject = application;
                $scope.ok = function (deleteObject) {
                deleteObject.domainId = deleteObject.domain.id;
                	delete deleteObject.domain;
                	$scope.showLoader = true;
                    application.isActive = false;
                    var hasServer = appService.crudService.softDelete("applications", deleteObject);
                    hasServer.then(function (result) {
                        $scope.list(1);
                        $scope.showLoader = false;
                        appService.notify({message: 'Application deleted successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                    }).catch(function (result) {
                    	if (!angular.isUndefined(result.data)) {
                        	if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                          	    var msg = result.data.globalError[0];
                        	    appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
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

