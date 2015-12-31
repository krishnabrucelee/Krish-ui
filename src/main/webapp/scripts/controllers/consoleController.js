/**
 *
 * consoleCtrl
 *
 */
angular.module('homer', [])
.factory('globalConfig', function globalConfig($window) {
    var appGlobalConfig = {};

    /**
     *  Global configuration goes here
     */
    appGlobalConfig = {
        project:{id:0, name:'Projects'},
        projectList:[{id:0, name:'Projects'},{id:1, name:'IMS'},{id:2, name:'Programming'},{id:3, name:'Testing'}],
        zone:{id:1, name:'Beijing'},
        zoneList:[{id:1, name:'Beijing'},{id:2, name:'Liaoning'},{id:3, name:'Shanghai'},{id:4, name:'Henan'}],
        settings: {
            currency : "¥",
            currencyLabel:"CNY"
        },
        networks:{
            name:''
        },
        rulesLB:[{name:'Test','protocol':'tcp',publicPort:'90',privatePort:'90',publicEndPort:'120',privateEndPort:'120',algorithm:'Round-robin',vms:[{id:'',name: "NorthChina- Beijing",zone:"Beijing"}],state:'active'}],
        Vms:['1','2','3','4'],
        selectedVms:[],
        date: {
            format:'dd/MMM/yyyy',
            dateOptions: {
                formatYear: 'yy',
                startingDay: 1
            },
            minDate:  new Date(),
        },
        Math: window.Math,

        HTTP_GET: 'GET',
        HTTP_POST: 'POST',
        HTTP_PUT: 'PUT',
        HTTP_DELETE: 'DELETE',
        APP_URL: "http://localhost:8080/api/",
        CONTENT_LIMIT: 10,
        VIEW_URL : 'app/views/',
        NOTIFICATION_TEMPLATE: 'app/views/notification/notify.jsp',

        paginationHeaders: function(pageNumber, limit) {
            var headers = {};

            var rangeStart = (pageNumber - 1) * limit;
            var rangeEnd = (pageNumber - 1) * limit + (limit - 1);
            headers.Range = "items=" + rangeStart + "-" + rangeEnd;
            return headers;
        },

        getViewPageUrl: function(url) {
        	return appGlobalConfig.VIEW_URL + url;
        },
        sessionValues:  JSON.parse($window.sessionStorage.getItem("loginSession"))
    };

    return appGlobalConfig;

})
.controller("consoleCtrl", function ($scope, $http, $sce, globalConfig, $window) {

	$scope.getQueryParameterByName = function (name) {
	    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
	    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
	        results = regex.exec(location.search);
	    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
	}

	var loginSession = globalConfig.sessionValues;
    if(loginSession == null) {
    	window.location.href = "login";
    }
    var consolePorxy = $window.sessionStorage.getItem("consoleProxy");
    $scope.consoleUrl = consolePorxy + "token=" + $scope.getQueryParameterByName("token");
    $scope.consoleUrl = $sce.trustAsResourceUrl($scope.consoleUrl);


	$http({
       "method": "GET",
       "data": {},
       "url": globalConfig.APP_URL+ "iso/list",
       "headers": {'x-auth-token': loginSession.token, 'Content-Type': 'application/json', 'Range': "items=0-9"}
   }).then(function (res) {
	   $scope.isoLists = res.data;

	   angular.forEach($scope.isoLists, function(obj, key) {
		  if(obj.name == atob($scope.getQueryParameterByName("iso"))) {
			  $scope.isos = obj;
		  }
	   });
   }).catch(function (result) {
	   	if(result.data != null && result.data.status === 401 && result.data.message === "INVALID_TOKEN") {
			notify({
				message : "Your session has expired. Please log-in again",
				classes : 'alert-danger',
				templateUrl : global.NOTIFICATION_TEMPLATE
			});
			setTimeout(function() {
				window.location.href = "login";
			}, 2000);
	    } else {
	    	throw result;
	    }
	});


	$scope.instanceStartLabel = "Start";
	  $scope.vmStart = function(item) {
		  var confirmBox  = confirm("Are you sure do you want to start?");
		  if(confirmBox) {
			  	$scope.instanceStartLabel = "Starting";
				var event = "VM.START";
				$http({
				       "method": globalConfig.HTTP_GET,
				       "data": {},
				       "url": globalConfig.APP_URL+ "virtualmachine/event?lang=en&vm="+item.uuid+"&event=" + event,
				       "headers": {'x-auth-token': loginSession.token, 'Content-Type': 'application/json', 'Range': "items=0-9"}
				   }).then(function(result) {
					   $scope.instanceStartLabel = "Start";
					   $scope.consoleVm = result.data;
				}).catch(function (result) {
					 $scope.vmStarting = false;
					console.log(result.data.globalError[0]);
			         if(result.data.globalError[0] != null){
			        	 var msg = result.data.globalError[0];
			        	 alert(msg);
		             }
	             });
		  	}
		}

	$scope.instanceStopLabel = "Stop";
	$scope.vmStop = function(item) {
		var confirmBox = confirm("Are your usre do you want to stop?");
		if(confirmBox) {
			$scope.instanceStopLabel = "Stopping";
			var event = "VM.STOP";
			$http({
			       "method": globalConfig.HTTP_GET,
			       "data": {},
			       "url": globalConfig.APP_URL+ "virtualmachine/event?lang=en&vm="+item.uuid+"&event=" + event,
			       "headers": {'x-auth-token': loginSession.token, 'Content-Type': 'application/json', 'Range': "items=0-9"}
			   }).then(function(result) {
				   $scope.instanceStopLabel = "Stop";
				   $scope.vmStopping = false;
				   $scope.consoleVm = result.data;
			}).catch(function (result) {
				 $scope.vmStarting = false;
		         if(result.data.globalError[0] != null){
		        	 var msg = result.data.globalError[0];
		        	 alert(msg);
	             }
           });
		}
	}

	$scope.attachIsoLabel = "Attach";
	$scope.detachIsoLabel = "Eject";
	$scope.attachISotoVM = function(vm) {
	    var event = "ISO.ATTACH";
	    var tempVm = vm;
		tempVm.iso = $scope.isos.uuid;
		tempVm.event = event;
		$scope.attachIsoLabel = "Attaching";
		$http({
		       "method": globalConfig.HTTP_PUT,
		       "data": tempVm,
		       "url": globalConfig.APP_URL+ "virtualmachine/vm?lang=en",
		       "headers": {'x-auth-token': loginSession.token, 'Content-Type': 'application/json', 'Range': "items=0-9"}
		   }).then(function(result) {
				$scope.homerTemplate = 'app/views/notification/notify.jsp';
				$scope.consoleVm = result.data;
	             alert($scope.isos.name+" is attaching to this VM");

				setTimeout(function() {
					$scope.attachIsoLabel = "Attach";
				}, 3000);
		}).catch(function (result) {
			console.log(result);
			console.log(result.data.globalError[0]);
	         if(result.data.globalError[0] != null){
	        	 var msg = result.data.globalError[0];
	        	 alert(msg);
             }
        });
	}

	$scope.detachISO = function(vm) {
		var event = "ISO.DETACH";
		$scope.vm = vm;
		$scope.vm.event = event;
		$scope.detachIsoLabel = "Ejecting";
		$http({
		       "method": globalConfig.HTTP_PUT,
		       "data": $scope.vm,
		       "url": globalConfig.APP_URL+ "virtualmachine/vm?lang=en",
		       "headers": {'x-auth-token': loginSession.token, 'Content-Type': 'application/json', 'Range': "items=0-9"}
		   }).then(function(result) {
			   $scope.consoleVm = result.data;
	             alert($scope.isos.name+" is detaching from this VM");
	             setTimeout(function() {
	            	 $scope.detachIsoLabel = "Eject";
				 }, 3000);
		}).catch(function (result) {
	         if(result.data.globalError[0] != null){
	        	 var msg = result.data.globalError[0];
	        	 alert(msg);
          }
     });

	}


//	$scope.isoList = function () {
//      var hasisoList = crudService.listAll("iso/list");
//      hasisoList.then(function (result) {  // this is only run after $http
//											// completes0
//              $scope.isoLists = result;
//       });
//   };
//   $scope.isoList();
});





