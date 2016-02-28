function monitorService() {

    var object = {};
    object.test = "test";
    object.getPandaChart = function() {

        var pandaChart = {

                delayType : {
                    Seconds : "Seconds",
                    Minutes : "Minutes",
                    Hour : "Hour"
                },

                chartTypes: {
                    CPU: "cpu",
                    MEMORY: "memory",
                    DISK: "disk",
                    NETWORK : "network"
                },

                /* Get the time labels */
                getTimeLabels : function(timeDelay, delayType, date) {

                    if(date) {
                        if(delayType == pandaChart.delayType.Seconds) {
                            if (date.getSeconds() % parseInt(timeDelay) == 0) {
                                var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
                                var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
                                var seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
                                return hours + ":" + minutes + ":" + seconds;
                            } else {
                                return "";
                            }
                        }

                        if(delayType == pandaChart.delayType.Minutes) {
                            if (date.getMinutes() % parseInt(timeDelay) == 0) {
                                var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
                                var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
                                return hours + ":" + minutes;
                            } else {
                                return "";
                            }
                        }

                        if(delayType == pandaChart.delayType.Hour) {
                            if (date.getHours() % parseInt(timeDelay) == 0) {
                                var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
                                var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
                                return hours + ":" + minutes;
                            } else {
                                return "";
                            }
                        }
                    }

                },

                /* Get the configuration by range */
                getConfigurationByRange: function(rangeId) {
                    var rangeConfig = {};
                    switch(rangeId) {
                        case "5m":
                            rangeConfig.dataIndexCount = 12;
                            rangeConfig.iterationCountCount = 3;
                            rangeConfig.tickSize = [15, "second"];
                            break;
                        case "15m":
                            rangeConfig.dataIndexCount = 60;
                            rangeConfig.iterationCountCount = 12;
                            rangeConfig.tickSize = [1, "minute"];
                            break;
                        case "30m":
                            rangeConfig.dataIndexCount = 120;
                            rangeConfig.iterationCountCount = 24;
                            rangeConfig.tickSize = [2, "minute"];
                            break;
                        case "1h":
                            rangeConfig.dataIndexCount = 240;
                            rangeConfig.iterationCountCount = 60;
                            rangeConfig.tickSize = [5, "minute"];
                            break;
                        case "3h":
                            rangeConfig.dataIndexCount = 720;
                            rangeConfig.iterationCountCount = 120;
                            rangeConfig.tickSize = [15, "minute"];
                            break;
                        case "6h":
                            rangeConfig.dataIndexCount = 1440;
                            rangeConfig.iterationCountCount = 360;
                            rangeConfig.tickSize = [30, "minute"];
                            break;
                        case "12h":
                            rangeConfig.dataIndexCount = 2880;
                            rangeConfig.iterationCountCount = 600;
                            rangeConfig.tickSize = [1, "hour"];
                            break;
                        case "24h":
                            rangeConfig.dataIndexCount = 5760;
                            rangeConfig.iterationCountCount = 1440;
                            rangeConfig.tickSize = [2, "hour"];
                            break;
                    }
                    return rangeConfig;
                },

                /* Get the graph label by range and date */
                getChartLabelByRangeAndDate: function(rangeId, date) {
                    switch (rangeId) {
                        case "5m":
                            return pandaChart.getTimeLabels(15,
                                    pandaChart.delayType.Seconds, date);
                            break;
                        case "15m":
                            return pandaChart.getTimeLabels(60,
                                    pandaChart.delayType.Seconds, date);
                            break;
                        case "30m":
                            return pandaChart.getTimeLabels(2,
                                    pandaChart.delayType.Minutes, date);
                            break;
                        case "1h":
                            return pandaChart.getTimeLabels(5,
                                    pandaChart.delayType.Minutes, date);
                            break;
                        case "3h":
                            return pandaChart.getTimeLabels(15,
                                    pandaChart.delayType.Minutes, date);
                            break;
                        case "6h":
                            return pandaChart.getTimeLabels(30,
                                    pandaChart.delayType.Minutes, date);
                            break;
                        case "12h":
                            return pandaChart.getTimeLabels(1,
                                    pandaChart.delayType.Hour, date);
                            break;
                        case "24h":
                            return pandaChart.getTimeLabels(2,
                                    pandaChart.delayType.Hour, date);
                            break;
                        }
                },

                /* Move the graph to left with real time data set */
                updateChartMarginByRangeAndIndex: function(rangeId, indexValue, chartIteration, chartContainer) {
                    var selector = jQuery('#' + chartContainer).find('.flot-base, .flot-x-axis, .flot-overlay');
                    switch(rangeId) {
                        case "5m":
                            if(chartIteration == 1 && indexValue==0) {
//                                var fifteenMinMargin = chartIteration * 30;
//                                selector.css({"margin-left": -fifteenMinMargin});

                                var fifteenMinMargin = chartIteration * 30;
                                //selector.addClass('m-l-n-lg');
                                selector.css({"margin-left": -30});
                            } else if(chartIteration == 2 && indexValue==0) {
                                var fifteenMinMargin = 60;
                                //selector.addClass('m-l-n-xxl');
                                selector.css({"margin-left": -60});
                            }
                            break;
                        case "15m":
                            if(chartIteration < 15 && indexValue == 0) {
                                var fifteenMinMargin = chartIteration * 4.8;
                                selector.css({"margin-left": -fifteenMinMargin});
                            }
                            break;
                        case "30m":
                            if(chartIteration < 30 && indexValue==0) {
                                var thirtyMinMargin = chartIteration * 2.4;
                                selector.css({"margin-left": -thirtyMinMargin});
                            }
                            break;
                        case "1h":
                            if(chartIteration <  60 && indexValue==0) {
                                var hourlyMargin = chartIteration * 1.2;
                                selector.css({"margin-left": -hourlyMargin});
                            }
                            break;
                        case "3h":
                            if(chartIteration <  180 && indexValue==0) {
                                var threeHourMargin = chartIteration * 0.4;
                                selector.css({"margin-left": -threeHourMargin});
                            }
                            break;
                        case "6h":
                            if(chartIteration <  360 && indexValue==0) {
                                var sixHourMargin = chartIteration * 0.2;
                                selector.css({"margin-left": -sixHourMargin});
                            }
                            break;
                        case "12h":
                            if(chartIteration <  720 && indexValue==0) {
                                var twelveHourMargin = chartIteration * 0.1;
                                selector.css({"margin-left": -twelveHourMargin});
                            }
                            break;
                        case "24h":
                            if(chartIteration <  1440 && indexValue==0) {
                                var twentyFourHourMargin = chartIteration * 0.05;
                                selector.css({"margin-left": -twentyFourHourMargin});
                            }
                            break;
                    }
                },

                flotOptions : {
                    series: {
                          splines: {
                                show: true,
                                lineWidth: 1.5,
                                fill: 0.1
                            },
                      },
                  legend: {
                      noColumns: 8,
                      container: "#legendContainer",
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
                            return pandaChart.getChartLabelByRangeAndDate($scope.mchart.cpu.actions.id, date);

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
                }
            }
        return pandaChart;
    }

    return object;

};

/**
 * Pass function into module
 */
angular
    .module('homer')
    .factory('monitorService', monitorService);