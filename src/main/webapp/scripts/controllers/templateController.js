/**
 *
 * templatesCtrl
 *
 */

angular
        .module('homer')
        .controller('templatesCtrl', templatesCtrl)
        .controller('templateDetailsCtrl', templateDetailsCtrl)
        .controller('uploadTemplateCtrl', uploadTemplateCtrl)

function templatesCtrl($scope, $stateParams, appService, $timeout, promiseAjax, globalConfig, $modal, $log, localStorageService) {

    $scope.global = globalConfig;
    $scope.sort = appService.globalConfig.sort;
    $scope.changeSorting = appService.utilService.changeSorting;
    $scope.template = {
        templateList: {}
    };
 $scope.templates = {};
$scope.template.listAllTemplate = {};
 $scope.TemplateForm = {};
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
                var hasCommunityList = appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "templates/listall" +"?lang=" + localStorageService.cookie.get('language') +"&sortBy="+sortOrder+sortBy +"&type=community"+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});


                    hasCommunityList.then(function(result) { // this is only run after $http
			// completes0
			$scope.communityList = result;
			// For pagination
			$scope.paginationObject.limit = limit;
			$scope.paginationObject.currentPage = pageNumber;
			$scope.paginationObject.totalItems = result.totalItems;
			$scope.paginationObject.sortOrder = sortOrder;
			$scope.paginationObject.sortBy = sortBy;
			$scope.showLoader = false;
		});
	};

    $scope.templateList = function () {
        $scope.showLoader = true;
        var hastemplateList = appService.crudService.listAll("templates/list");
        hastemplateList.then(function (result) {  // this is only run after $http completes0
            $scope.template.templateList = result;
            $scope.showLoader = false;
        });

    };
    $scope.templateList();

    $scope.communitylist = function () {
    $scope.formElements.category = 'community';
    //community List
    $scope.list = function (pageNumber) {
        appService.globalConfig.sort.sortOrder = $scope.paginationObject.sortOrder;
        appService.globalConfig.sort.sortBy = $scope.paginationObject.sortBy;
    	$scope.showLoader = true;
    	var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasCommunity = appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "templates/listall" +"?lang=" + localStorageService.cookie.get('language') +"&sortBy="+appService.globalConfig.sort.sortOrder+appService.globalConfig.sort.sortBy +"&type=community"+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});

        hasCommunity.then(function (result) {  // this is only run after $http completes0
            $scope.communityList = result;
            // For pagination
            $scope.paginationObject.limit = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
            $scope.showLoader = false;
        });
    };
    $scope.list (1);

    }

  $scope.changeSorts = function(sortBy, pageNumber) {
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
                var hasFeaturedList = appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "templates/listall" +"?lang=" + localStorageService.cookie.get('language') +"&sortBy="+sortOrder+sortBy +"&type=featured"+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});


                    hasFeaturedList.then(function(result) { // this is only run after $http
			// completes0
			$scope.featuredList = result;
			// For pagination
			$scope.paginationObject.limit = limit;
			$scope.paginationObject.currentPage = pageNumber;
			$scope.paginationObject.totalItems = result.totalItems;
			$scope.paginationObject.sortOrder = sortOrder;
			$scope.paginationObject.sortBy = sortBy;
			$scope.showLoader = false;
		});
	};

   $scope.featuredlist = function () {
   $scope.formElements.category = 'featured';
    //featured List
    $scope.list = function (pageNumber) {
        appService.globalConfig.sort.sortOrder = $scope.paginationObject.sortOrder;
        appService.globalConfig.sort.sortBy = $scope.paginationObject.sortBy;
    	$scope.showLoader = true;
    	var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasFeatured = appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "templates/listall" +"?lang=" + localStorageService.cookie.get('language') +"&sortBy="+appService.globalConfig.sort.sortOrder+appService.globalConfig.sort.sortBy +"&type=featured"+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
        hasFeatured.then(function (result) {  // this is only run after $http completes0
            $scope.featuredList = result;
            // For pagination
            $scope.paginationObject.limit = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
            $scope.showLoader = false;
        });
    };
    $scope.list (1);
   }

   $scope.changeSortings = function(sortBy, pageNumber) {
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
                var hasUserTemplateList = appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "templates/listall" +"?lang=" + localStorageService.cookie.get('language') +"&sortBy="+sortOrder+sortBy +"&type=user"+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});


                    hasUserTemplateList.then(function(result) { // this is only run after $http
			// completes0
			$scope.userTemplateList = result;
			// For pagination
			$scope.paginationObject.limit = limit;
			$scope.paginationObject.currentPage = pageNumber;
			$scope.paginationObject.totalItems = result.totalItems;
			$scope.paginationObject.sortOrder = sortOrder;
			$scope.paginationObject.sortBy = sortBy;
			$scope.showLoader = false;
		});
	};
   

   $scope.usertemplatelist = function () {
   $scope.formElements.category = 'mytemplates';

     var hastemplates= appService.crudService.listAll("templates/listalltemplate");
        hastemplates.then(function (result) {  // this is only run after $http completes0
            $scope.template.listAllTemplate = result;
            $scope.showLoader = false;
        });

    //Mytemplate List
    $scope.list = function (pageNumber) {
        appService.globalConfig.sort.sortOrder = $scope.paginationObject.sortOrder;
        appService.globalConfig.sort.sortBy = $scope.paginationObject.sortBy;
    	$scope.showLoader = true;
    	var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasFeatured = appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "templates/listall" +"?lang=" + localStorageService.cookie.get('language') +"&sortBy="+appService.globalConfig.sort.sortOrder+appService.globalConfig.sort.sortBy +"&type=user"+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
        hasFeatured.then(function (result) {  // this is only run after $http completes0
            $scope.userTemplateList = result;
            // For pagination
            $scope.paginationObject.limit = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
            $scope.showLoader = false;
        });
    };
    $scope.list (1);
   }

    $scope.showCommunityTemplateContent = function () {
        $scope.showLoader = true;
        $timeout(function () {
            $scope.showLoader = false;
            $scope.listView = !$scope.listView;
        }, 800);
	$scope.communitylist();
    };

    $scope.showFeaturedTemplateContent = function () {
        $scope.showLoader = true;
        $timeout(function () {
            $scope.showLoader = false;
            $scope.listView = !$scope.listView;
        }, 800);
    $scope.featuredlist();
    };

   $scope.showUserTemplateContent = function () {
        $scope.showLoader = true;
        $timeout(function () {
            $scope.showLoader = false;
            $scope.listView = !$scope.listView;
        }, 800);
    $scope.usertemplatelist();
    };

	 // OS Categorys list from server
    $scope.oscategorys = {};
    var hasOsCategoryList = appService.crudService.listAll("oscategorys/list");
    hasOsCategoryList.then(function (result) {
    	$scope.formElements.osCategoryList = result;
    });

    // OS Type list from server
    $scope.categoryChange = function() {
        $scope.ostypes = {};
        var hasosTypeList = appService.crudService.filterList("ostypes/list", $scope.templates.osCategory.name);
        hasosTypeList.then(function (result) {
    	    $scope.formElements.osTypeList = result;
        });
    };

	 // Hypervisors list from server
    $scope.hypervisors = {};
    var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
    var hashypervisorList = appService.crudService.list("hypervisors", $scope.global.paginationHeaders(1, limit), {"limit": limit});
    hashypervisorList.then(function (result) {
    	$scope.formElements.hypervisorList = result;
    });


	  $scope.templateCostList = function () {
        $scope.showLoader = true;
        var hastemplateList = appService.crudService.listAll("miscellaneous/listtemplate");
        hastemplateList.then(function (result) {  // this is only run after $http completes0
            $scope.miscellaneousList = result;
            $scope.showLoader = false;
        });

    };
    $scope.templateCostList();

    $scope.formElements = {
            rootDiskControllerList: {
                "0":"SCSI",
                "1":"IDE"
            },
            nicTypeList: {
          	  "0":"E1000",
          	  "1":"PCNET32",
          	  "2":"VMXNET2",
          	  "3":"VMXNET3"
            },
            keyboardTypeList: {
          	  "0":"US_KEYBOARD",
          	  "1":"UK_KEYBOARD",
          	  "2":"JAPANESE_KEYBOARD",
          	  "3":"SIMPLIFIED_CHINESE"
            },
            formatList: {
                         "Hyperv" : {
  			        	  "0":"VHD",
  			        	  "1":"VHDX",
  			           },
  			           "VMware" :
  			           {
  			        	  "0":"OVA",
  			           },
  			           "KVM" :
  			           {
  			        	  "0":"QCOW2",
  			        	  "1":"RAW",
  			        	  "2":"VHD",
  			        	  "3":"VMDK",
  			           },
  			           "XenServer" :
  			           {
  			        	  "0":"VHD",
  			           },
  			           "BareMetal" :
  			           {
  			        	  "0":"BAREMETAL",
  			           },
  			           "LXC" :
  			           {
  			        	  "0":"TAR",
  			           },
  			           "Ovm" :
  			           {
  			        	  "0":"RAW",
  			          }
  		          }
      }

    // Zone list from server
    $scope.zones = {};
    var haszoneList = appService.crudService.listAll("zones/list");
    haszoneList.then(function (result) {
    	$scope.formElements.zoneList = result;
    });

   

     $scope.uploadTemplateContainer = function (size){
           appService.dialogService.openDialog("app/views/templates/upload.jsp", 'lg', $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
     $scope.save = function (form,templates) {

        $scope.formSubmitted = true;
        if (form.$valid) {
            $scope.showLoader = true;
            var template = angular.copy(templates);
            	template.zoneId = template.zone.id;
            template.hypervisorId = template.hypervisor.id;
            template.osCategoryId = template.osCategory.id;
            template.osTypeId = template.osType.id;
	    template.submitCheck = true ;
            delete template.zone;
            delete template.hypervisor;
            delete template.osCategory;
            delete template.osType;
            var hasTemplate = appService.crudService.add("templates", template);
            hasTemplate.then(function (result) {  // this is only run after $http completes
                $scope.showLoader = false;
		 $modalInstance.close();
                appService.notify({message: 'Template created successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                if(template.format == "ISO") {
                        	$scope.isolist(1);
                } else {
                        	$scope.list(1);
                }

            }).catch(function (result) {
                if (!angular.isUndefined(result.data)) {
                	if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                  	    var msg = result.data.globalError[0];
                  	  $scope.showLoader = false;
                  	appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                    } else if (result.data.fieldErrors != null) {
                        angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                            $scope.TemplateForm[key].$invalid = true;
                            $scope.TemplateForm[key].errorMessage = errorMessage;
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


    // Delete the template
    $scope.delete = function (size, template) {
    	appService.dialogService.openDialog("app/views/templates/confirm-delete.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
                $scope.deleteId = template.id;
                $scope.ok = function (deleteId) {
                	$scope.showLoader = true;
                    var hasStorage = appService.crudService.delete("templates", deleteId);
                    hasStorage.then(function (result) {
                        $scope.homerTemplate = 'app/views/notification/notify.jsp';
                        $scope.showLoader = false;
                        $modalInstance.close();
                        appService.notify({message: 'Template deleted successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
                        if(template.format == "ISO") {
                        	$scope.isolist(1);
                        } else {
                        	$scope.list(1);
                        }
                    }).catch(function (result) {
                        if (!angular.isUndefined(result.data)) {
                        	if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                          	    var msg = result.data.globalError[0];
                          	    $scope.showLoader = false;
                          	    appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                            }
                        	$modalInstance.close();
                        }
                    });
                },
                $scope.cancel = function () {
                    $modalInstance.close();
                };
            }]);
    };

	
    if (!angular.isUndefined($stateParams.id) && $stateParams.id != '') {
        $scope.edit($stateParams.id)
    }

 
 $scope.editTemplateContainer = function (size, templateObj){
	$scope.templates = templateObj;
           appService.dialogService.openDialog("app/views/templates/edit-template.jsp", 'lg', $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {

$scope.oscategorys = {};
    $scope.getOsCategoryList = function() {
	    var hasOsCategoryList = appService.crudService.listAll("oscategorys/list");
	    hasOsCategoryList.then(function (result) {
	    	$scope.formElements.osCategoryList = result;
	    	angular.forEach($scope.formElements.osCategoryList, function(obj, key) {
	    		if(obj.id == $scope.templates.osCategory.id) {
	    			$scope.templates.osCategory = obj;
	    		}
	    	});
	    });
    }
$scope.getOsCategoryList();

    // Edit the Template
    $scope.update = function (form, template) {
        $scope.formSubmitted = true;
        if (form.$valid) {
        	$scope.showLoader = true;
            var template = angular.copy($scope.templates);
            template.zoneId = template.zone.id;
            template.hypervisorId = template.hypervisor.id;
            template.osCategoryId = template.osCategory.id;
            template.osTypeId = template.osType.id;
		    template.submitCheck = true ;
            delete template.zone;
            delete template.hypervisor;
            delete template.osCategory;
            delete template.osType;
            var hasTemplates = appService.crudService.update("templates", template);
            hasTemplates.then(function (result) {
                $scope.homerTemplate = 'app/views/notification/notify.jsp';
                $scope.showLoader = false;
		$modalInstance.close();
                appService.notify({message: 'Template updated successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                if(template.format == "ISO") {
                        	$scope.isolist(1);
                } else {
                        	$scope.list(1);
                }
            }).catch(function (result) {
                if (!angular.isUndefined(result.data)) {
                	if (result.data.fieldErrors != null) {
                		$scope.showLoader = false;
                        angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                            $scope.TemplateForm[key].$invalid = true;
                            $scope.TemplateForm[key].errorMessage = errorMessage;
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


    $scope.openDescription = function (index) {
        angular.forEach($scope.template.templateList, function (value, key) {
            if (index == key && !$scope.template.templateList[key].openDescription) {
                $scope.template.templateList[key].openDescription = true;
            } else {
                $scope.template.templateList[key].openDescription = false;
            }
        });
    }

    // INFO PAGE
    $scope.templateInfo = $scope.template.templateList[$stateParams.id - 1];
    $scope.showDescription = function (templateObj) {
        var modalInstance = $modal.open({
            animation: $scope.animationsEnabled,
            templateUrl: 'app/views/templates/properties.jsp',
            controller: 'templateDetailsCtrl',
            size: 'md',
            backdrop: 'static',
            windowClass: "hmodal-info",
            resolve: {
                templateObj: function () {
                    return angular.copy(templateObj);
                }
            }
        });
        modalInstance.result.then(function (selectedItem) {
            $scope.selected = selectedItem;
        });
    };

    $scope.openAddInstance = function (templateObj) {

        appService.localStorageService.set("selectedTemplate", templateObj);
        if(templateObj.format == "ISO") {
            appService.localStorageService.set("view", "iso");
        } else {
        	appService.localStorageService.set("view", "template");
        }
        var modalInstance = $modal.open({
            templateUrl: 'app/views/cloud/instance/add.jsp',
            controller: 'instanceCtrl',
            size: 'lg',
            backdrop: 'static',
            windowClass: "hmodal-info",
            resolve: {
                items: function () {
                    return $scope.items;
                }
            }
        });

        modalInstance.result.then(function (templateObj) {
            $scope.selected = templateObj;
        });

    };
};



function templateDetailsCtrl($scope, templateObj, globalConfig, $modalInstance) {
    $scope.global = globalConfig;
    $scope.templateObj = templateObj;
    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };
}
;

function uploadTemplateCtrl($scope, globalConfig, $modalInstance, notify) {
    $scope.global = globalConfig;
    $scope.formElements = {
        hypervisorList: [
            {
                id: 1,
                name: 'Hyperv',
                formatList: [
                    {id: 1, name: 'VHD'},
                    {id: 2, name: 'VHDX'},
                ]
            },
            {
                id: 2,
                name: 'KVM',
                formatList: [
                    {id: 1, name: 'QCOW2'},
                    {id: 2, name: 'RAW'},
                    {id: 3, name: 'VHD'},
                    {id: 4, name: 'VHDX'},
                ]
            },
            {
                id: 3,
                name: 'XenServer',
                formatList: [
                    {id: 1, name: 'VHD'},
                ]
            },
            {
                id: 4,
                name: 'VMware',
                formatList: [
                    {id: 1, name: 'OVA'},
                ],
                rootDiskControllerList: [
                    {id: 1, name: 'SCSI'},
                    {id: 2, name: 'IDE'},
                ],
                nicTypeList: [
                    {id: 1, name: 'E1000'},
                    {id: 2, name: 'PCNET32'},
                    {id: 3, name: 'VMXNET2'},
                    {id: 4, name: 'VMXNET3'},
                ],
                keyboardTypeList: [
                    {id: 1, name: 'US Keyboard'},
                    {id: 2, name: 'UK Keyboard'},
                    {id: 3, name: 'Japanese Keyboard'},
                    {id: 4, name: 'Simplified Chinese'},
                ],
            },
            {
                id: 5,
                name: 'BareMetal',
                formatList: [
                    {id: 1, name: 'BareMetal'},
                ]
            },
            {
                id: 6,
                name: 'Ovm',
                formatList: [
                    {id: 1, name: 'RAW'},
                ]
            },
            {
                id: 7,
                name: 'LXC',
                formatList: [
                    {id: 1, name: 'TAR'},
                ]
            },
        ],
        osTypeList:[
            {id: 1, name: 'Apple Mac OS X 10.6 (32-bit)'},
            {id: 2, name: 'Apple Mac OS X 10.6 (64-bit)'},
            {id: 3, name: 'CentOS 6.5 (32-bit)'},
            {id: 4, name: 'CentOS 6.5 (64-bit)'},
            {id: 5, name: 'Windows Server 2008 (32-bit)'},
            {id: 6, name: 'Windows Server 2008 (64-bit)'},
        ]
    }
 /**   $scope.save = function (form) {
        $scope.formSubmitted = true;
        if (form.$valid) {
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            notify({message: 'Uploaded successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
            $scope.cancel();
        }
    };
    $scope.ok = function () {
        $modalInstance.close();
    };
    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };**/



}

