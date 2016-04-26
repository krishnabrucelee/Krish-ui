/**
 *
 * sshkeyListCtrl
 *
 */

angular
        .module('homer')
        .controller('sshkeyListCtrl', sshkeyListCtrl)

function sshkeyListCtrl($scope,appService,$state,localStorageService, globalConfig) {

    $scope.sshkeyList = {};
    $scope.paginationObject = {};
    $scope.sshkeyForm = {};
    $scope.formElements = [];
    $scope.formElements.departmenttypeList = {};
    $scope.global = appService.globalConfig;
    $scope.sort = appService.globalConfig.sort;
    $scope.changeSorting = appService.utilService.changeSorting;
    $scope.userElement = {};
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
            var hasSSHKeysLists = {};
            if ($scope.domainView == null) {
            	hasSSHKeysLists =  appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "sshkeys" +"?lang=" + localStorageService.cookie.get('language') +"&sortBy="+sortOrder+sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
            } else {
            	hasSSHKeysLists =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "sshkeys/listByDomain"
    				+"?lang=" +appService.localStorageService.cookie.get('language')
    				+ "&domainId="+$scope.domainView.id+"&sortBy="+$scope.paginationObject.sortOrder+$scope.paginationObject.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
            }
            hasSSHKeysLists.then(function(result) { // this is only run after $http
			// completes0
			$scope.sshkeyList = result;
			$scope.sshkeyList.Count = 0;
            if (result.length != 0) {
                $scope.sshkeyList.Count = result.totalItems;
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

    // SSH Key List
    $scope.list = function (pageNumber) {
        appService.globalConfig.sort.sortOrder = $scope.paginationObject.sortOrder;
        appService.globalConfig.sort.sortBy = $scope.paginationObject.sortBy;
        $scope.showLoader = true;
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT :
        	$scope.paginationObject.limit;
        var hasSSHKeys = {};
        if ($scope.domainView == null) {
        	hasSSHKeys = appService.crudService.list("sshkeys", $scope.global.paginationHeaders(pageNumber, limit),
                    {"limit": limit});
        } else {
        	hasSSHKeys =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "sshkeys/listByDomain"
				+"?lang=" +appService.localStorageService.cookie.get('language')
				+ "&domainId="+$scope.domainView.id+"&sortBy="+globalConfig.sort.sortOrder+globalConfig.sort.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
        }
        hasSSHKeys.then(function (result) {
            $scope.sshkeyList = result;
            $scope.sshkeyList.Count = 0;
            if (result.length != 0) {
                $scope.sshkeyList.Count = result.totalItems;
            }

            // For pagination
            $scope.paginationObject.limit = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
            $scope.showLoader = false;
        });
    };
    $scope.list(1);

    // Get ssh key list based on domain selection
    $scope.selectDomainView = function(pageNumber) {
    	$scope.list(1);
    };

    // Open dialogue box to create SSH Key
    $scope.sshkey = {};
    $scope.formElements = {};

   // Load domain
    $scope.domain = {};
    var hasDomains = appService.crudService.listAll("domains/list");
    hasDomains.then(function (result) {
    	$scope.formElements.domainList = result;
    });

    // Department list load based on the domain
    $scope.domainChange = function() {
        $scope.domains = {};
        $scope.formElements.departmentList = {};
        $scope.options = {};
        if (!angular.isUndefined($scope.sshkey.domain)) {
	        var hasDepartmentList = appService.crudService.listAllByFilter("departments/search", $scope.sshkey.domain);
	        hasDepartmentList.then(function (result) {
	    	    $scope.formElements.departmentList = result;
	        });
        }
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

    // Getting list of projects by department
    $scope.getProjectsByDepartment = function(department) {
     $scope.options = {};
     if (!angular.isUndefined(department)) {
    	 if($scope.global.sessionValues.type !== 'USER') {
    		 $scope.showLoaderDetail = true;
    		 var hasProjects =  appService.promiseAjax.httpTokenRequest(appService.crudService.globalConfig.HTTP_GET,
       				 appService.crudService.globalConfig.APP_URL + "projects"  +"/department/"+department.id);
    		 hasProjects.then(function (result) {  // this is only run after $http completes0
	    		$scope.options = result;
	    		$scope.showLoaderDetail = false;
	    	 });
    	 }
     }
   	};

   if($scope.global.sessionValues.type === 'USER') {
		var hasUsers = appService.crudService.read("users", $scope.global.sessionValues.id);
        hasUsers.then(function (result) {
            if (!angular.isUndefined(result)) {
            	$scope.userElement = result;
    	        var hasProjects =  appService.crudService.listAllByObject("projects/user", $scope.userElement);
    			hasProjects.then(function (result) {  // this is only run after $http completes0
    	   		    $scope.options = result;
    	   	    });
            }
        });
	 }


   $scope.createSSHKey = function (size) {
       appService.dialogService.openDialog($scope.global.VIEW_URL + "cloud/sshkeys/add.jsp", size, $scope, ['$scope',
                 '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
       // Create a new sshkey
       $scope.save = function (form,sshkey) {
    	   $scope.formSubmitted = true;
    	   if ($scope.global.sessionValues.type === 'USER'){
    		   if (form.$valid) {
    			   $scope.showLoader = true;
    			   var domainObj = {};
    			   var departmentObj = {};
                   var sshkey = angular.copy($scope.sshkey);
                   if (!angular.isUndefined($scope.sshkey.domain) && $scope.sshkey.domain != null) {
                       sshkey.domainId = sshkey.domain.id;
    		       domainObj = sshkey.domain;
                       delete sshkey.domain;
                   }
                   if (!angular.isUndefined($scope.sshkey.department) && $scope.sshkey.department != null) {
                       sshkey.departmentId = sshkey.department.id;
    		       departmentObj = sshkey.department;
                       delete sshkey.department;
                   }
                   if (angular.isUndefined($scope.sshkey.publicKey) || $scope.sshkey.publicKey == "") {
                       delete sshkey.publicKey;
                   }
                   if (!angular.isUndefined($scope.sshkey.project) && $scope.sshkey.project != null) {
                       sshkey.projectId = sshkey.project.id;
                       projectObj = sshkey.project;
                       delete sshkey.project;
                   }
                   var hasServer = appService.crudService.add("sshkeys", sshkey);
                   hasServer.then(function (result) {
                	   $scope.sshkeyss = $scope.sshkeyList[$scope.sshkeyList.length];
    			       $scope.sshkeyss = result;
    			           var departments = [];
    			           var hasDepartments = appService.crudService.read("departments",
    			           $scope.global.sessionValues.departmentId);
    			           hasDepartments.then(function (result) {
    			               $scope.sshkeyss.department = result;
    			           });
                                   var domains = [];
    			           var hasDomains = appService.crudService.read("domains", $scope.global.sessionValues.domainId);
    			           hasDomains.then(function (result) {
    			               $scope.sshkeyss.domain = result;
    			           });
    			       $scope.sshkeyss.domain = domainObj;
    			       $scope.sshkeyss.department = departmentObj;
                               if (!angular.isUndefined($scope.sshkey.project) && $scope.sshkey.project != null) {
                                   $scope.sshkeyss.project = projectObj;
                               } 
    			       $scope.sshkeyList[$scope.sshkeyList.length] = $scope.sshkeyss;
    			       $scope.sshkey.privateKey = result.privateKey;
    			       $scope.list = function (pageNumber) {
    			           var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT :
    			        	   $scope.paginationObject.limit;
    			           var hasSSHKeys = appService.crudService.list("sshkeys",
    			        		   $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
    			               hasSSHKeys.then(function (result) {
    			                   $scope.sshkeyList = result;
    			                	   var sshkeyss = $scope.sshkeyList[$scope.sshkeyList.length];
    			                	   $scope.sshkeyList[$scope.sshkeyList.length] = $scope.sshkeyss;
    			                	   // For pagination
    			                	   $scope.paginationObject.limit = limit;
    			                	   $scope.paginationObject.currentPage = pageNumber;
    			                	   $scope.paginationObject.totalItems = result.totalItems;
    			                   });
    			           };
    			                $scope.formSubmitted = false;
    			                $modalInstance.close();
    			                $scope.showLoader = false;
    			                appService.notify({message: 'SSH key created successfully', classes: 'alert-success',
    			                	templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
    			                $scope.list(1);
    			                $scope.sshkey.name = "";
    			                $scope.sshkey.publicKey = "";
    			                $scope.sshkey.privateKey = result.privateKey;
    			                $scope.sshkey.domain = "";
    			                $scope.sshkey.department = "";
                                        $scope.sshkey.project = "";
                            	}).catch(function (result) {
                            		if(result.data.globalError[0] != ''){
                            			var msg = result.data.globalError[0];
                            			appService.notify({message: msg, classes: 'alert-danger',
                            				templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                            			$modalInstance.close();
                            			$state.reload();
                                    	}
                            	});
    		   }
    	   }
    	   else if (form.$valid && !angular.isUndefined($scope.sshkey.department)) {
        	   $scope.showLoader = true;
			   var domainObj = {};
			   var departmentObj = {};
               var sshkey = angular.copy($scope.sshkey);
               if (!angular.isUndefined($scope.sshkey.domain) && $scope.sshkey.domain != null) {
            	   sshkey.domainId = sshkey.domain.id;
		   domainObj = sshkey.domain;
                   delete sshkey.domain;
               }
               if (!angular.isUndefined($scope.sshkey.department) && $scope.sshkey.department != null) {
            	   sshkey.departmentId = sshkey.department.id;
		   departmentObj = sshkey.department;
                   delete sshkey.department;
               }
               if (angular.isUndefined($scope.sshkey.publicKey) || $scope.sshkey.publicKey == "") {
                   delete sshkey.publicKey;
               }
               if (!angular.isUndefined($scope.sshkey.project) && $scope.sshkey.project != null) {
                   sshkey.projectId = sshkey.project.id;
                   projectObj = sshkey.project;
                   delete sshkey.project;
               }
               var hasServer = appService.crudService.add("sshkeys", sshkey);
               hasServer.then(function (result) {
            	   $scope.sshkeyss = $scope.sshkeyList[$scope.sshkeyList.length];
			       $scope.sshkeyss = result;
			       if ($scope.global.sessionValues.type === 'USER') {
			           var departments = [];
			           var hasDepartments = appService.crudService.read("departments",
			        		   $scope.global.sessionValues.departmentId);
			           hasDepartments.then(function (result) {
			               $scope.sshkeyss.department = result;
			           });
                                   var domains = [];
			           var hasDomains = appService.crudService.read("domains", $scope.global.sessionValues.domainId);
			           hasDomains.then(function (result) {
			               $scope.sshkeyss.domain = result;
			           });
			       }
			       $scope.sshkeyss.domain = domainObj;
			       $scope.sshkeyss.department = departmentObj;
                               if (!angular.isUndefined($scope.sshkey.project) && $scope.sshkey.project != null) {
                                   $scope.sshkeyss.project = projectObj;
                               }
			       $scope.sshkeyList[$scope.sshkeyList.length] = $scope.sshkeyss;
			       $scope.sshkey.privateKey = result.privateKey;
			       $scope.list = function (pageNumber) {
			           var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT :
			        	   $scope.paginationObject.limit;
			           var hasSSHKeys = appService.crudService.list("sshkeys",
			        		   $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
			               hasSSHKeys.then(function (result) {
			                   $scope.sshkeyList = result;
			                	   var sshkeyss = $scope.sshkeyList[$scope.sshkeyList.length];
			                	   $scope.sshkeyList[$scope.sshkeyList.length] = $scope.sshkeyss;
			                	   // For pagination
			                	   $scope.paginationObject.limit = limit;
			                	   $scope.paginationObject.currentPage = pageNumber;
			                	   $scope.paginationObject.totalItems = result.totalItems;
			                   });
			           };
			                $scope.formSubmitted = false;
			                $modalInstance.close();
			                $scope.showLoader = false;
                                        appService.notify({message: 'SSH key created successfully', classes: 'alert-success',
    			                	templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
			                $scope.list(1);
			                $scope.sshkey.name = "";
			                $scope.sshkey.publicKey = "";
			                $scope.sshkey.privateKey = result.privateKey;
			                $scope.sshkey.domain = "";
			                $scope.sshkey.department = "";
                                        $scope.sshkey.project = "";
                        	}).catch(function (result) {
                        		if(result.data.globalError[0] != ''){
                        			var msg = result.data.globalError[0];
                        			appService.notify({message: msg, classes: 'alert-danger',
                        				templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                        			$modalInstance.close();
                        			$state.reload();
                                	}
                        	});
                    	}
                	},
                	$scope.cancel = function () {
                        $modalInstance.close();
                	};
            	}]);
    };

    // Delete the SSH key
    $scope.delete = function (size, sshkey) {
    	appService.dialogService.openDialog($scope.global.VIEW_URL + "cloud/sshkeys/delete.jsp", size, $scope,
    			['$scope', '$modalInstance', function ($scope, $modalInstance) {
    		$scope.deleteObject = sshkey;
            $scope.ok = function (deleteObject) {
            	var domainObject =  deleteObject.domain;
                if(!angular.isUndefined(deleteObject.domain) && deleteObject.domain != null) {
                	deleteObject.domainId = deleteObject.domain.id;
                    delete deleteObject.domain;
                }
                var departmentObject =  deleteObject.department;
                if(!angular.isUndefined(deleteObject.department) && deleteObject.department != null) {
                	deleteObject.departmentId = deleteObject.department.id;
                    delete deleteObject.department;
                }
                $scope.showLoader = true;
                sshkey.isActive = false;
                var hasServer = appService.crudService.softDelete("sshkeys", sshkey);
                hasServer.then(function (result) {
                    $scope.list(1);
                    $scope.showLoader = false;
                    appService.notify({message: 'SSH key deleted successfully', classes: 'alert-success',
                    	templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                }).catch(function (result) {
                	if(result.data.globalError[0] != ''){
                		var msg = result.data.globalError[0];
                        appService.notify({message: msg, classes: 'alert-danger',
                        	templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                    }
                });
		        $scope.cancel();
            },
            $scope.cancel = function () {
            	$modalInstance.close();
            };
            }]);
    };

};
