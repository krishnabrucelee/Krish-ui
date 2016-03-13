/**
 *
 * configurationCtrl
 *
 */

angular
    .module('homer')
    .controller('configurationCtrl', configurationCtrl)

function configurationCtrl($scope, $stateParams, appService, localStorageService, promiseAjax, $modal, $window, globalConfig, crudService, notify, $state) {
    $scope.formSubmitted = false;
    $scope.instanceList = [];
    $scope.formElements={};
    $scope.global = crudService.globalConfig;
    $scope.instanceForm = [];
    $scope.instanceElements = {};
    $scope.instance = {};
    $scope.instances = [];
    $scope.instances.computeOffering ={};
    $scope.resetForm = [];

    // Form Field Decleration
    $scope.computeOffer = {
//        type: {id:1, name:"Basic"}
    };


	var instanceId = $stateParams.id;
	$scope.viewInstance = function(instanceId) {
            var hasServers = crudService.read("virtualmachine", instanceId);
            hasServers.then(function (result) {
                $scope.instances = result;
                $scope.computeList();
                $scope.resetSSHKey();
            });
        };
        $scope.viewInstance(instanceId);



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
                value: 500,
                floor: 500,
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
        network: {
            category: 'all',
            isOpen: false
        }
    };

	 // Volume List
	$scope.volume = {};
	$scope.volume = [];
	$scope.list = function () {
       	var instanceId = $stateParams.id;
       	var hasVolume = promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "volumes/listbyinstancesandvolumetype?instanceid="+instanceId +"&lang=" + 	localStorageService.cookie.get('language')+"&sortBy=-id");
	        hasVolume.then(function (result) {
	            $scope.volume = result;
	        });
	    };
	    $scope.list();

	    $scope.computeList = function () {
             var hasCompute = crudService.listAll("computes/list");
             hasCompute.then(function (result) {  // this is only run after $http completes0
                     $scope.instanceElements.computeOfferingList = result;
                     angular.forEach(result, function(item){
                    	 if (!angular.isUndefined($scope.instances.computeOffering)) {
                    		 if(item.name === $scope.instances.computeOffering.name){
                    			 var index = $scope.instanceElements.computeOfferingList.indexOf(item);
					 $scope.instance.computeOffering = result[index];
                    		 }
                    	 }
                    	 	});
              	});
          	};

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

          		$scope.save = function (form, instance) {
          		$scope.formSubmitted = true;
          		if (form.$valid) {
          			$scope.showLoader= true;
          			$scope.instances.computeOfferingId = $scope.instance.computeOffering.id;
          			$scope.instances.computeOffering = $scope.instance.computeOffering;
          			var hasServer =crudService.updates("virtualmachine/resize", $scope.instances);
          			hasServer.then(function (result) {
			   	appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.vmEvents.vmresize,result.uuid,$scope.global.sessionValues.id);
          				$scope.showLoader= false;
          			}).catch(function (result) {
                        if (!angular.isUndefined(result) && result.data != null) {
	                        if (result.data.fieldErrors != '') {
	                            angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
	                            $scope.instanceForm[key].$invalid = true;
	              				$scope.showLoader= false;
	                            $scope.instanceForm[key].errorMessage = errorMessage;
	                            });
	                            }
              				$scope.showLoader= false;
                        }
                        });
          			}
          		},

          		$scope.config = function (){
                               $window.location.href = '#/cloud/instance/configuration.jsp';
          		}



    $scope.affinity = {
//        type: {id:1, name:"Basic"}
    };

    $scope.affinityElements = {
        groupList: [
            {id: 1, name: 'VM1', price: 0.5},
            {id: 2, name: 'Data1', price: 0.10},
            {id: 3, name: 'Network1', price: 0.15},
        ],
    };

    $scope.affinity.group = $scope.affinityElements.groupList[0];

    $scope.saveAffinity = function(form) {
        $scope.affinitySubmitted = true;
        if (form.$valid) {
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            notify({message: 'Updated successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
        }
    };


    $scope.addAffinityGroup = function (size) {

        var modalInstance = $modal.open({
            templateUrl: 'app/views/cloud/instance/affinity.jsp',
            controller: 'affinityCtrl',
              size: size,
            backdrop : 'static',
             windowClass: "hmodal-info",
            resolve: {
                items: function () {
                    return $scope.items;
                }
            }
        });

        modalInstance.result.then(function (selectedItem) {
            $scope.selected = selectedItem;
        }, function () {
        });

    };
  $scope.resetSSHKey = function() {
    $scope.formElements.sshKeyList = [];
     if (!angular.isUndefined($scope.instances.project) && $scope.instances.project != null) {
	        var hasSSHKeyList = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL
        		+ "sshkeys/search/project?project="+$scope.instances.project.id);
	        hasSSHKeyList.then(function (result) {
                    angular.forEach(result, function(object,value) {
        		if(object.id !== $scope.instances.keypairId) {
        			$scope.formElements.sshKeyList.push(object);
        		}
		    });
	        });
        } else if (!angular.isUndefined($scope.instances.department) && $scope.instances.department != null) {
	        var hasSSHKeyList = appService.crudService.listAllByFilter("sshkeys/search/department", $scope.instances.department);
	        hasSSHKeyList.then(function (result) {
	    	    angular.forEach(result, function(object,value) {
        		if(object.id !== $scope.instances.keypairId) {
        			$scope.formElements.sshKeyList.push(object);
        		}
		    });
	        });
        }
  }


    $scope.resetKey = function (form, resetSSH) {
   		$scope.formSubmitted = true;
   		if (form.$valid) {
   			$scope.showLoader= true;
                        $scope.instances.keypairId = $scope.resetSSH.keypairName.id;
   			var hasServer = appService.crudService.updates("virtualmachine/reset", $scope.instances);
   			hasServer.then(function (result) {
                         $scope.showLoader = false;
                         appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.vmEvents.vmSSHKEY,result.uuid,$scope.global.sessionValues.id);
                        }).catch(function (result) {
                 if (!angular.isUndefined(result) && result.data != null) {
                     if (result.data.fieldErrors != '') {
                         angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                         $scope.resetForm[key].$invalid = true;
                         $scope.resetForm[key].errorMessage = errorMessage;
                         });
                         }
                       $scope.showLoader= false;
                 }
                 });
   			}
   		};
      $scope.resetPassword= function(vm) {
          var event = "VM.RESETPASSWORD";
	  $scope.vm = vm;
	  $scope.vm.event = event;
	  $scope.vm.password = "reset";
	  $scope.formSubmitted = true;
          var hasVm = appService.crudService.updates("virtualmachine/handleevent/vm", $scope.vm);
	  hasVm.then(function(result) {
	  appService.notify({message: "VM password updated successfully. Please refresh and click show password", classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
	  }).catch(function (result) {
     });
     };
     $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.vmresize, function() {
         $scope.viewInstance($scope.instances.id);
         notify({message: 'Updated successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
     });
     $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.vmSSHKEY, function() {
         $scope.viewInstance($scope.instances.id);
         appService.notify({message: 'Keypair added successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
         if ($scope.instances.passwordEnabled == true) {
         $scope.resetPassword($scope.instances);
         }
       });
}
