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
        $scope.themeSettings = localStorageService.get('themeSettings');
        if ($scope.themeSettings.data != null) {
        	$scope.themeSettingsList = $scope.themeSettings.data;
        } else {
        	$scope.themeSettingsList = $scope.themeSettings;
        }
    	if ($scope.themeSettingsList != null) {
    		if ($scope.themeSettingsList.headerTitle != null) {
    			document.getElementById("pandaAppPageTitle").innerHTML = $scope.themeSettingsList.headerTitle;
    		}
    	}
        //$state.data.pageTitle = "testttt";
    };
    $scope.themeSettingList();

};