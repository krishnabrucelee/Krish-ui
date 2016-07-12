/**
 *
 * servicesCtrl
 *
 */

angular.module('homer')

.controller('servicesCtrl', servicesCtrl)

function servicesCtrl($scope, promiseAjax, crudService, appService, globalConfig, localStorageService, $cookies, $window) {

$scope.sort = appService.globalConfig.sort;
$scope.changeSorting = appService.utilService.changeSorting;

$scope.activitytab = {};

//$scope.activitytab = {
//        category: "service",
//    };
//appService.localStorageService.set('serviceView', 'service');

$scope.activitytab = appService.localStorageService.get('serviceView');

if($scope.activitytab == undefined || $scope.activitytab == null ){
	$scope.activitytab = "service";
}else {
	$scope.activitytab = appService.localStorageService.get('serviceView');
}

$scope.getservice = function(service) {
	  appService.localStorageService.set('serviceView', 'service');
	  $scope.activitytab = appService.localStorageService.get('serviceView');
};

$scope.getmyservice = function(myservice) {
	appService.localStorageService.set('serviceView', 'myservice');
	$scope.activitytab = appService.localStorageService.get('serviceView');
};

$scope.default_option = true
$scope.servicesList = {};
$scope.revokes = false;
$scope.paginationObject = {};
$scope.formElements = {};
$scope.global = crudService.globalConfig;
$scope.paginationObject.sortOrder = '+';
$scope.paginationObject.sortBy = 'serviceCode';

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
    var hasServicesList = {};
    $scope.filter = "";
    if ($scope.quickSearchText == null) {
    	hasServicesList = appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "services" +"?lang=" + localStorageService.cookie.get('language') +"&sortBy="+sortOrder+sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
    } else {
        $scope.filter = "&searchText=" + $scope.quickSearchText;
        hasServicesList = promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "services/listByFilter"
        		+ "?lang=" + appService.localStorageService.cookie.get('language') + $scope.filter + "&sortBy=" + $scope.paginationObject.sortOrder + $scope.paginationObject.sortBy + "&limit=" + limit, $scope.global.paginationHeaders(pageNumber, limit), {
            "limit": limit});
    }
    hasServicesList.then(function(result) {
		$scope.servicesList = result;
		$scope.servicesList.Count = 0;
        if (result.length != 0) {
            $scope.servicesList.Count = result.totalItems;
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

// Quick search list
$scope.quickSearchText = null;
$scope.searchList = function(quickSearchText) {
    $scope.quickSearchText = quickSearchText;
    $scope.list(1);
};

//Get service category
var hasServiceCategory = appService.crudService.listAll("serviceCategory/list");
hasServiceCategory.then(function (result) {
	$scope.formElements.serviceCategoryList = result;
});

// Services List
$scope.list = function (pageNumber) {




    var hasServicesList = {};
    $scope.filter = "";
         $scope.filter = "?searchText=" + $scope.quickSearchText;
         if ($scope.quickSearchText == null) {
             hasServicesList = promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "services/listAll");
         } else {
             $scope.filter = "&searchText=" + $scope.quickSearchText;
             hasServicesList = promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "services/listServices?searchText=" + $scope.quickSearchText);

         }

    hasServicesList.then(function (result) {
        $scope.servicesList = result;
        $scope.servicesList.Count = 0;
        if (result.length != 0) {
            $scope.servicesList.Count = result.totalItems;
        }


    });
};
$scope.list(1);

$scope.viewserviceDetails = function(size, serviceId) {
    appService.dialogService.openDialog("app/views/services/view-service-details.jsp", size, $scope, ['$scope', '$modalInstance', function($scope, $modalInstance) {
               var hasVpcs =  appService.crudService.read("services",serviceId);
                hasVpcs.then(function(result) {
              	  $scope.viewservice = result;
                })
            $scope.cancel = function() {
                $modalInstance.close();
            };
    }]);

};

$scope.vm = {};
$scope.vmlist = function(pageNumber, status) {
    if (!angular.isUndefined(status)) {
        $scope.vm.status = status;
        $window.sessionStorage.removeItem("status")
        $window.sessionStorage.setItem("status", status);
    } else {
        $scope.vm.status = $window.sessionStorage.getItem("status");
    }
    $scope.showLoader = true;
    var hasUsers = {};

    $scope.filter = "";
        hasUsers = promiseAjax.httpTokenRequest(globalConfig.HTTP_GET, globalConfig.APP_URL + "virtualmachine/listVMByStatus" + "?status=" + $scope.vm.status );


    $scope.borderContent = status;
    hasUsers.then(function(result) { // this is only run after $http
        // completes0
        $scope.instanceList = result;

        $scope.showLoader = false;
    });
};
$scope.vmlist(1, "Expunging");

$scope.openAddInstance = function(size, serviceId)
{
	appService.dialogService.openDialog($scope.global.VIEW_URL + "services/vm-list.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope',
                                                                                             function ($scope, $modalInstance, $rootScope) {
        // Create a services
        $scope.attachVMService = function (form, services) {

        },
        $scope.cancel = function () {
            $modalInstance.close();
        };
    }]);
};

