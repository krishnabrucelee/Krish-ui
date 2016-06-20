<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div class="m-l-sm m-r-sm monitor-charts" ng-controller="instanceMonitorCtrl">
	<div data-ng-show = "showLoader" style="margin: 20%">
                <get-loader-image data-ng-if="showLoader"></get-loader-image>
            </div>
            <div data-ng-hide="showLoader">
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
                            data-ng-init="range.actions = instanceElements.actions[0];"
                            data-ng-model="range.actions"
                            ng-options="actions.name for actions in instanceElements.actions">
                        </select>
                    </div>

                </div>


            </div>

        </div>
    </div>

    <div class="row" id="cpu-chart-container">
     <get-monitor-loader-image data-ng-show="monitorImage"></get-monitor-loader-image>
        <div class="col-md-offset-1 col-md-11">
            <div class="hide-left" data-ng-hide="monitorImage"></div>
            <div class="hide-right" data-ng-hide="monitorImage"></div>
            <flot dataset="cpu.dataset" data-ng-hide="monitorImage" options="flotOptions" height="280px" class="flotchart-container"></flot>
            <!--<div id="cpuLegendContainer" class="flotchart-legend-container"></div> -->
        </div>
    </div>

    <div class="row" data-ng-if="cpuData.length > 0">
        <div class="col-md-12">
            <div id="cpuLegendContent" class="flotchart-legend-content">
                <table style="font-size: smaller; color: #545454"
                    class="flotchart-legend-content-table">
                    <tbody>
                        <tr data-ng-repeat="cpuLegend in cpuData">
                            <td class="legendColorBox"
                                data-ng-click="togglePlot($index, cpuData.length)"><a></a>
                                <i class="fa fa-desktop"></i>

                                </td>
                            <td class="legendLabel"
                                data-ng-click="togglePlot($index, cpuData.length)">
                                <div style="border: 1px solid #ccc; padding: 1px;" class="pull-left m-r-xs m-l-xs">
                                    <div style="width: 4px; height: 0; overflow: hidden"
                                        ng-style="{'border': '5px solid ' + flotOptions.colors[$index] }"></div>
                                </div>
                                <a class="pull-left">{{ $index == 4 ? "AVERAGE" : "CPU " + $index }} </a>

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
                            <fmt:message key="memory.performance" bundle="${msg}" />
                            (MB)
                        </h4>
                    </div>
                </div>
            </div>
        </div>


    </div>

    <div class="row" id="memory-chart-container">
    <get-monitor-loader-image data-ng-show="monitorImage"></get-monitor-loader-image>
        <div class="col-md-offset-1 col-md-11">
            <div class="hide-left" data-ng-hide="monitorImage"></div>
            <div class="hide-right" data-ng-hide="monitorImage"></div>
            <flot dataset="memory.dataset" data-ng-hide="monitorImage" options="memoryFlotOptions"
                height="280px" class="flotchart-container"></flot>
            <!-- <div id="memoryLegendContainer" class="flotchart-legend-container"></div> -->
        </div>
    </div>

    <div class="row" data-ng-if="memoryData.length >0">
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
         <get-monitor-loader-image data-ng-show="monitorImage"></get-monitor-loader-image>
        <div class="col-md-offset-1 col-md-11">
            <div class="hide-left" data-ng-hide="monitorImage"> </div>
            <div class="hide-right" data-ng-hide="monitorImage"></div>
            <flot dataset="storage.dataset" options="storageFlotOptions" data-ng-hide="monitorImage" height="280px" class="flotchart-container"></flot>
            <!-- <div id="storageLegendContainer" class="flotchart-legend-container"></div> -->
        </div>
    </div>

    <div class="row" data-ng-if="storageData.length > 0">

        <div class="col-md-12">
            <div id="storageLegendContent" class="flotchart-legend-content">
                <table class="flotchart-legend-content-table"
                    style="font-size: smaller; color: #545454">
                    <tbody>

                        <tr>
                            <td class="legendColorBox">
                                <a data-ng-click="toggleStoragePlot('read')">
                                <div style="border: 1px solid #ccc; padding: 1px;">
                                    <div style="width: 4px; height: 0; overflow: hidden"
                                        ng-style="{'border': '5px solid ' + storageFlotOptions.colors[0] }"></div>
                                </div>
                                </a>
                            </td>
                            <td class="legendLabel">
                                <a class="m-l-sm" data-ng-click="toggleStoragePlot('read')">Disk Read</a>
                            </td>
                         </tr>
                          <tr>
                            <td class="legendColorBox">
                                <a
                                data-ng-click="toggleStoragePlot('write')">
                                <div style="border: 1px solid #ccc; padding: 1px;">
                                    <div style="width: 4px; height: 0; overflow: hidden"
                                        ng-style="{'border': '5px solid ' + storageFlotOptions.colors[1] }"></div>
                                </div>
                                </a>
                            </td>
                            <td class="legendLabel">
                                <a class="m-l-sm" data-ng-click="toggleStoragePlot('write')">Disk Write</a>
                            </td>
                         </tr>
                    </tbody>
                </table>
                <table class="flotchart-legend-content-table"
                    style="font-size: smaller; color: #545454">
                    <tbody>
                         <tr data-ng-repeat="storyLegend in storageData">
                            <td class="legendColorBox " data-ng-class="storageIndex == $index ? 'active' : ''"
                                data-ng-click="toggleDiskPlot($index, storageData.length)">
                                <a>
                                <i class="fa fa-2x fa-hdd-o m-r-xs"></i>
                                {{currentDisk[$index]}}
                                </a>
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

    <div class="row" id="network-chart-container" >
        <get-monitor-loader-image data-ng-show="monitorImage"></get-monitor-loader-image>
        <div class="col-md-offset-1 col-md-11">
            <div class="hide-left" data-ng-hide="monitorImage"></div>
            <div class="hide-right" data-ng-hide="monitorImage"></div>
            <flot dataset="network.dataset" data-ng-hide="monitorImage" options="networkFlotOptions" height="280px" class="flotchart-container"></flot>
            <!--<div id="cpuLegendContainer" class="flotchart-legend-container"></div> -->
        </div>
    </div>

    <div class="row" data-ng-if="networkData.length > 0">
        <div class="col-md-12">
            <div id="networkLegendContent" class="flotchart-legend-content">
                <table style="font-size: smaller; color: #545454"
                    class="flotchart-legend-content-table">
                    <tbody>
                        <tr>
                            <td class="legendColorBox"
                                data-ng-click="toggleNetPlot('send')">
                                <a></a>
                                <div style="border: 1px solid #ccc; padding: 1px;">
                                    <div style="width: 4px; height: 0; overflow: hidden"
                                        ng-style="{'border': '5px solid ' + storageFlotOptions.colors[0] }"></div>
                                </div>
                            </td>
                            <td class="legendLabel">
                                <a data-ng-click="toggleNetPlot('send')" class="m-l-sm">IN</a>
                            </td>
                         </tr>
                          <tr>
                            <td class="legendColorBox"
                                data-ng-click="toggleNetPlot('receive')">
                                <a></a>
                                <div style="border: 1px solid #ccc; padding: 1px;">
                                    <div style="width: 4px; height: 0; overflow: hidden"
                                        ng-style="{'border': '5px solid ' + storageFlotOptions.colors[1] }"></div>
                                </div>
                            </td>
                            <td class="legendLabel">
                                <a data-ng-click="toggleNetPlot('receive')" class="m-l-sm">OUT</a>
                            </td>
                         </tr>
                    </tbody>
                </table>
                <table style="font-size: smaller; color: #545454"
                    class="flotchart-legend-content-table">
                    <tbody>
                        <tr data-ng-repeat="networkLegend in networkData">
                            <td class="legendColorBox" data-ng-class="networkIndex == $index ? 'active' : ''"
                                data-ng-click="toggleNetworkPlot($index, networkData.length)">
							<a><i class="fa fa-sitemap fa-2x m-r-xs"></i>{{currentNetwork[$index]}}</a>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <hr>
</div>
</div>

<!-- <flot dataset="myData" options="myChartOptions"></flot> -->

