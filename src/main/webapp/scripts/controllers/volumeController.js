/**
 *
 * volumeCtrl
 *
 */

angular
        .module('homer')
        .controller('volumeCtrl', volumeCtrl)
        .controller('recurringSnapshotCtrl', recurringSnapshotCtrl)
        //.controller('uploadVolumeCtrl', uploadVolumeCtrl)

function volumeCtrl($scope, appService, $state, $stateParams, $timeout, volumeService, $window, localStorageService, globalConfig, notify) {
    $scope.global = appService.globalConfig;
    $scope.sort = appService.globalConfig.sort;
    $scope.changeSorting = appService.utilService.changeSorting;
    $scope.formElements = {};
    $scope.volumeElement = {};
    $scope.formSubmitted = false;
    // Form Field Decleration
    $scope.volume = {};
    $scope.volumeList = {};
    $scope.paginationObject = {};
    $scope.storageForm = {};
    $scope.options = {};
    $scope.global = appService.globalConfig;
            appService.globalConfig.webSocketLoaders.volumeLoader = false;
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
            var hasVolumesLists = {};
            $scope.filter = "";
            if ($scope.domainView == null && $scope.quickSearchText == null) {
            	hasVolumesLists =  appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "volumes" +"?lang=" + localStorageService.cookie.get('language') +"&sortBy="+sortOrder+sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
            } else {
            	if ($scope.domainView != null && $scope.quickSearchText == null) {
                    $scope.filter = "&domainId=" + $scope.domainView.id + "&searchText=";
                } else if ($scope.domainView == null && $scope.quickSearchText != null) {
                    $scope.filter = "&domainId=0" + "&searchText=" + $scope.quickSearchText;
                } else {
                    $scope.filter = "&domainId=" + $scope.domainView.id + "&searchText=" + $scope.quickSearchText;
                }
            	hasVolumesLists =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "volumes/listByFilter"
    				+"?lang=" +appService.localStorageService.cookie.get('language')
    				+ $scope.filter +"&sortBy="+$scope.paginationObject.sortOrder+$scope.paginationObject.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
            }
            hasVolumesLists.then(function(result) { // this is only run after $http
            	// completes0
            	$scope.volumeList = result;
            	$scope.volumeList.Count = result.totalItems;
            	console.log(globalConfig.sessionValues.token);
            	// For pagination
            	$scope.paginationObject.limit = limit;
            	$scope.paginationObject.currentPage = pageNumber;
            	$scope.paginationObject.totalItems = result.totalItems;
            	$scope.paginationObject.sortOrder = sortOrder;
            	$scope.paginationObject.sortBy = sortBy;
            	$scope.showLoader = false;
            });
	};

    // Load domain
    $scope.domain = {};
    var hasDomains = appService.crudService.listAll("domains/list");
    hasDomains.then(function (result) {
    	$scope.volumeElement.domainList = result;
    });

    // Department list load based on the domain
    $scope.domainChange = function() {
        $scope.domains = {};
        $scope.volumeElement.departmentList = {};
        $scope.volumeElements.diskOfferingList = {};
        $scope.options = {};
        if (!angular.isUndefined($scope.volume.domain)) {
	        var hasDepartmentList = appService.crudService.listAllByFilter("departments/search", $scope.volume.domain);
	        hasDepartmentList.then(function (result) {
	    	    $scope.volumeElement.departmentList = result;
	        });
	        var hasDisks = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL
	        		+ "storages/listbydomain?domainId="+$scope.volume.domain.id);
	        hasDisks.then(function (result) {  // this is only run after $http completes0
	            $scope.volumeElements.diskOfferingList = result;
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

    // Get volume list based on domain selection
    $scope.selectDomainView = function(pageNumber) {
    	$scope.list(1);
    };

    // Get volume list based on quick search
    $scope.quickSearchText = null;
    $scope.searchList = function(quickSearchText) {
    	if (quickSearchText != "") {
            $scope.quickSearchText = quickSearchText;
    	} else {
    		$scope.quickSearchText = null;
    	}
        $scope.list(1);
    };

    // Volume List
    $scope.list = function (pageNumber) {
        appService.globalConfig.sort.sortOrder = $scope.paginationObject.sortOrder;
        appService.globalConfig.sort.sortBy = $scope.paginationObject.sortBy;
    	 $scope.showLoader = true;
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasVolumes = {};
        $scope.filter = "";
        if ($scope.domainView == null && $scope.quickSearchText == null) {
        	hasVolumes = appService.crudService.list("volumes", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
        } else {
        	if ($scope.domainView != null && $scope.quickSearchText == null) {
                $scope.filter = "&domainId=" + $scope.domainView.id + "&searchText=";
            } else if ($scope.domainView == null && $scope.quickSearchText != null) {
                $scope.filter = "&domainId=0" + "&searchText=" + $scope.quickSearchText;
            } else {
                $scope.filter = "&domainId=" + $scope.domainView.id + "&searchText=" + $scope.quickSearchText;
            }
        	hasVolumes =  appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "volumes/listByFilter"
				+"?lang=" +appService.localStorageService.cookie.get('language')
				+ $scope.filter +"&sortBy="+globalConfig.sort.sortOrder+globalConfig.sort.sortBy+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
        }
        hasVolumes.then(function (result) {
            $scope.volumeList = result;
            $scope.volumeList.Count = result.totalItems;

      		 // Get the count of the listings
            var hasVmCount = {};
            if ($scope.domainView == null && $scope.quickSearchText == null) {
       		    hasVmCount = appService.crudService.listAll("volumes/volumeCounts");
            } else {
            	hasVmCount = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL +
            			"volumes/volumeCountsByDomain?lang="+
            			appService.localStorageService.cookie.get('language')+ $scope.filter +"&sortBy="+globalConfig.sort.sortOrder+globalConfig.sort.sortBy);
            }
       		hasVmCount.then(function(result) {
       			$scope.attachedCount = result.attachedCount;
       			if ($scope.domainView == null && $scope.quickSearchText == null) {
       				$scope.detachedCount = result.detachedCount;
                } else {
                	$scope.detachedCount = $scope.volumeList.Count - result.attachedCount;
                }
    		});

            // For pagination
            $scope.paginationObject.limit = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
            $scope.showLoader = false;
        });
    };
    $scope.list(1);

//    // Delete the volume
//    $scope.delete = function (size, volume) {
//        dialogService.openDialog($scope.global.VIEW_URL + "cloud/volume/delete.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
//        	$scope.deleteId = volume.id;
//                $scope.ok = function (deleteObject) {
//                    var hasServer = crudService.delete("volumes", volume);
//                    hasServer.then(function (result) {
//                        $scope.list(1);
//                        notify({message: 'Deleted successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
//                    });
//                    $modalInstance.close();
//                },
//                 $scope.cancel = function () {
//                     $modalInstance.close();
//                 };
//            }]);
//    };


    // Attach Volume
    $scope.attach = function (size, volume) {
        $scope.volume = volume;
            // instance List
        	$scope.instanceList = function (volume) {
        		if($scope.volume.projectId != null) {
        			// var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        			var hasVolumes = appService.promiseAjax.httpTokenRequest(appService.crudService.globalConfig.HTTP_GET, appService.crudService.globalConfig.APP_URL + "virtualmachine"  +"/volume/project/"+$scope.volume.projectId);
        			hasVolumes.then(function (result) {
			   		$scope.instanceList = result;

        				// $scope.paginationObject.limit = limit;
        				// $scope.paginationObject.currentPage = pageNumber;
        				// $scope.paginationObject.totalItems = result.totalItems;
        			});
        		} else {
        			var hasVolumes = appService.promiseAjax.httpTokenRequest(appService.crudService.globalConfig.HTTP_GET, appService.crudService.globalConfig.APP_URL + "virtualmachine"  +"/volume/department/"+$scope.volume.departmentId);
        			hasVolumes.then(function (result) {
			   		$scope.instanceList = result;

        				// $scope.paginationObject.limit = limit;
        				// $scope.paginationObject.currentPage = pageNumber;
        				// $scope.paginationObject.totalItems = result.totalItems;
        			});
        		}
        	};
            $scope.instanceList(1);

            appService.dialogService.openDialog("app/views/cloud/volume/attach-volume.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
                $scope.attachVolume = function (form, volume) {
                    volume.vmInstance = $scope.vmInstance;
                    $scope.formSubmitted = true;
                    if (form.$valid) {
                    	$scope.showLoader = true;
                    	appService.globalConfig.webSocketLoaders.volumeLoader = true;
                        if(!angular.isUndefined(volume.vmInstance) && volume.vmInstance != null) {
                        	volume.vmInstanceId = volume.vmInstance.id;
                        	delete volume.vmInstance;
                        }
                        if(!angular.isUndefined(volume.storageOffering) && volume.storageOffering != null) {
                        	volume.storageOfferingId = volume.storageOffering.id;
                        	delete volume.storageOffering;
                        }
                        if(!angular.isUndefined(volume.department) && volume.department != null) {
                        	volume.departmentId = volume.department.id;
                        	delete volume.department;
                        }
                        if(!angular.isUndefined(volume.project) && volume.project != null) {
                        	volume.projectId = volume.project.id;
                        	delete volume.project;
                        }
                        if(!angular.isUndefined(volume.zone) && volume.zone != null) {
                        	volume.zoneId = volume.zone.id;
                        	delete volume.zone;
                        }
                        $modalInstance.close();
                        var hasServer = appService.crudService.add("volumes/attach/" + volume.id, volume);
                        hasServer.then(function (result) {  // this is only run after $http completes
                            $scope.showLoader = false;
                        }).catch(function (result) {
                            if (!angular.isUndefined(result.data)) {
                                 if (result.data.fieldErrors != null) {
                                    angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                                    	$scope.showLoader = false;
                                        $scope.attachvolumeForm[key].$invalid = true;
                                        $scope.attachvolumeForm[key].errorMessage = errorMessage;
                                    });
                                }
                            }
                            appService.globalConfig.webSocketLoaders.volumeLoader = false;
                        });
                    }
                };
                $scope.cancel = function () {
                    $modalInstance.close();
                };
            }]);
    };

    // Detach Volume
    $scope.detach = function (size, volume) {
        $scope.volume = volume;
        appService.dialogService.openDialog("app/views/cloud/volume/detach-volume.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
                $scope.instanceList = function () {
                    var hasinstanceList = appService.crudService.listAll("virtualmachine/list");
                    hasinstanceList.then(function (result) {  // this is only run after $http completes0
                        $scope.instanceList = result;
                    });
                };
                $scope.instanceList();
                $scope.detachVolume = function (volume) {
                    $scope.showLoader = true;
                    if(!angular.isUndefined(volume.vmInstance) && volume.vmInstance != null) {
                    	volume.vmInstanceId = volume.vmInstance.id;
                    	delete volume.vmInstance;
                    }
                    if(!angular.isUndefined(volume.storageOffering) && volume.storageOffering != null) {
                    	volume.storageOfferingId = volume.storageOffering.id;
                    	delete volume.storageOffering;
                    }
                    if(!angular.isUndefined(volume.department) && volume.department != null) {
                    	volume.departmentId = volume.department.id;
                    	delete volume.department;
                    }
                    if(!angular.isUndefined(volume.project) && volume.project != null) {
                    	volume.projectId = volume.project.id;
                    	delete volume.project;
                    }
                    if(!angular.isUndefined(volume.zone) && volume.zone != null) {
                    	volume.zoneId = volume.zone.id;
                    	delete volume.zone;
                    }
		    $modalInstance.close();
                    appService.globalConfig.webSocketLoaders.volumeLoader = true;
                    var hasServer = appService.crudService.add("volumes/detach/" + volume.id, volume);
                    hasServer.then(function (result) {  // this is only run after $http completes
                    	$scope.showLoader = false;
                    }).catch(function (result) {
                        if (!angular.isUndefined(result.data)) {
                             if (result.data.fieldErrors != null) {
                                angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                                	$scope.showLoader = false;
                                    $scope.attachvolumeForm[key].$invalid = true;
                                    $scope.attachvolumeForm[key].errorMessage = errorMessage;
                                });
                            }
                        }
                        appService.globalConfig.webSocketLoaders.volumeLoader = false;
                    });
                };
                $scope.cancel = function () {
                    $modalInstance.close();
                };
            }]);
    };

    // Creating snapshot
    $scope.createSnapshot = function (size, volume) {
        $scope.volume = volume;
        $scope.snapshot = {};
        setTimeout(function () {
        	appService.dialogService.openDialog("app/views/cloud/snapshot/download-snapshot.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
                    $scope.validateConfirmSnapshot = function (form) {
                        $scope.formSubmitted = true;
                        if (form.$valid) {
                            var snapshot = $scope.snapshot;
                            snapshot.volume = $scope.volume;
                            snapshot.zone = appService.crudService.globalConfig.zone;
                            appService.globalConfig.webSocketLoaders.volumeLoader = true;
                            $modalInstance.close();
                            var hasServer = appService.crudService.add("snapshots", snapshot);
                            hasServer.then(function (result) {
                            }).catch(function (result) {
                                if (!angular.isUndefined(result) && result.data != null) {
                                    if (result.data.globalError[0] != '') {
                                        var msg = result.data.globalError[0];
                                        appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                                    }
                                    angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                                        $scope.confirmsnapshot[key].$invalid = true;
                                        $scope.confirmsnapshot[key].errorMessage = errorMessage;
                                    });
                                }
                                appService.globalConfig.webSocketLoaders.volumeLoader = false;
                            });
                        }
                    };
                    // Close the dialog box
                    $scope.cancel = function () {
                        $modalInstance.close();
                    };
                }]);
        }, 500);
    };

    $scope.openUploadVolumeContainer = function (size) {
    	appService.modalService.trigger('app/views/cloud/volume/upload.jsp', size);
    };

    //Resize Volume
    $scope.resizeVolume = function (size, volume) {
    	 $scope.volume = {};
        appService.dialogService.openDialog($scope.global.VIEW_URL + "cloud/volume/resize.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
            $scope.volume = volume;
            $scope.volume = angular.copy(volume);
        	$scope.diskList = function () {
        		var hasDisks = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL
    	        		+ "storages/listbydomain?domainId="+$scope.volume.domain.id);
    	        hasDisks.then(function (result) { // this is only run after
                        // $http completes0
                        $scope.volumeElements.OfferingList = result;
                        angular.forEach(result, function(item){
                       	 if (!angular.isUndefined($scope.volume.storageOffering)) {
                       		 if(item.description === $scope.volume.storageOffering.description){
                       			 var index = $scope.volumeElements.diskOfferingList.indexOf(item);
   					 $scope.volume.storageOffering = result[index];
                       		 }
                       	 }
                       	 	});
                    });
                };
                $scope.diskList();

                var size= $scope.volume.diskSize  / $scope.global.Math.pow(2, 30);

                $scope.rsize= size;

                // Resize the Volume
                $scope.update = function (form, volume) {
                    $scope.formSubmitted = true;
                    if (form.$valid) {
                    	$scope.showLoader = true;
                        $scope.volume.zone = $scope.global.zone;
                        var volume = angular.copy($scope.volume);
                    	if (!angular.isUndefined($scope.volume.storageOffering.diskSize) && volume.storageOffering.diskSize != null) {
                    		volume.diskSize = volume.storageOffering.diskSize;
                    	}
                        if(!angular.isUndefined($scope.volume.storageOffering) && volume.storageOffering != null) {
                        	volume.storageOfferingId = volume.storageOffering.id;
                        	if(!volume.storageOffering.isCustomDisk){
                        		delete volume.diskSize;
                        	}
                        	delete volume.storageOffering;
                        }
                        if(!angular.isUndefined(volume.vmInstance) && volume.vmInstance != null) {
                        	volume.vmInstanceId = volume.vmInstance.id;
                        	delete volume.vmInstance;
                        }
                        if(!angular.isUndefined($scope.volume.department) && volume.department != null) {
                        	volume.departmentId = volume.department.id;
                        	delete volume.department;
                        }
                        if(!angular.isUndefined($scope.volume.project) && volume.project != null) {
                        	volume.projectId = volume.project.id;
                        	delete volume.project;
                        }
                        if(!angular.isUndefined($scope.volume.zone) && volume.zone != null) {
                        	volume.zoneId = volume.zone.id;
                        	delete volume.zone;
                        }
                    	 appService.globalConfig.webSocketLoaders.volumeLoader = true;
                         $modalInstance.close();
                        var hasVolume = appService.crudService.add("volumes/resize/" + volume.id, volume);
                        hasVolume.then(function (result) {
                           $scope.showLoader = false;
                        }).catch(function (result) {
                            if (!angular.isUndefined(result.data)) {
                               if (result.data.fieldErrors != null) {
                                    angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                                        $scope.volumeForm[key].$invalid = true;
                                        $scope.volumeForm[key].errorMessage = errorMessage;
                                    });
                                }
                            }
                            appService.globalConfig.webSocketLoaders.volumeLoader = false;
                        });
                    }
                },
                $scope.cancel = function () {
                    $modalInstance.close();
                };
            }]);
    };
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

   	$scope.getDiskList = {};
    $scope.getDiskList = function (domainId, tag) {
    	var hasDisks = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL
        		+ "storages/storagesort?tags="+tag+"&domainId="+domainId);
	    hasDisks.then(function (result) {  // this is only run after $http completes0
		    $scope.volumeElements.diskOfferingList = result;
	    });
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

    //Create volume
    $scope.volume = {};
    $scope.volumeForm = {};
    $scope.addVolume = function (size) {
        $scope.volume = {};
    	 if($scope.global.sessionValues.type === 'USER') {
    		 var hasDepartments = appService.crudService.read("departments", $scope.global.sessionValues.departmentId);
    		 hasDepartments.then(function (result) {
    			 $scope.volume.department = result;
    		 });
    	 }

    	appService.dialogService.openDialog($scope.global.VIEW_URL + "cloud/volume/add.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope',
                                                                                                 function ($scope, $modalInstance, $rootScope) {
    		$scope.diskList = function (tag) {
                    if (angular.isUndefined(tag)) {
                        tag = "";
                    }
                	if(tag === null){
                		tag = "";
                	}

                	$scope.volumeElements.diskOfferingList = {};
                	$scope.volumeElement.departmentList = {};
                	if ($scope.global.sessionValues.type !== 'ROOT_ADMIN' && !angular.isUndefined($scope.global.sessionValues.domainId)) {
    	            	$scope.getDiskList($scope.global.sessionValues.domainId, tag);
    	            } else if (!angular.isUndefined($scope.volume.domain)) {
    	            	$scope.getDiskList($scope.volume.domain.id, tag);
    	            }
                };

                $scope.diskTag = function () {
                    var hasDiskTags = appService.crudService.listAll("storages/storagetags");
                    hasDiskTags.then(function (result) {  // this is only run after
                        // $http completes0

                        $scope.volumeElements.diskOfferingTags = result;
                    });
                };
                $scope.diskTag();

                $scope.$watch('volume.storageTags', function (val) {
                    $scope.diskList(val);
                });

                // Department list from server
                $scope.department = {};
                var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
                var hasDepartment = appService.promiseAjax.httpTokenRequest(appService.crudService.globalConfig.HTTP_GET, appService.crudService.globalConfig.APP_URL + "departments/list");
                hasDepartment.then(function (result) {  // this is only run after $http completes0
                	$scope.volumeElements.departmentList = result;
                });

                // Create a new application
                $scope.save = function (form, volume) {
                    $scope.formSubmitted = true;
                    if (form.$valid) {
                    	$scope.showLoader = true;
                        $scope.volume.zone = $scope.global.zone;
                        var volume = angular.copy($scope.volume);
                        if(!angular.isUndefined($scope.volume.storageOffering) && volume.storageOffering != null) {
                        	volume.storageOfferingId = volume.storageOffering.id;
                        	if(!volume.storageOffering.isCustomDisk){
                        		delete volume.diskSize;
                        	}
                        	delete volume.storageOffering;
                        }
                        if(!angular.isUndefined($scope.volume.department) && volume.department != null) {
                        	volume.departmentId = volume.department.id;
                        	delete volume.department;
                        }
                        if(!angular.isUndefined($scope.volume.project) && volume.project != null) {
                        	volume.projectId = volume.project.id;
                        	delete volume.project;
                        }
                        if(!angular.isUndefined($scope.volume.zone) && volume.zone != null) {
                        	volume.zoneId = volume.zone.id;
                        	delete volume.zone;
                        }
 			$modalInstance.close();
                        appService.globalConfig.webSocketLoaders.volumeLoader = true;
                        var hasVolume = appService.crudService.add("volumes", volume);
                        hasVolume.then(function (result) {
                        	$scope.showLoader = false;
                        }).catch(function (result) {
                        	$scope.showLoader = false;
                		    if (!angular.isUndefined(result.data)) {
                    		 if (result.data.fieldErrors != null) {
                           	$scope.showLoader = false;
                            	angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                                	$scope.volumeForm[key].$invalid = true;
                                	$scope.volumeForm[key].errorMessage = errorMessage;
                            	});
                    		}
                    	}
                		    appService.globalConfig.webSocketLoaders.volumeLoader = false;
                	});
                    }
                },
                $scope.cancel = function () {
                    $modalInstance.close();
                };
            }]);
    };

    $scope.volumeElements = volumeService.volumeElements;

    $scope.downloads = false;
    $scope.download = function () {
        $scope.downloadLoding = true;
        $timeout($scope.downloadActions, 2000);

    };

    $scope.downloadLink = function (url) {
        $window.location.href = url;
        $scope.cancel();
    }

    $scope.downloadActions = function () {
        $scope.downloading = true;
        $scope.downloadLoding = false;

    };

    $scope.confirmSnapshot = function () {
        $scope.cancel();
        $window.location.href = '#volume/snapshot';
    };

    $scope.resetDiskValues = function (volumeType) {
        $scope.volume.type = volumeType;
        $scope.volume.storageOffering = null;
        $scope.volumeElements.storageOffering.diskSize.value = 0;
        $scope.volumeElements.storageOffering.iops.value = 0;
    };


 // Upload volume
	$scope.volume = {};
	$scope.volumeForm = {};
	$scope.uploadVolumeCtrl = function (size) {
    $scope.volume = {};
    $scope.volumeElement.departmentList = {};
    $scope.volumeElements.diskOfferingList = {};
   	 if($scope.global.sessionValues.type === 'USER') {
   		 var hasDepartments = appService.crudService.read("departments", $scope.global.sessionValues.departmentId);
   		 hasDepartments.then(function (result) {
   			 $scope.volume.department = result;
   		 });
   	 }

		appService.dialogService.openDialog($scope.global.VIEW_URL + "cloud/volume/upload.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope',
                                                                                                 function ($scope, $modalInstance, $rootScope) {
	    $scope.global = appService.globalConfig;
    // Form Field Decleration


    $scope.formSubmitted = false;
    $scope.formElements = {
        formatList: {
          "0":"RAW",
       	  "1":"VHD",
       	  "2":"VHDX",
       	  "3":"OVA",
       	  "4":"QCOW2"
        }
    };

	/*$scope.zoneList = {};*/
	 $scope.zoneList = function () {
	               var hasZones = appService.crudService.listAll("zones/list");
	               hasZones.then(function (result) {  // this is only run
														// after $http
														// completes0
	                       $scope.zoneList = result;
	                });
	            };
	            $scope.zoneList();

	            if ($scope.global.sessionValues.type !== 'ROOT_ADMIN') {
	            	if (!angular.isUndefined($scope.global.sessionValues.domainId)) {
	            		var hasDisks = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL
	            	    		+ "storages/listbydomain?domainId="+$scope.global.sessionValues.domainId);
	            	    hasDisks.then(function (result) {  // this is only run after $http completes0
	            		$scope.volumeElements.diskOfferingList = result;
	            	    });
	            	}
	            }

               // Department list from server
               $scope.department = {};
               var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
               var hasDepartment = appService.promiseAjax.httpTokenRequest(appService.crudService.globalConfig.HTTP_GET, appService.crudService.globalConfig.APP_URL + "departments/list");
               hasDepartment.then(function (result) {  // this is only run after $http completes0
               	$scope.volumeElements.departmentList = result;
               });

    $scope.uploadVolume = function (form, volume) {
        $scope.formSubmitted = true;
        if (form.$valid) {
        	$scope.showLoader = true;
             var volume = $scope.volume;
             if(volume.storageOffering == "") {
            	 delete volume.storageOffering;
             }
             if(volume.md5checksum == "") {
            	 delete volume.md5checksum;
             }
             var volume = angular.copy($scope.volume);
             if(!angular.isUndefined(volume.storageOffering) && volume.storageOffering != null) {
             	volume.storageOfferingId = volume.storageOffering.id;
             	delete volume.storageOffering;
             }
             if(!angular.isUndefined(volume.zone) && volume.zone != null) {
             	volume.zoneId = volume.zone.id;
             	delete volume.zone;
             }
             if(!angular.isUndefined($scope.volume.department) && volume.department != null) {
             	volume.departmentId = volume.department.id;
             	delete volume.department;
             }
             if(!angular.isUndefined($scope.volume.project) && volume.project != null) {
             	volume.projectId = volume.project.id;
             	delete volume.project;
             }
             if(!angular.isUndefined($scope.volume.domain) && volume.domain != null) {
              	volume.domainId = volume.domain.id;
              	delete volume.domain;
              }
		$modalInstance.close();
        	appService.globalConfig.webSocketLoaders.volumeLoader = true;

             var hasUploadVolume = appService.crudService.add("volumes/upload", volume);
             hasUploadVolume.then(function (result) {
            	 $scope.showLoader = false;
            	}).catch(function (result) {
             	$scope.showLoader = false;
             	 appService.globalConfig.webSocketLoaders.volumeLoader = false;
    		    if (!angular.isUndefined(result.data)) {
        		 if (result.data.fieldErrors != null) {
               	$scope.showLoader = false;
                	angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                    	$scope.volumeForm[key].$invalid = true;
                    	$scope.volumeForm[key].errorMessage = errorMessage;
                	});
        		}
        	}
    	});
            }
        },
        $scope.cancel = function () {
            $modalInstance.close();
        };
    }]);
};

