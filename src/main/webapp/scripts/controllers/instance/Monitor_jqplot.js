/**
 * http://usejsdoc.org/
 */
angular.module('homer').controller('monitorsCtrl', monitorCtrl)

function monitorCtrl($scope, $rootScope, $http, $stateParams, appService, webSockets, $timeout) {
    /** Websocket and stackwatch connection. */
    var webSocket = {};
    $rootScope.messages = '';
    $rootScope.initiateConnection = 0;
    var headers = {};
    $scope.instance = {};
    $scope.uuid = "079f3a02-69be-47b7-9bdf-3319543aa821";
    $scope.monitorMemoryImage = true;
    
    /** cpu plot variables. */
    $scope.cpuData = [];
    $scope.cpuDataLength = 0;
    $scope.cpuTempData = [];
    $scope.cpuMaxData = []; 
    $scope.cpuLabels = [];    
    $scope.chartSeriesIndex = 1000; 
    
    /** disk plot variables. */
    $scope.diskReadData = [];
    $scope.diskWriteData = [];
    $scope.diskDataLength = 0;
    $scope.diskReadTempData = [];
    $scope.diskWriteTempData = [];
    $scope.diskMaxData = []; 
    $scope.diskLabels = [];
    $scope.diskChartSeriesIndex = 1000; 
    $scope.dynamicReadUpdate = 0;
    $scope.dynamicWriteUpdate = 0;
    
     /** memory plot variables. */
    $scope.memoryTotalData = [];
    $scope.memoryFreeData = [];
    $scope.memoryDataLength = 0;
    $scope.memoryFreeTempData = [];
    $scope.memoryTotalTempData = [];
    $scope.memoryMaxData = []; 
    $scope.memoryLabels = [];    
    $scope.memoryChartSeriesIndex = 1000; 
    $scope.memoryFreeIndex = 0;
    $scope.memoryTotalIndex = 0;
    
    
     /** network plot variables. */
    $scope.networkInData = [];
    $scope.networkOutData = [];
    $scope.networkDataLength = 0;
    $scope.networkInTempData = [];
    $scope.networkOutTempData = [];
    $scope.networkMaxData = []; 
    $scope.networkLabels = [];    
    $scope.networkChartSeriesIndex = 1000;    
    $scope.dynamicInUpdate = 0;
    $scope.dynamicOutUpdate = 0;
    
    // Range for performance duration.
    $scope.range = {
        cpu : {actions : {}},
        disk : {actions : {}},
        network : {actions : {}},
        memory : {actions : {}}
    };    
    
    $scope.seriesColors = [ "#62cb31", "#d9534f", "#f0ad4e", "#48a9da", "#9ACD32", "#FFFF00", "#F5DEB3",
                        "#EE82EE", "#40E0D0", "#D8BFD8", "#008080", "#4682B4", "#708090", "#2E8B57", "#FA8072",
                        "#800080", "#DB7093", "#DA70D6", "#FFE4B5", "#7B68EE", "#9370DB", "#FF00FF", "#00FF00",
                       "#FFB6C1" ];
                   
    var cpuPlot; // cpu plot
    var diskPlot; // disk plot
    var networkPlot; // disk plot
    var memoryPlot; // disk plot
    
    //refresh time (in millisec)
    var t = 5000;
    
    /** cpu chart options.*/
    var cpuChart = appService.monitor.getPandaChart();
    $scope.cpuOptions = cpuChart.chartOptions;
    
    /** disk chart options. */
    var diskChart = appService.monitor.getPandaChart();
    $scope.diskOptions = diskChart.chartOptions;
    
    /** memory chart options. */
    var memoryChart = appService.monitor.getPandaChart();
    $scope.memoryOptions = memoryChart.chartOptions;
    
    /** network chart options. */
    var networkChart = appService.monitor.getPandaChart();
    $scope.networkOptions = networkChart.chartOptions;
    
    // Overall ranges.
    $scope.instanceElements = {
        actions : [ {
            id : '5m',
            name : 'Last 5 minutes'
        }, {
            id : '15m',
            name : 'Last 15 minutes'
        }, {
            id : '30m',
            name : 'Last 30 minutes'
        }, {
            id : '45m',
            name : 'Last 45 minutes'
        }, {
            id : '1h',
            name : 'Last 1 hour'
        }
        ]
    };
    
    

    /** initial load. */
    $scope.$watch('$viewContentLoaded', function() {        
        cpuPlot = jQuery.jqplot('cpuChart',  [] , $scope.cpuOptions);
        cpuPlot.redraw(false);
        diskPlot = jQuery.jqplot('diskChart',  [] , $scope.diskOptions);
        diskPlot.redraw(false);
        networkPlot = jQuery.jqplot('networkChart',  [] , $scope.networkOptions);
        networkPlot.redraw(false);
        memoryPlot = jQuery.jqplot('memoryChart',  [] , $scope.memoryOptions);
        memoryPlot.redraw(false);
        
        $scope.range.cpu.actions = $scope.instanceElements.actions[0];
        $scope.range.disk.actions = $scope.instanceElements.actions[0];
        $scope.range.memory.actions = $scope.instanceElements.actions[0]; 
        $scope.range.network.actions = $scope.instanceElements.actions[0];
    });
           
    /** Establish webscoket connection by uuid, user id.*/
    var initStompClient = function() {        
        var hasServer = appService.crudService.read("virtualmachine", $stateParams.id);
        hasServer.then(function(result) {
            $scope.instance = result;
            $scope.uuid = result.uuid;
            $scope.hostName = result.displayName;
            webSockets.init(appService.globalConfig.MONITOR_SOCKET_URL + 'stack/watch', $scope.uuid);
            webSockets.connect(function(frame) {           
            $scope.range.cpu.actions = $scope.instanceElements.actions[0];
            $scope.range.disk.actions = $scope.instanceElements.actions[0];
            $scope.range.memory.actions = $scope.instanceElements.actions[0]; 
            $scope.range.network.actions = $scope.instanceElements.actions[0];                 
             webSockets.send("/metrics", {}, JSON.stringify({
            "uuid" : $scope.uuid,
            "userId" : appService.globalConfig.sessionValues.id,
            "cpu" : $scope.range.cpu.actions.id + "-ago",
            "network" : $scope.range.network.actions.id + "-ago",
            "memory" : $scope.range.memory.actions.id + "-ago",
            "disk" : $scope.range.disk.actions.id + "-ago"
            }));
            dataSubscribe();            
            }, function(error) {
            });
        });
    };
    
    function squash(arr){
        var tmp = [];
        for(var i = 0; i < arr.length; i++){
            if(tmp.indexOf(arr[i]) == -1){
                tmp.push(arr[i]);
            }
        }
        return tmp;
    }
    
    var graphTooltip = {

        getNetworkToolTipContent : function(type, iname) {
            var contents = "<div class='text-center'><b>" + graphTooltip.getCurrentDate() + "</b></div>";
            contents += "<div><b>swagent.network." + type + "{host=" + $scope.hostName + ",iname=" + iname + "} : %y (Bps)</b></div>";
            return contents;
        },

        getDiskToolTipContent : function(type, disk) {
            var contents = "<div class='text-center'><b>" + graphTooltip.getCurrentDate() + "</b></div>";
            contents += "<div><b>swagent.disk." + type + "_requests{host=" + $scope.hostName + ",disk=" + disk + "} : %y (Bps)</b></div>";
            return contents;
        },

        getMemoryToolTipContent : function(type) {
            var contents = "<div class='text-center'><b>" + graphTooltip.getCurrentDate() + "</b></div>";
            contents += "<div><b>swagent.memory." + type + "{host=" + $scope.hostName + "} : %y (MB)</b></div>";
            return contents;
        },

        getCpuToolTipContent : function(label, x, y) {
            var contents = "<div class='text-center'><b>" + graphTooltip.getCurrentDate() + "</b></div>";
            if (!angular.isUndefined($scope.cpuIndex)) {
                contents += "<div><b>swagent.percpu{host=" + $scope.hostName + ", core=CPU " + $scope.cpuIndex + "} : " + y
                        .toFixed(2) + "</b></div>";
            } else {
                contents += "<div><b>swagent.percpu{host=" + $scope.hostName + ", core=CPU 0} : " + y.toFixed(2) + "</b></div>";
            }
            return contents;
        }

    }
    
    /** Toggle cpu series.*/
    $scope.toggleCpuPlot = function($index, cpuLabel){
            if(cpuLabel != 'All') {
                angular.forEach(cpuPlot.series, function(value, key){
                    if(key == $index){
                       cpuPlot.series[key].show = true;
                       cpuPlot.redraw(true);
                       $scope.chartSeriesIndex = key
                    } else{
                       cpuPlot.series[key].show = false;
                       cpuPlot.redraw(true);
                    }
                });
            } else {
             angular.forEach(cpuPlot.series, function(value, key){
                    cpuPlot.series[key].show = true;
                    cpuPlot.redraw(true);
             });  
           }
    };
    
    /** Toggle disk series.*/
    $scope.toggleDiskPlot = function($index, diskLabel){
            if(diskLabel != 'All') {
                angular.forEach(diskPlot.series, function(value, key){
                    if(key == $index){
                       diskPlot.series[key].show = true;
                       diskPlot.redraw(true);
                       $scope.diskchartSeriesIndex = key
                    } else{
                       diskPlot.series[key].show = false;
                       diskPlot.redraw(true);
                    }
                });
            } else {
             angular.forEach(diskPlot.series, function(value, key){
                    diskPlot.series[key].show = true;
                    diskPlot.redraw(true);
             });  
           }
    };
    
    /** Toggle network series.*/
    $scope.toggleNetworkPlot = function($index, networkLabel){
            if(networkLabel != 'All') {
                angular.forEach(networkPlot.series, function(value, key){
                    if(key == $index){
                       networkPlot.series[key].show = true;
                       networkPlot.redraw(true);
                       $scope.networkchartSeriesIndex = key
                    } else{
                       networkPlot.series[key].show = false;
                       networkPlot.redraw(true);
                    }
                });
            } else {
             angular.forEach(networkPlot.series, function(value, key){
                    networkPlot.series[key].show = true;
                    networkPlot.redraw(true);
             });  
           }
    };
    
    /** Toggle memory series.*/
    $scope.toggleMemoryPlot = function($index, memoryLabel) {
            if(memoryLabel != 'All') {
                angular.forEach(memoryPlot.series, function(value, key){
                    if(key == $index){
                       memoryPlot.series[key].show = true;
                       memoryPlot.redraw(true);
                       $scope.memorychartSeriesIndex = key
                    } else{
                       memoryPlot.series[key].show = false;
                       memoryPlot.redraw(true);
                    }
                });
            } else {
             angular.forEach(memoryPlot.series, function(value, key){
                    memoryPlot.series[key].show = true;
                    memoryPlot.redraw(true);
             });  
           }
    };
    
    /** Plot cpu series.*/
    function getCpuPerformanceByFilter(data, interval) {
        $scope.cpuOptions = cpuChart.chartOptions;
        if(!angular.isUndefined(data[0]) && data[0].length > 0){
            $scope.cpuOptions.axes.xaxis.max = data[0][data[0].length-1][0];
            $scope.cpuOptions.axes.xaxis.min = data[0][data[0][0]];
        }
        $scope.cpuOptions.axes.yaxis.max = 100;
        //$scope.cpuOptions.axes.xaxis.tickInterval = cpuChart.getChartLabelByRangeAndDate(interval);
        $scope.cpuOptions.axes.yaxis.min = 0;
        $scope.cpuOptions.axes.yaxis.tickOptions.formatString = '%d';
        $scope.cpuOptions.axes.yaxis.numberTicks = 10;
        angular.forEach($scope.cpuLabels, function(value, key) {
            if(!value.indexOf('All') > -1) {
            $scope.cpuOptions.highlighter.labels.push("swagent.percpu{host=" + $scope.hostName + ", core= "+ value + "} : ");
            }
        });
        $scope.cpuOptions.highlighter.labels = squash($scope.cpuOptions.highlighter.labels);
        if (cpuPlot) {
            cpuPlot.destroy();                                
            cpuPlot = jQuery.jqplot ('cpuChart', data, $scope.cpuOptions);
        } 
    }
    
    /** Plot disk series.*/
    function getDiskPerformanceByFilter(readData, writeData, interval) {
        if(!angular.isUndefined(readData[0]) && readData[0].length > 0){
            $scope.diskOptions.axes.xaxis.max = readData[0][readData[0].length-1][0];
            $scope.diskOptions.axes.xaxis.min = readData[0][0][0];
        }
        $scope.diskOptions.axes.yaxis.max = Math.max.apply(Math,$scope.diskMaxData);
        $scope.diskOptions.axes.yaxis.min = 0;
        //$scope.cpuOptions.axes.xaxis.tickInterval = cpuChart.getChartLabelByRangeAndDate(interval);
         var chartReadData = [];
        if(readData.length > 0) {
            for(i=0; i< readData.length; i++) {
                chartReadData .push(readData[i]) ;
            }
        }
        if(writeData.length > 0) {
            for(i=0; i< writeData.length; i++) {
                chartReadData .push(writeData[i]) ;
            }
        }  
        angular.forEach($scope.diskLabels, function(value, key) {
            if(!value.indexOf('All') > -1) {
                if(value.indexOf('Read') > -1) {
                    $scope.diskOptions.highlighter.labels.push("swagent.disk.read" + "_requests{host=" + $scope.hostName + ", disk= "+ value.split(' ')[0] + "} (Bps): ");
                } 
                if(value.indexOf('Write') > -1){
                    $scope.diskOptions.highlighter.labels.push("swagent.disk.write" + "_requests{host=" + $scope.hostName + ", disk= "+ value.split(' ')[0] + "} (Bps): "); 
                }
            }
        });
        $scope.diskOptions.highlighter.labels = squash($scope.diskOptions.highlighter.labels);
        
        if (diskPlot) {
            diskPlot.destroy();                                
            diskPlot = jQuery.jqplot ('diskChart', chartReadData , $scope.diskOptions);
        }    
    }
    
    /** Plot memory series.*/
    function getMemoryPerformanceByFilter(freeData, totalData, interval) {       
        if(!angular.isUndefined(freeData) && freeData.length > 0){
            $scope.memoryOptions.axes.xaxis.max = freeData[freeData.length-1][0];
            $scope.memoryOptions.axes.xaxis.min = freeData[0][0];
        }
        $scope.memoryOptions.axes.yaxis.max = Math.max.apply(Math,$scope.memoryMaxData);
        $scope.memoryOptions.axes.yaxis.min = 0;
        //$scope.cpuOptions.axes.xaxis.tickInterval = cpuChart.getChartLabelByRangeAndDate(interval);
        var chartData = [];
        chartData .push(freeData);
        chartData .push(totalData); 
        angular.forEach($scope.memoryLabels, function(value, key) {
            if(!value.indexOf('All') > -1) {
                if(value.indexOf('Free') > -1) {
                    $scope.memoryOptions.highlighter.labels.push("swagent.memory.free" + "{host=" + $scope.hostName + "} (MB): ");
                } 
                if(value.indexOf('Total') > -1){
                    $scope.memoryOptions.highlighter.labels.push("swagent.memory.total" + "{host=" + $scope.hostName + "} (MB) : "); 
                }
            }
        });
        $scope.memoryOptions.highlighter.labels = squash($scope.memoryOptions.highlighter.labels);
        if (memoryPlot) {
            memoryPlot.destroy();                                
            memoryPlot = jQuery.jqplot ('memoryChart', chartData , $scope.memoryOptions);            
        }    
    }
    
    /** Plot Network Series.*/
    function getNetworkPerformanceByFilter(inData, outData, interval) {
        if(!angular.isUndefined(inData[0]) && inData[0].length > 0){
            $scope.networkOptions.axes.xaxis.max = inData[0][inData[0].length-1][0];
            $scope.networkOptions.axes.xaxis.min = inData[0][0][0];
        }
        $scope.networkOptions.axes.yaxis.max = Math.max.apply(Math,$scope.networkMaxData);
        $scope.networkOptions.axes.yaxis.min = 0;
        //$scope.cpuOptions.axes.xaxis.tickInterval = cpuChart.getChartLabelByRangeAndDate(interval);
        var chartData = [];
        if(inData.length > 0) {
            for(i=0; i< inData.length; i++) {
                chartData .push(inData[i]) ;
            }
        }
        if(outData.length > 0) {
            for(i=0; i< outData.length; i++) {
                chartData .push(outData[i]) ;
            }
        } 
        
        angular.forEach($scope.networkLabels, function(value, key) {
            if(!value.indexOf('All') > -1) {
                if(value.indexOf('In') > -1) {
                    $scope.networkOptions.highlighter.labels.push("swagent.network.receive" + "{host=" + $scope.hostName + ", iname= "+ value.split(' ')[0] + "} (Bps): ");
                } 
                if(value.indexOf('Out') > -1){
                    $scope.networkOptions.highlighter.labels.push("swagent.network.send" + "{host=" + $scope.hostName + ", iname= "+ value.split(' ')[0] + "} (Bps): "); 
                }
            }
        });
        $scope.networkOptions.highlighter.labels = squash($scope.networkOptions.highlighter.labels);
      
        
        if (networkPlot) {
            networkPlot.destroy();                                
            networkPlot = jQuery.jqplot ('networkChart', chartData , $scope.networkOptions);
        }    
    }
    
    function updateCpuPoints(data, interval) {          
        if (cpuPlot) {
            cpuPlot.destroy();
        }
        //$scope.cpuOptions.axes.xaxis.tickInterval = cpuChart.getChartLabelByRangeAndDate(interval);
        for(i=0; i< $scope.cpuData.length; i++) {
            if(!angular.isUndefined($scope.cpuData[i])) {
                if ($scope.cpuData[i].length > $scope.cpuDataLength - 1) {
                    $scope.cpuData[i].shift();
                }  
                if ($scope.cpuTempData.length > 0) {
                if  ($scope.cpuTempData[i].length > 0) {
                    var dataPoint = $scope.cpuTempData[i].shift(); 
                    $scope.cpuData[i].push(dataPoint);                     
                    $scope.cpuMaxData.shift();
                    if(i == $scope.chartSeriesIndex) {
                       // $scope.cpuOptions.series[i].show = true;
                    } else {
                       // $scope.cpuOptions.series[i].show = false;
                    }                    
                }
            }
                
            }
        }
        if (!angular.isUndefined($scope.cpuData[0]) && $scope.cpuData[0].length > 0) {
            $scope.cpuOptions.axes.xaxis.max = $scope.cpuData[0][$scope.cpuData[0].length -1][0];
            $scope.cpuOptions.axes.xaxis.min = $scope.cpuData[0][0][0];            
        }
        
        //$scope.cpuOptions.axes.yaxis.max =   Math.max.apply(Math, $scope.cpuMaxData);               
        var chartData = [];
        if($scope.cpuData.length > 0) {
            for(i=0; i< $scope.cpuData.length; i++) {
                chartData .push($scope.cpuData[i]) ;
            }
        }        
        if(chartData.length > 0) {
            cpuPlot = jQuery.jqplot ('cpuChart', chartData, $scope.cpuOptions);
            $scope.monitorMemoryImage = false;
        } else {
            cpuPlot = jQuery.jqplot ('cpuChart', [chartData], $scope.cpuOptions);
        }
        cpuPlot.redraw(false);
        $timeout(function() {
            updateCpuPoints($scope.cpuTempData, $scope.range.cpu.actions.id);            
        }, t);
        
    }
    
    function updateDiskPoints(data, data1, interval) {          
        if (diskPlot) {
            diskPlot.destroy();
        }
        var count = 0;
        //$scope.diskOptions.axes.xaxis.tickInterval = cpuChart.getChartLabelByRangeAndDate(interval);
        for(i=0; i< $scope.diskReadData.length; i++) {
            if(!angular.isUndefined($scope.diskReadData[i])) {
                if ($scope.diskReadData[i].length > $scope.diskDataLength - 1 && $scope.dynamicReadUpdate > 0) {
                    $scope.diskReadData[i].shift();
                    $scope.dynamicReadUpdate--;
                }  
                if ($scope.diskReadTempData.length > 0) {
                if  ($scope.diskReadTempData[i].length > 0) {
                    var dataPoint = $scope.diskReadTempData[i].shift(); 
                    count ++;
                    $scope.diskReadData[i].push(dataPoint); 
                    if(i == $scope.diskChartSeriesIndex) {
                       // $scope.diskOptions.series[i].show = true;
                    } else {
                       // $scope.diskOptions.series[i].show = false;
                    }                    
                }
            }                
            }
        }
        for(i=0; i< $scope.diskWriteData.length; i++) {
            if(!angular.isUndefined($scope.diskWriteData[i])) {
                if ($scope.diskWriteData[i].length > $scope.diskDataLength - 1 && $scope.dynamicWriteUpdate > 0 ) {
                    $scope.diskWriteData[i].shift();
                    $scope.dynamicWriteUpdate--;
                }  
                if ($scope.diskWriteTempData.length > 0) {
                if  ($scope.diskWriteTempData[i].length > 0) {
                    var dataPoint = $scope.diskWriteTempData[i].shift(); 
                    $scope.diskWriteData[i].push(dataPoint);  
                    if(i == $scope.diskChartSeriesIndex) {
                        //$scope.diskOptions.series[i+ ($scope.diskReadData.length-1)].show = true;
                    } else {
                        //$scope.diskOptions.series[i+($scope.diskReadData.length-1)].show = false;
                    }                    
                }
            }                
            }
        }        
        for (i =0;i< count; i++) { 
            $scope.diskMaxData.shift();
        }
        if (!angular.isUndefined($scope.diskReadData[0]) && $scope.diskReadData[0].length > 0) {
            $scope.diskOptions.axes.xaxis.max = $scope.diskReadData[0][$scope.diskReadData[0].length -1][0];
            $scope.diskOptions.axes.xaxis.min = $scope.diskReadData[0][0][0];            
        }
        
        $scope.diskOptions.axes.yaxis.max =   Math.max.apply(Math, $scope.diskMaxData);     
        var chartData = [];
        if($scope.diskReadData.length > 0) {
            for(i=0; i< $scope.diskReadData.length; i++) {
                chartData .push($scope.diskReadData[i]) ;
            }
        }
        if($scope.diskWriteData.length > 0) {
            for(i=0; i< $scope.diskWriteData.length; i++) {
                chartData .push($scope.diskWriteData[i]) ;
            }
        }
        if(chartData.length > 0) {
            diskPlot = jQuery.jqplot ('diskChart', chartData, $scope.diskOptions);
        } else {
            diskPlot = jQuery.jqplot ('diskChart', [chartData], $scope.diskOptions);
        }
        diskPlot.redraw(false);
        $timeout(function() {
            updateDiskPoints($scope.diskReadTempData, $scope.diskWriteTempData, $scope.range.disk.actions.id)
        }, t);
    }
    
    function updateNetworkPoints(data, data1, interval) {          
        if (networkPlot) {
            networkPlot.destroy();
        }
        var count = 0;
        //$scope.diskOptions.axes.xaxis.tickInterval = cpuChart.getChartLabelByRangeAndDate(interval);        
        for(i=0; i< $scope.networkInData.length; i++) {
            if(!angular.isUndefined($scope.networkInData[i])) {
                if ($scope.networkInData[i].length > $scope.networkDataLength - 1 && $scope.dynamicInUpdate > 0) {
                    $scope.networkInData[i].shift();
                    $scope.dynamicInUpdate--;
                }  
                if ($scope.networkInTempData.length > 0) {
                if  ($scope.networkInTempData[i].length > 0) {
                    var dataPoint = $scope.networkInTempData[i].shift(); 
                    count ++;
                    $scope.networkInData[i].push(dataPoint); 
                    if(i == $scope.networkChartSeriesIndex) {
                       // $scope.diskOptions.series[i].show = true;
                    } else {
                       // $scope.diskOptions.series[i].show = false;
                    }                    
                }
            }                
            }
        }
        for(i=0; i< $scope.networkOutData.length; i++) {
            if(!angular.isUndefined($scope.networkOutData[i])) {
                if ($scope.networkOutData[i].length > $scope.networkDataLength - 1 && $scope.dynamicOutUpdate > 0 ) {
                    $scope.networkOutData[i].shift();
                    $scope.dynamicOutUpdate--;
                }  
                if ($scope.networkOutTempData.length > 0) {
                if  ($scope.networkOutTempData[i].length > 0) {
                    var dataPoint = $scope.networkOutTempData[i].shift();
                    $scope.networkOutData[i].push(dataPoint);  
                    if(i == $scope.networkChartSeriesIndex) {
                        //$scope.diskOptions.series[i+ ($scope.diskReadData.length-1)].show = true;
                    } else {
                        //$scope.diskOptions.series[i+($scope.diskReadData.length-1)].show = false;
                    }                    
                }
            }                
            }
        }        
        for (i =0;i< count; i++) { 
            $scope.networkMaxData.shift();
        }
        if (!angular.isUndefined($scope.networkInData[0]) && $scope.networkInData[0].length > 0) {
            $scope.networkOptions.axes.xaxis.max = $scope.networkInData[0][$scope.networkInData[0].length -1][0];
            $scope.networkOptions.axes.xaxis.min = $scope.networkInData[0][0][0];            
        }
        
        $scope.networkOptions.axes.yaxis.max =   Math.max.apply(Math, $scope.networkMaxData);     
        var chartData = [];
        if($scope.networkInData.length > 0) {
            for(i=0; i< $scope.networkInData.length; i++) {
                chartData .push($scope.networkInData[i]) ;
            }
        }
        if($scope.networkOutData.length > 0) {
            for(i=0; i< $scope.networkOutData.length; i++) {
                chartData .push($scope.networkOutData[i]) ;
            }
        }
        if(chartData.length > 0) {
            networkPlot = jQuery.jqplot ('networkChart', chartData, $scope.networkOptions);
        } else {
            networkPlot = jQuery.jqplot ('networkChart', [chartData], $scope.networkOptions);
        }
        networkPlot.redraw(false);
        $timeout(function() {
            updateNetworkPoints($scope.networkInTempData, $scope.networkOutTempData, $scope.range.network.actions.id)
        }, t);
    }
    
    
     function updateMemoryPoints(data, data1, interval) {          
       if (memoryPlot) {
            memoryPlot.destroy();
        }
        
        $scope.memoryFreeIndex = $scope.memoryFreeTempData.length;
        //$scope.cpuOptions.axes.xaxis.tickInterval = cpuChart.getChartLabelByRangeAndDate(interval);
       if(!angular.isUndefined($scope.memoryFreeData)  && $scope.memoryFreeIndex > 0) {
            if ($scope.memoryFreeData.length > $scope.memoryDataLength - 1) {
                $scope.memoryFreeData.shift();
                $scope.memoryTotalData.shift();
                $scope.memoryMaxData.shift();
            } 
        }
        if($scope.memoryFreeTempData.length > 0) {
            var freeDataPoints = $scope.memoryFreeTempData.shift();
            $scope.memoryFreeData.push(freeDataPoints);
        }
        if($scope.memoryTotalTempData.length > 0) {
            var totalDataPoints = $scope.memoryTotalTempData.shift();
            $scope.memoryTotalData.push(totalDataPoints);
        }
        if (!angular.isUndefined($scope.memoryFreeData) && $scope.memoryFreeData.length > 0) {
            $scope.memoryOptions.axes.xaxis.max = $scope.memoryFreeData[$scope.memoryFreeData.length -1][0];
            $scope.memoryOptions.axes.xaxis.min = $scope.memoryFreeData[0][0];  
        }
        
        $scope.memoryOptions.axes.yaxis.max =   Math.max.apply(Math, $scope.memoryMaxData); 
        
        var chartData = [];
        chartData .push($scope.memoryFreeData);
        chartData .push($scope.memoryTotalData);
        
        if(chartData.length > 0) {
            memoryPlot = jQuery.jqplot ('memoryChart', chartData, $scope.memoryOptions);
        } else {
            memoryPlot = jQuery.jqplot ('memoryChart', chartData, $scope.memoryOptions);
        }
        memoryPlot.redraw(false);
        $timeout(function() {
            updateMemoryPoints($scope.memoryFreeTempData, $scope.memoryTotalTempData, $scope.range.memory.actions.id)
        }, t);
    }
    
    function getDateByTime(unixTimeStamp) {
        var date = new Date(unixTimeStamp * 1000);
        return date;
    }
    
    function getUnixTime(date){
        var unixtime = Number(date);
        return unixtime
    }
    
    function isItemInArray(array, item) {
    for (var i = 0; i < array.length; i++) {
        // This if statement depends on the format of your array
        if (getUnixTime(array[i][0]) == getUnixTime(item[0]) && array[i][1] == item[1]) {
            return true;   // Found it
        }
    }
    
    return false;   // Not found
    }
    
    function max(array) {
        Math.max.apply(Math, array.map(function (i) {
            return i[1];
        }));
    }

    $scope.updateGraphByRange = function(type) {
        if (type == 'cpu') {
            webSockets.send("/metrics", {}, JSON.stringify({
            "uuid" : $scope.uuid,
            "userId" : appService.globalConfig.sessionValues.id,
            "cpu" : $scope.range.cpu.actions.id + "-ago"
            }));            
            $scope.cpuData = [];
            $scope.cpuMaxData = [];
            $scope.cpuLabels = [];
            $scope.chartSeriesIndex = "";
            $scope.cpuOptions.axes.yaxis.max = 0;
            //getCpuPerformanceByFilter($scope.cpuData, $scope.range.cpu.actions.id);
         }
         if (type == 'network') {
            webSockets.send("/metrics", {}, JSON.stringify({
            "uuid" : $scope.uuid,
            "userId" : appService.globalConfig.sessionValues.id,
            "network" : $scope.range.network.actions.id + "-ago"
            }));
            $scope.networkInData = [];
            $scope.networkOutData = [];
            $scope.networkDataLength = 0;
            $scope.networkInTempData = [];
            $scope.networkOutTempData = [];
            $scope.networkMaxData = [];
            $scope.networkLabels = []; 
            $scope.networkChartSeriesIndex = 1000;
            $scope.networkOptions.axes.yaxis.max = 0;
         }
         if (type == 'memory') {
            webSockets.send("/metrics", {}, JSON.stringify({
            "uuid" : $scope.uuid,
            "userId" : appService.globalConfig.sessionValues.id,
            "memory" : $scope.range.memory.actions.id + "-ago"
            }));
            $scope.memoryTotalData = [];
            $scope.memoryFreeData = [];
            $scope.memoryDataLength = 0;
            $scope.memoryFreeTempData = [];
            $scope.memoryTotalTempData = [];
            $scope.memoryMaxData = []; 
            $scope.memoryLabels = []; 
            $scope.memoryChartSeriesIndex = "";
            $scope.memoryOptions.axes.yaxis.max = 0;
            
         }
         if (type == 'disk') {
            webSockets.send("/metrics", {}, JSON.stringify({
            "uuid" : $scope.uuid,
            "userId" : appService.globalConfig.sessionValues.id,
            "disk" : $scope.range.disk.actions.id + "-ago"
            }));  
            $scope.diskReadData = [];
            $scope.diskWriteData = [];
            $scope.diskDataLength = 0;
            $scope.diskReadTempData = [];
            $scope.diskWriteTempData = [];
            $scope.diskMaxData = []; 
            $scope.diskLabels = [];
            $scope.diskChartSeriesIndex = "";
            $scope.diskOptions.axes.yaxis.max = 0;
            //getDiskPerformanceByFilter($scope.diskReadData, $scope.diskWriteData, $scope.range.disk.actions.id);
         }        
    }
    
     $scope.updateGraphByRangeAndType = function(min, type) {
         if (type == 'cpu') {
            webSockets.send("/metrics", {}, JSON.stringify({
            "uuid" : $scope.uuid,
            "userId" : appService.globalConfig.sessionValues.id,
            "cpu" : min + "-ago"
            }));  
         }
         if (type == 'network') {
            webSockets.send("/metrics", {}, JSON.stringify({
            "uuid" : $scope.uuid,
            "userId" : appService.globalConfig.sessionValues.id,
            "network" : min + "-ago"
            }));  
         }
         if (type == 'memory') {
            webSockets.send("/metrics", {}, JSON.stringify({
            "uuid" : $scope.uuid,
            "userId" : appService.globalConfig.sessionValues.id,
            "memory" : min + "-ago"
            }));  
         }
         if (type == 'disk') {
            webSockets.send("/metrics", {}, JSON.stringify({
            "uuid" : $scope.uuid,
            "userId" : appService.globalConfig.sessionValues.id,
            "disk" : min + "-ago"
            }));  
         }
    }
    
    
    var dataSubscribe = function() {
        webSockets
                .subscribe("/topic/stackwatch.cpu/" + appService.globalConfig.sessionValues.id + "/" + $scope.uuid, function (message) {
                    $scope.monitorImage = true;
                    var cpuResult = JSON.parse(message.body).perCpuUsage;
                    $scope.cpuCount = cpuResult.length;
                    if (JSON.parse(message.body).duration != "1m-ago") {
                        angular.forEach(angular.fromJson(cpuResult), function (value, key) {
                            var data = [];
                            var dataValue = [];
                            $scope.cpuLabels[key] = value.tags;
                            $scope.cpuOptions.series.push([]);
                            var index = key;
                            if (value.dataPoints.length > 0) {
                                angular.forEach(angular.fromJson(value.dataPoints), function (obj, key) {
                                    var currentValue = obj;
                                    if ($scope.cpuData.length > 0) {
                                        if (!angular.isUndefined($scope.cpuData[index])) {
                                            if (!isItemInArray($scope.cpuData[index], [getDateByTime(key), currentValue])) {
                                                data.push([getDateByTime(key), currentValue]);
                                                dataValue.push(currentValue);
                                            }
                                        } else {
                                            data.push([getDateByTime(key), currentValue]);
                                            dataValue.push(currentValue);
                                        }
                                    } else {
                                        data.push([getDateByTime(key), currentValue]);
                                        dataValue.push(currentValue);
                                    }
                                });
                                if ($scope.cpuData.length > 0) {
                                    $scope.cpuData[key] = data;
                                    $scope.cpuMaxData = dataValue;
                                } else {
                                    $scope.cpuDataLength = data.length;
                                    $scope.cpuData.push(data);
                                    $scope.cpuMaxData.push(dataValue);
                                }
                            } 
                            getCpuPerformanceByFilter($scope.cpuData, $scope.range.cpu.actions.id);
                        });
                        $scope.cpuLabels[angular.fromJson(cpuResult).length] = "All";
                        if ($scope.cpuData.length > 0) {
                            if ($scope.range.cpu.actions.id == '5m' || $scope.range.cpu.actions.id == '15m' || $scope.range.cpu.actions.id == '30m' || $scope.range.cpu.actions.id == '45m' || $scope.range.cpu.actions.id == '1h') {
                                $scope.updateGraphByRangeAndType("1m", "cpu");
                                updateCpuPoints($scope.cpuTempData, $scope.range.cpu.actions.id);
                            }
                        }
                        

                    } else {
                        angular.forEach(angular.fromJson(cpuResult), function (value, key) {
                            var data = [];
                            var dataValue = [];
                            var index = key;
                            if (value.dataPoints.length > 0) {
                                angular.forEach(angular.fromJson(value.dataPoints), function (obj, key) {
                                    var currentValue = obj;
                                    if (!angular.isUndefined($scope.cpuData[index])) {
                                        if (!isItemInArray($scope.cpuData[index], [getDateByTime(key), currentValue])) {
                                            data.push([getDateByTime(key), currentValue]);
                                            dataValue.push(currentValue);
                                        }
                                    }
                                });
                                if (data.length > 0) {
                                $scope.cpuTempData[key] = data;
                                $scope.cpuMaxData.push(dataValue);
                                }
                            }
                        });
                    }
                    
                });
        webSockets
                .subscribe("/topic/stackwatch.memory/" + appService.globalConfig.sessionValues.id + "/" + $scope.uuid, function(message) {
                    var memoryResult = JSON.parse(message.body);
                    if (JSON.parse(message.body).duration != "1m-ago") {
                        angular.forEach(angular.fromJson(memoryResult).free, function (value, key) {
                            var data = [];
                            $scope.memoryLabels.push("Free");
                            $scope.memoryOptions.series.push([]);
                            var index = key;
                                angular.forEach(angular.fromJson(value), function (obj, key) {
                                    var currentValue = obj;
                                    if ($scope.memoryFreeData.length > 0) {
                                        if (!angular.isUndefined($scope.memoryFreeData)) {
                                            if (!isItemInArray($scope.memoryFreeData, [getDateByTime(key), currentValue/ (1024 * 1024)])) {
                                                 $scope.memoryFreeData.push([getDateByTime(key), currentValue/ (1024 * 1024)]);
                                                $scope.memoryMaxData.push(currentValue/ (1024 * 1024));
                                            }
                                        } else {
                                             $scope.memoryFreeData.push([getDateByTime(key), currentValue/ (1024 * 1024)]);
                                            $scope.memoryMaxData.push(currentValue/ (1024 * 1024));
                                        }
                                    } else {
                                        $scope.memoryFreeData.push([getDateByTime(key), currentValue/ (1024 * 1024)]);
                                         $scope.memoryMaxData.push(currentValue/ (1024 * 1024));
                                    }
                                });
                                if ($scope.memoryFreeData.length > 0) {
                                   // $scope.memoryFreeData[key] = data;
                                } else {
                                    $scope.memoryDataLength = data.length;
                                   // $scope.memoryFreeData.push(data);
                                }
                            });
                           angular.forEach(angular.fromJson(memoryResult).total, function (value, key) {
                            var data = [];
                            $scope.memoryOptions.series.push([]);
                            $scope.memoryLabels.push("Total") ;
                            var index = key;
                                angular.forEach(angular.fromJson(value), function (obj, key) {
                                    var currentValue = obj;
                                    if ($scope.memoryTotalData.length > 0) {
                                        if (!angular.isUndefined($scope.memoryTotalData)) {
                                            if (!isItemInArray($scope.memoryTotalData, [getDateByTime(key), currentValue/ (1024 * 1024)])) {
                                                $scope.memoryTotalData.push([getDateByTime(key), currentValue/ (1024 * 1024)]);
                                                $scope.memoryMaxData.push(currentValue/ (1024 * 1024));
                                            }
                                        } else {
                                            $scope.memoryTotalData.push([getDateByTime(key), currentValue/ (1024 * 1024)]);
                                            $scope.memoryMaxData.push(currentValue/ (1024 * 1024));
                                        }
                                    } else {
                                        $scope.memoryTotalData.push([getDateByTime(key), currentValue/ (1024 * 1024)]);
                                        $scope.memoryMaxData.push(currentValue/ (1024 * 1024));
                                    }
                                });
                                if ($scope.memoryTotalData.length > 0) {
                                    //$scope.memoryTotalData[key] = data;
                                } else {
                                    $scope.memoryDataLength = data.length;
                                    //$scope.memoryTotalData.push(data);
                                }
                            }); 
                            $scope.memoryLabels[$scope.memoryLabels.length] = "All";
                            $scope.updateGraphByRangeAndType("1m", "memory"); 
                            getMemoryPerformanceByFilter($scope.memoryFreeData, $scope.memoryTotalData, $scope.range.memory.actions.id);
                            updateMemoryPoints($scope.memoryFreeTempData, $scope.memoryTotalTempData, $scope.range.memory.actions.id);                            

                    } else {
                        angular.forEach(angular.fromJson(memoryResult).free, function (value, key) {
                            var data = [];
                            var index = key;
                                angular.forEach(angular.fromJson(value), function (obj, key) {
                                    var currentValue = obj;
                                    if (!angular.isUndefined($scope.memoryFreeData)) {
                                        if (!isItemInArray($scope.memoryFreeData, [getDateByTime(key), currentValue/ (1024 * 1024)])) {
                                            $scope.memoryFreeTempData.push([getDateByTime(key), currentValue/ (1024 * 1024)]);
                                            $scope.memoryMaxData.push(currentValue/ (1024 * 1024));
                                        }
                                    }
                                });
                        });
                        angular.forEach(angular.fromJson(memoryResult).total, function (value, key) {
                            var data = [];
                            var index = key;
                                angular.forEach(angular.fromJson(value), function (obj, key) {
                                    var currentValue = obj;
                                    if (!angular.isUndefined($scope.memoryTotalData)) {
                                        if (!isItemInArray($scope.memoryTotalData, [getDateByTime(key), currentValue/ (1024 * 1024)])) {
                                            $scope.memoryTotalTempData.push([getDateByTime(key), currentValue/ (1024 * 1024)]);
                                            $scope.memoryMaxData.push(currentValue/ (1024 * 1024));
                                        }
                                    }
                            });
                        });                        
                    }
                    //$scope.updateGraphByRangeAndType("1m", "memory");
                });
        webSockets
                .subscribe("/topic/stackwatch.disk/" + appService.globalConfig.sessionValues.id + "/" + $scope.uuid, function(message) {
                    var diskResult = JSON.parse(message.body);
                    $scope.monitorDiskImage = true;
                    $scope.diskCount = diskResult.read.length;
                    $scope.diskCounts = diskResult.write.length;
                     if (JSON.parse(message.body).duration != "1m-ago") {
                        angular.forEach(angular.fromJson(diskResult).read, function (value, key) {
                            var data = [];
                            $scope.diskLabels[key] = value.tags + ' Read';
                            $scope.diskOptions.series.push([]);
                            var index = key;
                            if (value.dataPoints.length > 0) {
                                angular.forEach(angular.fromJson(value.dataPoints), function (obj, key) {
                                    var currentValue = obj;
                                    if ($scope.diskReadData.length > 0) {
                                        if (!angular.isUndefined($scope.diskReadData[index])) {
                                            if (!isItemInArray($scope.diskReadData[index], [getDateByTime(key), currentValue])) {
                                                data.push([getDateByTime(key), currentValue]);
                                                $scope.diskMaxData.push(currentValue);
                                            }
                                        } else {
                                            data.push([getDateByTime(key), currentValue]);
                                            $scope.diskMaxData.push(currentValue);
                                        }
                                    } else {
                                        data.push([getDateByTime(key), currentValue]);
                                        $scope.diskMaxData.push(currentValue);
                                    }
                                });
                                if ($scope.diskReadData.length > 0) {
                                    $scope.diskReadData[key] = data;
                                } else {
                                    $scope.diskDataLength = data.length;
                                    $scope.diskReadData.push(data);
                                }
                            } });
                           angular.forEach(angular.fromJson(diskResult).write, function (value, key) {
                            var data = [];
                            $scope.diskOptions.series.push([]);
                            $scope.diskLabels[$scope.diskReadData.length + key] = value.tags + ' Write';
                            var index = key;
                            if (value.dataPoints.length > 0) {
                                angular.forEach(angular.fromJson(value.dataPoints), function (obj, key) {
                                    var currentValue = obj;
                                    if ($scope.diskWriteData.length > 0) {
                                        if (!angular.isUndefined($scope.diskWriteData[index])) {
                                            if (!isItemInArray($scope.diskWriteData[index], [getDateByTime(key), currentValue])) {
                                                data.push([getDateByTime(key), currentValue]);
                                                $scope.diskMaxData.push(currentValue);
                                            }
                                        } else {
                                            data.push([getDateByTime(key), currentValue]);
                                            $scope.diskMaxData.push(currentValue);
                                        }
                                    } else {
                                        data.push([getDateByTime(key), currentValue]);
                                        $scope.diskMaxData.push(currentValue);
                                    }
                                });
                                if ($scope.diskWriteData.length > 0) {
                                    $scope.diskWriteData[key] = data;
                                } else {
                                    $scope.diskDataLength = data.length;
                                    $scope.diskWriteData.push(data);
                                }
                             } 
                            }); 
                            $scope.diskLabels[$scope.diskLabels.length] = "All";
                            $scope.updateGraphByRangeAndType("1m", "disk"); 
                            getDiskPerformanceByFilter($scope.diskReadData, $scope.diskWriteData, $scope.range.disk.actions.id);
                            updateDiskPoints($scope.diskReadTempData, $scope.diskWriteTempData, $scope.range.disk.actions.id);                            

                    } else {
                        angular.forEach(angular.fromJson(diskResult).read, function (value, key) {
                            var data = [];
                            var index = key;
                            if (value.dataPoints.length > 0) {
                                angular.forEach(angular.fromJson(value.dataPoints), function (obj, key) {
                                    var currentValue = obj;
                                    if (!angular.isUndefined($scope.diskReadData[index])) {
                                        if (!isItemInArray($scope.diskReadData[index], [getDateByTime(key), currentValue])) {
                                            data.push([getDateByTime(key), currentValue]);
                                            $scope.diskMaxData.push(currentValue);
                                        }
                                    }
                                });
                                 $scope.dynamicReadUpdate = data.length;
                                if (data.length > 0) {
                                    $scope.diskReadTempData[key] = data;
                                }
                            }
                        });
                        angular.forEach(angular.fromJson(diskResult).write, function (value, key) {
                            var data = [];
                            var index = key;
                            if (value.dataPoints.length > 0) {
                                angular.forEach(angular.fromJson(value.dataPoints), function (obj, key) {
                                    var currentValue = obj;
                                    if (!angular.isUndefined($scope.diskWriteData[index])) {
                                        if (!isItemInArray($scope.diskWriteData[index], [getDateByTime(key), currentValue])) {
                                            data.push([getDateByTime(key), currentValue]);
                                            $scope.diskMaxData.push(currentValue);
                                        }
                                    }
                                });
                                $scope.dynamicWriteUpdate = data.length;
                                if (data.length > 0) {
                                    $scope.diskWriteTempData[key] = data;                                    
                                }
                            }
                        });
                        
                    }
                    $rootScope.$broadcast("DISK", diskResult);
                });
                
        webSockets
                .subscribe("/topic/stackwatch.network/" + appService.globalConfig.sessionValues.id + "/" + $scope.uuid, function(message) {
                    $scope.monitorNetworkImage = true;
                    var networkResult = JSON.parse(message.body);
                    $scope.networkCount = networkResult.in.length;
                    $scope.networkCounts = networkResult.out.length;
                    if (JSON.parse(message.body).duration != "1m-ago") {
                    angular.forEach(angular.fromJson(networkResult.in), function(value, key) {
                            var data = [];
                            $scope.networkLabels[key] = value.tags + ' In';
                            $scope.networkOptions.series.push([]);
                            var index = key;
                            if (value.dataPoints.length > 0) {
                                angular.forEach(angular.fromJson(value.dataPoints), function (obj, key) {
                                    var currentValue = obj;
                                    if ($scope.networkInData.length > 0) {
                                        if (!angular.isUndefined($scope.networkInData[index])) {
                                            if (!isItemInArray($scope.networkInData[index], [getDateByTime(key), currentValue])) {
                                                data.push([getDateByTime(key), currentValue]);
                                                $scope.networkMaxData.push(currentValue);
                                            }
                                        } else {
                                            data.push([getDateByTime(key), currentValue]);
                                            $scope.networkMaxData.push(currentValue);
                                        }
                                    } else {
                                        data.push([getDateByTime(key), currentValue]);
                                        $scope.networkMaxData.push(currentValue);
                                    }
                                });
                                if ($scope.networkInData.length > 0) {
                                    $scope.networkInData[key] = data;
                                } else {
                                    $scope.networkDataLength = data.length;
                                    $scope.networkInData.push(data);
                                }
                            }
                    });
                    angular.forEach(angular.fromJson(networkResult.out), function(value, key) {
                            var data = [];
                            $scope.networkOptions.series.push([]);
                            $scope.networkLabels[$scope.networkInData.length + key] = value.tags + ' Out';
                            var index = key;
                            if (value.dataPoints.length > 0) {
                                angular.forEach(angular.fromJson(value.dataPoints), function (obj, key) {
                                    var currentValue = obj;
                                    if ($scope.networkOutData.length > 0) {
                                        if (!angular.isUndefined($scope.networkOutData[index])) {
                                            if (!isItemInArray($scope.networkOutData[index], [getDateByTime(key), currentValue])) {
                                                data.push([getDateByTime(key), currentValue]);
                                                $scope.networkMaxData.push(currentValue);
                                            }
                                        } else {
                                            data.push([getDateByTime(key), currentValue]);
                                            $scope.networkMaxData.push(currentValue);
                                        }
                                    } else {
                                        data.push([getDateByTime(key), currentValue]);
                                        $scope.networkMaxData.push(currentValue);
                                    }
                                });
                                if ($scope.networkOutData.length > 0) {
                                    $scope.networkOutData[key] = data;
                                } else {
                                    $scope.networkDataLength = data.length;
                                    $scope.networkOutData.push(data);
                                }
                             } 
                    });
                     $scope.networkLabels[$scope.networkLabels.length] = "All";
                     $scope.updateGraphByRangeAndType("1m", "network"); 
                     getNetworkPerformanceByFilter($scope.networkInData, $scope.networkOutData, $scope.range.network.actions.id);
                     updateNetworkPoints($scope.networkInTempData, $scope.networkOutTempData, $scope.range.network.actions.id);                            

                } else {
                     angular.forEach(angular.fromJson(networkResult.in), function(value, key) {
                         var data = [];
                            var index = key;
                            if (value.dataPoints.length > 0) {
                                angular.forEach(angular.fromJson(value.dataPoints), function (obj, key) {
                                    var currentValue = obj;
                                    if (!angular.isUndefined($scope.networkInData[index])) {
                                        if (!isItemInArray($scope.networkInData[index], [getDateByTime(key), currentValue])) {
                                            data.push([getDateByTime(key), currentValue]);
                                            $scope.networkMaxData.push(currentValue);
                                        }
                                    }
                                });
                                 $scope.dynamicInUpdate = data.length;
                                if (data.length > 0) {
                                    $scope.networkInTempData[key] = data;
                                }
                            }
                    });
                    angular.forEach(angular.fromJson(networkResult.out), function(value, key) {
                        var data = [];
                            var index = key;
                            if (value.dataPoints.length > 0) {
                                angular.forEach(angular.fromJson(value.dataPoints), function (obj, key) {
                                    var currentValue = obj;
                                    if (!angular.isUndefined($scope.networkOutData[index])) {
                                        if (!isItemInArray($scope.networkOutData[index], [getDateByTime(key), currentValue])) {
                                            data.push([getDateByTime(key), currentValue]);
                                            $scope.networkMaxData.push(currentValue);
                                        }
                                    }
                                });
                                $scope.dynamicOutUpdate = data.length;
                                if (data.length > 0) {
                                    $scope.networkOutTempData[key] = data;                                    
                                }
                            }
                    });
                }
                    //$scope.updateGraphByRangeAndType("1m", "network");
                });
        webSockets
                .subscribe("/topic/stackwatch.connection/" + appService.globalConfig.sessionValues.id + "/" + $scope.uuid, function(message) {

                });
        webSockets
                .subscribe("/topic/stackwatch.all/" + appService.globalConfig.sessionValues.id + "/" + $scope.uuid, function(message) {

                });
    }
    initStompClient();

}
