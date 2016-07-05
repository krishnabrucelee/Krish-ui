/**
 * JqPlot
 */
function monitorServiceJQ() {
    var object = {};
    object.cpuLables = []
    object.setLabels = function(cpulabels) {
        object.cpuLables = cpulabels
    }

    object.getPandaChart = function() {
        var pandaChart = {
            delayType : {
                Seconds : "Seconds",
                Minutes : "Minutes",
                Hour : "Hour"
            },
            chartTypes : {
                CPU : "cpu",
                MEMORY : "memory",
                DISK : "disk",
                NETWORK : "network"
            },
            /* Get the time labels */
            getTimeLabels : function(timeDelay, delayType, date) {

                if (date) {
                    if (delayType == pandaChart.delayType.Seconds) {
                        if (date.getSeconds() % parseInt(timeDelay) == 0) {
                            var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
                            var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
                            var seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
                            return hours + ":" + minutes + ":" + seconds;
                        } else {
                            return "";
                        }
                    }

                    if (delayType == pandaChart.delayType.Minutes) {
                        if (date.getMinutes() % parseInt(timeDelay) == 0) {
                            var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
                            var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
                            return hours + ":" + minutes;
                        } else {
                            return "";
                        }
                    }

                    if (delayType == pandaChart.delayType.Hour) {
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
            /* Get the graph label by range and date */
            getChartLabelByRangeAndDate : function(rangeId) {
                switch (rangeId) {
                case "1m":
                    return "4 seconds";
                break;
                case "5m":
                    return "15 seconds";
                    break;
                case "15m":
                    return "1 minute";
                    break;
                case "30m":
                    return "2 minutes";
                    break;
                case "45m":
                    return "3 minutes";
                    break;
                case "1h":
                    return "4 minutes";
                    break;
                case "3h":
                    return "12 minutes";
                    break;
                case "6h":
                    return "20 minutes";
                    break;
                case "12h":
                    return "40 minutes";
                    break;
                case "24h":
                    return "1.5 hours";
                    break;
                }
            },
            chartOptions : {
                seriesColors : [ "#62cb31", "#d9534f", "#f0ad4e", "#48a9da", "#9ACD32", "#FFFF00", "#F5DEB3",
                        "#EE82EE", "#40E0D0", "#D8BFD8", "#008080", "#4682B4", "#708090", "#2E8B57", "#FA8072",
                        "#800080", "#DB7093", "#DA70D6", "#FFE4B5", "#7B68EE", "#9370DB", "#FF00FF", "#00FF00",
                       "#FFB6C1" ],
                height: 300,
                width: 500,
                axes : {
                    xaxis : {
                        numberTicks : 10,
                        renderer : $.jqplot.DateAxisRenderer,
                        tickRenderer: $.jqplot.CanvasAxisTickRenderer,
                        tickOptions : {
                            formatString : '%H:%M:%S',
                            fontFamily: 'Arial, Helvetica, sans-serif',
                            fontWeight :'bold',
                            fontSize : '10pt'
                        }
                    },
                    yaxis : {
                        min : 0,
                        tickRenderer: $.jqplot.CanvasAxisTickRenderer,
                        tickOptions : {
                            formatString : '%.2f',
                            fontFamily: 'Arial, Helvetica, sans-serif',
                            fontWeight :'bold',
                            fontSize : '10pt'
                        }
                    }
                },
//                series : [{
//				label: 'CPU',
//				lineWidth:2,
//                                show : true,
//                                showLine : true, // whether to render the line segments or not.
//                                showMarker : true, // render the data point markers or not.
//				markerRenderer : $.jqplot.MarkerRenderer, // renderer to use to draw the data // point markers.
//                    markerOptions : {
//                        show : true, // whether to show data point markers.
//                        style : 'circle', // circle, diamond, square, filledCircle.  // filledDiamond or filledSquare.
//                        lineWidth : 1, // color of marker, set to color of line by default.
//                        size : 0.5,
//                        shadow : false, // whether to draw shadow on marker or not.
//                        shadowAngle : 45, // angle of the shadow.  Clockwise from x axis.
//                        shadowOffset : 1, // offset from the line of the shadow,
//                        shadowDepth : 3, // Number of strokes to make when drawing shadow.  Each stroke // offset by shadowOffset from the last.
//                        shadowAlpha : 0.07
//                    // Opacity of the shadow
//                    }
//			}, {
//				label: 'CPU1',
//				lineWidth:2,
//                                show : true,
//                                showLine : true, // whether to render the line segments or not.
//                                showMarker : true, // render the data point markers or not.
//				markerRenderer : $.jqplot.MarkerRenderer, // renderer to use to draw the data // point markers.
//                    markerOptions : {
//                        show : true, // whether to show data point markers.
//                        style : 'circle', // circle, diamond, square, filledCircle.  // filledDiamond or filledSquare.
//                        lineWidth : 1,  // color of marker, set to color of line by default.
//                        shadow : false, // whether to draw shadow on marker or not.
//                        size : 0.5,
//                        shadowAngle : 45, // angle of the shadow.  Clockwise from x axis.
//                        shadowOffset : 1, // offset from the line of the shadow,
//                        shadowDepth : 3, // Number of strokes to make when drawing shadow.  Each stroke // offset by shadowOffset from the last.
//                        shadowAlpha : 0.07
//                    // Opacity of the shadow
//                    }
//			} ],
                title : {
                    text : "",
                    show: false
                },
                // Set default options on all series, turn on smoothing.
                seriesDefaults : {
                    show : true, // whether to render the series.
                    xaxis : 'xaxis', // either ‘xaxis’ or ‘x2axis’.
                    yaxis : 'yaxis', // either ‘yaxis’ or ‘y2axis’.
                    label : '', // label to use in the legend for this line.
                    lineWidth : 2, // Width of the line in pixels.
                    shadow : false, // show shadow or not.
                    shadowAngle : 45, // angle (degrees) of the shadow, clockwise from x axis.
                    shadowOffset : 1.25, // offset from the line of the shadow.
                    shadowDepth : 3, // Number of strokes to make when drawing shadow.  Each // stroke offset by shadowOffset from the last.
                    shadowAlpha : 0.1, // Opacity of the shadow.
                    showLine : true, // whether to render the line segments or not.
                    showMarker : true, // render the data point markers or not.
                    fill : false, // fill under the line,
                    fillAndStroke : true, // stroke a line at top of fill area.
                    fillColor : undefined, // custom fill color for filled lines (default is line color).
                    fillAlpha : undefined, // custom alpha to apply to fillColor. // renderer used to draw the series.
                    rendererOptions : {smooth: true}, // options passed to the renderer.  LineRenderer has no options.
                    markerRenderer : $.jqplot.MarkerRenderer, // renderer to use to draw the data // point markers.
                    markerOptions : {
                        show : true, // whether to show data point markers.
                        style : 'circle', // circle, diamond, square, filledCircle.  // filledDiamond or filledSquare.
                        lineWidth : 1,  // color of marker, set to color of line by default.
                        shadow : false, // whether to draw shadow on marker or not.
                        size : 2,
                        shadowAngle : 45, // angle of the shadow.  Clockwise from x axis.
                        shadowOffset : 1, // offset from the line of the shadow,
                        shadowDepth : 3, // Number of strokes to make when drawing shadow.  Each stroke // offset by shadowOffset from the last.
                        shadowAlpha : 0.07
                    // Opacity of the shadow
                    }
                },
                highlighter : {
                    tooltipFadeSpeed : 'slow',
                    tooltipLocation : 'n',
                    sizeAdjust : 5,
                    show : true,
                    tooltipAxes : 'both',
                    labels : [],
                    tooltipContentEditor : function (str, seriesIndex, pointIndex, plot) {
                                var date = plot.data[seriesIndex][pointIndex][0];
                                var currentDate = new Date(date);
                                var currentDay = currentDate.getDate();
                                var currentMonth = currentDate.getMonth() + 1;
                                var currentYear = currentDate.getFullYear();
                                currentDate = currentDay+"-"+currentMonth+"-"+currentYear+" "+currentDate.getHours() + ":" + currentDate.getMinutes() + ":" + currentDate.getSeconds();
                                var label = pandaChart.chartOptions.highlighter.labels[seriesIndex];
                                var point = plot.data[seriesIndex][pointIndex][1];
                                var html = "<div class='pop text-center'>";
                                html += currentDate;
                                html += "  <br> " + label;
                                html += point.toFixed(2);
                                html += "  </div>";

                                return html;
                            },
                    useAxesFormatters : false
                },
                cursor : {
                    show : false
                },
                grid : {
                    drawGridLines : true, // whether to draw lines across the grid or not.
                    gridLineColor : '#cccccc', // Color of the grid lines.
                    background : '#ffffff', // CSS color spec for background color of grid.
                    borderColor : '#999999', // CSS color spec for border around grid.
                    borderWidth : 2.0, // pixel width of border around grid.
                    shadowAngle : 45, // angle of the shadow.  Clockwise from x axis.
                    shadowOffset : 1.5, // offset from the line of the shadow.
                    shadowWidth : 3, // width of the stroke for the shadow.
                    shadowDepth : 3, // Number of strokes to make when drawing shadow.  // Each stroke offset by shadowOffset from the last.
                    shadowAlpha : 0.07, // Opacity of the shadow
                    renderer : $.jqplot.CanvasGridRenderer, // renderer to use to draw the grid.
                    rendererOptions : {},
                    borderColor: 'white',
                    shadow: false,
                    drawBorder: false
                // options to pass to the renderer.  Note, the default // CanvasGridRenderer takes no additional options.  },
                },
                series : [],
                noDataIndicator : {
                    show : true
                },
                background : 'rgba(255,0,0,0.1)',
                textColor : "#ff0000"
            }
        }
        return pandaChart;
    }
    return object;
}

angular.module('homer').factory('monitorServiceJQ', monitorServiceJQ);