//Upload volume from local
$scope.uploadVolumeFromLocalCtrl = function (size) {
	appService.dialogService.openDialog($scope.global.VIEW_URL + "cloud/volume/upload.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope',
                                                                                             function ($scope, $modalInstance, $rootScope) {
$scope.global = globalConfig;
// Form Field Decleration


$scope.formSubmitted = false;

$scope.validateVolume = function (form, volume) {

    $scope.formSubmitted = true;
    if (form.$valid) {
    	 $scope.volume.zone = $scope.global.zone;
         var volume = $scope.volume;
         var hasUploadVolume = appService.crudService.add("volumes", volume);
         hasUploadVolume.then(function (result) {
	     $scope.list(1);
             $scope.homerTemplate = 'app/views/notification/notify.jsp';
             appService.notify({message: 'Uploaded successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
             $modalInstance.close();
        appService.globalConfig.webSocketLoaders.volumeLoader = true;
         }).catch(function (result) {
				if (!angular.isUndefined(result) && result.data != null) {
                if (result.data.globalError[0] != '') {
                    var msg = result.data.globalError[0];
                    appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                }
        angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
            $scope.volumeForm[key].$invalid = true;
            $scope.volumeForm[key].errorMessage = errorMessage;
        });

			}
				 appService.globalConfig.webSocketLoaders.volumeLoader = false;
                    });
                }
            },
            $scope.cancel = function () {
                $modalInstance.close();
            };
}]);
};

   $scope.openReccuringSnapshot = function (volume) {

 	appService.dialogService.openDialog('app/views/cloud/volume/recurring-snapshot.jsp', 'lg', $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
	$scope.recurringSnapshot = volume;
        $scope.volumeId = volume.id;
	$scope.snapshotTab = {};
$scope.snapshotList = function () {
                    var hasDisks = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "snapshotpolicies/listbyvolume?volumeid="+$scope.volumeId  +"&lang=" + appService.localStorageService.cookie.get('language')+"&sortBy=-id");
                    hasDisks.then(function (result) {  // this is only run after
                        // $http completes0

                        $scope.snapshotList = result;
			angular.forEach($scope.snapshotList , function(obj, key) {
				$scope.snapshotTab[obj.intervalType] = true;
				scheduleTimeArr = obj.scheduleTime.split(":");
				obj.scheduleTest = scheduleTimeArr[1] + ":" + scheduleTimeArr[0] ;
				obj.scheduleType = scheduleTimeArr[2];

	if(obj.scheduleType== 0)
		{
		obj.day="Sunday";
		}
if(obj.scheduleType== 1)
		{
		obj.day="Monday";
		}
if(obj.scheduleType== 2)
		{
		obj.day="Tuesday";
		}
if(obj.scheduleType== 3)
		{
		obj.day="Wednesday";
		}

		if(obj.scheduleType== 4)
		{
		obj.day="Thursday";
		}
if(obj.scheduleType== 5)
		{
		obj.day="Friday";
		}
if(obj.scheduleType== 6)
		{
		obj.day="Saturday";
		}

 //var scheduleTypeDay= ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday","Saturday"];
 		   //  obj.scheduleTypes = scheduleType[obj.scheduleType];
			$scope.snapshotList[key] = obj;
			});
                    });
                };
   $scope.snapshotList();

$scope.recurringSnapshotLists = function () {
		console.log(volume);
		    $scope.volumeId = volume.id;
                    var hasDisks = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "snapshotpolicies/listbyvolume?volumeid="+$scope.volumeId  +"&lang=" + appService.localStorageService.cookie.get('language')+"&sortBy=-id");
                    hasDisks.then(function (result) {  // this is only run after
                        // $http completes0

                        $scope.recurringSnapshotList = result;

             });
};
   $scope.recurringSnapshotLists();

      $scope.deleteSnapshotPolicy = function(size, snapshot) {
    appService.dialogService.openDialog("app/views/common/confirm-delete.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
	    $scope.deleteObject = snapshot;
            $scope.ok = function (deleteObject) {
                var hasServer = appService.crudService.delete("snapshotpolicies", deleteObject);
                hasServer.then(function (result) {

                    appService.notify({message: 'Deleted successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
 $scope.recurringSnapshotLists();
		    $modalInstance.close();
                });

 $modalInstance.close();
            },

            $scope.cancel = function () {
                $modalInstance.close();
            };


        }]);


   };



        $scope.recurringsave = function (form, recurringSnapshot) {
		if (!angular.isUndefined($scope.recurringSnapshot.domain)) {
                recurringSnapshot.domainId = $scope.recurringSnapshot.domain.id;
                delete recurringSnapshot.domain;
            }
            if (!angular.isUndefined($scope.recurringSnapshot.department) && $scope.recurringSnapshot.department != null) {
                recurringSnapshot.departmentId = $scope.recurringSnapshot.department.id;
                delete recurringSnapshot.department;
            }
	   if (!angular.isUndefined(recurringSnapshot.id) && recurringSnapshot.id != null) {
             recurringSnapshot.volumeId = recurringSnapshot.id;
		delete recurringSnapshot.volume;
            }
 	   if (!angular.isUndefined($scope.recurringSnapshot.zone) && $scope.recurringSnapshot.zone != null) {
                recurringSnapshot.zoneId = $scope.recurringSnapshot.zone.id;
                delete recurringSnapshot.zone;
            }
             $scope.formSubmitted = true;

            if (form.$valid) {
            	$scope.showLoader = true;
		recurringSnapshot.timeZone = recurringSnapshot.timeZone.name;
		recurringSnapshot.dayOfWeek = recurringSnapshot.dayOfWeek.name;
			recurringSnapshot.intervalType = recurringSnapshot.intervalType.toUpperCase();
                var hasVolume = appService.crudService.add("snapshotpolicies",  recurringSnapshot);
                hasVolume.then(function (result) {
                	$scope.showLoader = false;
                	$modalInstance.close();
                }).catch(function (result) {
                	$scope.showLoader = false;
        		    if (!angular.isUndefined(result.data)) {
            		if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
              	   	 var msg = result.data.globalError[0];
              	   	 $scope.showLoader = false;
            	    	 appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                	}
            	}
        	});
            }
        },
        $scope.cancel = function () {
            $modalInstance.close();
        };
}]);
    };


