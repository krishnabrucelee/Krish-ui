/**
 *
 * instanceCtrl
 *
 */
angular
    .module('homer')
    .controller('instanceCtrl', instanceCtrl)

function instanceCtrl($scope, $modalInstance, $state, $stateParams, filterFilter, appService, $window, sweetAlert) {

    $scope.customdiskSize = function(input) {

        if (input === undefined || input === null) {
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            appService.notify({
                message: 'The value must be between 1 to 1024 ',
                classes: 'alert-danger',
                templateUrl: $scope.homerTemplate
            });
        }

    }

    $scope.customMemory = function(input) {

        if (input === undefined || input === null) {
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            appService.notify({
                message: 'The value must be between 512 to 4096 ',
                classes: 'alert-danger',
                templateUrl: $scope.homerTemplate
            });
        }

    }

    $scope.customCpuSpeed = function(input) {
        if (input === undefined || input === null) {
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            appService.notify({
                message: 'The value must be between 500 to 3500 ',
                classes: 'alert-danger',
                templateUrl: $scope.homerTemplate
            });
        }

    }

    $scope.customCpuCore = function(input) {

        if (input === undefined || input === null) {
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            appService.notify({
                message: 'The value must be between 1 to 32 ',
                classes: 'alert-danger',
                templateUrl: $scope.homerTemplate
            });
        }

    }
    $scope.global = appService.globalConfig;
    $scope.instanceList = [];
    $scope.formElements = [];
    $scope.instanceForm = [];
    $scope.instanceElements = {};
    $scope.instance = {};
    $scope.instance.networks = {};
    $scope.instance.networks.vpcList = [];
    $scope.paginationObject = {};
    $scope.templateCategories = {};
    $scope.templateVM = {};
    $scope.template = {
        templateList: {}
    };
    $scope.paginationObject.sortOrder = '+';
    $scope.paginationObject.sortBy = 'name';
    $scope.templateCategories = appService.localStorageService.get("view");
    $scope.templateVM = appService.localStorageService.get("selectedTemplate");
    if (!angular.isUndefined($scope.templateVM) && $scope.templateVM != null && $scope.templateVM.$valid) {
        $scope.instance.template = $scope.templateVM;
    }
    $scope.networkVM = appService.localStorageService.get("selectedNetwork");
    console.log($scope.networkVM);
    if (!angular.isUndefined($scope.networkVM) && $scope.networkVM != null) {
        console.log($scope.networkVM);
        var hasNetwork = appService.promiseAjax.httpTokenRequest( appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "guestnetwork/"+$scope.networkVM );
        hasNetwork.then(function(result) { // this is only run after $http
            $scope.instance.networkUuid = result.uuid;
            $scope.instance.network = result;
            appService.localStorageService.set("selectedNetwork", null);
        });
    }
    $scope.instance.networkOfferinglist = {};
    $scope.instance.networkOfferinglist.value = 'all';

    // Form Field Declaration
    $scope.instance.computeOffer = $scope.global.instanceCustomPlan.computeOffer;
    $scope.instance.diskOffer = $scope.global.instanceCustomPlan.diskOffer;
    $scope.instance.networks = $scope.global.instanceCustomPlan.networks;

    $scope.instance.bit64 = true;

    var hasDomains = appService.crudService.listAll("domains/list");
    hasDomains.then(function(result) { // this is only run after $http completes0
        $scope.formElements.domainList = result;
    });

    if ($scope.global.sessionValues.type === 'DOMAIN_ADMIN') {
        if (!angular.isUndefined($scope.global.sessionValues.domainId)) {
            var hasDomain = appService.crudService.read("domains", $scope.global.sessionValues.domainId);
            hasDomain.then(function(result) {
                $scope.departmentList(result);
            });
        }
    }

    $scope.osList = function() {
        var hasOsList = appService.crudService.listAll("oscategorys/list");
        hasOsList.then(function(result) { // this is only run after $http completes0
            $scope.formElements.osCategoryList = result;
        });
    };
    $scope.osList();

    //Template list by filter
    $scope.osListByFilter = function() {
        $scope.showLoader = true;
        var hasOsListByFilter = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "oscategorys/os?type=template");
        hasOsListByFilter.then(function(result) {
            $scope.showLoader = false;
            $scope.formElements.osCategoryListByFilter = result;
        });
    };
    $scope.osListByFilter();

    //ISO template list by filter
    $scope.osListByFilterIso = function() {
        $scope.showLoader = true;
        var hasOsListByFilterIso = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "oscategorys/os?type=iso");
        hasOsListByFilterIso.then(function(result) {
            $scope.showLoader = false;
            $scope.formElements.osCategoryListByFilter = result;
        });
    };

    $scope.templateList = function() {
        $scope.showLoader = true;
        var hastemplateList = appService.crudService.listAll("templates/list");
        hastemplateList.then(function(result) { // this is only run after $http completes0
            $scope.formElements.templateList = result;
            angular.forEach($scope.formElements.templateList, function(obj, key) {
                if (!angular.isUndefined(appService.localStorageService.get("selectedTemplate")) && appService.localStorageService.get("selectedTemplate") != null) {
                    if (obj.id == appService.localStorageService.get("selectedTemplate").id) {

                        $scope.instance.template = appService.localStorageService.get("selectedTemplate");
                        appService.localStorageService.set("selectedTemplate", {});
                        $scope.templateCategory = appService.localStorageService.get("view");
                        appService.localStorageService.set("view", "");
                    }
                }
            });
            $scope.showLoader = false;
        });
    };
    $scope.templateList();

    // Hypervisors list from server
    $scope.hypervisorList = function() {
        appService.globalConfig.sort.sortOrder = $scope.paginationObject.sortOrder;
        appService.globalConfig.sort.sortBy = $scope.paginationObject.sortBy;
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hashypervisorList = appService.crudService.list("hypervisors", $scope.global.paginationHeaders(1, limit), {
            "limit": limit
        });
        hashypervisorList.then(function(result) {
            $scope.formElements.hypervisorList = result;
        });
    };
    $scope.hypervisorList();

    $scope.getTemplatesByFilters = function() {
        var templateList = [];
        $scope.showLoader = true;
        var template = {};
        template.osCategory = $scope.instance.osCategory;
        if (!angular.isUndefined(template.osCategory) && template.osCategory != null) {
            template.osCategoryId = template.osCategory.id;
            delete template.osCategory;
        }
        template.architecture = $scope.instance.architecture;
        template.osVersion = $scope.instance.osVersion;
        var hastemplateList = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_POST, appService.globalConfig.APP_URL + "templates/searchtemplate?lang=" + appService.localStorageService.cookie.get('language'), '', template);

        hastemplateList.then(function(result) {
            $scope.formElements.templateList = result;
            $scope.showLoader = false;
        });
    }
    /*$scope.getTemplatesByFilters();**/

    $scope.getIsoByFilters = function() {
        var templateList = [];
        $scope.showLoader = true;
        var template = {};
        template.osCategory = $scope.instance.osCategory;
        if (!angular.isUndefined(template.osCategory) && template.osCategory != null) {
            template.osCategoryId = template.osCategory.id;
            delete template.osCategory;
        }
        template.architecture = $scope.instance.architecture;
        template.osVersion = $scope.instance.osVersion;
        var hastemplateList = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_POST, appService.globalConfig.APP_URL + "templates/searchiso?lang=" + appService.localStorageService.cookie.get('language'), '', template);

        hastemplateList.then(function(result) {
            $scope.formElements.templateList = result;
            $scope.showLoader = false;
        });
    }

    $scope.templateTypeFilter = function(format) {
        $scope.templateCategory = format;
        if (format == 'iso') {
            $scope.instance.osCategory = null;
            $scope.osListByFilterIso();
            $scope.getIsoByFilters();
        }
        if (format == 'template') {
            $scope.instance.osCategory = null;
            $scope.osListByFilter();
            $scope.getTemplatesByFilters();
        }
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

    $scope.setTemplate = function(item) {
        var hasUsers = appService.crudService.read("templates", item);
        hasUsers.then(function(result) {
            $scope.instance.template = result;
            $scope.instance.template.id = result.id;
        });
    }

    $scope.$watch('instance.template.id', function(obj) {
        if (!angular.isUndefined(obj)) {
            $scope.setTemplate(obj);
        }
    });

    $scope.formElements = {
        departmentList: [{
            id: 1,
            name: 'Developing'
        }, {
            id: 2,
            name: 'Testing'
        }],
        architectureList: [{
            id: 1,
            name: '32'
        }, {
            id: 2,
            name: '64'
        }]
    };

    $scope.compute = false;
    $scope.disk = false;
    $scope.disks = false;
    $scope.computes = false;
    $scope.networks = false;
    var networkArrays = [];
    var networkArray = [];
    $scope.computeFunction = function(item) {
        if (item === true) {
            $scope.compute = true;
            $scope.disk = false;
            $scope.networks = false;
            $scope.computes = true;
        } else {
            $scope.compute = false;
        }
    }
    $scope.computeSlide = function() {
        if (!$scope.compute) {
            $scope.compute = true;
        } else {
            $scope.compute = false;
        }
    }
    $scope.diskSlide = function() {
        if (!$scope.disk) {
            $scope.disk = true;
        } else {
            $scope.disk = false;
        }
    }
    $scope.networkSlide = function() {
        if (!$scope.networks) {
            $scope.networks = true;
        } else {
            $scope.networks = false;
        }
    }

    $scope.diskFunction = function(item) {
        if (item == 'Custom') {
            $scope.disk = true;
            $scope.compute = false;
            $scope.networks = false;
            $scope.disks = true;
        } else {
            $scope.disk = false;
        }
    }

    $scope.networkFunction = function(item) {
        if (item == '') {
            $scope.networks = false;
        } else {
        	if(item == 'all') {
        	        networkArray = [];
        	        $scope.instance.networkc = null;
        	        $scope.instance.networkss = [];
        		$scope.instance.networkOfferinglist.value = item;
        		$scope.instance.networkOfferinglist = $scope.instanceElements.networkOfferingList[0];
        	}
        	if(item == 'new'){
        		$scope.instance.networkOfferinglist.value = item;
        		$scope.instance.networkOfferinglist = $scope.instanceElements.networkOfferingList[2];
        	}
        	if(item == 'vpc'){
                    networkArrays = [];
        	    $scope.instance.networkc = null;
        	    $scope.instance.networkss = [];
                }
            $scope.networks = true;
            $scope.compute = false;
            $scope.disk = false;
        }
        $scope.listNetworkOffer();
    }

    $scope.userList = function(department) {
        $scope.showLoaderDetail = true;
        var hasUsers = appService.crudService.listAllByFilter("users/departmentusers", department);
        hasUsers.then(function(result) { // this is only run after $http completes0
            $scope.formElements.instanceOwnerList = result;
            $scope.showLoaderDetail = false;
        });
    };

    $scope.zoneList = function() {
        var hasZones = appService.crudService.listAll("zones/list");
        hasZones.then(function(result) { // this is only run after $http completes0
            $scope.zoneList = result[0];
            $scope.instance.zoneId = result[0].id;
        });
    };
    $scope.zoneList();

    //Application list by filter
    $scope.applicationList = function() {
        if (!angular.isUndefined($scope.instance.domain)) {
            var hasApplicationList = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "applications/domain?domainId=" + $scope.instance.domain.id);
            hasApplicationList.then(function(result) {
                $scope.formElements.applicationsList = result;
            });
        } else {
            delete $scope.formElements.applicationsList;
            delete $scope.formElements.instanceOwnerList;
            delete $scope.formElements.projecttypeList;
            delete $scope.instance.instanceOwner
            delete $scope.instance.project;
        }
    };

    $scope.applicationsList = {};
    $scope.getApplicationList = function() {
        var hasApplications = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "applications/domain?domainId=" + $scope.global.sessionValues.domainId);
        hasApplications.then(function(result) {
            $scope.applicationsList = result;
        });
    };

    if ($scope.global.sessionValues.type != "ROOT_ADMIN") {
        $scope.getApplicationList();
    }

    $scope.changedomain = function(obj) {
        $scope.applicationList();
        $scope.computeList();
        $scope.instance.department = null;
        $scope.instance.instanceOwner = null;
        $scope.instance.project = null;
        $scope.instance.networks.networkList = {};
        $scope.instance.networks.vpcList = {};
        if (!angular.isUndefined(obj)) {

            $scope.departmentList(obj);
            $scope.formElements.instanceOwnerList = {};
            $scope.formElements.projecttypeList = {};
            $scope.diskOfferingList(obj);
        }
    }

    $scope.depValue = {};
    $scope.changedepartment = function(obj) {
        $scope.depValue = obj.id;
        $scope.instance.instanceOwner = null;
        $scope.instance.project = null;
        $scope.instance.networks.networkList = null;
        $scope.instance.networks.vpcList = null;
        if (!angular.isUndefined(obj)) {
            $scope.userList(obj);
            $scope.listNetworks(obj.id, 'department');
            $scope.formElements.projecttypeList = {};

        }
    };



    $scope.changeinstanceowner = function(obj) {
        $scope.instance.project = null;
        if ($scope.global.sessionValues.type !== 'USER') {
            if (!angular.isUndefined(obj)) {
                $scope.projectList(obj);
            }
        }
    }

    $scope.changeproject = function(obj) {
        $scope.instance.networks.networkList = null;
        $scope.instance.networks.vpcList = null;
        if (!angular.isUndefined(obj)) {
            $scope.listNetworks(obj.id, 'project');
        } else {
    if ($scope.global.sessionValues.type == "USER") {
        $scope.depValue = $scope.global.sessionValues.departmentId;
    }
	 $scope.listNetworks($scope.depValue, 'department');
        }

    };


    $scope.departmentList = function(domain) {

        $scope.showLoaderDetail = true;

        if ($scope.global.sessionValues.type === 'USER') {
            var departments = [];
            var hasDepartments = appService.crudService.read("departments", $scope.global.sessionValues.departmentId);
            hasDepartments.then(function(result) {
                $scope.instance.department = result;
            });
        } else {
            var hasDepartments = appService.crudService.listAllByFilter("departments/search", domain);
            hasDepartments.then(function(result) { // this is only run after $http completes0
                $scope.formElements.departmenttypeList = result;
                $scope.showLoaderDetail = false;
            });
        }
    };

    $scope.diskOfferingList = function(domain) {
        $scope.showLoaderDetail = true;
        var hasDisks = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "storages/listbydomain?domainId=" + domain.id);
        hasDisks.then(function(result) { // this is only run after $http completes0
            $scope.instanceElements.diskOfferingList = result;
            $scope.showLoaderDetail = false;
        });
    };

    $scope.projectList = function(user) {
        $scope.showLoaderDetail = true;
        var hasProjects = appService.crudService.listAllByObject("projects/user", user);
        hasProjects.then(function(result) { // this is only run after $http completes0
            $scope.formElements.projecttypeList = result;
            $scope.showLoaderDetail = false;
        });
    };

    $scope.search = {
        'users': [],
        'departments': [],
        'projects': []
    };
    $scope.sliderTranslate = function(value) {
        return value + " " + this.attributes.rzSliderLabel;
    };

    $scope.instance.networkList = [];
    $scope.deselect = false;
    $scope.stateChanged = function (item) {
        if($scope.instance.networks.networkList[item].vpcId != null) {
            if(angular.isUndefined($scope.instance.networkss[item])) {
                if($scope.deselect) {
                  $scope.instance.networkss[item] = false;
                } else {
                    $scope.instance.networkss[item] = true;
                }
            } else {
                $scope.instance.networkss[item] = true;
                if (networkArray.length > 0) {
                    $scope.instance.networkss[networkArray[0]] = false;
                    networkArray.splice(0, 1);
                    networkArray.push(item);
                 } else {
                    $scope.instance.networkss[item] = true;
                    networkArray.push(item);
                }
                if(!$scope.deselect) {
                 $scope.instance.networkc = $scope.instance.networks.networkList[item].uuid;
                }
            }
        }
    }

    $scope.$watch('instance.networkc', function(obj) {
        if (!angular.isUndefined(obj)) {
            angular.forEach($scope.instance.networks.networkList, function(value, item) {
            if($scope.instance.networks.networkList[item].uuid == obj) {
                if($scope.instance.networks.networkList[item].vpcId == null) {
                    $scope.deselect = true;
                } else {
                    $scope.deselect = false;
                }
            }
          });
        }
    });

    $scope.stateChangedvpc = function (item) {
        if($scope.instance.networks.vpcList[item].vpcId != null) {
            if(angular.isUndefined($scope.instance.networkss[item])) {
                $scope.instance.networkss[item] = true;
            } else {
                if(networkArrays.length > 0){
                 $scope.instance.networkss[networkArrays[0]] = false;
                 networkArrays.splice(0, 1);
                 networkArrays.push(item);
                } else {
                    networkArrays.push(item);
                }
             $scope.instance.networkc = $scope.instance.networks.vpcList[item].uuid;
            }
        }

    }
    $scope.validateOffering = function(form) {
        $scope.OfferingSubmitted = true;
        var submitError = false;
        if (form.networkoffer.$valid && form.computeoffer.$valid) {
            var computeOfferValid = true;
            if ($scope.instance.computeOffering.customized == "true") {
                if ($scope.instance.computeOffer.cpuCore.value != 0 && $scope.instance.computeOffer.memory.value != 0) {
                    $scope.compute = false;
                }
                if ($scope.instance.computeOffering.customizedIops == "true") {
                    if ($scope.instance.computeOffer.minIops.value != 0 && $scope.instance.computeOffer.maxIops.value != 0) {
                        $scope.compute = false;
                    }
                } else {
                    submitError = true;
                    $scope.homerTemplate = 'app/views/notification/notify.jsp';
                    appService.notify({
                        message: 'Select the CPU core and RAM',
                        classes: 'alert-danger',
                        "timeOut": "1000",
                        templateUrl: $scope.homerTemplate
                    });
                    $scope.compute = true;
                    computeOfferValid = false;
                }
            } else {
                $scope.compute = false;
            }
            if (angular.isUndefined($scope.networkVM) || $scope.networkVM == null ) {
            if (form.networkoffer.$valid && !$scope.compute) {
                if ($scope.instance.networkOfferinglist.value == 'new') {
                    if ($scope.instance.networks.name == null) {
                        submitError = true;
                        $scope.networks = true;
                        $scope.disk = false;
                        $scope.homerTemplate = 'app/views/notification/notify.jsp';
                        appService.notify({
                            message: 'Enter network name',
                            classes: 'alert-danger',
                            templateUrl: $scope.homerTemplate
                        });
                    } else {
                        if (angular.isUndefined($scope.instance.networkOffering)) {
                            submitError = true;
                            $scope.networks = true;
                            $scope.disk = false;
                            $scope.homerTemplate = 'app/views/notification/notify.jsp';
                            appService.notify({
                                message: 'Select network offering ',
                                classes: 'alert-danger',
                                templateUrl: $scope.homerTemplate
                            });
                        }
                    }
                }
                var networkSelected = false;
                if ($scope.instance.networkOfferinglist.value == 'all') {
                	var allNetworks = "";
                    for (var i = 0; i < $scope.instance.networks.networkList.length; i++) {
                        if ($scope.instance.networkss[i] == true) {
                            var networks = $scope.instance.networks.networkList[i];
                            var result = $scope.instance.networkc;
                            if (result === networks.uuid) {
                                $scope.instance.networkUuid = networks.uuid;
                                networkSelected = true;
                                submitError = false;
                            } else {
                            	allNetworks = allNetworks +","+ networks.uuid;
                            }
                        }

                    }
                    $scope.instance.networkUuid = $scope.instance.networkUuid + allNetworks;
                    if (!networkSelected && $scope.isEmpty($scope.instance.networkc)) {
                        submitError = true;
                        $scope.networks = true;
                        $scope.disk = false;
                        $scope.homerTemplate = 'app/views/notification/notify.jsp';
                        appService.notify({
                            message: 'Select one default network',
                            classes: 'alert-danger',
                            templateUrl: $scope.homerTemplate
                        });
                    } else if (!networkSelected && !$scope.isEmpty($scope.instance.networkc)) {
                        submitError = true;
                        $scope.networks = true;
                        $scope.disk = false;
                        $scope.homerTemplate = 'app/views/notification/notify.jsp';
                        appService.notify({
                            message: 'Select atleast one network',
                            classes: 'alert-danger',
                            templateUrl: $scope.homerTemplate
                        });
                    }
                }

                if ($scope.instance.networkOfferinglist.value == 'vpc') {
                    var allNetworks = "";
                for (var i = 0; i < $scope.instance.networks.vpcList.length; i++) {
                    if ($scope.instance.networkss[i] == true) {
                        var networks = $scope.instance.networks.vpcList[i];
                        var result = $scope.instance.networkc;
                        if (result === networks.uuid) {
                            $scope.instance.networkUuid = networks.uuid;
                            networkSelected = true;
                            submitError = false;
                        } else {
                            allNetworks = allNetworks +","+ networks.uuid;
                        }
                    }

                }
                $scope.instance.networkUuid = $scope.instance.networkUuid + allNetworks;
                if (!networkSelected && $scope.isEmpty($scope.instance.networkc)) {
                    submitError = true;
                    $scope.networks = true;
                    $scope.disk = false;
                    $scope.homerTemplate = 'app/views/notification/notify.jsp';
                    appService.notify({
                        message: 'Select one default network',
                        classes: 'alert-danger',
                        templateUrl: $scope.homerTemplate
                    });
                } else if (!networkSelected && !$scope.isEmpty($scope.instance.networkc)) {
                    submitError = true;
                    $scope.networks = true;
                    $scope.disk = false;
                    $scope.homerTemplate = 'app/views/notification/notify.jsp';
                    appService.notify({
                        message: 'Select atleast one vpc network',
                        classes: 'alert-danger',
                        templateUrl: $scope.homerTemplate
                    });
                }
            }
            }
            } else {
                networkSelected = true;
                submitError = false;
            }
            if (networkSelected && computeOfferValid) {
                if (!angular.isUndefined($scope.instance.diskOffering)) {
                    if ($scope.instance.diskOffering.name == "Custom") {
                        if ($scope.instance.diskOffer.diskSize.value != 0 && $scope.instance.diskOffer.iops.value != 0) {
                            $scope.disk = false;
                            submitError = false;
                        } else {
                            submitError = true;
                            $scope.homerTemplate = 'app/views/notification/notify.jsp';
                            appService.notify({
                                message: 'Select the disk size and IOPS',
                                classes: 'alert-danger',
                                templateUrl: $scope.homerTemplate
                            });
                            $scope.disk = true;
                            $scope.networks = false;
                            submitError = true;
                        }
                    }
                }
            }
            if (!angular.isUndefined($scope.instance.computeOffer.cpuSpeed.value)) {
                if ($scope.instance.computeOffer.cpuSpeed.value < 500 && $scope.instance.computeOffer.memory.value < 512) {
                    $scope.homerTemplate = 'app/views/notification/notify.jsp';
                    appService.notify({
                        message: 'Please choose valid range for memory or cpu speed',
                        classes: 'alert-danger',
                        templateUrl: $scope.homerTemplate
                    });
                    submitError = true;
                }
            }
            if (!submitError) {
                $scope.submt();
            }
        }
    };
    $scope.isEmpty = function (obj) {
        for (var i in obj) if (obj.hasOwnProperty(i)) return false;
        return true;
    };
    $scope.validateTemplate = function(form) {
        $scope.templateFormSubmitted = true;
        appService.notify.closeAll();
        if ($scope.instance.template == null) {
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            appService.notify({
                message: 'Select the template',
                classes: 'alert-danger',
                templateUrl: $scope.homerTemplate
            });
        } else if (form.$valid && $scope.instance.department != null && $scope.instance.instanceOwner != null) {
            $scope.wizard.next();
        }
    };

    $scope.validateComputeOffer = function(form) {
        $scope.computeOfferFormSubmitted = true;
        if (form.$valid) {
            $scope.wizard.next();
        }
    };

    $scope.submt = function() {
        $scope.showLoader = true;
        $scope.OfferingSubmitted = false;
        if ($scope.global.sessionValues.type !== 'ROOT_ADMIN') {
            if (!angular.isUndefined($scope.global.sessionValues.domainId)) {
                $scope.instance.domainId = $scope.global.sessionValues.domainId;
            }
        }
        var instance = angular.copy($scope.instance);
        if (!angular.isUndefined(instance.project) && instance.project != null) {
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

        if (!angular.isUndefined($scope.instance.storageOffering) && $scope.instance.storageOffering != null) {
            if (instance.storageOffering.isCustomDisk) {
                if (!angular.isUndefined($scope.instance.diskOffer.diskSize.value)) {
                    instance.diskSize = $scope.instance.diskOffer.diskSize.value;
                }
                if (!angular.isUndefined($scope.instance.diskMaxIops)) {
                    instance.diskMaxIops = $scope.instance.diskMaxIops;
                }

                if (!angular.isUndefined($scope.instance.diskMinIops)) {
                    instance.diskMinIops = $scope.diskMinIops;
                }
            }
        } else {
            delete instance.diskSize;
            delete instance.diskMaxIops;
            delete instance.diskMinIops;
        }


        if (!angular.isUndefined($scope.instance.computeOffer.cpuCore.value)) {
            instance.cpuCore = $scope.instance.computeOffer.cpuCore.value;
        }
        if (!angular.isUndefined($scope.instance.computeOffer.cpuSpeed.value)) {
            instance.cpuSpeed = $scope.instance.computeOffer.cpuSpeed.value;
        }

        if (!angular.isUndefined($scope.instance.computeOffer.memory.value)) {
            instance.memory = $scope.instance.computeOffer.memory.value;
        }
        if (!angular.isUndefined($scope.instance.computeOffer.minIops.value)) {
            instance.computeMinIops = $scope.instance.computeOffer.minIops.value;
        }

        if (!angular.isUndefined($scope.instance.computeOffer.maxIops.value)) {
            instance.computeMaxIops = $scope.instance.computeOffer.maxIops.value;
        }
        instance.computeOfferingId = instance.computeOffering.id;
        delete instance.computeOffering;
        if (!angular.isUndefined(instance.storageOffering) && instance.storageOffering !== null) {
            instance.storageOfferingId = instance.storageOffering.id;
            delete instance.storageOffering;
        }
        instance.templateId = instance.template.id;
        delete instance.template;
        if (!angular.isUndefined(instance.hypervisor) && instance.hypervisor !== null) {
            instance.hypervisorId = instance.hypervisor.id;
            delete instance.hypervisor;
        }
        instance.zoneId = $scope.global.zone.id;
        var hasServer = appService.crudService.add("virtualmachine", instance);
        hasServer.then(function(result) { // this is only run after $http completes
            $scope.showLoader = false;
            appService.notify({
                message: "Instance creation started",
                classes: 'alert-success',
                templateUrl: $scope.global.NOTIFICATION_TEMPLATE
            });
            $modalInstance.close();
            $state.reload();
        }).catch(function(result) {
            $scope.showLoader = false;
            if (result.data.fieldErrors !== null && !angular.isUndefined(result.data.fieldErrors[0])) {
                var errorMessages = "";
                angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                    errorMessages += "," + key + ": " + "is incorrect ";
                });
                errorMessages = errorMessages.slice(1, errorMessages.length);
                appService.notify({
                    message: errorMessages,
                    classes: 'alert-danger',
                    templateUrl: $scope.global.NOTIFICATION_TEMPLATE
                });
            }
            $scope.wizard.prev();
        });

    };

    $scope.addnetwork = function() {

        var cidrRegex = /^([0-9]{1,3}\.){3}[0-9]{1,3}($|\/[0-32]{1,2})$/i;
        var networkError = false;
        if ($scope.guestnetwork.name == null) {
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            appService.notify({
                message: 'Enter Network Name',
                classes: 'alert-danger',
                templateUrl: $scope.homerTemplate
            });
            networkError = true;

        } else if ($scope.guestnetwork.networkOffering == null) {
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            appService.notify({
                message: 'Select the Network Offering Type',
                classes: 'alert-danger',
                templateUrl: $scope.homerTemplate
            });
            networkError = true;
        } else {
            $scope.saveNetwork(networkError);
        }
    };

    $scope.someSelected = function(object) {
        return Object.keys(object).some(function(key) {
            object[key];
        });
    }

    $scope.selectedAppClass = {};
    $scope.appClass = [{
        'name': 'Prod.',
        'id': 1
    }, {
        'name': 'QAS',
        'id': 2
    }, {
        'name': 'DEV',
        'id': 3
    }, {
        'name': 'Backup',
        'id': 4
    }, {
        'name': 'DR',
        'id': 5
    }, {
        'name': 'Other',
        'id': 6
    }];

    $scope.cancel = function() {
        $modalInstance.dismiss('cancel');
    };

    $scope.save = function() {
        var instance = $scope.instance;
        var hasServer = appService.crudService.add("virtualmachine", instance);
        hasServer.then(function(result) { // this is only run after $http completes
            appService.notify({
                message: 'instance created successfully',
                classes: 'alert-success',
                templateUrl: $scope.global.NOTIFICATION_TEMPLATE
            });
            $modalInstance.close();


        }).catch(function(result) {
            if (!angular.isUndefined(result.data)) {
                if (result.data.fieldErrors != null) {
                    angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                        $scope.instanceForm[key].$invalid = true;
                        $scope.instanceForm[key].errorMessage = errorMessage;
                    });
                }
            }
        });
    };

    $scope.addNetworkToVM = function() {
        dialogService.openDialog("app/views/cloud/instance/add-network.jsp", 'md', $scope, ['$scope', '$modalInstance', function($scope, $modalInstance) {
            $scope.listNetwork = function() {
                $scope.showLoaderDetail = true;
                var hasGuestNetworks = appService.crudService.findByDepartment("guestnetwork/list");
                hasGuestNetworks.then(function(result) { // this is only run after $http
                    $scope.networkList = result;
                    $scope.showLoaderDetail = false;
                });
            };
            listNetwork();
            $scope.add = function(deleteObject) {
                    if (form.$valid) {
                        $scope.instanceNetworkList = appService.localStorageService.get("instanceNetworkList");

                        $scope.instanceNetwork = {};

                        $scope.networks.plan = $scope.networks.networkOffers.name;

                        $scope.instanceNetwork = filterFilter($scope.networkList.networkOffers, {
                            'name': $scope.networks.plan
                        });
                        if (filterFilter($scope.instanceNetworkList, {
                                'name': $scope.networks.plan
                            })[0] == null) {
                            $scope.instanceNetworkList.push($scope.instanceNetwork[0]);
                            appService.localStorageService.set("instanceNetworkList", $scope.instanceNetworkList);
                            $scope.homerTemplate = 'app/views/notification/notify.jsp';
                            appService.notify({
                                message: 'Added successfully',
                                classes: 'alert-success',
                                templateUrl: $scope.homerTemplate
                            });
                            $scope.cancel();
                        } else {
                            $scope.homerTemplate = 'app/views/notification/notify.jsp';
                            appService.notify({
                                message: 'Network already exist',
                                classes: 'alert-danger',
                                templateUrl: $scope.homerTemplate
                            });
                        }
                        $scope.networkLists = appService.localStorageService.get("instanceNetworkList");
                        appService.localStorageService.set('instanceViewTab', 'network');
                       // $state.reload();
                    }
                },
                $scope.cancel = function() {
                    $modalInstance.close();
                };
        }]);
    };


    $scope.networkList = {
        networkOffers: [{
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
        }, {
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
        }]

    };

    $scope.computeList = function() {
        $scope.showLoaderOffer = true;
        if (!angular.isUndefined($scope.instance.domain) && $scope.global.sessionValues.type == 'ROOT_ADMIN') {
            var hasCompute = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "computes/listbydomain?domainId=" + $scope.instance.domain.id);
            hasCompute.then(function(result) { // this is only run after $http completes0
                $scope.instanceElements.computeOfferingList = result;
                $scope.showLoaderOffer = false;
            });
            //var hasCompute = appService.crudService.listAll("computes/listbydomain");
        } else {
            var hasCompute = appService.crudService.listAll("computes/list");
            hasCompute.then(function(result) { // this is only run after $http completes0
                $scope.instanceElements.computeOfferingList = result;
                $scope.showLoaderOffer = false;
            });
        }
    };
    $scope.computeList();

    if ($scope.global.sessionValues.type !== 'ROOT_ADMIN') {
        if (!angular.isUndefined($scope.global.sessionValues.domainId)) {
            var hasDisks = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "storages/listbydomain?domainId=" + $scope.global.sessionValues.domainId);
            hasDisks.then(function(result) { // this is only run after $http completes0
                $scope.instanceElements.diskOfferingList = result;
                $scope.showLoaderOffer = false;
            });
        }
    }

    $scope.instanceElements = {
        zoneList: [{
            id: 1,
            name: 'Beijing'
        }, {
            id: 2,
            name: 'Liaoning'
        }, {
            id: 3,
            name: 'Shanghai'
        }, {
            id: 4,
            name: 'Henan'
        }],
        templateList: [{
            id: 1,
            name: 'Windows 2012R ISO',
            price: 0.10
        }, {
            id: 2,
            name: 'Server 2012RSTD 64bit',
            price: 0.15
        }, {
            id: 3,
            name: "Centos 5.3 (64 bit)",
            price: 0.20
        }],
        networkList: [{
            id: 1,
            name: 'Shared',
            price: 0.30
        }, {
            id: 2,
            name: 'Isolated',
            price: 0.40
        }],
        networkOfferingList: [{
            id: 1,
            name: 'All',
            value: 'all',
            price: 0.10
        }, {
            id: 2,
            name: 'VPC',
            value: 'vpc',
            price: 0.20
        }, {
            id: 3,
            name: 'Add New Network',
            value: 'new',
            price: 0.0
        }]
    };

    // Wizard Steps
    $scope.step = 1;
    $scope.wizard = {
        show: function(number) {
            $scope.step = number;
        },
        next: function() {
            $scope.step++;
        },
        prev: function() {
            $scope.step--;
        }
    };
    $scope.instance.networkss = {};
    $scope.instance.networkc = {};
    $scope.getOsListByImage = function(templateImage) {
        $scope.instance.templateOs = {};
        $scope.instance.templateImage = templateImage;
    }

    $scope.getVersionListByOs = function(templateOs) {
        $scope.instance.templateVersion = null;
        $scope.instance.templateOs = templateOs;
        $scope.oslist = 0;
    }

    $scope.getComputeOfferByType = function(type) {
        $scope.instance.computeOffer.category = type;
    }

    $scope.getDiskOfferByType = function(type) {
        $scope.instance.diskOffer.category = type;
    }


    $scope.getNetworkByType = function(type) {
        $scope.instance.networks.category = type;
    }

    $scope.networkList = {};
    $scope.paginationObject = {};
    $scope.networkForm = {};
    $scope.instance.networks = {};
    $scope.global = appService.crudService.globalConfig;
    $scope.test = "test";
    // Guest Network List
    $scope.listNetworks = function(department, type) {
        $scope.showLoaderOffer = true;
        var hasGuestNetworks = {};
        if (type === 'department') {
            hasGuestNetworks = appService.crudService.listAllByFilters("guestnetwork/list", department);
        } else {
            hasGuestNetworks = appService.crudService.listAllByID("guestnetwork/listall?projectId=" + department);
        }
        hasGuestNetworks.then(function(result) { // this is only run after $http
            $scope.instance.networks.networkList = result;
            if ( $scope.instance.networks.vpcList == null) {
                $scope.instance.networks.vpcList = [];
            }
            angular.forEach(result, function(value, key) {
                if (value.vpcId != null) {
                    $scope.instance.networks.vpcList.push(value);
                }
            });
            if(result.length > 0) {
                $scope.instance.networkOfferinglist = $scope.instanceElements.networkOfferingList[0];
                $scope.networks = true;
            } else {
                $scope.listNetworkOffer();
                $scope.instance.networkOfferinglist = $scope.instanceElements.networkOfferingList[2];
                $scope.networks = true;
            }
            $scope.showLoaderOffer = false;
        });

    };


    if (!angular.isUndefined($scope.global.sessionValues.departmentId) && $scope.global.sessionValues.type == "USER") {
        var hasDept = appService.crudService.read("departments", $scope.global.sessionValues.departmentId);
        hasDept.then(function(result) {
            $scope.instance.department = result;
            if (!angular.isUndefined(result)) {
                $scope.listNetworks(result.id, 'department');

            }
        });


        var hasUsers = appService.crudService.read("users", $scope.global.sessionValues.id);
        hasUsers.then(function(result) {
            $scope.instance.instanceOwner = result;
            if (!angular.isUndefined(result)) {
                $scope.projectList(result);
            }
        });
    }


    $scope.networkOfferList = {};
    $scope.networkOfferForm = {};
    $scope.global = appService.crudService.globalConfig;
    //  Network Offer List

    $scope.listNetworkOffer = function() {
        var hasNetworks = appService.promiseAjax.httpTokenRequest(appService.globalConfig.HTTP_GET, appService.globalConfig.APP_URL + "networkoffer/isolated" + "?lang=" + appService.localStorageService.cookie.get('language') + "&sortBy=-id");
        hasNetworks.then(function(result) {
            $scope.instance.networks.networkOfferList = result;
        });
    };

    // create Guest Network
    $scope.guestnetwork = {};

    $scope.saveNetwork = function(networkError) {
        if (!networkError) {
            $scope.showLoaderOffer = true;
            $scope.guestnetwork.zone = $scope.global.zone;
            $scope.guestnetwork.displayText = $scope.guestnetwork.name;
            $scope.guestnetwork.departmentId = $scope.instance.department.id;
            $scope.guestnetwork.department = $scope.instance.department;
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

            if (!angular.isUndefined($scope.guestnetwork.project) && $scope.guestnetwork.project != null) {
                guestnetwork.projectId = $scope.guestnetwork.project.id;
                delete guestnetwork.project;
            }

            guestnetwork.zoneId = $scope.guestnetwork.zone.id;
            guestnetwork.networkOfferingId = $scope.guestnetwork.networkOffering.id;

            delete guestnetwork.zone;
            delete guestnetwork.networkOffering;

            var hasguestNetworks = appService.crudService.add("guestnetwork", guestnetwork);
            hasguestNetworks.then(function(result) {
                if ($scope.instance.project == null) {
                    $scope.listNetworks($scope.instance.department.id, 'department');
                } else {
                    $scope.listNetworks($scope.instance.project.id, 'project');
                }
                appService.notify({
                    message: 'Added successfully',
                    classes: 'alert-success',
                    templateUrl: $scope.global.NOTIFICATION_TEMPLATE
                });
                $scope.instance.networkOfferinglist = $scope.instanceElements.networkOfferingList[0];
                networkError = false;
                $scope.showLoaderOffer = false;
                $scope.guestnetwork = {};
            }).catch(function(result) {
                $scope.showLoaderOffer = false;
                if (!angular.isUndefined(result) && result.data != null) {
                    if (result.data.fieldErrors != '' && !angular.isUndefined(result.data.fieldErrors)) {
                        angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                            $scope.computeForm[key].$invalid = true;
                            $scope.computeForm[key].errorMessage = errorMessage;
                        });
                    }
                }
                $scope.guestnetwork = {};
            });
        }
    }
}
