/**
 *
 * instanceMonitorCtrl
 *
 */

angular
    .module('homer')
    .controller('instanceMonitorCtrl', instanceMonitorCtrl)

function instanceMonitorCtrl($scope, $state, $http, $stateParams, promiseAjax) {
    $scope.instanceList = [];
    if ($stateParams.id > 0) {
        var hasServer = promiseAjax.httpRequest("GET", "api/instance.json");
        hasServer.then(function (result) {  // this is only run after $http completes
            var instanceId = $stateParams.id - 1;
            $scope.instance = result[instanceId];
            $state.current.data.pageName = result.name;
            $state.current.data.id = result.id;
        });
    }

    /**
     * Data for Line chart
     */
    $scope.cpu = {
        labels: ["10.00", "10.05", "10.10", "10.15", "10.20", "10.25", "10.30"],
        datasets: [
            {
                label: "CPU 0",
                fillColor: "#E56919",
                strokeColor: "#E56919",
                pointColor: "#E56919",
                pointStrokeColor: "#fff",
                pointHighlightFill: "#fff",
                pointHighlightStroke: "rgba(220,220,220,1)",
                data: [5, 44, 37, 43, 46, 45, 32]
            },
            {
                label: "CPU 1",
                fillColor: "#16658D",
                strokeColor: "#16658D",
                pointColor: "#16658D",
                pointStrokeColor: "#fff",
                pointHighlightFill: "#fff",
                pointHighlightStroke: "rgba(26,179,148,1)",
                data: [37, 39, 29, 36, 32, 23, 28]
            },
            {
                label: "CPU 2",
                fillColor: "#7208A8",
                strokeColor: "#7208A8",
                pointColor: "#7208A8",
                pointStrokeColor: "#fff",
                pointHighlightFill: "#fff",
                pointHighlightStroke: "rgba(26,179,148,1)",
                data: [26, 32, 22, 26, 25, 22, 18]
            },
            {
                label: "CPU 3",
                fillColor: "rgba(98,203,49,0.5)",
                strokeColor: "rgba(98,203,49,0.7)",
                pointColor: "rgba(98,203,49,1)",
                pointStrokeColor: "#fff",
                pointHighlightFill: "#fff",
                pointHighlightStroke: "rgba(26,179,148,1)",
                data: [12, 22, 18, 16, 20, 19, 9]
            }

        ]
    };
     $scope.memory = {
        labels: ["10.00", "10.05", "10.10", "10.15", "10.20", "10.25", "10.30"],
        datasets: [
            {
                label: "Used Memory",
                fillColor: "#E56919",
                strokeColor: "#E56919",
                pointColor: "#E56919",
                pointStrokeColor: "#fff",
                pointHighlightFill: "#fff",
                pointHighlightStroke: "rgba(220,220,220,1)",
                data: [52, 44, 37, 43, 46, 45, 32]
            },
            {
                label: "Unused Memory",
                fillColor: "#16658D",
                strokeColor: "#16658D",
                pointColor: "#16658D",
                pointStrokeColor: "#fff",
                pointHighlightFill: "#fff",
                pointHighlightStroke: "rgba(26,179,148,1)",
                data: [37, 39, 29, 36, 32, 23, 28]
            }

        ]
    };
     $scope.network = {
        labels: ["10.00", "10.05", "10.10", "10.15", "10.20", "10.25", "10.30"],
        datasets: [
            {
                label: "NIC 0 - Receive",
                fillColor: "#E56919",
                strokeColor: "#E56919",
                pointColor: "#E56919",
                pointStrokeColor: "#fff",
                pointHighlightFill: "#fff",
                pointHighlightStroke: "rgba(220,220,220,1)",
                data: [52, 44, 37, 43, 46, 45, 32]
            },
            {
                label: "NIC 0 - Send",
                fillColor: "#16658D",
                strokeColor: "#16658D",
                pointColor: "#16658D",
                pointStrokeColor: "#fff",
                pointHighlightFill: "#fff",
                pointHighlightStroke: "rgba(26,179,148,1)",
                data: [37, 39, 29, 36, 32, 23, 28]
            },
            {
                label: "NIC 1 - Send",
                fillColor: "#7208A8",
                strokeColor: "#7208A8",
                pointColor: "#7208A8",
                pointStrokeColor: "#fff",
                pointHighlightFill: "#fff",
                pointHighlightStroke: "rgba(26,179,148,1)",
                data: [26, 32, 22, 26, 25, 22, 18]
            },
            {
                label: "NIC 1 - Receive",
                fillColor: "rgba(98,203,49,0.5)",
                strokeColor: "rgba(98,203,49,0.7)",
                pointColor: "rgba(98,203,49,1)",
                pointStrokeColor: "#fff",
                pointHighlightFill: "#fff",
                pointHighlightStroke: "rgba(26,179,148,1)",
                data: [12, 22, 18, 16, 20, 19, 9]
            }

        ]
    };
     $scope.disk = {
        labels: ["10.00", "10.05", "10.10", "10.15", "10.20", "10.25", "10.30"],
        datasets: [

            {
                label: "IOPS",
                fillColor: "#E56919",
                strokeColor: "#E56919",
                pointColor: "#E56919",
                pointStrokeColor: "#fff",
                pointHighlightFill: "#fff",
                pointHighlightStroke: "rgba(220,220,220,1)",
                data: [12, 22, 18, 16, 20, 19, 9]
            }

        ]
    };
    $scope.instanceElements= {actions: [
            {id: 1, name: 'Hours'},
            {id: 2, name: 'Days'},
            {id: 3, name: 'Weeks'},
            {id: 3, name: 'Month'}

        ]};

    /**
     * Options for Line chart
     */
    $scope.lineOptions = {
        scaleShowGridLines : true,
        scaleGridLineColor : "rgba(0,0,0,.05)",
        scaleGridLineWidth : 1,
        bezierCurve : true,
        bezierCurveTension : 0.4,
        pointDot : true,
        pointDotRadius : 4,
        pointDotStrokeWidth : 1,
        pointHitDetectionRadius : 20,
        datasetStroke : true,
        datasetStrokeWidth : 1,
        datasetFill : false,
//        responsive: true,
//        maintainAspectRatio: true
    };

}