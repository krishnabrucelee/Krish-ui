/**
 *
 * networkCtrl
 *
 */

angular
    .module('homer')
    .controller('networkCtrl', networkCtrl)

function networkCtrl($scope, $modal, $stateParams, localStorageService, promiseAjax) {

    $scope.networkList = [];

    $scope.instanceDetails='';

    //localStorageService.clearAll();
    if (localStorageService.get("instanceNetworkList") == null) {
        var hasServer = promiseAjax.httpRequest("GET", "api/instance.json");
        hasServer.then(function (result) {  // this is only run after $http completes
            $scope.networkList = result[$stateParams.id - 1].networkList;
            $scope.instanceDetails = result[$stateParams.id - 1].name;
            localStorageService.set("instanceNetworkList", $scope.networkList);
        });
    } else {
         var hasServer = promiseAjax.httpRequest("GET", "api/instance.json");
        hasServer.then(function (result) {
           $scope.instanceDetails = result[$stateParams.id - 1].name;
        });
        $scope.networkList = localStorageService.get("instanceNetworkList");
    }

    $scope.addNetworkToVM = function(size) {
        var modalInstance = $modal.open({
            animation: $scope.animationsEnabled,
            templateUrl: 'app/views/cloud/instance/add-network.jsp',
            controller: 'instanceCtrl',
            size: size,
            backdrop : 'static',
             windowClass: "hmodal-info",
            resolve: {
                instanceId: function () {
                    return $stateParams.id;
                }
            }
        });

        modalInstance.result.then(function (selectedItem) {
            $scope.selected = selectedItem;
        }, function () {
        });

    };

}