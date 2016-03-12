/**
 *
 * projectCtrl
 *
 */

angular
    .module('homer')
    .controller('projectCtrl', projectCtrl)

function projectCtrl($scope, appService, $filter, $state,$stateParams, localStorageService, globalConfig) {

   $scope.$on(appService.globalConfig.webSocketEvents.projectEvents.createProject, function() {

  //   $scope.instanceList = appService.webSocket;
    });
  $scope.$on(appService.globalConfig.webSocketEvents.projectEvents.addUser, function() {

  //   $scope.instanceList = appService.webSocket;
    });
  $scope.$on(appService.globalConfig.webSocketEvents.projectEvents.removeUser, function() {

  //   $scope.instanceList = appService.webSocket;
    });
  $scope.$on(appService.globalConfig.webSocketEvents.projectEvents.editProject, function() {

  //   $scope.instanceList = appService.webSocket;
    });
  $scope.$on(appService.globalConfig.webSocketEvents.projectEvents.deleteProject, function() {

  //   $scope.instanceList = appService.webSocket;
    });

	$scope.global = appService.globalConfig;
    $scope.projectList = {};
    $scope.paginationObject = {};
    $scope.accountElements={

    };
    $scope.sort = {
    		column : '',
    		descending : false
    	};
    $scope.oneChecked = false;
    $scope.removeLoader = {};
    $scope.ownerLoader = {};
    $scope.project = {};
    $scope.projectAccountList = {};
    $scope.projectElements = {};
    $scope.editProjects = {};
    $scope.projectList = {};
    $scope.formElements = {};
    $scope.userLists = {};
    $scope.projectInfo = {};
    $scope.project.department = {};
    $scope.projectForm = [];
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

            var hasProjectsLists = {};
            if ($scope.domainView == null) {
            	var hasProjectsLists =  appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "projects" +"?lang=" + localStorageService.cookie.get('language') +"&sortBy="+sortOrder+sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
            } else {
            	hasProjectsLists =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "projects/listByDomain"
    				+"?lang=" +appService.localStorageService.cookie.get('language')
    				+ "&domainId="+$scope.domainView.id+"&sortBy="+$scope.paginationObject.sortOrder+$scope.paginationObject.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
            }

            hasProjectsLists.then(function(result) { // this is only run after $http
			// completes0
			$scope.projectList = result;
			$scope.projectList.Count = 0;
            if (result.length != 0) {
                $scope.projectList.Count = result.totalItems;
            }
			// For pagination
			$scope.paginationObject.limit = limit;
			$scope.paginationObject.currentPage = pageNumber;
			$scope.paginationObject.totalItems = result.totalItems;
			$scope.paginationObject.sortOrder = sortOrder;
			$scope.paginationObject.sortBy = sortBy;
			$scope.showLoader = false;
		});
	};

    $scope.list = function (pageNumber) {
        appService.globalConfig.sort.sortOrder = $scope.paginationObject.sortOrder;
        appService.globalConfig.sort.sortBy = $scope.paginationObject.sortBy;
    	$scope.showLoader = true;
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasProjects = {};
        if ($scope.domainView == null) {
        	hasProjects = appService.crudService.list("projects", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
        } else {
        	hasProjects =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "projects/listByDomain"
				+"?lang=" +appService.localStorageService.cookie.get('language')
				+ "&domainId="+$scope.domainView.id+"&sortBy="+globalConfig.sort.sortOrder+globalConfig.sort.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
        }
        hasProjects.then(function (result) {  // this is only run after $http completes0
            $scope.projectList = result;
            $scope.projectList.Count = 0;
            if (result.length != 0) {
                $scope.projectList.Count = result.totalItems;
            }

            // For pagination
            $scope.paginationObject.limit  = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
            $scope.showLoader = false;
        });
    };
    $scope.list(1);

    // Get project list based on domain selection
    $scope.selectDomainView = function(pageNumber) {
    	$scope.list(1);
    };

    var hasDomains = appService.crudService.listAll("domains/list");
	hasDomains.then(function (result) {  // this is only run after $http completes0
	      $scope.formElements.domainList = result;
	});

    $scope.changeSorting = function(column) {

		var sort = $scope.sort;

		if (sort.column == column) {
			sort.descending = !sort.descending;
		} else {
			sort.column = column;
			sort.descending = false;
		}
		return sort.descending;
	};

    $scope.edit = function (projectId) {
    	$scope.showLoader = true;
        var hasproject = appService.crudService.read("projects", projectId);
        hasproject.then(function (result) {
            $scope.projectInfo = result;
            $state.current.data.pageName = result.name;
            if (!angular.isUndefined(result.department) && result.department != null) {
            $scope.userLists(result);
            }
        	$scope.showLoader = false;
        });
    };

    if (!angular.isUndefined($stateParams.id) && $stateParams.id != '') {
    	if ($stateParams.id > 0) {
            $scope.edit($stateParams.id);
        }
    }


    $scope.userList = function (department) {
    	if(department!= null && !angular.isUndefined(department)){
    		var hasUsers = appService.crudService.listAllByFilter("users/search", department);
    		hasUsers.then(function (result) {  // this is only run after $http
											// completes0
        	$scope.projectElements.projectOwnerList = result;
        	 angular.forEach($scope.projectElements.projectOwnerList, function(obj, key) {
        			if (!angular.isUndefined($scope.project.projectOwner) && $scope.project.projectOwner != null) {
        	    			if(obj.id == $scope.project.projectOwner.id) {
        	    				$scope.project.projectOwner = obj;

        	    			}
        	    		}
        	    	});

    		});
    	}
    };

    $scope.userLists = function (project) {
       var hasUsers = appService.crudService.listAllByObject("users/project", project);
        hasUsers.then(function (result) {  // this is only run after $http completes0
        	$scope.projectElements.projectuserList = result;

        });
    };

    $scope.userListByDepartment = function (department) {
        var hasUsers = appService.crudService.listAllByObject("users/department", department);
         hasUsers.then(function (result) {  // this is only run after $http completes0
                 $scope.projectElements.projectuserList = result;

         });
     };

    $scope.read = function (project) {
        var hasProject = appService.crudService.read("projects", project);
        hasProject.then(function (result) {  // this is only run after $http completes0
        	$scope.projectInfo = result;
         });
     };

    $scope.departmentList = function (domain) {
        var hasDepartments = appService.crudService.listAllByFilter("departments/search", domain);

		    if($scope.global.sessionValues.type === 'USER') {
		    	var departments = [];
		    	var hasDepartments = appService.crudService.read("departments", $scope.global.sessionValues.departmentId);
   		    	hasDepartments.then(function (result) {
   		    		$scope.project.department = result;
   		    		if (!angular.isUndefined(result)) {
   		    		    $scope.userListByDepartment(result);
   		    		}
	    	    });
		    } else {
		    	hasDepartments.then(function (result) {  // this is only run after $http completes0
		    		$scope.formElements.departmenttypeList = result;
		    		angular.forEach($scope.formElements.departmenttypeList, function(obj, key) {
		    			if (!angular.isUndefined($scope.project.department)) {
     	    				if(obj.id == $scope.project.department.id) {
     	    				$scope.project.department = obj;

     	    				}
		    			}
		    		});

		    	});
		    }
     };

     $scope.$watch('newProject.department', function (obj) {
    	 if($scope.global.sessionValues.type !== 'USER') {
	  if (!angular.isUndefined(obj)) {
    	 	$scope.userList(obj);
    	 	 angular.forEach($scope.projectElements.projectOwnerList, function(obj, key) {
    	 		 if (!angular.isUndefined($scope.project.projectOwner) && $scope.project.projectOwner != null) {
    	   	    			if(obj.id == $scope.project.projectOwner.id) {
    	   	    				$scope.project.projectOwner = obj;

    	   				}
    	   	    		}
    	   	    	});
	   }
    	 }
         });

     $scope.$watch('newProject.domain', function (obj) {
    	 if($scope.global.sessionValues.type !== 'USER') {
   	  	if (!angular.isUndefined(obj)) {
       	 	$scope.departmentList(obj);
   	  	}
    	 }
     });

     $scope.$watch('project.department', function (obj) {
   	  if (!angular.isUndefined(obj)) {
       	 	$scope.userList(obj);
       	 	 angular.forEach($scope.projectElements.projectOwnerList, function(obj, key) {
       	 		 if (!angular.isUndefined($scope.project.projectOwner) && $scope.project.projectOwner != null) {
       	   	    			if(obj.id == $scope.project.projectOwner.id) {
       	   	    				$scope.project.projectOwner = obj;

       	   				}
       	   	    		}
       	   	    	});
    	 }
            });

        $scope.$watch('project.domain', function (obj) {
      	  	if (!angular.isUndefined(obj)) {
          	 	$scope.departmentList(obj);
      	  	}
        });

    if($scope.global.sessionValues.type !== 'ROOT_ADMIN') {
    	if(!angular.isUndefined($scope.global.sessionValues.domainId)){
    	 var hasDomain = appService.crudService.read("domains", $scope.global.sessionValues.domainId);
    	 hasDomain.then(function (result) {
    		 $scope.departmentList(result);
         });
    	}
    }

    $scope.projectElements = {
        "projectStep" : true
    };

    $scope.project = {
        oneChecked:false
    };


    $scope.checkOne = function (items) {
    	 angular.forEach($scope.projectList, function (item, key) {
             if (items.id == item.id) {
            	 if (item['isSelected']) {
            	 $scope.project.oneChecked = true;
            	 }
             }
         });
    }
    $scope.isSelected = false;

    $scope.viewProjectDetails = function(project) {
    	$scope.projectInfo = angular.copy(project);
    	if(!angular.isUndefined($scope.projectInfo.department) && $scope.projectInfo.department != null ){
    		$scope.userLists($scope.projectInfo);
    	}
        $scope.isSelected =  true;
        $scope.checkOne(project);
    };

    $scope.viewProjectd = function(project) {
    	$scope.editProjects = angular.copy(project);
    	$scope.projectInfo = angular.copy(project);
    	if(!angular.isUndefined($scope.projectInfo.department) && $scope.projectInfo.department != null ){
    		$scope.userLists($scope.projectInfo);
	}
   	 	$scope.project = $scope.editProjects;
    	$scope.oneChecked = true;
    };


    $scope.projectForm = {};
    $scope.createProject = function (size) {
    	$scope.newProject = {};
    	appService.dialogService.openDialog("app/views/project/add.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
        // add project

            if($scope.global.sessionValues.type !== 'ROOT_ADMIN') {
            	if(!angular.isUndefined($scope.global.sessionValues.domainId)){
            		 $scope.newProject.domainId = $scope.global.sessionValues.domainId;
            		 var hasDomains = appService.crudService.read("domains", $scope.global.sessionValues.domainId);
            		 hasDomains.then(function (result) {
        		    		$scope.newProject.domain = result;
     	    	    });
            	}
            }
            if($scope.global.sessionValues.type === 'USER') {
		    	var departments = [];
		    	var hasDepartments = appService.crudService.read("departments", $scope.global.sessionValues.departmentId);
   		    	hasDepartments.then(function (result) {
   		    		$scope.newProject.department = result;
	    	    });
		    }
    	  $scope.save = function (form) {
    		   	 $scope.formSubmitted = true;
    		        if (form.$valid) {
    		        	$scope.projectLoader = true;
    		        	$scope.newProject.domainId =  $scope.newProject.domain.id;
    		            var project = angular.copy($scope.newProject);

    		            project.isActive = true;
    		            project.departmentId = project.department.id;
    		            project.projectOwnerId = project.projectOwner.id;
    		            project.domain =  $scope.newProject.domain;
    		            project.domainId =  $scope.newProject.domainId;
    		            delete project.domain;
    		            delete project.department;
    		            delete project.projectOwner;
    		            $scope.formSubmitted = false;
    		            var hasProject = appService.crudService.add("projects", project);
    		            hasProject.then(function (result) {  // this is only run after $http completes
			   appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.projectEvents.createProject,result.id,$scope.global.sessionValues.id);
    		            	$scope.formSubmitted = false;
    		            	$scope.projectLoader = false;
    		           	    $scope.cancel();
    		                $scope.homerTemplate = 'app/views/notification/notify.jsp';
    		                appService.notify({message: 'Project added successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});

    		              	$scope.list(1);
    		            }).catch(function (result) {
    		            	$scope.projectLoader = false;
    		                if(result.data.fieldErrors != null ){
    		               	 var msg = result.data.fieldErrors['name'];
    		               	 appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
    		                 }
    		            });
    		        }
    		    },
    		    $scope.cancel = function () {
                    $modalInstance.close();
                };

    	}]);
    };
    $scope.addUser = function(user) {
    	 var newUser = user;
         var oldUser;
         if(newUser){ //This will avoid empty data
         angular.forEach($scope.projectInfo.userList, function(eachuser){ //For loop
         if(angular.equals(newUser.userName.toLowerCase(),eachuser.userName.toLowerCase())){ // this line will check whether the data is existing or not
        	 oldUser = true;
        	 appService.notify({message: 'User already exist', classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
             $state.reload();
         }
         });
         if(!oldUser){
        	 $scope.projectInfo.userList.push(user);
        	 var hasServer = appService.crudService.update("projects", $scope.projectInfo);
             hasServer.then(function (result) {
			   appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.projectEvents.addUser,result.id,$scope.global.sessionValues.id);
                 $scope.project.user = {};
		         $scope.userLists($scope.projectInfo);
                 appService.notify({message: 'User updated successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                 $state.reload();
             });
         }
         }
    }

    $scope.removeUser = function(user) {
    	angular.forEach($scope.projectInfo.userList, function(obj, key) {
    		if(parseInt(obj.id) == parseInt(user.id)) {
    			$scope.projectInfo.userList.splice(key, 1);
    		}
    	});
    	var hasUser = appService.crudService.updates("projects/remove/user", $scope.projectInfo);
    	hasUser.then(function(result) {
	   appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.projectEvents.removeUser,result.id,$scope.global.sessionValues.id);
            $scope.project.user = {};
            $scope.userLists($scope.projectInfo);
            appService.notify({message: 'User removed successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
            $state.reload();
        });
    };

    // Edit the project
    $scope.editProject = function (size) {
         $scope.project = $scope.editProjects;
         angular.forEach($scope.formElements.departmenttypeList, function(obj, key) {
  			if (!angular.isUndefined($scope.project.department) && $scope.project.department != null) {
  	    			if(obj.id == $scope.project.department.id) {
  	    				$scope.project.department = obj;
  				}
  	    		}
  	     });
         angular.forEach($scope.projectElements.projectOwnerList, function(obj, key) {
   			if (!angular.isUndefined($scope.project.projectOwner) && $scope.project.projectOwner != null) {
   	    			if(obj.id == $scope.project.projectOwner.id) {
   	    				$scope.project.projectOwner = obj;
   				}
   	    		}
   	     });
         angular.forEach($scope.formElements.domainList, function(obj, key) {
    			if (!angular.isUndefined($scope.project.domain) && $scope.project.domain != null) {
    	    			if(obj.id == $scope.project.domain.id) {
    	    				$scope.project.domain = obj;
    				}
    	    		}
    	 });
        appService.dialogService.openDialog("app/views/project/edit.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
                // Update project
                var project = $scope.editProjects;
                $scope.projectForm = {};

             $scope.update = function (form) {
            	 $scope.projectLoader = true;
                    $scope.formSubmitted = true;
                    if (form.$valid) {
                        var project = angular.copy($scope.project);
                        project.projectOwnerId = $scope.project.projectOwner.id;
                        project.departmentId = $scope.project.department.id;
                        project.domainId = $scope.project.domain.id;
                        delete project.domain;
    		            delete project.department;
    		            delete project.projectOwner;
                        var hasServer = appService.crudService.update("projects", project);
                        hasServer.then(function (result) {
	   appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.projectEvents.editProject,result.id,$scope.global.sessionValues.id);
                       	 $scope.projectLoader = false;
                        	$scope.oneChecked = false;
                        	$scope.formSubmitted = false;
                            appService.notify({message: 'Project Updated successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                            $modalInstance.close();
                            $scope.list(1);
                        }).catch(function (result) {
    		            	$scope.projectLoader = false;
    		                if(result.data.globalError[0] != '' && result.data.globalError[0] != null ){
    		               	 var msg = result.data.globalError[0];
    		               	 appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
    		                    }
    		                angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
    		                    $scope.projectForm[key].$invalid = true;
    		                    $scope.projectForm[key].errorMessage = errorMessage;
    		                });

    		            });
                    } else {
                        $scope.projectLoader = false;
                    }
                },
                        $scope.cancel = function () {
                            $modalInstance.close();
                        };
            }]);
    };


    // Delete the department
    $scope.projectDeleteConfirmation = function (size) {
        appService.dialogService.openDialog("app/views/project/delete.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
                var deleteObject = $scope.editProjects;
                $scope.deleteProject = function () {
                    var hasServer = appService.crudService.softDelete("projects", deleteObject);
                    hasServer.then(function (result) {
	   appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.projectEvents.deleteProject,result.id,$scope.global.sessionValues.id);
                    	$scope.oneChecked = false;
                        $scope.list(1);
                        appService.notify({message: 'Project deleted successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});

                    });
                    $modalInstance.close();
                },
                        $scope.cancel = function () {
                            $modalInstance.close();
                        };
            }]);
    };

    $scope.status = {};
    $scope.status.basic = true;
    $scope.status.password = true;

    $scope.$watch('project.totalCheckedCount', function() {
        $scope.project.oneChecked = false;
       if($scope.project.totalCheckedCount == 1) {
           $scope.project.oneChecked = true;
       }
   });

    $scope.addAccount = function(account) {
        $scope.homerTemplate = 'app/views/notification/notify.jsp';
        $scope.showLoader = true;
        $timeout(function() {
            $scope.showLoader = false;
            account.role = {id:2, name:"user"};
            if (filterFilter($scope.projectAccountList, {'name': account.name })[0] == null) {
                $scope.projectAccountList.push(angular.copy(account));
                appService.notify({message: 'Account added successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
            } else {
                appService.notify({message: 'Account already exist', classes: 'alert-danger', templateUrl: $scope.homerTemplate});

            }
        }, 2000);

    };

    $scope.deleteAccount = function(index) {

        $scope.removeLoader["index_"+index] = true;
        $timeout(function() {
            $scope.projectAccountList.splice(index, 1);
            $scope.removeLoader["index_"+index] = false;
            appService.notify({message: 'Account removed successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
        }, 2000);
    };

    $scope.makeOwner = function(index) {
        $scope.ownerLoader["index_"+index] = true;
        $timeout(function() {
            var accountList = angular.copy($scope.projectAccountList).slice().reverse();
            var b = accountList[index];
            accountList[index] = accountList[0];
            accountList[0] = b;
            $scope.projectAccountList = accountList;
            $scope.ownerLoader["index_"+index] = false;
            appService.notify({message: 'Updated successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
        }, 2000);
    }




    $scope.validateInfraLimit = function(form) {
        $scope.formSubmitted = true;
        if (form.$valid) {
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            appService.notify({message: 'Updated successfully', classes: 'alert-success', "timeOut": "1000", templateUrl: $scope.homerTemplate});
        } else {
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            appService.notify({message: 'Please fill all the fields', classes: 'alert-danger', "timeOut": "1000", templateUrl: $scope.homerTemplate});
        }
    };

    $scope.accounts = {
            category: "users",
            oneItemSelected: {},
            selectedAll: {},
            totalcount: 0
        };


};
