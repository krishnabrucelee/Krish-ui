/**
 *
 * appCtrl
 *
 */

angular
        .module('homer')
        .controller('appCtrl', appCtrl);

function appCtrl($http, $scope, $window, $timeout, globalConfig, crudService, promiseAjax, localStorageService, $cookies) {

    // For iCheck purpose only

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
     * Data for Doughnut chart
     */
    $scope.doughnutData = [
        {
            value: 20,
            color: "#eee",
            highlight: "#ccc",
            label: "UnUsed"
        },
        {
            value: 80,
            color: "#48a9da",
            highlight: "#157db0",
            label: "Used"
        }
    ];

$scope.doughnutData1 = [
        {
            value: 42,
            color: "#f0ad4e",
            highlight: "#f0ad4e",
            label: "Used"
   
        },
        {
            value: 58,
            color: "#ebf1f4",
            highlight: "#ebf1f4",
            label: "UnUsed"
        }
    ];

$scope.doughnutData2 = [
	{
            value: 73,
            color: "#f0ad4e",
            highlight: "#f0ad4e",
            label: "Used"
        },
        {
            value: 17,
            color: "#ebf1f4",
            highlight: "#ebf1f4",
            label: "UnUsed"
        }
        
    ];
$scope.doughnutData3 = [
	{
            value: 22,
            color: "#48a9da",
            highlight: "#48a9da",
            label: "Used"
        },
        {
            value: 78,
            color: "#ebf1f4",
            highlight: "#ebf1f4",
            label: "UnUsed"
        }
        
    ];
$scope.doughnutData4 = [
	{
            value: 88,
            color: "#df6457",
            highlight: "#df6457",
            label: "Used"
        },
        {
            value: 12,
            color: "#ebf1f4",
            highlight: "#ebf1f4",
            label: "UnUsed"
        }
        
    ];	


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
     * Tooltips and Popover - used for tooltips in components view
     */
    $scope.dynamicTooltip = 'Hello, World!';
    $scope.htmlTooltip = "I\'ve been made <b>bold</b>!";
    $scope.dynamicTooltipText = 'Dynamic';
    $scope.dynamicPopover = 'Hello, World!';
    $scope.dynamicPopoverTitle = 'Title';

    /**
     * Pagination - used for pagination in components view
     */
    $scope.totalItems = 64;
    $scope.currentPage = 4;

    $scope.setPage = function (pageNo) {
        $scope.currentPage = pageNo;
    };

    /**
     * Typehead - used for typehead in components view
     */
    $scope.states = ['Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California', 'Colorado', 'Connecticut', 'Delaware', 'Florida', 'Georgia', 'Hawaii', 'Idaho', 'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana', 'Maine', 'Maryland', 'Massachusetts', 'Michigan', 'Minnesota', 'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'Nevada', 'New Hampshire', 'New Jersey', 'New Mexico', 'New York', 'North Dakota', 'North Carolina', 'Ohio', 'Oklahoma', 'Oregon', 'Pennsylvania', 'Rhode Island', 'South Carolina', 'South Dakota', 'Tennessee', 'Texas', 'Utah', 'Vermont', 'Virginia', 'Washington', 'West Virginia', 'Wisconsin', 'Wyoming'];
    // Any function returning a promise object can be used to load values asynchronously
    $scope.getLocation = function (val) {
        return $http.get('http://maps.googleapis.com/maps/api/geocode/json', {
            params: {
                address: val,
                sensor: false
            }
        }).then(function (response) {
            return response.data.results.map(function (item) {
                return item.formatted_address;
            });
        });
    };

    /**
     * Rating - used for rating in components view
     */
    $scope.rate = 7;
    $scope.max = 10;

    $scope.hoveringOver = function (value) {
        $scope.overStar = value;
        $scope.percent = 100 * Project(value / this.max);
    };

    /**
     * groups - used for Collapse panels in Tabs and Panels view
     */
    $scope.groups = [
        {
            title: 'Dynamic Group Header - 1',
            content: 'A wonderful serenity has taken possession of my entire soul, like these sweet mornings of spring which I enjoy with my whole heart. I am alone, and feel the charm of existence in this spot, which was created for the bliss of souls like mine. '
        },
        {
            title: 'Dynamic Group Header - 2',
            content: 'A wonderful serenity has taken possession of my entire soul, like these sweet mornings of spring which I enjoy with my whole heart. I am alone, and feel the charm of existence in this spot, which was created for the bliss of souls like mine. '
        }
    ];

    $scope.oneAtATime = true;

    $scope.criteria = [
        {id: 1, name: 'This Month', value: "Current Month"},
        {id: 2, name: 'Last Month', value: "Last Month"},
        {id: 3, name: 'Last 3 Months', value: "Last 3 Months"},
        {id: 4, name: 'Last 6 Months', value: "Last 6 Months"},
        {id: 5, name: "Last 9 Months", value: "Last 9 Months"},
        {id: 6, name: "Last 12 Months", value: "Last 12 Months"},
        {id: 7, name: "All", value: "All Time"}
    ];

    /**
     * Some Flot chart data and options used in Home
     */

    var data1 = [[0, 55], [1, 48], [2, 40], [3, 36], [4, 40], [5, 60], [6, 50], [7, 51]];
    var data2 = [[0, 56], [1, 49], [2, 41], [3, 38], [4, 46], [5, 67], [6, 57], [7, 59]];

    $scope.chartUsersData = [data1, data2];
    $scope.chartUsersOptions = {
        series: {
            splines: {
                show: true,
                tension: 0.4,
                lineWidth: 1,
                fill: 0.4
            },
        },
        grid: {
            tickColor: "#f0f0f0",
            borderWidth: 1,
            borderColor: 'f0f0f0',
            color: '#6a6c6f'
        },
        colors: ["#62cb31", "#efefef"],
    };

    $scope.stanimation = 'bounceIn';
    $scope.runIt = true;
    $scope.runAnimation = function () {

        $scope.runIt = false;
        $timeout(function () {
            $scope.runIt = true;
        }, 100)

    };

    /**
     *  Global configuration goes here
     */
    $scope.global = globalConfig;
    $scope.date = new Date();

    // Dashboard Activity
    $scope.recentActivityList = {};
    var hasServer = promiseAjax.httpRequest("GET", "api/activity-events.json");
    hasServer.then(function (result) {  // this is only run after $http completes
        $scope.recentActivityList = result;

    });

    // Dashboard Activity
    $scope.ticketList = {};
    var hasServer = promiseAjax.httpRequest("GET", "api/tickets.json");
    hasServer.then(function (result) {  // this is only run after $http completes
        $scope.ticketList = result;

    });

    // Dashboard Projects
    $scope.projectList = {};
    var hasServer = promiseAjax.httpRequest("GET", "api/project.json");
    hasServer.then(function (result) {  // this is only run after $http completes
        $scope.projectList = result;

    });

    $scope.departmentList = {};
    var hasServer = promiseAjax.httpRequest("GET", "api/department.json");
    hasServer.then(function (result) {  // this is only run after $http completes
        $scope.departmentList = result;

    });

    $scope.applicationList = [{'name': 'Prod.', 'id': 1}, {'name': 'QAS', 'id': 2}, {'name': 'DEV', 'id': 3}, {'name': 'Backup', 'id': 4}, {'name': 'DR', 'id': 5}, {'name': 'Other', 'id': 6}];


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
    	$http({method:globalConfig.HTTP_GET, url:globalConfig.APP_URL + 'loginHistory/'+$cookies.id,
			"headers": {'x-auth-token': $cookies.token, 'x-requested-with': '', 'Content-Type': 'application/json', 'Range': "items=0-9", 'x-auth-login-token': $cookies.loginToken, 'x-auth-remember': $cookies.rememberMe, 'x-auth-user-id': $cookies.id, 'x-auth-login-time': $cookies.loginTime}})
			.success(function(result){
				$window.sessionStorage.removeItem("loginSession")
		        $cookies.rememberMe = "false";
		        $cookies.loginToken = '0';
		        $cookies.loginTime = '0';
		        window.location.href = "login";
          }).catch(function (result) {
      	        $window.sessionStorage.removeItem("loginSession")
	    	    $cookies.rememberMe = "false";
	            $cookies.loginToken = '0';
	            $cookies.loginTime = '0';
		        window.location.href = "login";
          });
    }

    $scope.getZoneList = function (pageNumber) {
        $scope.paginationObject = {};
      var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
      var hasZones = crudService.list("zones", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
      hasZones.then(function (result) {  // this is only run after $http completes0

          $scope.global.zoneList = result;

          // For pagination
          $scope.paginationObject.limit  = limit;
          $scope.paginationObject.currentPage = pageNumber;
          $scope.paginationObject.totalItems = result.totalItems;
      });
  };
  $scope.getZoneList(1);

}
