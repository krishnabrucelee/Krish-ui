/**
 *
 * instanceCtrl
 *
 */

angular
        .module('homer')
        .controller('instanceCtrl', instanceCtrl)

function instanceCtrl($scope, $modalInstance, $state, $stateParams, filterFilter, appService, $window, sweetAlert) {

    $scope.global = appService.globalConfig;
    $scope.instanceList = [];
    $scope.formElements = [];
    $scope.instanceForm = [];
    $scope.instanceElements = {};
    $scope.instance ={};
    $scope.instance.networks = {};
    $scope.paginationObject = {};

    $scope.template = {
            templateList: {}
        };

    // Form Field Declaration
    $scope.instance = {
        computeOffer: {
            category: 'static',
            memory: {
                value: 512,
                floor: 512,
                ceil: 4096
            },
            cpuCore: {
                value: 1,
                floor: 1,
                ceil: 32

            },
            cpuSpeed: {
                value: 1000,
                floor: 1000,
                ceil: 3500
            },
            isOpen: true
        },
        diskOffer: {
            category: 'static',
            diskSize: {
                value: 0,
                floor: 0,
                ceil: 1024
            },
            iops: {
                value: 0,
                floor: 0,
                ceil: 500
            },
            isOpen: false
        },
        networks: {
            category: 'all',
            isOpen: false
        }
    };

    $scope.instance.bit64 = true;

    var hasDomains = appService.crudService.listAll("domains/list");
	hasDomains.then(function (result) {  // this is only run after $http completes0
	      $scope.formElements.domainList = result;
	});

	 $scope.$watch('instance.domain', function (obj) {
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


    $scope.osList = function () {
        var hasOsList = appService.crudService.listAll("oscategorys/list");
        hasOsList.then(function (result) {  // this is only run after $http completes0
                $scope.formElements.osCategoryList = result;
         });
     };
     $scope.osList();

     //Os list by filter
     $scope.osListByFilter = function () {
         var hasOsListByFilter = appService.crudService.listAll("oscategorys/os");
         hasOsListByFilter.then(function (result) {  // this is only run after $http completes0
                 $scope.formElements.osCategoryListByFilter = result;
          });
      };
      $scope.osListByFilter();

     $scope.templateList = function () {
    	 $scope.showLoader = true;
         var hastemplateList = appService.crudService.listAll("templates/list");
         hastemplateList.then(function (result) {  // this is only run after $http completes0
                $scope.formElements.templateList = result;
                $scope.showLoader = false;
          });
      };
      $scope.templateList();

      // Hypervisors list from server
      $scope.hypervisorList = function () {
    	  var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
    	  var hashypervisorList = appService.crudService.list("hypervisors", $scope.global.paginationHeaders(1, limit), {"limit": limit});
    	  hashypervisorList.then(function (result) {
    		  $scope.formElements.hypervisorList = result;
    	  });
      };
      $scope.hypervisorList();

//      $scope.templateCategory = function(category) {
//    	  var templateList = [];
//    	  $scope.showLoader = true;
//    	  var template = {};
//    	  if (category == "template") {
//
//    	  } else if (category == "iso") {
//
//    	  }
//
//
//    	  hastemplateList.then(function (result) {
//        	  $scope.formElements.templateList= result;
//        	  $scope.showLoader = false;
//          });
//      }

      $scope.getTemplatesByFilters = function() {
    	  var templateList = [];
    	  $scope.showLoader = true;
    	  var template = {};
    	  template.osCategory = $scope.instance.osCategory;
    	  if(!angular.isUndefined(template.osCategory) && template.osCategory != null) {
    		  template.osCategoryId = template.osCategory.id;
          	delete template.osCategory;
          }
//    	  template.osCategory = $scope.instance.osCategory;
    	  template.architecture = $scope.instance.architecture;
    	  template.osVersion = $scope.instance.osVersion;
    	  var hastemplateList = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_POST , appService.globalConfig.APP_URL + "templates/searchtemplate?lang=" + appService.localStorageService.cookie.get('language'), '', template);

    	  hastemplateList.then(function (result) {
        	  $scope.formElements.templateList= result;
        	  $scope.showLoader = false;
          });
      }

      $scope.getIsoByFilters = function() {
    	  var templateList = [];
    	  $scope.showLoader = true;
    	  var template = {};
    	  template.osCategory = $scope.instance.osCategory;
    	  if(!angular.isUndefined(template.osCategory) && template.osCategory != null) {
    		  template.osCategoryId = template.osCategory.id;
          	delete template.osCategory;
          }
//    	  template.osCategory = $scope.instance.osCategory;
    	  template.architecture = $scope.instance.architecture;
    	  template.osVersion = $scope.instance.osVersion;
    	  var hastemplateList = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_POST , appService.globalConfig.APP_URL + "templates/searchiso?lang=" + appService.localStorageService.cookie.get('language'), '', template);

    	  hastemplateList.then(function (result) {
        	  $scope.formElements.templateList= result;
        	  $scope.showLoader = false;
          });
      }

      function containsObject(obj, list) {
    	    var i;
    	    for (i = 0; i < list.length; i++) {
    	        if (list[i] === obj) {
    	            return true;
    	        }
    	    }
    	    return false;
    	}

        $scope.templateListOs = function (osType) {

        };

        $scope.templateListVersion = function (osVersion) {

        };

        $scope.templateListArchitecure = function (architecure) {

        };

        $scope.setTemplate = function (item){
        	 $scope.instance.template = item;
             $scope.instance.templateId = item.id;
            }

        $scope.formElements = {
                departmentList: [
                    {id: 1, name: 'Developing'},
                    {id: 2, name: 'Testing'}
                ],
                architectureList: [
                    {id: 1, name: '32'},
                    {id: 2, name: '64'}
                ]
        };

        $scope.compute = false;
        $scope.disk = false;
        $scope.disks = false;
        $scope.computes = false;
        $scope.networks = false;

        $scope.computeFunction = function (item) {
            if (item === true) {
                $scope.compute = true;
                $scope.disk = false;
                $scope.networks = false;
                $scope.computes = true;
            }
            else {
                $scope.compute = false;
            }
        }
        $scope.computeSlide = function () {
            if (!$scope.compute) {
                $scope.compute = true;
            }
            else {
                $scope.compute = false;
            }
        }
        $scope.diskSlide = function () {
        	  if (!$scope.disk) {
                  $scope.disk = true;
              }
              else {
                  $scope.disk = false;
              }
          }
          $scope.networkSlide = function () {
              if (!$scope.networks) {
                  $scope.networks = true;
              }
              else {
                  $scope.networks = false;
              }
          }

          $scope.diskFunction = function (item) {

              if (item == 'Custom') {
                  $scope.disk = true;
                  $scope.compute = false;
                  $scope.networks = false;
                  $scope.disks = true;
              }
              else {
                  $scope.disk = false;
              }
          }

          $scope.networkFunction = function (item) {
              if (item == '') {
                  $scope.networks = false;
              }
              else {
                  $scope.networks = true;
                  $scope.compute = false;
                  $scope.disk = false;
              }
              $scope.listNetworkOffer();
          }

          $scope.userList = function (department) {
        	  $scope.showLoaderDetail = true;
              var hasUsers = appService.crudService.listAllByFilter("users/departmentusers", department);
              hasUsers.then(function (result) {  // this is only run after $http completes0
                       $scope.formElements.instanceOwnerList = result;
                       $scope.showLoaderDetail = false;
               });
           };

           $scope.zoneList = function () {
               var hasZones = appService.crudService.listAll("zones/list");
               hasZones.then(function (result) {  // this is only run after $http completes0
                       $scope.zoneList= result[0];
                       $scope.instance.zoneId = result[0].id;
                });
            };
            $scope.zoneList();

           $scope.applicationList = function () {
        	   $scope.showLoaderDetail = true;
               var hasApplication = appService.crudService.listAll("applications/list");
               hasApplication.then(function (result) {  // this is only run after $http completes0
                   $scope.formElements.applicationsList = result;
                   $scope.showLoaderDetail = false;
            });
        };
        $scope.applicationList();

        $scope.departmentList = function (domain) {

		    	$scope.showLoaderDetail = true;

   		    if($scope.global.sessionValues.type === 'USER') {
   		    	var departments = [];
   		    	var hasDepartments = appService.crudService.read("departments", $scope.global.sessionValues.departmentId);
   		    	hasDepartments.then(function (result) {
   		    		$scope.instance.department = result;
   		    		if (!angular.isUndefined(result)) {
   		    			$scope.listNetworks(result.id,'department');
   		    		}
	    	    });
   		    	var hasUsers = appService.crudService.read("users", $scope.global.sessionValues.id);
   		    	hasUsers.then(function (result) {
   		    		$scope.instance.instanceOwner = result;
   		    		if (!angular.isUndefined(result)) {
   	    	          $scope.projectList(result);
   		    		}
	    	    });
   		    } else {
            var hasDepartments = appService.crudService.listAllByFilter("departments/search", domain);
            hasDepartments.then(function (result) {  // this is only run after $http completes0
                   $scope.formElements.departmenttypeList = result;
                   $scope.showLoaderDetail = false;
             });
   		    }
         };

         $scope.projectList = function (user) {
        	 $scope.showLoaderDetail = true;
             var hasProjects = appService.crudService.listAllByObject("projects/user", user);
             hasProjects.then(function (result) {  // this is only run after $http completes0
            	 $scope.formElements.projecttypeList = result;
            	 $scope.showLoaderDetail = false;
             });
         };

      $scope.search = {'users': [],'departments':[], 'projects':[]};

      $scope.$watch('instance.department', function (obj) {
    	  if (!angular.isUndefined(obj)) {
    	  $scope.userList(obj);
          $scope.listNetworks(obj.id,'department');
          //$scope.projectList(obj);
    	  }
          });


      $scope.$watch('instance.instanceOwner', function (obj) {
    	  if($scope.global.sessionValues.type !== 'USER') {
    		if (!angular.isUndefined(obj)) {
    	          $scope.projectList(obj);
    		}
    	  }
    	          });

      $scope.$watch('instance.project',function (obj) {
    		if (!angular.isUndefined(obj)) {
    	          $scope.listNetworks(obj.id,'project');
    		}
    	          });


     $scope.sliderTranslate = function (value) {
         return value + " " + this.attributes.rzSliderLabel;
     };

     $scope.instance.networkList= [];
     $scope.validateOffering = function (form) {
         $scope.OfferingSubmitted = true;
         var submitError = false;
         if (form.networkoffer.$valid && form.computeoffer.$valid) {
             var computeOfferValid = true;
             if ($scope.instance.computeOffering.customized == "true") {
                 if ($scope.instance.computeOffer.cpuCore.value != 0 && $scope.instance.computeOffer.memory.value != 0) {
                     $scope.compute = false;
                 }
                 else {
                     submitError = true;
                     $scope.homerTemplate = 'app/views/notification/notify.jsp';
                     appService.notify({message: 'Select the CPU core and RAM', classes: 'alert-danger', "timeOut": "1000", templateUrl: $scope.homerTemplate});
                     $scope.compute = true;
                     computeOfferValid = false;
                 }
             }
             if (form.networkoffer.$valid && !$scope.compute) {
                 if ($scope.instance.networkOfferinglist.value == 'new') {
                     if ($scope.instance.networks.name == null) {
                         submitError = true;
                         $scope.networks = true;
                         $scope.disk = false;
                         $scope.homerTemplate = 'app/views/notification/notify.jsp';
                         appService.notify({message: 'Enter network name  ', classes: 'alert-danger', templateUrl: $scope.homerTemplate});
                     }
                     else {
                         if (angular.isUndefined($scope.instance.networkOffering)) {
                             submitError = true;
                             $scope.networks = true;
                             $scope.disk = false;
                             $scope.homerTemplate = 'app/views/notification/notify.jsp';
                             appService.notify({message: 'Select network offering ', classes: 'alert-danger', templateUrl: $scope.homerTemplate});
                         }
                     }
                 }
                 var networkSelected = false;
                 if ($scope.instance.networkOfferinglist.value == 'vpc' || $scope.instance.networkOfferinglist.value == 'all') {
                     for (var i = 0; i < $scope.instance.networks.networkList.length; i++) {
                         if ($scope.instance.networks[i] == true) {
                    		 var networks = $scope.instance.networks.networkList[i];
                    		 var result = angular.fromJson($scope.instance.networkc);
                        	 if (result.id === networks.id){
                                 $scope.instance.networkUuid = networks.uuid;
                                 networkSelected = true;
                                 submitError = false;
                                 break;
                        	 }
                         }

                     }
                     if (!networkSelected) {
                         submitError = true;
                         $scope.networks = true;
                         $scope.disk = false;
                         $scope.homerTemplate = 'app/views/notification/notify.jsp';
                         appService.notify({message: 'Select network offering ', classes: 'alert-danger', templateUrl: $scope.homerTemplate});
                     }
                 }
             }
                 if (networkSelected && computeOfferValid) {
                     if (!angular.isUndefined($scope.instance.diskOffering)) {
                         if ($scope.instance.diskOffering.name == "Custom") {
                             if ($scope.instance.diskOffer.diskSize.value != 0 && $scope.instance.diskOffer.iops.value != 0) {
                                 $scope.disk = false;
                                 submitError = false;
                             }
                             else {
                                 submitError = true;
                                 $scope.homerTemplate = 'app/views/notification/notify.jsp';
                                 appService.notify({message: 'Select the disk size and IOPS', classes: 'alert-danger', templateUrl: $scope.homerTemplate});
                                 $scope.disk = true;
                                 $scope.networks = false;
                                 submitError = true;
                             }
                         }
                     }
                 }
                 if (!submitError) {
                     $scope.submt();
                 }
             }
     };

     $scope.validateTemplate = function (form) {
         $scope.templateFormSubmitted = true;
         appService.notify.closeAll();
         if ($scope.instance.template == null) {
             $scope.homerTemplate = 'app/views/notification/notify.jsp';
             appService.notify({message: 'Select the template', classes: 'alert-danger', templateUrl: $scope.homerTemplate});
         } else if (form.$valid) {
             $scope.wizard.next();
         }
     };

     $scope.validateComputeOffer = function (form) {
         $scope.computeOfferFormSubmitted = true;
         if (form.$valid) {
             $scope.wizard.next();
         }
     };

     $scope.submt = function () {
    	 $scope.showLoader = true;
    	 $scope.OfferingSubmitted = false;
    	 if($scope.global.sessionValues.type !== 'ROOT_ADMIN') {
          	if(!angular.isUndefined($scope.global.sessionValues.domainId)){
          		 $scope.instance.domainId = $scope.global.sessionValues.domainId;
          	}
          }
    	 var instance = angular.copy($scope.instance);
    	 if (!angular.isUndefined(instance.project)) {
             instance.projectId = instance.project.id;
             delete instance.project;
         }
    	 if (!angular.isUndefined(instance.domain) && instance.domain != null) {
         instance.domainId = instance.domain.id;
         delete instance.domain;
         }
         instance.departmentId = instance.department.id;
         delete instance.department;
         instance.instanceOwnerId = instance.instanceOwner.id;
         delete instance.instanceOwner;

         if (!angular.isUndefined($scope.instance.computeOffer.cpuCore.value)) {
             instance.cpuCore = $scope.instance.computeOffer.cpuCore.value;
         }
         if (!angular.isUndefined($scope.instance.computeOffer.cpuSpeed.value)) {
             instance.cpuSpeed = $scope.instance.computeOffer.cpuSpeed.value;
         }
         if (!angular.isUndefined($scope.instance.computeOffer.memory.value)) {
             instance.memory = $scope.instance.computeOffer.memory.value;
         }
         instance.computeOfferingId = instance.computeOffering.id;
         delete instance.computeOffering;
         if(!angular.isUndefined(instance.storageOffering) && instance.storageOffering !== null){
         instance.storageOfferingId = instance.storageOffering.id;
         delete instance.storageOffering;
         }
         instance.templateId = instance.template.id;
         delete instance.template;
         if (!angular.isUndefined(instance.hypervisor) && instance.hypervisor !== null){
        	 instance.hypervisorId = instance.hypervisor.id;
        	 delete instance.hypervisor;
         }
         instance.zoneId = $scope.global.zone.id;
         var hasServer = appService.crudService.add("virtualmachine", instance);
         hasServer.then(function (result) {  // this is only run after $http completes
        	$scope.showLoader = false;
        	appService.notify({message: result.eventMessage, classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
            $modalInstance.close();
            $state.reload();

            }).catch(function (result) {
            	$scope.showLoader = false;
         if(result.data.globalError[0] != '') {
        	 var msg = result.data.globalError[0];
        	 appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
         } else if(result.data.fieldErrors != null){
              var errorMessages = "";
              angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                        errorMessages += ","+key+": " + "is incorrect ";
                    });
              errorMessages = errorMessages.slice(1, errorMessages.legnth);
                 appService.notify({message: errorMessages, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
             } else {
             }

     	$scope.wizard.prev();
            });
     };

    $scope.addnetwork = function () {

          var cidrRegex = /^([0-9]{1,3}\.){3}[0-9]{1,3}($|\/[0-32]{1,2})$/i;
          var networkError = false;
          if($scope.guestnetwork.name == null){
          $scope.homerTemplate = 'app/views/notification/notify.jsp';
          appService.notify({message: 'Enter Network Name', classes: 'alert-danger', templateUrl: $scope.homerTemplate});
          networkError = true;

      } else if ($scope.guestnetwork.networkOffering == null) {
          $scope.homerTemplate = 'app/views/notification/notify.jsp';
          appService.notify({message: 'Select the Network Offering Type', classes: 'alert-danger', templateUrl: $scope.homerTemplate});
          networkError = true;
      }
      else {
          $scope.saveNetwork(networkError);
 }
     };

     $scope.someSelected = function (object) {
         return Object.keys(object).some(function (key) {
             return object[key];
         });
     }

     $scope.selectedAppClass = {};
     $scope.appClass = [{'name': 'Prod.', 'id': 1}, {'name': 'QAS', 'id': 2}, {'name': 'DEV', 'id': 3}, {'name': 'Backup', 'id': 4}, {'name': 'DR', 'id': 5}, {'name': 'Other', 'id': 6}];

     $scope.cancel = function () {
         $modalInstance.dismiss('cancel');
     };

     $scope.save = function () {
         var instance = $scope.instance;

          var hasServer = appService.crudService.add("virtualmachine", instance);
         hasServer.then(function (result) {  // this is only run after $http completes
             appService.notify({message: 'instance created successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
             $modalInstance.close();
         }).catch(function (result) {
        	 if (!angular.isUndefined(result.data)) {
              	if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                	    var msg = result.data.globalError[0];
              	    appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                  } else if (result.data.fieldErrors != null) {
                 	 angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                          $scope.instanceForm[key].$invalid = true;
                          $scope.instanceForm[key].errorMessage = errorMessage;
                      });
              	}
              }
         });
     };

     $scope.addNetworkToVM = function () {
         dialogService.openDialog("app/views/cloud/instance/add-network.jsp", 'md', $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
         	$scope.listNetwork = function () {
         		$scope.showLoaderDetail = true;
                    var hasGuestNetworks = appService.crudService.findByDepartment("guestnetwork/list");
                    hasGuestNetworks.then(function (result) {  // this is only run after $http
                            $scope.networkList = result;
                            $scope.showLoaderDetail = false;
                    });

                };
            	listNetwork();
         	$scope.add = function (deleteObject) {
         		   if (form.$valid) {
         	             $scope.instanceNetworkList = appService.localStorageService.get("instanceNetworkList");

         	             $scope.instanceNetwork = {
         	             };
         	             // appService.localStorageService.remove('instanceNetworkList');

         	             $scope.networks.plan = $scope.networks.networkOffers.name;

         	             $scope.instanceNetwork = filterFilter($scope.networkList.networkOffers, {'name': $scope.networks.plan});
         	             if (filterFilter($scope.instanceNetworkList, {'name': $scope.networks.plan})[0] == null) {
         	                 $scope.instanceNetworkList.push($scope.instanceNetwork[0]);
         	                 appService.localStorageService.set("instanceNetworkList", $scope.instanceNetworkList);
         	                 $scope.homerTemplate = 'app/views/notification/notify.jsp';
         	                 appService.notify({message: 'Added successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
         	                 $scope.cancel();
         	             }
         	             else {
         	                 $scope.homerTemplate = 'app/views/notification/notify.jsp';
         	                 appService.notify({message: 'Network already exist', classes: 'alert-danger', templateUrl: $scope.homerTemplate});
         	             }
         	             $scope.networkLists = appService.localStorageService.get("instanceNetworkList");
         	             appService.localStorageService.set('instanceViewTab', 'network');
         	             $state.reload();

         	         }
                 },
                 $scope.cancel = function () {
                     $modalInstance.close();
                 };
             }]);
     };

     /*$scope.addNetworkVM = function (form) {
         $scope.formSubmitted = true;
         if (form.$valid) {
             $scope.instanceNetworkList = appService.localStorageService.get("instanceNetworkList");

             $scope.instanceNetwork = {
             };
             // appService.localStorageService.remove('instanceNetworkList');

             $scope.networks.plan = $scope.networks.networkOffers.name;

             $scope.instanceNetwork = filterFilter($scope.networkList.networkOffers, {'name': $scope.networks.plan});
             if (filterFilter($scope.instanceNetworkList, {'name': $scope.networks.plan})[0] == null) {
                 $scope.instanceNetworkList.push($scope.instanceNetwork[0]);
                 appService.localStorageService.set("instanceNetworkList", $scope.instanceNetworkList);
                 $scope.homerTemplate = 'app/views/notification/notify.jsp';
                 appService.notify({message: 'Added successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
                 $scope.cancel();
             }
             else {
                 $scope.homerTemplate = 'app/views/notification/notify.jsp';
                 appService.notify({message: 'Network already exist', classes: 'alert-danger', templateUrl: $scope.homerTemplate});
             }
             $scope.networkLists = appService.localStorageService.get("instanceNetworkList");
             appService.localStorageService.set('instanceViewTab', 'network');
             $state.reload();

         }
     };
*/
     $scope.networkList = {
         networkOffers: [
             {
                 "id": 1,
                 "name": "Advanced Network",
                 "networkID": "f6dfee50-690c-4210-b77c-c9bf3179b159",
                 "networkType": {
                     "id": 2,
                     "name": "Isolated"
                 },
                 "ip": "10.1.10.92",
                 "gateway": "10.1.1.1",
                 "netmask": "255.255.255.0",
                 "isDefault": "No"
             },
             {
                 "id": 2,
                 "name": "Custom Network",
                 "networkID": "f6dfee50-690c-4210-b77c-c9bf31734e59",
                 "networkType": {
                     "id": 1,
                     "name": "Shared Network"
                 },
                 "ip": "10.2.2.92",
                 "gateway": "10.2.2.1",
                 "netmask": "255.255.255.0",
                 "isDefault": "NO"
             }
             ]

         };

         $scope.computeList = function () {
        	 $scope.showLoaderOffer = true;
             var hasCompute = appService.crudService.listAll("computes/list");
             hasCompute.then(function (result) {  // this is only run after $http completes0
                     $scope.instanceElements.computeOfferingList = result;
                     $scope.showLoaderOffer = false;
              });
          };
          $scope.computeList();

          $scope.diskList = function () {
         	 $scope.showLoaderOffer = true;
              var hasDisks = appService.crudService.listAll("storages/list");
              hasDisks.then(function (result) {  // this is only run after $http completes0
                     $scope.instanceElements.diskOfferingList = result;
                	 $scope.showLoaderOffer = false;
               });
           };
           $scope.diskList();

         $scope.instanceElements = {
             zoneList: [{id: 1, name: 'Beijing'}, {id: 2, name: 'Liaoning'}, {id: 3, name: 'Shanghai'}, {id: 4, name: 'Henan'}],
             templateList: [
                 {id: 1, name: 'Windows 2012R ISO', price: 0.10},
                 {id: 2, name: 'Server 2012RSTD 64bit', price: 0.15},
                 {id: 3, name: "Centos 5.3 (64 bit)", price: 0.20}
             ],
             networkList: [
                 {id: 1, name: 'Shared', price: 0.30},
                 {id: 2, name: 'Isolated', price: 0.40}
             ],
             networkOfferingList: [
                 {id: 1, name: 'All', value: 'all', price: 0.10},
                 {id: 2, name: 'VPC', value: 'vpc', price: 0.20},
                 {id: 3, name: 'Add New Network', value: 'new', price: 0.0}
             ]
         };

         // Wizard Steps
         $scope.step = 1;
         $scope.wizard = {
             show: function (number) {
                 $scope.step = number;
             },
             next: function () {
                 $scope.step++;
             },
             prev: function () {
            	 $scope.step--;
             }
         };
         $scope.instance.networks={};
         $scope.instance.networkc={};
        $scope.getOsListByImage = function (templateImage) {
             $scope.instance.templateOs = {};
             $scope.instance.templateImage = templateImage;
         }

         $scope.getVersionListByOs = function (templateOs) {
             $scope.instance.templateVersion = null;
             $scope.instance.templateOs = templateOs;
             $scope.oslist = 0;
         }

         $scope.getComputeOfferByType = function (type) {
             $scope.instance.computeOffer.category = type;
         }

         $scope.getDiskOfferByType = function (type) {
             $scope.instance.diskOffer.category = type;
         }


         $scope.getNetworkByType = function (type) {
             $scope.instance.networks.category = type;
         }

         $scope.networkList = {};
         $scope.paginationObject = {};
      $scope.networkForm = {};
      $scope.instance.networks={};
         $scope.global = appService.crudService.globalConfig;
         $scope.test = "test";
         // Guest Network List
         $scope.listNetworks = function (department,type) {
        	 $scope.showLoaderOffer = true;
        	 var hasGuestNetworks = {};
        	 if(type === 'department'){
        		 hasGuestNetworks = appService.crudService.listAllByFilters("guestnetwork/list", department);
         	 } else {
         		hasGuestNetworks = appService.crudService.listAllByID("guestnetwork/listall?projectId="+department);
         	 }
             hasGuestNetworks.then(function (result) {  // this is only run after $http
                     $scope.instance.networks.networkList = result;
                	 $scope.showLoaderOffer = false;
             });

         };

       $scope.networkOfferList = {};
       $scope.networkOfferForm = {};
       $scope.global = appService.crudService.globalConfig;
     //  Network Offer List

       $scope.listNetworkOffer = function () {
    	   var hasNetworks =  appService.promiseAjax.httpTokenRequest( appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "networkoffer/isolated" +"?lang=" + appService.localStorageService.cookie.get('language')+"&sortBy=-id");
         hasNetworks.then(function (result) {
                 $scope.instance.networks.networkOfferList = result;
         });
     };

         // create Guest Network
         $scope.guestnetwork = {};

         $scope.saveNetwork = function (networkError) {
             if (!networkError) {
            	 $scope.showLoaderOffer = true;
        	 $scope.guestnetwork.zone = $scope.global.zone;
        	 $scope.guestnetwork.displayText =  $scope.guestnetwork.name;
        	 $scope.guestnetwork.departmentId= $scope.instance.department.id;
    	 		$scope.guestnetwork.department= $scope.instance.department;
            	 $scope.guestnetwork.domain = $scope.instance.department.domain;
            	 $scope.guestnetwork.domainId = $scope.instance.department.domainId;
            	 $scope.guestnetwork.project = $scope.instance.project;


            	 var guestnetwork = angular.copy($scope.guestnetwork);
 if (!angular.isUndefined($scope.guestnetwork.domain)) {
                            guestnetwork.domainId = $scope.guestnetwork.domain.id;
			 delete guestnetwork.domain;
			}
			 if (!angular.isUndefined($scope.guestnetwork.department)) {
			guestnetwork.departmentId = $scope.guestnetwork.department.id;
			delete guestnetwork.department;
			}

			 if (!angular.isUndefined($scope.guestnetwork.project)) {
			guestnetwork.projectId = $scope.guestnetwork.project.id;
			delete guestnetwork.project;
			}

                        guestnetwork.zoneId = $scope.guestnetwork.zone.id;
                        guestnetwork.networkOfferingId = $scope.guestnetwork.networkOffering.id;

                        delete guestnetwork.zone;
                        delete guestnetwork.networkOffering;

                 var hasguestNetworks = appService.crudService.add("guestnetwork", guestnetwork);
                 hasguestNetworks.then(function (result) {
                	if($scope.instance.project == null) {
                	     $scope.listNetworks($scope.instance.department.id, 'department');
                 	} else {
                 		$scope.listNetworks($scope.instance.project.id, 'project');
                 	}

                   appService.notify({message: 'Added successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                   $scope.instance.networkOfferinglist = $scope.instanceElements.networkOfferingList[0];
                   networkError = false;
                   $scope.showLoaderOffer = false;
                 }).catch(function (result) {
                	 $scope.showLoaderOffer = false;
                	 if(!angular.isUndefined(result) && result.data != null) {
	      		 		   if(result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])){
	                      	 var msg = result.data.globalError[0];
	                      	 appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
	                       }
		      		 		angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
	                            $scope.computeForm[key].$invalid = true;
	                            $scope.computeForm[key].errorMessage = errorMessage;
	                        });
         			  }

                 });
             }
         }
}
