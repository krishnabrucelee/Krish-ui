
angular
        .module('homer')
        .controller('rolesListCtrl', rolesListCtrl)


 function rolesListCtrl($scope, $window, $state, modalService, crudService, notify, promiseAjax, dialogService, $stateParams) {

    $scope.formElements = {
    };
    $scope.ids = {};
    $scope.role = {
        department: {}
    };
    $scope.paginationObject = {};
    $scope.RoleForm = {};
    $scope.global = crudService.globalConfig;
    $scope.userList = {};
    $scope.roleList = {};

    // Role List
    $scope.list = function (pageNumber) {
    	$scope.showLoader = true;
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasRoles = crudService.list("roles", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
        hasRoles.then(function (result) {  // this is only run after $http completes0
            $scope.roleList = result;
            console.log($scope.roleList);
            // For pagination
            $scope.paginationObject.limit  = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
            $scope.showLoader = false;
        });
    };
    $scope.list(1);

    // Department list from server
    $scope.role.department = {};
    var hasDepartment = crudService.listAll("departments/list");
    hasDepartment.then(function (result) {  // this is only run after $http completes0
    	$scope.formElements.departmentList = result;
    });

    // Load permission

    $scope.permissions = {};
    var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
    var hasPermissions = promiseAjax.httpTokenRequest( crudService.globalConfig.HTTP_GET, crudService.globalConfig.APP_URL + "permissions/list");

    hasPermissions.then(function (result) {  // this is only run after $http completes0
    	  $scope.showLoader = true;
    	$scope.permissions = result;
        $scope.showLoader = false;

    });

    // Create a new role to our application
    $scope.role = {};
    $scope.permissionList = [];
    $scope.createRole = function (form) {
        $scope.formSubmitted = true;
        if (form.$valid) {
        	$scope.showLoader = true;
            $scope.role.permissionList = [];
            angular.forEach($scope.permissions, function(permission, key) {
            	if($scope.permissionList[permission.id]) {
            		$scope.role.permissionList.push(permission);
            	}
            })
            var role = $scope.role;
            var hasServer = crudService.add("roles", role);
            hasServer.then(function (result) {  // this is only run after $http completes
            	$scope.showLoader = false;
            	$scope.list(1);
                notify({message: 'Added successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                $window.location.href = '#/roles';
            }).catch(function (result) {
                if (!angular.isUndefined(result.data)) {
                    if (result.data.globalError != '' && !angular.isUndefined(result.data.globalError)) {
                        var msg = result.data.globalError[0];
                        $scope.showLoader = false;
                        notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                    } else if (result.data.fieldErrors != null) {
                        angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                            $scope.attachvolumeForm[key].$invalid = true;
                            $scope.attachvolumeForm[key].errorMessage = errorMessage;
                        });
                    }
                }

            });
        }
    };
        $scope.edit = function (roleId) {
            var hasRole = crudService.read("roles", roleId);
            hasRole.then(function (result) {
                $scope.role = result;
                angular.forEach($scope.role.permissionList, function(permission, key) {
                	$scope.permissionList[permission.id] = true;
                });
            	angular.forEach($scope.formElements.departmentList, function(obj, key) {
    	    		if(obj.id == $scope.role.department.id) {
    	    			$scope.role.department = obj;
    	    		}
    	    	});

            });

        };


        if (!angular.isUndefined($stateParams.id) && $stateParams.id != '') {
            $scope.edit($stateParams.id)
        }

        $scope.update = function (form) {
            $scope.formSubmitted = true;
            if (form.$valid) {
            	$scope.showLoader = true;
            	$scope.role.permissionList = [];
                angular.forEach($scope.permissions, function(permission, key) {
                	if($scope.permissionList[permission.id]) {
                   		$scope.role.permissionList.push(permission);
                   	}
                })
            	var role = $scope.role;
                var hasServer = crudService.update("roles", role);
                hasServer.then(function (result) {
                	$scope.showLoader = false;
                $scope.homerTemplate = 'app/views/notification/notify.jsp';
                notify({message: 'Updated successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
                $window.location.href = '#/roles';
                }).catch(function (result) {
                    if (!angular.isUndefined(result.data)) {
                        if (result.data.globalError != '' && !angular.isUndefined(result.data.globalError)) {
                            var msg = result.data.globalError[0];
                            $scope.showLoader = false;
                            notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                        } else if (result.data.fieldErrors != null) {
                            angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                                $scope.attachvolumeForm[key].$invalid = true;
                                $scope.attachvolumeForm[key].errorMessage = errorMessage;
                            });
                        }
                    }

                });
            }
        };


    $scope.delete = function (size, role) {
        dialogService.openDialog("app/views/roles/confirm-delete.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
                $scope.deleteId = role.id;
                $scope.ok = function (id) {
                	$scope.showLoader = true;
                	role.isActive = false;
                    var hasRole = crudService.softDelete("roles", role);
                    hasRole.then(function (result) {
                    	$scope.showLoader = false;
                        $scope.list(1);
                        $scope.homerTemplate = 'app/views/notification/notify.jsp';
                        notify({message: 'Deleted successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
                        $modalInstance.close();
                    }).catch(function (result) {
                        if (!angular.isUndefined(result) && result.data != null) {
                            if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                                var msg = result.data.globalError[0];
                                $scope.showLoader = false;
                                notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                            }
                            angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                                $scope.addnetworkForm[key].$invalid = true;
                                $scope.addnetworkForm[key].errorMessage = errorMessage;
                            });
                        }
                    });

                },
                        $scope.cancel = function () {
                            $modalInstance.close();
                        };
            }]);
    };

    $scope.permissionGroup = {};
    $scope.checkAll = function (permissionModule, key) {
        if ($scope.permissionGroup[key]) {
            $scope.permissionGroup[key] = true;
        } else {
            $scope.permissionGroup[key] = false;
        }
        angular.forEach(permissionModule, function (permission, permissionKey) {
            $scope.permissionList[permission.id] = $scope.permissionGroup[key];
        });

    };

     $scope.checkOne = function (permission, permissionModule) {
        var i=0;

        if (!$scope.permissionList[permission.id]) {

        	$scope.permissionList[permission.id] = false;
        } else {
        	$scope.permissionList[permission.id] = true;
        }
		 angular.forEach(permissionModule, function (object) {
			 if ($scope.permissionList[object.id]) {
				 i++;
			 }
		 });

        if(i == permissionModule.length) {
        	$scope.permissionGroup[permissionModule[0].module] = true;
        } else {
        	$scope.permissionGroup[permissionModule[0].module] = false;
        }

    };

    // Opened user add window
    $scope.assignRole = function (size) {
        dialogService.openDialog("app/views/roles/assign-role.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
            // Getting list of users and roles by department
        $scope.getUsersByDepartment = function(department) {
        	var hasUsers =  promiseAjax.httpTokenRequest( crudService.globalConfig.HTTP_GET, crudService.globalConfig.APP_URL + "users"  +"/department/"+department.id);
        	hasUsers.then(function (result) {  // this is only run after $http completes0
        		$scope.userList = result;
        	});

        	var hasRoles =  promiseAjax.httpTokenRequest( crudService.globalConfig.HTTP_GET, crudService.globalConfig.APP_URL + "roles"  +"/department/"+department.id);
        	hasRoles.then(function (result) {  // this is only run after $http completes0
        		$scope.roleList = result;
        	});
        };

       // Assign a new role to our user
        $scope.userRoleList = [];
        $scope.assignRoleSave = function (form) {
        	$scope.formSubmitted = true;
        	$scope.formSubmitted = true;
        	var assignedUsers = [];
        	angular.forEach($scope.userList, function(obj, key) {
        		var userObject = {};
        		userObject = obj;
        		userObject.role = $scope.userRoleList[obj.id];
        		assignedUsers.push(userObject);
        	});

        	console.log(assignedUsers);
        	if (form.$valid) {
        		var hasServer = crudService.add("users/assignRole", assignedUsers);
        		hasServer.then(function (result) {  // this is only run after $http completes
        			$scope.list(1);
        			notify({message: 'Assigned successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
        			$modalInstance.close();
        		}).catch(function (result) {
        			if(!angular.isUndefined(result) && result.data != null) {
        				angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
        					$scope.RoleForm[key].$invalid = true;
        					$scope.RoleForm[key].errorMessage = errorMessage;
        				});
        			}
        		});
        	}
        	},
        	   $scope.cancel = function () {
                $modalInstance.close();
            };
        }]);
    };


    // Opened user edit window
    $scope.editAssignedRole = function (size) {
        dialogService.openDialog("app/views/roles/edit-assigned-role.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
            // Getting list of users and roles by department
        $scope.getUsersByDepartment = function(department) {
        	var hasUsers =  promiseAjax.httpTokenRequest( crudService.globalConfig.HTTP_GET, crudService.globalConfig.APP_URL + "users"  +"/department/"+department.id);
        	hasUsers.then(function (result) {  // this is only run after $http completes0
        		$scope.userList = result;
        	});

          	var hasRoles =  promiseAjax.httpTokenRequest( crudService.globalConfig.HTTP_GET, crudService.globalConfig.APP_URL + "roles"  +"/department/"+department.id);
        	hasRoles.then(function (result) {  // this is only run after $http completes0
        		$scope.roleList = result;
        	});
        };

       // Assign a new role to our user
        $scope.userRoleList = [];
        $scope.editAssignedRoleSave = function (form) {
        	$scope.formSubmitted = true;
        	var assignedUsers = [];
        	angular.forEach($scope.userList, function(obj, key) {
        		var userObject = {};
        		userObject = obj;
        		userObject.role = $scope.userRoleList[obj.id];
        		assignedUsers.push(userObject);
        	});

        	console.log(assignedUsers);
        	if (form.$valid) {
        		var hasServer = crudService.add("users/assignRole", assignedUsers);
        		hasServer.then(function (result) {  // this is only run after $http completes
        			$scope.list(1);
        			notify({message: 'Updated successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
        			$modalInstance.close();
        		}).catch(function (result) {
        			if(!angular.isUndefined(result) && result.data != null) {
        				angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
        					$scope.RoleForm[key].$invalid = true;
        					$scope.RoleForm[key].errorMessage = errorMessage;
        				});
        			}
        		});
        	}
        	},
        	   $scope.cancel = function () {
                $modalInstance.close();
            };
        }]);
    };

}