/**
 *
 * templatesCtrl
 *
 */

angular
        .module('homer')
        .controller('templatesCtrl', templatesCtrl)
        .controller('templateDetailsCtrl', templateDetailsCtrl)
        .controller('uploadTemplateCtrl', uploadTemplateCtrl)

function templatesCtrl($scope, $stateParams, $timeout, promiseAjax, globalConfig, $modal, $log) {

    $scope.global = globalConfig;
    $scope.template = {
        templateList: {}
    };

    var hasServer = promiseAjax.httpRequest("GET", "api/templates.json");
    hasServer.then(function (result) {
       $scope.template.templateList = result;
    });

    $scope.showTemplateContent = function() {
        $scope.showLoader = true;
        $timeout(function() {
            $scope.showLoader = false;
            $scope.listView =!$scope.listView;

        }, 800);

    };

    $scope.uploadTemplateContainer = function () {
        var modalInstance = $modal.open({
            templateUrl: 'app/views/templates/upload.jsp',
            controller: 'uploadTemplateCtrl',
            size: 'lg',
            backdrop: 'static',
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
            $log.info('Modal dismissed at: ' + new Date());
        });
    };


    $scope.openDescription = function (index) {
        angular.forEach($scope.template.templateList, function (value, key) {
            if (index == key && !$scope.template.templateList[key].openDescription) {
                $scope.template.templateList[key].openDescription = true;
            } else {
                $scope.template.templateList[key].openDescription = false;
            }
        });
    }



    // INFO PAGE

    $scope.templateInfo = $scope.template.templateList[$stateParams.id - 1];

    $scope.showDescription = function (templateObj) {
        //modalService.trigger('app/views/servicecatalog/viewnetwork.jsp', 'md', 'View Network Offering');
        var modalInstance = $modal.open({
            animation: $scope.animationsEnabled,
            templateUrl: 'app/views/templates/properties.jsp',
            controller: 'templateDetailsCtrl',
            size: 'md',
            backdrop: 'static',
            windowClass: "hmodal-info",
            resolve: {
                templateObj: function () {
                    return angular.copy(templateObj);
                }
            }
        });

        modalInstance.result.then(function (selectedItem) {
            $scope.selected = selectedItem;

        }, function () {
            $log.info('Modal dismissed at: ' + new Date());
        });
    };
}

angular.module('homer').controller('PopoverDemoCtrl', function ($scope) {
    $scope.dynamicPopover = {
        content: 'Hello, World!',
        templateUrl: 'myPopoverTemplate.jsp',
        title: 'Title'
    };
});

function templateDetailsCtrl($scope, templateObj, $modalInstance) {
    $scope.templateObj = templateObj;
    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };
};


function uploadTemplateCtrl($scope, globalConfig, $modalInstance, notify) {

    $scope.global = globalConfig;

    $scope.formElements = {
        hypervisorList: [
            {
                id: 1,
                name: 'Hyperv',
                formatList: [
                    {id: 1, name: 'VHD'},
                    {id: 2, name: 'VHDX'},
                ]
            },
            {
                id: 2,
                name: 'KVM',
                formatList: [
                    {id: 1, name: 'QCOW2'},
                    {id: 2, name: 'RAW'},
                    {id: 3, name: 'VHD'},
                    {id: 4, name: 'VHDX'},
                ]
            },
            {
                id: 3,
                name: 'XenServer',
                formatList: [
                    {id: 1, name: 'VHD'},
                ]
            },
            {
                id: 4,
                name: 'VMware',
                formatList: [
                    {id: 1, name: 'OVA'},
                ],
                rootDiskControllerList: [
                    {id: 1, name: 'SCSI'},
                    {id: 2, name: 'IDE'},
                ],
                nicTypeList: [
                    {id: 1, name: 'E1000'},
                    {id: 2, name: 'PCNET32'},
                    {id: 3, name: 'VMXNET2'},
                    {id: 4, name: 'VMXNET3'},
                ],
                keyboardTypeList: [
                    {id: 1, name: 'US Keyboard'},
                    {id: 2, name: 'UK Keyboard'},
                    {id: 3, name: 'Japanese Keyboard'},
                    {id: 4, name: 'Simplified Chinese'},
                ],
            },
            {
                id: 5,
                name: 'BareMetal',
                formatList: [
                    {id: 1, name: 'BareMetal'},
                ]
            },
            {
                id: 6,
                name: 'Ovm',
                formatList: [
                    {id: 1, name: 'RAW'},
                ]
            },
            {
                id: 7,
                name: 'LXC',
                formatList: [
                    {id: 1, name: 'TAR'},
                ]
            },
        ],

        osTypeList: [
            {id: 1, name: 'Apple Mac OS X 10.6 (32-bit)'},
            {id: 2, name: 'Apple Mac OS X 10.6 (64-bit)'},
            {id: 3, name: 'CentOS 6.5 (32-bit)'},
            {id: 4, name: 'CentOS 6.5 (64-bit)'},
            {id: 5, name: 'Windows Server 2008 (32-bit)'},
            {id: 6, name: 'Windows Server 2008 (64-bit)'},
        ]
    }
     $scope.save = function(form) {
        $scope.formSubmitted = true;
        if (form.$valid) {
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            notify({message: 'Uploaded successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
            $scope.cancel();

        }
    };
    $scope.ok = function () {
        $modalInstance.close();
    };

    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };
}
