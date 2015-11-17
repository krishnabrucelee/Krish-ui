/**
 *
 * instanceViewCtrl
 *
 */

angular
        .module('homer')
        .controller('instanceViewCtrl', instanceViewCtrl)
        .controller('instanceDetailsCtrl', instanceDetailsCtrl)


function instanceViewCtrl($scope,$log, dialogService, $modal,$http, $state, $stateParams, localStorageService, globalConfig, crudService, $window) {
    $scope.instanceList = [];
    $scope.global = crudService.globalConfig;
    if ($stateParams.id > 0) {
        var hasServer = crudService.read("virtualmachine", $stateParams.id);
        hasServer.then(function (result) {  // this is only run after $http completes
            $scope.instance = result;
        });
    }

    $scope.startVm = function(size, item) {
		  dialogService.openDialog("app/views/cloud/instance/start.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
			  $scope.item =item;
			  $scope.vmStart = function(item) {
					var event = "VM.START";
					var hasVm = crudService.vmUpdate("virtualmachine/event", item.uuid, event);
					hasVm.then(function(result) {
						$state.reload();
						 $scope.cancel();
					});
				},
			  $scope.cancel = function () {
                $modalInstance.close();
            };
        }]);
  };

  $scope.stopVm = function(size,item) {
  	 dialogService.openDialog("app/views/cloud/instance/stop.jsp", size, $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance, $rootScope) {
  		 $scope.item =item;
  		 $scope.vmStop = function(item) {
  				var event = "VM.STOP";
  				var hasVm = crudService.vmUpdate("virtualmachine/event", item.uuid, event);
  				hasVm.then(function(result) {
  					$state.reload();
  					 $scope.cancel();
  				});
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
  				var hasVm = crudService.vmUpdate("virtualmachine/event", item.uuid, event);
  				hasVm.then(function(result) {
  					$state.reload();
  					 $scope.cancel();
  				});
  			},
			  $scope.cancel = function () {
               $modalInstance.close();
           };
       }]);
  };

  $scope.actionExpunge = false;

  $scope.reInstallVm = function(size,item) {
	  	 dialogService.openDialog("app/views/cloud/instance/reinstall.jsp", size,  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {
	  		 $scope.item =item;
	  		 $scope.vmRestart = function(item) {
	  				var event = "VM.RESTORE";
	  				var hasVm = crudService.vmUpdate("virtualmachine/event", item.uuid, event);
	  				hasVm.then(function(result) {
	  					$state.reload();
	  					 $scope.cancel();
	  				});
	  			},
				  $scope.cancel = function () {
	               $modalInstance.close();
	           };
	       }]);
	  };

	  $scope.reDestroyVm = function(size,item) {
		  	 dialogService.openDialog("app/views/cloud/instance/vmdestroy.jsp", size,  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {
		  		 $scope.item =item;
		  		 $scope.vmDestroy = function(item) {
		  			$scope.actionExpunge = true;
		  				if ($scope.agree == true) {
		  					var event = "VM.EXPUNGE";
			  				var hasVm = crudService.vmUpdate("virtualmachine/event", item.uuid, event);
			  				hasVm.then(function(result) {
			  					$state.reload();
			  					 $scope.cancel();
			  				});
		  		        } else{
		  		        	var event = "VM.DESTROY";
		  		        	var hasVm = crudService.vmUpdate("virtualmachine/event", item.uuid, event);
		  		        	hasVm.then(function(result) {
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

		  $scope.recoverVm = function(size,item) {
			  	 dialogService.openDialog("app/views/cloud/instance/recoverVm.jsp", size,  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {
			  		 $scope.item =item;
			  		 $scope.vmRecover= function(item) {
			  					var event = "VM.CREATE";
				  				var hasVm = crudService.vmUpdate("virtualmachine/event", item.uuid, event);
				  				hasVm.then(function(result) {
				  					$state.reload();
				  					 $scope.cancel();
				  				});

			  			},
						  $scope.cancel = function () {
			               $modalInstance.close();
			           };
			       }]);
			  };

			  $scope.showConsole = function(vm) {
				  $scope.vm = vm;
				  var hasVms = crudService.console("virtualmachine/console", $scope.vm.name);
	  				hasVms.then(function(result) {
	  					console.log(result);
	  					 $window.open(result);
	  				});
			  }

			  $scope.showDescription = function(vm) {
				  	 dialogService.openDialog("app/views/cloud/instance/editnote.jsp", 'sm',  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {
				  		 $scope.vm = vm;
				  		 $scope.update= function(form) {
					  				var hasVm = crudService.update("virtualmachine", $scope.vm);
					  				hasVm.then(function(result) {
					  					$state.reload();
					  					 $scope.cancel();
					  				});

				  			},
							  $scope.cancel = function () {
				               $modalInstance.close();
				           };
				       }]);
				  };
				  $scope.attachISO = function(vm) {
					  	 dialogService.openDialog("app/views/cloud/instance/attach-ISO.jsp", 'md',  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {
					  		 $scope.vm = vm;
					  		 $scope.update= function(form) {
						  				var hasVm = crudService.vmUpdate("virtualmachine/event", item.uuid, event);
						  				hasVm.then(function(result) {
						  					$state.reload();
						  					 $scope.cancel();
						  				});

					  			},
								  $scope.cancel = function () {
					               $modalInstance.close();
					           };
					       }]);
					  };
					  $scope.detachISO = function(vm) {
						  	 dialogService.openDialog("app/views/cloud/instance/detach-ISO.jsp", 'md',  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {
						  		 $scope.vm = vm;
						  		 $scope.update= function(form) {
							  				var hasVm = crudService.vmUpdate("virtualmachine/event", item.uuid, event);
							  				hasVm.then(function(result) {
							  					$state.reload();
							  					 $scope.cancel();
							  				});

						  			},
									  $scope.cancel = function () {
						               $modalInstance.close();
						           };
						       }]);
						  };

						  $scope.takeSnapshot = function(vm) {
							  	 dialogService.openDialog("app/views/cloud/instance/createVmSnapshot.jsp", 'md',  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {
							  		 $scope.instance = vm;
							  		 $scope.validateVMSnapshot= function(form) {
								  			$scope.formSubmitted = true;
						                    if (form.$valid) {
						                    	$scope.vmsnapshot.domainId = $scope.instance.domainId;
						                    	$scope.vmsnapshot.vmId = $scope.instance.id;
								  				var hasVm = crudService.add("vmsnapshot",$scope.vmsnapshot);
								  				hasVm.then(function(result) {
								  					$state.reload();
								  					 $scope.cancel();
								  				}).catch(function (result) {
								  					console.log(result.data.globalError[0]);
								  			         if(result.data.globalError[0] != ''){
								  			        	 var msg = result.data.globalError[0];
								  			        	 notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
								  			        	 wizard.show(1);
								  			             } else if(!angular.isUndefined(result) && result.data != null) {
							                            angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
							                            	$scope.departmentForm[key].$invalid = true;
							                                $scope.departmentForm[key].errorMessage = errorMessage;
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

						$scope.hostMigrate = function(vm) {
								  	 dialogService.openDialog("app/views/cloud/instance/host-migrate.jsp", 'md',  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {
								  		 $scope.vm = vm;

								  		 $scope.update= function(form) {
									  				var hasVm = crudService.vmUpdate("virtualmachine/event", item.uuid, event);
									  				hasVm.then(function(result) {
									  					$state.reload();
									  					 $scope.cancel();
									  				});

								  		 },
											  $scope.cancel = function () {
								               $modalInstance.close();
								           };
								       }]);
								  };
						$scope.showPassword = function(vm) {
									  	 dialogService.openDialog("app/views/cloud/instance/show-reset-password.jsp", 'md',  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {
									  		 $scope.vm = vm;
									  		 $scope.update= function(form) {
										  				var hasVm = crudService.vmUpdate("virtualmachine/event", item.uuid, event);
										  				hasVm.then(function(result) {
										  					$state.reload();
										  					 $scope.cancel();
										  				});

									  			},
												  $scope.cancel = function () {
									               $modalInstance.close();
									           };
									       }]);
							};

    $scope.templateCategory = 'dashboard';
    var instanceViewTab = localStorageService.get("instanceViewTab");
    if (!angular.isUndefined(instanceViewTab) && instanceViewTab != null) {
        $scope.templateCategory = instanceViewTab;
        localStorageService.set("instanceViewTab", 'dashboard');
    }

    $scope.reloadMonitor = function () {
        localStorageService.set("instanceViewTab", 'monitor');
        $state.reload();
    }




    /**
     * Data for Line chart
     */
    $scope.lineData = {
        labels: ["10.00", "10.05", "10.10", "10.15", "10.20", "10.25", "10.30"],
        datasets: [
            {
                label: "vCpu %",
                fillColor: "#E56919",
                strokeColor: "#E56919",
                pointColor: "#E56919",
                pointStrokeColor: "#fff",
                pointHighlightFill: "#fff",
                pointHighlightStroke: "rgba(220,220,220,1)",
                data: [52, 44, 37, 43, 46, 45, 32]
            },
            {
                label: "Memory %",
                fillColor: "#16658D",
                strokeColor: "#16658D",
                pointColor: "#16658D",
                pointStrokeColor: "#fff",
                pointHighlightFill: "#fff",
                pointHighlightStroke: "rgba(26,179,148,1)",
                data: [37, 39, 29, 36, 32, 23, 28]
            },
            {
                label: "N/W: kB/s",
                fillColor: "#7208A8",
                strokeColor: "#7208A8",
                pointColor: "#7208A8",
                pointStrokeColor: "#fff",
                pointHighlightFill: "#fff",
                pointHighlightStroke: "rgba(26,179,148,1)",
                data: [26, 32, 22, 26, 25, 22, 18]
            },
            {
                label: "Disk: Bytes/Sec",
                fillColor: "rgba(98,203,49,0.5)",
                strokeColor: "rgba(98,203,49,0.7)",
                pointColor: "rgba(98,203,49,1)",
                pointStrokeColor: "#fff",
                pointHighlightFill: "#fff",
                pointHighlightStroke: "rgba(26,179,148,1)",
                data: [12, 22, 18, 16, 20, 19, 9]
            }

        ]
    };
    $scope.instanceElements = {actions: [
            {id: 1, name: 'Hours'},
            {id: 2, name: 'Days'},
            {id: 3, name: 'Weeks'},
            {id: 4, name: 'Month'}
        ]};

    /**
     * Options for Line chart
     */
    $scope.lineOptions = {
        scaleShowGridLines: true,
        scaleGridLineColor: "rgba(0,0,0,.05)",
        scaleGridLineWidth: 1,
        bezierCurve: true,
        bezierCurveTension: 0.4,
        pointDot: true,
        pointDotRadius: 4,
        pointDotStrokeWidth: 1,
        pointHitDetectionRadius: 20,
        datasetStroke: true,
        datasetStrokeWidth: 1,
        datasetFill: false,
//        responsive: true,
//        maintainAspectRatio: true
    };

}
function instanceDetailsCtrl($scope, instance, $modalInstance) {
    $scope.instance = instance;
    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };
}
;