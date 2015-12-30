/**
 *
 * projectCtrl
 *
 */

angular
    .module('homer')
    .controller('projectCtrl', projectCtrl)

function projectCtrl($scope, appService, $filter, $state,$stateParams) {
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

    $scope.list = function (pageNumber) {
    	$scope.showLoader = true;
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasProjects = appService.crudService.list("projects", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
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

    $scope.userLists = function (department) {
       var hasUsers = appService.crudService.listAllByFilter("users/search", department);
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
   		    			$scope.userLists(result);
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

     $scope.$watch('newProject.domain', function (obj) {
   	  	if (!angular.isUndefined(obj)) {
       	 	$scope.departmentList(obj);
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
    	$scope.newProject = {};
        $scope.projectForm = {};
    	appService.dialogService.openDialog("app/views/project/add.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
        // add project
    	  $scope.save = function (form) {
    		   	 $scope.formSubmitted = true;
    		        if (form.$valid) {
    		        	$scope.projectLoader = true;
    		            if($scope.global.sessionValues.type !== 'ROOT_ADMIN') {
    		            	if(!angular.isUndefined($scope.global.sessionValues.domainId)){
    		            		 $scope.newProject.domainId = $scope.global.sessionValues.domainId;
    		            	}
    		            }
    		            else{
    		            	 $scope.newProject.domainId =  $scope.newProject.domain.id;
    		            }
    		            var project = angular.copy($scope.newProject);
    		            console.log(project);
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
    		            	$scope.formSubmitted = false;
    		            	$scope.projectLoader = false;
    		           	    $scope.cancel();
    		                $scope.homerTemplate = 'app/views/notification/notify.jsp';
    		                appService.notify({message: 'Project added successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});

    		              	$scope.list(1);
    		            }).catch(function (result) {
    		            	console.log($scope.newProject);
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
         if(newUser.userName.toLowerCase() == eachuser.userName.toLowerCase()){ // this line will check whether the data is existing or not
        	 oldUser = true;
        	 appService.notify({message: 'User already added ', classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
         }
         });
         if(!oldUser){
        	 $scope.projectInfo.userList.push(user);
        	 var hasServer = appService.crudService.update("projects", $scope.projectInfo);
             hasServer.then(function (result) {
                 appService.notify({message: 'User updated successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
             });
         }
         }

    }

    $scope.removeUser = function(user) {
    	angular.forEach($scope.projectInfo.userList, function(obj, key) {
    		if(obj.id == user.id) {
    			$scope.projectInfo.userList.splice(key, 1);
    		}
    	});
    	var hasServer = appService.crudService.update("projects", $scope.projectInfo);
        hasServer.then(function (result) {
            appService.notify({message: 'User removed successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});

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
