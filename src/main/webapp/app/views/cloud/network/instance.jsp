<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="panel-heading">
    <div class="row">
        <div class="pull-right">
            <div class="quick-search">
                <div class="input-group">
                    <input data-ng-model="networkSearch" type="text" class="form-control input-medium" placeholder="Quick Search" aria-describedby="quicksearch-go">
                    <span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
                </div>
            </div>
        </div>
    </div>
    <div class="clearfix"></div>
</div>
<div class="white-content">
    <form >
<div class="table-responsive col-12-table">
        <table cellspacing="1" cellpadding="1" class="table dataTable table-bordered table-striped ">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Internal Name</th>
                    <th>Display Name</th>
                    <th>Zone</th>
                    <th>State</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <tr data-ng-repeat="instance in vmList | filter: networkSearch ">
                    <td>
                        <a class="text-info" ui-sref="cloud.list-instance.view-instance({id: {{ instance.id}}})"  title="View Instance" >{{ instance.name}}</a>
                    </td>
					<td >{{instance.instanceInternalName}} </td>
					<td >{{instance.displayName}} </td>
                    <td >{{instance.zone.name}} </td>
                    <td>
                     <label class="label label-success ng-binding ng-scope" >{{instance.status}}</label><!-- end ngIf: instance.state == 'Running' -->
                    </td>
                   <td>
					<div class="btn-group action-menu">
                           <a class="fa fa-cogs dropdown-toggle" data-toggle="dropdown" ></a>
                                <ul class="dropdown-menu pull-right">
                                     <img src="images/dropdown-arw2.png" border="0" class="vol-dropdown-arw">
											<li has-permission="START_VM"
														data-ng-if = "instance.status != 'ERROR' || instance.status != 'EXPUNGING' || instance.status != 'STARTING' || instance.status != 'STOPPING' || instance.status != 'DESTROYING'  ">
														<a class="icon-button text-center"
														title="<fmt:message key="start" bundle="${msg}" />"
														data-ng-click="startVm('sm',instance)"
														data-ng-hide="instance.status == 'RUNNING'"> <span
															class="fa fa-play m-xs"></span> <fmt:message key="start" bundle="${msg}" />
													</a>
													</li>
													<li has-permission="STOP_VM"
														data-ng-if = "instance.status != 'ERROR' || instance.status != 'EXPUNGING' || instance.status != 'STARTING' || instance.status != 'STOPPING' || instance.status != 'DESTROYING'  ">
														<a class="icon-button text-center"
														data-ng-click="stopVm('sm',instance)"
														title="<fmt:message key="stop" bundle="${msg}" />"
														data-ng-if="instance.status  == 'RUNNING'"> <span
															class="fa fa-ban m-xs"></span> <fmt:message key="stop" bundle="${msg}" />
													</a>
													</li>

													<li has-permission="REBOOT_VM"
														data-ng-if = "instance.status != 'ERROR' || instance.status != 'EXPUNGING' || instance.status != 'STARTING' || instance.status != 'STOPPING' || instance.status != 'DESTROYING'   ">
														<a class="icon-button text-center"
														data-ng-if="instance.status == 'RUNNING'"
														title="<fmt:message key="restart" bundle="${msg}" />"
														data-ng-click="rebootVm('sm',instance)"><span
															class="fa fa-rotate-left m-xs"></span>
															<fmt:message key="restart" bundle="${msg}" />
															</a>
													</li>
													<li has-permission="VIEW_CONSOLE"
														data-ng-if="instance.status == 'RUNNING'">
														<a data-ng-click="showConsole(instance)"
														class="icon-button text-center"
														title="<fmt:message key="view.console" bundle="${msg}" />"><span
															class="fa-desktop fa m-xs"></span>
														<fmt:message key="view.console" bundle="${msg}" />
														</a>
													</li>
                                                </ul>

                                                <button class="btn btn-xs btn-success btn-circle" data-ng-if="instance.status == 'RUNNING'" title="{{ instance.status}}"></button>
	                                            <button class="btn btn-xs btn-danger btn-circle" data-ng-if="instance.status == 'STOPPED'"  title="{{ instance.status}}"></button>
	                                            <button class="btn btn-xs btn-warning btn-circle" data-ng-if="instance.status == 'STARTING'"  title="{{ instance.status}}"></button>
	                                            <button class="btn btn-xs btn-danger btn-circle" data-ng-if="instance.status == 'ERROR'"  title="{{ instance.status}}"></button>
						    					<button class="btn btn-xs btn-warning btn-circle" data-ng-if="instance.status == 'STOPPING'"  title="{{ instance.status}}">&nbsp</button>
	                                            <button class="btn btn-xs btn-danger btn-circle" data-ng-if="instance.status == 'EXPUNGING'"  title="{{ instance.status}}"></button>
	                                            <button class="btn btn-xs btn-danger btn-circle" data-ng-if="instance.status == 'DESTROYED'"  title="{{ instance.status}}"></button>

                          </div>
                    </td>

                </tr>

            </tbody>
        </table>
</div>
    </form>
</div>