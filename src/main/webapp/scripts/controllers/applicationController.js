/**
 *
 * applicationListCtrl
 *
 */

angular
        .module('homer')
        .controller('applicationListCtrl', applicationListCtrl)

function applicationListCtrl($scope, appService, localStorageService, globalConfig) {

    $scope.$on(appService.globalConfig.webSocketEvents.applicationEvents.createApplication, function() {

  //   $scope.applicationList = appService.webSocket;
    });
   $scope.$on(appService.globalConfig.webSocketEvents.applicationEvents.deleteApplication, function() {

  //   $scope.applicationList = appService.webSocket;
    });
   $scope.$on(appService.globalConfig.webSocketEvents.applicationEvents.editApplication, function() {

  //   $scope.applicationList = appService.webSocket;
    });

    $scope.applicationList = {};
    $scope.paginationObject = {};
    $scope.applicationForm = {};
    $scope.global = appService.globalConfig;
    $scope.sort = appService.globalConfig.sort;
    $scope.changeSorting = appService.utilService.changeSorting;
    $scope.paginationObject.sortOrder = '+';
    $scope.paginationObject.sortBy = 'type';

    $scope.changeSort = function(sortBy, pageNumber) {
		var sort = appService.globalConfig.sort;
		if (sort.column == sortBy) {
			sort.descending = !sort.descending;
		} else {
			sort.column = sortBy;
			sort.descending = false;
		}
		var sortOrder = '-';
		if(!sort.descending){
			sortOrder = '+';
		}
		$scope.paginationObject.sortOrder = sortOrder;
		$scope.paginationObject.sortBy = sortBy;
		$scope.showLoader = true;
		var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
            	var hasApplicationsLists = {};
           	if ($scope.domainView == null && $scope.applicationSearch == null) {
            	    hasApplicationsLists = appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "applications" +"?lang=" + localStorageService.cookie.get('language') +"&sortBy="+sortOrder+sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
            	}  else {
                $scope.filter = "";
            	if ($scope.domainView != null && $scope.applicationSearch == null) {
                	$scope.filter = "&domainId=" + $scope.domainView.id + "&searchText=";
            	} else if ($scope.domainView == null && $scope.applicationSearch != null) {
                	$scope.filter = "&domainId=0" + "&searchText=" + $scope.applicationSearch;
            	} else {
                	$scope.filter = "&domainId=" + $scope.domainView.id + "&searchText=" + $scope.applicationSearch;
            	}
            hasApplicationsLists =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "applications/listByFilter"
				+"?lang=" +appService.localStorageService.cookie.get('language')+ encodeURI($scope.filter) +"&sortBy="+$scope.paginationObject.sortOrder +$scope.paginationObject.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
        }

            hasApplicationsLists.then(function(result) { // this is only run after $http
			// completes0
			$scope.applicationList = result;
			$scope.applicationList.Count = 0;
            if (result.length != 0) {
                $scope.applicationList.Count = result.totalItems;
            }
			// For pagination
			$scope.paginationObject.limit = limit;
			$scope.paginationObject.currentPage = pageNumber;
			$scope.paginationObject.totalItems = result.totalItems;
			$scope.paginationObject.sortOrder = sortOrder;
			$scope.paginationObject.sortBy = sortBy;
			$scope.showLoader = false;
		});
	};

    // Application List
    $scope.list = function (pageNumber) {
        appService.globalConfig.sort.sortOrder = $scope.paginationObject.sortOrder;
        appService.globalConfig.sort.sortBy = $scope.paginationObject.sortBy;
    	$scope.showLoader = true;
        $scope.application = {};
        $scope.filter = "";
    	var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasApplications = {};
	if ($scope.domainView == null && $scope.applicationSearch == null) {
		    hasApplications = appService.crudService.list("applications", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
	} else {
	    if ($scope.domainView != null && $scope.applicationSearch == null) {
		$scope.filter = "&domainId=" + $scope.domainView.id + "&searchText=";
            } else if ($scope.domainView == null && $scope.applicationSearch != null) {
	    	$scope.filter = "&domainId=0" + "&searchText=" + $scope.applicationSearch;
            } else {
		$scope.filter = "&domainId=" + $scope.domainView.id + "&searchText=" + $scope.applicationSearch;
	    }
	    hasApplications =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "applications/listByFilter"
					+"?lang=" +appService.localStorageService.cookie.get('language')+ $scope.filter+"&sortBy="+appService.globalConfig.sort.sortOrder+appService.globalConfig.sort.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
	}
        hasApplications.then(function (result) {  // this is only run after $http completes0
            $scope.applicationList = result;
            $scope.applicationList.Count = 0;
            if (result.length != 0) {
                $scope.applicationList.Count = result.totalItems;
            }

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

    // Get application list based on domain selection
    $scope.selectDomainView = function(pageNumber) {
    	$scope.list(1);
    };

    // Get instance list based on quick search
    $scope.applicationSearch = null;
    $scope.searchList = function(applicationSearch) {
        $scope.applicationSearch = applicationSearch;
        $scope.list(1);
    };

    // Get domain list
    var hasdomainListView = appService.crudService.listAll("domains/list");
    hasdomainListView.then(function (result) {
    	$scope.domainListView = result;
    });


    // Add the application
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
			    $scope.formSubmitted = false;
                            $modalInstance.close();
                            $scope.showLoader = false;
                            appService.notify({message: 'Application added successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                            $scope.list(1);
                        }).catch(function (result) {
                        	$scope.showLoader = false;
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
                	$scope.showLoader = true;
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
            		$scope.showLoader = false;
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

