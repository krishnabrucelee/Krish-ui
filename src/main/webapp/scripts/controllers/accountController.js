

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

 $scope.$on(appService.globalConfig.webSocketEvents.accountEvents.addUser, function() {

  //   $scope.accountList = appService.webSocket;
    });
 $scope.$on(appService.globalConfig.webSocketEvents.accountEvents.editUser, function() {

  //   $scope.accountList = appService.webSocket;
    });
 $scope.$on(appService.globalConfig.webSocketEvents.accountEvents.deleteUser, function() {

  //   $scope.accountList = appService.webSocket;
    });

    $scope.global = appService.globalConfig;
    $scope.userData = "testss";
    $scope.addUser = function (form) {
        $scope.formSubmitted = true;
        if (form.$valid) {
        }
    };
}

// Load list page of user
function accountListCtrl($scope,$state, $log,$timeout,$stateParams, appService) {
    $scope.accounts = {
        category: "users",
        oneItemSelected: {},
        selectedAll: {},
        totalcount: 0
    };
    $scope.activeUsers = [];
    $scope.active = {};
	$scope.inActive = {};
    $scope.oneChecked = false;
    $scope.default_option = true;
    $scope.revokes = false;
    $scope.edit = false;
    $scope.deletes = false;
    $scope.revokes = false;
    $scope.accountList = {};
    $scope.paginationObject = {};
    $scope.userForm = {};
    $scope.global = appService.globalConfig;
    $scope.user = {};
    $scope.sort = appService.globalConfig.sort;
    $scope.changeSorting = appService.utilService.changeSorting;
    $scope.accountElements={

    };

    $scope.userList = function() {
	    var hasUsers = appService.crudService.listAll("users/list");
		$scope.showLoader = true;
		hasUsers.then(function (result) {  // this is only run after $http completes0
		   $scope.activeUsers = result;
	    });
    }
    $scope.userList();

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

    // Get account list based on domain selection
    $scope.selectDomainView = function(pageNumber) {
    	$scope.list(1);
    };

    // User List
    $scope.list = function (pageNumber) {
    	$scope.showLoader = true;
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasUsers = {};
        if ($scope.domainView == null) {
        	hasUsers = appService.crudService.list("users", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
        } else {
        	hasUsers =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "users/listByUserDomain"
				+"?lang=" +appService.localStorageService.cookie.get('language')
				+ "&domainId="+$scope.domainView.id+"&sortBy=ASC"+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
        }
        hasUsers.then(function (result) {  // this is only run after $http completes0

            $scope.accountList = result;
            $scope.accountList.Count = 0;
            if (result.length != 0) {
                $scope.accountList.Count = result.totalItems;
            }

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
	    $scope.user = {};
        appService.dialogService.openDialog("app/views/account/add-user.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
            $scope.save = function (form) {
                $scope.formSubmitted = true;
                if (form.$valid) {
		            $scope.showLoader = true;
                    var user = angular.copy($scope.user);
		            if(!angular.isUndefined($scope.user.department)) {
                        user.departmentId = user.department.id;
                    }

 		         if ($scope.global.sessionValues.type != "ROOT_ADMIN") {
 		        	 domain.id = $scope.global.sessionValues.domainId;
 		        	 user.domainId = domain.id;
    	               } else {
				user.domainId = user.domain.id;
			}
                    if (user.password == $scope.account.confirmPassword) {
                    	var hasServer = appService.crudService.add("users", user);
                    	hasServer.then(function (result) {  // this is only run after $http completes
			   appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.accountEvents.addUser,result.id,$scope.global.sessionValues.id);
				        $scope.showLoader = false;
                    	appService.notify({message: 'Added successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
				        $modalInstance.close();
				        $scope.list(1);
                    	}).catch(function (result) {
                    		if(!angular.isUndefined(result) && result.data != null) {
				            $scope.showLoader = false;
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
        }])};

       if ($scope.global.sessionValues.type === "USER") {
       var hasRoles =  appService.promiseAjax.httpTokenRequest( appService.crudService.globalConfig.HTTP_GET, appService.crudService.globalConfig.APP_URL + "roles"  +"/department/"+$scope.global.sessionValues.departmentId);
            	 hasRoles.then(function (result) {  // this is only run after $http completes0
            		 $scope.accountElements.roleList = result;
            	 });

		    var hasProjects =  appService.promiseAjax.httpTokenRequest( appService.crudService.globalConfig.HTTP_GET, appService.crudService.globalConfig.APP_URL + "projects"  +"/department/"+$scope.global.sessionValues.departmentId);
		    hasProjects.then(function (result) {  // this is only run after $http completes0
                $scope.options = result;
            });
}

        // Delete user data from database
        $scope.deleteUser = function (size,account) {

         var user = account;
       	 angular.forEach($scope.accountList, function (item, key) {
                if (item['isSelected']) {
               	 user = item;
                }
       	 });

       	$scope.user = user;
      appService.dialogService.openDialog("app/views/account/delete-user.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
          $scope.deleteUsers = function(user) {
              $scope.showLoader = true;
               var hasServer = appService.crudService.softDelete("users", user);
               hasServer.then(function (result) {
			   appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.accountEvents.deleteUser,result.id,$scope.global.sessionValues.id);
               $scope.list(1);
               appService.notify({message: 'Deleted successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
               $scope.showLoader = false;
               $scope.cancel();
               }).catch(function (result) {
                   $scope.showLoader = false;
                   $scope.cancel();
               });
          },
          $scope.cancel = function(){
              $modalInstance.close();
          }
      }]);

        };

        $scope.viewAccountd = function(account) {
            $scope.oneChecked = false;
            $scope.editAccounts = angular.copy(account);
            $scope.accountInfo = angular.copy(account);
            $scope.account = $scope.editAccounts;
            if (account.isActive) {
                console.log("ok");
                $scope.oneChecked = true;
                $scope.edit = true;
                $scope.deletes = true;

            } else {
                $scope.oneChecked = false;
            }

        };

    // Edit user data
    $scope.editUser = function (size,account) {
    	var user = account;
    	 angular.forEach($scope.accountList, function (item, key) {
             if (item['isSelected']) {
            	 user = item;
             }
    	 });
    	appService.dialogService.openDialog("app/views/account/edit-user.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
    	    $scope.user = angular.copy(user);
    		$scope.saveUser = function (user) {
    			$scope.formSubmitted = true;
    			$scope.showLoader = true;
    			var user = $scope.user;
                user.departmentId = user.department.id;
    		    var hasServer = appService.crudService.update("users",user);
    		    hasServer.then(function (result) {
			   appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.accountEvents.editUser,result.id,$scope.global.sessionValues.id);
    		    	$scope.list(1);
    		        appService.notify({message: 'Updated successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
    		        $scope.cancel();
                    $scope.showLoader = false;
    		    }).catch(function (result) {
    		    	if(!angular.isUndefined(result) && result.data != null) {
    		    		angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
    		    			$scope.userForm[key].$invalid = true;
                            $scope.userForm[key].errorMessage = errorMessage;
				   		    $scope.showLoader = false;
                    	});
                    }
                });
    		},
            $scope.cancel = function () {
		$scope.list(1);
                $modalInstance.close();
            };
       }]);
    };

    // Reset Password
    $scope.resetPassword = function (size,account) {
    	var user = account;
    	 angular.forEach($scope.accountList, function (item, key) {
             if (item['isSelected']) {
            	 user = item;
             }
    	 });
    	appService.dialogService.openDialog("app/views/account/reset-password.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
    	    $scope.profile = angular.copy(user);
    		$scope.updatePassword = function (form, profile) {
    	        $scope.formSubmitted = true;
    	        if (form.$valid) {
    	        	$scope.showLoader = true;
    	        	if(profile.newPassword != profile.confirmPassword) {
    	        		appService.notify({message: 'Password did not match', classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
    	        		$scope.showLoader = false;
    	        	} else {
    	            	profile.confirmPassword = profile.confirmPassword;
    	            	profile.password = null;
    	            var hasUpdatePassword = appService.crudService.add("users/updatePassword", profile);
    	            hasUpdatePassword.then(function (result) {
    	            	$scope.showLoader = false;
    	                appService.notify({message: 'Updated successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
    	                $modalInstance.close();
    	                $scope.list(1);
    	            }).catch(function (result) {
    	            	$scope.showLoader = false;
    	    		    if (!angular.isUndefined(result.data)) {
    	        		 if (result.data.fieldErrors != null) {
    	               	$scope.showLoader = false;
    	                	angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
    	                    	$scope.profileForm[key].$invalid = true;
    	                    	$scope.profileForm[key].errorMessage = errorMessage;
    	                	});
    	        		}
    	        	}
    	    	});
    	            $scope.list(1);
    	    }
    	    }
    	    },
            $scope.cancel = function () {
		$scope.list(1);
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

    $scope.revoking = function (account) {
    	var user = account;
      	$scope.user = user;
    	  appService.dialogService.openDialog("app/views/account/revoke.jsp", 'sm', $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
    		  $scope.ok = function(user) {
                  $scope.showLoader = true;
                   var hasServer = appService.crudService.update("users/disable", user);
                   hasServer.then(function (result) {
    			     $scope.list(1);
    			     $scope.userList();
                   appService.notify({message: 'Disabled successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                   $scope.showLoader = false;
                   $scope.cancel();
                   }).catch(function (result) {
                       $scope.showLoader = false;
                       $scope.cancel();
                   });
              },
              $scope.cancel = function(){
                  $modalInstance.close();
              }

    	  }]);    }

    $scope.activating = function (account) {
    	var user = account;
      	$scope.user = user;
        appService.dialogService.openDialog("app/views/account/activate.jsp", 'sm', $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {

        	$scope.ok = function(user) {
                $scope.showLoader = true;
                 var hasServer = appService.crudService.update("users/enable", user);
                 hasServer.then(function (result) {
  			     $scope.list(1);
  			     $scope.userList();
                 appService.notify({message: 'Enabled successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                 $scope.showLoader = false;
                 $scope.cancel();
                 }).catch(function (result) {
                     $scope.showLoader = false;
                     $scope.cancel();
                 });
            },
            $scope.cancel = function(){
                $modalInstance.close();
            }


        }]);
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


