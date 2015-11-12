angular
        .module('homer')
        .controller('sshkeyListCtrl', sshkeyListCtrl)
        .controller('sshCtrl', sshCtrl)


function sshCtrl($scope, $modalInstance, notify, localStorageService) {


    $scope.submitForm = function () {
        if ($scope.form.sshForm.$valid) {

            $scope.sshKeyList = localStorageService.get("sshKeyList");
            var instanceCount = $scope.sshKeyList.length;
            $scope.sshKey.id = instanceCount + 1;
            $scope.sshKey.fingerPrint = "wae"+ $scope.sshKey.id+"a:"+"sef"+ $scope.sshKey.id+"a:"+"sgf"+ $scope.sshKey.id+"s:"+"ers"+ $scope.sshKey.id+"s";
            $scope.sshKeyList.push($scope.sshKey);

            localStorageService.set("sshKeyList", $scope.sshKeyList);

            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            notify({message: 'Created successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
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

function sshkeyListCtrl($scope, $modal, $log, localStorageService, promiseAjax) {
    if (localStorageService.get("sshKeyList") == null) {
        var hasServer = promiseAjax.httpRequest("GET", "api/sshKeys.json");
        hasServer.then(function (result) {  // this is only run after $http completes
            $scope.sshKeyList = result;
            localStorageService.set("sshKeyList", result);
        });
    } else {
        $scope.sshKeyList = localStorageService.get("sshKeyList");
    }

    $scope.showForm = function (size) {

        var modalInstance = $modal.open({
            templateUrl: 'app/views/cloud/sshkeys/add.jsp',
            controller: 'sshCtrl',
            size: size,
            backdrop: 'static',
            windowClass: "hmodal-info",
            resolve: {
                items: function () {
                    return $scope.items;
                }
            }
        });




    };
}