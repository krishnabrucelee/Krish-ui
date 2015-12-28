

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.    
 */ 
   
angular         
        .module('homer')     
        .controller('accountCtrl', accountCtrl)  
        .controller('accountListCtrl', accountListCtrl)   
        .controller('editCtrl', editCtrl)   
 
function accountCtrl($scope, appService) {
    $scope.global = appService.globalConfig;
    $scope.userData = "testss";
    $scope.addUser = function (form) { 
    	console.log(form);   
        $scope.formSubmitted = true;      
        if (form.$valid) {    
        	console.log($scope.user);
        }
    };
}

// Load list page of user
function accountListCtrl($scope,$state, $log,$timeout, appService) { 
    $scope.accounts = {
        category: "users",
        oneItemSelected: {},
        selectedAll: {},
        totalcount: 0
    };

    $scope.default_option = true
    $scope.revokes = false;
    $scope.accountList = {};
    $scope.paginationObject = {};
    $scope.userForm = {};
    $scope.global = appService.globalConfig;
    $scope.user = {};
    $scope.accountElements={

    };

    // Department list load based on the domain
    $scope.domainChange = function() {
        $scope.domains = {};
        var hasDepartmentList = appService.crudService.listAllByFilter("departments/search", $scope.user.domain);
        hasDepartmentList.then(function (result) {
    	    $scope.accountElements.departmentList = result;
        });
    };

    // Load department
    $scope.department = {};
    $scope.userLists = function (domain) {
    var hasDepartments = appService.crudService.listAllByFilter("departments/search", domain.id);
    hasDepartments.then(function (result) {  // this is only run after $http completes0
    	$scope.accountElements.departmentList = result;
    });
    }

    // Load domain
    $scope.domain = {};
    var hasDomains = appService.crudService.listAll("domains/list");
    hasDomains.then(function (result) {  // this is only run after $http completes0
    	$scope.accountElements.domainList = result;
    });


    $scope.checkAccount = function (item) {
        item.isSelected = true;
        $scope.checkOne(item);
    }

   
    
    // User List
    $scope.list = function (pageNumber) {
    	$scope.showLoader = true;
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasUsers = appService.crudService.list("users", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
        hasUsers.then(function (result) {  // this is only run after $http completes0
     
            $scope.accountList = result;
            // For pagination
            $scope.paginationObject.limit  = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
            $scope.showLoader = false;

        });
    };
    $scope.list(1);
    $scope.editList = {};
    $scope.activate = false;
    $scope.revoke = false;
    $scope.deletes = false;
    $scope.edit = false;
    $scope.disabled = false;
    appService.localStorageService.set("edit", null);

    // To check all user list
    $scope.checkAll = function () {
        $scope.accounts.oneItemSelected[$scope.accounts.category] = false;

        if ($scope.accounts.selectedAll[$scope.accounts.category]) {
            $scope.accounts.selectedAll[$scope.accounts.category] = true;
        } else {
            $scope.accounts.selectedAll[$scope.accounts.category] = false;
        }

        angular.forEach($scope.accountList, function (item, key) {
            item['isSelected'] = $scope.accounts.selectedAll[$scope.accounts.category];
            if (item['isSelected']) {
                $scope.accounts.oneItemSelected[$scope.accounts.category] = true;
                $scope.disabled = false;
            }
        });

    };

    // To check one user
    $scope.checkOne = function (item) {
        $scope.editList = item;
        appService.localStorageService.set("edit", $scope.editList);
        $scope.accounts.oneItemSelected[$scope.accounts.category] = false;
        $scope.accounts.selectedAll[$scope.accounts.category] = true;
        var count = 0;
        angular.forEach($scope.accountList, function (item, key) {

            if (item['isSelected']) {
                count++;
                $scope.accounts.oneItemSelected[$scope.accounts.category] = true;
                $scope.edit = true;
                $scope.deletes = true;
                if (item.enabled == true) {
                    $scope.revoke = true;
                }
                else {
                    $scope.activate = true
                }
            } else {
                $scope.accounts.selectedAll[$scope.accounts.category] = false;
                $scope.disabled = false;
            }
        });

        $scope.accounts.totalcount = count;

        if ($scope.accounts.totalcount == 1) {
            $scope.disabled = true;
        }
        else if ($scope.accounts.totalcount > 0) {
            $scope.disabled = false;
        }

    }

    $scope.viewDetails = function(item) {
        item.isSelected = (item.isSelected) ? false : true;
        $scope.checkOne(item);
    };

    $scope.checkAccount = function (item) {
        item.isSelected = true;
        $scope.checkOne(item);

    }

    // Opened user add window
    $scope.addUser = function (size) {
        appService.dialogService.openDialog("app/views/account/add-user.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
        	$scope.save = function (form) {
                $scope.formSubmitted = true;
                if (form.$valid) {
                    var user = angular.copy($scope.user);
		    if(!angular.isUndefined($scope.user.department)) {
                       user.departmentId = user.department.id; 
                    }
                    if (user.password == $scope.account.confirmPassword) {
                    	var hasServer = appService.crudService.add("users", user);
                    	hasServer.then(function (result) {  // this is only run after $http completes
                    		$scope.list(1);
                    		appService.notify({message: 'Added successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                    		$modalInstance.close();
                    		$scope.user.userName = "";
                    		$scope.user.password = "";
                    		$scope.user.department = "";
                    		$scope.user.domain = "";
                    		$scope.user.role = "";
                    		$scope.user.email = "";
                    		$scope.user.firstName = "";
                    		$scope.user.lastName = "";
                    		$scope.user.projectList = "";
                    	}).catch(function (result) {
                    		if(!angular.isUndefined(result) && result.data != null) {
                    			angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
				   $scope.userForm[key].$invalid = true;
                            	   $scope.userForm[key].errorMessage = errorMessage;
                    			});
                    		}
                    	});
                    }
                    else {  // Add tool tip message for confirmation password in add-user
                    	var key = 'confirmpassword';
                    	$scope.userForm[key].$invalid = true;
                    	$scope.userForm[key].errorMessage = document.getElementById("passwordErrorMessage").value;
                    }
                }
            },
            $scope.cancel = function () {
                $modalInstance.close();
            };


            // Getting list of roles and projects by department
            $scope.getRolesAndProjectsByDepartment = function(department) {
            	 var hasRoles =  appService.promiseAjax.httpTokenRequest( appService.crudService.globalConfig.HTTP_GET, appService.crudService.globalConfig.APP_URL + "roles"  +"/department/"+department.id);
            	 hasRoles.then(function (result) {  // this is only run after $http completes0
            		 $scope.accountElements.roleList = result;
            	 });

		 var hasProjects =  appService.promiseAjax.httpTokenRequest( appService.crudService.globalConfig.HTTP_GET, appService.crudService.globalConfig.APP_URL + "projects"  +"/department/"+department.id);
		 hasProjects.then(function (result) {  // this is only run after $http completes0
            		$scope.options = result;
            	 });
           	};
         }]); 
          
    };

    // Delete user data from database
    $scope.deleteUser = function (size) {
     var user = {};
   	 angular.forEach($scope.accountList, function (item, key) {

            if (item['isSelected']) {
           	 user = item;
            }
   	 });

     var hasServer = appService.crudService.softDelete("users", user);
     hasServer.then(function (result) {
         $scope.list(1);
         appService.notify({message: 'Deleted successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
         $modalInstance.close();
     });

    appService.modalService.trigger('app/views/account/delete-user.jsp', size);
    };

    $scope.deleteUsers = function () {
        $scope.cancel();
    }

    // Edit user data
    $scope.editUser = function (size) {  
    	var user = {};
    	 angular.forEach($scope.accountList, function (item, key) {

             if (item['isSelected']) {
            	 user = item;
             }
    	 });

    	appService.dialogService.openDialog("app/views/account/edit-user.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
    		$scope.user = angular.copy(user);

    		   $scope.saveUser = function (user) {
                               $scope.showLoader = true;
    		        $scope.formSubmitted = true;
			var user = $scope.user;
                        user.departmentId = user.department.id;
    		        var hasServer = appService.crudService.update("users",user);
    		        hasServer.then(function (result) {
    		            $scope.list(1);
    		            appService.notify({message: 'Updated successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
    		            $scope.cancel();
                                $scope.showLoader = false;
    		        }).catch(function (result) {
                    		if(!angular.isUndefined(result) && result.data != null) {
                    			angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
				   $scope.userForm[key].$invalid = true;
                            	   $scope.userForm[key].errorMessage = errorMessage;
                    			});
                    		}
                    	});
    		    },
             $scope.cancel = function () {
                 $modalInstance.close();
             };
         }]);
    };

    $scope.ok = function () {
        $timeout($scope.generateLoad, 3000);

    };
    $scope.generateLoad = function () {
        $scope.activates = true;
        $scope.revokes=false;
        $scope.cancel();
        $state.reload();

    }

    $scope.generateRevoke = function () {
        $scope.revokes = true;
        $scope.activates = false;

        $scope.cancel();
        $state.reload();
    }

    $scope.revok = function () {
        $timeout($scope.generateRevoke, 3000);
    };

    $scope.revoking = function () {
        appService.modalService.trigger('views/account/revoke.html', 'md');
    }

    $scope.activating = function () {
        appService.modalService.trigger('views/account/activate.html', 'md');
    }
}


function editCtrl($scope, account, notify, $modalInstance) {
    $scope.account = account;
    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');

    };
    $scope.saveUser = function (form) {
        $scope.formSubmitted = true;
        if (form.$valid) {
            $scope.homerTemplate = 'views/notification/notify.jsp';
            appService.notify({message: 'Account updated successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
            $scope.cancel();
        }

    }

}


