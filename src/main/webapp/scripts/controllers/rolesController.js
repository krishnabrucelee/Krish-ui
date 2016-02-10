angular
        .module('homer')
        .controller('rolesListCtrl', rolesListCtrl)

 function rolesListCtrl($scope, appService, $window, $stateParams) {

    $scope.formElements = {};
    $scope.sort = appService.globalConfig.sort;
    $scope.changeSorting = appService.utilService.changeSorting;
    $scope.ids = {};
    $scope.role = {
        department: {}
    };
    $scope.paginationObject = {};
    $scope.RoleForm = {};
    $scope.global = appService.globalConfig;
    $scope.userList = {};
    $scope.roleList = {};

    // Role List
    $scope.list = function (pageNumber) {
    	$scope.showLoader = true;
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasRoles = appService.crudService.list("roles", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
        hasRoles.then(function (result) {  // this is only run after $http
            $scope.roleList = result;
            // For pagination
            $scope.paginationObject.limit  = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
            $scope.showLoader = false;
        });
    };
    $scope.list(1);


    // Load permission

    function listPermissions() {
	    $scope.permissions = {};
	    $scope.showLoader = {};
	    var hasPermissions = appService.promiseAjax.httpTokenRequest(appService.crudService.globalConfig.HTTP_GET, appService.crudService.globalConfig.APP_URL + "permissions/list");
	    hasPermissions.then(function (result) {  // this is only run after $http
	    	$scope.permissions = result;
	    	$scope.showLoader = false;
	    });
    }
    listPermissions();

    // Load domain
    $scope.domain = {};
    var hasDomains = appService.crudService.listAll("domains/list");
    hasDomains.then(function (result) {  // this is only run after $http
											// completes0
    	$scope.formElements.domainList = result;
    });

    // Department list load based on the domain
    $scope.domainChange = function() {
        $scope.domains = {};
        var hasDepartmentList = appService.crudService.listAllByFilter("departments/search", $scope.role.domain);
        hasDepartmentList.then(function (result) {
    	    $scope.formElements.departmentList = result;
        });
    };

    $scope.departmentList = {};
    $scope.getDepartmentList = function (domain) {
        var hasDepartments = appService.crudService.listAllByFilter("departments/search", domain);
        hasDepartments.then(function (result) {
            $scope.departmentList = result;
        });
    };

    if ($scope.global.sessionValues.type != "ROOT_ADMIN") {
        var domain = {};
        domain.id = $scope.global.sessionValues.domainId;
        $scope.getDepartmentList(domain);
    }

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

            var role = angular.copy($scope.role);
            if(!angular.isUndefined($scope.role.department) && role.department != null) {
            	role.departmentId = role.department.id;
            	delete role.department;
            }
            if(!angular.isUndefined($scope.role.domain) && role.domain != null) {
            	role.domainId = role.domain.id;
            	delete role.domain;
            }
            var hasServer = appService.crudService.add("roles", role);
            hasServer.then(function (result) {  // this is only run after $http
												// completes
            	$scope.showLoader = false;
            	$scope.list(1);
            	appService.notify({message: 'Added successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                $window.location.href = '#/roles';
            }).catch(function (result) {
            	if (!angular.isUndefined(result) && result.data != null) {
                    if (result.data.globalError[0] != '') {
                        var msg = result.data.globalError[0];
                        $scope.showLoader = false;
                        appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                    }
            angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                $scope.RoleForm[key].$invalid = true;
                $scope.RoleForm[key].errorMessage = errorMessage;
            });

    		}
        });
        }
    };

    $scope.edit = function (roleId) {
    	$scope.permissionGroupCount = [];
        var hasRole = appService.crudService.read("roles", roleId);
        hasRole.then(function (result) {
            $scope.role = result;
            var permissionGroupCount = [];
            angular.forEach($scope.role.permissionList, function(permission, key) {
            	$scope.permissionList[permission.id] = true;
            	if(isNaN($scope.permissionGroupCount[permission.module])) {
            		$scope.permissionGroupCount[permission.module] = 0;
            	}
            	$scope.permissionGroupCount[permission.module]++;
            });
        	angular.forEach($scope.formElements.departmentList, function(obj, key) {
	    		if(obj.id == $scope.role.department.id) {
	    			$scope.role.department = obj;
	    		}
	    	});

        	angular.forEach($scope.formElements.domainList, function(obj, key) {
	    		if(obj.id == $scope.role.domain.id) {
	    			$scope.role.domain = obj;
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
        	var role = angular.copy($scope.role);
            if(!angular.isUndefined($scope.role.department) && role.department != null) {
            	role.departmentId = role.department.id;
            	delete role.department;
            }
            if(!angular.isUndefined($scope.role.domain) && role.domain != null) {
            	role.domainId = role.domain.id;
            	delete role.domain;
            }
            var hasServer = appService.crudService.update("roles", role);
            hasServer.then(function (result) {
            	$scope.showLoader = false;
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            appService.notify({message: 'Updated successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
            $window.location.href = '#/roles';
            }).catch(function (result) {
                if (!angular.isUndefined(result.data)) {
                	$scope.showLoader = false;
                    if (result.data.fieldErrors != null) {
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
    	appService.dialogService.openDialog("app/views/roles/confirm-delete.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
                $scope.deleteId = role.id;
                $scope.ok = function (id) {
                	$scope.showLoader = true;
                	role.isActive = false;
                    if(!angular.isUndefined($scope.role.department) && role.department != null) {
                    	role.departmentId = role.department.id;
                    	delete role.department;
                    }
                    if(!angular.isUndefined($scope.role.domain) && role.domain != null) {
                    	role.domainId = role.domain.id;
                    	delete role.domain;
                    }

                    var hasRole = appService.crudService.softDelete("roles", role);
                    hasRole.then(function (result) {
                    	$scope.showLoader = false;
                        $scope.list(1);
                        $scope.homerTemplate = 'app/views/notification/notify.jsp';
                        appService.notify({message: 'Deleted successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
                        $modalInstance.close();
                    }).catch(function (result) {
                        if (!angular.isUndefined(result) && result.data != null) {
                            if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                                var msg = result.data.globalError[0];
                                $scope.showLoader = false;
                                appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
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

    $scope.checkAllPermissions = function(permissions) {
		var permissionModules = [];
		var unchecked = false;
		for(var i=0; i< permissions.length; i++) {
			if (!$scope.permissionGroup[permissions[i].module] || angular.isUndefined($scope.permissionGroup[permissions[i].module])) {
				unchecked = true;
				break;
			}
		}


		for(var i=0; i< permissions.length; i++) {
			if (unchecked) {
				$scope.permissionGroup[permissions[i].module]= true;
				$scope.permissionList[permissions[i].id] = true;
			} else {
				$scope.permissionGroup[permissions[i].module]= false;
				$scope.permissionList[permissions[i].id] = false;
			}
		}
    }

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
    	appService.dialogService.openDialog("app/views/roles/assign-role.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
    		$scope.userRolePermissionList = {};
            $scope.userRoleList= [];
    	    // Department list from server
    	    $scope.role.department = {};

    	 // Getting list of users and roles by department
    	    $scope.getUsersByDepartment = function(department) {
        	var hasUsers =  appService.promiseAjax.httpTokenRequest(appService.crudService.globalConfig.HTTP_GET, appService.crudService.globalConfig.APP_URL + "users"  +"/department/"+department.id);
        	hasUsers.then(function (result) {  // this is only run after $http
												// completes0
        		$scope.userList = result;
        		if(angular.isUndefined($scope.userRoleList))
        			$scope.userRoleList = [];
    			var hasRoles =  appService.promiseAjax.httpTokenRequest(appService.crudService.globalConfig.HTTP_GET, appService.crudService.globalConfig.APP_URL + "roles"  +"/department/"+department.id);
            	hasRoles.then(function (result) {  // this is only run after
													// $http completes0
            		$scope.roleList = result;

            		angular.forEach($scope.roleList, function(roleObj, rkey) {
        				$scope.userRoleList[roleObj.id] = roleObj;
            		});
        			angular.forEach($scope.userList, function(obj, key) {
        				if(angular.isUndefined($scope.userRolePermissionList)) {
        					$scope.userRolePermissionList = {};
        				}
            			if(!angular.isUndefined(obj.role) && obj.role != null && obj.role != "") {
        					$scope.userRolePermissionList[obj.id] = obj.role.id;
            			}
            		});
            	});
        	});
        };

    	    var sessionValues = appService.globalConfig.sessionValues;
    	    $scope.userType = sessionValues.type;
    	    if(sessionValues.type != "USER") {
	    	    var hasDepartment = appService.crudService.listAll("departments/list");
	    	    hasDepartment.then(function (result) {  // this is only run after
														// $http completes0
	    	    	$scope.formElements.departmentList = result;
	    	    });
    	    } else {
    	    	var hasDepartment = appService.crudService.read("departments", sessionValues.departmentId);
	    	    hasDepartment.then(function (result) {  // this is only run after
	    	    	$scope.department = result;
	    	    	$scope.getUsersByDepartment(result);
	    	    });
    	    }

       // Assign a new role to our user
        $scope.role.department = "";
        $scope.assignRoleSave = function (form) {
        	$scope.formSubmitted = true;
        	var assignedUsers = [];
        	angular.forEach($scope.userList, function(obj, key) {
        		var userObject = {};
        		userObject = obj;
        		var userRoleId = $scope.userRolePermissionList[obj.id];
				if(angular.isUndefined($scope.userRoleList[userRoleId])){
					userObject.roleId = "";
				} else {
					userObject.roleId = userRoleId;
				}
				assignedUsers.push(userObject);
        	});
        	if (form.$valid && assignedUsers.length > 0) {
        		var hasServer = appService.crudService.add("users/assignRole", assignedUsers);
        		hasServer.then(function (result) {  // this is only run after
													// $http completes
        			$scope.list(1);
        			appService.notify({message: 'Assigned successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
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
        		$scope.role.department = "";
                $modalInstance.close();
            };
        }]);
    };
}

