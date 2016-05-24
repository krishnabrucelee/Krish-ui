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

function billingCtrl($scope, appService, globalConfig, localStorageService, $window, notify) {

    $scope.global = globalConfig;
    $scope.invoiceList = [];
    $scope.reportElements = {
            dateList: [{id: 1, root: 'Date Range', name: 'All', value: 'all'}, {id: 2, root: 'Date Range', name: 'Period', value: 'period'}],
        };

    $scope.open = function ($event, currentDateField) {
        $event.preventDefault();
        $event.stopPropagation();

        $scope.usageStatisticsObj[currentDateField] = true;
    };
    localStorageService.set("invoiceList",null);
    if (localStorageService.get("invoiceList") == null) {
        var hasServer = appService.promiseAjax.httpRequest("GET", "api/invoice.json");
        hasServer.then(function (result) {  // this is only run after $http completes
            $scope.invoiceList = result;
            localStorageService.set("invoiceList", result);
        });
    } else {
        $scope.invoiceList = localStorageService.get("invoiceList");
    }

    // Domain List
    var hasDomains = appService.crudService.listAll("domains/list");
    hasDomains.then(function (result) {  // this is only run after $http completes0
        $scope.domainList = result;
    });

    $scope.save = function(form) {
        $scope.formSubmitted = true;
        if (form.$valid) {
            $scope.invoiceList = localStorageService.get("invoiceList");
            var invoiceCount = $scope.invoiceList.length;
            localStorageService.set("invoiceList", $scope.invoiceList);
        }
    };

    $scope.monthList = appService.utilService.getMonthList();

    Date.prototype.ddmmyyyy= function() {
       var yyyy = this.getFullYear().toString();
       var mm = (this.getMonth()+1).toString(); // getMonth() is zero-based
       var dd  = this.getDate().toString();
       return (dd[1]?dd:"0"+dd[0]) + "-"+ (mm[1]?mm:"0"+mm[0]) + "-" + yyyy; // padding
      };

    $scope.usageStatistics = [];
    $scope.showLoader = false;
    $scope.usageStatisticsObj = {};

    $scope.getBillableTypeByUsageType = function(usageType) {
        var billableType = "";
        switch(usageType) {
        case 1:
            billableType = "VM";
            break;
        case 2:
            billableType = "Stopped VM";
            break;
        case 3:
            billableType = "IP";
            break;
        case 6:
            billableType = "Storage";
            break;
        case 7:
        case 8:
            billableType = "Template";
            break;
        case 9:
        case 15:
            billableType = "Snapshot";
            break;


        }
        return billableType;
    }

    $scope.getUsageStatistics = function() {
        if(angular.isUndefined($scope.usageStatisticsObj.startDate)
                || $scope.usageStatisticsObj.startDate == ""
                || (angular.isUndefined($scope.usageStatisticsObj.endDate)
                        || $scope.usageStatisticsObj.endDate == ""
                        || (($scope.usageStatisticsObj.domain == "" || $scope.usageStatisticsObj.domain == null)
                        && appService.globalConfig.sessionValues.type == "ROOT_ADMIN"))) {
            alert("Please select all the mandatory fields")
            return false;
        }


        var groupBy = $scope.groupBy;
        $scope.showLoader = false;
        $scope.usageStatisticsType = groupBy;
            var startDate = $scope.usageStatisticsObj.startDate.ddmmyyyy();
            var endDate = $scope.usageStatisticsObj.endDate.ddmmyyyy();

	    $scope.reportStartDate = $scope.usageStatisticsObj.startDate.ddmmyyyy();
            $scope.reportEndDate = $scope.usageStatisticsObj.endDate.ddmmyyyy();

            if($scope.global.sessionValues.type != 'ROOT_ADMIN') {
                domainUuid = appService.globalConfig.sessionValues.domainAbbreviationName;
                $scope.domainName = appService.globalConfig.sessionValues.domainAbbreviationName;
            } else {
                domainUuid = $scope.usageStatisticsObj.domain.companyNameAbbreviation;
                $scope.domainName = $scope.usageStatisticsObj.domain.companyNameAbbreviation;

            }

            var hasServer = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL
                    + "usage/listUsageByPeriod?fromDate="+ startDate +"&toDate=" + endDate + "&groupingType=" + groupBy + "&domainUuid=" + domainUuid);
            hasServer.then(function (result) {  // this is only run after $http completes
                $scope.usageStatistics = result;
                $scope.showLoader = true;
                if(groupBy == "service") {
                    usageList = $scope.getUsageListByGroup("usageid");
                    $scope.groupItemByUsageList(usageList);
            } else if(groupBy == "project") {
                usageList = $scope.getUsageListByGroup("project");
                $scope.groupItemByUsageList(usageList);
            }
            else if(groupBy == "department") {
                usageList = $scope.getUsageListByGroup("account");
                $scope.groupItemByUsageList(usageList);
            }
        });

        $scope.myframe = true;
    	$scope.reportUrl =  appService.globalConfig.PING_APP_URL + "usage/statistics?fromDate="+ startDate +"&toDate=" + endDate + "&groupingType=" + groupBy + "&domainUuid=" + domainUuid;
    	document.getElementById('myframe').setAttribute('src', $scope.reportUrl + "&type=html");
    }

    $scope.getUsageListByGroup = function(group) {
        var groupItemList = [];
        angular.forEach($scope.usageStatistics, function(obj, key) {
        if(!angular.isUndefined(obj[group])) {
            groupItem = obj[group];
            if(angular.isUndefined(groupItemList[groupItem])) {
                groupItemList[groupItem] = [];
            }
            if(angular.isUndefined(groupItemList[groupItem][obj.usagetype])) {
                groupItemList[groupItem][obj.usagetype] = {};
            }
            if(angular.isUndefined(groupItemList[groupItem][obj.usagetype].usageUnits)) {
                groupItemList[groupItem][obj.usagetype].usageUnits = 0;
            }

            if(angular.isUndefined(groupItemList[groupItem][obj.usagetype].planTotal)) {
                groupItemList[groupItem][obj.usagetype].planTotal = 0;
            }
            var rawusage = (obj.rawusage > 0) ? 1 : 0;
            if(obj.rawusage < 24 && obj.usagetype == 2) {
                rawusage = 0;
            }
            if(!angular.isUndefined(obj.templateid) && obj.usagetype == 6) {
                rawusage = 0;
            }

            if(angular.isUndefined(obj.planCost))
                obj.planCost = 0;

            if(angular.isUndefined(obj.usageUnits)) {
                obj.usageUnits = 0;
            }


            // For template
            if(!angular.isUndefined(obj.templateid)) {
                var tempGroupItem = obj.templateid;
                if(group != "usageid")
                    tempGroupItem = obj[group];
                if(angular.isUndefined(groupItemList[tempGroupItem])) {
                    groupItemList[tempGroupItem] = [];
                }
                if(angular.isUndefined(groupItemList[tempGroupItem][obj.usagetype])) {
                    groupItemList[tempGroupItem][obj.usagetype] = {};
                }
                if(angular.isUndefined(groupItemList[tempGroupItem][7])) {
                    groupItemList[tempGroupItem][7] = {};
                }
                if(angular.isUndefined(groupItemList[tempGroupItem][7].usageUnits)) {
                    groupItemList[tempGroupItem][7].usageUnits = 0;
                }
                if(angular.isUndefined(groupItemList[tempGroupItem][obj.usagetype])) {
                    groupItemList[tempGroupItem][7][obj.usagetype] = {};
                }

                if(angular.isUndefined(groupItemList[tempGroupItem][7].planTotal)) {
                    groupItemList[tempGroupItem][7].planTotal = 0;
                }

            }

            if(rawusage > 0) {
                if((group == "project" && !angular.isUndefined(obj.projectid))
                        || (group == "account" && !angular.isUndefined(obj.accountid))
                        || group == "usageid") {

                    if(obj.usagetype == 2
                        && !angular.isUndefined(obj.templatecost)
                        && parseFloat(obj.templatecost) > 0) {


                        if(obj.templateonetimechargeable) {
                            groupItemList[tempGroupItem][7].planTotal =  parseFloat(obj.templatecost);
                        } else {
                            groupItemList[tempGroupItem][7].planTotal =  parseFloat(groupItemList[tempGroupItem][7].planTotal) + (parseFloat(obj.usageUnits) * parseFloat(obj.templatecost));
                        }

                        groupItemList[tempGroupItem][7].usageUnits =  groupItemList[tempGroupItem][7].usageUnits + rawusage;
                        groupItemList[tempGroupItem][7].billableType = $scope.getBillableTypeByUsageType(7);
                        groupItemList[tempGroupItem][7].usageType = 7;
                        groupItemList[tempGroupItem][7].usageid = obj.templateid;
                        if(!angular.isUndefined(obj.templateusagename))
                        groupItemList[tempGroupItem][7].usageName = obj.templateusagename;
                    }

                    if(parseFloat(obj.planCost) > 0) {
                        groupItemList[groupItem][obj.usagetype].usageUnits =  groupItemList[groupItem][obj.usagetype].usageUnits + rawusage;
                        groupItemList[groupItem][obj.usagetype].planTotal =  parseFloat(groupItemList[groupItem][obj.usagetype].planTotal) + (parseFloat(obj.usageUnits) * parseFloat(obj.planCost));
                        groupItemList[groupItem][obj.usagetype].billableType = $scope.getBillableTypeByUsageType(obj.usagetype);
                        groupItemList[groupItem][obj.usagetype].usageType = obj.usagetype;
                        if(!angular.isUndefined(obj.usagename))
                            groupItemList[groupItem][obj.usagetype].usageName = obj.usagename;
                    }
                }
            }
        }
        });
        return groupItemList;
    }

    $scope.groupItemByUsageList = function(usageList) {
        $scope.usageList= [];
        $scope.usageTotal = {};
        $scope.usageTotal = [];
        var inc=0;
        for(var j in usageList) {
            inc++;
            if(angular.isUndefined($scope.usageTotal[j])) {
                $scope.usageTotal[inc] = {
                        planCost: 0,
                        usageUnits: 0
                };
            }
            var usageTotal = {};
            for(var i=0; i< usageList[j].length; i++) {
                if(!angular.isUndefined(usageList[j][i])) {
                    var usageItem = {};
                    if(usageList[j][i].planTotal > 0) {
                        usageItem.name = j;
                        if(usageList[j][i].usageUnits > 0) {
                            usageItem.usageUnits = usageList[j][i].usageUnits;
                            usageItem.planCost = parseFloat(usageList[j][i].planTotal).toFixed(2);
                            usageItem.billableType = usageList[j][i].billableType;
                            usageItem.usageType = usageList[j][i].usageType;
                            usageItem.usageName = usageList[j][i].usageName;
                            $scope.usageList.push(usageItem);
                            $scope.usageTotal[inc].total = $scope.usageTotal[inc].total + usageItem.planCost;
                        }
                    }

                }
            }
        }
    }
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
                    hasConfigList =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "usage/invoice/listByDomain"
                            +"?type=invoice"+ "&domainUuid="+appService.globalConfig.sessionValues.domainAbbreviationName+"&status=null");
                } else {

                    hasConfigList = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "usage/invoice?type=invoice");


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
                hasConfigList =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "usage/invoice/listByDomain"
                    +"?type=invoice"+"&domainUuid="+domainViewAbbr+"&status="+$scope.statusView);
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
   $scope.defaultView = true;
   $scope.configList = function (pageNumber) {
	$scope.defaultView = true;
      var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
      var hasConfigList = {};
      if (($scope.domainView == null || angular.isUndefined($scope.domainView))
              && ($scope.statusView == null || angular.isUndefined($scope.statusView))) {

          if (appService.globalConfig.sessionValues.type !== 'ROOT_ADMIN') {

$scope.domainpdf = function()
{
	 $scope.viewpdf =appService.globalConfig.PING_APP_URL +"invoice/statistics/report?domainUuid="+appService.globalConfig.sessionValues.domainAbbreviationName+"&status=null&type=pdf&method=invoice";
}

$scope.domainexcel = function()
{
	 $scope.viewexcel =appService.globalConfig.PING_APP_URL +"invoice/statistics/report?domainUuid="+appService.globalConfig.sessionValues.domainAbbreviationName+"&status=null&type=xlsx&method=invoice";
}
   hasConfigList =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "usage/invoice/listByDomain"
                        +"?type=invoice"+ "&domainUuid="+appService.globalConfig.sessionValues.domainAbbreviationName+"&status=null");


          } else {
 $scope.showLoader = true;
              hasConfigList = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "usage/invoice?type=invoice");
	//$scope.myReportframe = true;
    	//$scope.reportUrl =  appService.globalConfig.PING_APP_URL + "invoice/reportlist?type=invoice";;
    	//document.getElementById('myReportframe').setAttribute('src', $scope.reportUrl);
 $scope.showLoader = false;
          }
      } else {
 $scope.defaultView = false;
          var domainViewAbbr = null;
	  $scope.domainViewAbbr = null;
          if ($scope.domainView != null && !angular.isUndefined($scope.domainView)) {
                domainViewAbbr = $scope.domainView.companyNameAbbreviation;
		$scope.domainViewAbbr = $scope.domainView.companyNameAbbreviation;
            }
            if ($scope.statusView == null || angular.isUndefined($scope.statusView)) {
               $scope.statusView = null;
            }
            if (appService.globalConfig.sessionValues.type !== 'ROOT_ADMIN') {
               domainViewAbbr = appService.globalConfig.sessionValues.domainAbbreviationName;
		$scope.domainViewAbbr = appService.globalConfig.sessionValues.domainAbbreviationName;
             }




    	//$scope.myframe = true;
    	//$scope.reportUrl =  appService.globalConfig.PING_APP_URL + "invoice/statistics?domainUuid="+ $scope.domainViewAbbr +"&status=" + $scope.statusView+"&type=invoice";
    	//document.getElementById('myframe').setAttribute('src', $scope.reportUrl);

$scope.pdf = function()
{
	 $scope.viewpdf =appService.globalConfig.PING_APP_URL +"invoice/statistics/report?domainUuid="+$scope.domainViewAbbr+"&status="+ $scope.statusView+"&type=pdf&method=invoice";
}

$scope.excel = function()
{
	 $scope.viewexcel =appService.globalConfig.PING_APP_URL +"invoice/statistics/report?domainUuid="+$scope.domainViewAbbr+"&status="+ $scope.statusView+"&type=xlsx&method=invoice";
}



   hasConfigList =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "usage/invoice/listByDomain"
                +"?type=invoice"+ "&domainUuid="+domainViewAbbr+"&status="+$scope.statusView);
      }
 $scope.showLoader = true;
      hasConfigList.then(function (result) {  // this is only run after $http completes0

 $scope.invoiceList = result;
 $scope.showLoader = false;
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
                    hasConfigList =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "usage/invoice/listByDomain"
                            +"?type=payment&lang=" +appService.localStorageService.cookie.get('language')
                            + "&domainUuid="+appService.globalConfig.sessionValues.domainAbbreviationName+"&status=null");
                } else {
                    hasConfigList = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "usage/invoice?type=payment&lang="+ appService.localStorageService.cookie.get('language')
                            +"&sortBy="+sortOrder+sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
                }

            } else {
 $scope.defaultView = false;
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
                hasConfigList =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "usage/invoice/listByDomain"
                    +"?type=payment"
                    + "&domainUuid="+domainViewAbbr+"&status="+$scope.statusView);
            }

          hasConfigList.then(function(result) { // this is only run after $http
//                if (!angular.isUndefined(result._embedded)) {
//                   $scope.invoiceList = result['_embedded'].invoiceList;
//                    } else {
//                        $scope.invoiceList = {};
 //                   }

$scope.invoiceList = result;

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
 $scope.defaultView = true;
   $scope.configList = function (pageNumber) {
 $scope.defaultView = true;
      var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
      var hasConfigList = {};
      if (($scope.domainView == null || angular.isUndefined($scope.domainView))
              && ($scope.statusView == null || angular.isUndefined($scope.statusView))) {

          if (appService.globalConfig.sessionValues.type !== 'ROOT_ADMIN') {

$scope.domainpdf = function()
{
	 $scope.viewpdf =appService.globalConfig.PING_APP_URL +"invoice/statistics/report?domainUuid="+appService.globalConfig.sessionValues.domainAbbreviationName+"&status=null&type=pdf&method=payment";
}

$scope.domainexcel = function()
{
	 $scope.viewexcel =appService.globalConfig.PING_APP_URL +"invoice/statistics/report?domainUuid="+appService.globalConfig.sessionValues.domainAbbreviationName+"&status=null&type=xlsx&method=payment";
}
              hasConfigList =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "usage/invoice/listByDomain"
                        +"?type=payment"+ "&domainUuid="+appService.globalConfig.sessionValues.domainAbbreviationName+"&status=null");
          } else {

             hasConfigList = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "usage/invoice?type=payment");

	//$scope.myReportframe = true;
    	//$scope.reportUrl =  appService.globalConfig.PING_APP_URL + "invoice/reportlist?type=payment&method=payment";
    	//document.getElementById('myReportframe').setAttribute('src', $scope.reportUrl);
          }
      } else {

 $scope.defaultView = false;
          var domainViewAbbr = null;
	  $scope.domainViewAbbr = null;
            if ($scope.domainView != null && !angular.isUndefined($scope.domainView)) {
              domainViewAbbr = $scope.domainView.companyNameAbbreviation;
	$scope.domainViewAbbr = $scope.domainView.companyNameAbbreviation;
          }
            if ($scope.statusView == null || angular.isUndefined($scope.statusView)) {
               $scope.statusView = null;
            }
            if (appService.globalConfig.sessionValues.type !== 'ROOT_ADMIN') {
              domainViewAbbr = appService.globalConfig.sessionValues.domainAbbreviationName;
	$scope.domainViewAbbr = appService.globalConfig.sessionValues.domainAbbreviationName;
             }

	  //$scope.myframe = true;
	 //$scope.reportUrl =  appService.globalConfig.PING_APP_URL + "invoice/statistics?domainUuid="+ $scope.domainViewAbbr +"&status=" + $scope.statusView+"&type=payment";
    	//document.getElementById('myframe').setAttribute('src', $scope.reportUrl);

$scope.pdf = function()
{
	 $scope.viewpdf =appService.globalConfig.PING_APP_URL +"invoice/statistics/report?domainUuid="+$scope.domainViewAbbr+"&status="+ $scope.statusView+"&type=pdf&method=payment";
}

$scope.excel = function()
{
	 $scope.viewexcel =appService.globalConfig.PING_APP_URL +"invoice/statistics/report?domainUuid="+$scope.domainViewAbbr+"&status="+ $scope.statusView+"&type=xlsx&method=payment";
}

          hasConfigList =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "usage/invoice/listByDomain"
                +"?type=payment"+ "&domainUuid="+domainViewAbbr+"&status="+$scope.statusView);
      }
 $scope.showLoader = true;
      hasConfigList.then(function (result) {  // this is only run after $http completes0
//         if (!angular.isUndefined(result._embedded)) {
//             $scope.invoiceList = result['_embedded'].invoiceList;
//         } else {
//             $scope.invoiceList = {};/
//         }
$scope.invoiceList = result;
 $scope.showLoader = false;
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

   $scope.PayNow = function (size, invoice) {
       $scope.invoice = invoice;
       appService.dialogService.openDialog("app/views/common/confirm-payment.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
              $scope.ok = function (invoice) {
                   $scope.showLoader = true;
                   var makePay = appService.promiseAjax.httpTokenRequest(globalConfig.HTTP_GET, globalConfig.APP_URL + "payment/pay"
                           +"?lang=" +appService.localStorageService.cookie.get('language')
                           + "&invoice="+invoice.invoiceNumber+"&totalfee="+invoice.totalCost+"&client="+invoice.domain.uuid);
                   makePay.then(function (result) {
                       $scope.showLoader = false;
                       $modalInstance.close();
                       appService.localStorageService.set("payments",result);
                       $window.location.href = '#/alipayments';
                 }).catch(function (result) {$modalInstance.close();$scope.showLoader = false;});
               },
               $scope.cancel = function () {
                   $modalInstance.close();
               };
           }]);
   };


    $scope.formElements = {
            invoiceStatusList: {
                "3":"PAID",
                "5":"UNPAID"
            }
    }

};
