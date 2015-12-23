/**
 *
 * projectCtrl
 *
 */

angular
    .module('homer')
    .controller('projectCtrl', projectCtrl)

function projectCtrl($scope, promiseAjax, $modal, $state, modalService, dialogService, globalConfig,crudService,$stateParams, notify) {
	$scope.global = globalConfig;
    $scope.projectList = {};
    $scope.paginationObject = {};
    $scope.accountElements={

    };
    $scope.oneChecked = false;
    $scope.removeLoader = {};
    $scope.ownerLoader = {};
    $scope.project = {};
    $scope.projectAccountList = {};
    $scope.projectElements = {};
    $scope.projectForm = {};
    $scope.editProjects = {};
    $scope.projectList = {};
    $scope.formElements = {};
    $scope.userLists = {};
    $scope.projectInfo = {};
    $scope.project.department = {};
    $scope.global = crudService.globalConfig;

    $scope.list = function (pageNumber) {
    	$scope.showLoader = true;
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasProjects = crudService.list("projects", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
        hasProjects.then(function (result) {  // this is only run after $http completes0
            $scope.projectList = result;
            // For pagination
            $scope.paginationObject.limit  = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
            $scope.showLoader = false;
        });
    };
    $scope.list(1);

    $scope.edit = function (projectId) {
    	$scope.showLoader = true;
        var hasproject = crudService.read("projects", projectId);
        hasproject.then(function (result) {
            $scope.projectInfo = result;
            $state.current.data.pageName = result.name;
            console.log(result.department);
            if (!angular.isUndefined(result.department) && result.department != null) {
            console.log(result.department);
            $scope.userLists(result.department);
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
    	console.log(department);
    	if(department!= null && !angular.isUndefined(department)){
    		var hasUsers = crudService.listAllByFilter("users/search", department);
    		hasUsers.then(function (result) {  // this is only run after $http
											// completes0
        	$scope.projectElements.projectOwnerList = result;
        	 angular.forEach($scope.projectElements.projectOwnerList, function(obj, key) {
        			if (!angular.isUndefined($scope.project.projectOwner) && $scope.project.projectOwner != null) {
        	    			if(obj.id == $scope.project.projectOwner.id) {
        	    				$scope.project.projectOwner = obj;
        	    				console.log($scope.project.projectOwner);
        				}
        	    		}
        	    	});

    		});
    	}
    };

    $scope.userLists = function (department) {
    	console.log(department);
       var hasUsers = crudService.listAllByFilter("users/search", department);
        hasUsers.then(function (result) {  // this is only run after $http completes0
        	$scope.projectElements.projectuserList = result;

        });
    };

    $scope.read = function (project) {
        var hasProject = crudService.read("projects", project);
        hasProject.then(function (result) {  // this is only run after $http completes0
        	$scope.projectInfo = result;
         });
     };


    $scope.departmentList = function () {
        var hasDepartments = crudService.listAll("departments/list");
        hasDepartments.then(function (result) {  // this is only run after $http completes0
        	 $scope.formElements.departmenttypeList = result;
        	 angular.forEach($scope.formElements.departmenttypeList, function(obj, key) {
     			if (!angular.isUndefined($scope.project.department)) {
     	    			if(obj.id == $scope.project.department.id) {
     	    				$scope.project.department = obj;
     	    				console.log($scope.project.department);
     				}
     	    		}
     	    	});

         });
     };

     $scope.$watch('project.department', function (obj) {
	  if (!angular.isUndefined(obj)) {
    	 	$scope.userList(obj);
    	 	 angular.forEach($scope.projectElements.projectOwnerList, function(obj, key) {
    	 		 if (!angular.isUndefined($scope.project.projectOwner) && $scope.project.projectOwner != null) {
    	   	    			if(obj.id == $scope.project.projectOwner.id) {
    	   	    				$scope.project.projectOwner = obj;
    	   	    				console.log($scope.project.projectOwner);
    	   				}
    	   	    		}
    	   	    	});
	   }
         });

     $scope.departmentList();

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
    	$scope.userLists($scope.projectInfo.department);
    	}
        $scope.isSelected =  true;
        $scope.checkOne(project);
    };

    $scope.viewProjectd = function(project) {
    	$scope.editProjects = angular.copy(project);
    	$scope.projectInfo = angular.copy(project);
    	if(!angular.isUndefined($scope.projectInfo.department) && $scope.projectInfo.department != null ){
    	$scope.userLists($scope.projectInfo.department);}
   	 	$scope.project = $scope.editProjects;
    	$scope.oneChecked = true;
    };


     $scope.createProject = function (size) {
         modalService.trigger('app/views/project/add.jsp', size);
    };

    $scope.addUser =function(user){

    	 var newUser = user;
         var oldUser;
         if(newUser){ //This will avoid empty data
         angular.forEach($scope.projectInfo.userList, function(eachuser){ //For loop
         if(newUser.userName.toLowerCase() == eachuser.userName.toLowerCase()){ // this line will check whether the data is existing or not
        	 oldUser = true;
        	 notify({message: 'User already added ', classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
         }
         });
         if(!oldUser){
        	 $scope.projectInfo.userList.push(user);
        	 var hasServer = crudService.update("projects", $scope.projectInfo);
             hasServer.then(function (result) {
                 notify({message: 'User updated successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
             });
         }
         }

    }

    $scope.removeUser = function(user){
    	angular.forEach($scope.projectInfo.userList, function(obj, key) {
    		if(obj.id == user.id) {
    			$scope.projectInfo.userList.splice(key, 1);
    		}
    	});
    	var hasServer = crudService.update("projects", $scope.projectInfo);
        hasServer.then(function (result) {
            notify({message: 'User removed successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});

        });
    };

    // Edit the project
    $scope.editProject = function (size) {
         $scope.project = $scope.editProjects;
         angular.forEach($scope.formElements.departmenttypeList, function(obj, key) {
  			if (!angular.isUndefined($scope.project.department) && $scope.project.department != null) {
  	    			if(obj.id == $scope.project.department.id) {
  	    				$scope.project.department = obj;
  	    				console.log($scope.project.department);
  				}
  	    		}
  	    	});
         angular.forEach($scope.projectElements.projectOwnerList, function(obj, key) {
   			if (!angular.isUndefined($scope.project.projectOwner) && $scope.project.projectOwner != null) {
   	    			if(obj.id == $scope.project.projectOwner.id) {
   	    				$scope.project.projectOwner = obj;
   	    				console.log($scope.project.projectOwner);
   				}
   	    		}
   	    	});
        dialogService.openDialog("app/views/project/edit.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
                // Update project
                var project = $scope.editProjects;

             $scope.update = function (form) {
                    $scope.formSubmitted = true;
                    if (form.$valid) {
                        var project = $scope.project;
                        project.projectOwnerId = $scope.project.projectOwner.id;
                        project.departmentId = $scope.project.department.id;
                        var hasServer = crudService.update("projects", project);
                        hasServer.then(function (result) {
                        	$scope.oneChecked = false;
                        	$scope.project={};
                            $scope.list(1);
                            notify({message: 'Project Updated successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                            $modalInstance.close();
                        });
                    }
                },
                        $scope.cancel = function () {
                            $modalInstance.close();
                        };
            }]);
    };


    // Delete the department
    $scope.projectDeleteConfirmation = function (size) {
        dialogService.openDialog("app/views/project/delete.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
                var deleteObject = $scope.editProjects;
                $scope.deleteProject = function () {
                	console.log(deleteObject);
                    var hasServer = crudService.softDelete("projects", deleteObject);
                    hasServer.then(function (result) {
                    	$scope.oneChecked = false;
                        $scope.list(1);
                        notify({message: 'Project deleted successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});

                    });
                    $modalInstance.close();
                },
                        $scope.cancel = function () {
                            $modalInstance.close();
                        };
            }]);
    };

 /*    $scope.editProject = function (size) {
         var project = $scope.projectList[$scope.project.totalCheckedCount - 1];
            var modalInstance = $modal.open({
                templateUrl: 'app/views/project/edit.jsp',
                controller: 'editProjectCtrl',
                size: size,
                backdrop: 'static',
                windowClass: "hmodal-info",
                resolve: {
                    project: function () {
                        return project;
                    }
                }
            });

            modalInstance.result.then(function (selectedItem) {
                $scope.selected = selectedItem;
            }, function () {
            });


    };

    $scope.projectDeleteConfirmation = function(size) {
        modalService.trigger('app/views/project/delete.jsp', size);
    };*/


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
                notify({message: 'Account added successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
            } else {
                notify({message: 'Account already exist', classes: 'alert-danger', templateUrl: $scope.homerTemplate});

            }
        }, 2000);

    };

    $scope.deleteAccount = function(index) {

        $scope.removeLoader["index_"+index] = true;
        $timeout(function() {
            $scope.projectAccountList.splice(index, 1);
            $scope.removeLoader["index_"+index] = false;
            notify({message: 'Account removed successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
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
            notify({message: 'Updated successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
        }, 2000);
    }


    $scope.save = function (form) {
   	 $scope.formSubmitted = true;
        if (form.$valid) {
            var project = $scope.project;
            project.isActive = true;
            project.domain = project.department.domain;
            var hasProject = crudService.add("projects", project);
            hasProject.then(function (result) {  // this is only run after $http completes
           	 $scope.projectLoader = true;
           	 $scope.list(1);
                $scope.homerTemplate = 'app/views/notification/notify.jsp';
                notify({message: 'Project added successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
                $scope.cancel();
                $state.reload();
            }).catch(function (result) {
            	console.log(result.data.globalError[0]);
                if(result.data.globalError[0] != '' && result.data.globalError[0] != null ){
               	 var msg = result.data.globalError[0];
               	 notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });

                    }
                angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                    $scope.projectForm[key].$invalid = true;
                    $scope.projectForm[key].errorMessage = errorMessage;
                });

            });
        }
    };

    $scope.validateInfraLimit = function(form) {
        $scope.formSubmitted = true;
        if (form.$valid) {
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            notify({message: 'Updated successfully', classes: 'alert-success', "timeOut": "1000", templateUrl: $scope.homerTemplate});
        } else {
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            notify({message: 'Please fill all the fields', classes: 'alert-danger', "timeOut": "1000", templateUrl: $scope.homerTemplate});
        }
    };

    $scope.accounts = {
            category: "users",
            oneItemSelected: {},
            selectedAll: {},
            totalcount: 0
        };

    $scope.department = {};
    var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
    var hasDepartments = crudService.list("departments", $scope.global.paginationHeaders(1, limit), {"limit": limit});
    hasDepartments.then(function (result) {  // this is only run after $http completes0
    	$scope.accountElements.departmentList = result;
    });

    $scope.project = {};
    var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
    var hasProjects = promiseAjax.httpTokenRequest( crudService.globalConfig.HTTP_GET, crudService.globalConfig.APP_URL + "projects/list");
    hasProjects.then(function (result) {  // this is only run after $http completes0
    	$scope.options = result;
    });

    $scope.domain = {};
    var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
    var hasDomains = crudService.list("domains", $scope.global.paginationHeaders(1, limit), {"limit": limit});
    hasDomains.then(function (result) {  // this is only run after $http completes0
    	$scope.accountElements.domainList = result;
    });


    $scope.createUser = function() {

        dialogService.openDialog("app/views/account/add-user.jsp", 'lg', $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
        	$scope.save = function (form) {
                $scope.formSubmitted = true;
                if (form.$valid) {
                    var user = $scope.user;
                    var hasServer = crudService.add("users", user);
                    hasServer.then(function (result) {  // this is only run after $http completes
                        $scope.list(1);
                        notify({message: 'Added successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                        $modalInstance.close();
                        $scope.userList(user.department);
                    }).catch(function (result) {
                        angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                            $scope.departmentForm[key].$invalid = true;
                            $scope.departmentForm[key].errorMessage = errorMessage;
                        });
                    });
                }
            },
            $scope.cancel = function () {
                $modalInstance.close();
            };

            // Getting list of roles by department
            $scope.getRolesByDepartment = function(department) {
            	 var hasRoles =  promiseAjax.httpTokenRequest( crudService.globalConfig.HTTP_GET, crudService.globalConfig.APP_URL + "roles"  +"/department/"+department.id);
            	 hasRoles.then(function (result) {  // this is only run after $http completes0
            		 $scope.accountElements.roleList = result;
            	 });
           	};

         }]);
    }
};
