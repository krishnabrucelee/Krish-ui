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

function quotaLimitCtrl($scope, $state, $stateParams, appService, $window) {

	$scope.global = appService.globalConfig;
	$scope.resourceDomainList = [];
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

	$scope.resourceDomainList = function() {
		var hasresourceDomainList = appService.crudService
				.listAll("resourceDomains/listresourcedomains");
		hasresourceDomainList.then(function(result) { // this is only run
			// after $http
			// completes0
			$scope.resourceDomainList = result;
			var i = 0;
			angular.forEach(result, function(object, key) {
				i++;
				$scope.resourceQuota[object.resourceType] = object.usedLimit;
				$scope.resourceQuota[object.resourceType] = object.available;
				if (object.resourceType != "Project") {
					if (object.resourceType == "Memory") {
						object.available = Math.round(object.available / 1024);
						object.usedLimit = Math.round( object.usedLimit / 1024);
						object.resourceType = object.resourceType + " " + "(GB)";
					}
					if (object.available == -1 && object.resourceType == "PrimaryStorage" || object.available == -1 && object.resourceType == "SecondaryStorage") {
					    object.usedLimit = Math.round( object.usedLimit / (1024 * 1024 * 1024));
					    object.resourceType = object.resourceType + " " + "(GiB)";
				    }
					if (object.usedLimit == null) {
						object.usedLimit = 0;
					}
					if (object.available == null || object.available == -1 || object.available == 0) {
						object.available = 100;
					}
					$scope.resourceListMap(object.resourceType,
							object.usedLimit, object.available);
				}
			});

		});
	};
	$scope.resourceDomainList(1);

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
	$scope.resourceListMap = function(resourceName, available, used) {
		console.log(resourceName);
		$scope.resource[resourceName + "Limit"] = {
			"title" : resourceName,
			"options" : [ {
				value : parseFloat(used),
				color : "#A9A9A9",
				highlight : "#57b32c",
				label : "Available",
				showLabels : "true",
			}, {
				value : parseFloat(available),
				color : "#3399FF",
				highlight : "#e74c3c",
				label : "Used",
				showLabels : "true",
			} ]
		};
		$scope.quotaLimitData.push($scope.resource[resourceName + "Limit"]);
	}

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

}