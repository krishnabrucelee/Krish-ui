/*
 * Configuration Controller for estalishing connectivity with cloud Stack
 */
angular
        .module('homer')
        .controller('headerCtrl', headerCtrl)

function headerCtrl($scope, $http, $window, $modal, $log, $state, $stateParams, appService,globalConfig, localStorageService, $cookies) {

      $scope.showImage = function() {
            $scope.logoImage =  REQUEST_PROTOCOL + $window.location.hostname +':8080/'  + 'resources/' + 'theme_logo.jpg';
    }
    $scope.showImage();

    $scope.themeSettingList = function () {
                $scope.themeSettingsList = localStorageService.cookie.get('themeSettings');
                if ($scope.themeSettingsList.data.headerTitle != null) {
                    document.getElementById("pandaAppPageTitle").innerHTML = $scope.themeSettingsList.data.headerTitle;
                }

    };
    $scope.themeSettingList();

};