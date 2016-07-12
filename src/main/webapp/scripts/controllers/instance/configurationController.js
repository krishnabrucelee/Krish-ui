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
    $scope.affinitySubmitted = false;
    $scope.instanceList = [];
    $scope.formElements={};
    $scope.global = crudService.globalConfig;
    $scope.instanceForm = [];
    $scope.instanceElements = {};
    $scope.instance = {};
    $scope.instances = [];
    $scope.instances.computeOffering ={};
    $scope.resetForm = [];
    $scope.affinityForm = [];
    $scope.global.webSocketLoaders.vmsshKey = false;
    $scope.global.webSocketLoaders.computeOffer = false;
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
                $scope.affinityGrouplist();
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
       	var hasVolume = promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "volumes/listbyinstancesandvolumetype?instanceid="+instanceId +"&lang=" + localStorageService.cookie.get('language')+"&sortBy=-id");
       	hasVolume.then(function (result) {
	            $scope.volume = result;
	        });
       	var hasDatavolume = promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "volumes/listbyinstanceId?instanceid="+instanceId +"&lang=" + localStorageService.cookie.get('language')+"&sortBy=-id");
       	hasDatavolume.then(function (result) {
            $scope.dataVolume = result;
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
          		        $scope.formSubmitted = false;
          		        $scope.showLoader = true;
				$scope.global.webSocketLoaders.computeOffer = true;
          			$scope.instances.computeOfferingId = $scope.instance.computeOffering.id;
          			$scope.instances.computeOffering = $scope.instance.computeOffering;
          			var hasServer =crudService.updates("virtualmachine/resize", $scope.instances);
          			hasServer.then(function (result) {
          			}).catch(function (result) {
                        if (!angular.isUndefined(result) && result.data != null) {
	                        if (result.data.fieldErrors != '') {
	                            angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
	                            $scope.instanceForm[key].$invalid = true;
	                            $scope.instanceForm[key].errorMessage = errorMessage;
	                            });
	                            }
                        }
                        $scope.global.webSocketLoaders.computeOffer = false;
                        $scope.showLoader = false;
                        });
          			}
          		},

          		$scope.config = function (){
                               $window.location.href = '#/cloud/instance/configuration.jsp';
          		}



  	    // Load affinity group type
  	    $scope.affinityGroupType = {};
  	    var hasAffinityGroupType = appService.crudService.listAll("affinityGroupType/list");
  	    hasAffinityGroupType.then(function (result) {
  	    	$scope.formElements.affinityGroupTypeList = result;
  	    });
  	    $scope.affinity = {
  	    		groupList: []
  	    };
  	    // Affinity group List
  	    $scope.affinityGrouplist = function () {
  	    	$scope.affinityGroup = {};
  	  	    var hasAffinityGroup =  appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "affinityGroup/groupList/" + $scope.instances.departmentId);
  	  	    hasAffinityGroup.then(function (result) {
  	  	    	$scope.formElements.affinityGroupList = result;
  	  	    	angular.forEach($scope.formElements.affinityGroupList, function(formObj, formKey) {
	  	  	    	angular.forEach($scope.instances.affinityGroupList, function(obj, key) {
	  	  	    		if(formObj.name == obj.name)
	  	  	    			$scope.affinity.groupList.push(formObj);
		  	    	})
  	  	    	});
  	  	    });
  	    };

  	   $scope.createAffinityGroup = function (size) {
          appService.dialogService.openDialog($scope.global.VIEW_URL + "cloud/instance/affinity.jsp", size, $scope, ['$scope',
                    '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
          // Create a new affinity group
          $scope.save = function (affinityGroupForm, affinityGroup) {
       	   $scope.affinitySubmitted = true;
       		   if (affinityGroupForm.$valid) {
       			   $scope.showLoader = true;
       			    affinityGroup.affinityGroupTypeId = affinityGroup.affinityGroupType.id;
       			    affinityGroup.domainId = $scope.instances.domainId;
       			    affinityGroup.departmentId = $scope.instances.departmentId;
       			    affinityGroup.transAffinityGroupAccessFlag = "INSTANCE";
                      var hasServer = appService.crudService.add("affinityGroup", affinityGroup);
                      hasServer.then(function (result) {
                    	  $scope.affinityGrouplist();
                          $scope.showLoader = false;
                          $modalInstance.close();
                          appService.notify({message: 'Affinity group added successfully', classes: 'alert-success',
                          templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                   	}).catch(function (result) {
                   		if(result.data.globalError[0] != ''){
                   			var msg = result.data.globalError[0];
                   			appService.notify({message: msg, classes: 'alert-danger',
                   				templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                   			$modalInstance.close();
                          }
                   	});
       		   }

       	},
       	$scope.cancel = function () {
               $modalInstance.close();
       	};
          }]);
       };

       $scope.saveAffinity = function (form, affinity) {
      		$scope.affinitySubmitted = true;
      		if (form.$valid) {
      			$scope.showLoader = true;
                $scope.affinitySubmitted = false;
                $scope.instances.affinityGroupList = $scope.affinity.groupList;
      			var hasServer = appService.crudService.updates("virtualmachine/affinityGroup", $scope.instances);
      			hasServer.then(function (result) {
      				    $scope.showLoader = false;
                        $scope.instances = result;
   			            $scope.viewInstance(result.id);
   			            appService.notify({message: 'Affinity group updated successfully', classes: 'alert-success',
                         templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
      			}).catch(function (result) {
      				     $scope.showLoader = false;
                   		 if (!angular.isUndefined(result) && result.data != null) {
                         if (result.data.fieldErrors != '') {
                            angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                            $scope.affinityForm[key].$invalid = true;
                            $scope.affinityForm[key].errorMessage = errorMessage;
                            });
                        }
                        }
                    });
      			}
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
                        $scope.formSubmitted = false;
                        $scope.instances.keypairId = $scope.resetSSH.keypairName.id;
                        $scope.showLoader = true;
			$scope.global.webSocketLoaders.vmsshKey = true;
			$scope.showLoader = true;
   			var hasServer = appService.crudService.updates("virtualmachine/reset", $scope.instances);
   			hasServer.then(function (result) {
                         $scope.instances = result;
			 $scope.viewInstance(result.id);
   			}).catch(function (result) {
                		 if (!angular.isUndefined(result) && result.data != null) {
                     if (result.data.fieldErrors != '') {
                         angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                         $scope.resetForm[key].$invalid = true;
                         $scope.resetForm[key].errorMessage = errorMessage;
                         });
                         }
                     $scope.global.webSocketLoaders.vmsshKey = false;
                     $scope.showLoader = false;
                 }
                 $scope.global.webSocketLoaders.vmsshKey = false;
                 $scope.showLoader = false;
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
	   }).catch(function (result) {
     });
     };

     $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.vmresize, function(event, args) {
         if(args.status == 'FAILED'){
	    $scope.global.webSocketLoaders.computeOffer = false;
	 } else {
         	$scope.global.webSocketLoaders.computeOffer = false;
         	var hasServers = crudService.read("virtualmachine", instanceId);
        	hasServers.then(function (result) {
             	$scope.instances = result;
             	$scope.computeList();
         	});
	}
     });
     $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.vmSSHKEY, function(event, args) {
         if(args.status == 'FAILED'){
	    $scope.global.webSocketLoaders.vmsshKey = false;
	 } else if(args.status === 'SUCCEEDED') {
	    $scope.global.webSocketLoaders.vmsshKey = false;
            $scope.resetSSHKey();
            if ($scope.instances.passwordEnabled == true) {
               $scope.resetPassword($scope.instances);
            }
	}
     });
    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.resetPassword, function(event, args) {
    });
    $scope.$on(appService.globalConfig.webSocketEvents.volumeEvents.attachVolume, function(event, args) {
    	$scope.list();
    });
    $scope.$on(appService.globalConfig.webSocketEvents.volumeEvents.detachVolume, function(event, args) {
    	$scope.list();
    });

}
