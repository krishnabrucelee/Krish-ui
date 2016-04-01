/**
 *
 * instanceCtrl
 *
 */

angular
    .module('homer')
    .controller('billingCtrl', billingCtrl)
    .controller('billingInvoiceCtrl', billingInvoiceCtrl)
    .controller('billingPaymentsCtrl', billingPaymentsCtrl)

function billingCtrl($scope, promiseAjax, globalConfig, localStorageService, $window, notify) {

    $scope.global = globalConfig;
    $scope.invoiceList = [];

    localStorageService.set("invoiceList",null);
    if (localStorageService.get("invoiceList") == null) {
        var hasServer = promiseAjax.httpRequest("GET", "api/invoice.json");
        hasServer.then(function (result) {  // this is only run after $http completes
            $scope.invoiceList = result;
            localStorageService.set("invoiceList", result);
        });
    } else {
        $scope.invoiceList = localStorageService.get("invoiceList");
    }

    $scope.save = function(form) {
        $scope.formSubmitted = true;
        if (form.$valid) {
            $scope.invoiceList = localStorageService.get("invoiceList");
            var invoiceCount = $scope.invoiceList.length;
            localStorageService.set("invoiceList", $scope.invoiceList);
        }
    };
};

function billingInvoiceCtrl($scope, $http, $window, $modal, $log, $state, $stateParams, appService, globalConfig) {

    $scope.paginationObject = {};
    $scope.configForm = {};
    $scope.domainList = {};
    $scope.invoiceList = {};
    $scope.hasConfigList = {};
    $scope.sort = appService.globalConfig.sort;
    $scope.global = appService.globalConfig;
    $scope.paginationObject.sortOrder = '-';
    $scope.paginationObject.sortBy = 'dueDate';

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
            var hasConfigList = {};
            if (($scope.domainView == null || angular.isUndefined($scope.domainView))
            		&& ($scope.statusView == null || angular.isUndefined($scope.statusView))) {
            	if (appService.globalConfig.sessionValues.type !== 'ROOT_ADMIN') {
            		hasConfigList =  appService.promiseAjax.httpRequestPing(appService.globalConfig.HTTP_GET, appService.globalConfig.PING_APP_URL + "invoice/listByDomain"
            				+"?lang=" +appService.localStorageService.cookie.get('language')
            				+ "&domainUuid="+appService.globalConfig.sessionValues.domainAbbreviationName+"&status=null&sortBy="+$scope.paginationObject.sortOrder+$scope.paginationObject.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
            	} else {
            		hasConfigList = appService.promiseAjax.httpRequestPing(appService.globalConfig.HTTP_GET, appService.globalConfig.PING_APP_URL + "invoice?lang="+ appService.localStorageService.cookie.get('language')
                			+"&sortBy="+sortOrder+sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
            	}
            } else {
            	  var domainViewAbbr = null;
          	      if ($scope.domainView != null && !angular.isUndefined($scope.domainView)) {
            		  domainViewAbbr = $scope.domainView.companyNameAbbreviation;
            	  }
             	  if ($scope.statusView == null || angular.isUndefined($scope.statusView)) {
             		 $scope.statusView = null;
             	  }
             	  if (appService.globalConfig.sessionValues.type !== 'ROOT_ADMIN') {
             		 domainViewAbbr = appService.globalConfig.sessionValues.domainAbbreviationName;
            	  }
            	hasConfigList =  appService.promiseAjax.httpRequestPing(appService.globalConfig.HTTP_GET, appService.globalConfig.PING_APP_URL + "invoice/listByDomain"
    				+"?lang=" +appService.localStorageService.cookie.get('language')
    				+ "&domainUuid="+domainViewAbbr+"&status="+$scope.statusView+"&sortBy="+$scope.paginationObject.sortOrder+$scope.paginationObject.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
            }

            hasConfigList.then(function(result) { // this is only run after $http
            	if (!angular.isUndefined(result._embedded)) {
                    $scope.invoiceList = result['_embedded'].invoiceList;
           	 	} else {
           	 		$scope.invoiceList = {};
           	 	}

			    // For pagination
			    $scope.paginationObject.limit = limit;
			    $scope.paginationObject.currentPage = pageNumber;
			    $scope.paginationObject.totalItems = $scope.invoiceList.totalItems;
			    $scope.paginationObject.sortOrder = sortOrder;
			    $scope.paginationObject.sortBy = sortBy;
			    $scope.showLoader = false;
		});
	};

	// Domain List
	var hasDomains = appService.crudService.listAll("domains/list");
	hasDomains.then(function (result) {  // this is only run after $http completes0
		$scope.domainList = result;
	});

   $scope.global = globalConfig;
   $scope.configList = function (pageNumber) {
	  var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
	  var hasConfigList = {};
	  if (($scope.domainView == null || angular.isUndefined($scope.domainView))
      		&& ($scope.statusView == null || angular.isUndefined($scope.statusView))) {
		  if (appService.globalConfig.sessionValues.type !== 'ROOT_ADMIN') {
			  hasConfigList =  appService.promiseAjax.httpRequestPing(appService.globalConfig.HTTP_GET, appService.globalConfig.PING_APP_URL + "invoice/listByDomain"
						+"?lang=" +appService.localStorageService.cookie.get('language')
						+ "&domainUuid="+appService.globalConfig.sessionValues.domainAbbreviationName+"&status=null&sortBy="+$scope.paginationObject.sortOrder+$scope.paginationObject.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
		  } else {
			  hasConfigList = appService.promiseAjax.httpRequestPing(appService.globalConfig.HTTP_GET, appService.globalConfig.PING_APP_URL + "invoice?lang="+ appService.localStorageService.cookie.get('language')
		      			+"&sortBy="+$scope.paginationObject.sortOrder+$scope.paginationObject.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
		  }
      } else {
    	  var domainViewAbbr = null;
    	  if ($scope.domainView != null && !angular.isUndefined($scope.domainView)) {
      		  domainViewAbbr = $scope.domainView.companyNameAbbreviation;
      	  }
      	  if ($scope.statusView == null || angular.isUndefined($scope.statusView)) {
      		 $scope.statusView = null;
      	  }
      	  if (appService.globalConfig.sessionValues.type !== 'ROOT_ADMIN') {
      		 domainViewAbbr = appService.globalConfig.sessionValues.domainAbbreviationName;
   	      }

       	hasConfigList =  appService.promiseAjax.httpRequestPing(appService.globalConfig.HTTP_GET, appService.globalConfig.PING_APP_URL + "invoice/listByDomain"
				+"?lang=" +appService.localStorageService.cookie.get('language')
				+ "&domainUuid="+domainViewAbbr+"&status="+$scope.statusView+"&sortBy="+$scope.paginationObject.sortOrder+$scope.paginationObject.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
      }
      hasConfigList.then(function (result) {  // this is only run after $http completes0
    	 if (!angular.isUndefined(result._embedded)) {
             $scope.invoiceList = result['_embedded'].invoiceList;
    	 } else {
    		 $scope.invoiceList = {};
    	 }

         // For pagination
		 $scope.paginationObject.limit = limit;
		 $scope.paginationObject.currentPage = pageNumber;
		 $scope.paginationObject.totalItems = $scope.invoiceList.totalItems;
		 $scope.showLoader = false;
      });
 	  };
   $scope.configList(1);

   // Get application list based on domain selection
   $scope.selectDomainView = function(pageNumber) {
   	   $scope.configList(1);
   };

    $scope.validateInvoice = function (form) {
        $scope.formSubmitted = true;
        if (form.$valid) {
            var config = $scope.config;
            config.dateFormatType = config.dateFormatType.id;
            $scope.showLoader = true;
            var hasConfig = appService.promiseAjax.httpRequestPing(globalConfig.HTTP_POST, globalConfig.PING_APP_URL + "configuration", config);
            hasConfig.then(function (result) {  // this is only run after $http
                $scope.showLoader = false;
                $scope.homerTemplate = 'app/views/notification/notify.jsp';
                appService.notify({message: 'Updated successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
                $scope.configList();

            }).catch(function (result) {
            	$scope.showLoader = false;
                if (!angular.isUndefined(result.data)) {
                    if (result.data.globalError != '' && !angular.isUndefined(result.data.globalError)) {
                        var msg = result.data.globalError[0];
                        $scope.showLoader = false;
                        appService.notify({message: msg, classes: 'alert-danger', templateUrl: appService.globalConfig.NOTIFICATION_TEMPLATE});
                    } else if (result.data.fieldErrors != null) {
                        angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                            $scope.configForm[key].$invalid = true;
                            $scope.configForm[key].errorMessage = errorMessage;
                        });
                    }
                }
            });
        }
    };

    $scope.formElements = {
            invoiceStatusList: {
                "2":"DUE",
                "3":"PAID",
                "4":"OVER_DUE"
            }
    }

};

function billingPaymentsCtrl($scope, $http, $window, $modal, $log, $state, $stateParams, appService, globalConfig) {

    $scope.paginationObject = {};
    $scope.configForm = {};
    $scope.domainList = {};
    $scope.invoiceList = {};
    $scope.hasConfigList = {};
    $scope.sort = appService.globalConfig.sort;
    $scope.global = appService.globalConfig;
    $scope.paginationObject.sortOrder = '-';
    $scope.paginationObject.sortBy = 'dueDate';

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
            var hasConfigList = {};
            if (($scope.domainView == null || angular.isUndefined($scope.domainView))
            		&& ($scope.statusView == null || angular.isUndefined($scope.statusView))) {
            	if (appService.globalConfig.sessionValues.type !== 'ROOT_ADMIN') {
            		hasConfigList =  appService.promiseAjax.httpRequestPing(appService.globalConfig.HTTP_GET, appService.globalConfig.PING_APP_URL + "invoice/listByDomain"
            				+"?lang=" +appService.localStorageService.cookie.get('language')
            				+ "&domainUuid="+appService.globalConfig.sessionValues.domainAbbreviationName+"&status=null&sortBy="+$scope.paginationObject.sortOrder+$scope.paginationObject.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
            	} else {
            		hasConfigList = appService.promiseAjax.httpRequestPing(appService.globalConfig.HTTP_GET, appService.globalConfig.PING_APP_URL + "invoice?lang="+ appService.localStorageService.cookie.get('language')
                			+"&sortBy="+sortOrder+sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
            	}

            } else {
            	  var domainViewAbbr = null;
          	      if ($scope.domainView != null && !angular.isUndefined($scope.domainView)) {
            		  domainViewAbbr = $scope.domainView.companyNameAbbreviation;
            	  }
             	  if ($scope.statusView == null || angular.isUndefined($scope.statusView)) {
             		 $scope.statusView = null;
             	  }
             	  if (appService.globalConfig.sessionValues.type !== 'ROOT_ADMIN') {
             		 domainViewAbbr = appService.globalConfig.sessionValues.domainAbbreviationName;
            	  }
            	hasConfigList =  appService.promiseAjax.httpRequestPing(appService.globalConfig.HTTP_GET, appService.globalConfig.PING_APP_URL + "invoice/listByDomain"
    				+"?lang=" +appService.localStorageService.cookie.get('language')
    				+ "&domainUuid="+domainViewAbbr+"&status="+$scope.statusView+"&sortBy="+$scope.paginationObject.sortOrder+$scope.paginationObject.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
            }

            hasConfigList.then(function(result) { // this is only run after $http
            	if (!angular.isUndefined(result._embedded)) {
                    $scope.invoiceList = result['_embedded'].invoiceList;
           	 	} else {
           	 		$scope.invoiceList = {};
           	 	}

			    // For pagination
			    $scope.paginationObject.limit = limit;
			    $scope.paginationObject.currentPage = pageNumber;
			    $scope.paginationObject.totalItems = $scope.invoiceList.totalItems;
			    $scope.paginationObject.sortOrder = sortOrder;
			    $scope.paginationObject.sortBy = sortBy;
			    $scope.showLoader = false;
		});
	};

	// Domain List
	var hasDomains = appService.crudService.listAll("domains/list");
	hasDomains.then(function (result) {  // this is only run after $http completes0
		$scope.domainList = result;
	});

   $scope.global = globalConfig;

   $scope.configList = function (pageNumber) {
	  var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
	  var hasConfigList = {};
	  if (($scope.domainView == null || angular.isUndefined($scope.domainView))
      		&& ($scope.statusView == null || angular.isUndefined($scope.statusView))) {
		  if (appService.globalConfig.sessionValues.type !== 'ROOT_ADMIN') {
			  hasConfigList =  appService.promiseAjax.httpRequestPing(appService.globalConfig.HTTP_GET, appService.globalConfig.PING_APP_URL + "invoice/listByDomain"
						+"?lang=" +appService.localStorageService.cookie.get('language')
						+ "&domainUuid="+appService.globalConfig.sessionValues.domainAbbreviationName+"&status=null&sortBy="+$scope.paginationObject.sortOrder+$scope.paginationObject.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
		  } else {
			 hasConfigList = appService.promiseAjax.httpRequestPing(appService.globalConfig.HTTP_GET, appService.globalConfig.PING_APP_URL + "invoice?lang="+ appService.localStorageService.cookie.get('language')
      			+"&sortBy="+$scope.paginationObject.sortOrder+$scope.paginationObject.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
		  }
      } else {
    	  var domainViewAbbr = null;
  	      if ($scope.domainView != null && !angular.isUndefined($scope.domainView)) {
    		  domainViewAbbr = $scope.domainView.companyNameAbbreviation;
    	  }
      	  if ($scope.statusView == null || angular.isUndefined($scope.statusView)) {
      		 $scope.statusView = null;
      	  }
      	  if (appService.globalConfig.sessionValues.type !== 'ROOT_ADMIN') {
      		domainViewAbbr = appService.globalConfig.sessionValues.domainAbbreviationName;
   	      }
      	hasConfigList =  appService.promiseAjax.httpRequestPing(appService.globalConfig.HTTP_GET, appService.globalConfig.PING_APP_URL + "invoice/listByDomain"
				+"?lang=" +appService.localStorageService.cookie.get('language')
				+ "&domainUuid="+domainViewAbbr+"&status="+$scope.statusView+"&sortBy="+$scope.paginationObject.sortOrder+$scope.paginationObject.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
      }
      hasConfigList.then(function (result) {  // this is only run after $http completes0
    	 if (!angular.isUndefined(result._embedded)) {
             $scope.invoiceList = result['_embedded'].invoiceList;
    	 } else {
    		 $scope.invoiceList = {};
    	 }

         // For pagination
		 $scope.paginationObject.limit = limit;
		 $scope.paginationObject.currentPage = pageNumber;
		 $scope.paginationObject.totalItems = $scope.invoiceList.totalItems;
		 $scope.showLoader = false;
      });
 	  };
   $scope.configList(1);

   // Get application list based on domain selection
   $scope.selectDomainView = function(pageNumber) {
   	   $scope.configList(1);
   };

    $scope.validateInvoice = function (form) {
        $scope.formSubmitted = true;
        if (form.$valid) {
            var config = $scope.config;
            config.dateFormatType = config.dateFormatType.id;
            $scope.showLoader = true;
            var hasConfig = appService.promiseAjax.httpRequestPing(globalConfig.HTTP_POST, globalConfig.PING_APP_URL + "configuration", config);
            hasConfig.then(function (result) {  // this is only run after $http
                $scope.showLoader = false;
                $scope.homerTemplate = 'app/views/notification/notify.jsp';
                appService.notify({message: 'Updated successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
                $scope.configList();

            }).catch(function (result) {
            	$scope.showLoader = false;
                if (!angular.isUndefined(result.data)) {
                    if (result.data.globalError != '' && !angular.isUndefined(result.data.globalError)) {
                        var msg = result.data.globalError[0];
                        $scope.showLoader = false;
                        appService.notify({message: msg, classes: 'alert-danger', templateUrl: appService.globalConfig.NOTIFICATION_TEMPLATE});
                    } else if (result.data.fieldErrors != null) {
                        angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                            $scope.configForm[key].$invalid = true;
                            $scope.configForm[key].errorMessage = errorMessage;
                        });
                    }
                }
            });
        }
    };

    $scope.formElements = {
            invoiceStatusList: {
                "3":"PAID",
                "5":"UNPAID"
            }
    }

};