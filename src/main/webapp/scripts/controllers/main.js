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
    $scope.paginationObject = {};
    $scope.sort = appService.globalConfig.sort;
    $scope.paginationObject.sortOrder = '-';
    $scope.paginationObject.sortBy = 'eventDateTime';

    // For iCheck purpose only
    $scope.infrastructure = {};
    $scope.showInfrastructureLoader = true;


    $scope.getActivity = function (pageNumber) {
	appService.globalConfig.sort.sortOrder = $scope.paginationObject.sortOrder;
    appService.globalConfig.sort.sortBy = $scope.paginationObject.sortBy;
    var limit = 10;
        var hasactionServer = appService.promiseAjax.httpTokenRequest($scope.global.HTTP_GET, $scope.global.APP_URL + "events/list/read-event" +"?lang=" + localStorageService.cookie.get('language') + "&sortBy="+appService.globalConfig.sort.sortOrder+appService.globalConfig.sort.sortBy+"&limit=10", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
        hasactionServer.then(function (result) {  // this is only run after $http completes
            if(result.length>0){
        	$scope.activityList = result[0];
            var msg = result[0].message;
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
    $scope.activityList.category = $scope.currentActivity.category;
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



    $scope.getInfrastructureDetails = function() {
      var hasResult = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "dashboard/infrastructure");
      hasResult.then(function(result) {  // this is only run after;
          $scope.infrastructure  = result;
          $scope.showInfrastructureLoader = false;
      });
    }

$scope.themeSettingList = function () {
		return $http({method:'get', url:  REQUEST_PROTOCOL+ $window.location.hostname +':8080/home/list'})
		.then(function(result){
			$scope.themeSettings = result;
			 $scope.welcomeContentUser = result.data.welcomeContentUser;
			 $scope.footerContent = result.data.footerContent;
			 $scope.splashTitleUser= result.data.splashTitleUser;
			 $cookies.splashTitleUser = result.data.splashTitleUser;
		});
	};
	$scope.themeSettingList();


    $scope.quotaLimits = {
      "CPU": {label: "vCPU"}, "Memory": {label: "Memory"}, "Volume": {label: "Volume"}, "Network": {label: "Network"},
      "IP": {label: "IP"}, "PrimaryStorage": {label: "PrimaryStorage"}, "SecondaryStorage": {label: "SecondaryStorage"},
      "Snapshot": {label: "Snapshot"}
    };

    $scope.showQuotaLoader = true;
    var resourceArr = ["CPU", "Memory", "Volume", "Network", "IP", "PrimaryStorage", "SecondaryStorage", "Snapshot"];

    $scope.getResourceQuotaDetails = function() {
      var  actionURL = "quota";
      $scope.quotaAction = "domain";
      if(globalConfig.sessionValues.type == "USER") {
    	  actionURL = "departmentQuota";
	  $scope.quotaAction = "department";
      }
      var hasResourceDomainId = promiseAjax.httpTokenRequest( globalConfig.HTTP_GET , globalConfig.APP_URL + "dashboard/" + actionURL);
      hasResourceDomainId.then(function (result) {  // this is only run after $http completes
        $scope.showQuotaLoader = false;
          angular.forEach(result, function(obj, key) {
        	  if(obj.usedLimit == null || obj.usedLimit == "null" || isNaN(obj.usedLimit)) {
        		  obj.usedLimit = 0;
        	  }
              if(resourceArr.indexOf(obj.resourceType) > -1) {
                if(angular.isUndefined($scope.quotaLimits[obj.resourceType])) {
                    $scope.quotaLimits[obj.resourceType] = {};
                }

                if(obj.resourceType == "Memory") {
                  obj.usedLimit = Math.round( obj.usedLimit / 1024);
			if (obj.max != -1) {
      							obj.max = Math.round(obj.max / 1024);
                    $scope.quotaLimits[obj.resourceType].label = $scope.quotaLimits[obj.resourceType].label + " " + "(GB)";
      						}
                }

                if (obj.max == -1 && obj.resourceType == "PrimaryStorage" || obj.max == -1 && obj.resourceType == "SecondaryStorage") {
  					        obj.usedLimit = Math.round( obj.usedLimit / (1024 * 1024 * 1024));
                    $scope.quotaLimits[obj.resourceType].label = $scope.quotaLimits[obj.resourceType].label + " " + "(GB)";
     				    }

                $scope.quotaLimits[obj.resourceType].max = parseInt(obj.max);
                $scope.quotaLimits[obj.resourceType].usedLimit = parseInt(obj.usedLimit);
                $scope.quotaLimits[obj.resourceType].percentage = parseFloat(parseInt(obj.usedLimit) / parseInt(obj.max) * 100).toFixed(2);
                var unUsed = $scope.quotaLimits[obj.resourceType].max - $scope.quotaLimits[obj.resourceType].usedLimit;


                var usedColor = "#48a9da";
                if($scope.quotaLimits[obj.resourceType].percentage > 79 && $scope.quotaLimits[obj.resourceType].percentage < 90) {
                    usedColor = "#f0ad4e";
                } else if($scope.quotaLimits[obj.resourceType].percentage > 89){
                    usedColor = "#df6457";
                }
                $scope.quotaLimits[obj.resourceType].doughnutData = [
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
                        label: "Unused"

                    }
                ];
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
        $scope.showAppLoader = true;
        $timeout(function () {
            $scope.showAppLoader = false;
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


    $scope.showTopDeptLoader = false;
    $scope.getTopDepartmentCostList = function(type) {
      $scope.showTopDeptLoader = true;
      var hasDepartments = promiseAjax.httpTokenRequest( globalConfig.HTTP_GET , globalConfig.APP_URL + "usage/usageByAccount");
      hasDepartments.then(function (result) {  // this is only run after $http completes
          $scope.showTopDeptLoader = false;
          $scope.top5DepartmentList = result;
      });
    }


    $scope.showTopProjectLoader = false;
    $scope.getTopProjectCostList = function(type) {
      $scope.showTopProjectLoader = true;
      var hasProjects = promiseAjax.httpTokenRequest( globalConfig.HTTP_GET , globalConfig.APP_URL + "usage/usageByProject");
      hasProjects.then(function (result) {  // this is only run after $http completes
          $scope.showTopProjectLoader = false;
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
    $scope.showCostByMonthLoader = false;
    $scope.getCostByMonthGraph = function() {
        $scope.showCostByMonthLoader = true;
        var hasProjects = promiseAjax.httpTokenRequest( globalConfig.HTTP_GET , globalConfig.APP_URL + "usage/usageTotalByDomain");
        hasProjects.then(function (result) {  // this is only run after $http completes
          $scope.domainUsateCost = result;
          $scope.showCostByMonthLoader = false;
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
