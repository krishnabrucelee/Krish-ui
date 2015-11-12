/**
 *
 * activityCtrl
 *
 */

angular
        .module('homer')
        .controller('activityCtrl', activityCtrl)
        .controller('activityDescriptionCtrl', activityDescriptionCtrl)
        .controller('archiveCtrl', archiveCtrl)
        .controller('deleteCtrl', deleteCtrl)
        .controller('activityViewCtrl', activityViewCtrl)

function activityCtrl($scope, $modal, promiseAjax, localStorageService, modalService) {

    $scope.activity = {
        category: "events",
        oneItemSelected: {},
        selectedAll: {}
    };
    $scope.getActivityByCategory = function (category) {
        $scope.activity = {
            category: category,
            oneItemSelected: {},
            selectedAll: {}
        };
        $scope.activity.category = category;
        $scope.pageTitle = category.substring(0, 1).toUpperCase() + category.substring(1).toLowerCase();
        var hasServer = promiseAjax.httpRequest("GET", "api/activity-" + category + ".json");
        hasServer.then(function (result) {  // this is only run after $http completes
            $scope.activityList = result;

        });
    }
    $scope.getActivityByCategory($scope.activity.category);

    $scope.archiveGlobal = function () {
        modalService.trigger('app/views/activity/archive.jsp', 'md', 'Archive ' + $scope.pageTitle);
    };

    $scope.deleteGlobal = function () {
        modalService.trigger('app/views/activity/delete.jsp', 'md', 'Delete ' + $scope.pageTitle);
    };

    $scope.delete = function () {
        modalService.trigger('app/views/activity/confirm-delete.jsp', 'md', 'Delete Confirmation');
    };

    $scope.archive = function () {
        modalService.trigger('app/views/activity/confirm-archive.jsp', 'md', 'Archive Confirmation');
    };



    $scope.checkAll = function () {
        $scope.activity.oneItemSelected[$scope.activity.category] = false;

        if ($scope.activity.selectedAll[$scope.activity.category]) {
            $scope.activity.selectedAll[$scope.activity.category] = true;
        } else {
            $scope.activity.selectedAll[$scope.activity.category] = false;
        }


        angular.forEach($scope.activityList, function (item, key) {
            item['isSelected'] = $scope.activity.selectedAll[$scope.activity.category];
            if (item['isSelected']) {
                $scope.activity.oneItemSelected[$scope.activity.category] = true;
            }
        });

    };

    $scope.checkOne = function (item) {
        $scope.activity.oneItemSelected[$scope.activity.category] = false;
        $scope.activity.selectedAll[$scope.activity.category] = true;
        angular.forEach($scope.activityList, function (item, key) {
            if (item['isSelected']) {
                $scope.activity.oneItemSelected[$scope.activity.category] = true;
            } else {
                $scope.activity.selectedAll[$scope.activity.category] = false;
            }
        });
    }


    $scope.showDescription = function (activity) {
        $scope.currentActivity = activity;
        activity.pageTitle = $scope.pageTitle;
        activity.category = $scope.activity.category;

        var modalInstance = $modal.open({
            animation: $scope.animationsEnabled,
            templateUrl: 'app/views/activity/activity-description.jsp',
            controller: 'activityDescriptionCtrl',
            size: 'md',
            backdrop: 'static',
            windowClass: "hmodal-info",
            resolve: {
                activity: function () {
                    return angular.copy(activity);
                }
            }
        });

        modalInstance.result.then(function (selectedItem) {
            $scope.selected = selectedItem;

        }, function () {
        });
    };
};


function activityDescriptionCtrl($scope, activity, $modalInstance, notify) {
    $scope.activity = activity;
    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };
};

function archiveCtrl($scope, globalConfig, notify, $state, $stateParams) {
    $scope.global = globalConfig;
    $scope.activity = {};
    $scope.archive = function () {
        $scope.homerTemplate = 'app/views/notification/notify.jsp';
        notify({message: 'Archived successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
        $scope.cancel();
    };


    $scope.save = function (form)
    {
        $scope.formSubmitted = true;

        if (form.$valid) {
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            notify({message: 'Archived successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
            $scope.cancel();
        }
    }


    $scope.open = function ($event, currentDateField) {
        $event.preventDefault();
        $event.stopPropagation();

        $scope.activity[currentDateField] = true;
    };

};


function deleteCtrl($scope, $state, $stateParams, globalConfig, notify) {
    $scope.global = globalConfig;
    $scope.activity = {};
    $scope.delete = function () {
        $scope.homerTemplate = 'app/views/notification/notify.jsp';
        notify({message: 'Deleted successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
        $scope.cancel();
    };

    $scope.remove = function (form)
    {
        $scope.formSubmitted = true;

        if (form.$valid) {
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            notify({message: 'Deleted successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
            $scope.cancel();
        }
    }


    $scope.open = function ($event, currentDateField) {
        $event.preventDefault();
        $event.stopPropagation();

        $scope.activity[currentDateField] = true;
    };
};


function activityViewCtrl($scope, $state, $stateParams, promiseAjax, localStorageService, modalService) {
    var hasServer = promiseAjax.httpRequest("GET", "api/activity-" + pageTitle + ".json");
    hasServer.then(function (result) {  // this is only run after $http completes
        $scope.activityList = result;
        angular.forEach($scope.activityList, function (item, key) {
            if (item.id == activityId) {
                $scope.activity = item;
                modalService.trigger('app/views/activity/activity-description.jsp', 'md', "#" + $scope.activity.id);
            }
        });

    });

};