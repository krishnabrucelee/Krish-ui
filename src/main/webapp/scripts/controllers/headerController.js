/*
 * Configuration Controller for estalishing connectivity with cloud Stack
 */
angular
        .module('homer')
        .controller('headerCtrl', headerCtrl)

function headerCtrl($scope, $http, $window, $modal, $log, $state, $stateParams, appService,globalConfig, $cookies) {

	  $scope.showImage = function() {
	    	$scope.logoImage =  REQUEST_PROTOCOL + $window.location.hostname +':8080/'  + 'resources/' + 'theme_logo.jpg';
	}
	$scope.showImage();

	$scope.themeSettingList = function () {
		$scope.themeSettingsList = {};
		    var hasThemeList = appService.crudService.listAll("themesettings/listAll");
		    hasThemeList.then(function (result) {
		    	$scope.themeSettingsList = result[0];
//		    	if (!angular.isUndefined($scope.themeSettingsList.id)) {
//		            var hasCustomList= appService.crudService.listByQuery("themesettings/listbythemeid?id="+$scope.themeSettingsList.id);
//			        hasCustomList.then(function (result) {
//			        $scope.themeCustomisationList = JSON.stringify(result);
//			        });
//		    	}
		    });
	};
	$scope.themeSettingList();
};