<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

    <div class="m-l-sm m-r-sm " ng-controller="instanceMonitorCtrl">

       <div class="row " >

            <div class="col-lg-10 col-md-10 col-sm-12 col-md-offset-1 animated-panel">

                <div class="hpanel">
                    <div class="row">
                    <div class="pull-left ">
                        <h4 class="m-b-sm ng-binding pull-left"><fmt:message key="cpu.performance" bundle="${msg}" /></h4>


                    </div>
                    <div class="pull-right"><!-- data-ng-click="updateCpuPerformance(cpu.result, cpu.actions)"  -->
                        <a title="<fmt:message key="common.refresh" bundle="${msg}" />" href="javascript:void(0)" data-ng-click="updateCpuPerformance(cpu.result, cpu.actions)" class="btn btn-info" ><span class="fa fa-refresh fa-lg "></span></a>

                    </div>

                    <div class="pull-right m-r-sm">

                        <select  data-ng-change="updateCpuPerformance(cpu.result, cpu.actions)"   class="form-control" name="cpuActions" data-ng-init="cpu.actions = instanceElements.actions[0]; updateCpuPerformance(cpu.result, cpu.actions);" data-ng-model="cpu.actions" ng-options="actions.name for actions in instanceElements.actions" >
                        </select>
                    </div>

                </div>


                </div>
            </div>
        </div>
        <div class="row"  id="cpu-chart-container">
        	<div class="col-md-offset-1 col-md-11">
        		<div class="hide-left"></div>
	        	<div class="hide-right"></div>
		        <flot dataset="cpu.dataset" options="flotOptions" height="280px" class="flotchart-container" ></flot>
				<div id="cpuLegendContainer" class="flotchart-legend-container"></div>
			</div>
		</div>
		<hr>
        <div class="row" >

            <div class="col-lg-10 col-md-10 col-sm-12 col-md-offset-1 ">

                <div class="hpanel">
                    <div class="row">
                    <div class="pull-left">
                        <h4 class="m-b-sm ng-binding pull-left"><fmt:message key="memory.performance" bundle="${msg}" /> (MB)</h4>


                    </div>
                    <div class="pull-right">
                        <a href="javascript:void(0);" title="<fmt:message key="common.refresh" bundle="${msg}" />"  class="btn btn-info" href="#/instance/list"><span class="fa fa-refresh fa-lg "></span></a>

                    </div>

                    <div class="pull-right m-r-sm">

                        <select  data-ng-change="updateMemoryPerformance(memory.result, memory.actions)"   class="form-control" name="memoryActions" data-ng-init="memory.actions = instanceElements.actions[0]; updateMemoryPerformance(memory.result, memory.actions);" data-ng-model="memory.actions" ng-options="actions.name for actions in instanceElements.actions" >
                        </select>
                    </div>
                    </div>
                 </div>
            </div>
        </div>

        <div class="row"  id="memory-chart-container">
        	<div class="col-md-offset-1 col-md-11">
        		<div class="hide-left"></div>
	        	<div class="hide-right"></div>
		        <flot dataset="memory.dataset" options="memoryFlotOptions" height="280px" class="flotchart-container" ></flot>
				<div id="memoryLegendContainer" class="flotchart-legend-container"></div>
			</div>
		</div>
		<hr>

		 <div class="row" >

            <div class="col-lg-10 col-md-10 col-sm-12 col-md-offset-1 ">

                <div class="hpanel">
                    <div class="row">
                    <div class="pull-left">
                        <h4 class="m-b-sm ng-binding pull-left"><fmt:message key="disk.performance" bundle="${msg}" /> (MB)</h4>


                    </div>
                    <div class="pull-right">
                        <a href="javascript:void(0);" title="<fmt:message key="common.refresh" bundle="${msg}" />"  class="btn btn-info" href="#/instance/list"><span class="fa fa-refresh fa-lg "></span></a>

                    </div>

                    <div class="pull-right m-r-sm">

                        <select  data-ng-change="updateStoragePerformance(storage.result, storage.actions)"   class="form-control" name="storageActions" data-ng-init="storage.actions = instanceElements.actions[0]; updateStoragePerformance(storage.result, storage.actions);" data-ng-model="storage.actions" ng-options="actions.name for actions in instanceElements.actions" >
                        </select>
                    </div>
                    </div>
                 </div>
            </div>
        </div>

        <div class="row"  id="storage-chart-container">
        	<div class="col-md-offset-1 col-md-11">
        		<div class="hide-left"></div>
	        	<div class="hide-right"></div>
		        <flot dataset="storage.dataset" options="storageFlotOptions" height="280px" class="flotchart-container" ></flot>
				<div id="storageLegendContainer" class="flotchart-legend-container"></div>
			</div>
		</div>
        <%-- <div class="row" >

            <div class="col-lg-10 col-md-10 col-sm-12 col-md-offset-1 ">

                <div class="hpanel">
                    <div class="row">
                    <div class="pull-left">
                        <h4 class="m-b-sm ng-binding pull-left"><fmt:message key="network.performance" bundle="${msg}" /></h4>


                    </div>
                    <div class="pull-right">
                        <a href="javascript:void(0);" title="<fmt:message key="common.refresh" bundle="${msg}" />" class="btn btn-info" href="#/instance/list"><span class="fa fa-refresh fa-lg "></span></a>

                    </div>

                    <div class="pull-right m-r-sm">

                        <select  class="form-control" name="actions" data-ng-init="instance.actions = instanceElements.actions[3].name" data-ng-model="instance.actions" ng-options="actions.name for actions in instanceElements.actions" >
                            <option value=""><fmt:message key="minutes" bundle="${msg}" /></option>
                        </select>
                    </div>
                    </div>
                    <div class="row"><hr class="m-t-xs"></div>
                    <div class="row">
                    <div class="chart">
                        <canvas linechart options="lineOptions" data="network" width="780" height="220"></canvas>
                    </div>
                    </div>
                    <table>
                        <tbody>
                            <tr>
                                <td class="legendColorBox p-xs">
                                    <div style="border:1px solid #ccc;padding:1px"><div style="width:4px;height:0;border:5px solid #E56919;overflow:hidden"></div></div>
                                </td>
                                <td class="legendLabel">NIC 0 - <fmt:message key="receive" bundle="${msg}" /></td>
                                <td class="legendColorBox p-xs"><div style="border:1px solid #ccc;padding:1px"><div style="width:4px;height:0;border:5px solid #16658D;overflow:hidden"></div></div>
                                </td>
                                <td class="legendLabel">NIC 0 - <fmt:message key="send" bundle="${msg}" /></td><td class="legendColorBox p-xs"><div style="border:1px solid #ccc;padding:1px"><div style="width:4px;height:0;border:5px solid #7208A8;overflow:hidden"></div></div>
                                </td>
                                <td class="legendLabel">NIC 1 - <fmt:message key="send" bundle="${msg}" /></td><td class="legendColorBox p-xs"><div style="border:1px solid #ccc;padding:1px"><div style="width:4px;height:0;border:5px solid rgba(98,203,49,0.5);overflow:hidden"></div></div>
                                </td>
                                <td class="legendLabel">NIC 1 - <fmt:message key="receive" bundle="${msg}" /></td></tr></tbody></table>

                </div>
            </div>
        </div> --%>
        <%-- <div class="row " >

            <div class="col-lg-10 col-md-10 col-sm-12 col-md-offset-1 ">

                <div class="hpanel">
                    <div class="row">
                    <div class="pull-left">
                        <h4 class="m-b-sm ng-binding pull-left"><fmt:message key="disk.performance" bundle="${msg}" /> (KBps)</h4>


                    </div>
                    <div class="pull-right">
                        <a href="javascript:void(0);" title="<fmt:message key="common.refresh" bundle="${msg}" />" class="btn btn-info" href="#/instance/list"><span class="fa fa-refresh fa-lg "></span></a>

                    </div>

                    <div class="pull-right m-r-sm">

                        <select  class="form-control" name="actions" data-ng-init="instance.actions = instanceElements.actions[3].name" data-ng-model="instance.actions" ng-options="actions.name for actions in instanceElements.actions" >
                            <option value=""><fmt:message key="minutes" bundle="${msg}" /></option>
                        </select>
                    </div>
                    </div>
                    <div class="row"><hr class="m-t-xs"></div>
                    <div class="row">
                    <div class="chart">
                        <canvas linechart options="lineOptions" data="disk" width="780" height="220"></canvas>
                    </div>
                    </div>
                    <table>
                        <tbody>
                            <tr>
                                <td class="legendColorBox p-xs">
                                    <div style="border:1px solid #ccc;padding:1px"><div style="width:4px;height:0;border:5px solid #E56919;overflow:hidden"></div></div>
                                </td>
                                <td class="legendLabel">Disk Write IOPS</td>
								<td class="legendColorBox p-xs">
                                    <div style="border:1px solid #ccc;padding:1px"><div style="width:4px;height:0;border:5px solid #16658D;overflow:hidden"></div></div>
                                </td>
                                <td class="legendLabel">Disk Read IOPS</td>

                                </tr></tbody></table>

                </div>
            </div>
        </div> --%>
      </div>

      <!-- <flot dataset="myData" options="myChartOptions"></flot> -->

