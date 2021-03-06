/**
 * Department crud operations done in this controller.
 */

angular
        .module('homer')
        .controller('departmentCtrl', departmentCtrl)

function departmentCtrl($scope, $sce, appService, localStorageService, globalConfig) {

  $scope.$on(appService.globalConfig.webSocketEvents.departmentEvents.createDepartment, function() {

  //   $scope.departmentList = appService.webSocket;
    });
  $scope.$on(appService.globalConfig.webSocketEvents.departmentEvents.deleteDepartment, function() {

  //   $scope.departmentList = appService.webSocket;
    });
  $scope.$on(appService.globalConfig.webSocketEvents.departmentEvents.editDepartment, function() {

  //   $scope.departmentList = appService.webSocket;
    });

    $scope.departmentList = {};
    $scope.paginationObject = {};
    $scope.departmentForm = {};
    $scope.global = appService.globalConfig;
    $scope.sort = appService.globalConfig.sort;
    $scope.changeSorting = appService.utilService.changeSorting;
    $scope.paginationObject.sortOrder = '+';
    $scope.paginationObject.sortBy = 'userName';
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
            		var hasDepartmentLists = {};
			if ($scope.domainView == null && $scope.departmentSearch == null) {
            	    		hasDepartmentLists = appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "departments" +"?lang=" + localStorageService.cookie.get('language') +"&sortBy="+sortOrder+sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
            		}  else {
                	$scope.filter = "";
            		if ($scope.domainView != null && $scope.departmentSearch == null) {
                		$scope.filter = "&domainId=" + $scope.domainView.id + "&searchText=";
            		} else if ($scope.domainView == null && $scope.departmentSearch != null) {
                		$scope.filter = "&domainId=0" + "&searchText=" + $scope.departmentSearch;
            		} else {
                		$scope.filter = "&domainId=" + $scope.domainView.id + "&searchText=" + $scope.departmentSearch;
            		}
            		hasDepartmentLists =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "departments/listByDomain"
				+"?lang=" +appService.localStorageService.cookie.get('language')+ $scope.filter+"&sortBy="+$scope.paginationObject.sortOrder +$scope.paginationObject.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
        		}
			hasDepartmentLists.then(function(result) { // this is only run after $http
				// completes0
				$scope.departmentList = result;
				$scope.departmentList.Count = 0;
	            if (result.length != 0) {
	                $scope.departmentList.Count = result.totalItems;
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

    // Department List
    $scope.list = function (pageNumber) {
    appService.globalConfig.sort.sortOrder = $scope.paginationObject.sortOrder;
    appService.globalConfig.sort.sortBy = $scope.paginationObject.sortBy;
    	$scope.showLoader = true;
    	$scope.department = {};
        $scope.filter = "";
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasDepartments = {};
	if ($scope.domainView == null && $scope.departmentSearch== null) {
		    hasDepartments = appService.crudService.list("departments", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
	} else {
	    if ($scope.domainView != null && $scope.departmentSearch == null) {
		$scope.filter = "&domainId=" + $scope.domainView.id + "&searchText=";
            } else if ($scope.domainView == null && $scope.departmentSearch != null) {
	    	$scope.filter = "&domainId=0" + "&searchText=" + $scope.departmentSearch;
            } else {
		$scope.filter = "&domainId=" + $scope.domainView.id + "&searchText=" + $scope.departmentSearch;
	    }
	    hasDepartments =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "departments/listByDomain"
					+"?lang=" +appService.localStorageService.cookie.get('language')+ encodeURI($scope.filter)+"&sortBy="+appService.globalConfig.sort.sortOrder+appService.globalConfig.sort.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
	}
        hasDepartments.then(function (result) {  // this is only run after $http completes0
            $scope.departmentList = result;
            $scope.departmentList.Count = 0;
            if (result.length != 0) {
                $scope.departmentList.Count = result.totalItems;
            }

            // For pagination
            $scope.paginationObject.limit  = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
            $scope.showLoader = false;
        });
    };
    $scope.list(1);

    // Get department list based on domain selection
    $scope.selectDomainView = function(pageNumber) {
    	$scope.list(1);
    };

    // Get instance list based on quick search
    $scope.departmentSearch = null;
    $scope.searchList = function(departmentSearch) {
        $scope.departmentSearch = departmentSearch;
        $scope.list(1);
    };

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
        appService.dialogService.openDialog("app/views/department/edit.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
                // Update department
                $scope.department = angular.copy(department);
                $scope.update = function (form) {
                    $scope.formSubmitted = true;
                    if (form.$valid) {
                    	$scope.showLoader = true;
                        var department =angular.copy($scope.department);

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
	                      	 var errorMsgs = result.data.globalError[0];
	                      	 var errorList = errorMsgs.split("@@");
	                     	 appService.notify.closeAll();
	                      		var msg = "You have following resources for this department: <br><ul>" +
	                  	 		"<li>Project :"+ errorList[1] +"</li>" +
	                  	 		"<li>Instance :"+ errorList[2] + "</li>" +
	                  	 		"<li>Role :"+ errorList[3] + "</li>" +
	                  	 		"<li>Volume :"+ errorList[4] + "</li>" +
	                  	 		"<li>SSHkey :"+ errorList[5] + "</li>" +
	                  	 		"<li>Network :"+ errorList[6] + "</li>" +
	                  	 		"<li>User :"+ errorList[7] + "</li>" +
	                  	 		"</ul><br>Kindly delete associated resources and try again";
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
