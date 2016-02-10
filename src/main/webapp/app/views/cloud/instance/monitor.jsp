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
                    <div class="pull-right">
                        <a title="<fmt:message key="common.refresh" bundle="${msg}" />" href="javascript:void(0)" class="btn btn-info" ><span class="fa fa-refresh fa-lg "></span></a>

                    </div>

                    <div class="pull-right m-r-sm">

                        <select  class="form-control" name="actions" data-ng-init="instance.actions = instanceElements.actions[3].name" data-ng-model="instance.actions" ng-options="actions.name for actions in instanceElements.actions" >
                            <option value=""><fmt:message key="minutes" bundle="${msg}" /></option>
                        </select>
                    </div>

                </div>
                    <div class="row"><hr class="m-t-xs"></div>
                    <div class="row" >
                    <div class="chart" >
                     	<canvas class="hide"   responsive="true"></canvas>
                        <canvas linechart options="lineOptions" data="cpu" width="780" height="220" ></canvas>
                    </div></div>
                    <table>
                        <tbody>
                            <tr>
                                <td class="legendColorBox p-xs">
                                    <div style="border:1px solid #ccc;padding:1px"><div style="width:4px;height:0;border:5px solid #E56919;overflow:hidden"></div></div>
                                </td>
                                <td class="legendLabel">CPU 0</td>
                                <td class="legendColorBox p-xs"><div style="border:1px solid #ccc;padding:1px"><div style="width:4px;height:0;border:5px solid #16658D;overflow:hidden"></div></div>
                                </td>
                                <td class="legendLabel">CPU 1</td>
                                <!-- <td class="legendLabel">CPU 2</td><td class="legendColorBox p-xs"><div style="border:1px solid #ccc;padding:1px"><div style="width:4px;height:0;border:5px solid rgba(98,203,49,0.5);overflow:hidden"></div></div>
                                </td>
                                <td class="legendLabel">CPU 3</td> -->
                                </tr></tbody></table>

                </div>
            </div>
                                    <!--<hr class="m-t-xs">-->


        </div>
        <div class="row" >

            <div class="col-lg-10 col-md-10 col-sm-12 col-md-offset-1 ">

                <div class="hpanel">
                    <div class="row">
                    <div class="pull-left">
                        <h4 class="m-b-sm ng-binding pull-left"><fmt:message key="memory.performance" bundle="${msg}" /></h4>


                    </div>
                    <div class="pull-right">
                        <a href="javascript:void(0);" title="<fmt:message key="common.refresh" bundle="${msg}" />"  class="btn btn-info" href="#/instance/list"><span class="fa fa-refresh fa-lg "></span></a>

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
                        <canvas linechart options="lineOptions" data="memory" width="780" height="220"></canvas>
                    </div>
                    </div>
                    <table>
                        <tbody>
                            <tr>
                                <td class="legendColorBox p-xs">
                                    <div style="border:1px solid #ccc;padding:1px"><div style="width:4px;height:0;border:5px solid #E56919;overflow:hidden"></div></div>
                                </td>
                                <td class="legendLabel">Total</td>
                                <td class="legendColorBox p-xs"><div style="border:1px solid #ccc;padding:1px"><div style="width:4px;height:0;border:5px solid #16658D;overflow:hidden"></div></div>
                                </td>
                                <td class="legendLabel"><fmt:message key="unused.memory" bundle="${msg}" /></td><td class="legendColorBox p-xs">
                                </td>
                                <td class="legendColorBox p-xs"><div style="border:1px solid #ccc;padding:1px"><div style="width:4px;height:0;border:5px solid #7208A8;overflow:hidden"></div></div>
                                </td>
                                <td class="legendLabel"><fmt:message key="used.memory" bundle="${msg}" /></td><td class="legendColorBox p-xs">
                                </td>
                                </tr></tbody></table>

                </div>
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
        <div class="row " >

            <div class="col-lg-10 col-md-10 col-sm-12 col-md-offset-1 ">

                <div class="hpanel">
                    <div class="row">
                    <div class="pull-left">
                        <h4 class="m-b-sm ng-binding pull-left"><fmt:message key="disk.performance" bundle="${msg}" /></h4>


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
                                <td class="legendLabel"><fmt:message key="disk.iops" bundle="${msg}" /></td>

                                </tr></tbody></table>

                </div>
            </div>
        </div>
      </div>


