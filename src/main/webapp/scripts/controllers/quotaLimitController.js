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
    console.log(quotaReason.title);
    $scope.submitForm = function () {
        if ($scope.form.userForm.$valid) {
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            notify({message: 'Request has been sent successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
            $modalInstance.close('closed');
        } else {
            console.log('userform is not in scope');
        }
    };

    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };
}
;

function quotaLimitCtrl($scope, $modal, $log) {


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
                value: 20,
                color: "#A9A9A9",
                highlight: "#57b32c",
                label: "Available",
                showLabels: "true",
            },
            {
                value: 80,
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



