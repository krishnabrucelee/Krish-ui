
angular
        .module('homer')
        .controller('rolesListCtrl', rolesListCtrl)


 function rolesListCtrl($scope, $window, $state, modalService, crudService, notify, promiseAjax, dialogService, $stateParams) {

    $scope.formElements = {
    };

    $scope.role = {
        department: {}
    };
// var hasServer = promiseAjax.httpRequest("GET", "api/role.json");
// hasServer.then(function (result) { // this is only run after $http completes
// $scope.rolesList = result;
// if (!angular.isUndefined($stateParams.id)) {
// var roleId = $stateParams.id - 1;
// $scope.role = result[roleId];
// $state.current.data.pageTitle = result[roleId].name;
//
// }
    $scope.paginationObject = {};
    $scope.RoleForm = {};
    $scope.global = crudService.globalConfig;


    // Department List
    $scope.list = function (pageNumber) {
        var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
        var hasRoles = crudService.list("roles", $scope.global.paginationHeaders(pageNumber, limit), {"limit": limit});
        hasRoles.then(function (result) {  // this is only run after $http
											// completes0

            $scope.roleList = result;
            console.log($scope.roleList);
            // For pagination
            $scope.paginationObject.limit  = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
        });
    };
    $scope.list(1);

    // Department list from server
    $scope.role.department = {};
    var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
    var hasRoles = crudService.list("departments", $scope.global.paginationHeaders(1, limit), {"limit": limit});
    hasRoles.then(function (result) {  // this is only run after $http
										// completes0
    	$scope.formElements.roleList = result;
//    	$scope.roleList = result;
//    	$scope.formElements.roleList = $scope.roleList[0];
    });

    // Create a new role to our application
    $scope.role = {};
    $scope.createRole = function (form) {
        $scope.formSubmitted = true;
        if (form.$valid) {
            var role = $scope.role;
            var hasServer = crudService.add("roles", role);
            hasServer.then(function (result) {  // this is only run after $http
												// completes
                $scope.list(1);
                notify({message: 'Added successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                $window.location.href = '#/roles';
            }).catch(function (result) {
                angular.forEach(result.data.fieldErrors, function(errorMessage, key) {
                	$scope.RoleForm[key].$invalid = true;
                    $scope.RoleForm[key].errorMessage = errorMessage;
                });

            });
        }

    };

        var hasServers = promiseAjax.httpRequest("GET", "api/permission.json");
        hasServers.then(function (results) {  // this is only run after $http
												// completes
            $scope.permissions = results;


        });


        $scope.edit = function (roleId) {
            var hasRole = crudService.read("roles", roleId);
            hasRole.then(function (result) {
                $scope.role = result;
                console.log($scope.role);
            });

        };


        if (!angular.isUndefined($stateParams.id) && $stateParams.id != '') {
            $scope.edit($stateParams.id)
        }

        $scope.update = function (form) {

            $scope.formSubmitted = true;

            if (form.$valid) {
            	var role = $scope.role;
                var hasServer = crudService.update("roles", role);
                hasServer.then(function (result) {

                $scope.homerTemplate = 'app/views/notification/notify.jsp';
                notify({message: 'Updated successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});

                $window.location.href = '#/roles';
                });
            }
        };


    $scope.delete = function (size, role) {
        dialogService.openDialog("app/views/common/confirm-delete.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
                $scope.deleteId = role.id;
                $scope.ok = function (id) {
                	role.isActive = false;
                    var hasRole = crudService.update("roles", role);
                    hasRole.then(function (result) {
                        $scope.list(1);
                        notify({message: 'Deleted successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
                    });
                    $modalInstance.close();
                },
                        $scope.cancel = function () {
                            $modalInstance.close();
                        };
            }]);
    };

    $scope.checkAll = function (permission, index) {
        if ($scope.permissions[index].selected) {
            $scope.permissions[index].selected = true;
        } else {
            $scope.permissions[index].selected = false;
        }

        angular.forEach($scope.permissions[index].accessmenu, function (access, key) {
            $scope.permissions[index].accessmenu[key].selected = $scope.permissions[index].selected;
        });

    };

     $scope.checkOne = function (permission) {
        $scope.permissions.oneItemSelected[$scope.permissions] = false;
        $scope.permissions.selectedAll[$scope.permissions] = true;
        angular.forEach($scope.permissionsList, function (item) {
            if (item['selected']) {
                $scope.permissions.oneItemSelected[$scope.permissions] = true;
            } else {
                $scope.permissions.selectedAll[$scope.permissions.category] = false;
            }
        });
    };



}
