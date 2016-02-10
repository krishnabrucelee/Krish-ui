/**
 *
 * instanceMonitorCtrl
 *
 */

angular
    .module('homer')
    .controller('instanceMonitorCtrl', instanceMonitorCtrl)

function instanceMonitorCtrl($scope, $rootScope, $http, $stateParams, appService) {

	$scope.dataset = [{ data: [], yaxis: 100, label: "sin" }, { data: [], yaxis: 100, label: "cos" }];
    $scope.options = {
      legend: {
        show: true,
        position:"nw"
      }
    };
    $scope.dataset[0].data.push([0,200]);
    $scope.dataset[0].data.push([1,300]);
    $scope.dataset[1].data.push([0,300]);
    $scope.dataset[1].data.push([1,300]);


    var dataset = [{data: []}, {data: []}];

    function getData(i) {
    	 var data = $scope.dataset[0].data;

		  data.push([i, Math.floor((Math.random() * 100) + 1)]);


		  data.shift();
		  //$scope.dataset[0].data.shift();
	      $scope.dataset[0].data = data;
	      $scope.dataset[1].data = data;

	      //console.log($scope.dataset);
    }


    var i =2;
    setInterval(function() {
    	getData(i);
    	i++;
    }, 800);



		/**
	     * Data for Line chart
	     */
	    $scope.cpu = {
	        labels: ["10.05", "10.10", "10.15", "10.20", "10.25", "10.30", "10.35", "10.40", "10.45", "10.50"],
	        datasets: [
	            {
	                label: "CPU 0",
	                fillColor: "#E56919",
	                strokeColor: "#E56919",
	                pointColor: "#E56919",
	                pointStrokeColor: "#fff",
	                pointHighlightFill: "#fff",
	                pointHighlightStroke: "rgba(220,220,220,1)",
	                data: [99,97,98,95,98,99,96,94,98,100]
	            },
	            {
	                label: "CPU 1",
	                fillColor: "#16658D",
	                strokeColor: "#16658D",
	                pointColor: "#16658D",
	                pointStrokeColor: "#fff",
	                pointHighlightFill: "#fff",
	                pointHighlightStroke: "rgba(26,179,148,1)",
	                data: [98,99,96,94,98,100,98,97,98,99]
	            }
	        ]
	    };


	    function getDateByTime(unixTimeStamp) {
	    	var date = new Date(unixTimeStamp*1000);
	    	return date;
	    }


	    var j=0;

	    function getCpuPerformance(url, indexValue, instanceName) {
		    var hasServer = appService.promiseAjax.httpRequest("GET", "http://192.168.1.137:4242/api/"+ url);
		    hasServer.then(function (result) {
		    	for(var i=0; i < result.length; i++ ) {
			    	angular.forEach(result[i].dps, function(obj, key) {
			    		j++;
				        var date = getDateByTime(key);
			    		var objIndex = $scope.cpu.labels.indexOf(date.getHours() + "." + date.getMinutes()+ "." + date.getSeconds());
			    		if(objIndex < 0) {
			    			if(indexValue == 0) {
			    				$scope.cpu.labels.shift();
			    				$scope.cpu.labels.push(date.getHours() + "." + date.getMinutes()+ "." + date.getSeconds());
			    			}
					        $scope.cpu.datasets[indexValue].data.shift();
					        $scope.cpu.datasets[1].data.shift();

					        //var objValue = (obj) * 1/100;
					        $scope.cpu.datasets[indexValue].data.push(obj);
			    		}  else {
			    			var objValue = parseInt(obj) / 1024;
			    			$scope.cpu.datasets[indexValue].data[objIndex] = obj;
			    		}

			    	});
		    	}
		    });
	    }


	    $scope.memory = {
		        labels: ["10.00", "10.05","10.10", "10.15","10.20", "10.25", "10.30","10.35", "10.40"],
		        datasets: [
		            {
		                label: "Used Memory",
		                fillColor: "#E56919",
		                strokeColor: "#E56919",
		                pointColor: "#E56919",
		                pointStrokeColor: "#fff",
		                pointHighlightFill: "#fff",
		                pointHighlightStroke: "rgba(220,220,220,1)",
		                data: [0, 0, 0, 0, 0, 0, 0, 0, 0]
		            },
		            {
		                label: "Unused Memory",
		                fillColor: "#16658D",
		                strokeColor: "#16658D",
		                pointColor: "#16658D",
		                pointStrokeColor: "#fff",
		                pointHighlightFill: "#fff",
		                pointHighlightStroke: "rgba(26,179,148,1)",
		                data: [0, 0, 0, 0, 0, 0, 0, 0, 0]
		            },{
		                label: "Total Memory",
		                fillColor: "#7208A8",
		                strokeColor: "#7208A8",
		                pointColor: "#7208A8",
		                pointStrokeColor: "#fff",
		                pointHighlightFill: "#fff",
		                pointHighlightStroke: "rgba(26,179,148,1)",
		                data: [0, 0, 0, 0, 0, 0, 0, 0, 0]
		            }

		        ]
		    };



		var objIndex = [];

		var currentUrl = "";
	    function getMemoryPerformance(url, indexValue, instanceName) {
		    var hasServer = appService.promiseAjax.httpRequest("GET", "http://192.168.1.137:4242/api/"+ url);
		    hasServer.then(function (result) {
		    	for(var i=0; i < result.length; i++ ) {
		    		var j =0;
			    	angular.forEach(result[i].dps, function(obj, key) {
			    		j++;
			    		var date = getDateByTime(key);
				        var objIndex = $scope.memory.labels.indexOf(date.getHours() + "." + date.getMinutes()+ "." + date.getSeconds());

			    		if(objIndex < 0) {
			    			if(indexValue == 0) {
			    				$scope.memory.labels.shift();
			    				$scope.memory.labels.push(date.getHours() + "." + date.getMinutes()+ "." + date.getSeconds());
			    			}
			    			var objValue = parseFloat(parseInt(obj) / (1024 * 1024));
					        $scope.memory.datasets[indexValue].data.shift();
					        $scope.memory.datasets[1].data.shift();
					        $scope.memory.datasets[2].data.shift();
					        $scope.memory.datasets[indexValue].data.push(objValue);
			    		} else {
			    			var objValue = parseFloat(parseInt(obj) / (1024 * 1024));
			    			$scope.memory.datasets[indexValue].data[objIndex] = objValue;
			    		}

			    	});
		    	}
		    });
	    }

	    $scope.disk = {
		        labels: ["10.00", "10.05", "10.10", "10.15", "10.20", "10.25", "10.30"],
		        datasets: [
		            {
		                label: "Write",
		                fillColor: "#E56919",
		                strokeColor: "#E56919",
		                pointColor: "#E56919",
		                pointStrokeColor: "#fff",
		                pointHighlightFill: "#fff",
		                pointHighlightStroke: "rgba(220,220,220,1)",
		                data: [0, 0, 0, 0, 0, 0, 0]
		            },
		            {
		                label: "Read",
		                fillColor: "#16658D",
		                strokeColor: "#16658D",
		                pointColor: "#16658D",
		                pointStrokeColor: "#fff",
		                pointHighlightFill: "#fff",
		                pointHighlightStroke: "rgba(220,220,220,1)",
		                data: [0, 0, 0, 0, 0, 0, 0]
		            }
		        ]
		    };


	    var objIndex = [];

		var currentUrl = "";
	    function getStorageIO(url, indexValue, instanceName) {
		    var hasServer = appService.promiseAjax.httpRequest("GET", "http://192.168.1.137:4242/api/"+ url);
		    hasServer.then(function (result) {
		    	for(var i=0; i < result.length; i++ ) {
		    		var j =0;
			    	angular.forEach(result[i].dps, function(obj, key) {
			    		j++;
			    		var date = getDateByTime(key);
				        var objIndex = $scope.disk.labels.indexOf(date.getHours() + "." + date.getMinutes()+ "." + date.getSeconds());
			    		if(objIndex < 0) {
			    			if(indexValue == 0) {
			    				$scope.disk.labels.shift();
			    				$scope.disk.labels.push(date.getHours() + "." + date.getMinutes()+ "." + date.getSeconds());
			    			}
					        $scope.disk.datasets[indexValue].data.shift();
					        $scope.disk.datasets[1].data.shift();
					        var objValue = parseFloat(parseInt(obj) / (1024));
					        $scope.disk.datasets[indexValue].data.push(parseFloat(objValue));
			    		}else {
			    			var objValue = parseFloat(parseInt(obj) / (1024));
			    			$scope.disk.datasets[indexValue].data[objIndex] = parseFloat(objValue);
			    		}

			    	});
		    	}
		    });
	    }

	    if ($stateParams.id > 0) {
	        var hasServer = appService.crudService.read("virtualmachine", $stateParams.id);
	        hasServer.then(function (result) {  // this is only run after $http
	            $scope.instance = result;
	            var displayName = result.displayName.toLowerCase();
	            //getCpuPerformance("query?start=1m-ago&m=sum:rate:linux.cpu{host="+ displayName +"}", 0, result.displayName.toLowerCase());
	            for(var cpuCores=0; cpuCores < result.computeOffering.numberOfCores; cpuCores++) {
	            	getCpuPerformance("query?start=1m-ago&m=sum:rate:linux.cpu.percpu{host="+ displayName +",cpu=" + cpuCores + "}", cpuCores, result.displayName.toLowerCase());
	            }
	            getMemoryPerformance("query?start=1m-ago&m=sum:os.mem.total{host="+ displayName +"}", 0,  result.displayName.toLowerCase());
	            getMemoryPerformance("query?start=1m-ago&m=sum:os.mem.free{host="+ displayName +"}", 1,  result.displayName.toLowerCase());
	            getMemoryPerformance("query?start=1m-ago&m=sum:os.mem.used{host="+ displayName +"}", 2,  result.displayName.toLowerCase());

	            //getStorageIO("query?start=1m-ago&m=sum:linux.disk.write_requests{host="+ displayName +"}", 0,  result.displayName.toLowerCase());
	            //getStorageIO("query?start=1m-ago&m=sum:linux.disk.read_requests{host="+ displayName +"}", 1,  result.displayName.toLowerCase());

	            setInterval(function() {
	    	    	//getCpuPerformance("query?start=1m-ago&m=sum:rate:linux.cpu{host="+ displayName +"}", 0, result.displayName.toLowerCase());
	    	    	for(var cpuCores=0; cpuCores < result.computeOffering.numberOfCores; cpuCores++) {
		            	getCpuPerformance("query?start=1m-ago&m=sum:rate:linux.cpu.percpu{host="+ displayName +",cpu=" + cpuCores + "}", cpuCores, result.displayName.toLowerCase());
		            }
		            getMemoryPerformance("query?start=1m-ago&m=sum:os.mem.total{host="+ displayName +"}", 0,  result.displayName.toLowerCase());
		            getMemoryPerformance("query?start=1m-ago&m=sum:os.mem.free{host="+ displayName +"}", 1, result.displayName.toLowerCase());
	            	getMemoryPerformance("query?start=1m-ago&m=sum:os.mem.used{host="+ displayName +"}", 2, result.displayName.toLowerCase());

	            	//getStorageIO("query?start=1m-ago&m=sum:linux.disk.write_requests{host="+ displayName +"}", 0,  result.displayName.toLowerCase());
		           // getStorageIO("query?start=1m-ago&m=sum:linux.disk.read_requests{host="+ displayName +"}", 1,  result.displayName.toLowerCase());
	            }, 1500000);

	        });
	    }








//	    var j=0;
//
//	    function getStorageUsage() {
//		    var hasServer = promiseAjax.httpRequest("GET", "http://192.168.1.137:4242/api/query?start=1m-ago&m=sum:rate:linux.disk.part.ios_in_progress{host=tcollector-1}");
//		    hasServer.then(function (result) {
//		    	for(var i=0; i < result.length; i++ ) {
//			    	angular.forEach(result[i].dps, function(obj, key) {
//			    		j++;
//			    		$scope.disk.labels.shift();
//			    		var date = getDateByTime(key);
//				        $scope.disk.labels.push(date.getHours() + "." + date.getMinutes()+ "." + date.getSeconds());
//				        $scope.disk.datasets[i].data.shift();
//				        $scope.disk.datasets[i].data.push(obj);
//			    	});
//		    	}
//		    });
//	    }
//
//	    setInterval(function() {
//	    	getStorageUsage();
//	    }, 1000);


	     $scope.network = {
	        labels: ["10.00", "10.05", "10.10", "10.15", "10.20", "10.25", "10.30"],
	        datasets: [
	            {
	                label: "NIC 0 - Receive",
	                fillColor: "#E56919",
	                strokeColor: "#E56919",
	                pointColor: "#E56919",
	                pointStrokeColor: "#fff",
	                pointHighlightFill: "#fff",
	                pointHighlightStroke: "rgba(220,220,220,1)",
	                data: [52, 44, 37, 43, 46, 45, 32]
	            },
	            {
	                label: "NIC 0 - Send",
	                fillColor: "#16658D",
	                strokeColor: "#16658D",
	                pointColor: "#16658D",
	                pointStrokeColor: "#fff",
	                pointHighlightFill: "#fff",
	                pointHighlightStroke: "rgba(26,179,148,1)",
	                data: [37, 39, 29, 36, 32, 23, 28]
	            },
	            {
	                label: "NIC 1 - Send",
	                fillColor: "#7208A8",
	                strokeColor: "#7208A8",
	                pointColor: "#7208A8",
	                pointStrokeColor: "#fff",
	                pointHighlightFill: "#fff",
	                pointHighlightStroke: "rgba(26,179,148,1)",
	                data: [26, 32, 22, 26, 25, 22, 18]
	            },
	            {
	                label: "NIC 1 - Receive",
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








//
//
//
//	    var j=0;
//
//	    function getStorageUsage() {
//		    var hasServer = promiseAjax.httpRequest("GET", "http://192.168.1.137:4242/api/query?start=1m-ago&m=sum:rate:linux.disk.part.ios_in_progress{host=tcollector-1}");
//		    hasServer.then(function (result) {
//		    	for(var i=0; i < result.length; i++ ) {
//			    	angular.forEach(result[i].dps, function(obj, key) {
//			    		j++;
//			    		$scope.disk.labels.shift();
//			    		var date = getDateByTime(key);
//				        $scope.disk.labels.push(date.getHours() + "." + date.getMinutes()+ "." + date.getSeconds());
//				        $scope.disk.datasets[i].data.shift();
//				        $scope.disk.datasets[i].data.push(obj);
//			    	});
//		    	}
//		    });
//	    }
//
//	    setInterval(function() {
//	    	getStorageUsage();
//	    }, 1000);

	    $scope.instanceElements= {actions: [
	            {id: 1, name: 'Hours'},
	            {id: 2, name: 'Days'},
	            {id: 3, name: 'Weeks'},
	            {id: 3, name: 'Month'}

	        ]};

	    /**
	     * Options for Line chart
	     */
	    $scope.lineOptions = {
	        scaleShowGridLines : true,
	        scaleGridLineColor : "rgba(0,0,0,.05)",
	        scaleGridLineWidth : 1,
	        bezierCurve : true,
	        bezierCurveTension : 0.4,
	        pointDot : true,
	        pointDotRadius : 4,
	        pointDotStrokeWidth : 1,
	        pointHitDetectionRadius : 20,
	        datasetStroke : true,
	        datasetStrokeWidth : 1,
	        datasetFill: false,
	        animation: false
	//        responsive: true,
	//        maintainAspectRatio: true
	    };



}