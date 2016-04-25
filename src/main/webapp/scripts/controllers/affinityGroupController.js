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
            if ($scope.domainView == null) {
            	hasAffinityGroup =  appService.promiseAjax.httpTokenRequest(globalConfig.HTTP_GET, globalConfig.APP_URL +
                		"affinityGroup" +"?lang=" + localStorageService.cookie.get('language') +"&sortBy="+sortOrder+sortBy+"&limit="+limit,
                		$scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
            } else {
            	hasAffinityGroup =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "affinityGroup/listByDomain"
    				+"?lang=" +appService.localStorageService.cookie.get('language')
    				+ "&domainId="+$scope.domainView.id+"&sortBy="+$scope.paginationObject.sortOrder+$scope.paginationObject.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
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
	};

	// Affinity group List
    $scope.list = function (pageNumber) {
        appService.globalConfig.sort.sortOrder = $scope.paginationObject.sortOrder;
        appService.globalConfig.sort.sortBy = $scope.paginationObject.sortBy;
        $scope.showLoader = true;
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasAffinityGroup = {};
        if ($scope.domainView == null) {
        	hasAffinityGroup = appService.crudService.list("affinityGroup", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
        } else {
        	hasAffinityGroup =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "affinityGroup/listByDomain"
				+"?lang=" +appService.localStorageService.cookie.get('language')
				+ "&domainId="+$scope.domainView.id+"&sortBy="+globalConfig.sort.sortOrder+globalConfig.sort.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
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
    };
    $scope.list(1);

    // Load domain
    $scope.domain = {};
    var hasDomains = appService.crudService.listAll("domains/list");
    hasDomains.then(function (result) {
    	$scope.formElements.domainList = result;
    });

    // Get volume list based on domain selection
    $scope.selectDomainView = function(pageNumber) {
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
  	    	$scope.formElements.instanceList = result;
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