$scope.addServices = function (size) {
    $scope.services = {};
	appService.dialogService.openDialog($scope.global.VIEW_URL + "servicecatalog/servicesCreate.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope',
                                                                                             function ($scope, $modalInstance, $rootScope) {
        // Create a services
        $scope.save = function (form, services) {
        	$scope.formSubmitted = true;
            if (form.$valid) {
            	$scope.showLoader = true;
            	var hasServices = appService.uploadServicesIcon.updateService(services, appService.promiseAjax.httpTokenRequest, appService.globalConfig,
            			$cookies,localStorageService);
                hasServices.then(function (result) {
                	$scope.showLoader = false;
                	$modalInstance.close();
                	$scope.list(1);
                	$scope.homerTemplate = 'app/views/notification/notify.jsp';
                    appService.notify({message: 'Created successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
                }).catch(function (result) {
                	$scope.showLoader = false;
        		    if (!angular.isUndefined(result.data)) {
            		if (result.data.fieldErrors != null) {
                   	    $scope.showLoader = false;
                    	angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                        	$scope.servicesForm[key].$invalid = true;
                        	$scope.servicesForm[key].errorMessage = errorMessage;
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

$scope.editServices = function (size, services) {
    $scope.services = {};
	var hasServices = appService.crudService.read("services", services.id);
	hasServices.then(function (result) {
        $scope.services = result;
        if ($scope.services.serviceCost == 0) {
        	$scope.services.serviceCost = null;
        }
        $scope.serviceIconImage = 'http://'+ $window.location.hostname +':8080/'  + 'resources/' + $scope.services.serviceIcon;
    });
	appService.dialogService.openDialog($scope.global.VIEW_URL + "servicecatalog/servicesEdit.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope',
                                                                                             function ($scope, $modalInstance, $rootScope) {
        // Edit services
        $scope.edit = function (form, services) {
            $scope.formSubmitted = true;
            if (form.$valid) {
            	$scope.showLoader = true;
            	var hasServices = appService.uploadServicesIcon.updateService(services, appService.promiseAjax.httpTokenRequest, appService.globalConfig,
            			$cookies,localStorageService);
                hasServices.then(function (result) {
                $scope.showLoader = false;
                $modalInstance.close();
            	$scope.list(1);
                $scope.homerTemplate = 'app/views/notification/notify.jsp';
                appService.notify({message: 'Updated successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
                }).catch(function (result) {
                    if (!angular.isUndefined(result.data)) {
                	$scope.showLoader = false;
                    if (result.data.fieldErrors != null) {
                        angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                            $scope.servicesForm[key].$invalid = true;
                            $scope.servicesForm[key].errorMessage = errorMessage;
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

$scope.delete = function (size, services) {
    $scope.services = {};
	appService.dialogService.openDialog($scope.global.VIEW_URL + "servicecatalog/delete-storage.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope',
                                                                                             function ($scope, $modalInstance, $rootScope) {
	   // Delete the services
	   $scope.ok = function (servicesId) {
            $scope.showLoader = true;
            var hasServices = appService.crudService.softDelete("services", services);
            hasServices.then(function (result) {
                $scope.list(1);
                $scope.homerTemplate = 'app/views/notification/notify.jsp';
                $scope.showLoader = false;
                appService.notify({message: 'Deleted successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
            });
            $modalInstance.close();
		},
        $scope.cancel = function () {
            $modalInstance.close();
        };
    }]);
};
};