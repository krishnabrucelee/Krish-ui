/**
 *
 * appCtrl
 *
 */

angular
        .module('homer')
        .controller('appCtrl', appCtrl);

function appCtrl($http, $scope, $window, $timeout, appService, globalConfig, crudService, promiseAjax, localStorageService, $cookies) {

    // For iCheck purpose only
    $scope.infrastructure = {};
    $scope.showInfrastructureLoader = true;
    var hasResult = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "dashboard/infrastructure");
    hasResult.then(function(result) {  // this is only run after;
        $scope.infrastructure  = result;
        $scope.showInfrastructureLoader = false;
    });

    $scope.quotaLimits = {
      "CPU": {label: "vCPU"}, "Memory": {label: "Memory"}, "Volume": {label: "Volume"}, "Network": {label: "Network"},
      "IP": {label: "IP"}, "PrimaryStorage": {label: "PrimaryStorage"}, "SecondaryStorage": {label: "SecondaryStorage"},
      "Snapshot": {label: "Snapshot"}
    };

    $scope.showQuotaLoader = true;
    var resourceArr = ["CPU", "Memory", "Volume", "Network", "IP", "PrimaryStorage", "SecondaryStorage", "Snapshot"];
    var hasResourceDomainId = promiseAjax.httpTokenRequest( globalConfig.HTTP_GET , globalConfig.APP_URL + "dashboard/quota");
    hasResourceDomainId.then(function (result) {  // this is only run after $http completes
      $scope.showQuotaLoader = false;
        angular.forEach(result, function(obj, key) {
            if(resourceArr.indexOf(obj.resourceType) > -1) {
              if(angular.isUndefined($scope.quotaLimits[obj.resourceType])) {
                  $scope.quotaLimits[obj.resourceType] = {};
              }

              if(obj.resourceType == "Memory") {
                obj.usedLimit = Math.round( obj.usedLimit / 1024);
    						if (obj.max != -1) {
    							obj.max = Math.round(obj.max / 1024);
                  $scope.quotaLimits[obj.resourceType].label = $scope.quotaLimits[obj.resourceType].label + " " + "(GiB)";
    						}
              }

              if (obj.max == -1 && obj.resourceType == "PrimaryStorage" || obj.max == -1 && obj.resourceType == "SecondaryStorage") {
					        obj.usedLimit = Math.round( obj.usedLimit / (1024 * 1024 * 1024));
                  $scope.quotaLimits[obj.resourceType].label = $scope.quotaLimits[obj.resourceType].label + " " + "(GiB)";
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
                      label: "Left"

                  }
              ];
            }
        });
    });

    $scope.checkOne = true;
    $scope.appLanguage = function() {
        if(localStorageService.cookie.get('language') == null) {
            localStorageService.cookie.set('language', 'en');
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
        animateScale: false
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
    $scope.getDepartmentList();

    $scope.showTopDeptLoader = false;
    $scope.getTopDepartmentCostList = function(type) {
      $scope.showTopDeptLoader = true;
      var hasDepartments = promiseAjax.httpTokenRequest( globalConfig.HTTP_GET , globalConfig.APP_URL + "usage/usageByAccount");
      hasDepartments.then(function (result) {  // this is only run after $http completes
          $scope.showTopDeptLoader = false;
          $scope.top5DepartmentList = result;
      });
    }
    $scope.getTopDepartmentCostList();

    $scope.showTopProjectLoader = false;
    $scope.getTopProjectCostList = function(type) {
      $scope.showTopProjectLoader = true;
      var hasProjects = promiseAjax.httpTokenRequest( globalConfig.HTTP_GET , globalConfig.APP_URL + "usage/usageByProject");
      hasProjects.then(function (result) {  // this is only run after $http completes
          $scope.showTopProjectLoader = false;
          $scope.top5ProjectList = result;
      });
    }
    $scope.getTopProjectCostList();


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
    $scope.getCostByMonthGraph();



    //$scope.applicationList = [{'name': 'Prod.', 'id': 1}, {'name': 'QAS', 'id': 2}, {'name': 'DEV', 'id': 3}, {'name': 'Backup', 'id': 4}, {'name': 'DR', 'id': 5}, {'name': 'Other', 'id': 6}];


    $scope.updateLanguage = function(language) {
        if(localStorageService.cookie.get('language') == 'en') {
            localStorageService.cookie.set('language', 'zh');
        } else {
            localStorageService.cookie.set('language', 'en');
        }
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

}