// Delete the Volume
$scope.delete = function (size, volume) {
	appService.dialogService.openDialog("app/views/cloud/volume/delete.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
            $scope.deleteObject = volume;
            $scope.ok = function (volume) {
            	$scope.showLoader = true;
            	if(!angular.isUndefined(volume.domain) && volume.domain != null ) {
                	volume.domainId = volume.domain.id;
                	delete volume.domain;
                }
                if(!angular.isUndefined(volume.project) && volume.project != null) {
                	volume.projectId = volume.project.id;
                	delete volume.project;
                }
                if(!angular.isUndefined(volume.zone) && volume.zone != null) {
                	volume.zoneId = volume.zone.id;
                	delete volume.zone;
                }

                //volume.id = deleteObject.id;

                $modalInstance.close();
            	appService.globalConfig.webSocketLoaders.volumeLoader = true;
                var hasServer = appService.crudService.softDelete("volumes", volume);
                hasServer.then(function (result) {
		$scope.showLoader = false;
                }).catch(function (result) {
                    if (!angular.isUndefined(result) && result.data != null) {
                    	$scope.showLoader = false;
                        angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                            $scope.addnetworkForm[key].$invalid = true;
                            $scope.addnetworkForm[key].errorMessage = errorMessage;
                        });
                    }
                    appService.globalConfig.webSocketLoaders.volumeLoader = false;
                });

            },
                    $scope.cancel= function () {
                        $modalInstance.close();
                    };
        }]);
};

    // Form Field Decleration
    $scope.recurringSnapshot = {
        minutes: 60,
        hour: 12
    };

    $scope.getNumber = {};

    $scope.formElements = {
        timeZoneList: [
            {
                "id": 1,
                "name": "Etc/GMT+12"
            },
            {
                "id": 2,
                "name": "Pacific/Midwa"
            },
            {
                "id": 3,
                "name": "Pacific/Niue"
            },
            {
                "id": 4,
                "name": "Pacific/Pago_Pago"
            },
            {
                "id": 5,
                "name": "Pacific/Samoa"
            },
            {
                "id": 6,
                "name": "US/Samoa"
            },
            {
                "id": 7,
                "name": "America/Adak"
            }
        ],
      dayOfWeekList: [
            {
                "id": 0,
                "name": "SUNDAY"
            },
  	     {
                "id": 1,
                "name": "MONDAY"
            },
	   {
                "id": 2,
                "name": "TUESDAY"
            },
{
                "id": 3,
                "name": "WEDNESDAY"
            },
{
                "id": 4,
                "name": "THURSDAY"
            },
{
                "id": 5,
                "name": "FRIDAY"
            },
{
                "id": 6,
                "name": "SATURDAY"
            }
	],
         hourCount: new Array(12),
        minuteCount: new Array(60),
        dayOfMonth: new Array(28)
    };




   /* $scope.snapshotList = [
        {
            time: 1,
            dayOfWeek: "Every Sunday",
            timeZone: {
                "id": 4,
                "name": "Pacific/Pago_Pago"
            },
            noOfSnapshots: 1
        },
        {
            time: 1,
            dayOfWeek: "Day 1 of month",
            timeZone: {
                "id": 4,
                "name": "Pacific/Midwa"
            },
            noOfSnapshots: 1
        },
    ];*/

    $scope.number = 5;
    $scope.getNumber = function (num) {
        return new Array(num);
    }

    $scope.mytime = new Date();

    $scope.hstep = 1;
    $scope.mstep = 15;

    $scope.options = {
        hstep: [1, 2, 3],
        mstep: [1, 5, 10, 15, 25, 30]
    };

    $scope.ismeridian = true;
    $scope.toggleMode = function () {
        $scope.ismeridian = !$scope.ismeridian;
    };

    $scope.save = function (form) {
        $scope.formSubmitted = true;
        if (form.$valid) {
            $scope.snapshotList.push($scope.recurringSnapshot);
        }
    };
        $scope.$on(appService.globalConfig.webSocketEvents.volumeEvents.attachVolume, function(event, args) {
            appService.globalConfig.webSocketLoaders.volumeLoader = false;
            $scope.list(1);
        });
         $scope.$on(appService.globalConfig.webSocketEvents.volumeEvents.detachVolume, function(event, args) {
             appService.globalConfig.webSocketLoaders.volumeLoader = false;
             $scope.list(1);
         });
         $scope.$on(appService.globalConfig.webSocketEvents.volumeEvents.createSnapshot, function(event, args) {
        appService.globalConfig.webSocketLoaders.volumeLoader = false;
	if(args.status !== 'FAILED' || args.status !== 'ERROR') {
		$window.location = "#/snapshot/list";
	}
        });
         $scope.$on(appService.globalConfig.webSocketEvents.volumeEvents.volumeresize, function(event, args) {
             appService.globalConfig.webSocketLoaders.volumeLoader = false;
             $scope.list(1);
         });
         $scope.$on(appService.globalConfig.webSocketEvents.volumeEvents.volumesave, function(event, args) {
             appService.globalConfig.webSocketLoaders.volumeLoader = false;
             $scope.list(1);
         });
         $scope.$on(appService.globalConfig.webSocketEvents.volumeEvents.uploadVolume, function(event, args) {
             appService.globalConfig.webSocketLoaders.volumeLoader = false;
             $scope.list(1);
         });
         $scope.$on(appService.globalConfig.webSocketEvents.volumeEvents.recurringSnapshot, function(event, args) {
             appService.globalConfig.webSocketLoaders.volumeLoader = false;
             $scope.list(1);
         });
         $scope.$on(appService.globalConfig.webSocketEvents.volumeEvents.volumedelete, function(event, args) {
             appService.globalConfig.webSocketLoaders.volumeLoader = false;
             $scope.list(1);
         });
        $scope.$on("Volume", function(event, args) {
            appService.globalConfig.webSocketLoaders.volumeLoader = false;
            $scope.list(1);
        });

};



