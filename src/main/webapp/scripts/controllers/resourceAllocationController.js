/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


angular
.module('homer')
.controller('resourceAllocationCtrl', resourceAllocationCtrl);

function resourceAllocationCtrl($scope, crudService, globalConfig, notify, $state, $stateParams, promiseAjax, appService) {

	$scope.resourceQuota = {};
	$scope.resourceQuota = {};
	$scope.resourceTypeList = [
                            "Instance",
	                        /** Number of public IP addresses a user can own. */
	                        "IP",
	                        /**  Number of disk volumes a user can create. */
	                        "Volume",
	                        /** Number of snapshots a user can create. */
	                        "Snapshot",
	                        /** Number of templates that a user can register/create. */
	                        "Template",
	                        /** Number of projects an account can own. */
	                        "Project",
	                        /** Number of guest network a user can create. */
	                        "Network",
	                        /** Number of VPC a user can create. */
	                        "VPC",
	                        /** Total number of CPU cores a user can use. */
	                        "CPU",
	                        /** Total Memory (in MB) a user can use. */
	                        "Memory",
	                        /** Total primary storage space (in GiB) a user can use. */
	                        "PrimaryStorage",
	                        /** Total secondary storage space (in GiB) a user can use. */
	                        "SecondaryStorage"];

	$scope.paginationObject = {};
        $scope.global = crudService.globalConfig;
        $scope.sort = appService.globalConfig.sort;
	$scope.domainList = {};
	

    // Domain List
    $scope.departmentList = {};
    $scope.paginationObject = {};
    $scope.departmentForm = {};
    $scope.global = crudService.globalConfig;
    $scope.paginationObject.sortOrder = '+';
    $scope.paginationObject.sortBy = 'name';


    // Save Resource limits based on the quota type.
	$scope.save = function(form) {
		//if(form.$valid) {
		if($scope.type == "project-quota") {
			if(!angular.isUndefined($scope.resourceQuota.project)) {
				$scope.saveProjectQuota(form);
			}
		} else if($scope.type == "department-quota") {
			if(!angular.isUndefined($scope.resourceQuota.department)) {
				$scope.saveDepartmentQuota(form);
			}
		} else {
			$scope.saveDomainQuota(form);
		}
		//}
	}

	// Department List
	$scope.list = function(pageNumber) {
		var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT
				: $scope.paginationObject.limit;
		var hasDepartments = crudService.listAll("departments/list");
		hasDepartments.then(function(result) { // this is only run after $http completes0

			$scope.stateid = $stateParams.id;
			$scope.type = $stateParams.quotaType;
			$scope.departmentList = result;

			angular.forEach($scope.departmentList, function(obj, key) {
				if (obj.id == $scope.stateid) {
					$scope.resourceQuota.department = obj;
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
    	appService.globalConfig.sort.sortOrder = $scope.paginationObject.sortOrder;
        appService.globalConfig.sort.sortBy = $scope.paginationObject.sortBy;
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasProjects = crudService.list("projects", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
        hasProjects.then(function (result) {  // this is only run after $http completes0

            $scope.stateid = $stateParams.id;
			$scope.type = $stateParams.quotaType;
			$scope.projectList = result;

			angular.forEach($scope.projectList, function(obj, key) {
				if (obj.id == $scope.stateid) {
					$scope.resourceQuota.project = obj;

				}
			});

            // For pagination
            $scope.paginationObject.limit  = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
        });
    };
    $scope.projectquotalist(1);



	// Save resource limit for department.
	$scope.saveDepartmentQuota = function(form) {
		$scope.formSubmitted = true;
		if(form.$valid) {
			$scope.showLoader = true;
			var quotaList = [];
			for(var i=0; i < $scope.resourceTypeList.length; i++) {
				if(i != 5) {
					var resourceObject = {};
					resourceObject.domainId = $scope.resourceQuota.department.domainId;
					resourceObject.domain = $scope.resourceQuota.department.domain;
					resourceObject.departmentId = $scope.resourceQuota.department.id;
					resourceObject.department = $scope.resourceQuota.department;
					resourceObject.resourceType = $scope.resourceTypeList[i];
					resourceObject.max = $scope.resourceQuota[$scope.resourceTypeList[i]];
					resourceObject.id = $scope.resourceQuota[$scope.resourceTypeList[i]+"id"];
					quotaList.push(resourceObject);
				}
			}

			var hasResource = promiseAjax.httpTokenRequest( globalConfig.HTTP_POST , globalConfig.APP_URL + "resourceDepartments/create" , '', quotaList);
			hasResource.then(function (result) {  // this is only run after $http completes
				angular.forEach(result, function(obj, key) {
					$scope.resourceQuota[$scope.resourceTypeList[i]+"id"] = obj.id;
				});
				$scope.showLoader = false;
				$scope.isDisabledProject = false;
				$scope.formSubmitted = false;
	            notify({message: 'Updated successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
	            $state.reload();
	        }).catch(function (result) {
	        	$scope.showLoader = false;
	            if (!angular.isUndefined(result.data)) {
	            	 if (result.data.fieldErrors != null) {
	                    angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
	                        $scope.resourceAllocationForm[key].$invalid = true;
	                        $scope.resourceAllocationForm[key].errorMessage = errorMessage;
	                    });
	            	}
	            }
	        });
		}
	};


	// Save resource limit for project.
	$scope.saveProjectQuota = function(form) {
		$scope.formSubmitted = true;
		if(form.$valid) {
			$scope.showLoader = true;
			var quotaList = [];
			for(var i=0; i < $scope.resourceTypeList.length; i++) {
				if(i != 5) {
					var resourceObject = {};
					resourceObject.domainId = $scope.resourceQuota.project.domainId;
					resourceObject.domain = $scope.resourceQuota.project.domain;
					resourceObject.departmentId = $scope.resourceQuota.project.departmentId;
					resourceObject.department = $scope.resourceQuota.project.department;
					resourceObject.projectId = $scope.resourceQuota.project.id;
					resourceObject.project = $scope.resourceQuota.project;
					resourceObject.resourceType = $scope.resourceTypeList[i];
					resourceObject.max = $scope.resourceQuota[$scope.resourceTypeList[i]];
					resourceObject.id = $scope.resourceQuota[$scope.resourceTypeList[i]+"id"];
					quotaList.push(resourceObject);
				}
			}

			var hasResource = promiseAjax.httpTokenRequest( globalConfig.HTTP_POST , globalConfig.APP_URL + "resourceProjects/create" , '', quotaList);
			hasResource.then(function (result) {  // this is only run after $http completes
				angular.forEach(result, function(obj, key) {
					$scope.resourceQuota[$scope.resourceTypeList[i]+"id"] = obj.id;
				});
				$scope.showLoader = false;
				$scope.formSubmitted = false;
	            notify({message: 'Updated successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
	            $state.reload();
	        }).catch(function (result) {
	        	$scope.showLoader = false;
	            if (!angular.isUndefined(result.data)) {
	            	if (result.data.fieldErrors != null) {
	                    angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
	                        $scope.resourceAllocationForm[key].$invalid = true;
	                        $scope.resourceAllocationForm[key].errorMessage = errorMessage;
	                    });
	            	}
	            }
	        });

		}
	};

	$scope.isDisabledDepartment = false;
	$scope.isDisabledProject = false;

	// Get the departments by domain.

	$scope.loadEditOption = function(list, scopeObject, object) {
		if (object != null) {
		angular.forEach(list, function(domainObject, domainKey) {
			 if(domainObject.id == object.id) {
				 scopeObject = domainObject;
			 }
		 });
		} else {
			$state.reload();
		}
	};

	// Get the projects by department.
	$scope.getDepartmentResourceLimits = function() {
		$scope.resource ='department';
		if(angular.isUndefined($scope.resourceQuota.department) || $scope.resourceQuota.department == null) {
			$scope.resourceQuota.department = {id:0};
		}

		var hasResource = promiseAjax.httpTokenRequest( globalConfig.HTTP_GET , globalConfig.APP_URL + "resourceDepartments/department/"+$stateParams.id);
		hasResource.then(function (result) {

			var i=0;
			angular.forEach(result, function(object, key) {
				i++;
				if(i == 1) {
					$scope.isDisabledProject = false;
					$scope.resourceQuota.domain = result[0].domain;
					$scope.loadEditOption($scope.departmentList, $scope.resourceQuota.department, object.department);
				}
				$scope.resourceQuota[object.resourceType] = object.max;
				$scope.resourceQuota[object.resourceType+"id"] = object.id;

			});
        });

		var hasResourceDomainId = promiseAjax.httpTokenRequest( globalConfig.HTTP_GET , globalConfig.APP_URL + "resourceDomains/quotadepartmentId/"+$stateParams.id);
		hasResourceDomainId.then(function (result) {  // this is only run after $http completes
			$scope.resourceDomainCount = result;
        });

		var hasResourceDomainId = promiseAjax.httpTokenRequest( globalConfig.HTTP_GET , globalConfig.APP_URL + "resourceDepartments/quotadepartmentId/"+$stateParams.id);
		hasResourceDomainId.then(function (result) {  // this is only run after $http completes
			$scope.resourceDepartmentCount = result;
        });

		var hasResourceProjectsId = promiseAjax.httpTokenRequest( globalConfig.HTTP_GET , globalConfig.APP_URL + "resourceProjects/departmentId/"+$stateParams.id);
		hasResourceProjectsId.then(function (result) {  // this is only run after $http completes
			$scope.resourceProjectCount = result;
        });

	};
	$scope.getProjectResourceLimits = function() {
		$scope.resource ='project';
		if(angular.isUndefined($scope.resourceQuota.project)  || $scope.resourceQuota.project == null) {
			$scope.resourceQuota.project = {id:0};

		}
		$scope.showLoader = true;
		var hasResource = promiseAjax.httpTokenRequest( globalConfig.HTTP_GET , globalConfig.APP_URL + "resourceProjects/project/"+$stateParams.id);
		hasResource.then(function (result) {
			$scope.resourceQuota.project = result[0].project;
			var i=0;
			angular.forEach(result, function(object, key) {
				i++;
				if(i == 1) {
					$scope.resourceQuota.domain = result[0].domain;
					$scope.resourceQuota.department = result[0].department;
					$scope.loadEditOption($scope.projectList, $scope.resourceQuota.project, object.project);
				}
				$scope.resourceQuota[object.resourceType] = object.max;
				$scope.resourceQuota[object.resourceType+"id"] = object.id;
			});
			$scope.showLoader = false;
        });

		var hasResourceDomainId = promiseAjax.httpTokenRequest( globalConfig.HTTP_GET , globalConfig.APP_URL + "resourceDomains/quotaprojectId/"+$stateParams.id);
		hasResourceDomainId.then(function (result) {  // this is only run after $http completes
			$scope.resourceDomainCount = result;
        });

		var hasResourceDepartmentsId = promiseAjax.httpTokenRequest( globalConfig.HTTP_GET , globalConfig.APP_URL + "resourceProjects/quotaprojectId/"+$stateParams.id);
		hasResourceDepartmentsId.then(function (result) {  // this is only run after $http completes
			$scope.resourceProjectCount = result;
        });

		var hasResourceDepartmentsId = promiseAjax.httpTokenRequest( globalConfig.HTTP_GET , globalConfig.APP_URL + "resourceDepartments/quotaprojectId/"+$stateParams.id);
		hasResourceDepartmentsId.then(function (result) {  // this is only run after $http completes
			$scope.resourceDepartmentCount = result;
        });

	}

	if($stateParams.quotaType == 'project-quota') {
		$scope.getProjectResourceLimits();

	}

	if($stateParams.quotaType == 'department-quota') {
		$scope.getDepartmentResourceLimits();
	}
};
