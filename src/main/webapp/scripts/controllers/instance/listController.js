/**
 *
 * instanceListCtrl
 *
 */

angular.module('homer').controller('instanceListCtrl', instanceListCtrl)
		.controller('instanceDetailsCtrl', instanceDetailsCtrl)

function instanceListCtrl($scope, $sce, $log, $filter, dialogService, promiseAjax, $state,
		globalConfig, crudService,$modal, localStorageService, $window, notify, appService, $stateParams) {


    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.startVm, function() {

  //   $scope.instanceList = appService.webSocket;
    });

    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.stopVm, function() {
    //    $scope.instanceList = appService.webSocket;
    });

    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.rebootVm, function() {
   //     $scope.instanceList = appService.webSocket;
    });

	$scope.instanceList = [];
	$scope.instancesList = [];
	$scope.instance = {};
    $scope.global = crudService.globalConfig;
	$scope.paginationObject = {};
    $scope.sort = appService.globalConfig.sort;
    $scope.changeSorting = appService.utilService.changeSorting;

    if ($stateParams.id > 0) {
        var hasServer = appService.crudService.read("virtualmachine", $stateParams.id);
        hasServer.then(function (result) {  // this is only run after $http
            $scope.instance = result;
            $scope.networkList = result.network;
            $state.current.data.pageName = result.name;
            $state.current.data.id = result.id;
        });
    }

    $scope.hostList = function () {
	      var hashostList = appService.crudService.listAll("host/list");
	      hashostList.then(function (result) {
				$scope.hostLists = result;
	       });
	   };
	   $scope.hostList();

	   $scope.showConsole = function(vm) {
		   $scope.vm = vm;
		   var hasVms = crudService.updates("virtualmachine/console", vm);
		   hasVms.then(function(result) {
			   var consoleUrl = result.success + "&displayname="+vm.displayName;
			   window.open($sce.trustAsResourceUrl(consoleUrl), vm.name + vm.id,'width=750,height=460');
			   appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.vmEvents.showConsole,result.id,$scope.global.sessionValues.id);
		   });

	   }


	   $scope.startVm = function(size, item) {
	       $scope.instance = item;
	       if($scope.global.sessionValues.type === 'ROOT_ADMIN'){
	           size = 'md';
	       } else {
	    		size = 'sm';
	       }
	       appService.dialogService.openDialog("app/views/cloud/instance/start.jsp", size,  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {
		       var vms = item;
		  	   var event = "VM.START";
		  	   $scope.update= function(form) {
		  	       vms.event = event;
		  		   $scope.formSubmitted = true;
	               if (form.$valid) {
	                   if($scope.instance.host != null) {
	                       vms.hostUuid = $scope.instance.host.uuid;
	                   }
			  		   var hasVm = appService.crudService.updates("virtualmachine/handleevent/vm", vms);

			  		       hasVm.then(function(result) {
			  		    	 appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.vmEvents.startVm,result.id,$scope.global.sessionValues.id);
			                   $state.reload();
			  				   $scope.cancel();
			  			   }).catch(function (result) {

			  				  $state.reload();
                              $scope.cancel();
		                    });
		  		 }

	                },
					  $scope.cancel = function () {
		               $modalInstance.close();
		           };
		       }]);
	  };

	       $scope.agree = {
	               value1 : false,
	               value2 : true
	             };
	  $scope.stopVm = function(size,item) {
              $scope.item =item;
             appService.dialogService.openDialog("app/views/cloud/instance/stop.jsp", size,  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {
                     $scope.item = item;
                    $scope.vmStop = function(item) {
                            var event = "VM.STOP";
                            $scope.actionExpunge = true;
                            if ($scope.agree.value1) {
                                 item.transForcedStop = $scope.agree.value1;
                                 item.event = event;
                                 var hasVm = appService.crudService.updates("virtualmachine/handleevent/vm", item);
                                 hasVm.then(function(result) {
                                        $state.reload();
                                        $scope.cancel();
                                        appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.vmEvents.stopVm,result.id,$scope.global.sessionValues.id);
                                 }).catch(function (result) {
                                        $state.reload();
                                        $scope.cancel();

                                 });
                            } else {
                              var event = "VM.STOP";
                                    var hasVm = appService.crudService.vmUpdate("virtualmachine/handlevmevent", item.uuid, event);
                                    hasVm.then(function(result) {
                                            $state.reload();
                                             $scope.cancel();
                                             appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.vmEvents.stopVm,result.id,$scope.global.sessionValues.id);
                                    }).catch(function (result) {
                                      $state.reload();
                                      $scope.cancel();

                                    });
                              }
                            },
                              $scope.cancel = function () {
                   $modalInstance.close();
               };
           }]);
      };
    $scope.rebootVm = function(size,item) {
    	 dialogService.openDialog("app/views/cloud/instance/reboot.jsp", size,  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {
    		 $scope.item =item;
    		 $scope.vmRestart = function(item) {
    				var event = "VM.REBOOT";
    				var hasVm = crudService.vmUpdate("virtualmachine/handlevmevent", item.uuid, event);
    				hasVm.then(function(result) {
    					$state.reload();
    					 $scope.cancel();
    	    				appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.vmEvents.rebootVm,result.id,$scope.global.sessionValues.id);
    				});
    			},
			  $scope.cancel = function () {
                 $modalInstance.close();
             };
         }]);
    };



	$scope.vm = {};

	$scope.list = function(pageNumber, status) {
	if(!angular.isUndefined(status)) {
	$scope.vm.status = status;
 	$window.sessionStorage.removeItem("status")
 	$window.sessionStorage.setItem("status",status);
	} else {
	$scope.vm.status=$window.sessionStorage.getItem("status");
        }
		$scope.showLoader = true;
		var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;

		var hasUsers =  promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "virtualmachine/listByStatus" +"?lang=" + localStorageService.cookie.get('language') + "&status="+$scope.vm.status+"&sortBy=+name&limit="+limit,  $scope.global.paginationHeaders(pageNumber, limit), {
			"limit" : limit
		})

		$scope.borderContent = status
		hasUsers.then(function(result) { // this is only run after $http
			// completes0
			$scope.instanceList = result;
			// For pagination

                $scope.instancesList.Count = 0;
           		 for (i = 0; i < result.length; i++) {
            		 if($scope.instanceList[i].status.indexOf("Expunging") > -1) {
            		 $scope.instancesList.Count++;
           		  }
           		 }

           		 // Get the count of the listings
           		var hasVmCount =  crudService.listAll("virtualmachine/vmCounts");
           		hasVmCount.then(function(result) {
           			$scope.runningVmCount = result.runningVmCount;
           			$scope.stoppedVmCount = result.stoppedVmCount;
           			$scope.totalCount = result.totalCount;
        		});
			$scope.paginationObject.limit = limit;
			$scope.paginationObject.currentPage = pageNumber;
			$scope.paginationObject.totalItems = result.totalItems;
			$scope.showLoader = false;
		});
	};

	$scope.list(1, "Expunging");


	$scope.openAddInstance = function(size) {

		var modalInstance = $modal.open({
			templateUrl : 'app/views/cloud/instance/add.jsp',
			controller : 'instanceCtrl',
			size : size,
			backdrop : 'static',
			windowClass : "hmodal-info",
			resolve : {
				items : function() {
					return $scope.items;
				}
			}
		});

		modalInstance.result.then(function(selectedItem) {
			$scope.selected = selectedItem;
		}, function() {
			$log.info('Modal dismissed at: ' + new Date());
		});

	};

	$scope.showDescription = function(vm) {
            $scope.instance = vm;
            appService.dialogService.openDialog("app/views/cloud/instance/displaynote.jsp", 'sm',  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {

                $scope.cancel = function () {
                        $modalInstance.close();
                };
            }]);
         };

	$scope.addApplication = function(vm) {
        var hasapplicationList = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL
            		+ "applications/domain?domainId="+vm.domainId)
    		      hasapplicationList.then(function (result) {
    		              $scope.applicationLists = result;
    		       });

	  	 appService.dialogService.openDialog("app/views/cloud/instance/add-application.jsp", 'md',  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {
	  		var tempVm = vm;
	  		 var event = "ADD.APPLICATION";
	  		 $scope.addApplicationtoVM = function(form) {
	  			$scope.formSubmitted =true;
	  			 if(form.$valid) {
	  				tempVm.application = $scope.application;
	  				tempVm.applicationList = $scope.applications;
	  				tempVm.event = event;
		  				var hasVm = appService.crudService.updates("virtualmachine/handleevent/vm", tempVm);
		  				hasVm.then(function(result) {
		  					$scope.homerTemplate = 'app/views/notification/notify.jsp';
		                     appService.notify({message: $scope.application+" is adding to this VM", classes: 'alert-success', "timeOut": "5000", templateUrl: $scope.homerTemplate});
		  					 $state.reload();
		  					 $scope.cancel();
		  				}).catch(function (result) {
		  				  $state.reload();
                          $scope.cancel();
	                            });
	  			 }
	  			},
				  $scope.cancel = function () {
	               $modalInstance.close();
	           };
	       }]);
	  };

}
function instanceDetailsCtrl($scope, instance, notify, $modalInstance) {

	$scope.update = function(form) {

		$scope.formSubmitted = true;

		if (form.$valid) {
			$scope.homerTemplate = 'app/views/notification/notify.jsp';
			notify({
				message : 'Updated successfully',
				classes : 'alert-success',
				templateUrl : $scope.homerTemplate
			});
			$scope.cancel();
		}
	};
	$scope.instance = instance;
	$scope.cancel = function() {
		$modalInstance.dismiss('cancel');
	};
};
