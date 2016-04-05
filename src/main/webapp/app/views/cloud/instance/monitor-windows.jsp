<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div class="m-l-sm m-r-sm " ng-controller="instanceMonitorWindowsCtrl">

    <div class="row clearfix ">

        <div class="col-lg-12 col-md-12 col-sm-12">

            <div class="hpanel">
                <div class="row">
                    <div class="pull-left ">
                        <h4 class="m-b-sm ng-binding pull-left">
                            <fmt:message key="cpu.performance" bundle="${msg}" />
                        </h4>
                    </div>

                    <div class="pull-right">
                        <a title="<fmt:message key="common.refresh" bundle="${msg}" />"
                            href="javascript:void(0)"
                            data-ng-click="updateGraphByRange()"
                            class="btn btn-info"><span class="fa fa-refresh fa-lg "></span></a>
                    </div>

                    <div class="pull-right m-r-sm">




                        <select data-ng-change="updateGraphByRange()" class="form-control"
                            name="cpuActions"
                            data-ng-init="range.actions = instanceElements.actions[0]; updateGraphByRange();"
                            data-ng-model="range.actions"
                            ng-options="actions.name for actions in instanceElements.actions">
                        </select>
                    </div>

                </div>


            </div>

        </div>
    </div>





    <div class="row" id="cpu-chart-container">
        <div class="col-md-offset-1 col-md-11">
            <div class="hide-left"></div>
            <div class="hide-right"></div>
            <flot dataset="cpu.dataset" options="flotOptions" height="280px" class="flotchart-container"></flot>
            <!--<div id="cpuLegendContainer" class="flotchart-legend-container"></div> -->
        </div>
    </div>



    <div class="row">
        <div class="col-md-12">
            <div id="cpuLegendContent" class="flotchart-legend-content">
                <table style="font-size: smaller; color: #545454"
                    class="flotchart-legend-content-table">
                    <tbody>
                        <tr data-ng-repeat="cpuLegend in cpuData">
                            <td class="legendColorBox"
                                data-ng-click="togglePlot($index, cpuData.length)"><a></a>
                                <div style="border: 1px solid #ccc; padding: 1px;">
                                    <div style="width: 4px; height: 0; overflow: hidden"
                                        ng-style="{'border': '5px solid ' + flotOptions.colors[$index] }"></div>
                                    <!-- <div data-ng-if="cpu.dataset[$index].length == 0" style="width: 4px; height: 0; border: 5px solid red; overflow: hidden"></div> -->
                                </div></td>
                            <td class="legendLabel"
                                data-ng-click="togglePlot($index, cpuData.length)"><a
                                class="m-l-sm">{{ $index == 4 ? "AVERAGE" : "CPU " }} Total </a></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <hr>
    <div class="row">

        <div class="col-lg-12 col-md-12 col-sm-12">

            <div class="hpanel">
                <div class="row">
                    <div class="pull-left">
                        <h4 class="m-b-sm ng-binding pull-left">
                            <fmt:message key="memory.performance" bundle="${msg}" />
                            (MB)
                        </h4>
                    </div>
                </div>
            </div>
        </div>


    </div>

    <div class="row" id="memory-chart-container">
        <div class="col-md-offset-1 col-md-11">
            <div class="hide-left"></div>
            <div class="hide-right"></div>
            <flot dataset="memory.dataset" options="memoryFlotOptions"
                height="280px" class="flotchart-container"></flot>
            <!-- <div id="memoryLegendContainer" class="flotchart-legend-container"></div> -->
        </div>
    </div>
    <div class="row">
    <div class="col-md-12">
            <div id="memoryLegendContent" class="flotchart-legend-content">
                <table style="font-size: smaller; color: #545454" class="flotchart-legend-content-table">
                    <tbody>
                        <tr data-ng-repeat="memoryLegend in memoryData">
                            <td class="legendColorBox"
                                data-ng-click="toggleMemoryPlot($index, memoryData.length)">
                                <a></a>
                                <div style="border: 1px solid #ccc; padding: 1px;">
                                    <div style="width: 4px; height: 0; overflow: hidden"
                                        ng-style="{'border': '5px solid ' + memoryFlotOptions.colors[$index] }"></div>
                                </div>
                            </td>
                            <td class="legendLabel">
                                <a class="m-l-sm">{{ ($index == 0 ? "Total" : "Free") }}</a>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
     </div>
    <hr>

    <div class="row">

        <div class="col-lg-12 col-md-12 col-sm-12">

            <div class="hpanel">
                <div class="row">
                    <div class="pull-left">
                        <h4 class="m-b-sm ng-binding pull-left">
                            <fmt:message key="disk.performance" bundle="${msg}" />
                            (Bps)
                        </h4>


                    </div>
                </div>
            </div>
        </div>


    </div>

    <div class="row" id="storage-chart-container">
        <div class="col-md-offset-1 col-md-11">
            <div class="hide-left"></div>
            <div class="hide-right"></div>
            <flot dataset="storage.dataset" options="storageFlotOptions"
                height="280px" class="flotchart-container"></flot>
            <!-- <div id="storageLegendContainer" class="flotchart-legend-container"></div> -->
        </div>
    </div>
    <div class="row">

        <div class="col-md-12">
            <div id="storageLegendContent" class="flotchart-legend-content">
                <table class="flotchart-legend-content-table"
                    style="font-size: smaller; color: #545454">
                    <tbody>
                        <tr data-ng-repeat="storyLegend in storageData">
                            <td class="legendColorBox"
                                data-ng-click="toggleStoragePlot($index, storageData.length)">
                                <a></a>
                                <div style="border: 1px solid #ccc; padding: 1px;">
                                    <div style="width: 4px; height: 0; overflow: hidden"
                                        ng-style="{'border': '5px solid ' + storageFlotOptions.colors[$index] }"></div>
                                </div>
                            </td>
                            <td class="legendLabel">

                                <a class="m-l-sm">{{ ($index == 0 ? "Disk Write" : "Disk
                                    Read") }}</a>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

     <hr>

    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12">
            <div class="hpanel">
                <div class="row">
                    <div class="pull-left">
                        <h4 class="m-b-sm ng-binding pull-left">
                            <fmt:message key="network.performance" bundle="${msg}" />
                            (Bps)
                        </h4>


                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row" id="network-chart-container-windows">
        <div class="col-md-offset-1 col-md-11">
            <div class="hide-left"></div>
            <div class="hide-right"></div>
            <flot dataset="network.dataset" options="networkFlotOptions" height="280px" class="flotchart-container"></flot>
            <!--<div id="cpuLegendContainer" class="flotchart-legend-container"></div> -->
        </div>
    </div>



    <div class="row">
        <div class="col-md-12">
            <div id="networkLegendContentWindows" class="flotchart-legend-content">
                <table style="font-size: smaller; color: #545454"
                    class="flotchart-legend-content-table">
                    <tbody>
                        <tr data-ng-repeat="networkLegend in networkData">
                            <td class="legendColorBox"
                                data-ng-click="toggleNetworkPlot($index, networkData.length)"><a></a>
                                <div style="border: 1px solid #ccc; padding: 1px;">
                                    <div style="width: 4px; height: 0; overflow: hidden"
                                        ng-style="{'border': '5px solid ' + flotOptions.colors[$index] }"></div>
                                    <!-- <div data-ng-if="cpu.dataset[$index].length == 0" style="width: 4px; height: 0; border: 5px solid red; overflow: hidden"></div> -->
                                </div></td>
                            <td class="legendLabel"><a class="m-l-sm">{{ $index == 0 ? "In" : "Out" }} </a></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <hr>

</div>

<!-- <flot dataset="myData" options="myChartOptions"></flot> -->

