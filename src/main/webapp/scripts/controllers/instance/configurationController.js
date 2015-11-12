/**
 *
 * configurationCtrl
 *
 */

angular
    .module('homer')
    .controller('configurationCtrl', configurationCtrl)

function configurationCtrl($scope, $modal, globalConfig, notify) {

    $scope.global = globalConfig;
    $scope.formSubmitted = false;
    // Form Field Decleration
    $scope.computeOffer = {
//        type: {id:1, name:"Basic"}
    };


    $scope.instance = {
        computeOffer: {
            category: 'static',
            ram: {
                value: 0,
                floor: 0,
                ceil: 64
            },
            cpuCore: {
                value: 0,
                floor: 0,
                ceil: 32

            },
            isOpen: true


        },
        diskOffer: {
            category: 'static',
            diskSize: {
                value: 0,
                floor: 0,
                ceil: 1024

            },
            iops: {
                value: 0,
                floor: 0,
                ceil: 500

            },
            isOpen: false

        },
        network: {
            category: 'all',
            isOpen: false

        }
    };


    $scope.computeOfferElements = {
        type: [
            {
                id:1,
                name:"Micro",
                planList: [
                    {id: 1, group:'Micro', name: 'micro-1 (1vCPU / 512M)', price: 0.5},
                    {id: 2, group:'Micro', name: 'micro-2 (1vCPU / 1G)', price: 0.10},
                    {id: 18, group:'Custom', name: 'Custom', price: 0.0}
                ]
            },
            {
                id:2,
                name:"Standard",
                planList: [
                    {id: 3, group: 'Standard', name: 'standard-1 (1vCPU / 2G)', price: 0.15},
                    {id: 4, group: 'Standard', name: 'standard-2 (2vCPU / 4G)', price: 0.0},
                    {id: 5, group: 'Standard', name: 'standard-4 (4vCPU / 8G)', price: 0.5},
                    {id: 6, group: 'Standard', name: 'standard-8 (8vCPU / 16G)', price: 0.10},
                    {id: 7, group: 'Standard', name: 'standard-12 (12vCPU / 24G)', price: 0.15},
                    {id: 8, group: 'Standard', name: 'standard-16 (16vCPU / 32G)', price: 0.0},
                    {id: 18, group:'Custom', name: 'Custom', price: 0.0}
                ]

            },
            {
                id:3,
                name:"Compute",
                planList: [
                    {id: 14, group: 'Compute', name: 'compute-2 (2vCPU / 2G)', price: 0.10},
                    {id: 15, group: 'Compute', name: 'compute-4 (4vCPU / 4G)', price: 0.15},
                    {id: 16, group: 'Compute', name: 'compute-8 (8vCPU / 8G)', price: 0.0},
                    {id: 17, group: 'Compute', name: 'compute-12 (12vCPU / 12G)', price: 0.0},
                    {id: 18, group:'Custom', name: 'Custom', price: 0.0}
                ]

            },
            {
                id:4,
                name:"Memory",
                planList: [
                    {id: 9, group: 'Memory', name: 'memory-1 (1vCPU / 4G)', price: 0.5},
                    {id: 10, group: 'Memory', name: 'memory-2 (2vCPU / 8G)', price: 0.10},
                    {id: 11, group: 'Memory', name: 'memory-4 (4vCPU / 16G)', price: 0.15},
                    {id: 12, group: 'Memory', name: 'memory-8 (8vCPU / 32G)', price: 0.0},
                    {id: 13, group: 'Memory', name: 'memory-12 (12vCPU / 48G)', price: 0.5},
                    {id: 18, group:'Custom', name: 'Custom', price: 0.0}
                ]

            }
        ],

    };
    $scope.computeOffer.plan = $scope.computeOfferElements.type[0].planList[0];

    $scope.changePlan = function(type) {
        $scope.computeOffer.type = type;
        $scope.computeOffer.plan = null;
    };

    $scope.save = function(form) {
        $scope.formSubmitted = true;
        var customValid = true;

        if($scope.computeOffer.plan.name == "Custom" &&
                ($scope.instance.computeOffer.ram.value <= 0 || $scope.instance.computeOffer.cpuCore.value <= 0)) {
            customValid = false;
        }
        if (form.$valid && customValid) {

            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            notify({message: 'Updated successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
        }
    };


    $scope.affinity = {
//        type: {id:1, name:"Basic"}
    };


    $scope.affinityElements = {
        groupList: [
            {id: 1, name: 'VM1', price: 0.5},
            {id: 2, name: 'Data1', price: 0.10},
            {id: 3, name: 'Network1', price: 0.15},
        ],
    };

    $scope.affinity.group = $scope.affinityElements.groupList[0];

    $scope.saveAffinity = function(form) {
        $scope.affinitySubmitted = true;
        if (form.$valid) {
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            notify({message: 'Updated successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
        }
    };


    $scope.addAffinityGroup = function (size) {

        var modalInstance = $modal.open({
            templateUrl: 'app/views/cloud/instance/affinity.jsp',
            controller: 'affinityCtrl',
              size: size,
            backdrop : 'static',
             windowClass: "hmodal-info",
            resolve: {
                items: function () {
                    return $scope.items;
                }
            }
        });

        modalInstance.result.then(function (selectedItem) {
            $scope.selected = selectedItem;
        }, function () {
        });

    };

}
