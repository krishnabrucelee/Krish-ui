/**
 *
 * instanceViewCtrl
 *
 */
angular
        .module('homer')
        .controller('instanceViewCtrl', instanceViewCtrl)
        .controller('instanceDetailsCtrl', instanceDetailsCtrl)

function instanceViewCtrl($scope, $sce, $state, $stateParams, appService, $window) {

  $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.startVm, function() {
      //  $scope.instance = appService.webSocket;
    });

    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.stopVm, function() {
     //   $scope.instance = appService.webSocket;
    });

    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.rebootVm, function() {
      //  $scope.instance = appService.webSocket;
    });

      $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.reInstallVm, function() {
       // $scope.instance = appService.webSocket;
    });

    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.stopVm, function() {
       // $scope.instance = appService.webSocket;
    });

    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.rebootVm, function() {
      //  $scope.instance = appService.webSocket;
    });
    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.reDestroyVm, function() {
      //  $scope.instance = appService.webSocket;
    });

    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.recoverVm, function() {
      //  $scope.instance = appService.webSocket;
    });

    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.updateDisplayName, function() {
       // $scope.instance = appService.webSocket;
    });
    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.showDescription, function() {
       // $scope.instance = appService.webSocket;
    });

    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.attachISO, function() {
       // $scope.instance = appService.webSocket;
    });

    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.detachISO, function() {
       // $scope.instance = appService.webSocket;
    });

    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.takeSnapshot, function() {
       // $scope.instance = appService.webSocket;
    });

    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.hostMigrate, function() {
        //$scope.instance = appService.webSocket;
    });

    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.showPassword, function() {
      //  $scope.instance = appService.webSocket;
    });
    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.resetPassword, function() {
       // $scope.instance = appService.webSocket;
    });

    $scope.instanceList = [];
    $scope.testvar = "test";
    $scope.global = appService.globalConfig;

    if ($stateParams.id > 0) {
    	$scope.showLoader = true;
    	$scope.showLoaderOffer = true;
 	    var hasServer = appService.crudService.read("virtualmachine", $stateParams.id);
        hasServer.then(function (result) {
            $scope.instance = result;
		    $scope.instanceList = result;
		    setTimeout(function() {
			$state.current.data.pageName = result.name;
		    	$state.current.data.id = result.id;
		    }, 1000)

            var str = $scope.instance.cpuUsage;
            if(str!=null){
            var newString = str.replace(/^_+|_+$/g,'');
            var num = parseFloat(newString).toFixed(2);
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

    // Resize Instance

    $scope.resize = function() {
     	 appService.dialogService.openDialog("app/views/cloud/instance/runningresize.jsp", 'sm',  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {
   			  $scope.cancel = function () {
                  $modalInstance.close();
              };
          }]);
     };

    $scope.selectab = function() {
        $scope.templateCategory = 'config';
	    $scope.active = true;
	}

    $scope.networkTab = function() {
    	$scope.templateCategory = 'network';
    }



 // Volume List
$scope.volume = {};
$scope.volume = [];
$scope.list = function () {
       	var instanceId = $stateParams.id;
       	var hasVolume = appService.promiseAjax.httpTokenRequest( appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "volumes/listbyinstancesandvolumetype?instanceid="+instanceId +"&lang=" + appService.localStorageService.cookie.get('language')+"&sortBy=-id");
	        hasVolume.then(function (result) {
	            $scope.volume = result;
	        });
	    };
	    $scope.list();

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

  $scope.isoList = function () {
      var hasisoList = appService.crudService.listAll("iso/list");
      hasisoList.then(function (result) {
              $scope.isoLists = result;
       });
   };
   $scope.isoList();

   $scope.hostList = function () {
	      var hashostList = appService.crudService.listAll("host/list");
	      hashostList.then(function (result) {
				$scope.hostLists = result;
	       });
	   };
	   $scope.hostList();

  $scope.rebootVm = function(size,item) {
  	 appService.dialogService.openDialog("app/views/cloud/instance/reboot.jsp", size,  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {
  		 $scope.item =item;
  		 $scope.vmRestart = function(item) {
  				var event = "VM.REBOOT";
  				var hasVm = appService.crudService.vmUpdate("virtualmachine/handlevmevent", item.uuid, event);
  				hasVm.then(function(result) {
    	    				appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.vmEvents.rebootVm,result.id,$scope.global.sessionValues.id);
  					$state.reload();
  					 $scope.cancel();
  				}).catch(function (result) {
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
	  	 appService.dialogService.openDialog("app/views/cloud/instance/reinstall.jsp", size,  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {
	  		 $scope.item =item;
	  		 $scope.vmRestart = function(item) {
	  				var event = "VM.RESTORE";
	  				var hasVm = appService.crudService.vmUpdate("virtualmachine/handlevmevent", item.uuid, event);
	  				hasVm.then(function(result) {
    	    				appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.vmEvents.reInstallVm,result.id,$scope.global.sessionValues.id);
	  					$state.reload();
	  					 $scope.cancel();
	  				}).catch(function (result) {
	  				  $state.reload();
                                          $scope.cancel();
                           });
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

	  $scope.reDestroyVm = function(size,item) {
              appService.dialogService.openDialog("app/views/cloud/instance/vmdestroy.jsp", size,  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {
                      $scope.item =item;
                      $scope.vmDestroy = function(item) {
                             $scope.actionExpunge = true;
                                     if ($scope.agree.value1) {
                                             var event = "VM.EXPUNGE";
                                             var hasVm = appService.crudService.vmUpdate("virtualmachine/handlevmevent", item.uuid, event);
                                             hasVm.then(function(result) {
    	    				appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.vmEvents.reDestroyVm,result.id,$scope.global.sessionValues.id);
                                                     $scope.cancel();
                                                     window.location.href = "index#/instance/list";
                                                     $state.reload();
                                             }).catch(function (result) {
                                               $state.reload();
                                               $scope.cancel();

                                 });
                             } else {
                                     var event = "VM.DESTROY";
                                     var hasVm = appService.crudService.vmUpdate("virtualmachine/handlevmevent", item.uuid, event);
                                     hasVm.then(function(result) {
    	    				appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.vmEvents.reDestroyVm,result.id,$scope.global.sessionValues.id);
                                     window.location.href = "index#/instance/list";
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
                                             appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.vmEvents.stopVm,result.id,$scope.global.sessionValues.id);
                                                    $state.reload();
                                                    $scope.cancel();
                                             }).catch(function (result) {
                                                    $state.reload();
                                                    $scope.cancel();
                                             });
		  		        } else {
		  		          var event = "VM.STOP";
		                                var hasVm = appService.crudService.vmUpdate("virtualmachine/handlevmevent", item.uuid, event);
		                                hasVm.then(function(result) {
                                             appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.vmEvents.stopVm,result.id,$scope.global.sessionValues.id);
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

		  $scope.recoverVm = function(size,item) {
			  	 appService.dialogService.openDialog("app/views/cloud/instance/recoverVm.jsp", size,  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {
		  		 $scope.item =item;
		  		 $scope.vmRecover= function(item) {
		  					var event = "VM.CREATE";
			  				var hasVm = appService.crudService.vmUpdate("virtualmachine/handlevmevent", item.uuid, event);
			  				hasVm.then(function(result) {
                                             appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.vmEvents.recoverVm,result.id,$scope.global.sessionValues.id);
			  					$state.reload();
			  					 $scope.cancel();
			  				}).catch(function (result) {
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
				   var hasVms = appService.crudService.updates("virtualmachine/console", vm);
				   hasVms.then(function(result) {
					   var consoleUrl = result.success;
					   window.open($sce.trustAsResourceUrl(consoleUrl), vm.name + vm.id,'width=750,height=460');
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
	  			 		var hasVm = appService.crudService.update("virtualmachine", $scope.vm);
		  				hasVm.then(function(result) {
                                             appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.vmEvents.updateDisplayName,result.id,$scope.global.sessionValues.id);
		  					appService.notify({message: "Updated successfully", classes: 'alert-success', "timeOut": "5000", templateUrl: $scope.homerTemplate});
		  					$state.reload();
		  					 $scope.cancel();
		  				});
	  			 	}
	  		 };

			  $scope.showDescription = function(vm) {
			                 $scope.instance = vm;
				  	 appService.dialogService.openDialog("app/views/cloud/instance/editnote.jsp", 'sm',  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {

				  		 $scope.update= function(form) {
				  		                        $scope.vm = $scope.instance;
					  				var hasVm = appService.crudService.update("virtualmachine", $scope.vm);
					  				hasVm.then(function(result) {
                                             appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.vmEvents.showDescription,result.id,$scope.global.sessionValues.id);
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
					  	 appService.dialogService.openDialog("app/views/cloud/instance/attach-ISO.jsp", 'md',  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {
					  		var tempVm = vm;
					  		 var event = "ISO.ATTACH";
					  		 $scope.attachISotoVM = function(form) {
					  			$scope.formSubmitted =true;
					  			 if(form.$valid) {
					  				tempVm.iso = $scope.isos.uuid;
					  				tempVm.event = event;

						  				var hasVm = appService.crudService.updates("virtualmachine/handleevent/vm", tempVm);
						  				hasVm.then(function(result) {
                                             appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.vmEvents.attachISO,result.id,$scope.global.sessionValues.id);
						  					$scope.homerTemplate = 'app/views/notification/notify.jsp';
						                     appService.notify({message: $scope.isos.name+" is attaching to this VM", classes: 'alert-success', "timeOut": "5000", templateUrl: $scope.homerTemplate});
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
					  $scope.detachISO = function(vm) {
						  	 appService.dialogService.openDialog("app/views/cloud/instance/detach-ISO.jsp", 'md',  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {
						  		 $scope.vm = vm;
						  		 var event = "ISO.DETACH";
						  		 $scope.update = function() {
						  			$scope.vm.event = event;
						  			console.log($scope.vm);
							  				var hasVm = appService.crudService.updates("virtualmachine/handleevent/vm", $scope.vm);
							  				hasVm.then(function(result) {
                                             appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.vmEvents.detachISO,result.id,$scope.global.sessionValues.id);
							  					$scope.homerTemplate = 'app/views/notification/notify.jsp';
							                     appService.notify({message: $scope.vm.isoName+" is detaching from this VM", classes: 'alert-success', "timeOut": "5000", templateUrl: $scope.homerTemplate});
							  					$state.reload();
							  					$scope.cancel();
							  				}).catch(function (result) {
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
							  	 appService.dialogService.openDialog("app/views/cloud/instance/createVmSnapshot.jsp", 'md',  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance, $rootScope) {
							  		 $scope.instance = vm;
							  		 $scope.validateVMSnapshot= function(form) {
								  			$scope.formSubmitted = true;
						                    if (form.$valid) {
						                    	$scope.vmsnapshot.domainId = $scope.instance.domainId;
						                    	$scope.vmsnapshot.vmId = $scope.instance.id;
						                    	if (angular.isUndefined($scope.vmsnapshot.snapshotMemory) || $scope.vmsnapshot.snapshotMemory === null || $scope.vmsnapshot.snapshotMemory === '') {
						                    	$scope.vmsnapshot.snapshotMemory = false;
						                    	}
								  				var hasVm = appService.crudService.add("vmsnapshot",$scope.vmsnapshot);
								  				hasVm.then(function(result) {
                                             appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.vmEvents.takeSnapshot,result.id,$scope.global.sessionValues.id);
								  					$scope.homerTemplate = 'app/views/notification/notify.jsp';
								                     appService.notify({message: $scope.vmsnapshot.name+" is creating for "+$scope.instance.name, classes: 'alert-success', "timeOut": "5000", templateUrl: $scope.homerTemplate});
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

						$scope.hostMigrate = function(vm) {
								  	 appService.dialogService.openDialog("app/views/cloud/instance/host-migrate.jsp", 'md',  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {
								  		var vms = vm;
								  		 var event = "VM.MIGRATE";
								  		 $scope.update= function(form) {
								  			vms.event = event;
								  			$scope.formSubmitted = true;
						                    if (form.$valid) {
						                    	vms.hostUuid = $scope.host.uuid;
									  				var hasVm = appService.crudService.updates("virtualmachine/handleevent/vm", vms);
									  				hasVm.then(function(result) {
                                             appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.vmEvents.hostMigrate,result.id,$scope.global.sessionValues.id);
									  					$scope.homerTemplate = 'app/views/notification/notify.jsp';
									                    appService.notify({message: $scope.host.name+" is migrating", classes: 'alert-success', "timeOut": "5000", templateUrl: $scope.homerTemplate});
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


						$scope.hostInformation = function(vm) {

								  	 appService.dialogService.openDialog("app/views/cloud/instance/listhost.jsp", 'md',  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {

					  $scope.cancel = function () {
					        $modalInstance.close();
					    };

								       }]);
								  };
					  $scope.showPassword = function(vm) {
						  var hasInstance = appService.promiseAjax.httpTokenRequest(appService.crudService.globalConfig.HTTP_GET, appService.crudService.globalConfig.APP_URL + "virtualmachine"+"/getvncpassword/"+vm.id);
						  hasInstance.then(function (result) {
                                             appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.vmEvents.showPassword,result.id,$scope.global.sessionValues.id);
		        				$scope.instance = result;
		        				console.log($scope.instanceList);
		        				appService.dialogService.openDialog("app/views/cloud/instance/show-reset-password.jsp", 'md',  $scope, ['$scope', '$modalInstance','$rootScope', function ($scope, $modalInstance , $rootScope) {
								    $scope.cancel = function () {
								        $modalInstance.close();
									};
								}]);
		        			});
						};

						$scope.resetPassword= function(vm) {
							var event = "VM.RESETPASSWORD";
			  			 	$scope.vm = vm;
			  			 	$scope.vm.event = event;
			  			 	$scope.vm.password = "reset";
				  			$scope.formSubmitted = true;

			  				var hasVm = appService.crudService.updates("virtualmachine/handleevent/vm", $scope.vm);
			  				hasVm.then(function(result) {
                                             appService.webSocket.prepForBroadcast(appService.globalConfig.webSocketEvents.vmEvents.resetPassword,result.id,$scope.global.sessionValues.id);
			  					appService.notify({message: "VM password updated successfully. Please refresh and click show password", classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
			  					$state.reload();
			  					$scope.cancel();
			  				}).catch(function (result) {
			  				  //$state.reload();

		                    });
			  		     };

    $scope.templateCategory = 'dashboard';
    var instanceViewTab = appService.localStorageService.get("instanceViewTab");
    if (!angular.isUndefined(instanceViewTab) && instanceViewTab != null) {
        $scope.templateCategory = instanceViewTab;
        appService.localStorageService.set("instanceViewTab", 'dashboard');
    }

    $scope.reloadMonitor = function () {
        appService.localStorageService.set("instanceViewTab", 'monitor');
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
