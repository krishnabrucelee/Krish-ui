/**
 *
 * affinityGroupListCtrl
 *
 */

angular
        .module('homer')
        .controller('affinityGroupListCtrl', affinityGroupListCtrl)

function affinityGroupListCtrl($scope, appService, $state, localStorageService, globalConfig) {

	$scope.affinityGroupList = {};
	$scope.affinityGroupElement = {};
	$scope.affinityGroup = {};
    $scope.paginationObject = {};
    $scope.formElements = [];
    $scope.global = appService.globalConfig;
    $scope.sort = appService.globalConfig.sort;
    $scope.changeSorting = appService.utilService.changeSorting;
    $scope.userElement = {};
    $scope.paginationObject.sortOrder = '+';
    $scope.paginationObject.sortBy = 'name';

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
            var hasAffinityGroup = {};
//            if ($scope.domainView == null) {
//            	hasAffinityGroup =  appService.promiseAjax.httpTokenRequest(globalConfig.HTTP_GET, globalConfig.APP_URL +
//                		"affinityGroup" +"?lang=" + localStorageService.cookie.get('language') +"&sortBy="+sortOrder+sortBy+"&limit="+limit,
//                		$scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
//            } else {
//            	hasAffinityGroup =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "affinityGroup/listByDomain"
//    				+"?lang=" +appService.localStorageService.cookie.get('language')
//    				+ "&domainId="+$scope.domainView.id+"&sortBy="+$scope.paginationObject.sortOrder+$scope.paginationObject.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
//            }

            $scope.filter = "";
            if($scope.global.sessionValues.type === "ROOT_ADMIN") {
            if ($scope.domainView == null && $scope.affinityGroupSearch == null) {
            	hasAffinityGroup =  appService.promiseAjax.httpTokenRequest(globalConfig.HTTP_GET, globalConfig.APP_URL +
                		"affinityGroup" +"?lang=" + localStorageService.cookie.get('language') +"&sortBy="+sortOrder+sortBy+"&limit="+limit,
                		$scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
            } else {
                if ($scope.domainView != null && $scope.affinityGroupSearch == null) {
                    $scope.filter = "&domainId=" + $scope.domainView.id + "&searchText=";
                } else if ($scope.domainView == null && $scope.affinityGroupSearch != null) {
                    $scope.filter = "&domainId=0" + "&searchText=" + $scope.affinityGroupSearch;
                } else {
                    $scope.filter = "&domainId=" + $scope.domainView.id + "&searchText=" + $scope.affinityGroupSearch;
                }
                hasAffinityGroup =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "affinityGroup/listByDomain"
        				+"?lang=" +appService.localStorageService.cookie.get('language')
        				+ $scope.filter+"&sortBy="+$scope.paginationObject.sortOrder+$scope.paginationObject.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
            	}
            hasAffinityGroup.then(function(result) { // this is only run after $http
			// completes0
			$scope.affinityGroupList = result;
			$scope.affinityGroupList.Count = 0;
            if (result.length != 0) {
                $scope.affinityGroupList.Count = result.totalItems;
            }
			// For pagination
			$scope.paginationObject.limit = limit;
			$scope.paginationObject.currentPage = pageNumber;
			$scope.paginationObject.totalItems = result.totalItems;
			$scope.paginationObject.sortOrder = sortOrder;
			$scope.paginationObject.sortBy = sortBy;
			$scope.showLoader = false;
		});

    }

       if ($scope.global.sessionValues.type === 'USER' || $scope.global.sessionValues.type === 'DOMAIN_ADMIN') {
               if ($scope.global.sessionValues.domainId != null && $scope.affinityGroupSearch == null) {
                   $scope.filter = "&domainId=" + $scope.global.sessionValues.domainId + "&searchText=";
               } else if ($scope.global.sessionValues.domainId == null && $scope.affinityGroupSearch != null) {
                   $scope.filter = "&domainId=0" + "&searchText=" + $scope.affinityGroupSearch;
               } else {
                   $scope.filter = "&domainId=" + $scope.global.sessionValues.domainId + "&searchText=" + $scope.affinityGroupSearch;
               }
               hasAffinityGroup =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "affinityGroup/listByDomain"
       				+"?lang=" +appService.localStorageService.cookie.get('language')
       				+ $scope.filter+"&sortBy="+$scope.paginationObject.sortOrder+$scope.paginationObject.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});

           hasAffinityGroup.then(function(result) { // this is only run after $http
			// completes0
			$scope.affinityGroupList = result;
			$scope.affinityGroupList.Count = 0;
           if (result.length != 0) {
               $scope.affinityGroupList.Count = result.totalItems;
           }
			// For pagination
			$scope.paginationObject.limit = limit;
			$scope.paginationObject.currentPage = pageNumber;
			$scope.paginationObject.totalItems = result.totalItems;
			$scope.paginationObject.sortOrder = sortOrder;
			$scope.paginationObject.sortBy = sortBy;
			$scope.showLoader = false;
		});
       }
	};

	// Affinity group List
    $scope.list = function (pageNumber) {
        appService.globalConfig.sort.sortOrder = $scope.paginationObject.sortOrder;
        appService.globalConfig.sort.sortBy = $scope.paginationObject.sortBy;
        $scope.showLoader = true;
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasAffinityGroup = {};
        $scope.filter = "";
        if ($scope.global.sessionValues.type === "ROOT_ADMIN") {
        if ($scope.domainView == null && $scope.affinityGroupSearch == null) {
        	hasAffinityGroup = appService.crudService.list("affinityGroup", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
        } else {
            if ($scope.domainView != null && $scope.affinityGroupSearch == null) {
                $scope.filter = "&domainId=" + $scope.domainView.id + "&searchText=";
            } else if ($scope.domainView == null && $scope.affinityGroupSearch != null) {
                $scope.filter = "&domainId=0" + "&searchText=" + $scope.affinityGroupSearch;
            } else {
                $scope.filter = "&domainId=" + $scope.domainView.id + "&searchText=" + $scope.affinityGroupSearch;
            }
            hasAffinityGroup =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "affinityGroup/listByDomain"
    				+"?lang=" +appService.localStorageService.cookie.get('language')
    				+  encodeURI($scope.filter) +"&sortBy="+globalConfig.sort.sortOrder+globalConfig.sort.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
        	}
        	hasAffinityGroup.then(function (result) {
            $scope.affinityGroupList = result;
            $scope.affinityGroupList.Count = 0;
            if (result.length != 0) {
                $scope.affinityGroupList.Count = result.totalItems;
            }

            // For pagination
            $scope.paginationObject.limit = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
            $scope.showLoader = false;
        });
    }

        	 if ($scope.global.sessionValues.type === 'USER' || $scope.global.sessionValues.type === 'DOMAIN_ADMIN') {
                 if ($scope.global.sessionValues.domainId != null && $scope.affinityGroupSearch == null) {
                     $scope.filter = "&domainId=" + $scope.global.sessionValues.domainId + "&searchText=";
                 } else if ($scope.global.sessionValues.domainId == null && $scope.affinityGroupSearch != null) {
                     $scope.filter = "&domainId=0" + "&searchText=" + $scope.affinityGroupSearch;
                 } else {
                     $scope.filter = "&domainId=" + $scope.global.sessionValues.domainId + "&searchText=" + $scope.affinityGroupSearch;
                 }
                 hasAffinityGroup =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "affinityGroup/listByDomain"
         				+"?lang=" +appService.localStorageService.cookie.get('language')
         				+ $scope.filter+"&sortBy="+$scope.paginationObject.sortOrder+$scope.paginationObject.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});

             hasAffinityGroup.then(function(result) { // this is only run after $http
                 $scope.affinityGroupList = result;
                 $scope.affinityGroupList.Count = 0;
                 if (result.length != 0) {
                     $scope.affinityGroupList.Count = result.totalItems;
                 }

                 // For pagination
                 $scope.paginationObject.limit = limit;
                 $scope.paginationObject.currentPage = pageNumber;
                 $scope.paginationObject.totalItems = result.totalItems;
                 $scope.showLoader = false;
  		});
         }
    };
    $scope.list(1);

    // Load domain
    $scope.domain = {};
    var hasDomains = appService.crudService.listAll("domains/list");
    hasDomains.then(function (result) {
    	$scope.formElements.domainList = result;
    });

    //Load department list
    $scope.departmentList = {};
    $scope.getDepartmentList = function (domain) {
        var hasDepartments = appService.crudService.listAllByFilter("departments/search", domain);
        hasDepartments.then(function (result) {
            $scope.departmentList = result;
        });
    };

    if ($scope.global.sessionValues.type == "DOMAIN_ADMIN") {
        var domain = {};
        domain.id = $scope.global.sessionValues.domainId;
        $scope.getDepartmentList(domain);
    }

    if($scope.global.sessionValues.type === 'USER') {
		var hasUsers = appService.crudService.read("users", $scope.global.sessionValues.id);
        hasUsers.then(function (result) {
            if (!angular.isUndefined(result)) {
            	$scope.userElement = result;
            }
        });
	 }

    // Department list load based on the domain
    $scope.domainChange = function() {
        $scope.affinityGroupElement.departmentList = {};
        if (!angular.isUndefined($scope.affinityGroup.domain)) {
	        var hasDepartmentList = appService.crudService.listAllByFilter("departments/search", $scope.affinityGroup.domain);
	        hasDepartmentList.then(function (result) {
	    	    $scope.affinityGroupElement.departmentList = result;
	        });
        }
    };

    // Get volume list based on domain selection
    $scope.selectDomainView = function(pageNumber) {
    	$scope.list(1);
    };

 // Get affinity group list based on quick search
    $scope.affinityGroupSearch = null;
    $scope.searchList = function(affinityGroupSearch) {
        $scope.affinityGroupSearch = affinityGroupSearch;
        $scope.list(1);
    };

    // Load affinity group type
    $scope.affinityGroupType = {};
    var hasAffinityGroupType = appService.crudService.listAll("affinityGroupType/list");
    hasAffinityGroupType.then(function (result) {
    	$scope.formElements.affinityGroupTypeList = result;
    });

    $scope.createAffinityGroup = function (size) {
        appService.dialogService.openDialog($scope.global.VIEW_URL + "cloud/affinitygroup/add.jsp", size, $scope, ['$scope',
                  '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
        // Create a new affinity group
        $scope.save = function (affinityGroupForm, affinityGroup) {
     	   $scope.formSubmitted = true;
     		   if (affinityGroupForm.$valid) {
     			   $scope.showLoader = true;
     			    affinityGroup.affinityGroupTypeId = affinityGroup.affinityGroupType.id;
     			    affinityGroup.transAffinityGroupAccessFlag = "CRUD";
     			    if ($scope.global.sessionValues.type == "ROOT_ADMIN") {
     				  affinityGroup.domainId = affinityGroup.domain.id;
     				  affinityGroup.departmentId = affinityGroup.department.id;
     			    }
     			    if ($scope.global.sessionValues.type == "DOMAIN_ADMIN") {
     			    	affinityGroup.departmentId = affinityGroup.department.id;
      			    }
                    var hasServer = appService.crudService.add("affinityGroup", affinityGroup);
                    hasServer.then(function (result) {
                    	$scope.list(1);
                        $scope.showLoader = false;
                        $modalInstance.close();
                        appService.notify({message: 'Affinity group added successfully', classes: 'alert-success',
                        	templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                 	}).catch(function (result) {
                 		if(result.data.globalError[0] != ''){
                 			var msg = result.data.globalError[0];
                 			appService.notify({message: msg, classes: 'alert-danger',
                 				templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                 			$modalInstance.close();
                        }
                 	});
     		   }

     	},
     	$scope.cancel = function () {
             $modalInstance.close();
     	};
        }]);
     };

    // Delete the affinity group
    $scope.delete = function (size, affinityGroup) {
    	appService.dialogService.openDialog($scope.global.VIEW_URL + "cloud/affinitygroup/delete.jsp", size, $scope,
    			['$scope', '$modalInstance', function ($scope, $modalInstance) {
    		$scope.deleteObject = affinityGroup;
            $scope.ok = function (deleteObject) {
                $scope.showLoader = true;
                var hasServer = appService.crudService.delete("affinityGroup", affinityGroup.id);
                hasServer.then(function (result) {
                    $scope.list(1);
                    $scope.showLoader = false;
                    $modalInstance.close();
                    appService.notify({message: 'Affinity group deleted successfully', classes: 'alert-success',
                    	templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                }).catch(function (result) {
                	if(result.data.globalError[0] != ''){
                		var msg = result.data.globalError[0];
                        appService.notify({message: msg, classes: 'alert-danger',
                        	templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                    }
                	$scope.showLoader = false;
                	$modalInstance.close();
                });
            },
            $scope.cancel = function () {
            	$modalInstance.close();
            };
            }]);
    };

    // Get instance list by group
    $scope.getInstance = function (affinityGroup) {
    	$scope.formElements.instanceList = {};
  	    var hasInstanceList =  appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL
  	    		+ "virtualmachine/affinityGroupInstance/" + affinityGroup.id);
  	    hasInstanceList.then(function (result) {
  	    	if (result.length == 0) {
  	    		appService.notify({message: 'Instance not available for selected affinity group', classes: 'alert-success',
                	templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
  	    	} else {
  	    		$scope.formElements.instanceList = result;
  	    	}
  	    }).catch(function (result) {
        	if(result.data.globalError[0] != ''){
        		var msg = result.data.globalError[0];
                appService.notify({message: msg, classes: 'alert-danger',
                	templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
            }
        	$scope.showLoader = false;
        	$modalInstance.close();
        });
    };

    // Get instance list by group
    $scope.openInstance = function (instance) {
  	    var hasInstanceList =  appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL
  	    		+ "virtualmachine/affinityGroupInstance/" + affinityGroup.id);
  	    hasInstanceList.then(function (result) {
  	    	$scope.formElements.instanceList = result;
  	    });
    };


};
