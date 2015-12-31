/**
 *
 * storageCtrl
 *
 */

angular
    .module('homer')
    .controller('storageCtrl', storageCtrl)

function storageCtrl($scope, $state, $stateParams, appService, filterFilter, $window,
volumeService, modalService, globalConfig) {

	   $scope.global = globalConfig;
	    $scope.formSubmitted = false;
	    // Form Field Decleration
	    $scope.volume = {
	    };
	    $scope.volumeList = [];

	    $scope.paginationObject = {};
	    $scope.storageForm = {};
	    $scope.global = appService.globalConfig;

//
//	    $scope.instanceDetails='';
//	    if ($stateParams.id > 0) {
//	        var hasServer = crudService.read("virtualmachine", $stateParams.id);
//	        hasServer.then(function (result) {  // this is only run after $http
//	            $scope.instance = result;
//	            console.log( $scope.instance);
//	            $scope.volumeList = result.volume;
//
//	        });
//	    }

	    // Volume List
	    $scope.list = function (volume) {
       	var instanceId = $stateParams.id;
       	var hasVolumes = appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "volumes/listbyinstances?instanceid="+instanceId +"&lang=" + appService.localStorageService.cookie.get('language')+"&sortBy=-id");
	        hasVolumes.then(function (result) {
	            $scope.volumeList = result;
	            console.log($scope.volumeList);
	        });
	    };
	    $scope.list(1);

	    $scope.listVm = function (volume) {
	       	var instanceId = $stateParams.id;
	       	var hasInstance = appService.crudService.read("virtualmachine" , instanceId);
	       	hasInstance.then(function (result) {
		            $scope.instanceName=result.name;
		        });
		    };
		    $scope.listVm(1);
	    // Attach Volume
	    $scope.attach = function (size, volume) {
	        $scope.volume = volume;
	        appService.dialogService.openDialog("app/views/cloud/instance/attach-volume.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {

	            // instance List
	        	$scope.volumeList = function (instance) {

	        		if($scope.instance.projectId != null) {
	        			console.log("project " + $scope.instance.projectId);
	        			// var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
	        			var hasVolumes = appService.promiseAjax.httpTokenRequest( appService.crudService.globalConfig.HTTP_GET, appService.crudService.globalConfig.APP_URL + "volumes"  +"/instance/project/"+$scope.instance.projectId);
	        			hasVolumes.then(function (result) {
	        				$scope.volumeList = result;

	        			});
	        		} else {
	        			console.log("department " + $scope.instance.departmentId);
	        			var hasVolumes = appService.promiseAjax.httpTokenRequest( appService.crudService.globalConfig.HTTP_GET, appService.crudService.globalConfig.APP_URL + "volumes"  +"/instance/department/"+$scope.instance.departmentId);
	        			hasVolumes.then(function (result) {
	        				$scope.volumeList = result;

	        			});
	        		}
	        	};
	            $scope.volumeList(1);
//
//	            // instance List
//	        	$scope.volumeList = function (pageNumber) {
//	                var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
//	                var hasVolumes = crudService.list("volumes/listbyvolumetype", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
//	                hasVolumes.then(function (result) {
//	                	  $scope.volumeList = result;
//
//	                    $scope.paginationObject.limit = limit;
//	                    $scope.paginationObject.currentPage = pageNumber;
//	                    $scope.paginationObject.totalItems = result.totalItems;
//	                });
//	            };
//	            $scope.volumeList(1);


	                $scope.attachVolume = function (form, volume) {
	                	volume.vmInstanceId = $stateParams.id;
	                    $scope.formSubmitted = true;
	                    if (form.$valid) {
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
	                        var hasServer = appService.crudService.add("volumes/attach/" + volume.id, volume);
	                        hasServer.then(function (result) {  // this is only run after $http completes
	                        	$scope.showLoader = false;
	                        	appService.notify({message: 'Attached successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
	                            //$window.location.href = '#/instance/list/view/';
	                            $scope.list(1);
	                            $modalInstance.close();
	                        }).catch(function (result) {
	                            if (!angular.isUndefined(result.data)) {
	                                if (result.data.globalError != '' && !angular.isUndefined(result.data.globalError)) {
	                                    var msg = result.data.globalError[0];
	                                    $scope.showLoader = false;
	                                    appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
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
	                    console.log(volume);
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
	                    var hasServer = appService.crudService.add("volumes/detach/" + volume.id, volume);
	                    hasServer.then(function (result) {  // this is only run after $http completes
	                    	$scope.showLoader = false;
	                    	appService.notify({message: 'Detached successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
	                        $scope.list(1);
	                        $modalInstance.close();
	                    }).catch(function (result) {
	                        if (!angular.isUndefined(result.data)) {
	                            if (result.data.globalError != '' && !angular.isUndefined(result.data.globalError)) {
	                                var msg = result.data.globalError[0];
	                                $scope.showLoader = false;
	                                appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
	                            } else if (result.data.fieldErrors != null) {
	                                angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
	                                    $scope.attachvolumeForm[key].$invalid = true;
	                                    $scope.attachvolumeForm[key].errorMessage = errorMessage;
	                                });
	                            }
	                        }
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
	                            var hasServer = appService.crudService.add("snapshots", snapshot);
	                            hasServer.then(function (result) {
	                            	appService.notify({message: 'Added successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
	                                $window.location = "#/snapshot/list";
	                                $modalInstance.close();
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
	        modalService.trigger('app/views/cloud/volume/upload.jsp', size);
	    };

	    $scope.openReccuringSnapshot = function (volume) {
	        modalService.trigger('app/views/cloud/volume/recurring-snapshot.jsp', 'lg');
	    };

	    //Resize Volume
	    $scope.resizeVolume = function (size, volume) {
	        $scope.volume = volume;
	        $scope.volume = angular.copy(volume);
	        appService.dialogService.openDialog($scope.global.VIEW_URL + "cloud/volume/resize.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
	                $scope.diskList = function () {
	                    var hasDisks = appService.crudService.listAll("storages/list");
	                    hasDisks.then(function (result) {  // this is only run after
	                        // $http completes0
	                        $scope.volumeElements.diskOfferingList = result;
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
	                        var volume = $scope.volume;
	                        var hasVolume = appService.crudService.add("volumes/resize/" + volume.id, volume);
	                        hasVolume.then(function (result) {
	                        	$scope.showLoader = false;
	                            $scope.list(1);
	                            appService.notify({message: 'Updated successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
	                            $modalInstance.close();
	                        }).catch(function (result) {
	                            if (!angular.isUndefined(result.data)) {
	                                if (result.data.globalError != '' && !angular.isUndefined(result.data.globalError)) {
	                                    var msg = result.data.globalError[0];
	                                    $scope.showLoader = false;
	                                    appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
	                                } else if (result.data.fieldErrors != null) {
	                                    angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
	                                        $scope.attachvolumeForm[key].$invalid = true;
	                                        $scope.attachvolumeForm[key].errorMessage = errorMessage;
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

	    //Create volume
	    $scope.volume = {};
	    $scope.volumeForm = {};
	    $scope.addVolume = function (size) {
	    	appService.dialogService.openDialog($scope.global.VIEW_URL + "cloud/volume/add.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope',
	                                                                                                 function ($scope, $modalInstance, $rootScope) {

	                $scope.diskList = function (tag) {
	                    if (angular.isUndefined(tag)) {
	                        tag = "";
	                    }
	                    	if(tag === null){
	                    		tag = "";
	                    	}
	                    var hasDisks = appService.crudService.listAllByTag("storages/storagesort", tag);
	                    hasDisks.then(function (result) {  // this is only run after
	                        // $http completes0
	                        $scope.volumeElements.diskOfferingList = result;
	                    });
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

	                $scope.project = {};
	                 $scope.projectList = function () {
	                 var hasProjects = appService.promiseAjax.httpTokenRequest( appService.crudService.globalConfig.HTTP_GET, appService.crudService.globalConfig.APP_URL + "projects/list");
	                 hasProjects.then(function (result) {  // this is only run after $http completes0
	                 	$scope.options = result;
	                 });
	                };

	                // Department list from server
	                $scope.department = {};
	                var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
	                var hasDepartment = appService.promiseAjax.httpTokenRequest( appService.crudService.globalConfig.HTTP_GET, appService.crudService.globalConfig.APP_URL + "departments/list");
	                hasDepartment.then(function (result) {  // this is only run after $http completes0
	                	$scope.volumeElements.departmentList = result;
	                });


	                // Getting list of projects by department
	                $scope.getProjectsByDepartment = function(department) {
	           		 var hasProjects =  appService.promiseAjax.httpTokenRequest( appService.crudService.globalConfig.HTTP_GET, appService.crudService.globalConfig.APP_URL + "projects"  +"/department/"+department.id);
	        		 hasProjects.then(function (result) {  // this is only run after $http completes0
	                    		$scope.options = result;
	                    	 });
	               	};

	                $scope.$watch('volume.department', function (obj) {
	                	if (!angular.isUndefined(obj)) {
	                		$scope.getProjectsByDepartment(obj);
	                	} else {
	                		if($scope.global.sessionValues.type != 'ROOT_ADMIN') {
	                			$scope.projectList();
	                		}

	                	}
	                          });

	                $scope.volume.name = "";
	                $scope.volume.storageTags = "";
	                $scope.volume.storageOffering = "";
	                // Create a new application
	                $scope.save = function (form, volume) {
	                    $scope.formSubmitted = true;

	                    if (form.$valid) {
	                    	$scope.showLoader = true;
	                        $scope.volume.zone = $scope.global.zone;


	                        var volume = angular.copy($scope.volume);
	                        if(!angular.isUndefined($scope.volume.storageOffering) && volume.storageOffering != null) {
	                        	volume.storageOfferingId = volume.storageOffering.id;
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
	                        var hasVolume = appService.crudService.add("volumes", volume);
	                        hasVolume.then(function (result) {
	                        	$scope.showLoader = false;
	                            $scope.list(1);
	                            appService.notify({message: 'Added successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
	                            $modalInstance.close();
	                        }).catch(function (result) {
	 				if (!angular.isUndefined(result) && result.data != null) {
	                                    if (result.data.globalError[0] != '') {
	                                        var msg = result.data.globalError[0];
	                                        $scope.showLoader = false;
	                                        appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
	                                    }
	                            angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
	                                $scope.volumeForm[key].$invalid = true;
	                                $scope.volumeForm[key].errorMessage = errorMessage;
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
//		$scope.volume = {};
//		$scope.volumeForm = {};
		$scope.uploadVolumeCtrl = function (size) {
			appService.dialogService.openDialog($scope.global.VIEW_URL + "cloud/volume/upload.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope',
	                                                                                                 function ($scope, $modalInstance, $rootScope) {
	    $scope.global = globalConfig;
	    // Form Field Decleration
	    $scope.volume.name = "";
	    $scope.volume.zone = "";
	    $scope.volume.storageOffering = "";
	    $scope.volume.format = "";
	    $scope.volume.md5checksum = "";
	    $scope.volume.url = "";

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

		$scope.zoneList = {};
		 $scope.zoneList = function () {
		               var hasZones = appService.crudService.listAll("zones/list");
		               hasZones.then(function (result) {  // this is only run
															// after $http
															// completes0
		                       $scope.zoneList = result;
		console.log($scope.zoneList );

		                });
		            };
		            $scope.zoneList();

	    $scope.diskList = {};
	    $scope.diskList = function () {
	                    var hasDisks = appService.crudService.listAll("storages/list");
	                    hasDisks.then(function (result) {  // this is only run after
	                        // $http completes0
	                        $scope.volumeElements.diskOfferingList = result;
	                    });
	                };
	                $scope.diskList();

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
	             var hasUploadVolume = appService.crudService.add("volumes/upload", volume);
	             hasUploadVolume.then(function (result) {
	            	 $scope.showLoader = false;

	                 $scope.homerTemplate = 'app/views/notification/notify.jsp';
	                 appService.notify({message: 'Uploaded successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
	                 $modalInstance.close();
	                 $scope.list(1);
	             }).catch(function (result) {
	  				if (!angular.isUndefined(result) && result.data != null) {
	                    if (result.data.globalError[0] != '') {
	                        var msg = result.data.globalError[0];
	                        $scope.showLoader = false;
	                        appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
	                    }
	            angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
	                $scope.volumeForm[key].$invalid = true;
	                $scope.volumeForm[key].errorMessage = errorMessage;
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

	//Upload volume from local
	$scope.uploadVolumeFromLocalCtrl = function (size) {
		appService.dialogService.openDialog($scope.global.VIEW_URL + "cloud/volume/upload.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope',
	                                                                                             function ($scope, $modalInstance, $rootScope) {
	$scope.global = globalConfig;
	// Form Field Decleration


	$scope.formSubmitted = false;
	//$scope.formElements = {
//	    formatList: [
//	        {id: 1, name: 'RAW'},
//	        {id: 2, name: 'VHD'},
//	        {id: 3, name: 'VHDX'},
//	        {id: 4, name: 'OVA'},
//	        {id: 5, name: 'QCOW2'}
//	    ]
	//};

	//
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
		appService.dialogService.openDialog("app/views/common/confirm-delete.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
	            $scope.deleteObject = volume;

	            $scope.ok = function (volume) {
		            $scope.showLoader = true;

		            if(!angular.isUndefined(volume.domain) && volume.domain != null ) {
	                	volume.domainId = volume.domain.id;
	                	delete volume.domain;
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

	                volume.id = deleteObject.id;

	                var hasServer = appService.crudService.softDelete("volumes", volume);
	                hasServer.then(function (result) {

	                    $scope.showLoader = false;
	                    appService.notify({message: 'Deleted successfully ', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
	                    $scope.list(1);
	                });
	                $modalInstance.close();
	            },
	                    $scope.cancel = function () {
	                        $modalInstance.close();
	                    };
	        }]);
	};

	};


//    $scope.global = globalConfig;
//    $scope.storageDetails = {};
//    $scope.volumeElements = volumeService.volumeElements;
//    $scope.volume = {};
////    if (localStorageService.get("volumeList") == null) {
////        var hasServer = promiseAjax.httpRequest("GET", "api/instance.json");
////        hasServer.then(function (result) {  // this is only run after $http completes
////            $scope.instanceName = result[$stateParams.id - 1].name;
////            $scope.volumeList = result[$stateParams.id - 1].volumeList;
////            localStorageService.set("volumeList", $scope.volumeList);
////        });
////    } else {
////        var hasServer = promiseAjax.httpRequest("GET", "api/instance.json");
////        hasServer.then(function (result) {
////           $scope.instanceName = result[$stateParams.id - 1].name;
////        });
////        $scope.volumeList = localStorageService.get("volumeList");
////    }
//
//
////    $scope.addVolume = function(size) {
////    	modalService.trigger('app/views/cloud/instance/add-volume.jsp', 'md');
////
////    };
//    //Add volume
//    $scope.volume = {};
//    $scope.volumeForm = {};
//    $scope.addVolume = function (size) {
//        dialogService.openDialog($scope.global.VIEW_URL + "cloud/volume/add.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope',
//                                                                                                 function ($scope, $modalInstance, $rootScope) {
//
//                $scope.diskList = function (tag) {
//                    if (angular.isUndefined(tag)) {
//                        tag = "";
//                    }
//                    	if(tag === null){
//                    		tag = "";
//                    	}
//                    var hasDisks = crudService.listAllByTag("storages/storagesort", tag);
//                    hasDisks.then(function (result) {  // this is only run after
//                        // $http completes0
//                        $scope.volumeElements.diskOfferingList = result;
//                    });
//                };
//
////                $scope.diskTag = function () {
////                    var hasDiskTags = crudService.listAll("storages/storagetags");
////                    hasDiskTags.then(function (result) {  // this is only run after
////                        // $http completes0
////
////                        $scope.volumeElements.diskOfferingTags = result;
////                    });
////                };
////                $scope.diskTag();
//
//                $scope.$watch('volume.storageTags', function (val) {
//                    $scope.diskList(val);
//                });
//                $scope.volume.name = "";
//                $scope.volume.storageTags = "";
//                $scope.volume.storageOffering = "";
//                // Create a new application
//                $scope.save = function (form, volume) {
//                    $scope.formSubmitted = true;
//
//                    if (form.$valid) {
//                        $scope.volume.zone = $scope.global.zone;
//                        var volume = $scope.volume;
//                        var hasVolume = crudService.add("volumes", volume);
//                        hasVolume.then(function (result) {
//                            $scope.list(1);
//                            notify({message: 'Added successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
//                            $modalInstance.close();
//                        }).catch(function (result) {
// 				if (!angular.isUndefined(result) && result.data != null) {
//                                    if (result.data.globalError[0] != '') {
//                                        var msg = result.data.globalError[0];
//                                        notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
//                                    }
//                            angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
//                                $scope.volumeForm[key].$invalid = true;
//                                $scope.volumeForm[key].errorMessage = errorMessage;
//                            });
//
//				}
//                        });
//                    }
//                },
//                        $scope.cancel = function () {
//                            $modalInstance.close();
//                        };
//            }]);
//    };
//
//    $scope.resetDiskValues = function(volumeType) {
//
//        $scope.volume.type = volumeType;
//        $scope.volume.diskOfferings = null;
//        $scope.volumeElements.diskOffer.diskSize.value = 1;
//        $scope.volumeElements.diskOffer.iops.value = 1;
//    };
//
//
//    $scope.save = function(form) {
//        $scope.instanceId = $stateParams.id;
//        $scope.formSubmitted = true;
//        var diskValid = true;
//        if($scope.volume.diskOfferings.custom &&
//                ($scope.volumeElements.diskOffer.diskSize.value <= 0 || $scope.volumeElements.diskOffer.iops.value <= 0)) {
//            diskValid = false;
//        }
//        if (form.$valid && diskValid) {
//            if(filterFilter($scope.volumeList,{'name':$scope.volume.name})[0]== null){
//                $scope.volumeList = volumeService.saveByInstance($scope.volume, $scope.instanceId);
//                localStorageService.set('volumeList', $scope.volumeList);
//                localStorageService.set('instanceViewTab', 'storage');
//
//                $scope.homerTemplate = 'app/views/notification/notify.jsp';
//                notify({message: 'Added successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
//                $scope.cancel();
//                $state.reload();
//            }
//            else {
//                $scope.homerTemplate = 'app/views/notification/notify.jsp';
//                notify({message: 'Disk already added', classes: 'alert-danger', templateUrl: $scope.homerTemplate});
//
//            }
//        }
//    };


