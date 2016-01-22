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

    $scope.submitForm = function () {
        if ($scope.form.userForm.$valid) {
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            notify({message: 'Request has been sent successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
            $modalInstance.close('closed');
        } else {

        }
    };

    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };
};

function quotaLimitCtrl($scope, $state, $stateParams, appService, filterFilter, $window,
		volumeService, modalService, globalConfig) {

	$scope.global = globalConfig;
	$scope.global = appService.globalConfig;
	$scope.resourceDomainList = [];
	$scope.resourceQuota = {};
	$scope.resourceTypeList = [
	                            "Instance",
		                        /** Number of public IP addresses a user can own. */
		                        "IP",
		                        /**  Number of disk volumes a user can create. */
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
		                        "SecondaryStorage"];


    $scope.resourceDomainList = function () {
        var hasresourceDomainList = appService.crudService.listAll("resourceDomains/listresourcedomains");
        hasresourceDomainList.then(function (result) {  // this is only run after $http completes0
           $scope.resourceDomainList = result;

			var i=0;
			angular.forEach(result, function(object, key) {
				i++;
				$scope.resourceQuota[object.resourceType] = object.usedLimit;
				$scope.resourceQuota[object.resourceType] = object.available;
			});

        });
    };
    $scope.resourceDomainList(1);

    $scope.showForm = function (quotaReason) {
        //$scope.quota = quota;
        var modalInstance = $modal.open({
            templateUrl: 'app/views/cloud/quota/quota-reason.jsp',
            controller: 'quotaReasonCtrl',
            backdrop: 'static',
            keyboard: false,
            scope: $scope,
            resolve: {
                userForm: function () {
                    return $scope.userForm;
                },
                quotaReason: function() {
                    return quotaReason;
                }
            }
        });



    };

    var instanceLimit = {
        "title": "Instance",
        "options": [
            {
                value: 40,
                color: "#A9A9A9",
                highlight: "#57b32c",
                label: "Available",
                showLabels: "true",
            },
            {
                value: 10,
                color: "#3399FF",
                highlight: "#e74c3c",
                label: "Used",
                showLabels: "true",
            }]
    };
    var snapShotLimit = {
        "title": "Snapshot's",
        "options": [
            {
                value: 60,
                color: "#A9A9A9",
                highlight: "#57b32c",
                label: "Available",
                showLabels: "true",
            },
            {
                value: 40,
                color: "#3399FF",
                highlight: "#e74c3c",
                label: "Used",
                showLabels: "true",
            }]
    };
    var ipLimit = {
        "title": "Public IP",
        "options": [
            {
                value: 80,
                color: "#A9A9A9",
                highlight: "#57b32c",
                label: "Available",
                showLabels: "true",
            },
            {
                value: 20,
                color: "#3399FF",
                highlight: "#e74c3c",
                label: "Used",
                showLabels: "true",
            }]
    };
    var volumeLimit = {
        "title": "Volume's",
        "options": [
            {
                value: 50,
                color: "#A9A9A9",
                highlight: "#57b32c",
                label: "Available",
                showLabels: "true",
            },
            {
                value: 50,
                color: "#3399FF",
                highlight: "#e74c3c",
                label: "Used",
                showLabels: "true",
            }]
    };
    var templateLimit = {
        "title": "Template's",
        "options": [
            {
                value: 100,
                color: "#A9A9A9",
                highlight: "#57b32c",
                label: "Available",
                showLabels: "true",
            },
            {
                value: 0,
                color: "#3399FF",
                highlight: "#e74c3c",
                label: "Used",
                showLabels: "true",
            }]
    };

    var vpcLimit = {
        "title": "VPC",
        "options": [
            {
                value: 0,
                color: "#A9A9A9",
                highlight: "#57b32c",
                label: "Available",
                showLabels: "true",
            },
            {
                value: 100,
                color: "#3399FF",
                highlight: "#e74c3c",
                label: "Used",
                showLabels: "true",
            }]
    };
    var cpuLimit = {
        "title": "CPU Cores",
        "options": [
            {
                value: 10,
                color: "#A9A9A9",
                highlight: "#57b32c",
                label: "Available",
                showLabels: "true",
            },
            {
                value: 90,
                color: "#3399FF",
                highlight: "#e74c3c",
                label: "Used",
                showLabels: "true",
            }]
    };
    var memoryLimit = {
        "title": "Memory(MB)",
        "options": [
            {
                value: 40,
                color: "#A9A9A9",
                highlight: "#57b32c",
                label: "Available",
                showLabels: "true",
            },
            {
                value: 60,
                color: "#3399FF",
                highlight: "#e74c3c",
                label: "Used",
                showLabels: "true",
            }]
    };
    var networkLimit = {
        "title": "Network's",
        "options": [
            {
                value: 45,
                color: "#A9A9A9",
                highlight: "#57b32c",
                label: "Available",
                showLabels: "true",
            },
            {
                value: 55,
                color: "#3399FF",
                highlight: "#e74c3c",
                label: "Used",
                showLabels: "true",
            }]
    };
    var primarystorageLimit = {
        "title": "Primary Storage",
        "options": [
            {
                value: 40,
                color: "#A9A9A9",
                highlight: "#57b32c",
                label: "Available",
                showLabels: "true",
            },
            {
                value: 60,
                color: "#3399FF",
                highlight: "#e74c3c",
                label: "Used",
                showLabels: "true",
            }]
    };
    var secondarystorageLimit = {
        "title": "Secondary Storage",
        "options": [
            {
                value: 85,
                color: "#A9A9A9",
                highlight: "#57b32c",
                label: "Available",
                showLabels: "true",
            },
            {
                value: 15,
                color: "#3399FF",
                highlight: "#e74c3c",
                label: "Used",
                showLabels: "true",
            }]
    };

    /**
     * Data for Doughnut chart
     */
    $scope.quotaLimitData = [
        instanceLimit,
        cpuLimit,
        memoryLimit,
        ipLimit,
        volumeLimit,
        templateLimit,
        snapShotLimit,
        networkLimit,
        vpcLimit,
        primarystorageLimit,
        secondarystorageLimit
    ];

    /**
     * Options for Doughnut chart
     */
    $scope.quotaChartOptions = {
        segmentShowStroke: true,
        segmentStrokeColor: "#fff",
        segmentStrokeWidth: 1,
        percentageInnerCutout: 40, // This is 0 for Pie charts
        animationSteps: 100,
        animationEasing: false,
        animateRotate: false,
        animateScale: false,
        showTooltips: true,
        tooltipCaretSize: 12,
        tooltipFontSize: 12,
        tooltipYPadding: 6,
        tooltipXPadding: 6,
        legend:true
    };

}



