/**
 *
 * instanceMonitorCtrl
 *
 */

angular
    .module('homer')
    .controller('instanceMonitorCtrl', instanceMonitorCtrl)

function instanceMonitorCtrl($scope, $rootScope, $http, $stateParams, appService) {

	$scope.togglePlot = function(index) { };

	var cpuData = [];

	/*$scope.mchart = {
			cpu: {
				result: [],
	    		actions: {id: "5m", name: 'Last 5 minutes'},
	    		dataset: [],
	    		colorLabels: ["#62cb31", "#d9534f", "#f0ad4e", "#48a9da"],
	    		chartIteration: 0,
	    		totalDelayCount: 0,
	    		chartIterationCount: 3,
	    	    forAdditionalIterations: [],
	    	    dataIndexCount: 12
			},

			memory: {
				result: [],
	    		actions: {id: "5m", name: 'Last 5 minutes'},
	    		dataset: [],
	    		colorLabels: ["#62cb31", "#d9534f", "#f0ad4e", "#48a9da"]
			}
	};

*/
	$scope.cpu = {
    		result: [],
    		actions: {id: "5m", name: 'Last 5 minutes'}
    };
	$scope.cpu.dataset = [];

	$scope.instanceElements= {actions: [
            {id: '5m', name: 'Last 5 minutes'},
            {id: '15m', name: 'Last 15 minutes'},
            {id: '30m', name: 'Last 30 minutes'},
            {id: '1h', name: 'Last 1 hour'},
            {id: '3h', name: 'Last 3 hour'},
            {id: '6h', name: 'Last 6 hour'},
            {id: '12h', name: 'Last 12 hours'}
//	        {id: '24h', name: 'Last 24 hours'}

        ]};

	var pandaChart = appService.monitorService.getPandaChart();
	var pandaMemoryChart = appService.monitorService.getPandaChart();

	$scope.flotOptions = {
		series: {
	          splines: {
	                show: true,
	                lineWidth: 1.5,
	                fill: 0.1
	            },
	      },
      legend: {
    	  noColumns: 8,
    	  container: "#cpuLegendContainer",
    	  show: true,
          position:"nw",
          labelFormatter: function(label, series){
            return '<a href="javascript:void(0)" data-ng-click="togglePlot('+series.idx+'); return false;">'+label+'</a>';
          }
      },

      xaxes: [{
	        mode: "time",
	        timeformat: "%H:%M:%S",
	        tickSize: [5, "minute"],
	        tickFormatter: function (v, axis) {
	        	var date = new Date(v);
	        	return appService.monitorService.getPandaChart().getChartLabelByRangeAndDate($scope.cpu.actions.id, date);

	        },
	        axisLabel: "Date",
	        axisLabelUseCanvas: true,
	        axisLabelFontSizePixels: 12,
	        axisLabelFontFamily: 'Verdana, Arial',
	        axisLabelPadding: 10
	    }],

      grid: {
          hoverable: true,
          mouseActiveRadius: 30,
          tickColor: "#dddddd",
          borderWidth: 0.5,
          borderColor: '#dddddd',
          color: 'red',

          axisMargin: 15
      },
      tooltip: {
          show: true,
          content: "%s | x: %x; y: %y"
        },
      colors: [],
    };


	/**
     * Data for Line chart
     */
    function getDateByTime(unixTimeStamp) {
    	var date = new Date(unixTimeStamp*1000);
    	return date;
    }

    var dataIndexCount = 12;
    var j=0;
    var colorLabels = ["#62cb31", "#d9534f", "#f0ad4e", "#48a9da"];
    var chartIteration = 0; totalDelayCount=0; chartIterationCount = 3;
    var forAdditionalIterations = [];

    function getPerformanceByFilters(url, indexValue, instanceName, totalCount, chartType) {
    	var chartConfig = pandaChart.getConfigurationByRange($scope.cpu.actions.id);
    	dataIndexCount = chartConfig.dataIndexCount;
    	chartIterationCount = chartConfig.chartIterationCount;
    	$scope.flotOptions.xaxes[0].tickSize = chartConfig.tickSize;


    	$scope.flotOptions.colors = ["#62cb31", "#d9534f", "#f0ad4e", "#48a9da"];
		if(indexValue == 0 && totalCount != -1) {
			chartIteration++;
    	}

		if(chartIteration == chartIterationCount || totalCount == -1) {
    		forAdditionlTenIndex = 0;
    		if(indexValue == totalCount)
    			chartIteration = 0;
		    var hasServer = appService.promiseAjax.httpRequest("GET", "http://192.168.1.137:4242/api/"+ url);
		    hasServer.then(function (result) {

		    	if(angular.isUndefined($scope.cpuData)) {
		    		$scope.cpuData = [];
		    	}
		    	$scope.cpuData[indexValue] = [];
		    	for(var i=0; i < result.length; i++ ) {
		    		j++;
		    		var dataPoints = result[i].dps;
		    		var dataIndex = 0;
		    		forAdditionalIterations[indexValue] = [];
			    	angular.forEach(dataPoints, function(obj, key) {
			    		dataIndex++;
		    			var currentValue = obj;
			    		if(dataIndex <= dataIndexCount) {
					        $scope.cpuData[indexValue].push([getDateByTime(key).getTime(), currentValue]);
			    		} else {
			    			forAdditionalIterations[indexValue].push([getDateByTime(key).getTime(), currentValue]);
			    		}
			    	});

			    	var currentData =  {
		    			data : $scope.cpuData[indexValue],
		    			yaxis : 100,
		    			label : "CPU " + indexValue,
		    			color : colorLabels[indexValue],
		    			points : {
		    				fillColor : colorLabels[indexValue],
		    				show : true
		    			},
		    			idx: indexValue
		    		};

			    	if(angular.isUndefined($scope.cpu.dataset[i])) {
			    		$scope.cpu.dataset[indexValue] = {
			    				data: []
			    		};
			    	}
			    	$scope.cpu.dataset[indexValue] = currentData;
		    	}
		    });
    	}

		if(indexValue ==0) {
			jQuery('.flot-base,.flot-x-axis, .flot-overlay').removeClass('m-l-n-lg m-l-n-xxl');
		}
		pandaChart.updateChartMarginByRangeAndIndex($scope.cpu.actions.id, indexValue, chartIteration);
    }

    var updatePerformance = 0;
    $scope.updateCpuPerformance = function(cpuResult, cpuAction) {
    	updatePerformance++;
    	chartIteration = 0; totalDelayCount=0; start = 0; end = 0; forAdditionalTenIndex=0; chartIterationCount = 3;
    	forAdditionalIterations = [];
    	var displayName = "monitor-vm";
    	for(var cpuCores=0; cpuCores < 4; cpuCores++) {
    		getPerformanceByFilters("query?start=" + $scope.cpu.actions.id + "-ago&m=sum:linux.cpu.percpu{host="+ displayName +",cpu=" + cpuCores + "}", cpuCores, displayName, -1, pandaChart.chartTypes.CPU);
        }

    	if(updatePerformance == 1)  {
	    	setInterval(function() {
            	$scope.$apply(function () {
	    	    	for(var cpuCores=0; cpuCores < 4; cpuCores++) {
	    	    		getPerformanceByFilters("query?start=" + $scope.cpu.actions.id + "-ago&m=sum:linux.cpu.percpu{host="+ displayName +",cpu=" + cpuCores + "}", cpuCores, displayName, 3, pandaChart.chartTypes.CPU);
		            }
            	});
            }, 5000);
    	}

    }


    $scope.memory = {
    		result: [],
    		actions: {id: "5m", name: 'Last 5 minutes'}
    };
	$scope.memory.dataset = [];
    $scope.memoryFlotOptions = {
    		series: {
    	          splines: {
    	                show: true,
    	                lineWidth: 1.5,
    	                fill: 0.1
    	            },
    	      },
          legend: {
        	  noColumns: 8,
        	  container: "#memoryLegendContainer",
        	  show: true,
              position:"nw",
              labelFormatter: function(label, series){
                return '<a href="javascript:void(0)" data-ng-click="togglePlot('+series.idx+'); return false;">'+label+'</a>';
              }
          },

          xaxes: [{
    	        mode: "time",
    	        timeformat: "%H:%M:%S",
    	        tickSize: [5, "minute"],
    	        tickFormatter: function (v, axis) {
    	        	var date = new Date(v);
    	        	return pandaMemoryChart.getChartLabelByRangeAndDate($scope.cpu.actions.id, date);

    	        },
    	        axisLabel: "Date",
    	        axisLabelUseCanvas: true,
    	        axisLabelFontSizePixels: 12,
    	        axisLabelFontFamily: 'Verdana, Arial',
    	        axisLabelPadding: 10
    	    }],

          grid: {
              hoverable: true,
              mouseActiveRadius: 30,
              tickColor: "#dddddd",
              borderWidth: 0.5,
              borderColor: '#dddddd',
              color: 'red',

              axisMargin: 15
          },
          tooltip: {
              show: true,
              content: "%s | x: %x; y: %y"
            },
          colors: [],
        };



    var memoryIndexCount = 12;
    var memoryColorLabels = ["#62cb31", "#d9534f", "#f0ad4e", "#48a9da"];
    var memoryChartIteration = 0; memoryTotalDelayCount=0; memoryChartIterationCount = 3;
    var memoryForAdditionalIterations = [];

    function getMemoryPerformanceByFilters(url, indexValue, instanceName, totalCount, chartType) {
    	var chartConfig = pandaChart.getConfigurationByRange($scope.memory.actions.id);
    	memoryIndexCount = chartConfig.dataIndexCount;
    	memoryChartIterationCount = chartConfig.chartIterationCount;
    	$scope.memoryFlotOptions.xaxes[0].tickSize = chartConfig.tickSize;


    	$scope.memoryFlotOptions.colors = ["#62cb31", "#d9534f", "#f0ad4e", "#48a9da"];
		if(indexValue == 0 && totalCount != -1) {
			memoryChartIteration++;
    	}

		if(memoryChartIteration == memoryChartIterationCount || totalCount == -1) {
    		forAdditionlTenIndex = 0;
    		if(indexValue == totalCount)
    			memoryChartIteration = 0;
		    var hasServer = appService.promiseAjax.httpRequest("GET", "http://192.168.1.137:4242/api/"+ url);
		    hasServer.then(function (result) {

		    	if(angular.isUndefined($scope.memoryData)) {
		    		$scope.memoryData = [];
		    	}
		    	$scope.memoryData[indexValue] = [];
		    	for(var i=0; i < result.length; i++ ) {
		    		var dataPoints = result[i].dps;
		    		var dataIndex = 0;
		    		memoryForAdditionalIterations[indexValue] = [];
			    	angular.forEach(dataPoints, function(obj, key) {
			    		dataIndex++;
		    			var currentValue = obj;
			    		if(dataIndex <= memoryIndexCount) {
					        $scope.memoryData[indexValue].push([getDateByTime(key).getTime(), currentValue]);
			    		} else {
			    			memoryForAdditionalIterations[indexValue].push([getDateByTime(key).getTime(), currentValue]);
			    		}
			    	});

			    	var currentData =  {
		    			data : $scope.memoryData[indexValue],
		    			yaxis : 100,
		    			label : "Memory " + indexValue,
		    			color : memoryColorLabels[indexValue],
		    			points : {
		    				fillColor : memoryColorLabels[indexValue],
		    				show : true
		    			},
		    			idx: indexValue
		    		};

			    	if(angular.isUndefined($scope.memory.dataset[i])) {
			    		$scope.memory.dataset[indexValue] = {
			    				data: []
			    		};
			    	}
			    	$scope.memory.dataset[indexValue] = currentData;
		    	}
		    });
    	}

		if(indexValue ==0) {
			jQuery('.flot-base,.flot-x-axis, .flot-overlay').removeClass('m-l-n-lg m-l-n-xxl');
		}
		pandaChart.updateChartMarginByRangeAndIndex($scope.memory.actions.id, indexValue, memoryChartIteration);
    }

    var updatePerformance = 0;
    $scope.updateMemoryPerformance = function(memoryResult, memoryAction) {
    	updatePerformance++;
    	memoryChartIteration = 0; memoryTotalDelayCount=0; start = 0; end = 0; forAdditionalTenIndex=0; memoryChartIterationCount = 3;
    	memoryForAdditionalIterations = [];
    	var displayName = "monitor-vm";
    	getMemoryPerformanceByFilters("query?start=" + $scope.memory.actions.id + "-ago&m=sum:os.mem.total{host="+ displayName +"}", 0,  displayName.toLowerCase(), -1);
    	getMemoryPerformanceByFilters("query?start=" + $scope.memory.actions.id + "-ago&m=sum:os.mem.free{host="+ displayName +"}", 1,  displayName.toLowerCase(), -1);
    	getMemoryPerformanceByFilters("query?start=" + $scope.memory.actions.id + "-ago&m=sum:os.mem.used{host="+ displayName +"}", 2,  displayName.toLowerCase(), -1);

    	if(updatePerformance == 1)  {
	    	setInterval(function() {
            	$scope.$apply(function () {
            		getMemoryPerformanceByFilters("query?start=" + $scope.memory.actions.id + "-ago&m=sum:os.mem.total{host="+ displayName +"}", 0,  displayName.toLowerCase(), 3);
            		getMemoryPerformanceByFilters("query?start=" + $scope.memory.actions.id + "-ago&m=sum:os.mem.free{host="+ displayName +"}", 1,  displayName.toLowerCase(), 3);
            		getMemoryPerformanceByFilters("query?start=" + $scope.memory.actions.id + "-ago&m=sum:os.mem.used{host="+ displayName +"}", 2,  displayName.toLowerCase(), 3);
            	});
            }, 5000);
    	}

    }










    $scope.storage = {
    		result: [],
    		actions: {id: "5m", name: 'Last 5 minutes'}
    };
	$scope.storage.dataset = [];
    $scope.storageFlotOptions = {
    		series: {
    	          splines: {
    	                show: true,
    	                lineWidth: 1.5,
    	                fill: 0.1
    	            },
    	      },
          legend: {
        	  noColumns: 8,
        	  container: "#storageLegendContainer",
        	  show: true,
              position:"nw",
              labelFormatter: function(label, series){
                return '<a href="javascript:void(0)" data-ng-click="togglePlot('+series.idx+'); return false;">'+label+'</a>';
              }
          },

          xaxes: [{
    	        mode: "time",
    	        timeformat: "%H:%M:%S",
    	        tickSize: [5, "minute"],
    	        tickFormatter: function (v, axis) {
    	        	var date = new Date(v);
    	        	return pandaChart.getChartLabelByRangeAndDate($scope.cpu.actions.id, date);

    	        },
    	        axisLabel: "Date",
    	        axisLabelUseCanvas: true,
    	        axisLabelFontSizePixels: 12,
    	        axisLabelFontFamily: 'Verdana, Arial',
    	        axisLabelPadding: 10
    	    }],

          grid: {
              hoverable: true,
              mouseActiveRadius: 30,
              tickColor: "#dddddd",
              borderWidth: 0.5,
              borderColor: '#dddddd',
              color: 'red',

              axisMargin: 15
          },
          tooltip: {
              show: true,
              content: "%s | x: %x; y: %y"
            },
          colors: [],
        };



    var storageIndexCount = 12;
    var storageColorLabels = ["#62cb31", "#d9534f", "#f0ad4e", "#48a9da"];
    var storageChartIteration = 0; storageTotalDelayCount=0; storageChartIterationCount = 3;
    var storageForAdditionalIterations = [];

    function getStoragePerformanceByFilters(url, indexValue, instanceName, totalCount, chartType) {
    	var chartConfig = pandaChart.getConfigurationByRange($scope.storage.actions.id);
    	storageIndexCount = chartConfig.dataIndexCount;
    	storageChartIterationCount = chartConfig.chartIterationCount;
    	$scope.storageFlotOptions.xaxes[0].tickSize = chartConfig.tickSize;


    	$scope.storageFlotOptions.colors = ["#62cb31", "#d9534f", "#f0ad4e", "#48a9da"];
		if(indexValue == 0 && totalCount != -1) {
			storageChartIteration++;
    	}

		if(storageChartIteration == storageChartIterationCount || totalCount == -1) {
    		forAdditionlTenIndex = 0;
    		if(indexValue == totalCount)
    			storageChartIteration = 0;
		    var hasServer = appService.promiseAjax.httpRequest("GET", "http://192.168.1.137:4242/api/"+ url);
		    hasServer.then(function (result) {

		    	if(angular.isUndefined($scope.storageData)) {
		    		$scope.storageData = [];
		    	}
		    	$scope.storageData[indexValue] = [];
		    	for(var i=0; i < result.length; i++ ) {
		    		var dataPoints = result[i].dps;
		    		var dataIndex = 0;
		    		storageForAdditionalIterations[indexValue] = [];
			    	angular.forEach(dataPoints, function(obj, key) {
			    		dataIndex++;
		    			var currentValue = obj;
			    		if(dataIndex <= storageIndexCount) {
					        $scope.storageData[indexValue].push([getDateByTime(key).getTime(), currentValue]);
			    		} else {
			    			storageForAdditionalIterations[indexValue].push([getDateByTime(key).getTime(), currentValue]);
			    		}
			    	});

			    	var currentData =  {
		    			data : $scope.storageData[indexValue],
		    			yaxis : 100,
		    			label : "Storage " + indexValue,
		    			color : storageColorLabels[indexValue],
		    			points : {
		    				fillColor : storageColorLabels[indexValue],
		    				show : true
		    			},
		    			idx: indexValue
		    		};

			    	if(angular.isUndefined($scope.storage.dataset[i])) {
			    		$scope.storage.dataset[indexValue] = {
			    				data: []
			    		};
			    	}
			    	$scope.storage.dataset[indexValue] = currentData;
		    	}
		    });
    	}

		if(indexValue ==0) {
			jQuery('.flot-base,.flot-x-axis, .flot-overlay').removeClass('m-l-n-lg m-l-n-xxl');
			jQuery('.flot-base, .flot-x-axis, .flot-overlay').addClass("testcls");
			jQuery('.cpu-chart-container').find('.flot-base,.flot-x-axis, .flot-overlay').css({"backgroundColor":"red","color":"red"});
		}
		pandaChart.updateChartMarginByRangeAndIndex($scope.storage.actions.id, indexValue, storageChartIteration);
    }

    var updatePerformance = 0;
    $scope.updateStoragePerformance = function(storageResult, storageAction) {
    	updatePerformance++;
    	storageChartIteration = 0; storageTotalDelayCount=0; start = 0; end = 0; forAdditionalTenIndex=0; storageChartIterationCount = 3;
    	storageForAdditionalIterations = [];
    	var displayName = "monitor-vm";
    	getStoragePerformanceByFilters("query?start=" + $scope.storage.actions.id + "-ago&m=sum:linux.disk.write_requests{host="+ displayName +"}", 0,  displayName.toLowerCase(), -1);
    	getStoragePerformanceByFilters("query?start=" + $scope.storage.actions.id + "-ago&m=sum:linux.disk.read_requests{host="+ displayName +"}", 1,  displayName.toLowerCase(), -1);
    	//getStoragePerformanceByFilters("query?start=" + $scope.storage.actions.id + "-ago&m=sum:os.mem.used{host="+ displayName +"}", 2,  displayName.toLowerCase(), -1);

    	if(updatePerformance == 1)  {
	    	setInterval(function() {
            	$scope.$apply(function () {
            		getStoragePerformanceByFilters("query?start=" + $scope.storage.actions.id + "-ago&m=sum:linux.disk.write_requests{host="+ displayName +"}", 0,  displayName.toLowerCase(), 3);
            		getStoragePerformanceByFilters("query?start=" + $scope.storage.actions.id + "-ago&m=sum:linux.disk.read_requests{host="+ displayName +"}", 1,  displayName.toLowerCase(), 3);
            		//getStoragePerformanceByFilters("query?start=" + $scope.storage.actions.id + "-ago&m=sum:os.mem.used{host="+ displayName +"}", 2,  displayName.toLowerCase(), 3);
            	});
            }, 5000);
    	}

    }





	    if ($stateParams.id > 0) {
	        var hasServer = appService.crudService.read("virtualmachine", $stateParams.id);
	        hasServer.then(function (result) {  // this is only run after $http
	            $scope.cpu.result = result;
	            var displayName = "monitor-vm";

	            //$scope.updateCpuPerformance($scope.cpu.result, $scope.cpu.actions.id);
//	            var displayName = result.displayName.toLowerCase();
	            //getCpuPerformance("query?start=1m-ago&m=sum:rate:linux.cpu{host="+ displayName +"}", 0, result.displayName.toLowerCase());
	            //for(var cpuCores=0; cpuCores < 4; cpuCores++) {
	            	//getCpuPerformance("query?start=" + $scope.cpu.actions.id + "-ago&m=sum:linux.cpu.percpu{host="+ displayName +",cpu=" + cpuCores + "}", cpuCores, result.displayName.toLowerCase(), -1);
	            //}
//	            getMemoryPerformance("query?start=1m-ago&m=sum:os.mem.total{host="+ displayName +"}", 0,  result.displayName.toLowerCase());
//	            getMemoryPerformance("query?start=1m-ago&m=sum:os.mem.free{host="+ displayName +"}", 1,  result.displayName.toLowerCase());
//	            getMemoryPerformance("query?start=1m-ago&m=sum:os.mem.used{host="+ displayName +"}", 2,  result.displayName.toLowerCase());

	            //getStorageIO("query?start=1m-ago&m=sum:linux.disk.write_requests{host="+ displayName +"}", 0,  result.displayName.toLowerCase());
	            //getStorageIO("query?start=1m-ago&m=sum:linux.disk.read_requests{host="+ displayName +"}", 1,  result.displayName.toLowerCase());

	            setInterval(function() {
	            	$scope.$apply(function () {
	            		//result.computeOffering.numberOfCores
	    	    	//getCpuPerformance("query?start=1m-ago&m=sum:rate:linux.cpu{host="+ displayName +"}", 0, result.displayName.toLowerCase());
	    	    	for(var cpuCores=0; cpuCores < 4; cpuCores++) {
		            	//getCpuPerformance("query?start=" + $scope.cpu.actions.id + "-ago&m=sum:linux.cpu.percpu{host="+ displayName +",cpu=" + cpuCores + "}", cpuCores, result.displayName.toLowerCase(), 3);
		            }
//		            getMemoryPerformance("query?start=1m-ago&m=sum:os.mem.total{host="+ displayName +"}", 0,  result.displayName.toLowerCase());
//		            getMemoryPerformance("query?start=1m-ago&m=sum:os.mem.free{host="+ displayName +"}", 1, result.displayName.toLowerCase());
//	            	getMemoryPerformance("query?start=1m-ago&m=sum:os.mem.used{host="+ displayName +"}", 2, result.displayName.toLowerCase());

	            	//getStorageIO("query?start=1m-ago&m=sum:linux.disk.write_requests{host="+ displayName +"}", 0,  result.displayName.toLowerCase());
		           // getStorageIO("query?start=1m-ago&m=sum:linux.disk.read_requests{host="+ displayName +"}", 1,  result.displayName.toLowerCase());
	            	});
	            }, 5000);

	        });
	    }


}