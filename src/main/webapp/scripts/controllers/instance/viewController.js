/**
 *
 * instanceViewCtrl
 *
 */

angular
        .module('homer')
        .controller('instanceViewCtrl', instanceViewCtrl)
        .controller('instanceDetailsCtrl', instanceDetailsCtrl)

function instanceViewCtrl($scope,$log, $sce, dialogService, $modal,$http, $state, $stateParams, promiseAjax, localStorageService, globalConfig, crudService, notify, $window) {

    $scope.instanceList = [];
    $scope.testvar = "test";
    $scope.global = crudService.globalConfig;
    if ($stateParams.id > 0) {
    	$scope.showLoader = true;
    	$scope.showLoaderOffer = true;
 	    var hasServer = crudService.read("virtualmachine", $stateParams.id);
        hasServer.then(function (result) {  // this is only run after $http											// completes
            $scope.instance = result;
		$scope.instanceList = result;

		console.log($scope.instance);
            var str = $scope.instance.cpuUsage;
            if(str!=null){
            var newString = str.replace(/^_+|_+$/g,'');
            var num = parseFloat(newString).toFixed(2);
            $state.current.data.pageName = result.name;
            $scope.showLoaderOffer = false;
            $scope.showLoader = false;
            $scope.chart(num);
            }

            else{
            	   $scope.showLoaderOffer = false;
            	   $scope.showLoader = false;
            	 $scope.chart(0);
            }
		$scope.cancel = function () {
            $modalInstance.close();
        };

        });

    }

    // Resize Instance
   
    $scope.resize = function() {
     	 dialogService.openDialog("app/views/cloud/instance/runningresize.jsp", 'sm',  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {
   			  $scope.cancel = function () {
                  $modalInstance.close();
              };
          }]);
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
	    };
	    $scope.list();

    $scope.startVm = function(size, item) {
		  dialogService.openDialog("app/views/cloud/instance/start.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
			  $scope.item =item;
			  $scope.vmStart = function(item) {
					var event = "VM.START";
					var hasVm = crudService.vmUpdate("virtualmachine/event", item.uuid, event);
					hasVm.then(function(result) {
						$state.reload();
						 $scope.cancel();
					}).catch(function (result) {
	  					console.log(result.data.globalError[0]);
	  			         if(result.data.globalError[0] != null){
	  			        	 var msg = result.data.globalError[0];
	  			        	 notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });

	  			             }
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
  				}).catch(function (result) {
  					console.log(result.data.globalError[0]);
 			         if(result.data.globalError[0] != null){
 			        	 var msg = result.data.globalError[0];
 			        	 notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });

 			             }
                       });
  			},
			  $scope.cancel = function () {
               $modalInstance.close();
           };
       }]);
  };

  $scope.isoList = function () {
      var hasisoList = crudService.listAll("iso/list");
      hasisoList.then(function (result) {  // this is only run after $http
											// completes0
              $scope.isoLists = result;
       });
   };
   $scope.isoList();

   $scope.hostList = function () {
	      var hashostList = crudService.listAll("host/list");
	      hashostList.then(function (result) {  // this is only run after $http
				$scope.hostLists = result;
	       });
	   };
	   $scope.hostList();

  $scope.rebootVm = function(size,item) {
  	 dialogService.openDialog("app/views/cloud/instance/reboot.jsp", size,  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {
  		 $scope.item =item;
  		 $scope.vmRestart = function(item) {
  				var event = "VM.REBOOT";
  				var hasVm = crudService.vmUpdate("virtualmachine/event", item.uuid, event);
  				hasVm.then(function(result) {
  					$state.reload();
  					 $scope.cancel();
  				}).catch(function (result) {
  					console.log(result.data.globalError[0]);
 			         if(result.data.globalError[0] != null){
 			        	 var msg = result.data.globalError[0];
 			        	 notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });

 			             }
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
	  				}).catch(function (result) {
	  					console.log(result.data.globalError[0]);
	  			         if(result.data.globalError[0] != null){
	  			        	 var msg = result.data.globalError[0];
	  			        	 notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
	  			        	$state.reload();
		  					$scope.cancel();
	  			             }
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
			  				}).catch(function (result) {
			  					console.log(result.data.globalError[0]);
			  			         if(result.data.globalError[0] != null){
			  			        	 var msg = result.data.globalError[0];
			  			        	 notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
			  			        	$state.reload();
				  					$scope.cancel();
			  			             }
		                            });
		  		        } else{
		  		        	var event = "VM.DESTROY";
		  		        	var hasVm = crudService.vmUpdate("virtualmachine/event", item.uuid, event);
		  		        	hasVm.then(function(result) {
		  					$state.reload();
		  					$scope.cancel();
		  				}).catch(function (result) {
		  					console.log(result.data.globalError[0]);
		  			         if(result.data.globalError[0] != null){
		  			        	 var msg = result.data.globalError[0];
		  			        	 notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
		  			        	$state.reload();
			  					$scope.cancel();
		  			             }
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
			  				}).catch(function (result) {
			  					console.log(result.data.globalError[0]);
			  			         if(result.data.globalError[0] != null){
			  			        	 var msg = result.data.globalError[0];
			  			        	 notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
			  			        	$state.reload();
				  					$scope.cancel();
			  			             }
		                            });
		  			},
					  $scope.cancel = function () {
		               $modalInstance.close();
		           };
		       }]);
			  };

			  $scope.showConsole = function(vm) {
				  $scope.vm = vm;
				  var hasVms = crudService.updates("virtualmachine/console", vm);
	  				hasVms.then(function(result) {
	  					$scope.consoleUrl = $sce.trustAsResourceUrl(result.success);

	  					$window.sessionStorage.setItem("consoleToken", $scope.consoleUrl);
	  					$window.sessionStorage.setItem("consoleVms", JSON.stringify($scope.vm));
	  					//$scope.consoleUrl = $sce.trustAsResourceUrl("http://192.168.1.152/console/?token=MTkyLjE2OC4xLjE1MnxpLTItNjktVk18bm92bmN0ZXN0");
	  					$scope.instance = vm;
	  					 window.open("app/console.jsp", 'Console', 'width=800,height=580');
	  			        /*dialogService.openDialog("app/views/cloud/instance/view-console.jsp", 'lg', $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
	  			          $scope.cancel = function () {
			  	               $modalInstance.close();
			  	           };
	  			        }]);*/

	  				});
			  }

			  $scope.instnaceEdit = false;
			  $scope.editDisplayName = function(vm) {
				  $scope.vm = vm;
				  $scope.instnaceEdit = true;
			  }

	  		 $scope.updateDisplayName= function(vm) {
	  			 	$scope.formSubmitted = true;
	  			 	$scope.vm = vm;
	  			 	if($scope.vm.transDisplayName != "") {
	  			 		$scope.vm.transDisplayName=$scope.vm.transDisplayName;
	  			 		var hasVm = crudService.update("virtualmachine", $scope.vm);
		  				hasVm.then(function(result) {
		  					notify({message: "Updated successfully", classes: 'alert-success', "timeOut": "5000", templateUrl: $scope.homerTemplate});
		  					$state.reload();
		  					 $scope.cancel();
		  				});
	  			 	}
	  		 };

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
					  		var tempVm = vm;
					  		 var event = "ISO.ATTACH";
					  		 $scope.attachISotoVM = function(form) {
					  			$scope.formSubmitted =true;
					  			 if(form.$valid) {
					  				tempVm.iso = $scope.isos.uuid;
					  				tempVm.event = event;
							  		console.log(tempVm.iso);
							  		console.log(tempVm.event);
						  				var hasVm = crudService.updates("virtualmachine/vm", tempVm);
						  				hasVm.then(function(result) {
						  					$scope.homerTemplate = 'app/views/notification/notify.jsp';
						                     notify({message: $scope.isos.name+" is attaching to this VM", classes: 'alert-success', "timeOut": "5000", templateUrl: $scope.homerTemplate});
						  					$state.reload();
						  					 $scope.cancel();
						  				}).catch(function (result) {
						  					console.log(result);
						  					console.log(result.data.globalError[0]);
						  			         if(result.data.globalError[0] != null){
						  			        	 var msg = result.data.globalError[0];
						  			        	 notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
						  			        	$state.reload();
							  					$scope.cancel();
						  			             }
					                            });
					  			 }
					  			},
								  $scope.cancel = function () {
					               $modalInstance.close();
					           };
					       }]);
					  };
					  $scope.detachISO = function(vm) {
						  	 dialogService.openDialog("app/views/cloud/instance/detach-ISO.jsp", 'md',  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {
						  		 $scope.vm = vm;
						  		 var event = "ISO.DETACH";
						  		 $scope.update = function() {
						  			$scope.vm.event = event;
							  				var hasVm = crudService.updates("virtualmachine/vm", $scope.vm);
							  				hasVm.then(function(result) {
							  					$scope.homerTemplate = 'app/views/notification/notify.jsp';
							                     notify({message: $scope.vm.isoName+" is detaching from this VM", classes: 'alert-success', "timeOut": "5000", templateUrl: $scope.homerTemplate});
							  					$state.reload();
							  					$scope.cancel();
							  				}).catch(function (result) {
							  					console.log(result);
							  					console.log(result.data.globalError[0]);
							  			         if(result.data.globalError[0] != null){
							  			        	 var msg = result.data.globalError[0];
							  			        	 notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
							  			        	$state.reload();
								  					$scope.cancel();
							  			             }
						                            });
						  			},
									  $scope.cancel = function () {
						               $modalInstance.close();
						           };
						       }]);
						  };

						  $scope.takeSnapshot = function(vm) {
							  	 dialogService.openDialog("app/views/cloud/instance/createVmSnapshot.jsp", 'md',  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance, $rootScope) {
							  		 $scope.instance = vm;
							  		 $scope.validateVMSnapshot= function(form) {
								  			$scope.formSubmitted = true;
						                    if (form.$valid) {
						                    	$scope.vmsnapshot.domainId = $scope.instance.domainId;
						                    	$scope.vmsnapshot.vmId = $scope.instance.id;
						                    	if (angular.isUndefined($scope.vmsnapshot.snapshotMemory) || $scope.vmsnapshot.snapshotMemory === null || $scope.vmsnapshot.snapshotMemory === '') {
						                    	$scope.vmsnapshot.snapshotMemory = false;
						                    	}
								  				var hasVm = crudService.add("vmsnapshot",$scope.vmsnapshot);
								  				hasVm.then(function(result) {
								  					$scope.homerTemplate = 'app/views/notification/notify.jsp';
								                     notify({message: $scope.vmsnapshot.name+" is creating for "+$scope.instance.name, classes: 'alert-success', "timeOut": "5000", templateUrl: $scope.homerTemplate});
								  					 $state.reload();
								  					 $scope.cancel();
								  				}).catch(function (result) {
								  					console.log(result.data.globalError[0]);
								  				  $scope.homerTemplate = 'app/views/notification/notify.jsp';
								                     notify({message: result.data.globalError[0], classes: 'alert-danger', "timeOut": "5000", templateUrl: $scope.homerTemplate});
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

						$scope.hostMigrate = function(vm) {
								  	 dialogService.openDialog("app/views/cloud/instance/host-migrate.jsp", 'md',  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {
								  		var vms = vm;
								  		 var event = "VM.MIGRATE";
								  		 $scope.update= function(form) {
								  			vms.event = event;
								  			$scope.formSubmitted = true;
						                    if (form.$valid) {
						                    	vms.hostUuid = $scope.host.uuid;
									  				var hasVm = crudService.updates("virtualmachine/vm", vms);
									  				hasVm.then(function(result) {
									  					$scope.homerTemplate = 'app/views/notification/notify.jsp';
									                    notify({message: $scope.host.name+" is migrating", classes: 'alert-success', "timeOut": "5000", templateUrl: $scope.homerTemplate});
									  					$state.reload();
									  					 $scope.cancel();
									  				}).catch(function (result) {
									  					console.log(result.data.globalError[0]);
									  			         if(result.data.globalError[0] != null){
									  			        	 var msg = result.data.globalError[0];
									  			        	 notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
									  			        	$state.reload();
										  					$scope.cancel();
									  			         }
								                            });
								  		 }
						                    },
											  $scope.cancel = function () {
								               $modalInstance.close();
								           };
								       }]);
								  };


						$scope.hostInformation = function(vm) {

								  	 dialogService.openDialog("app/views/cloud/instance/listhost.jsp", 'md',  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {
					console.log($scope.instance.host);
					  $scope.cancel = function () {
					        $modalInstance.close();
					    };


								       }]);
								  };
						$scope.showPassword = function(vm) {
									  	 dialogService.openDialog("app/views/cloud/instance/show-reset-password.jsp", 'md',  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {
									  		 $scope.vm = vm;
									  		 var event = "VM.RESETPASSWORD";
									  		 $scope.update= function(form) {
									  			$scope.vm.event = event;
									  			$scope.formSubmitted = true;
									  			if(form.$valid) {
									  				   $scope.vm.password = $scope.passwords;
										  				var hasVm = crudService.updates("virtualmachine/vm", $scope.vm);
										  				hasVm.then(function(result) {
										  					$state.reload();
										  					 $scope.cancel();
										  				}).catch(function (result) {
										  					console.log(result);
										  					console.log(result.data.globalError[0]);
										  			         if(result.data.globalError[0] != null){
										  			        	 var msg = result.data.globalError[0];
										  			        	notify({message: msg, classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
										  			        	$state.reload();
											  					$scope.cancel();
										  			         }
									                            });
									  			}
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
// responsive: true,
// maintainAspectRatio: true
    };

$scope.chart=function(used){

	var available= parseFloat(100-used).toFixed(2);


    var instanceLimit = {
        "title": "Instance",
        "options": [
                    {
                value: parseFloat(available),
                color: "#d6ebf5",
                highlight: "#57b32c",
                label: "Available",
                showLabels: "true",
            },
            {
                value: parseFloat(used),
                color: "#3399FF",
                highlight: "#e74c3c",
                label: "Used",
                showLabels: "true",
            }]
    };

    /**
     * Data for Doughnut chart
     */
    $scope.quotaLimitData = [
        instanceLimit
           ];


    /**
     * Options for Doughnut chart
     */
    $scope.quotaChartOptions = {
        segmentShowStroke: true,
        segmentStrokeColor: "#fff",
        segmentStrokeWidth: 1,
        percentageInnerCutout: 50, // This is 0 for Pie charts
        animationSteps: 100,
        animationEasing: false,
        animateRotate: false,
        animateScale: false,
        showTooltips: true,
        tooltipCaretSize: 12,
        tooltipFontSize: 12,
        tooltipYPadding: 6,
        tooltipXPadding: 6,
        legend:true
    };

}
}

function instanceDetailsCtrl($scope,$log, $sce, dialogService, $modal,$http, $state, $stateParams, promiseAjax, localStorageService, globalConfig, crudService, notify, $window) {

    $scope.instanceList = [];
    $scope.testvar = "test";
    $scope.global = crudService.globalConfig;

if ($stateParams.id > 0) {
    	$scope.showLoader = true;
    	$scope.showLoaderOffer = true;
 	    var hasServer = crudService.read("virtualmachine", $stateParams.id);
        hasServer.then(function (result) {  // this is only run after $http											// completes
            $scope.instance = result;
		$scope.instanceList = result;
console.log($scope.instance);
            var str = $scope.instance.cpuUsage;
            if(str!=null){
            var newString = str.replace(/^_+|_+$/g,'');
            var num = parseFloat(newString).toFixed(2);
            $state.current.data.pageName = result.name;
            $scope.showLoaderOffer = false;
            $scope.showLoader = false;
            $scope.chart(num);
            }
            else{
            	   $scope.showLoaderOffer = false;
            	   $scope.showLoader = false;
            	 $scope.chart(0);
            }

        });
    }

};