function recurringSnapshotCtrl($scope,appService, globalConfig, localStorageService, $window, notify) {

    $scope.global = globalConfig;
    $scope.formSubmitted = false;
    // Form Field Decleration
    $scope.recurringSnapshot = {
        minutes: 60,
        hour: 12
    };

    $scope.getNumber = {};

    $scope.formElements = {
        timeZoneList: [
            {
                "id": 1,
                "name": "Etc/GMT+12"
            },
            {
                "id": 2,
                "name": "Pacific/Midwa"
            },
            {
                "id": 3,
                "name": "Pacific/Niue"
            },
            {
                "id": 4,
                "name": "Pacific/Pago_Pago"
            },
            {
                "id": 5,
                "name": "Pacific/Samoa"
            },
            {
                "id": 6,
                "name": "US/Samoa"
            },
            {
                "id": 7,
                "name": "America/Adak"
            }
        ],
        hourCount: new Array(12),
        minuteCount: new Array(60),
        dayOfMonth: new Array(28)
    };

    $scope.number = 5;
    $scope.getNumber = function (num) {
        return new Array(num);
    }

    $scope.mytime = new Date();

    $scope.hstep = 1;
    $scope.mstep = 15;

    $scope.options = {
        hstep: [1, 2, 3],
        mstep: [1, 5, 10, 15, 25, 30]
    };

    $scope.ismeridian = true;
    $scope.toggleMode = function () {
        $scope.ismeridian = !$scope.ismeridian;
    };

    $scope.save = function (form) {
        $scope.formSubmitted = true;
        if (form.$valid) {
            $scope.snapshotList.push($scope.recurringSnapshot);
        }
    };
}
