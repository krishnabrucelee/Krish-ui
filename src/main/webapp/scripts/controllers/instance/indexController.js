/**
 *
 * instanceCtrl
 *
 */

angular
        .module('homer')
        .controller('instanceCtrl', instanceCtrl)

function instanceCtrl($scope, Search, $modalInstance, $state, $stateParams, filterFilter, promiseAjax, globalConfig, localStorageService, $window, sweetAlert, notify, crudService) {

    $scope.global = globalConfig;
    $scope.instanceList = [];
    $scope.formElements=[];
    $scope.global = crudService.globalConfig;
    $scope.instanceForm = [];
    $scope.instanceElements = {};
    $scope.instance ={};
    $scope.instance.networks = {};

    $scope.template = {
            templateList: {}
        };

    // Form Field Decleration
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

    $scope.osList = function () {
        var hasOsList = crudService.listAll("oscategorys/list");
        hasOsList.then(function (result) {  // this is only run after $http completes0
                $scope.formElements.osCategoryList = result;
         });
     };
     $scope.osList();


     $scope.templateList = function () {
         var hastemplateList = crudService.listAll("templates/list");
         hastemplateList.then(function (result) {  // this is only run after $http completes0
                $scope.formElements.templateList = result;
          });
      };
      $scope.templateList();


      $scope.getTemplatesByFilters = function() {
    	  var templateList = [];
    	  var template = {};
    	  template.osCategory = $scope.instance.osCategory;
    	  template.architecture = $scope.instance.architecture;
    	  template.osVersion = $scope.instance.osVersion;
    	  console.log(template);

    	  var hastemplateList = promiseAjax.httpTokenRequest(globalConfig.HTTP_POST , globalConfig.APP_URL + "templates/search?lang=" + localStorageService.cookie.get('language'), '', template);
          hastemplateList.then(function (result) {
        	  $scope.formElements.templateList= result;
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
console.log(item);
        	 $scope.instance.template = item;
             $scope.instance.templateId = item.id;
            }

        $scope.formElements = {
                departmentList: [
                    {id: 1, name: 'Developing'},
                    {id: 2, name: 'Testing'}
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
              console.log(item);
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
              $scope.listNetworkOffer(1);

              console.log(item);
          }

          $scope.userList = function (department) {
              var hasUsers = crudService.listAllByFilter("users/search", department);
              hasUsers.then(function (result) {  // this is only run after $http completes0
                       $scope.formElements.instanceOwnerList = result;
               });
           };

           $scope.zoneList = function () {
               var hasZones = crudService.listAll("zones/list");
               hasZones.then(function (result) {  // this is only run after $http completes0
                       $scope.instance.zone = result[0];
                       $scope.instance.zoneId = result[0].id;
                });
            };
            $scope.zoneList();

           $scope.applicationList = function () {
               var hasApplication = crudService.listAll("applications/list");
               hasApplication.then(function (result) {  // this is only run after $http completes0
                   $scope.formElements.applicationsList = result;
            });
        };
        $scope.applicationList();

        $scope.departmentList = function () {
            var hasDepartments = crudService.listAll("departments/list");
            hasDepartments.then(function (result) {  // this is only run after $http completes0
                   $scope.formElements.departmenttypeList = result;

             });
         };
         $scope.departmentList();

         $scope.projectList = function () {
             var hasProjects = crudService.listAll("projects/list");
             hasProjects.then(function (result) {  // this is only run after $http completes0
            	 $scope.formElements.projecttypeList = result;
             });
         };
         $scope.projectList();

      $scope.search = {'users': [],'departments':[], 'projects':[]};
      $scope.$watch('instance.user', function (val) {
      var payload = {'q': val};
      if(val != '' && val != undefined && val.length > 2){
      Search.get(payload, "users/search", function(data){
      $scope.search.users = data;
      });
      }else{
      $scope.search.users = [];
      }
      });

      $scope.$watch('instance.department', function (obj) {
	if (!angular.isUndefined(obj)) {
    	  $scope.userList(obj);
          $scope.listNetwork(obj.id);
	}
          });

      $scope.$watch('instance.projct', function (val) {
          var payload = {'q': val};
          if(val != '' && val != undefined && val.length > 2){
          Search.get(payload, "projects/search", function(data){
        	  $scope.search.projects = data;
          });
          }else{
          $scope.search.projects = [];
          }
          });

      $scope.$watch('instance.dept', function (val) {
          var payload = {'q': val};
          if(val != '' && val != undefined && val.length > 2){
          Search.get(payload, "departments/search", function(data){
          $scope.search.departments = data;
          });
          }else{
          $scope.search.departments = [];
          }
          });

      $scope.setProject = function(item){
          $scope.search.projects = [];
          $scope.instance.projct = item.name;
          $scope.instance.project = item;
          $scope.instance.projectId = item.id;
      };

      $scope.setUser = function(item){
          $scope.search.users = [];
          $scope.instance.user = item.userName;
          $scope.instance.instanceOwner = item;
          $scope.instance.instanceOwnerId = item.id;
      };

      $scope.setDepartment = function(item){
          $scope.search.departments = [];
          $scope.instance.dept = item.name;
          $scope.instance.department = item;
          $scope.instance.departmentId = item.id;
          $scope.instance.domain = $scope.instance.department.domain;
          $scope.instance.domainId = $scope.instance.domain.id;

      };

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
                     notify({message: 'Select the CPU core and RAM', classes: 'alert-danger', "timeOut": "1000", templateUrl: $scope.homerTemplate});
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
                         notify({message: 'Enter network name  ', classes: 'alert-danger', templateUrl: $scope.homerTemplate});
                     }
                     else {
                         if (angular.isUndefined($scope.instance.networkOffering)) {
                             submitError = true;
                             $scope.networks = true;
                             $scope.disk = false;
                             $scope.homerTemplate = 'app/views/notification/notify.jsp';
                             notify({message: 'Select network offering ', classes: 'alert-danger', templateUrl: $scope.homerTemplate});

                         }
                     }
                 }
                 var networkSelected = false;
                 if ($scope.instance.networkOfferinglist.value == 'vpc' || $scope.instance.networkOfferinglist.value == 'all') {
                     for (var i = 0; i < $scope.instance.networks.networkList.length; i++) {
                         var networks = $scope.instance.networks.networkList[i];
                         $scope.instance.networkUuid = networks.uuid;
                         console.log(networks);
                         console.log($scope.instance.nerworkList);
                         if ($scope.instance.networks[i] == true) {
                             networkSelected = true;
                             submitError = false;
                             break;
                         }
                     }

                     if (!networkSelected) {
                         submitError = true;
                         $scope.networks = true;
                         $scope.disk = false;
                         $scope.homerTemplate = 'app/views/notification/notify.jsp';
                         notify({message: 'Select network offering ', classes: 'alert-danger', templateUrl: $scope.homerTemplate});
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
                                 notify({message: 'Select the disk size and IOPS', classes: 'alert-danger', templateUrl: $scope.homerTemplate});
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
         notify.closeAll();
         if ($scope.instance.template == null) {
             $scope.homerTemplate = 'app/views/notification/notify.jsp';
             notify({message: 'Select the template', classes: 'alert-danger', templateUrl: $scope.homerTemplate});

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
    	 var instance = $scope.instance;
    	 if (!angular.isUndefined(instance.project)) {
             instance.projectId = instance.project.id;
         }
    	 if (!angular.isUndefined(instance.department.domain) && instance.department.domain != null) {
         instance.domain = instance.department.domain;
         instance.domainId =instance.domain.id;
         }else{
        	 instance.domainId = 1;
         }
         instance.departmentId = instance.department.id;
         instance.instanceOwnerId = instance.instanceOwner.id;

         if (!angular.isUndefined($scope.instance.computeOffer.cpuCore.value)) {
             instance.cpuCore = $scope.instance.computeOffer.cpuCore.value;
         }
         if (!angular.isUndefined($scope.instance.computeOffer.cpuSpeed.value)) {
             instance.cpuSpeed = $scope.instance.computeOffer.cpuSpeed.value;
         }
         if (!angular.isUndefined($scope.instance.computeOffer.memory.value)) {
             instance.memory = $scope.instance.computeOffer.memory.value;
         }
         console.log("hi");
         console.log("=====");
         console.log(instance);
         var hasServer = crudService.add("virtualmachine", instance);
         hasServer.then(function (result) {  // this is only run after $http completes

            notify({message: result.eventMessage, classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });

                    console.log(result);
                 $modalInstance.close();
                $state.reload();
            }).catch(function (result) {
            	console.log(result.data.globalError[0]);
         if(result.data.globalError[0] != ''){
        	 var msg = result.data.globalError[0];
        	 notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
        	 wizard.show(1);
             } else if(result.data.fieldErrors != null){
              var errorMessages = "";
              angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                        errorMessages += ","+key+": " + "is incorrect ";
                    });
              errorMessages = errorMessages.slice(1, errorMessages.legnth);
                 notify({message: errorMessages, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
             }


            });
     };

     $scope.instanceId = function (id) {
         var hasUsers = crudService.listAll("virtualmachine/list");
          hasUsers.then(function (result) {  // this is only run after $http completes0
                 console.log(result);
          });
      };

      $scope.instanceId(1);


     $scope.addnetwork = function () {

          var cidrRegex = /^([0-9]{1,3}\.){3}[0-9]{1,3}($|\/[0-32]{1,2})$/i;
          var networkError = false;
          if($scope.guestnetwork.name == null){
          $scope.homerTemplate = 'app/views/notification/notify.jsp';
          notify({message: 'Enter Network Name', classes: 'alert-danger', templateUrl: $scope.homerTemplate});
          networkError = true;

      } else if ($scope.guestnetwork.networkOffering == null) {
          $scope.homerTemplate = 'app/views/notification/notify.jsp';
          notify({message: 'Select the Network Offering Type', classes: 'alert-danger', templateUrl: $scope.homerTemplate});
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

          var hasServer = crudService.add("virtualmachine", instance);
         hasServer.then(function (result) {  // this is only run after $http completes
             notify({message: 'instance created successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
             $modalInstance.close();
         }).catch(function (result) {
             angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                 $scope.instanceForm[key].$invalid = true;
                 $scope.instanceForm[key].errorMessage = errorMessage;
             });

         });
     };



     $scope.addNetworkToVM = function () {
         dialogService.openDialog("app/views/cloud/instance/add-network.jsp", 'md', $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
         	$scope.listNetwork = function () {
                    var hasGuestNetworks = crudService.findByDepartment("guestnetwork/list");
                    hasGuestNetworks.then(function (result) {  // this is only run after $http
                            $scope.networkList = result;
                    });

                };
            	listNetwork();
         	$scope.add = function (deleteObject) {
         		   if (form.$valid) {
         	             $scope.instanceNetworkList = localStorageService.get("instanceNetworkList");

         	             $scope.instanceNetwork = {
         	             };
         	             // localStorageService.remove('instanceNetworkList');

         	             $scope.networks.plan = $scope.networks.networkOffers.name;

         	             $scope.instanceNetwork = filterFilter($scope.networkList.networkOffers, {'name': $scope.networks.plan});
         	             if (filterFilter($scope.instanceNetworkList, {'name': $scope.networks.plan})[0] == null) {
         	                 $scope.instanceNetworkList.push($scope.instanceNetwork[0]);
         	                 localStorageService.set("instanceNetworkList", $scope.instanceNetworkList);
         	                 $scope.homerTemplate = 'app/views/notification/notify.jsp';
         	                 notify({message: 'Added successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
         	                 $scope.cancel();
         	             }
         	             else {
         	                 $scope.homerTemplate = 'app/views/notification/notify.jsp';
         	                 notify({message: 'Network already exist', classes: 'alert-danger', templateUrl: $scope.homerTemplate});
         	             }
         	             $scope.networkLists = localStorageService.get("instanceNetworkList");
         	             localStorageService.set('instanceViewTab', 'network');
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
             $scope.instanceNetworkList = localStorageService.get("instanceNetworkList");

             $scope.instanceNetwork = {
             };
             // localStorageService.remove('instanceNetworkList');

             $scope.networks.plan = $scope.networks.networkOffers.name;

             $scope.instanceNetwork = filterFilter($scope.networkList.networkOffers, {'name': $scope.networks.plan});
             if (filterFilter($scope.instanceNetworkList, {'name': $scope.networks.plan})[0] == null) {
                 $scope.instanceNetworkList.push($scope.instanceNetwork[0]);
                 localStorageService.set("instanceNetworkList", $scope.instanceNetworkList);
                 $scope.homerTemplate = 'app/views/notification/notify.jsp';
                 notify({message: 'Added successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
                 $scope.cancel();
             }
             else {
                 $scope.homerTemplate = 'app/views/notification/notify.jsp';
                 notify({message: 'Network already exist', classes: 'alert-danger', templateUrl: $scope.homerTemplate});
             }
             $scope.networkLists = localStorageService.get("instanceNetworkList");
             localStorageService.set('instanceViewTab', 'network');
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
             var hasCompute = crudService.listAll("computes/list");
             hasCompute.then(function (result) {  // this is only run after $http completes0
                     $scope.instanceElements.computeOfferingList = result;
              });
          };
          $scope.computeList();

          $scope.diskList = function () {
              var hasDisks = crudService.listAll("storages/list");
              hasDisks.then(function (result) {  // this is only run after $http completes0
                     $scope.instanceElements.diskOfferingList = result;
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
         $scope.global = crudService.globalConfig;
         $scope.test = "test";
         // Guest Network List
         $scope.listNetwork = function (department) {
             var hasGuestNetworks = crudService.listAllByFilters("guestnetwork/list", department);
             hasGuestNetworks.then(function (result) {  // this is only run after $http
                     $scope.instance.networks.networkList = result;
             });

         };


         $scope.networkOfferList = {};
         $scope.paginationObject = {};
         $scope.networkOfferForm = {};
         $scope.global = crudService.globalConfig;
         $scope.test = "test";
         //  Network Offer List
         $scope.listNetworkOffer = function (pageNumber) {
             var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
             var hasNetworks = crudService.list("networkoffer", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
             hasNetworks.then(function (result) {  // this is only run after $http
                                                                                                     // completes0

                     $scope.instance.networks.networkOfferList = result;

                 // For pagination
                 $scope.paginationObject.limit = limit;
                 $scope.paginationObject.currentPage = pageNumber;
                 $scope.paginationObject.totalItems = result.totalItems;
             });
         };

         // create Guest Network
         $scope.guestnetwork = {};

         $scope.saveNetwork = function (networkError) {

             if (!networkError) {

            	 $scope.guestnetwork.zone = $scope.global.zone;
            	 var guestnetwork = $scope.guestnetwork;
            	 $scope.guestnetwork.departmentId= $scope.instance.department.id;
		 $scope.guestnetwork.department= $scope.instance.department;
            	 $scope.guestnetwork.domainId = $scope.instance.department.domainId;

                 console.log($scope.guestnetwork);
                 var hasguestNetworks = crudService.add("guestnetwork", guestnetwork);
                 hasguestNetworks.then(function (result) {
                     $scope.listNetwork($scope.instance.department.id);
                     notify({message: 'Added successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                     $scope.instance.networkOfferinglist = $scope.instanceElements.networkOfferingList[0];
                   $scope.guestnetwork.name = "";
                   $scope.guestnetwork.networkoffering = "";
                   networkError = false;
                 }).catch(function (result) {
                     if (!angular.isUndefined(result.data)) {
                         angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                             $scope.computeForm[key].$invalid = true;
                             $scope.computeForm[key].errorMessage = errorMessage;
                         });
                     }
                 });
             }
         }

}
