/*
 * QuotaAllocation Controller for allocate the resources for department and projects
 */
angular.module('homer').controller('quotaAllocationCtrl', quotaAllocationCtrl)

function quotaAllocationCtrl($scope, $window, $modal, $log, $state, crudService,
		$stateParams, promiseAjax, notify, localStorageService, modalService) {

	$scope.departmentList = {};
	$scope.paginationObject = {};
	$scope.departmentForm = {};
	$scope.global = crudService.globalConfig;




	// Department List
	$scope.list = function(pageNumber) {
		var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT
				: $scope.paginationObject.limit;
		var hasDepartments = crudService.list("departments", $scope.global
				.paginationHeaders(pageNumber, limit), {
			"limit" : limit
		});
		hasDepartments.then(function(result) { // this is only run after $http completes0

			$scope.stateid = $stateParams.id;
			$scope.type = $stateParams.quotaType;
			console.log($scope.type);
			$scope.departmentList = result;

			angular.forEach($scope.departmentList, function(obj, key) {
				if (obj.id == $scope.stateid) {
					$scope.department = obj;
				}
			});

			// For pagination
			$scope.paginationObject.limit = limit;
			$scope.paginationObject.currentPage = pageNumber;
			$scope.paginationObject.totalItems = result.totalItems;
		});
	};
	$scope.list(1);

	// Project List


    $scope.projectquotalist = function (pageNumber) {
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasProjects = crudService.list("projects", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
        hasProjects.then(function (result) {  // this is only run after $http completes0

            $scope.stateid = $stateParams.id;
			$scope.type = $stateParams.quotaType;
			$scope.projectList = result;

			angular.forEach($scope.projectList, function(obj, key) {
				if (obj.id == $scope.stateid) {
					$scope.config.project = obj;
					alert("1swd");

				}
			});

            // For pagination
            $scope.paginationObject.limit  = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
        });
    };
    $scope.projectquotalist(1);




};

