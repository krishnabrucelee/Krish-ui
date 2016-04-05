/**
 *
 * instanceMonitorCtrl
 *
 */

angular.module('homer').controller('instanceMonitorWindowsCtrl', instanceMonitorWindowsCtrl)

function instanceMonitorWindowsCtrl($scope, $rootScope, $http, $stateParams, appService) {

    var cpuData = [];

    $scope.global = appService.globalConfig;

    $scope.cpuIndex = "";

    $scope.memoryIndex = "";

    $scope.storageIndex = "";

    $scope.networkIndex = "";

    $scope.OpenTsdbIp = appService.globalConfig.MONITOR_URL;

    $scope.hostName = "az-monitor-windows";

    $scope.cpuCount = 4;

    $scope.cpu = {
        result : [],
        actions : {
            id : "5m",
            name : 'Last 5 minutes'
        }
    };
    $scope.cpu.dataset = [];
    $scope.cpu.altdataset = [];

    var graphTooltip = {

        getCurrentDate : function() {
            var today = new Date();
            var currentDay = today.getDate();
            var currentMonth = today.getMonth() + 1;
            var currentYear = today.getFullYear();
            var hours = today.getHours();
            var minutes = today.getMinutes();
            var seconds = today.getSeconds();

            if (currentDay < 10) {
                currentDay = '0' + currentDay
            }

            if (currentMonth < 10) {
                currentMonth = '0' + currentMonth
            }

            today = currentMonth + '-' + currentDay + '-' + currentYear + " " + hours + ":" + minutes + ":" + seconds;

            return today;
        },

        getSearchTimeLabel : function() {
            return $scope.selectedSearchValue;
        },

        getNetworkToolTipContent : function() {
            var contents = "<div class='text-center'><b>" + graphTooltip.getCurrentDate() + "</b></div>";
            contents += "<div><b>os.net.bytes{host=" + $scope.hostName + ",iface=eth0} : %y (Bps)</b></div>";
            return contents;
        },

        getDiskToolTipContent : function() {
            var contents = "<div class='text-center'><b>" + graphTooltip.getCurrentDate() + "</b></div>";
            contents += "<div><b>linux.disk.write_requests{host=" + $scope.hostName + "} : %y (Bps)</b></div>";
            return contents;
        },

        getMemoryToolTipContent : function() {
            var contents = "<div class='text-center'><b>" + graphTooltip.getCurrentDate() + "</b></div>";
            contents += "<div><b>os.mem.total{host=" + $scope.hostName + "} : %y (MB)</b></div>";
            return contents;
        },

        getCpuToolTipContent : function(label, x, y) {
            var contents = "<div class='text-center'><b>" + graphTooltip.getCurrentDate() + "</b></div>";
            contents += "<div><b>linux.cpu{host=" + $scope.hostName + "} : " + y.toFixed(2) + "</b></div>";
            return contents;
        }

    }

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
        },
        // {id: '3h', name: 'Last 3 hour'},
        // {id: '6h', name: 'Last 6 hour'},
        // {id: '12h', name: 'Last 12 hours'}
        //          {id: '24h', name: 'Last 24 hours'}

        ]
    };

    var pandaChart = appService.monitorService.getPandaChart();
    var pandaMemoryChart = appService.monitorService.getPandaChart();

    $scope.cpuAltEnabled = [];

    function getTooltip(label, x, y) {
        var y = y.toFixed(2);
        var currentDate = new Date(x);
        x = currentDate.getHours() + ":" + currentDate.getMinutes() + ":" + currentDate.getSeconds();
        return label + " | x : " + x + " y : " + y;
    }

    $scope.togglePlot = function(index, length) {
        $scope.cpuIndex = index;
        for (var i = 0; i < length; i++) {
            if (index == i) {
                $scope.cpu.dataset[index] = $scope.cpu.altdataset[index];
            } else {
                $scope.cpu.dataset[i] = [];
            }
        }
    };

    $scope.flotOptions = {
        series : {
            lines : {
                show : true,
                lineWidth : 1.5,
                fill : 0.1
            },
        },
        legend : {
            noColumns : 8,
            container : "#cpuLegendContainer",
            show : true,
            position : "nw",
            labelFormatter : function(label, series) {
                return '<a data-ng-controller="instanceMonitorCtrl" href="javascript:void(0)" ng-click="alert(\'test\');">' + label + '</a>';
            }
        },
        tooltip : true,

        tooltipOpts : {
            content : graphTooltip.getCpuToolTipContent,
            defaultTheme : true
        },

        xaxes : [ {
            mode : "time",
            timeformat : "%H:%M:%S",
            tickSize : [ 5, "minute" ],
            tickFormatter : function(v, axis) {
                var date = new Date(v);
                return appService.monitorService.getPandaChart()
                        .getChartLabelByRangeAndDate($scope.range.actions.id, date);

            },
            axisLabel : "Date",
            axisLabelUseCanvas : true,
            axisLabelFontSizePixels : 12,
            axisLabelFontFamily : 'Verdana, Arial',
            axisLabelPadding : 10
        } ],

        yaxis : {
            min : 0,
            max : 100,
            tickFormatter : function(v, axis) {
                if (v % 10 == 0) {
                    return v + "%";
                } else {
                    return "";
                }
            },
            axisLabel : "CPU loading",
            axisLabelUseCanvas : true,
            axisLabelFontSizePixels : 12,
            axisLabelFontFamily : 'Verdana, Arial',
            axisLabelPadding : 6
        },

        grid : {
            hoverable : true,
            mouseActiveRadius : 30,
            tickColor : "#dddddd",
            borderWidth : 0.5,
            borderColor : '#dddddd',
            color : 'red',
            axisMargin : 15
        },
        colors : [],
    };

    /**
     * Data for Line chart
     */
    function getDateByTime(unixTimeStamp) {
        var date = new Date(unixTimeStamp * 1000);
        return date;
    }

    var dataIndexCount = 12;
    var j = 0;
    var colorLabels = [ "#62cb31", "#d9534f", "#f0ad4e", "#48a9da", "#d81df5" ];
    var chartIteration = 0;
    totalDelayCount = 0;
    chartIterationCount = 3;
    var forAdditionalIterations = [];

    function getPerformanceByFilters(url, indexValue, instanceName, totalCount, chartType) {
        var chartConfig = pandaChart.getConfigurationByRange($scope.range.actions.id);
        dataIndexCount = chartConfig.dataIndexCount;
        chartIterationCount = chartConfig.iterationCountCount;

        $scope.flotOptions.xaxes[0].tickSize = chartConfig.tickSize;

        $scope.flotOptions.colors = [ "#62cb31", "#d9534f", "#f0ad4e", "#48a9da", "#d81df5" ];
        if (indexValue == 0 && totalCount != -1) {
            chartIteration++;
        }
        if (chartIteration == chartIterationCount || totalCount == -1) {
            forAdditionlTenIndex = 0;
            if (indexValue == totalCount)
                chartIteration = 0;
            var hasServer = appService.promiseAjax.httpRequest("GET", $scope.OpenTsdbIp + url);
            hasServer.then(function(result) {

                if (angular.isUndefined($scope.cpuData)) {
                    $scope.cpuData = [];
                    $scope.cpuAltData = [];
                }

                $scope.cpuData[indexValue] = [];
                $scope.cpuAltData[indexValue] = [];
                for (var i = 0; i < result.length; i++) {
                    j++;
                    var dataPoints = result[i].dps;
                    var dataIndex = 0;
                    forAdditionalIterations[indexValue] = [];
                    angular.forEach(dataPoints, function(obj, key) {
                        dataIndex++;
                        var currentValue = obj;
                        if (dataIndex <= dataIndexCount) {
                            $scope.cpuData[indexValue].push([ getDateByTime(key).getTime(), currentValue ]);
                        } else {
                            //forAdditionalIterations[indexValue].push([getDateByTime(key).getTime(), currentValue]);
                        }
                    });
                    $scope.cpuAltData[indexValue] = $scope.cpuData[indexValue];
                    var currentData = {
                        data : $scope.cpuData[indexValue],
                        yaxis : 100,
                        label : "CPU " + indexValue,
                        color : colorLabels[indexValue],
                        points : {
                            fillColor : colorLabels[indexValue],
                            show : false
                        },
                        idx : indexValue
                    };

                    if (angular.isUndefined($scope.cpu.dataset[i])) {
                        $scope.cpu.dataset[indexValue] = {
                            data : []
                        };
                        $scope.cpu.altdataset[indexValue] = {
                            data : []
                        };
                    }
                    $scope.cpu.dataset[indexValue] = currentData;
                    $scope.cpu.altdataset[indexValue] = currentData;
                }
            });
        }

        if (indexValue == 0) {
            jQuery('.cpu-chart-container').find('.flot-base, .flot-x-axis, .flot-overlay').css({
                "margin-left" : 0
            });
        }
        pandaChart
                .updateChartMarginByRangeAndIndex($scope.range.actions.id, indexValue, chartIteration, 'cpu-chart-container');

        if ($scope.cpuIndex) {
            $scope.togglePlot($scope.cpuIndex, $scope.cpuData.length);
        }

    }

    var updatePerformance = 0;
    $scope.updateCpuPerformance = function(cpuResult, cpuAction) {
        updatePerformance++;
        chartIteration = 0;
        totalDelayCount = 0;
        start = 0;
        end = 0;
        forAdditionalTenIndex = 0;
        chartIterationCount = 3;
        forAdditionalIterations = [];
        var displayName = $scope.hostName;
        //for(var cpuCores = 0; cpuCores < $scope.cpuCount; cpuCores++) {
        //getPerformanceByFilters("query?start=" + $scope.range.actions.id + "-ago&m=p75:rate:linux.cpu.percpu{host="+ displayName +",cpu=" + cpuCores + "}", cpuCores, displayName, -1, pandaChart.chartTypes.CPU);
        //getPerformanceByFilters("query?start=" + $scope.range.actions.id + "-ago&m=p75:rate:win.cpu{host="+ displayName + "}", cpuCores, displayName, -1, pandaChart.chartTypes.CPU);
        //}

        getPerformanceByFilters("query?start=" + $scope.range.actions.id + "-ago&m=avg:rate:win.cpu{host=" + displayName + ",type=user}", 0, displayName, -1, pandaChart.chartTypes.CPU);

        if (updatePerformance == 1) {
            setInterval(function() {
                $scope
                        .$apply(function() {
                            //for(var cpuCores=0; cpuCores < $scope.cpuCount; cpuCores++) {
                            //getPerformanceByFilters("query?start=" + $scope.range.actions.id + "-ago&m=p75:rate:linux.cpu.percpu{host="+ displayName +",cpu=" + cpuCores + "}", cpuCores, displayName, 3, pandaChart.chartTypes.CPU);
                            // getPerformanceByFilters("query?start=" + $scope.range.actions.id + "-ago&m=p75:rate:win.cpu{host="+ displayName + "}", cpuCores, displayName, -1, pandaChart.chartTypes.CPU);
                            //}
                            getPerformanceByFilters("query?start=" + $scope.range.actions.id + "-ago&m=avg:rate:win.cpu{host=" + displayName + ",type=user}", 0, displayName, -1, pandaChart.chartTypes.CPU);

                        });
            }, 5000);
        }

    }

    $scope.memory = {
        result : [],
        actions : {
            id : "5m",
            name : 'Last 5 minutes'
        }
    };
    $scope.memory.dataset = [];
    $scope.memory.altdataset = [];

    $scope.toggleMemoryPlot = function(index, length) {
        $scope.memoryIndex = index;
        for (var i = 0; i < length; i++) {
            if (index == i) {
                $scope.memory.dataset[index] = $scope.memory.altdataset[index];
            } else {
                $scope.memory.dataset[i] = [];
            }
        }
    };

    $scope.memoryFlotOptions = {
        series : {
            lines : {
                show : true,
                lineWidth : 1.5,
                fill : 0.1
            },
        },
        legend : {
            noColumns : 8,
            container : "#memoryLegendContainer",
            show : true,
            position : "nw",
            labelFormatter : function(label, series) {
                return '<a href="javascript:void(0)" data-ng-click="togglePlot(this, ' + series.idx + '); return false;">' + label + '</a>';
            }
        },

        tooltip : {
            show : true,
            content : graphTooltip.getMemoryToolTipContent()
        },

        tooltipOpts : {
            content : getMemoryTooltip,
            defaultTheme : true
        },

        xaxes : [ {
            mode : "time",
            timeformat : "%H:%M:%S",
            tickSize : [ 5, "minute" ],
            tickFormatter : function(v, axis) {
                var date = new Date(v);
                return pandaMemoryChart.getChartLabelByRangeAndDate($scope.range.actions.id, date);

            },
            axisLabel : "Date",
            axisLabelUseCanvas : true,
            axisLabelFontSizePixels : 12,
            axisLabelFontFamily : 'Verdana, Arial',
            axisLabelPadding : 10
        } ],

        grid : {
            hoverable : true,
            mouseActiveRadius : 30,
            tickColor : "#dddddd",
            borderWidth : 0.5,
            borderColor : '#dddddd',
            color : 'red',

            axisMargin : 15
        },
        colors : [],
    };

    function getMemoryTooltip(label, x, y) {
        var y = y.toFixed(2);
        var currentDate = new Date(x);
        x = currentDate.getHours() + ":" + currentDate.getMinutes() + ":" + currentDate.getSeconds();
        return label + " | x : " + x + " y : " + y;
    }

    var memoryIndexCount = 12;
    var memoryColorLabels = [ "#62cb31", "#d9534f", "#f0ad4e", "#48a9da" ];
    var memoryChartIteration = 0;
    memoryTotalDelayCount = 0;
    memoryChartIterationCount = 2;
    var memoryForAdditionalIterations = [];

    function getMemoryPerformanceByFilters(url, indexValue, instanceName, totalCount, chartType, memoryType) {
        var chartConfig = pandaChart.getConfigurationByRange($scope.range.actions.id);
        memoryIndexCount = chartConfig.dataIndexCount;
        memoryChartIterationCount = chartConfig.iterationCountCount;
        $scope.memoryFlotOptions.xaxes[0].tickSize = chartConfig.tickSize;

        $scope.memoryFlotOptions.colors = [ "#62cb31", "#d9534f", "#f0ad4e", "#48a9da" ];
        if (indexValue == 0 && totalCount != -1) {
            memoryChartIteration++;
        }
        if (memoryChartIteration == memoryChartIterationCount || totalCount == -1) {
            forAdditionlTenIndex = 0;
            if (indexValue == totalCount)
                memoryChartIteration = 0;
            var hasServer = appService.promiseAjax.httpRequest("GET", $scope.OpenTsdbIp + url);
            hasServer.then(function(result) {
                if (angular.isUndefined($scope.memoryData)) {
                    $scope.memoryData = [];
                    $scope.memoryAltData = [];
                }

                $scope.memoryData[indexValue] = [];
                $scope.memoryAltData[indexValue] = [];

                for (var i = 0; i < result.length; i++) {
                    var dataPoints = result[i].dps;
                    var dataIndex = 0;
                    memoryForAdditionalIterations[indexValue] = [];
                    angular.forEach(dataPoints, function(obj, key) {
                        dataIndex++;
                        var currentValue = obj;
                        if (!angular.isUndefined(currentValue) && currentValue != 0) {
                            currentValue = currentValue / (1024 * 1024);
                        }
                        if (dataIndex <= memoryIndexCount) {
                            $scope.memoryData[indexValue].push([ getDateByTime(key).getTime(), currentValue ]);
                        } else {
                            //memoryForAdditionalIterations[indexValue].push([getDateByTime(key).getTime(), currentValue]);
                        }
                    });

                    $scope.memoryAltData[indexValue] = $scope.memoryData[indexValue];

                    var currentData = {
                        data : $scope.memoryData[indexValue],
                        yaxis : 100,
                        label : memoryType,
                        color : memoryColorLabels[indexValue],
                        points : {
                            fillColor : memoryColorLabels[indexValue],
                            show : false
                        },
                        idx : indexValue
                    };

                    if (angular.isUndefined($scope.memory.dataset[i])) {
                        $scope.memory.dataset[indexValue] = {
                            data : []
                        };
                        $scope.memory.altdataset[indexValue] = {
                            data : []
                        };
                    }
                    $scope.memory.dataset[indexValue] = currentData;
                    $scope.memory.altdataset[indexValue] = currentData;
                }
            });
        }

        if (indexValue == 0) {
            jQuery('.memory-chart-container').find('.flot-base, .flot-x-axis, .flot-overlay').css({
                "margin-left" : 0
            });
        }
        pandaChart
                .updateChartMarginByRangeAndIndex($scope.range.actions.id, indexValue, memoryChartIteration, 'memory-chart-container');

        if ($scope.memoryIndex) {
            $scope.toggleMemoryPlot($scope.memoryIndex, $scope.memoryData.length);
        }
    }

    var updateMemoryPerformance = 0;
    $scope.updateMemoryPerformance = function(memoryResult, memoryAction) {
        updateMemoryPerformance++;
        memoryChartIteration = 0;
        memoryTotalDelayCount = 0;
        start = 0;
        end = 0;
        forAdditionalTenIndex = 0;
        memoryChartIterationCount = 3;
        memoryForAdditionalIterations = [];
        var displayName = $scope.hostName;
        http: //192.168.2.22:4242/api/query?start=1m-ago&m=avg:win.disk.fs.space_total{host=azbpmlap4}

        getMemoryPerformanceByFilters("query?start=" + $scope.range.actions.id + "-ago&m=avg:os.mem.total{host=" + displayName + "}", 0, displayName
                .toLowerCase(), -1, pandaChart.chartTypes.MEMORY, "Total");
        getMemoryPerformanceByFilters("query?start=" + $scope.range.actions.id + "-ago&m=avg:os.mem.free{host=" + displayName + "}", 1, displayName
                .toLowerCase(), -1, pandaChart.chartTypes.MEMORY, "Free");
        //getMemoryPerformanceByFilters("query?start=" + $scope.memory.actions.id + "-ago&m=sum:os.mem.used{host="+ displayName +"}", 2,  displayName.toLowerCase(), -1, pandaChart.chartTypes.MEMORY);

        if (updateMemoryPerformance == 1) {
            setInterval(function() {
                $scope
                        .$apply(function() {
                            getMemoryPerformanceByFilters("query?start=" + $scope.range.actions.id + "-ago&m=avg:os.mem.total{host=" + displayName + "}", 0, displayName
                                    .toLowerCase(), 1, pandaChart.chartTypes.MEMORY, "Total");
                            getMemoryPerformanceByFilters("query?start=" + $scope.range.actions.id + "-ago&m=avg:os.mem.free{host=" + displayName + "}", 1, displayName
                                    .toLowerCase(), 1, pandaChart.chartTypes.MEMORY, "Free");
                            // getMemoryPerformanceByFilters("query?start=" + $scope.memory.actions.id + "-ago&m=sum:os.mem.used{host="+ displayName +"}", 2,  displayName.toLowerCase(), 2, pandaChart.chartTypes.MEMORY);
                        });
            }, 5000);
        }

    }

    $scope.storage = {
        result : [],
        actions : {
            id : "5m",
            name : 'Last 5 minutes'
        }
    };

    $scope.storage.dataset = [];
    $scope.storage.altdataset = [];

    $scope.toggleStoragePlot = function(index, length) {
        $scope.storageIndex = index;
        for (var i = 0; i < length; i++) {
            if (index == i) {
                $scope.storage.dataset[index] = $scope.storage.altdataset[index];
            } else {
                $scope.storage.dataset[i] = [];
            }
        }
    };

    $scope.storageFlotOptions = {
        series : {
            lines : {
                show : true,
                lineWidth : 1.5,
                fill : 0.1
            },
        },
        legend : {
            noColumns : 8,
            container : "#storageLegendContainer",
            show : true,
            position : "nw",
            labelFormatter : function(label, series) {
                return '<a href="javascript:void(0)" data-ng-click="togglePlot(' + series.idx + '); return false;">' + label + '</a>';
            }
        },

        xaxes : [ {
            mode : "time",
            timeformat : "%H:%M:%S",
            tickSize : [ 5, "minute" ],
            tickFormatter : function(v, axis) {
                var date = new Date(v);
                return pandaChart.getChartLabelByRangeAndDate($scope.range.actions.id, date);

            },
            axisLabel : "Date",
            axisLabelUseCanvas : true,
            axisLabelFontSizePixels : 12,
            axisLabelFontFamily : 'Verdana, Arial',
            axisLabelPadding : 10
        } ],

        grid : {
            hoverable : true,
            mouseActiveRadius : 30,
            tickColor : "#dddddd",
            borderWidth : 0.5,
            borderColor : '#dddddd',
            color : 'red',

            axisMargin : 15
        },
        tooltip : {
            show : true,
            content : graphTooltip.getDiskToolTipContent()
        },
        colors : [],
    };

    var storageIndexCount = 12;
    var storageColorLabels = [ "#62cb31", "#d9534f", "#f0ad4e", "#48a9da" ];
    var storageChartIteration = 0;
    storageTotalDelayCount = 0;
    storageChartIterationCount = 3;
    var storageForAdditionalIterations = [];

    function getStoragePerformanceByFilters(url, indexValue, instanceName, totalCount, chartType, diskType) {
        var chartConfig = pandaChart.getConfigurationByRange($scope.range.actions.id);
        storageIndexCount = chartConfig.dataIndexCount;
        storageChartIterationCount = chartConfig.iterationCountCount;
        $scope.storageFlotOptions.xaxes[0].tickSize = chartConfig.tickSize;

        $scope.storageFlotOptions.colors = [ "#62cb31", "#d9534f", "#f0ad4e", "#48a9da" ];
        if (indexValue == 0 && totalCount != -1) {
            storageChartIteration++;
        }

        if (storageChartIteration == storageChartIterationCount || totalCount == -1) {
            forAdditionlTenIndex = 0;
            if (indexValue == totalCount)
                storageChartIteration = 0;
            var hasServer = appService.promiseAjax.httpRequest("GET", $scope.OpenTsdbIp + url);
            hasServer.then(function(result) {

                if (angular.isUndefined($scope.storageData)) {
                    $scope.storageData = [];
                    $scope.storageAltData = [];
                }
                $scope.storageData[indexValue] = [];
                $scope.storageAltData[indexValue] = [];

                for (var i = 0; i < result.length; i++) {
                    var dataPoints = result[i].dps;
                    var dataIndex = 0;
                    storageForAdditionalIterations[indexValue] = [];
                    angular.forEach(dataPoints, function(obj, key) {
                        dataIndex++;
                        var currentValue = obj;
                        if (dataIndex <= storageIndexCount) {
                            $scope.storageData[indexValue].push([ getDateByTime(key).getTime(), currentValue ]);
                        } else {
                            //                            storageForAdditionalIterations[indexValue].push([getDateByTime(key).getTime(), currentValue]);
                        }
                    });

                    var currentData = {
                        data : $scope.storageData[indexValue],
                        yaxis : 100,
                        label : "Disk " + diskType,
                        color : storageColorLabels[indexValue],
                        points : {
                            fillColor : storageColorLabels[indexValue],
                            show : false
                        },
                        idx : indexValue
                    };

                    if (angular.isUndefined($scope.storage.dataset[i])) {
                        $scope.storage.dataset[indexValue] = {
                            data : []
                        };
                        $scope.memory.altdataset[indexValue] = {
                            data : []
                        };
                    }
                    $scope.storage.dataset[indexValue] = currentData;
                    $scope.storage.altdataset[indexValue] = currentData;
                }
            });
        }

        if (indexValue == 0) {
            jQuery('.storage-chart-container').find('.flot-base, .flot-x-axis, .flot-overlay').css({
                "margin-left" : 0
            });
        }
        pandaChart
                .updateChartMarginByRangeAndIndex($scope.range.actions.id, indexValue, storageChartIteration, 'storage-chart-container');

        if ($scope.storageIndex) {
            $scope.togglePlot($scope.storageIndex, $scope.storageData.length);
        }
    }

    var updateStoragePerformance = 0;
    $scope.updateStoragePerformance = function(storageResult, storageAction) {
        updateStoragePerformance++;
        storageChartIteration = 0;
        storageTotalDelayCount = 0;
        start = 0;
        end = 0;
        forAdditionalTenIndex = 0;
        storageChartIterationCount = 3;
        storageForAdditionalIterations = [];
        var displayName = $scope.hostName;
        http: //192.168.2.22:4242/api/query?start=1m-ago&m=avg:rate:win.disk.ops{host=azbpmlap4,type=read}
        getStoragePerformanceByFilters("query?start=" + $scope.range.actions.id + "-ago&m=avg:rate:win.disk.ops{host=" + displayName + ",type=write}", 0, displayName
                .toLowerCase(), -1, pandaChart.chartTypes.DISK, "Write");
        getStoragePerformanceByFilters("query?start=" + $scope.range.actions.id + "-ago&m=avg:rate:win.disk.ops{host=" + displayName + ",type=read}", 1, displayName
                .toLowerCase(), -1, pandaChart.chartTypes.DISK, "Read");
        //getStoragePerformanceByFilters("query?start=" + $scope.range.actions.id + "-ago&m=sum:os.mem.used{host="+ displayName +"}", 2,  displayName.toLowerCase(), -1);

        if (updateStoragePerformance == 1) {
            setInterval(function() {
                $scope
                        .$apply(function() {
                            getStoragePerformanceByFilters("query?start=" + $scope.storage.actions.id + "-ago&m=avg:rate:win.disk.ops{host=" + displayName + ",type=write}", 0, displayName
                                    .toLowerCase(), 1, pandaChart.chartTypes.DISK, "Write");
                            getStoragePerformanceByFilters("query?start=" + $scope.storage.actions.id + "-ago&m=avg:rate:win.disk.ops{host=" + displayName + ",type=read}", 1, displayName
                                    .toLowerCase(), 1, pandaChart.chartTypes.DISK, "Read");
                            //getStoragePerformanceByFilters("query?start=" + $scope.storage.actions.id + "-ago&m=sum:os.mem.used{host="+ displayName +"}", 2,  displayName.toLowerCase(), 3);
                        });
            }, 5000);
        }

    }

    if ($stateParams.id > 0) {
        var hasServer = appService.crudService.read("virtualmachine", $stateParams.id);
        hasServer.then(function(result) { // this is only run after $http
            $scope.cpu.result = result;
            var displayName = $scope.hostName;

            //$scope.updateCpuPerformance($scope.cpu.result, $scope.cpu.actions.id);
            //              var displayName = result.displayName.toLowerCase();
            //getCpuPerformance("query?start=1m-ago&m=sum:rate:linux.cpu{host="+ displayName +"}", 0, result.displayName.toLowerCase());
            //for(var cpuCores=0; cpuCores < 4; cpuCores++) {
            //getCpuPerformance("query?start=" + $scope.cpu.actions.id + "-ago&m=sum:linux.cpu.percpu{host="+ displayName +",cpu=" + cpuCores + "}", cpuCores, result.displayName.toLowerCase(), -1);
            //}
            //              getMemoryPerformance("query?start=1m-ago&m=sum:os.mem.total{host="+ displayName +"}", 0,  result.displayName.toLowerCase());
            //              getMemoryPerformance("query?start=1m-ago&m=sum:os.mem.free{host="+ displayName +"}", 1,  result.displayName.toLowerCase());
            //              getMemoryPerformance("query?start=1m-ago&m=sum:os.mem.used{host="+ displayName +"}", 2,  result.displayName.toLowerCase());

            //getStorageIO("query?start=1m-ago&m=sum:linux.disk.write_requests{host="+ displayName +"}", 0,  result.displayName.toLowerCase());
            //getStorageIO("query?start=1m-ago&m=sum:linux.disk.read_requests{host="+ displayName +"}", 1,  result.displayName.toLowerCase());

            setInterval(function() {
                $scope.$apply(function() {
                    //result.computeOffering.numberOfCores
                    //getCpuPerformance("query?start=1m-ago&m=sum:rate:linux.cpu{host="+ displayName +"}", 0, result.displayName.toLowerCase());
                    for (var cpuCores = 0; cpuCores < $scope.cpuCount; cpuCores++) {
                        //getCpuPerformance("query?start=" + $scope.cpu.actions.id + "-ago&m=sum:linux.cpu.percpu{host="+ displayName +",cpu=" + cpuCores + "}", cpuCores, result.displayName.toLowerCase(), 3);
                    }
                    //                  getMemoryPerformance("query?start=1m-ago&m=sum:os.mem.total{host="+ displayName +"}", 0,  result.displayName.toLowerCase());
                    //                  getMemoryPerformance("query?start=1m-ago&m=sum:os.mem.free{host="+ displayName +"}", 1, result.displayName.toLowerCase());
                    //                  getMemoryPerformance("query?start=1m-ago&m=sum:os.mem.used{host="+ displayName +"}", 2, result.displayName.toLowerCase());

                    //getStorageIO("query?start=1m-ago&m=sum:linux.disk.write_requests{host="+ displayName +"}", 0,  result.displayName.toLowerCase());
                    // getStorageIO("query?start=1m-ago&m=sum:linux.disk.read_requests{host="+ displayName +"}", 1,  result.displayName.toLowerCase());
                });
            }, 5000);

        });
    }

    $scope.network = {
        result : [],
        actions : {
            id : "5m",
            name : 'Last 5 minutes'
        }
    };

    $scope.network.dataset = [];
    $scope.network.altdataset = [];

    $scope.toggleNetworkPlot = function(index, length) {
        $scope.networkIndex = index;
        for (var i = 0; i < length; i++) {
            if (index == i) {
                $scope.network.dataset[index] = $scope.network.altdataset[index];
            } else {
                $scope.network.dataset[i] = [];
            }
        }
    };

    $scope.networkFlotOptions = {
        series : {
            lines : {
                show : true,
                lineWidth : 1.5,
                fill : 0.1
            },
        },
        legend : {
            noColumns : 8,
            container : "#networkLegendContainerWindows",
            show : true,
            position : "nw",
            labelFormatter : function(label, series) {
                return '<a href="javascript:void(0)" data-ng-click="togglNetworkPlot(' + series.idx + '); return false;">' + label + '</a>';
            }
        },

        xaxes : [ {
            mode : "time",
            timeformat : "%H:%M:%S",
            tickSize : [ 5, "minute" ],
            tickFormatter : function(v, axis) {
                var date = new Date(v);
                return pandaChart.getChartLabelByRangeAndDate($scope.range.actions.id, date);

            },
            axisLabel : "Date",
            axisLabelUseCanvas : true,
            axisLabelFontSizePixels : 12,
            axisLabelFontFamily : 'Verdana, Arial',
            axisLabelPadding : 10
        } ],

        grid : {
            hoverable : true,
            mouseActiveRadius : 30,
            tickColor : "#dddddd",
            borderWidth : 0.5,
            borderColor : '#dddddd',
            color : 'red',

            axisMargin : 15
        },
        tooltip : {
            show : true,
            content : graphTooltip.getNetworkToolTipContent()
        },
        colors : [],
    };

    var networkIndexCount = 12;
    var networkColorLabels = [ "#62cb31", "#d9534f", "#f0ad4e", "#48a9da" ];
    var networkChartIteration = 0;
    networkTotalDelayCount = 0;
    networkChartIterationCount = 3;
    var networkForAdditionalIterations = [];

    function getNetworkPerformanceByFilters(url, indexValue, instanceName, totalCount, chartType, diskType) {
        var chartConfig = pandaChart.getConfigurationByRange($scope.range.actions.id);
        networkIndexCount = chartConfig.dataIndexCount;
        networkChartIterationCount = chartConfig.iterationCountCount;
        $scope.networkFlotOptions.xaxes[0].tickSize = chartConfig.tickSize;

        $scope.networkFlotOptions.colors = [ "#62cb31", "#d9534f", "#f0ad4e", "#48a9da" ];
        if (indexValue == 0 && totalCount != -1) {
            networkChartIteration++;
        }

        if (networkChartIteration == networkChartIterationCount || totalCount == -1) {
            forAdditionlTenIndex = 0;
            if (indexValue == totalCount)
                networkChartIteration = 0;
            var hasServer = appService.promiseAjax.httpRequest("GET", $scope.OpenTsdbIp + url);
            hasServer.then(function(result) {

                if (angular.isUndefined($scope.networkData)) {
                    $scope.networkData = [];
                    $scope.networkAltData = [];
                }
                $scope.networkData[indexValue] = [];
                $scope.networkAltData[indexValue] = [];

                for (var i = 0; i < result.length; i++) {
                    var dataPoints = result[i].dps;
                    var dataIndex = 0;
                    networkForAdditionalIterations[indexValue] = [];
                    angular.forEach(dataPoints, function(obj, key) {
                        dataIndex++;
                        var currentValue = obj;
                        if (!angular.isUndefined(currentValue) && currentValue != 0) {
                            currentValue = currentValue;
                        }
                        if (dataIndex <= networkIndexCount) {
                            $scope.networkData[indexValue].push([ getDateByTime(key).getTime(), currentValue ]);
                        } else {
                            //                            storageForAdditionalIterations[indexValue].push([getDateByTime(key).getTime(), currentValue]);
                        }
                    });

                    var currentData = {
                        data : $scope.networkData[indexValue],
                        yaxis : 100,
                        label : "Disk " + diskType,
                        color : networkColorLabels[indexValue],
                        points : {
                            fillColor : networkColorLabels[indexValue],
                            show : false
                        },
                        idx : indexValue
                    };

                    if (angular.isUndefined($scope.network.dataset[i])) {
                        $scope.network.dataset[indexValue] = {
                            data : []
                        };
                        $scope.network.altdataset[indexValue] = {
                            data : []
                        };
                    }
                    $scope.network.dataset[indexValue] = currentData;
                    $scope.network.altdataset[indexValue] = currentData;
                }
            });
        }

        if (indexValue == 0) {
            jQuery('.network-chart-container-windows').find('.flot-base, .flot-x-axis, .flot-overlay').css({
                "margin-left" : 0
            });
        }
        pandaChart
                .updateChartMarginByRangeAndIndex($scope.range.actions.id, indexValue, storageChartIteration, 'network-chart-container-windows');

        if ($scope.networkIndex) {
            $scope.toggleNetworkPlot($scope.networkIndex, $scope.networkData.length);
        }
    }

    var updateNetworkPerformance = 0;
    $scope.updateNetworkPerformance = function(networkResult, networkAction) {
        updateNetworkPerformance++;
        networkChartIteration = 0;
        networkTotalDelayCount = 0;
        start = 0;
        end = 0;
        forAdditionalTenIndex = 0;
        networkChartIterationCount = 3;
        networkForAdditionalIterations = [];
        var displayName = $scope.hostName;

        getNetworkPerformanceByFilters("query?start=" + $scope.range.actions.id + "-ago&m=avg:rate:win.net.bytes{host=" + displayName + ",direction=in}", 0, displayName
                .toLowerCase(), -1, pandaChart.chartTypes.NETWORK, "In");
        getNetworkPerformanceByFilters("query?start=" + $scope.range.actions.id + "-ago&m=avg:rate:win.net.bytes{host=" + displayName + ",direction=out}", 1, displayName
                .toLowerCase(), -1, pandaChart.chartTypes.NETWORK, "Out");

        if (updateNetworkPerformance == 1) {
            setInterval(function() {
                $scope
                        .$apply(function() {
                            getNetworkPerformanceByFilters("query?start=" + $scope.range.actions.id + "-ago&m=avg:rate:win.net.bytes{host=" + displayName + ",direction=in}", 0, displayName
                                    .toLowerCase(), -1, pandaChart.chartTypes.NETWORK, "In");
                            getNetworkPerformanceByFilters("query?start=" + $scope.range.actions.id + "-ago&m=avg:rate:win.net.bytes{host=" + displayName + ",direction=out}", 1, displayName
                                    .toLowerCase(), -1, pandaChart.chartTypes.NETWORK, "Out");
                        })
            }, 1000);
        }
    }

    $scope.updateGraphByRange = function() {
        $scope.updateCpuPerformance($scope.cpu.result, $scope.range.actions);
        $scope.updateMemoryPerformance($scope.memory.result, $scope.range.actions);
        $scope.updateStoragePerformance($scope.storage.result, $scope.range.actions);
        $scope.updateNetworkPerformance($scope.network.result, $scope.range.actions);
    }

}
