/**
 *
 * quotaLimitCtrl
 *
 */
angular
    .module('homer')
    .controller('quotaLimitCtrl', quotaLimitCtrl)
    .controller('quotaReasonCtrl', quotaReasonCtrl)

function quotaReasonCtrl($scope, $modalInstance, userForm, quotaReason, notify) {

    $scope.quotaReason = quotaReason;

    $scope.submitForm = function() {
        if ($scope.form.userForm.$valid) {
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            notify({
                message: 'Request has been sent successfully',
                classes: 'alert-success',
                templateUrl: $scope.homerTemplate
            });
            $modalInstance.close('closed');
        } else {

        }
    };

    $scope.cancel = function() {
        $modalInstance.dismiss('cancel');
    };
};

function quotaLimitCtrl($scope, $state, $stateParams, globalConfig, appService, $window) {

	$scope.global = appService.globalConfig;
	$scope.sort = appService.globalConfig.sort;
	$scope.resourceDomainList = {};
	$scope.resourceQuota = {};
	$scope.resourceTypeList = [ "Instance",
	/** Number of public IP addresses a user can own. */
	"IP",
	/** Number of disk volumes a user can create. */
	"Volume",
	/** Number of snapshots a user can create. */
	"Snapshot",
	/** Number of templates that a user can register/create. */
	"Template",
	/** Number of projects an account can own. */
	"Project",
	/** Number of guest network a user can create. */
	"Network",
	/** Number of VPC a user can create. */
	"VPC",
	/** Total number of CPU cores a user can use. */
	"CPU",
	/** Total Memory (in MB) a user can use. */
	"Memory",
	/** Total primary storage space (in GiB) a user can use. */
	"PrimaryStorage",
	/** Total secondary storage space (in GiB) a user can use. */
	"SecondaryStorage" ];

    // Load domain
    $scope.domain = {};
    $scope.domainList = [];
    var hasDomains = appService.crudService.listAll("domains/list");
    hasDomains.then(function (result) {
    	$scope.domainList = result;
    });



	// Get volume list based on domain selection
    $scope.selectDomainView = function() {
    	$scope.resourceDomainList = {};
    	$scope.getResourceDomain();
    };
	$scope.showForm = function(quotaReason) {
		// $scope.quota = quota;
		var modalInstance = $modal.open({
			templateUrl : 'app/views/cloud/quota/quota-reason.jsp',
			controller : 'quotaReasonCtrl',
			backdrop : 'static',
			keyboard : false,
			scope : $scope,
			resolve : {
				userForm : function() {
					return $scope.userForm;
				},
				quotaReason : function() {
					return quotaReason;
				}
			}
		});
	};

	/**
	 * Resource limit types, used and available mapping to view data.
	 */
	$scope.quotaLimitData = [];
	$scope.resource = {};
	$scope.resourceListMap = function(resourceName, used, max) {
		$scope.resource[resourceName + "Limit"] = {
			"title" : resourceName,
			"options" : [ {
				value : parseFloat(used),
				color : "#3399FF",
				highlight : "#e74c3c",
				label : "Used",
				showLabels : "true",
			}, {
				value : parseFloat(max),
				color : "#A9A9A9",
				highlight : "#57b32c",
				label : "Available",
				showLabels : "true",
			} ]
		};
		$scope.quotaLimitData.push($scope.resource[resourceName + "Limit"]);
	}

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

	/**
	 * Options for Doughnut chart
	 */
	$scope.quotaChartOptions = {
		segmentShowStroke : true,
		segmentStrokeColor : "#fff",
		segmentStrokeWidth : 1,
		percentageInnerCutout : 40, // This is 0 for Pie charts
		animationSteps : 100,
		animationEasing : false,
		animateRotate : false,
		animateScale : false,
		showTooltips : true,
		tooltipCaretSize : 12,
		tooltipFontSize : 12,
		tooltipYPadding : 4,
		tooltipXPadding : 4,
		legend : true
	};

$scope.getResourceDomain = function() {
	$scope.quotaLimits = {
		      "CPU": {label: "vCPU"}, "Memory": {label: "Memory"}, "Volume": {label: "Volume"}, "Network": {label: "Network"},
		      "IP": {label: "IP"}, "PrimaryStorage": {label: "PrimaryStorage"}, "SecondaryStorage": {label: "SecondaryStorage"},
		      "Snapshot": {label: "Snapshot"}
		    };
    $scope.showQuotaLoader = true;
    var resourceArr = ["CPU", "Memory", "Volume", "Network", "IP", "PrimaryStorage", "SecondaryStorage", "Snapshot"];
    if (angular.isUndefined($scope.domainView) || $scope.domainView == null) {
        var hasResourceDomainId = appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET , globalConfig.APP_URL + "dashboard/quota");
   } else {
       var hasResourceDomainId = appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET , globalConfig.APP_URL + "resourceDomains/listByDomain/"+$scope.domainView.id);
   }
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
                      label: "UnUsed"
                  }
              ];
            }
        });
    });
};
$scope.getResourceDomain();

}
