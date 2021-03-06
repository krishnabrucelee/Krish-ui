/**
 *
 * instanceViewCtrl
 *
 */
angular.module('homer').controller('instanceViewCtrl', instanceViewCtrl).controller('instanceDetailsCtrl', instanceDetailsCtrl)

function instanceViewCtrl($scope, $sce, $state, $stateParams, appService, $window) {
    $scope.instanceList = [];
    $scope.testvar = "test";
    $scope.persistinstance = "";
    $scope.global = appService.globalConfig;
    appService.globalConfig.webSocketLoaders.viewLoader = false;
    $scope.formElements = {};
    $scope.osCategory = {
        Linux: "CentOS",
        Windows: "Windows"
    }
    $scope.viewInstances = function(id) {
        if (id == '0') {
            id = $stateParams.id;
        }
        $scope.showLoader = true;
        $scope.showLoaderOffer = true;
        var hasServer = appService.crudService.read("virtualmachine", id);
        hasServer.then(function(result) {
            $scope.instance = result;
            $scope.persistinstance = result;
            setTimeout(function() {
                $state.current.data.pageName = result.name;
                $state.current.data.id = result.id;
            }, 1000)
            var str = $scope.instance.cpuUsage;
            if (str != null) {
                var newString = str.replace(/^_+|_+$/g, '');
                var num = parseFloat(newString).toFixed(2);
                $scope.showLoaderOffer = false;
                $scope.showLoader = false;
                $scope.chart(num);
            } else {
                $scope.showLoaderOffer = false;
                $scope.showLoader = false;
                $scope.chart(0);
            }
            $scope.templateCategory = 'dashboard';
        });
    };
    $scope.viewInstance = function(id) {
        if (id == '0') {
            id = $stateParams.id;
        }
        var hasServer = appService.crudService.read("virtualmachine", id);
        hasServer.then(function(result) {
            $scope.instance = result;
            $scope.persistinstance = result;
            setTimeout(function() {
                $state.current.data.pageName = result.name;
                $state.current.data.id = result.id;
            }, 1000)
            var str = $scope.instance.cpuUsage;
            if (str != null) {
                var newString = str.replace(/^_+|_+$/g, '');
                var num = parseFloat(newString).toFixed(2);
                $scope.chart(num);
            } else {
                $scope.chart(0);
            }
        });
    };
    if ($stateParams.id > 0 && !angular.isUndefined($stateParams.id)) {
        $scope.viewInstances($stateParams.id);
    }
    $scope.vmList = function() {
            var hasServer = appService.crudService.read("virtualmachine", $stateParams.id);
            hasServer.then(function(result) {
                $scope.instance = result;
                $scope.instanceList = result;
            });
        }
        // Resize Instance
    $scope.resize = function() {
        appService.dialogService.openDialog("app/views/cloud/instance/runningresize.jsp", 'sm', $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
            $scope.cancel = function() {
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
    $scope.list = function() {
        var instanceId = $stateParams.id;
        var hasVolume = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "volumes/listbyinstancesandvolumetype?instanceid=" + instanceId + "&lang=" + appService.localStorageService.cookie.get('language') + "&sortBy=-id");
        hasVolume.then(function(result) {
            $scope.volume = result;
        });
        $scope.templateCategory = 'storage';
    };
    $scope.startVm = function(size, item) {
        $scope.hostList();
        $scope.instance = item;
        if ($scope.global.sessionValues.type === 'ROOT_ADMIN') {
            size = 'md';
        } else {
            size = 'sm';
        }
        appService.dialogService.openDialog("app/views/cloud/instance/start.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
            var vms = item;
            var event = "VM.START";
            $scope.update = function(form) {
                    vms.event = event;
                    $scope.formSubmitted = true;
                    if (form.$valid) {
                        if ($scope.instance.host != null) {
                            vms.hostUuid = $scope.instance.host.uuid;
                        }
                        appService.globalConfig.webSocketLoaders.viewLoader = true;
                        var hasVm = appService.crudService.updates("virtualmachine/handleevent/vm", vms);
                        hasVm.then(function(result) {
                            $scope.cancel();
                        }).catch(function(result) {
                            appService.globalConfig.webSocketLoaders.viewLoader = false;
                            $scope.cancel();
                        });
                    }
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };
    $scope.isoList = function() {
        var hasisoList = appService.crudService.listAll("iso/list");
        hasisoList.then(function(result) {
            $scope.isoLists = result;
        });
    };
    $scope.hostList = function() {
        var hashostList = appService.crudService.listAll("host/list");
        hashostList.then(function(result) {
            $scope.hostLists = result;
        });
    };
    $scope.rebootVm = function(size, item) {
        appService.dialogService.openDialog("app/views/cloud/instance/reboot.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
            $scope.item = item;
            $scope.vmRestart = function(item) {
                    var event = "VM.REBOOT";
                    var hasVm = appService.crudService.vmUpdate("virtualmachine/handlevmevent", item.uuid, event);
                    appService.globalConfig.webSocketLoaders.viewLoader = true;
                    hasVm.then(function(result) {
                        $scope.cancel();
                    }).catch(function(result) {
                        $scope.cancel();
                        appService.globalConfig.webSocketLoaders.viewLoader = false;
                    });
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };
    $scope.actionExpunge = false;
    $scope.reInstallVm = function(size, item) {
        appService.dialogService.openDialog("app/views/cloud/instance/reinstall.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
            $scope.item = item;
            $scope.vmRestart = function(item) {
                    var event = "VM.RESTORE";
                    var hasVm = appService.crudService.vmUpdate("virtualmachine/handlevmevent", item.uuid, event);
                    appService.globalConfig.webSocketLoaders.viewLoader = true;
                    hasVm.then(function(result) {
                        $scope.cancel();
                    }).catch(function(result) {
                        $scope.cancel();
                        appService.globalConfig.webSocketLoaders.viewLoader = false;
                    });
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };
    $scope.agree = {
        value1: false,
        value2: true
    };
    $scope.reDestroyVm = function(size, item) {
        appService.dialogService.openDialog("app/views/cloud/instance/vmdestroy.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
            $scope.item = item;
            $scope.vmDestroy = function(item) {
                    $scope.actionExpunge = true;
                    if ($scope.agree.value1) {
                        var event = "VM.EXPUNGE";
                        var hasVm = appService.crudService.vmUpdate("virtualmachine/handlevmevent", item.uuid, event);
                        appService.globalConfig.webSocketLoaders.viewLoader = true;
                        hasVm.then(function(result) {
                            $scope.agree.value1 = false;
                            window.location.href = "index#/instance/list";
                            $scope.cancel();
                        }).catch(function(result) {
                            $scope.cancel();
                            appService.globalConfig.webSocketLoaders.viewLoader = false;
                            $scope.agree.value1 = false;
                        });
                    } else {
                        var event = "VM.DESTROY";
                        appService.globalConfig.webSocketLoaders.viewLoader = true;
                        var hasVm = appService.crudService.vmUpdate("virtualmachine/handlevmevent", item.uuid, event);
                        hasVm.then(function(result) {
                            $scope.agree.value1 = false;
                            window.location.href = "index#/instance/list";
                            $scope.cancel();
                        }).catch(function(result) {
                            $scope.cancel();
                            appService.globalConfig.webSocketLoaders.viewLoader = false;
                            $scope.agree.value1 = false;
                        });
                    }
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };
    $scope.stopVm = function(size, item) {
        $scope.item = item;
        appService.dialogService.openDialog("app/views/cloud/instance/stop.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
            $scope.item = item;
            $scope.vmStop = function(item) {
                    var event = "VM.STOP";
                    $scope.actionExpunge = true;
                    if ($scope.agree.value1) {
                        item.transForcedStop = $scope.agree.value1;
                        item.event = event;
                        appService.globalConfig.webSocketLoaders.viewLoader = true;
                        var hasVm = appService.crudService.updates("virtualmachine/handleevent/vm", item);
                        hasVm.then(function(result) {
                            $scope.cancel();
                            $scope.agree.value1 = false;
                        }).catch(function(result) {
                            $scope.cancel();
                            appService.globalConfig.webSocketLoaders.viewLoader = false;
                            $scope.agree.value1 = false;
                        });
                    } else {
                        var event = "VM.STOP";
                        appService.globalConfig.webSocketLoaders.viewLoader = true;
                        var hasVm = appService.crudService.vmUpdate("virtualmachine/handlevmevent", item.uuid, event);
                        hasVm.then(function(result) {
                            $scope.cancel();
                        }).catch(function(result) {
                            $scope.cancel();
                            appService.globalConfig.webSocketLoaders.viewLoader = false;
                        });
                    }
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };
    $scope.recoverVm = function(size, item) {
        appService.dialogService.openDialog("app/views/cloud/instance/recoverVm.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
            $scope.item = item;
            $scope.vmRecover = function(item) {
                    var event = "VM.CREATE";
                    appService.globalConfig.webSocketLoaders.viewLoader = true;
                    var hasVm = appService.crudService.vmUpdate("virtualmachine/handlevmevent", item.uuid, event);
                    hasVm.then(function(result) {
                        $scope.cancel();
                    }).catch(function(result) {
                        $scope.cancel();
                        appService.globalConfig.webSocketLoaders.viewLoader = false;
                    });
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };
    $scope.showConsole = function(vm) {
        $scope.vm = vm;
        var hasVms = appService.crudService.updates("virtualmachine/console", vm);
        hasVms.then(function(result) {
            var consoleUrl = result.success;
            var consoleUrl = result.success + "&displayname=" + vm.displayName;
            window.open($sce.trustAsResourceUrl(consoleUrl), vm.name + vm.id, 'width=750,height=460');
        });
    }
    $scope.instnaceEdit = false;
    $scope.editDisplayName = function(vm) {
        $scope.vm = vm;
        $scope.instnaceEdit = true;
    }
    $scope.updateDisplayName = function(vm) {
        $scope.formSubmitted = true;
        $scope.vm = vm;
        if ($scope.vm.transDisplayName != "") {
            $scope.vm.transDisplayName = $scope.vm.transDisplayName;
            appService.globalConfig.webSocketLoaders.viewLoader = true;
            var hasVm = appService.crudService.update("virtualmachine", $scope.vm);
            hasVm.then(function(result) {}).catch(function(result) {
                appService.globalConfig.webSocketLoaders.viewLoader = false;
            });
        }
    };
    $scope.showDescription = function(vm) {
        $scope.instance = vm;
        appService.dialogService.openDialog("app/views/cloud/instance/editnote.jsp", 'sm', $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
            $scope.update = function(form) {
                    $scope.vm = $scope.instance;
                    var hasVm = appService.crudService.update("virtualmachine", $scope.vm);
                    hasVm.then(function(result) {
                        $scope.cancel();
                    });
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };
    $scope.attachISO = function(vm) {
        $scope.isoList();
        appService.dialogService.openDialog("app/views/cloud/instance/attach-ISO.jsp", 'md', $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
            var tempVm = vm;
            var event = "ISO.ATTACH";
            $scope.attachISotoVM = function(form) {
                    $scope.formSubmitted = true;
                    if (form.$valid) {
                        $scope.viewLoader = appService.globalConfig.webSocketLoaders.viewLoader;
                        tempVm.iso = $scope.isos.uuid;
                        tempVm.event = event;
                        appService.globalConfig.webSocketLoaders.viewLoader = true;
                        var hasVm = appService.crudService.updates("virtualmachine/handleevent/vm", tempVm);
                        hasVm.then(function(result) {
                            $scope.cancel();
                        }).catch(function(result) {
                            appService.globalConfig.webSocketLoaders.viewLoader = false;
                            $scope.cancel();
                        });
                    }
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
        $scope.viewLoader = $scope.global.webSocketLoaders.viewLoader;
    };
    $scope.detachISO = function(vm) {
        appService.dialogService.openDialog("app/views/cloud/instance/detach-ISO.jsp", 'sm', $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
            $scope.vm = vm;
            var event = "ISO.DETACH";
            $scope.update = function() {
                    $scope.vm.event = event;
                    appService.globalConfig.webSocketLoaders.viewLoader = true;
                    var hasVm = appService.crudService.updates("virtualmachine/handleevent/vm", $scope.vm);
                    hasVm.then(function(result) {
                        $scope.cancel();
                    }).catch(function(result) {
                        $scope.cancel();
                        appService.globalConfig.webSocketLoaders.viewLoader = false;
                    });
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };
    $scope.takeSnapshot = function(vm) {
        appService.dialogService.openDialog("app/views/cloud/instance/createVmSnapshot.jsp", 'md', $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
            $scope.instance = vm;
            $scope.validateVMSnapshot = function(form) {
                    $scope.formSubmitted = true;
                    if (form.$valid) {
                        $scope.showLoader = true;
                        $scope.vmsnapshot.domainId = $scope.instance.domainId;
                        $scope.vmsnapshot.vmId = $scope.instance.id;
                        if (angular.isUndefined($scope.vmsnapshot.snapshotMemory) || $scope.vmsnapshot.snapshotMemory === null || $scope.vmsnapshot.snapshotMemory === '') {
                            $scope.vmsnapshot.snapshotMemory = false;
                        }
                        appService.globalConfig.webSocketLoaders.viewLoader = true;
                        var hasVm = appService.crudService.add("vmsnapshot", $scope.vmsnapshot);
                        hasVm.then(function(result) {
                            $modalInstance.close();
                            window.location.href = "index#/snapshot/list";
                            $scope.showLoader = false;
                        }).catch(function(result) {
                            $scope.showLoader = false;
                            $scope.cancel();
                            appService.globalConfig.webSocketLoaders.viewLoader = false;
                        });
                    }
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };
    $scope.hostMigrate = function(vm) {
        $scope.hostList();
        appService.dialogService.openDialog("app/views/cloud/instance/host-migrate.jsp", 'md', $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
            var vms = vm;
            var event = "VM.MIGRATE";
            $scope.update = function(form) {
                    vms.event = event;
                    $scope.formSubmitted = true;
                    if (form.$valid) {
                        vms.hostUuid = $scope.host.uuid;
                        appService.globalConfig.webSocketLoaders.viewLoader = true;
                        var hasVm = appService.crudService.updates("virtualmachine/handleevent/vm", vms);
                        hasVm.then(function(result) {
                            $scope.cancel();
                        }).catch(function(result) {
                            $scope.cancel();
                            appService.globalConfig.webSocketLoaders.viewLoader = false;
                        });
                    }
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };

    $scope.domain = {};
    var hasDomains = appService.crudService.listAll("domains/list");
    hasDomains.then(function (result) {
    	$scope.domainList = result;
    });

    $scope.departmentList = {};
    $scope.getDepartmentList = function (domainId) {
    	if (!angular.isUndefined(domainId)) {
	    	var domain = {};
	        domain.id = domainId;
	        var hasDepartments = appService.crudService.listAllByFilter("departments/search", domain);
	        hasDepartments.then(function (result) {
	            $scope.departmentList = result;
	        });
    	} else {
    		$scope.departmentList = {};
    	}
    };

    if ($scope.global.sessionValues.type == "DOMAIN_ADMIN") {
        $scope.getDepartmentList($scope.global.sessionValues.domainId);
    }

    $scope.vmMigrate = function(vm) {
        appService.dialogService.openDialog("app/views/cloud/instance/vm-migrate.jsp", 'md', $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
            var vms = angular.copy(vm);
            var event = "VM.ASSIGN";
            $scope.update = function(form) {
                    vms.event = event;
                    $scope.formSubmitted = true;
                    if (form.$valid) {
                    	vms.domain = $scope.department.domain;
                    	vms.domainId = $scope.department.domain.id;
                    	vms.department = $scope.department;
                    	vms.departmentId = $scope.department.id;
                        appService.globalConfig.webSocketLoaders.viewLoader = true;
                        var hasVm = appService.crudService.updates("virtualmachine/handleevent/vm", vms);
                        hasVm.then(function(result) {
                            $scope.cancel();
                        }).catch(function(result) {
                            $scope.cancel();
                            appService.globalConfig.webSocketLoaders.viewLoader = false;
                        });
                    }
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };

    $scope.hostInformation = function(vm) {
        appService.dialogService.openDialog("app/views/cloud/instance/listhost.jsp", 'md', $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
            $scope.cancel = function() {
                $modalInstance.close();
            };
        }]);
    };
    $scope.showPassword = function(vm) {
        var hasInstance = appService.promiseAjax.httpTokenRequest(appService.crudService.globalConfig.HTTP_GET, appService.crudService.globalConfig.APP_URL + "virtualmachine" + "/getvncpassword/" + vm.id);
        hasInstance.then(function(result) {
            $scope.instance = result;
            appService.dialogService.openDialog("app/views/cloud/instance/show-reset-password.jsp", 'md', $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
                $scope.cancel = function() {
                    $modalInstance.close();
                };
            }]);
        });
    };
    $scope.resetPassword = function(size, vm) {
        $scope.instance = vm;
        appService.dialogService.openDialog("app/views/cloud/instance/reset-password.jsp", size, $scope, ['$scope', '$modalInstance', '$rootScope', function($scope, $modalInstance, $rootScope) {
            $scope.reset = function(vm) {
                $scope.cancel();
                var event = "VM.RESETPASSWORD";
                $scope.vm = vm;
                $scope.vm.event = event;
                $scope.vm.password = "reset";
                $scope.formSubmitted = true;
                appService.globalConfig.webSocketLoaders.viewLoader = true;
                var hasVm = appService.crudService.updates("virtualmachine/handleevent/vm", $scope.vm);
                hasVm.then(function(result) {
                    $scope.cancel();
                }).catch(function(result) {
                    appService.globalConfig.webSocketLoaders.viewLoader = false;
                });
            }
            $scope.cancel = function() {
                $modalInstance.close();
            };
        }]);
    }
    $scope.templateCategory = 'dashboard';
    var instanceViewTab = appService.localStorageService.get("instanceViewTab");
    if (!angular.isUndefined(instanceViewTab) && instanceViewTab != null) {
        $scope.templateCategory = instanceViewTab;
        appService.localStorageService.set("instanceViewTab", 'dashboard');
    }
    $scope.reloadMonitor = function() {
            appService.localStorageService.set("instanceViewTab", 'monitor');
        }
        /**
         * Data for Line chart
         */
    $scope.lineData = {
        labels: ["10.00", "10.05", "10.10", "10.15", "10.20", "10.25", "10.30"],
        datasets: [{
            label: "vCpu %",
            fillColor: "#E56919",
            strokeColor: "#E56919",
            pointColor: "#E56919",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(220,220,220,1)",
            data: [52, 44, 37, 43, 46, 45, 32]
        }, {
            label: "Memory %",
            fillColor: "#16658D",
            strokeColor: "#16658D",
            pointColor: "#16658D",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(26,179,148,1)",
            data: [37, 39, 29, 36, 32, 23, 28]
        }, {
            label: "N/W: kB/s",
            fillColor: "#7208A8",
            strokeColor: "#7208A8",
            pointColor: "#7208A8",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(26,179,148,1)",
            data: [26, 32, 22, 26, 25, 22, 18]
        }, {
            label: "Disk: Bytes/Sec",
            fillColor: "rgba(98,203,49,0.5)",
            strokeColor: "rgba(98,203,49,0.7)",
            pointColor: "rgba(98,203,49,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(26,179,148,1)",
            data: [12, 22, 18, 16, 20, 19, 9]
        }]
    };
    $scope.instanceElements = {
        actions: [{
            id: 1,
            name: 'Hours'
        }, {
            id: 2,
            name: 'Days'
        }, {
            id: 3,
            name: 'Weeks'
        }, {
            id: 4,
            name: 'Month'
        }]
    };
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
    $scope.chart = function(used) {
            var available = parseFloat(100 - used).toFixed(2);
            var instanceLimit = {
                "title": "Instance",
                "options": [{
                    value: parseFloat(available),
                    color: "#d6ebf5",
                    highlight: "#57b32c",
                    label: "Available",
                    showLabels: "true",
                }, {
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
                legend: true
            };
        }
        //$scope.viewLoader = appService.globalConfig.webSocketLoaders.viewLoader;
    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.startVm, function(event, args) {
	if(args.status == 'FAILED' && $scope.persistinstance.uuid === args.resourceUuid){
	    $scope.global.webSocketLoaders.viewLoader = false;
	    if (!angular.isUndefined($stateParams.id) && $stateParams.id > 0) {
                $scope.viewInstance($stateParams.id);
            }
	}
        if ($scope.persistinstance.uuid === args.resourceUuid) {
            $scope.global.webSocketLoaders.viewLoader = false;
            if (!angular.isUndefined($stateParams.id) && $stateParams.id > 0) {
                $scope.viewInstance($stateParams.id);
            }
        }
    });
    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.stopVm, function(event, args) {
	if(args.status == 'FAILED' && $scope.persistinstance.uuid === args.resourceUuid){
	    $scope.global.webSocketLoaders.viewLoader = false;
	    if (!angular.isUndefined($stateParams.id) && $stateParams.id > 0) {
                $scope.viewInstance($stateParams.id);
            }
	}
        if ($scope.persistinstance.uuid === args.resourceUuid) {
            $scope.global.webSocketLoaders.viewLoader = false;
            if (!angular.isUndefined($stateParams.id) && $stateParams.id > 0) {
                $scope.viewInstance($stateParams.id);
            }
        }
    });
    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.rebootVm, function(event, args) {
	if(args.status == 'FAILED' && $scope.persistinstance.uuid === args.resourceUuid){
	    $scope.global.webSocketLoaders.viewLoader = false;
	    if (!angular.isUndefined($stateParams.id) && $stateParams.id > 0) {
                $scope.viewInstance($stateParams.id);
            }
	}
        if ($scope.persistinstance.uuid === args.resourceUuid) {
            $scope.global.webSocketLoaders.viewLoader = false;
            if (!angular.isUndefined($stateParams.id) && $stateParams.id > 0) {
                $scope.viewInstance($stateParams.id);
            }
        }
    });
    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.reInstallVm, function(event, args) {
        if(args.status == 'FAILED' && $scope.persistinstance.uuid === args.resourceUuid){
	    $scope.global.webSocketLoaders.viewLoader = false;
	    if (!angular.isUndefined($stateParams.id) && $stateParams.id > 0) {
                $scope.viewInstance($stateParams.id);
            }
	}
        if ($scope.persistinstance.uuid === args.resourceUuid) {
            if (!angular.isUndefined($stateParams.id) && $stateParams.id > 0) {
                $scope.viewInstance($stateParams.id);
            }
            $scope.global.webSocketLoaders.viewLoader = false;
        }
    });
    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.reDestroyVm, function(event, args) {
	if(args.status == 'FAILED' && $scope.persistinstance.uuid === args.resourceUuid){
	    $scope.global.webSocketLoaders.viewLoader = false;
	    if (!angular.isUndefined($stateParams.id) && $stateParams.id > 0) {
                $scope.viewInstance($stateParams.id);
            }
	}
        if ($scope.persistinstance.uuid === args.resourceUuid) {
            $scope.global.webSocketLoaders.viewLoader = false;
            if (!angular.isUndefined($stateParams.id) && $stateParams.id > 0) {
                $scope.viewInstance($stateParams.id);
            }
        }
    });
    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.expungeVM, function(event, args) {
        if(args.status == 'FAILED' && $scope.persistinstance.uuid === args.resourceUuid){
	    $scope.global.webSocketLoaders.viewLoader = false;
	    if (!angular.isUndefined($stateParams.id) && $stateParams.id > 0) {
                $scope.viewInstance($stateParams.id);
            }
	}
        if ($scope.persistinstance.uuid === args.resourceUuid) {
            $scope.global.webSocketLoaders.viewLoader = false;
            if (!angular.isUndefined($stateParams.id) && $stateParams.id > 0) {
                $scope.viewInstance($stateParams.id);
            }
        }
    });
    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.recoverVm, function(event, args) {
        if(args.status == 'FAILED' && $scope.persistinstance.uuid === args.resourceUuid){
	    $scope.global.webSocketLoaders.viewLoader = false;
	    if (!angular.isUndefined($stateParams.id) && $stateParams.id > 0) {
                $scope.viewInstance($stateParams.id);
            }
	}
        if ($scope.persistinstance.uuid === args.resourceUuid) {
            if (!angular.isUndefined($stateParams.id) && $stateParams.id > 0) {
                $scope.viewInstance($stateParams.id);
            }
            $scope.global.webSocketLoaders.viewLoader = false;
        }
    });
    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.attachISO, function(event, args) {
        if(args.status == 'FAILED'){
	    $scope.global.webSocketLoaders.viewLoader = false;
	}
            $scope.global.webSocketLoaders.viewLoader = false;
            if (!angular.isUndefined($stateParams.id) && $stateParams.id > 0) {
                $scope.viewInstance($stateParams.id);
            }
    });
    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.detachISO, function(event, args) {
        if(args.status == 'FAILED'){
	    $scope.global.webSocketLoaders.viewLoader = false;
	}
            $scope.global.webSocketLoaders.viewLoader = false;
            if (!angular.isUndefined($stateParams.id) && $stateParams.id > 0) {
                $scope.viewInstance($stateParams.id);
            }
    });
    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.takeSnapshot, function(event, args) {
        if(args.status == 'FAILED' && $scope.persistinstance.uuid === args.resourceUuid){
	    $scope.global.webSocketLoaders.viewLoader = false;
	    if (!angular.isUndefined($stateParams.id) && $stateParams.id > 0) {
                $scope.viewInstance($stateParams.id);
            }
	}
        if ($scope.persistinstance.uuid === args.resourceUuid) {
            $scope.global.webSocketLoaders.viewLoader = false;
            if (!angular.isUndefined($stateParams.id) && $stateParams.id > 0) {
                $scope.viewInstance($stateParams.id);
            }
        }
    });
    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.hostMigrate, function(event, args) {
        if(args.status == 'FAILED' && $scope.persistinstance.uuid === args.resourceUuid){
	    $scope.global.webSocketLoaders.viewLoader = false;
	    if (!angular.isUndefined($stateParams.id) && $stateParams.id > 0) {
                $scope.viewInstance($stateParams.id);
            }
	}
        if ($scope.persistinstance.uuid === args.resourceUuid) {
            $scope.global.webSocketLoaders.viewLoader = false;
            if (!angular.isUndefined($stateParams.id) && $stateParams.id > 0) {
                $scope.viewInstance($stateParams.id);
            }
        }
    });
    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.resetPassword, function(event, args) {
        if(args.status == 'FAILED' && $scope.persistinstance.uuid === args.resourceUuid){
	    $scope.global.webSocketLoaders.viewLoader = false;
	    if (!angular.isUndefined($stateParams.id) && $stateParams.id > 0) {
                $scope.viewInstance($stateParams.id);
            }
	}
        if ($scope.persistinstance.uuid === args.resourceUuid && args.status === 'SUCCEEDED') {
            $scope.global.webSocketLoaders.viewLoader = false;
            if (!angular.isUndefined($stateParams.id) && $stateParams.id > 0) {
                $scope.viewInstance($stateParams.id);
            }
        }
    });
    $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.updateVM, function(event, args) {
            if(args.status == 'FAILED' && $scope.persistinstance.uuid === args.resourceUuid){
	    $scope.global.webSocketLoaders.viewLoader = false;
	    if (!angular.isUndefined($stateParams.id) && $stateParams.id > 0) {
                $scope.viewInstance($stateParams.id);
            }
	    }
            if ($scope.persistinstance.uuid === args.resourceUuid) {
                $scope.global.webSocketLoaders.viewLoader = false;
                if (!angular.isUndefined($stateParams.id) && $stateParams.id > 0) {
                    $scope.viewInstance($stateParams.id);
                }
                $scope.instnaceEdit = false;
            }
        }); $scope.$on("VirtualMachine", function(event, args) {
            if(args.status == 'FAILED' && $scope.persistinstance.uuid === args.resourceUuid){
	    $scope.global.webSocketLoaders.viewLoader = false;
	    if (!angular.isUndefined($stateParams.id) && $stateParams.id > 0) {
                $scope.viewInstance($stateParams.id);
            }
	    }
            if ($scope.persistinstance.uuid === args.resourceUuid) {
                $scope.global.webSocketLoaders.viewLoader = false;
                if (!angular.isUndefined($stateParams.id) && $stateParams.id > 0) {
                    $scope.viewInstance($stateParams.id);
                }
            }
        });
        $scope.$on(appService.globalConfig.webSocketEvents.vmEvents.moveVm, function(event, args) {
            if(args.status == 'FAILED' && $scope.persistinstance.uuid === args.resourceUuid){
	    	    $scope.global.webSocketLoaders.viewLoader = false;
	    	    if (!angular.isUndefined($stateParams.id) && $stateParams.id > 0) {
                    $scope.viewInstance($stateParams.id);
                }
    	    }
            if ($scope.persistinstance.uuid === args.resourceUuid) {
                $scope.global.webSocketLoaders.viewLoader = false;
                if (!angular.isUndefined($stateParams.id) && $stateParams.id > 0) {
                    $scope.viewInstance($stateParams.id);
                }
            }
        });

    }

    function instanceDetailsCtrl($scope, $log, $sce, dialogService, $modal, $http, $state, $stateParams, promiseAjax, localStorageService, globalConfig, crudService, notify, $window) {
        $scope.instanceList = [];
        $scope.testvar = "test";
        $scope.global = crudService.globalConfig;
        if ($stateParams.id > 0) {
            $scope.showLoader = true;
            $scope.showLoaderOffer = true;
            var hasServer = crudService.read("virtualmachine", $stateParams.id);
            hasServer.then(function(result) { // this is only run after $http                                                                                       // completes
                $scope.instance = result;
                $scope.instanceList = result;
                var str = $scope.instance.cpuUsage;
                if (str != null) {
                    var newString = str.replace(/^_+|_+$/g, '');
                    var num = parseFloat(newString).toFixed(2);
                    $state.current.data.pageName = result.name;
                    $scope.showLoaderOffer = false;
                    $scope.showLoader = false;
                    $scope.chart(num);
                } else {
                    $scope.showLoaderOffer = false;
                    $scope.showLoader = false;
                    $scope.chart(0);
                }
            });
        }
    };
