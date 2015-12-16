<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="hpanel">
    <div class="row m-l-sm m-r-sm panel-body" ng-controller="instanceViewCtrl">

        <ul class="nav nav-tabs" data-ng-init="templateCategory = 'dashboard'">
            <li class="active"><a href="javascript:void(0)" data-ng-click="templateCategory = 'dashboard'" data-toggle="tab">  <i class="fa fa-laptop"></i> <fmt:message key="dashboard" bundle="${msg}" /></a></li>
            <li data-ng-show ="instance.status == 'Stopped'" class=""><a has-permission="UPGRADE_VM" data-ng-click="templateCategory = 'config'" data-toggle="tab"> <i class="fa fa-cogs"></i> <fmt:message key="configuration" bundle="${msg}" /></a></li>
            <li class=""><a  data-ng-click="templateCategory = 'storage'" data-toggle="tab"><i class="fa fa-database"></i> <fmt:message key="storage" bundle="${msg}" /></a></li>
            <li class=""><a  data-ng-click="templateCategory = 'network'" data-toggle="tab"> <!--<i class="fa fa-sitemap"></i>--><i class="custom-icon custom-icon-network"></i> <fmt:message key="networking" bundle="${msg}" /></a></li>
            <li class=""><a has-permission="MONITOR_VM_PERFORMANCE" data-ng-click="templateCategory = 'monitor'" data-toggle="tab"> <i class="fa fa-desktop"></i> <fmt:message key="monitor" bundle="${msg}" /></a></li>
        </ul>

        <div class="tab-content">
         <div data-ng-show = "showLoaderOffer" style="margin: 20%">
      		<get-loader-image data-ng-show="showLoaderOffer"></get-loader-image>
      	 </div>
            <div data-ng-hide="showLoaderOffer" class="tab-pane" data-ng-class="{'active' : templateCategory == 'dashboard'}" id="step1-dashboard">

                <div  class="row" >

                    <div class="col-lg-9 col-md-8 col-sm-12">
                        <div class="hpanel">
                            <div class="pull-right">
                                <a title="<fmt:message key="common.refresh" bundle="${msg}" />"  class="btn btn-info" ui-sref="cloud.list-instance.view-instance"  ui-sref-opts="{reload: true}" ><span class="fa fa-refresh fa-lg "></span></a>

                            </div>
                            <h4>
								<fmt:message key="common.statistics" bundle="${msg}" />
							</h4>
							<div class="row m-l-md">
								<div class=" col-md-5 col-sm-12 col-lg-5 ">
									<div class="row">
										<hr class="m-t-xs">
										<table cellspacing="1" cellpadding="1" width="300"
											height="200" class="table table-bordered table-striped">
											<tbody>
												<tr>
													<td><label
														class="col-md-7 col-sm-7 col-xs-4 control-label "><fmt:message
																key="total.cpu" bundle="${msg}" /></label></td>
													<td>{{instance.cpuCore}}x{{instance.cpuSpeed}} MHz</td>
												</tr>
												<tr>
													<td><label
														class="col-md-7 col-sm-7 col-xs-4 control-label "><fmt:message
																key="network.read" bundle="${msg}" /></label></td>
													<td>{{instance.networkKbsRead}} KB</td>
												</tr>
												<tr>
													<td><label
														class="col-md-7 col-sm-7 col-xs-4 control-label "><fmt:message
																key="network.write" bundle="${msg}" /></label></td>
													<td>{{instance.networkKbsWrite}} KB</td>
												</tr>
												<tr>
													<td><label
														class="col-md-8 col-sm-7 col-xs-4 control-label "><fmt:message
																key="disk.read.bytes" bundle="${msg}" /></label></td>
													<td data-ng-if="instance.diskKbsRead>1024">{{(instance.diskKbsRead)/1024 | number:2}} MB</td>
													<td data-ng-if="instance.diskKbsRead<1024">{{instance.diskKbsRead}} KB</td>
												</tr>
												<tr>
													<td><label
														class="col-md-8 col-sm-7 col-xs-7 control-label "><fmt:message
																key="disk.write.bytes" bundle="${msg}" /></label></td>
													<td data-ng-if="instance.diskKbsWrite>1024">{{(instance.diskKbsWrite)/1024 | number:2}} MB</td>
													<td data-ng-if="instance.diskKbsWrite<1024">{{instance.diskKbsWrite}} KB</td>
												</tr>
												<tr>
													<td><label
														class="col-md-7 col-sm-7 col-xs-7 control-label "><fmt:message
																key="disk.read.io" bundle="${msg}" /></label></td>
													<td>{{instance.diskIoRead}} </td>

												</tr>
												<tr>
													<td><label
														class="col-md-7 col-sm-7 col-xs-7 control-label "><fmt:message
																key="disk.write.io" bundle="${msg}" /></label></td>
													<td>{{instance.diskIoWrite}} </td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
								<div class=" col-md-5 col-sm-12 col-lg-5 ">
									<div class="row m-l-lg m-t-lg"
										data-ng-repeat="quota in quotaLimitData">
										<label class="col-md-6 col-sm-6 col-xs-6 control-label ">
											<fmt:message key="cpu.utilized" bundle="${msg}" />
										</label>{{instance.cpuUsage}}
										<div class="col-md-4  col-sm-4 col-xs-4 m-t-lg m-r-xxs">
											<canvas donutchart options="quotaChartOptions"
												data="quota.options" width="175" height="175">
                                            </canvas>

										</div>
									</div>
								</div>
							</div>

                        </div>
                    </div>
                    <div class="col-lg-3 col-md-4 col-sm-5">
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-bolt"></i>&nbsp;&nbsp;<fmt:message key="quick.actions" bundle="${msg}" /></h3>
                            </div>
                            <div class="panel-body no-padding">
                                <ul class="list-group">
                                <div data-ng-show="instance.status != 'Error' || instance.status != 'Expunging' || instance.status != 'Starting' || instance.status != 'Stopping' || instance.status != 'Destroying'  ">
                                    <li  class="list-group-item">
                                        <a has-permission="STOP_VM" href="javascript:void(0);" title="<fmt:message key="stop" bundle="${msg}" />" data-ng-click="stopVm('sm',instance)" data-ng-show="instance.status == 'Running'"><span class="fa-ban fa font-bold m-xs"></span> <fmt:message key="stop" bundle="${msg}" /></a>
                                        <a has-permission="START_VM" href="javascript:void(0);" title="<fmt:message key="start" bundle="${msg}" />" data-ng-click="startVm('sm',instance)" data-ng-show="instance.status == 'Stopped'"><span class="fa-play fa font-bold m-xs"></span> <fmt:message key="start" bundle="${msg}" /></a>
                                    </li>
                                    <li has-permission="REBOOT_VM" data-ng-if="instance.status == 'Running'" class="list-group-item">
                                        <a href="javascript:void(0);" data-ng-if="instance.status == 'Running'" title="<fmt:message key="restart" bundle="${msg}" />" data-ng-click="rebootVm('sm',instance)"><span class="fa-rotate-left fa font-bold m-xs"></span> <fmt:message key="reboot" bundle="${msg}" /></a>
                                    </li>
                                    <li has-permission="VIEW_CONSOLE" class="list-group-item" data-ng-if="instance.status == 'Running'">
                                        <a href="javascript:void(0);" title="<fmt:message key="view.console" bundle="${msg}" />" data-ng-click="showConsole(instance)"><span class="fa-desktop fa font-bold m-xs"></span> <fmt:message key="view.console" bundle="${msg}" /></a>
                                    </li>
                                    <li has-permission="RESET_PASSWORD" data-ng-show="instance.passwordEnabled == true && (instance.status == 'Running' || instance.status == 'Stopped')"  class="list-group-item">
                                        <a href="javascript:void(0);" title="<fmt:message key="reset.password" bundle="${msg}" />" data-ng-click="showPassword(instance)"><span class="fa-key fa font-bold m-xs"></span> <fmt:message key="show/reset.password" bundle="${msg}" /></a>
                                    </li>
                                    <li has-permission="REINSTALL_VM" class="list-group-item" data-ng-if="instance.status == 'Running'">
                                        <a href="javascript:void(0);" title="<fmt:message key="reinstall.vm" bundle="${msg}" />" data-ng-click="reInstallVm('md',instance)"><span class="fa fa-history m-xs"></span> <fmt:message key="reinstall.vm" bundle="${msg}" /></a>
                                    </li>
                                    <li has-permission="DESTROY_VM" class="list-group-item" data-ng-show="instance.status == 'Running' || instance.status == 'Stopped' ">
                                        <a href="javascript:void(0);" data-ng-click="reDestroyVm('sm',instance)" title="<fmt:message key="destroy.vm" bundle="${msg}" />"><span class="fa-times-circle fa font-bold m-xs"></span> <fmt:message key="destroy.vm" bundle="${msg}" /></a>
                                    </li>
                                    <li data-ng-if="instance.status == 'Destroyed'" class="list-group-item">
                                        <a href="javascript:void(0);" data-ng-if="instance.status == 'Destroyed'" data-ng-click="recoverVm('sm',instance)" title="<fmt:message key="recover.vm" bundle="${msg}" />"><span class="fa-history fa font-bold m-xs"></span> <fmt:message key="recover.vm" bundle="${msg}" /></a>
                                    </li>
                                    <li has-permission="ATTACH_ISO" data-ng-show="instance.status == 'Running' || instance.status == 'Stopped'" data-ng-if="instance.isoName === null " class="list-group-item">
                                        <a href="javascript:void(0);" title="<fmt:message key="attach.iso" bundle="${msg}" />" data-ng-click="attachISO(instance)"><span class="fa-dot-circle-o fa font-bold m-xs"></span> <fmt:message key="attach.iso" bundle="${msg}" /></a>
                                    </li>
                                    <li data-ng-show="instance.status == 'Running' || instance.status == 'Stopped' "  data-ng-if="instance.isoName !== null " class="list-group-item">
                                        <a href="javascript:void(0);" title="<fmt:message key="detach.iso" bundle="${msg}" />" data-ng-click="detachISO(instance)"><span class="fa-compass fa font-bold m-xs"></span> <fmt:message key="detach.iso" bundle="${msg}" /></a>
                                    </li>
                                    <li has-permission="TAKE_VM_SNAPSHOT" data-ng-show="instance.status == 'Running' || instance.status == 'Stopped'" class="list-group-item">
                                        <a href="javascript:void(0);" title="<fmt:message key="vm.snapshot" bundle="${msg}" />" data-ng-click="takeSnapshot(instance)"><span class="fa-camera fa font-bold m-xs"></span> <fmt:message key="take.vm.snapshot" bundle="${msg}" /></a>
                                    </li>
                                    <li has-permission="MIGRATE_HOST" data-ng-if="instance.status == 'Running'" class="list-group-item">
                                        <a href="javascript:void(0);" title="<fmt:message key="migrate.instance.to.another.host" bundle="${msg}" />" data-ng-click="hostMigrate(instance)"><span class="fa-arrows fa font-bold m-xs"></span> <fmt:message key="migrate.instance.to.another.host" bundle="${msg}" /></a>
                                    </li>
                                    </div>
                                    <li class="list-group-item">
                                        <!--<a href="#" title="Edit Note">  <span class="fa-edit fa font-bold m-xs"></span> Edit Note</a>-->
                                        <a  title="<fmt:message key="edit.note" bundle="${msg}" />" data-ng-click="showDescription(instance)"><span class="fa-edit fa font-bold m-xs"></span><fmt:message key="edit.note" bundle="${msg}" /></a>

                                    </li>

                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-12 col-md-12 col-sm-7">
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-cloud"></i>&nbsp;&nbsp;<fmt:message key="instance.summary" bundle="${msg}" /></h3>
                            </div>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <table class="table table-condensed table-striped" cellspacing="1" cellpadding="1">
                                            <tbody>
                                                <tr>
                                                    <td class="col-md-4 col-sm-4"><b><fmt:message key="common.zone" bundle="${msg}" /></b></td>
                                                    <td class="col-md-8 col-sm-8">{{ instance.zone.name}}</td>
                                                </tr>
                                                <tr>
                                                    <td><b><fmt:message key="display.name" bundle="${msg}" /></b></td>
                                                    <td>
                                                    	<span data-ng-if="!instnaceEdit">{{instance.transDisplayName}}</span>
														<div data-ng-if="instnaceEdit && instance.status == 'Stopped'" class="form-group"
															ng-class="{'text-danger': instance.transDisplayName == '' && formSubmitted}">
															<input type="text" name="transDisplayName"
																data-ng-model="instance.transDisplayName"
																class="form-control editedinput "
																data-ng-class="{'error': instance.transDisplayName == '' && formSubmitted}">
														</div>
														<a data-ng-if="!instnaceEdit && instance.status == 'Stopped'" data-ng-click="editDisplayName(instance)"  class="fa fa-edit m-l-lg"> <fmt:message key="common.edit" bundle="${msg}" /></a>
														<a data-ng-if="instnaceEdit" data-ng-click="updateDisplayName(instance)"  class="btn btn-sm btn-info pull-right"> <fmt:message key="common.update" bundle="${msg}" /></a>
                                                     </td>
                                                </tr>
                                                <tr>
                                                    <td><b><fmt:message key="common.status" bundle="${msg}" /></b></td>
                                                    <td><b class="text-uppercase" data-ng-class="instance.status == 'Stopped' ? 'text-danger' : 'text-success' ">{{ instance.status}} </b></td>
                                                </tr>
                                                <tr>
                                                    <td><b><fmt:message key="offer" bundle="${msg}" /></b></td>
                                                    <td>{{ instance.computeOffering.name}} <a data-ng-show = "instance.status == 'Stopped'" data-ng-click="templateCategory = 'config'"  class="fa fa-edit m-l-lg"> <fmt:message key="common.edit" bundle="${msg}" /></a></td>
                                                </tr>
                                                <tr>
                                                    <td><b><fmt:message key="disk.size" bundle="${msg}" /></b></td>
                                                    <td>{{volume[0].diskSize / global.Math.pow(2, 30)}} GB</td>
                                                </tr>
                                                <tr>
                                                    <td><b><fmt:message key="common.ip" bundle="${msg}" /></b></td>
                                                    <td>{{ instance.ipAddress}} | {{instance.network.networkType}} </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="col-md-6">
                                        <table class="table table-condensed table-striped" cellspacing="1" cellpadding="1">
                                            <tbody>
                                                <tr>
                                                    <td class="col-md-4 col-sm-4"><b><fmt:message key="created.on" bundle="${msg}" /></b></td>
                                                    <td class="col-md-8 col-sm-8">{{ instance.createdDateTime *1000 | date:'yyyy-MM-dd HH:mm:ss'}}</td>
                                                </tr>
                                                <tr>
                                                    <td><b><fmt:message key="instance.id" bundle="${msg}" /></b></td>
                                                    <td>VM-{{ instance.uuid}}</td>
                                                </tr>
                                                <tr>
                                                    <td><b><fmt:message key="memory" bundle="${msg}" /></b></td>
                                                    <td>{{ instance.computeOffering.memory }}</td>
                                                </tr>
                                                <tr>
                                                    <td><b><fmt:message key="cpu.cores" bundle="${msg}" /></b></td>
                                                    <td>{{ instance.computeOffering.numberOfCores }}</td>
                                                </tr>
                                                 <tr>
                                                    <td><b><fmt:message key="common.host" bundle="${msg}" /></b></td>
                                                    <td>{{ instance.host.name }}</td>
                                                </tr>
                                                <tr>
                                                    <td><b><fmt:message key="common.account" bundle="${msg}" /></b></td>
                                                    <td>{{ instance.instanceOwner.userName}}</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


            </div>
            <div class="tab-pane"  data-ng-class="{'active' : templateCategory == 'config'}" id="step1-config">
                <div data-ng-include src="'app/views/cloud/instance/configuration.jsp'"></div>
            </div>
            <div class="tab-pane"  data-ng-class="{'active' : templateCategory == 'storage'}" id="step1-storage">
                <div data-ng-include src="'app/views/cloud/instance/storage.jsp'"></div>
            </div>
            <div class="tab-pane"  data-ng-class="{'active' : templateCategory == 'network'}" id="step1-network">
                <div data-ng-include src="'app/views/cloud/instance/network-config.jsp'"></div>
            </div>
            <div class="tab-pane"  data-ng-class="{'active' : templateCategory == 'monitor'}" id="step1-monitor">
                <div data-ng-include src="'app/views/cloud/instance/monitor.jsp'"></div>
            </div>
        </div>


    </div>
</div>
