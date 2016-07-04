<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />
<div class="m-l-sm m-r-sm monitor-charts" ng-controller="monitorsCtrl">
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
                            data-ng-click="updateGraphByRange('cpu')"
                            class="btn btn-info"><span class="fa fa-refresh fa-lg "></span></a>
                    </div>

                    <div class="pull-right m-r-sm">
                        <select data-ng-change="updateGraphByRange('cpu')" class="form-control"
                            name="cpuActions"
                            data-ng-init="range.cpu.actions = instanceElements.actions[0];"
                            data-ng-model="range.cpu.actions"
                            ng-options="actions.name for actions in instanceElements.actions">
                        </select>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <get-monitor-loader-image-memory data-ng-show="monitorMemoryImage"></get-monitor-loader-image-memory>
        <div data-ng-show="!monitorMemoryImage" class="col-md-offset-1 col-md-11">
            <div id="cpuChart" style="height:300px; width:90%;"></div>
        </div>
    </div>
    <div class="row" data-ng-if="cpuData.length > 0">
        <div class="col-md-12">
            <div id="cpuLegendContent" class="flotchart-legend-content">
                <table style="font-size: smaller; color: #545454"
                    class="flotchart-legend-content-table">
                    <tbody>
                        <tr data-ng-repeat="cpuLegend in cpuLabels">
                            <td class="legendColorBox">
                                <a data-ng-click="toggleCpuPlot($index, cpuLegend)"><i class="fa fa-desktop"></i></a>
                            </td>
                            <td class="legendLabel">
                                <div style="border: 1px solid #ccc; padding: 1px;" class="pull-left m-r-xs m-l-xs">
                                    <div style="width: 4px; height: 0; overflow: hidden"
                                         ng-style="{'border': '5px solid ' + seriesColors[$index] }"><a data-ng-click="toggleCpuPlot($index, cpuLegend)"></a></div>
                                </div>
                                <a class="pull-left" data-ng-click="toggleCpuPlot($index, cpuLegend)"> <span style="text-transform: uppercase">{{cpuLegend }} </span></a>
                             </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <hr>
     <div class="row clearfix ">
        <div class="col-lg-12 col-md-12 col-sm-12">
            <div class="hpanel">
                <div class="row">
                    <div class="pull-left ">
                        <h4 class="m-b-sm ng-binding pull-left">
                            <fmt:message key="disk.performance" bundle="${msg}" />
                        </h4>
                    </div>

                    <div class="pull-right">
                        <a title="<fmt:message key="common.refresh" bundle="${msg}" />"
                            href="javascript:void(0)"
                            data-ng-click="updateGraphByRange('disk')"
                            class="btn btn-info"><span class="fa fa-refresh fa-lg "></span></a>
                    </div>

                    <div class="pull-right m-r-sm">
                        <select data-ng-change="updateGraphByRange('disk')" class="form-control"
                            name="diskActions"
                            data-ng-init="range.disk.actions = instanceElements.actions[0];"
                            data-ng-model="range.disk.actions"
                            ng-options="actions.name for actions in instanceElements.actions">
                        </select>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <get-monitor-loader-image-memory data-ng-show="monitorMemoryImage"></get-monitor-loader-image-memory>
        <div data-ng-show="!monitorMemoryImage" class="col-md-offset-1 col-md-11">
            <div id="diskChart" style="height:300px; width:90%;"></div>
        </div>
    </div>
    <div class="row" data-ng-if="diskReadData.length > 0">
        <div class="col-md-12">
            <div id="cpuLegendContent" class="flotchart-legend-content">
                <table style="font-size: smaller; color: #545454"
                    class="flotchart-legend-content-table">
                    <tbody>
                        <tr data-ng-repeat="diskLegend in diskLabels">
                            <td class="legendColorBox">
                                <a data-ng-click="toggleDiskPlot($index, diskLegend)"><i class="fa fa-desktop"></i></a>
                            </td>
                            <td class="legendLabel">
                                <div style="border: 1px solid #ccc; padding: 1px;" class="pull-left m-r-xs m-l-xs">
                                    <div style="width: 4px; height: 0; overflow: hidden"
                                         ng-style="{'border': '5px solid ' + seriesColors[$index] }"><a data-ng-click="toggleDiskPlot($index, diskLegend)"></a></div>
                                </div>
                                <a class="pull-left" data-ng-click="toggleDiskPlot($index, diskLegend)" style="text-transform: capitalize">{{diskLegend}}</a>
                             </td>                           
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <hr>
    <div class="row clearfix ">
        <div class="col-lg-12 col-md-12 col-sm-12">
            <div class="hpanel">
                <div class="row">
                    <div class="pull-left ">
                        <h4 class="m-b-sm ng-binding pull-left">
                            <fmt:message key="memory.performance" bundle="${msg}" />
                        </h4>
                    </div>

                    <div class="pull-right">
                        <a title="<fmt:message key="common.refresh" bundle="${msg}" />"
                            href="javascript:void(0)"
                            data-ng-click="updateGraphByRange('memory')"
                            class="btn btn-info"><span class="fa fa-refresh fa-lg "></span></a>
                    </div>

                    <div class="pull-right m-r-sm">
                        <select data-ng-change="updateGraphByRange('memory')" class="form-control"
                            name="diskActions"
                            data-ng-init="range.memory.actions = instanceElements.actions[0];"
                            data-ng-model="range.memory.actions"
                            ng-options="actions.name for actions in instanceElements.actions">
                        </select>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <get-monitor-loader-image-memory data-ng-show="monitorMemoryImage"></get-monitor-loader-image-memory>
        <div data-ng-show="!monitorMemoryImage" class="col-md-offset-1 col-md-11">
            <div id="memoryChart" style="height:300px; width:90%;"></div>
        </div>
    </div>
    <div class="row" data-ng-if="memoryFreeData.length > 0">
        <div class="col-md-12">
            <div id="cpuLegendContent" class="flotchart-legend-content">
                <table style="font-size: smaller; color: #545454"
                    class="flotchart-legend-content-table">
                    <tbody>
                        <tr data-ng-repeat="memoryLegend in memoryLabels">
                            <td class="legendColorBox">
                                <a data-ng-click="toggleMemoryPlot($index, memoryLegend)"><i class="fa fa-desktop"></i></a>
                            </td>
                            <td class="legendLabel">
                                <div style="border: 1px solid #ccc; padding: 1px;" class="pull-left m-r-xs m-l-xs">
                                    <div style="width: 4px; height: 0; overflow: hidden"
                                         ng-style="{'border': '5px solid ' + seriesColors[$index] }"><a data-ng-click="toggleMemoryPlot($index, memoryLegend)"></a></div>
                                </div>
                                <a class="pull-left" data-ng-click="toggleMemoryPlot($index, memoryLegend)" style="text-transform: capitalize">{{memoryLegend}}</a>
                             </td>                           
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <hr>
    <div class="row clearfix ">
        <div class="col-lg-12 col-md-12 col-sm-12">
            <div class="hpanel">
                <div class="row">
                    <div class="pull-left ">
                        <h4 class="m-b-sm ng-binding pull-left">
                            <fmt:message key="network.performance" bundle="${msg}" />
                        </h4>
                    </div>

                    <div class="pull-right">
                        <a title="<fmt:message key="common.refresh" bundle="${msg}" />"
                            href="javascript:void(0)"
                            data-ng-click="updateGraphByRange('network')"
                            class="btn btn-info"><span class="fa fa-refresh fa-lg "></span></a>
                    </div>

                    <div class="pull-right m-r-sm">
                        <select data-ng-change="updateGraphByRange('network')" class="form-control"
                            name="diskActions"
                            data-ng-init="range.network.actions = instanceElements.actions[0];"
                            data-ng-model="range.network.actions"
                            ng-options="actions.name for actions in instanceElements.actions">
                        </select>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <get-monitor-loader-image-memory data-ng-show="monitorMemoryImage"></get-monitor-loader-image-memory>
        <div data-ng-show="!monitorMemoryImage" class="col-md-offset-1 col-md-11">
            <div id="networkChart" style="height:300px; width:90%;"></div>
        </div>
    </div>
    <div class="row" data-ng-if="networkInData.length > 0">
        <div class="col-md-12">
            <div id="cpuLegendContent" class="flotchart-legend-content">
                <table style="font-size: smaller; color: #545454"
                    class="flotchart-legend-content-table">
                    <tbody>
                        <tr data-ng-repeat="networkLegend in networkLabels">
                            <td class="legendColorBox">
                                <a data-ng-click="toggleNetworkPlot($index, networkLegend)"><i class="fa fa-desktop"></i></a>
                            </td>
                            <td class="legendLabel">
                                <div style="border: 1px solid #ccc; padding: 1px;" class="pull-left m-r-xs m-l-xs">
                                    <div style="width: 4px; height: 0; overflow: hidden"
                                         ng-style="{'border': '5px solid ' + seriesColors[$index] }"><a data-ng-click="toggleNetworkPlot($index, networkLegend)"></a></div>
                                </div>
                                <a class="pull-left" data-ng-click="toggleNetworkPlot($index, networkLegend)" style="text-transform: capitalize">{{networkLegend}}</a>
                             </td>                           
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>