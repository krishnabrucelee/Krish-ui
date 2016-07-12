/**
 *
 * appCtrl
 *
 */

angular
        .module('homer')
        .controller('appCtrl', appCtrl);

function appCtrl($http, $scope,$rootScope, $window,$modal, $timeout, appService, globalConfig, crudService, promiseAjax, localStorageService, $cookies) {

	$scope.global = appService.globalConfig;
	$scope.owner = {};
    $scope.paginationObject = {};
    $scope.sort = appService.globalConfig.sort;
    $scope.paginationObject.sortOrder = '-';
    $scope.paginationObject.sortBy = 'eventDateTime';
    $scope.activity = {
        category: "events",
        oneItemSelected: {},
        selectedAll: {}
    };

    var hasUsers = appService.crudService.read("users", $scope.global.sessionValues.id);
    hasUsers.then(function (result) {
        $scope.owner = result;
    });

    // For iCheck purpose only
    $scope.infrastructure = {};
    $scope.showLoaderOffer = true;


    $scope.getActivity = function (pageNumber) {
        var limit = 10;
        var hasactionServer = appService.promiseAjax.httpTokenRequest($scope.global.HTTP_GET, $scope.global.APP_URL + "events/list/read-event" +"?lang=" + localStorageService.cookie.get('language') + "&sortBy="+$scope.paginationObject.sortOrder+$scope.paginationObject.sortBy+"&limit=10", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
        hasactionServer.then(function (result) {  // this is only run after $http completes
            if(result.length>0){
        	$scope.activityList = result[0];
            var msg = result[0].message;
            if (msg.length > 50) {
                msg =  msg.slice(0, 50) + '...';
            }
            appService.notify({message: msg, classes: 'alert-info',templateUrl: $scope.global.NOTIFICATIONS_TEMPLATE });
            // For pagination
            $scope.paginationObject.limit = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
            $scope.global.event = result.totalItems;
            }else{
            	$scope.global.event = 0;
            }
        });
    };
    $scope.getActivity(1);

    // Delete the event
    $rootScope.deleteEvent = function () {
        var hasServer = appService.crudService.softDelete("events", $scope.activityList);
        hasServer.then(function(){
    	    $scope.getActivity(1);
        });
    }

//List the event
$rootScope.listEvent = function () {
	var hasServer = appService.promiseAjax.httpTokenRequest( $scope.global.HTTP_PUT , $scope.global.APP_URL + "events/event-update"  +"/"+$scope.activityList.id);
	hasServer.then(function(){
	    $scope.getActivity(1);
    });
}

$rootScope.showDescriptions = function () {
	var hasServer = appService.promiseAjax.httpTokenRequest( $scope.global.HTTP_PUT , $scope.global.APP_URL + "events/event-update"  +"/"+$scope.activityList.id);
    $scope.currentActivity = $scope.activityList;
    $scope.activityList.pageTitle = $scope.pageTitle;
    $scope.activityList.category = $scope.activity.category;
    $scope.activityList.owner = $scope.owner;
    var modalInstance = $modal.open({
        animation: $scope.animationsEnabled,
        templateUrl: 'app/views/activity/activity-description.jsp',
        controller: 'activityDescriptionCtrl',
        size: 'md',
        backdrop: 'static',
        windowClass: "hmodal-info",
        resolve: {
            activity: function () {
                return angular.copy($scope.activityList);
            },
            owner:function () {
                return angular.copy( $scope.owner);
            },
        }
    });

    modalInstance.result.then(function (selectedItem) {
        $scope.selected = selectedItem;

    }, function () {
    });
};

if ($scope.global.sessionValues.type == 'ROOT_ADMIN') {
	$scope.filterParamater = 'domain';
}
if ($scope.global.sessionValues.type == 'DOMAIN_ADMIN') {
	$scope.filterParamater = 'department';
}
if ($scope.global.sessionValues.type == 'USER') {
	$scope.filterParamater = 'project';
}

    $scope.getInfrastructureDetails = function() {
      var hasResult = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "dashboard/infrastructure?filter=" + $scope.filterParamater);
      hasResult.then(function(result) {  // this is only run after;
          $scope.infrastructure  = result;
            $scope.showLoaderOffer = false;
      });
    }

$scope.themeSettingList = function () {
        return $http({method:'get', url:  REQUEST_PROTOCOL+ $window.location.hostname +':8080/home/list'})
        .then(function(result){
            $scope.themeSettings = result.data[0];
             $scope.welcomeContentUser = result.data[0].welcomeContentUser;
             $scope.footerContent = result.data[0].footerContent;
             $scope.splashTitleUser= result.data[0].splashTitleUser;
             $cookies.splashTitleUser = result.data[0].splashTitleUser;
        });
    };
    $scope.themeSettingList();

//    $scope.quotaLimits = {
//    	       "Instance":{label: "VM"},"CPU": {label: "vCPU"}, "Memory": {label: "Memory"},"Template":{label: "Template"},"Snapshot": {label: "Snapshot"}, "Network": {label: "Network"},
//    	       "IP": {label: "IP"}, "VPC": {label: "VPC"}, "Volume": {label: "Volume"},"PrimaryStorage": {label: "PrimaryStorage"}, "SecondaryStorage": {label: "SecondaryStorage"},
//
//    	     };

    $scope.quotaLimits = [];
    $scope.networkQuotaList = [];
    $scope.storageQuotaList = [];
     $scope.showLoaderDetail = true;
     var resourceArr = ["Instance","CPU", "Memory","Template","Snapshot", "Network", "IP", "VPC","Volume", "PrimaryStorage", "SecondaryStorage"];

    $scope.getResourceQuotaDetails = function() {
      var  actionURL = "quota";
      $scope.quotaAction = "domain";
      if(globalConfig.sessionValues.type == "USER") {
          actionURL = "departmentQuota";
      $scope.quotaAction = "department";
      }
      var hasResourceDomainId = promiseAjax.httpTokenRequest( globalConfig.HTTP_GET , globalConfig.APP_URL + "dashboard/" + actionURL);
      hasResourceDomainId.then(function (result) {  // this is only run after $http completes

    	  $scope.showLoaderDetail = false;
         // console.log("Result",result);
            angular.forEach(result, function(obj, key) {
           	 //console.log("Key-",key,"Resource-",obj.resourceType);
           	 if(obj.resourceType == "Instance"){
           		 $scope.addText = function() {
           		        $scope.quotaLimits[0] = obj;
           		        $scope.quotaLimits[0].label= "VM";
           		        $scope.quotaLimits[0].max = parseInt(obj.max);
                           $scope.quotaLimits[0].usedLimit = parseInt(obj.usedLimit);
                           $scope.quotaLimits[0].percentage = parseFloat(parseInt(obj.usedLimit) / parseInt(obj.max) * 100).toFixed(2);
                           if(obj.usedLimit == null || obj.usedLimit == "null" || isNaN(obj.usedLimit)) {
                               obj.usedLimit = 0;
                           }
                          if(resourceArr.indexOf(obj.resourceType) > -1) {
                            if(angular.isUndefined($scope.quotaLimits[0])) {
                                $scope.quotaLimits[0] = {};

                            }
           		    }
                          if(isNaN($scope.quotaLimits[0].percentage)) {
                              $scope.quotaLimits[0].percentage = 0;
                          }

                          var unUsed = $scope.quotaLimits[0].max - $scope.quotaLimits[0].usedLimit;

                          var usedColor = "#48a9da";
                          if($scope.quotaLimits[0].percentage > 79 && $scope.quotaLimits[0].percentage < 90) {
                              usedColor = "#f0ad4e";
                          } else if($scope.quotaLimits[0].percentage > 89){
                              usedColor = "#df6457";
                          }

                          $scope.quotaLimits[0].doughnutData = [
                             {
                             value: parseInt(obj.usedLimit),
                             color: usedColor,
                             highlight: usedColor,
                             label: "Used"
                             },
                             {
                             value: unUsed,
                             color: "#ebf1f4",
                             highlight: "#ebf1f4",
                             label: "UnUsed"
                             }];
                          }
           		 $scope.addText();

           	 }
           	 if(obj.resourceType == "CPU"){
           		 $scope.addText = function() {
        		        $scope.quotaLimits[1] = obj;
       		        $scope.quotaLimits[1].label= "vCPU";
       		        $scope.quotaLimits[1].max = parseInt(obj.max);
                       $scope.quotaLimits[1].usedLimit = parseInt(obj.usedLimit);
                       $scope.quotaLimits[1].percentage = parseFloat(parseInt(obj.usedLimit) / parseInt(obj.max) * 100).toFixed(2);

                       if(obj.usedLimit == null || obj.usedLimit == "null" || isNaN(obj.usedLimit)) {
                           obj.usedLimit = 0;
                       }
                      if(resourceArr.indexOf(obj.resourceType) > -1) {
                        if(angular.isUndefined($scope.quotaLimits[1])) {
                            $scope.quotaLimits[1] = {};

                        }
       		    }
                       if(isNaN($scope.quotaLimits[1].percentage)) {
                           $scope.quotaLimits[1].percentage = 0;
                       }

                       var unUsed = $scope.quotaLimits[1].max - $scope.quotaLimits[1].usedLimit;

                       var usedColor = "#48a9da";
                       if($scope.quotaLimits[1].percentage > 79 && $scope.quotaLimits[1].percentage < 90) {
                           usedColor = "#f0ad4e";
                       } else if($scope.quotaLimits[1].percentage > 89){
                           usedColor = "#df6457";
                       }

                       $scope.quotaLimits[1].doughnutData = [
                          {
                          value: parseInt(obj.usedLimit),
                          color: usedColor,
                          highlight: usedColor,
                          label: "Used"
                          },
                          {
                          value: unUsed,
                          color: "#ebf1f4",
                          highlight: "#ebf1f4",
                          label: "UnUsed"
                          }];

           		    }
           		 $scope.addText();

           	 }
           	 if(obj.resourceType == "Memory"){
           		 $scope.addText = function() {
        		        $scope.quotaLimits[2] = obj;
       		        $scope.quotaLimits[2].label= "Memory";

       		        obj.usedLimit = Math.round( obj.usedLimit / 1024);
                       if (obj.max != -1) {
                                   obj.max = Math.round(obj.max / 1024);
                                   $scope.quotaLimits[2].label = $scope.quotaLimits[2].label + " " + "(GiB)";
                       }

                       $scope.quotaLimits[2].max = parseInt(obj.max);
                       $scope.quotaLimits[2].usedLimit = parseInt(obj.usedLimit);
                       $scope.quotaLimits[2].percentage = parseFloat(parseInt(obj.usedLimit) / parseInt(obj.max) * 100).toFixed(2);

                       if(obj.usedLimit == null || obj.usedLimit == "null" || isNaN(obj.usedLimit)) {
                           obj.usedLimit = 0;
                       }
                      if(resourceArr.indexOf(obj.resourceType) > -1) {
                        if(angular.isUndefined($scope.quotaLimits[2])) {
                            $scope.quotaLimits[2] = {};

                        }
       		    }
                       if(isNaN($scope.quotaLimits[2].percentage)) {
                           $scope.quotaLimits[2].percentage = 0;
                       }

                       var unUsed = $scope.quotaLimits[2].max - $scope.quotaLimits[2].usedLimit;

                       var usedColor = "#48a9da";
                       if($scope.quotaLimits[2].percentage > 79 && $scope.quotaLimits[2].percentage < 90) {
                           usedColor = "#f0ad4e";
                       } else if($scope.quotaLimits[2].percentage > 89){
                           usedColor = "#df6457";
                       }

                       $scope.quotaLimits[2].doughnutData = [
                          {
                          value: parseInt(obj.usedLimit),
                          color: usedColor,
                          highlight: usedColor,
                          label: "Used"
                          },
                          {
                          value: unUsed,
                          color: "#ebf1f4",
                          highlight: "#ebf1f4",
                          label: "UnUsed"
                          }];
           		    }
           		 $scope.addText();

           	 }
           	 if(obj.resourceType == "Template"){
           		 $scope.addText = function() {
        		        $scope.quotaLimits[3] = obj;
       		        $scope.quotaLimits[3].label= "Template";
       		        $scope.quotaLimits[3].max = parseInt(obj.max);
                       $scope.quotaLimits[3].usedLimit = parseInt(obj.usedLimit);
                       $scope.quotaLimits[3].percentage = parseFloat(parseInt(obj.usedLimit) / parseInt(obj.max) * 100).toFixed(2);

                       if(obj.usedLimit == null || obj.usedLimit == "null" || isNaN(obj.usedLimit)) {
                           obj.usedLimit = 0;
                       }
                      if(resourceArr.indexOf(obj.resourceType) > -1) {
                        if(angular.isUndefined($scope.quotaLimits[3])) {
                            $scope.quotaLimits[3] = {};

                        }
       		    }
                       if(isNaN($scope.quotaLimits[3].percentage)) {
                           $scope.quotaLimits[3].percentage = 0;
                       }

                       var unUsed = $scope.quotaLimits[3].max - $scope.quotaLimits[3].usedLimit;

                       var usedColor = "#48a9da";
                       if($scope.quotaLimits[3].percentage > 79 && $scope.quotaLimits[3].percentage < 90) {
                           usedColor = "#f0ad4e";
                       } else if($scope.quotaLimits[3].percentage > 89){
                           usedColor = "#df6457";
                       }

                       $scope.quotaLimits[3].doughnutData = [
                          {
                          value: parseInt(obj.usedLimit),
                          color: usedColor,
                          highlight: usedColor,
                          label: "Used"
                          },
                          {
                          value: unUsed,
                          color: "#ebf1f4",
                          highlight: "#ebf1f4",
                          label: "UnUsed"
                          }];

           		    }
           		 $scope.addText();

           	 }
           	 if(obj.resourceType == "Snapshot"){
           		 $scope.addText = function() {
        		        $scope.quotaLimits[4] = obj;
       		        $scope.quotaLimits[4].label= "Snapshot";
       		        $scope.quotaLimits[4].max = parseInt(obj.max);
                       $scope.quotaLimits[4].usedLimit = parseInt(obj.usedLimit);
                       $scope.quotaLimits[4].percentage = parseFloat(parseInt(obj.usedLimit) / parseInt(obj.max) * 100).toFixed(2);

                       if(obj.usedLimit == null || obj.usedLimit == "null" || isNaN(obj.usedLimit)) {
                           obj.usedLimit = 0;
                       }
                      if(resourceArr.indexOf(obj.resourceType) > -1) {
                        if(angular.isUndefined($scope.quotaLimits[4])) {
                            $scope.quotaLimits[4] = {};

                        }
       		    }
                       if(isNaN($scope.quotaLimits[4].percentage)) {
                           $scope.quotaLimits[4].percentage = 0;
                       }

                       var unUsed = $scope.quotaLimits[4].max - $scope.quotaLimits[4].usedLimit;

                       var usedColor = "#48a9da";
                       if($scope.quotaLimits[4].percentage > 79 && $scope.quotaLimits[4].percentage < 90) {
                           usedColor = "#f0ad4e";
                       } else if($scope.quotaLimits[4].percentage > 89){
                           usedColor = "#df6457";
                       }

                       $scope.quotaLimits[4].doughnutData = [
                          {
                          value: parseInt(obj.usedLimit),
                          color: usedColor,
                          highlight: usedColor,
                          label: "Used"
                          },
                          {
                          value: unUsed,
                          color: "#ebf1f4",
                          highlight: "#ebf1f4",
                          label: "UnUsed"
                          }];

           		    }
           		 $scope.addText();

           	 }

           	 if(obj.resourceType == "Network"){
           		 $scope.addText = function() {
        		        $scope.networkQuotaList[0] = obj;
       		        $scope.networkQuotaList[0].label= "Network";
       		        $scope.networkQuotaList[0].max = parseInt(obj.max);
                       $scope.networkQuotaList[0].usedLimit = parseInt(obj.usedLimit);
                       $scope.networkQuotaList[0].percentage = parseFloat(parseInt(obj.usedLimit) / parseInt(obj.max) * 100).toFixed(2);

                       if(obj.usedLimit == null || obj.usedLimit == "null" || isNaN(obj.usedLimit)) {
                           obj.usedLimit = 0;
                       }
                      if(resourceArr.indexOf(obj.resourceType) > -1) {
                        if(angular.isUndefined($scope.networkQuotaList[0])) {
                            $scope.networkQuotaList[0] = {};

                        }
       		    }
                       if(isNaN($scope.networkQuotaList[0].percentage)) {
                           $scope.networkQuotaList[0].percentage = 0;
                       }

                       var unUsed = $scope.networkQuotaList[0].max - $scope.networkQuotaList[0].usedLimit;

                       var usedColor = "#48a9da";
                       if($scope.networkQuotaList[0].percentage > 79 && $scope.networkQuotaList[0].percentage < 90) {
                           usedColor = "#f0ad4e";
                       } else if($scope.networkQuotaList[0].percentage > 89){
                           usedColor = "#df6457";
                       }

                       $scope.networkQuotaList[0].doughnutData = [
                          {
                          value: parseInt(obj.usedLimit),
                          color: usedColor,
                          highlight: usedColor,
                          label: "Used"
                          },
                          {
                          value: unUsed,
                          color: "#ebf1f4",
                          highlight: "#ebf1f4",
                          label: "UnUsed"
                          }];

           		    }
           		 $scope.addText();

           	 }
           	 if(obj.resourceType == "IP"){
           		 $scope.addText = function() {
         		        $scope.networkQuotaList[1] = obj;
         		      $scope.networkQuotaList[1].label= "IP";
     		        $scope.networkQuotaList[1].max = parseInt(obj.max);
                     $scope.networkQuotaList[1].usedLimit = parseInt(obj.usedLimit);
                     $scope.networkQuotaList[1].percentage = parseFloat(parseInt(obj.usedLimit) / parseInt(obj.max) * 100).toFixed(2);

                     if(obj.usedLimit == null || obj.usedLimit == "null" || isNaN(obj.usedLimit)) {
                         obj.usedLimit = 0;
                     }
                    if(resourceArr.indexOf(obj.resourceType) > -1) {
                      if(angular.isUndefined($scope.networkQuotaList[1])) {
                          $scope.networkQuotaList[1] = {};

                      }
     		    }
                     if(isNaN($scope.networkQuotaList[1].percentage)) {
                         $scope.networkQuotaList[1].percentage = 0;
                     }

                     var unUsed = $scope.networkQuotaList[1].max - $scope.networkQuotaList[1].usedLimit;

                     var usedColor = "#48a9da";
                     if($scope.networkQuotaList[1].percentage > 79 && $scope.networkQuotaList[1].percentage < 90) {
                         usedColor = "#f0ad4e";
                     } else if($scope.networkQuotaList[1].percentage > 89){
                         usedColor = "#df6457";
                     }

                     $scope.networkQuotaList[1].doughnutData = [
                        {
                        value: parseInt(obj.usedLimit),
                        color: usedColor,
                        highlight: usedColor,
                        label: "Used"
                        },
                        {
                        value: unUsed,
                        color: "#ebf1f4",
                        highlight: "#ebf1f4",
                        label: "UnUsed"
                        }];
           		    }
           		 $scope.addText();

           	 }
           	 if(obj.resourceType == "VPC"){
           		 $scope.addText = function() {
         		        $scope.networkQuotaList[2] = obj;
         		      $scope.networkQuotaList[2].label= "VPC";
     		        $scope.networkQuotaList[2].max = parseInt(obj.max);
                     $scope.networkQuotaList[2].usedLimit = parseInt(obj.usedLimit);
                     $scope.networkQuotaList[2].percentage = parseFloat(parseInt(obj.usedLimit) / parseInt(obj.max) * 100).toFixed(2);

                     if(obj.usedLimit == null || obj.usedLimit == "null" || isNaN(obj.usedLimit)) {
                         obj.usedLimit = 0;
                     }
                    if(resourceArr.indexOf(obj.resourceType) > -1) {
                      if(angular.isUndefined($scope.networkQuotaList[2])) {
                          $scope.networkQuotaList[2] = {};

                      }
     		    }
                     if(isNaN($scope.networkQuotaList[2].percentage)) {
                         $scope.networkQuotaList[2].percentage = 0;
                     }

                     var unUsed = $scope.networkQuotaList[2].max - $scope.networkQuotaList[2].usedLimit;

                     var usedColor = "#48a9da";
                     if($scope.networkQuotaList[2].percentage > 79 && $scope.networkQuotaList[2].percentage < 90) {
                         usedColor = "#f0ad4e";
                     } else if($scope.networkQuotaList[2].percentage > 89){
                         usedColor = "#df6457";
                     }

                     $scope.networkQuotaList[2].doughnutData = [
                        {
                        value: parseInt(obj.usedLimit),
                        color: usedColor,
                        highlight: usedColor,
                        label: "Used"
                        },
                        {
                        value: unUsed,
                        color: "#ebf1f4",
                        highlight: "#ebf1f4",
                        label: "UnUsed"
                        }];
           		    }
           		 $scope.addText();

           	 }

           	 if(obj.resourceType == "Volume"){
           		 $scope.addText = function() {

         		        $scope.storageQuotaList[0] = obj;
        		        $scope.storageQuotaList[0].label= "Volume";
        		        $scope.storageQuotaList[0].max = parseInt(obj.max);
                        $scope.storageQuotaList[0].usedLimit = parseInt(obj.usedLimit);
                        $scope.storageQuotaList[0].percentage = parseFloat(parseInt(obj.usedLimit) / parseInt(obj.max) * 100).toFixed(2);

                        if(obj.usedLimit == null || obj.usedLimit == "null" || isNaN(obj.usedLimit)) {
                            obj.usedLimit = 0;
                        }
                       if(resourceArr.indexOf(obj.resourceType) > -1) {
                         if(angular.isUndefined($scope.storageQuotaList[0])) {
                             $scope.storageQuotaList[0] = {};

                         }
        		    }
                        if(isNaN($scope.storageQuotaList[0].percentage)) {
                            $scope.storageQuotaList[0].percentage = 0;
                        }

                        var unUsed = $scope.storageQuotaList[0].max - $scope.storageQuotaList[0].usedLimit;

                        var usedColor = "#48a9da";
                        if($scope.storageQuotaList[0].percentage > 79 && $scope.storageQuotaList[0].percentage < 90) {
                            usedColor = "#f0ad4e";
                        } else if($scope.storageQuotaList[0].percentage > 89){
                            usedColor = "#df6457";
                        }

                        $scope.storageQuotaList[0].doughnutData = [
                           {
                           value: parseInt(obj.usedLimit),
                           color: usedColor,
                           highlight: usedColor,
                           label: "Used"
                           },
                           {
                           value: unUsed,
                           color: "#ebf1f4",
                           highlight: "#ebf1f4",
                           label: "UnUsed"
                           }];

            		            		    }
           		 $scope.addText();

           	 }
           	 if(obj.resourceType == "PrimaryStorage"){
           		 $scope.addText = function() {
         		        $scope.storageQuotaList[1] = obj;
         		        $scope.storageQuotaList[1].label = "Primary Storage";
         		      if (obj.max == -1 && obj.resourceType == "PrimaryStorage" || obj.max == -1 && obj.resourceType == "SecondaryStorage") {
                         // obj.usedLimit = Math.round( obj.usedLimit / (1024 * 1024 * 1024));
                $scope.storageQuotaList[1].label = $scope.storageQuotaList[1].label + " " + "(GiB)";
             }

         		    $scope.storageQuotaList[1].max = parseInt(obj.max);
                   $scope.storageQuotaList[1].usedLimit = parseInt(obj.usedLimit);
                   $scope.storageQuotaList[1].percentage = parseFloat(parseInt(obj.usedLimit) / parseInt(obj.max) * 100).toFixed(2);

                   if(obj.usedLimit == null || obj.usedLimit == "null" || isNaN(obj.usedLimit)) {
                       obj.usedLimit = 0;
                   }
                  if(resourceArr.indexOf(obj.resourceType) > -1) {
                    if(angular.isUndefined($scope.storageQuotaList[1])) {
                        $scope.storageQuotaList[1] = {};

                    }
   		    }
                   if(isNaN($scope.storageQuotaList[1].percentage)) {
                       $scope.storageQuotaList[1].percentage = 0;
                   }

                   var unUsed = $scope.storageQuotaList[1].max - $scope.storageQuotaList[1].usedLimit;

                   var usedColor = "#48a9da";
                   if($scope.storageQuotaList[1].percentage > 79 && $scope.storageQuotaList[1].percentage < 90) {
                       usedColor = "#f0ad4e";
                   } else if($scope.storageQuotaList[1].percentage > 89){
                       usedColor = "#df6457";
                   }

                   $scope.storageQuotaList[1].doughnutData = [
                      {
                      value: parseInt(obj.usedLimit),
                      color: usedColor,
                      highlight: usedColor,
                      label: "Used"
                      },
                      {
                      value: unUsed,
                      color: "#ebf1f4",
                      highlight: "#ebf1f4",
                      label: "UnUsed"
                      }];
           		    }
           		 $scope.addText();

           	 }
           	 if(obj.resourceType == "SecondaryStorage"){
           		 $scope.addText = function() {
         		        $scope.storageQuotaList[2] = obj;
         		      $scope.storageQuotaList[2].label = "Secondary Storage";
         		      if (obj.max == -1 && obj.resourceType == "PrimaryStorage" || obj.max == -1 && obj.resourceType == "SecondaryStorage") {
                         // obj.usedLimit = Math.round( obj.usedLimit / (1024 * 1024 * 1024));
                $scope.storageQuotaList[2].label = $scope.storageQuotaList[2].label + " " + "(GiB)";
             }

         		    $scope.storageQuotaList[2].max = parseInt(obj.max);
                   $scope.storageQuotaList[2].usedLimit = parseInt(obj.usedLimit);
                   $scope.storageQuotaList[2].percentage = parseFloat(parseInt(obj.usedLimit) / parseInt(obj.max) * 100).toFixed(2);

                   if(obj.usedLimit == null || obj.usedLimit == "null" || isNaN(obj.usedLimit)) {
                       obj.usedLimit = 0;
                   }
                  if(resourceArr.indexOf(obj.resourceType) > -1) {
                    if(angular.isUndefined($scope.storageQuotaList[2])) {
                        $scope.storageQuotaList[2] = {};

                    }
   		    }
                   if(isNaN($scope.storageQuotaList[2].percentage)) {
                       $scope.storageQuotaList[2].percentage = 0;
                   }

                   var unUsed = $scope.storageQuotaList[2].max - $scope.storageQuotaList[2].usedLimit;

                   var usedColor = "#48a9da";
                   if($scope.storageQuotaList[2].percentage > 79 && $scope.storageQuotaList[2].percentage < 90) {
                       usedColor = "#f0ad4e";
                   } else if($scope.storageQuotaList[2].percentage > 89){
                       usedColor = "#df6457";
                   }

                   $scope.storageQuotaList[2].doughnutData = [
                      {
                      value: parseInt(obj.usedLimit),
                      color: usedColor,
                      highlight: usedColor,
                      label: "Used"
                      },
                      {
                      value: unUsed,
                      color: "#ebf1f4",
                      highlight: "#ebf1f4",
                      label: "UnUsed"
                      }];
           		    }
           		 $scope.addText();

           	 }
            });

        });
    }



    $scope.checkOne = true;
    $scope.appLanguage = function() {
        if(localStorageService.cookie.get('language') == null) {
            var hasConfigs = appService.crudService.listAll("generalconfiguration/configlist");
            hasConfigs.then(function (result) {
                $scope.generalconfiguration = result[0];
                if ($scope.generalconfiguration.defaultLanguage == 'Chinese') {
                    localStorageService.cookie.set('language', 'zh');
                } else {
                    localStorageService.cookie.set('language', 'en');
                }
            });
        }
        return localStorageService.cookie.get('language');
    }();

    /**
     * Sparkline bar chart data and options used in under Profile image on left navigation panel
     */

    $scope.barProfileData = [5, 6, 7, 2, 0, 4, 2, 4, 5, 7, 2, 4, 12, 11, 4];
    $scope.barProfileOptions = {
        type: 'bar',
        barWidth: 7,
        height: '30px',
        barColor: '#48a9da',
        negBarColor: '#157db0'
    };

        /**
     * Options for Doughnut chart
     */
    $scope.doughnutOptions = {
        segmentShowStroke: true,
        segmentStrokeColor: "#fff",
        segmentStrokeWidth: 0,
        percentageInnerCutout: 85, // This is 0 for Pie charts
        animationSteps: 100,
        animationEasing: "easeOutBounce",
        animateRotate: false,
        animateScale: false,

customTooltips: function customTooltips(tooltip){

            // Tooltip Element
            var tooltipEl = $('#chartjs-customtooltip');

            // Make the element if not available
            if (!tooltipEl[0]) {
                $('body').append('<div id="chartjs-customtooltip"></div>');
                tooltipEl = $('#chartjs-customtooltip');
            }

            // Hide if no tooltip
            if (!tooltip) {
                tooltipEl.css({
                    opacity: 0
                });
                return;
            }

            // Set caret Position
            tooltipEl.removeClass('above below no-transform');
            if (tooltip.yAlign) {
                tooltipEl.addClass(tooltip.yAlign);
            } else {
                tooltipEl.addClass('no-transform');
            }

            // Set Text
            if (tooltip.text) {
                tooltipEl.html(tooltip.text);
            } else {
                var innerHtml = '<div class="title">' + tooltip.title + '</div>';
                for (var i = 0; i < tooltip.labels.length; i++) {
                    innerHtml += [
                        '<div class="section">',
                        '   <span class="key" style="background-color:' + tooltip.legendColors[i].fill + '"></span>',
                        '   <span class="value">' + tooltip.labels[i] + '</span>',
                        '</div>'
                    ].join('');
                }
                tooltipEl.html(innerHtml);
            }

            // Find Y Location on page
            var top = 0;
            if (tooltip.yAlign) {
                if (tooltip.yAlign == 'above') {
                    top = tooltip.y - tooltip.caretHeight - tooltip.caretPadding;
                } else {
                    top = tooltip.y + tooltip.caretHeight + tooltip.caretPadding;
                }
            }

            var offset = $(tooltip.chart.canvas).offset();

            // Display, position, and set styles for font
            tooltipEl.css({
                opacity: 1,
                width: tooltip.width ? (tooltip.width + 'px') : 'auto',
                left: offset.left + tooltip.x + 'px',
                top: offset.top + top + 'px',
                fontFamily: tooltip.fontFamily,
                fontSize: tooltip.fontSize,
                fontStyle: tooltip.fontStyle,
            });
        }
    };


    $scope.singleBarChartOptions = {
        scaleBeginAtZero: true,
        scaleShowGridLines: true,
        scaleGridLineColor: "rgba(0,0,0,.05)",
        scaleGridLineWidth: 1,
        barShowStroke: true,
        barStrokeWidth: 1,
        barValueSpacing: 30,
        barDatasetSpacing: 1,
        tooltipTemplate: "¥ <%= value %>",
        showTooltips: true

    };

    // Project Summary
    $scope.projectSummaryData = {
        labels: ["jamseer_project", "AZ test project", "AZ Panda", "AZ Jadeart"],
        datasets: [
            {
                label: "My Second dataset",
                fillColor: "rgba(72,169,218,0.5)",
                strokeColor: "rgba(72,169,218,0.8)",
                highlightFill: "rgba(72,169,218,0.75)",
                highlightStroke: "rgba(72,169,218,1)",
                data: [15, 20, 32, 40]

            }
        ]
    };


    $scope.getProjectDetails = function () {
        $scope.showProjectLoader = true;
        $timeout(function () {
            $scope.showProjectLoader = false;
        }, 400);

    };


    $scope.filterBy = function () {
        $scope.showLoader = true;
        $timeout(function () {
            $scope.showLoader = false;
        }, 400);
    };

    $scope.filterByApplication = function () {
        $scope.showLoader = true;
        $timeout(function () {
            $scope.showLoader = false;
        }, 400);
    };


    $scope.filterByDepartment = function () {
        $scope.showDeptLoader = true;
        $timeout(function () {
            $scope.showDeptLoader = false;
        }, 400);
    };


    $scope.dahboardSummaryData = {
        labels: ["Instance(5)", "VM Snapshot(10)", "Volume(10)", "Vol Snapshot(10)", "Floating Ips(10)"],
        datasets: [
            {
                label: "My Second dataset",
                fillColor: "rgba(72,169,218,0.5)",
                strokeColor: "rgba(72,169,218,0.8)",
                highlightFill: "rgba(72,169,218,0.75)",
                highlightStroke: "rgba(72,169,218,1)",
                data: [100, 200, 300, 270, 150]
            }
        ]
    };

    $scope.chartIncomeData = [
        {
            label: "line",
            data: [[1, 10], [2, 26], [3, 16], [4, 36], [5, 32], [6, 51]]
        }
    ];

    $scope.chartIncomeOptions = {
        series: {
            lines: {
                show: true,
                lineWidth: 0,
                fill: true,
                fillColor: "#64cc34"

            }
        },
        colors: ["#62cb31"],
        grid: {
            show: false
        },
        legend: {
            show: false
        }
    };


    /**
     *  Global configuration goes here
     */
    $scope.global = globalConfig;
    $scope.date = new Date();

    // Dashboard Projects
    $scope.projectList = {};
    var hasServer = promiseAjax.httpRequest("GET", "api/project.json");
    hasServer.then(function (result) {  // this is only run after $http completes
        $scope.projectList = result;

    });


    $scope.applicationList = {};
    $scope.listing = {
      department: true,
      departmentList: [],
      applicaiton: false,
      applicationList: [],
      userList:[]
    };

    $scope.departmentList = {};
    $scope.getDepartmentList = function(type) {
        $scope.listing.activeDepartment = false;
        $scope.listing.userList = [];
      $scope.listing.groupType = type;
      $scope.listing.application = false;
      $scope.listing.department = true;
      var hasDepartments = promiseAjax.httpTokenRequest( globalConfig.HTTP_GET , globalConfig.APP_URL + "dashboard/departmentByDomain");
      hasDepartments.then(function (result) {  // this is only run after $http completes
          $scope.listing.departmentList = result;
      });
    };


                $scope.showDepartmentLoader = false;
    $scope.getTopDepartmentCostList = function(type) {
      $scope.showDepartmentLoader = true;
            var hasDepartments = promiseAjax.httpTokenRequest( globalConfig.HTTP_GET , globalConfig.APP_URL + "usage/usageByAccount");
      hasDepartments.then(function (result) {  // this is only run after $http completes
                $scope.showDepartmentLoader = false;
$scope.top5DepartmentList = result;


      });
    }


    $scope.showLoader = false;
    $scope.getTopProjectCostList = function(type) {
      $scope.showLoader = true;
      var hasProjects = promiseAjax.httpTokenRequest( globalConfig.HTTP_GET , globalConfig.APP_URL + "usage/usageByProject");
      hasProjects.then(function (result) {  // this is only run after $http completes
          $scope.showLoader = false;
          $scope.top5ProjectList = result;
      });
    }



    $scope.findSubCategoryByDepartment = function(groupType, id) {
      $scope.listing.activeDepartment = id;
      if (groupType == "department") {
          var hasProjects =  appService.promiseAjax.httpTokenRequest(appService.crudService.globalConfig.HTTP_GET,
                     appService.crudService.globalConfig.APP_URL + "projects"  +"/department/"+id);
          hasProjects.then(function (result) {  // this is only run after $http completes0
                $scope.listing.userList = result;
                $scope.type = "Projects";
             });
      } else if (groupType == "user") {
          var hasUsers = promiseAjax.httpTokenRequest( globalConfig.HTTP_GET , globalConfig.APP_URL + "users/department/"+ id);
          hasUsers.then(function (result) {  // this is only run after $http completes
              $scope.listing.userList = result;
              $scope.type = "Users";
          });
      }
    };

    $scope.getApplicationList = function() {
      $scope.listing.department = false;
      $scope.listing.application = true;

      var hasApplicaitons = promiseAjax.httpTokenRequest( globalConfig.HTTP_GET , globalConfig.APP_URL + "dashboard/applicationByDomain");
      hasApplicaitons.then(function (result) {  // this is only run after $http completes
          $scope.listing.applicationList = result;
      });
    };

    $scope.flotChartData = [
        {
            label: "bar",
            data: []
        }
    ];

    $scope.costChartOptions = appService.utilService.getFlotBarOptions();
    $scope.costCharData = appService.utilService.getFlotBarData();
    $scope.showUsageLoader = false;
    $scope.getCostByMonthGraph = function() {
        $scope.showUsageLoader = true;
        var hasProjects = promiseAjax.httpTokenRequest( globalConfig.HTTP_GET , globalConfig.APP_URL + "usage/usageTotalByDomain");
        hasProjects.then(function (result) {  // this is only run after $http completes
          $scope.domainUsateCost = result;
          $scope.showUsageLoader = false;
          var usageData = [];
          var ticks = [];
          var i=0;
          angular.forEach($scope.domainUsateCost, function(obj, key) {
              i++;
              usageData.push([i, obj.cost]);
              ticks.push([i, obj.month]);
          });

          $scope.costChartOptions.xaxis.ticks = ticks;

          /**
           * Bar Chart data
           */
          $scope.costCharData = [
              {
                  label: "bar",
                  data: usageData
              }
          ];
        });
    }

    if(appService.globalConfig.sessionValues.type != "ROOT_ADMIN") {
          $scope.getInfrastructureDetails();
          $scope.getResourceQuotaDetails();
          $scope.getDepartmentList();
          $scope.getTopDepartmentCostList();
          $scope.getTopProjectCostList();
          $scope.getCostByMonthGraph();
      }



    //$scope.applicationList = [{'name': 'Prod.', 'id': 1}, {'name': 'QAS', 'id': 2}, {'name': 'DEV', 'id': 3}, {'name': 'Backup', 'id': 4}, {'name': 'DR', 'id': 5}, {'name': 'Other', 'id': 6}];


    $scope.updateLanguage = function(language) {
         localStorageService.cookie.set('language', language);
         appService.localStorageService.get('serviceView');
         $window.location.reload();
    }

    /**
     *  Logout a user.
     */
    $scope.logout = function() {
        appService.utilService.logoutApplication("LOGOUT");
    }



  $scope.dashboard = {
      costList: {}
  };
  $scope.toggleCostList = function(type) {
      $scope.dashboard.costList.department = false;
    $scope.dashboard.costList.project = false;
    $scope.dashboard.costList.application = false;
       $scope.dashboard.costList[type] = true;
  }

$scope.getZoneList = function () {
      var hasZones = crudService.listAll("zones/list");
      hasZones.then(function (result) {  // this is only run after $http completes0
          $scope.global.zoneList = result;
      });
  };
  $scope.getZoneList();

  $scope.updatePagination = function (limit) {
      var hasResult = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET,
              appService.globalConfig.APP_URL + "users" +"/paginationLimit/"+limit);
      hasResult.then(function(result) {
          globalConfig.CONTENT_LIMIT = limit;
          var currentSession = JSON.parse($window.sessionStorage.getItem("loginSession"));
          currentSession.paginationLimit = limit;
          $window.sessionStorage.setItem("loginSession", JSON.stringify(currentSession));
      });
  };

  $scope.$on("notification", function(event, args) {
	  $scope.getActivity(1);
	   	 });

}
