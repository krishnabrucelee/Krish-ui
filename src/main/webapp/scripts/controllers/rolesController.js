angular
        .module('homer')
        .controller('rolesListCtrl', rolesListCtrl)

 function rolesListCtrl($scope, $state, appService, $window, $stateParams, localStorageService, globalConfig) {



  $scope.$on(appService.globalConfig.webSocketEvents.roleEvents.createRole, function() {

  //   $scope.roleList = appService.webSocket;
    });
  $scope.$on(appService.globalConfig.webSocketEvents.roleEvents.updateRole, function() {

  //   $scope.roleList = appService.webSocket;
    });
  $scope.$on(appService.globalConfig.webSocketEvents.roleEvents.deleteRole, function() {

  //   $scope.roleList = appService.webSocket;
    });
  $scope.$on(appService.globalConfig.webSocketEvents.roleEvents.assignRole, function() {

  //   $scope.roleList = appService.webSocket;
    });

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
    $scope.paginationObject.sortOrder = '+';
    $scope.paginationObject.sortBy = 'name';
    $scope.changeSort = function(sortBy, pageNumber) {
			var sort = appService.globalConfig.sort;
			if (sort.column == sortBy) {
				sort.descending = !sort.descending;
			} else {
				sort.column = sortBy;
				sort.descending = false;
			}
			var sortOrder = '-';
			if(!sort.descending){
				sortOrder = '+';
			}
			$scope.paginationObject.sortOrder = sortOrder;
			$scope.paginationObject.sortBy = sortBy;
			$scope.showLoader = true;
			var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;

            var hasRoleLists = {};
//            if ($scope.domainView == null) {
//            	hasRoleLists =  appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "roles" +"?lang=" + localStorageService.cookie.get('language') +"&sortBy="+sortOrder+sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
//            } else {
//            	hasRoleLists =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "roles/listByDomain"
//    				+"?lang=" +appService.localStorageService.cookie.get('language')
//    				+ "&domainId="+$scope.domainView.id+"&sortBy="+$scope.paginationObject.sortOrder+$scope.paginationObject.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
//            }

            $scope.filter = "";
            if ($scope.filterView == null && $scope.roleSearch == null) {
            	hasRoleLists =  appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "roles" +"?lang=" + localStorageService.cookie.get('language') +"&sortBy="+sortOrder+sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
            } else {
                if ($scope.filterView != null && $scope.roleSearch == null) {
                    $scope.filter = "&domainId=" + $scope.filterView.id + "&searchText=" + "&filterParameter=" + $scope.filterParamater;
                } else if ($scope.filterView == null && $scope.roleSearch != null) {
                    $scope.filter = "&domainId=0" + "&searchText=" + $scope.roleSearch + "&filterParameter=" + $scope.filterParamater;
                } else {
                    $scope.filter = "&domainId=" + $scope.filterView.id + "&searchText=" + $scope.roleSearch + "&filterParameter=" + $scope.filterParamater;
                }
              hasRoleLists =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "roles/listByDomain"
        		+"?lang=" +appService.localStorageService.cookie.get('language')
        		+ encodeURI($scope.filter) +"&sortBy="+$scope.paginationObject.sortOrder+$scope.paginationObject.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
            }

			hasRoleLists.then(function(result) { // this is only run after $http
				// completes0
				$scope.roleList = result;
				$scope.roleList.Count = 0;
	            if (result.length != 0) {
	                $scope.roleList.Count = result.totalItems;
	            }
				// For pagination
				$scope.paginationObject.limit = limit;
				$scope.paginationObject.currentPage = pageNumber;
				$scope.paginationObject.totalItems = result.totalItems;
				$scope.paginationObject.sortOrder = sortOrder;
				$scope.paginationObject.sortBy = sortBy;
				$scope.showLoader = false;
			});

//           if ($scope.global.sessionValues.type === 'USER' || $scope.global.sessionValues.type === 'DOMAIN_ADMIN') {
//                if ($scope.global.sessionValues.domainId != null && $scope.roleSearch == null) {
//                    $scope.filter = "&domainId=" + $scope.global.sessionValues.domainId + "&searchText=";
//                } else if ($scope.global.sessionValues.domainId == null && $scope.roleSearch != null) {
//                    $scope.filter = "&domainId=0" + "&searchText=" + $scope.roleSearch;
//                } else {
//                    $scope.filter = "&domainId=" + $scope.global.sessionValues.domainId + "&searchText=" + $scope.roleSearch;
//                }
//              hasRoleLists =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "roles/listByDomain"
//        		+"?lang=" +appService.localStorageService.cookie.get('language')
//        		+ $scope.filter+"&sortBy="+$scope.paginationObject.sortOrder+$scope.paginationObject.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
//
//
//			hasRoleLists.then(function(result) { // this is only run after $http
//				// completes0
//				$scope.roleList = result;
//				$scope.roleList.Count = 0;
//	            if (result.length != 0) {
//	                $scope.roleList.Count = result.totalItems;
//	            }
//				// For pagination
//				$scope.paginationObject.limit = limit;
//				$scope.paginationObject.currentPage = pageNumber;
//				$scope.paginationObject.totalItems = result.totalItems;
//				$scope.paginationObject.sortOrder = sortOrder;
//				$scope.paginationObject.sortBy = sortBy;
//				$scope.showLoader = false;
//			});
//    }
		};


    // Role List
    $scope.list = function (pageNumber) {
        appService.globalConfig.sort.sortOrder = $scope.paginationObject.sortOrder;
        appService.globalConfig.sort.sortBy = $scope.paginationObject.sortBy;
    	$scope.showLoader = true;
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasRoles = {};
        $scope.filter = "";
        if ($scope.filterView == null && $scope.roleSearch == null) {
        	hasRoles = appService.crudService.list("roles", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
        } else {
            if ($scope.filterView != null && $scope.roleSearch == null) {
                $scope.filter = "&domainId=" + $scope.filterView.id + "&searchText=" + "&filterParameter=" + $scope.filterParamater;
            } else if ($scope.filterView == null && $scope.roleSearch != null) {
                $scope.filter = "&domainId=0" + "&searchText=" + $scope.roleSearch + "&filterParameter=" + $scope.filterParamater;
            } else {
                $scope.filter = "&domainId=" + $scope.filterView.id + "&searchText=" + $scope.roleSearch + "&filterParameter=" + $scope.filterParamater;
            }
        	hasRoles =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "roles/listByDomain"
			+"?lang=" +appService.localStorageService.cookie.get('language')
			+ encodeURI($scope.filter)+ "&sortBy="+globalConfig.sort.sortOrder+globalConfig.sort.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
        }
        hasRoles.then(function (result) {  // this is only run after $http
            $scope.roleList = result;
            $scope.roleList.Count = 0;
            if (result.length != 0) {
                $scope.roleList.Count = result.totalItems;
            }

            // For pagination
            $scope.paginationObject.limit  = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
            $scope.showLoader = false;
        });

//        if ($scope.global.sessionValues.type === 'USER' || $scope.global.sessionValues.type === 'DOMAIN_ADMIN') {
//            if ($scope.global.sessionValues.domainId != null && $scope.roleSearch == null) {
//                $scope.filter = "&domainId=" + $scope.global.sessionValues.domainId + "&searchText=";
//            } else if ($scope.global.sessionValues.domainId == null && $scope.roleSearch != null) {
//                $scope.filter = "&domainId=0" + "&searchText=" + $scope.roleSearch;
//            } else {
//                $scope.filter = "&domainId=" + $scope.global.sessionValues.domainId + "&searchText=" + $scope.roleSearch;
//            }
//        	hasRoles =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "roles/listByDomain"
//			+"?lang=" +appService.localStorageService.cookie.get('language')
//			+ $scope.filter +"&sortBy="+globalConfig.sort.sortOrder+globalConfig.sort.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
//
//        hasRoles.then(function (result) {  // this is only run after $http
//            $scope.roleList = result;
//            $scope.roleList.Count = 0;
//            if (result.length != 0) {
//                $scope.roleList.Count = result.totalItems;
//            }
//
//            // For pagination
//            $scope.paginationObject.limit  = limit;
//            $scope.paginationObject.currentPage = pageNumber;
//            $scope.paginationObject.totalItems = result.totalItems;
//            $scope.showLoader = false;
//        });
//    }
    };
    $scope.list(1);

    // Get role list based on domain selection
    $scope.selectDomainView = function(domainfilter) {
    	$scope.filterView = domainfilter;
    	$scope.filterParamater = 'domain';
    	$scope.list(1);
    };

    // Get volume list based on domain selection
    $scope.selectDepartmentView = function(departmentView) {
    	$scope.filterView = departmentView;
    	$scope.filterParamater = 'department';
    	$scope.list(1);
    };

    // Get volume list based on domain selection
    $scope.selectProjectView = function(projectView) {
    	$scope.filterView = projectView;
    	$scope.filterParamater = 'project';
    	$scope.list(1);
    };

    // Get role search list based on quick search
    $scope.roleSearch = null;
    $scope.searchList = function(roleSearch) {
    	if ($scope.global.sessionValues.type == 'ROOT_ADMIN') {
    		$scope.filterParamater = 'domain';
    	}
    	if ($scope.global.sessionValues.type == 'DOMAIN_ADMIN') {
    		$scope.filterParamater = 'department';
    	}
    	if ($scope.global.sessionValues.type == 'USER') {
    		$scope.filterParamater = 'project';
    	}
        $scope.roleSearch = roleSearch;
        $scope.list(1);
    };

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

    if($scope.global.sessionValues.type === 'USER') {
		var hasUsers = appService.crudService.read("users", $scope.global.sessionValues.id);
        hasUsers.then(function (result) {
            if (!angular.isUndefined(result)) {
            	$scope.userElement = result;
            }
        });
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
		 $scope.showLoader = false;
            	$scope.list(1);
            	appService.notify({message: 'Added successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                $window.location.href = '#/organization/roles';
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
            $state.current.data.pageName = result.name;
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
            $window.location.href = '#/organization/roles';
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


    $scope.getDepartmentsByDomain = function (domain) {

        $scope.showLoaderDetail = true;

        if ($scope.global.sessionValues.type === 'USER') {
            var departments = [];
            var hasDepartments = appService.crudService.read("departments", $scope.global.sessionValues.departmentId);
            hasDepartments.then(function (result) {
                $scope.formElements.departments = result;
            });
        } else {
            var hasDepartments = appService.crudService.listAllByFilter("departments/search", domain);
            hasDepartments.then(function (result) {  // this is only run after $http completes0
                $scope.formElements.departments = result;
            });
        }
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
    	    $scope.role.domain = {};

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
	    	    	$scope.formElements.departments = result;
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
				delete userObject.role;
				delete userObject.department;
				delete userObject.domain;
				assignedUsers.push(userObject);
        	});
        	if(appService.globalConfig.sessionValues.type != "USER" && ($scope.role.department == "" || angular.isUndefined($scope.role.department))) {
        		appService.notify({message: "Please choose the department", classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
        	}
        	else if(assignedUsers.length == 0) {
        		appService.notify({message: "No users are there to assign role", classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
        	}
        	if (form.$valid && assignedUsers.length > 0) {
        		var hasServer = appService.crudService.add("users/assignRole", assignedUsers);
        		hasServer.then(function (result) {  // this is only run after
	                        $scope.list(1);
        			appService.notify({message: 'Assigned successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
        			$scope.role.department = "";
            		$scope.role.domain = "";
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
        		$scope.role.domain = "";
                $modalInstance.close();
            };
        }]);
    };
}

