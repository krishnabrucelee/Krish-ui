<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div class="hpanel">
    <div class="row m-l-sm m-r-sm panel-body" ng-controller="instanceViewCtrl">
        <ul class="nav nav-tabs" data-ng-init="templateCategory = 'dashboard'">
            <li data-ng-class="{'active' : templateCategory == 'dashboard'}"><a href="javascript:void(0)" data-ng-click="viewInstances('0');" data-toggle="tab">  <i class="fa fa-laptop"></i> <fmt:message key="common.summary" bundle="${msg}" /></a></li>
            <li data-ng-class="{'active' : templateCategory == 'config'}"><a has-permission="RESIZE" data-ng-click="selectab()"  data-toggle="tab"> <i class="fa fa-cogs"></i> <fmt:message key="configuration" bundle="${msg}" /></a></li>
            <li class=""><a  data-ng-click="list();" data-toggle="tab"><i class="fa fa-database"></i> <fmt:message key="storage" bundle="${msg}" /></a></li>
            <li class=""><a  data-ng-click="networkTab()" data-toggle="tab"> <!--<i class="fa fa-sitemap"></i>--><i class="custom-icon custom-icon-network"></i> <fmt:message key="networking" bundle="${msg}" /></a></li>
            <li class=""><a has-permission="MONITOR_VM_PERFORMANCE" href="javascript:void(0)" data-ng-class="{'active': templateCategory == 'monitor'}" data-ng-click="templateCategory = 'monitor'" data-toggle="tab"> <i class="fa fa-desktop"></i> <fmt:message key="monitor" bundle="${msg}" /></a></li>

            <div class="pull-right">
            	<button type="button" data-ng-hide="templateCategory == 'monitor' || templateCategory == 'monitor-windows'" title="<fmt:message key="common.refresh" bundle="${msg}" />"  class="btn btn-info" ui-sref="cloud.list-instance.view-instance"  ui-sref-opts="{reload: true}" ><span class="fa fa-refresh fa-lg "></span></button>
            </div>
        </ul>

        <div class="tab-content">
            <div data-ng-if = "showLoaderOffer" style="margin: 20%">
                <get-loader-image data-ng-if="showLoaderOffer"></get-loader-image>
            </div>
            <div data-ng-if="!showLoaderOffer" class="tab-pane" data-ng-class="{'active' : templateCategory == 'dashboard'}" id="step1-dashboard">
                <div data-ng-if="global.webSocketLoaders.viewLoader" class="overlay-wrapper">
           <get-show-loader-image data-ng-show="global.webSocketLoaders.viewLoader"></get-show-loader-image>

            </div>
                <div  class="row" >
                    <div class="col-lg-9 col-md-8 col-sm-12">
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-cloud"></i>&nbsp;&nbsp;<fmt:message key="instance.summary" bundle="${msg}" /></h3>
                            </div>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <table class="table table-condensed table-striped" cellspacing="1" cellpadding="1">
                                            <tbody>
                                            <h4 class="text-info"><fmt:message key="basic.info" bundle="${msg}" /></h4>
                                            <tr>
                                                <td class="col-md-6 col-sm-6">
                                                    <b>
                                                        <fmt:message key="instance.name" bundle="${msg}" />
                                                    </b>
                                                </td>
                                                <td class="col-md-6 col-sm-6">{{ instance.name}}</td>
                                            </tr>
                                            <tr>
                                            <td class="col-md-6 col-sm-6">
                                                <b>
                                                    <fmt:message key="instance.display.name" bundle="${msg}" />
                                                </b>
                                            </td>
                                            <td class="col-md-6 col-sm-6">
                                                <span data-ng-if="!instnaceEdit">{{instance.displayName}}</span>
                                                <div data-ng-if="instnaceEdit && instance.status == 'STOPPED'" class="form-group"
                                                     ng-class="{'text-danger': instance.transDisplayName == '' && formSubmitted}">
                                                    <input type="text" name="transDisplayName"
                                                           data-ng-model="instance.displayName"
                                                           class="form-control editedinput "
                                                           data-ng-class="{'error': instance.displayName == '' && formSubmitted}">
                                                </div>
                                                <a data-ng-if="!instnaceEdit && instance.status == 'STOPPED'" data-ng-click="editDisplayName(instance)"  class="fa fa-edit m-l-lg">
                                                    <fmt:message key="common.edit" bundle="${msg}" />
                                                </a>
                                                <a data-ng-if="instnaceEdit" data-ng-click="updateDisplayName(instance)"  class="btn btn-sm btn-info pull-right">
                                                    <fmt:message key="common.update" bundle="${msg}" />
                                                </a>
                                            </td>
                                            </tr>
                                            <tr>
                                                <td class="col-md-6 col-sm-6">
                                                    <b>
                                                        <fmt:message key="instance.internal.name" bundle="${msg}" />
                                                    </b>
                                                </td>
                                                <td class="col-md-6 col-sm-6">{{ instance.instanceInternalName}}</td>
                                            </tr>
                                            <tr>
                                                <td class="col-md-6 col-sm-6">
                                                    <b>
                                                        <fmt:message key="instance.id" bundle="${msg}" />
                                                    </b>
                                                </td>
                                                <td class="col-md-6 col-sm-6">VM-{{ instance.uuid}}</td>
                                            </tr>
                                            <tr>
                                                <td class="col-md-6 col-sm-6">
                                                    <b>
                                                        <fmt:message key="common.status" bundle="${msg}" />
                                                    </b>
                                                </td>
                                                <td class="col-md-6 col-sm-6"> <b class="text-uppercase text-success" data-ng-if="instance.status == 'RUNNING'" title="{{ instance.status}}">{{ instance.status}}</b>
                                                    <b class="text-uppercase text-warning" data-ng-if="instance.status == 'STARTING'" title="{{ instance.status}}">{{ instance.status}}</b>
                                                    <b class="text-uppercase text-danger" data-ng-if="instance.status == 'ERROR'" title="{{ instance.status}}">{{ instance.status}}</b>
                                                    <b class=" text-uppercase text-danger" data-ng-if="instance.status == 'STOPPING'" title="{{ instance.status}}">{{ instance.status}}</b>
                                                    <b class=" text-uppercase text-danger" data-ng-if="instance.status == 'STOPPED'" title="{{ instance.status}}">{{ instance.status}}</b>
                                                    <b class=" text-uppercase text-danger" data-ng-if="instance.status == 'EXPUNGING'" title="{{ instance.status}}">{{ instance.status}}</b>
                                                    <b class=" text-uppercase text-danger" data-ng-if="instance.status == 'DESTROYED'" title="{{ instance.status}}">{{ instance.status}}</b>
                                                    <b class=" text-uppercase text-warning" data-ng-if="instance.status == 'MIGRATING'" title="{{ instance.status}}">{{ instance.status}}</b>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="col-md-6 col-sm-6">
                                                    <b>
                                                        <fmt:message key="common.zone" bundle="${msg}" />
                                                    </b>
                                                </td>
                                                <td class="col-md-6 col-sm-6">{{ instance.zone.name}}</td>
                                            </tr>
                                            <tr>
                                                <td class="col-md-6 col-sm-6">
                                                    <b>
                                                        <fmt:message key="common.host" bundle="${msg}" />
                                                    </b>
                                                </td>
                                                <td class="col-md-6 col-sm-6">{{ instance.host.name}}</td>
                                            </tr>
                                            <tr>
                                                <td class="col-md-6 col-sm-6">
                                                    <b>
                                                        <fmt:message key="created.on" bundle="${msg}" />
                                                    </b>
                                                </td>
                                                <td class="col-md-6 col-sm-6">{{ instance.createdDateTime * 1000 | date:'yyyy-MM-dd HH:mm:ss'}}</td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="col-md-6">
                                        <table class="table table-condensed table-striped" cellspacing="1" cellpadding="1">
                                            <tbody>
                                            <h4 class="text-info"><fmt:message key="ownership" bundle="${msg}" /></h4>
                                            <tr>
                                                <td class="col-md-6 col-sm-6">
                                                    <b>
                                                        <fmt:message key="instance.owner" bundle="${msg}" />
                                                    </b>
                                                </td>
                                                <td class="col-md-6 col-sm-6">{{instance.instanceOwner.userName}}</td>
                                            </tr>
                                             <tr>
                                                <td class="col-md-6 col-sm-6">
                                                    <b>
                                                        <fmt:message key="common.application" bundle="${msg}" />
                                                    </b>
                                                </td>
                                                <td class="col-md-6 col-sm-6">
                                                    <div data-ng-repeat="application in instance.applicationList"> <span data-ng-if="application.type !== ''">{{application.type}}</span> </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="col-md-6 col-sm-6">
                                                    <b>
                                                        <fmt:message key="common.project" bundle="${msg}" />
                                                    </b>
                                                </td>
                                                <td class="col-md-6 col-sm-6">{{instance.project.name}}</td>
                                            </tr>
                                             <tr>
                                                <td class="col-md-6 col-sm-6">
                                                    <b>
                                                        <fmt:message key="common.department" bundle="${msg}" />
                                                    </b>
                                                </td>
                                                <td class="col-md-6 col-sm-6"><span data-ng-if="instance.project != null">{{instance.project.department.userName}} </span> <span data-ng-if="instance.project == null">{{ instance.department.userName}}</span></td>
                                            </tr>
                                            <tr>
                                                <td class="col-md-6 col-sm-6" >
                                                    <b>
                                                        <fmt:message key="common.company" bundle="${msg}" />
                                                    </b>
                                                </td>
                                                <td class="col-md-6 col-sm-6">{{instance.domain.name}}</td>
                                            </tr>
                                            </tbody>
                                        </table>
                                        <table class="table table-condensed table-striped" cellspacing="1" cellpadding="1">
                                            <tbody>
                                            <h4 class="text-info"><fmt:message key="service.cost" bundle="${msg}" /></h4>
                                            <tr>
                                                <td class="col-md-6 col-sm-6">
                                                    <b>
                                                        <fmt:message key="subscription.cost" bundle="${msg}" />
                                                    </b>
                                                </td>
                                                <td class="col-md-6 col-sm-6"><span class="text-danger"
														data-ng-if="!instance.computeOffering.customized"
													> <app-currency></app-currency> {{(instance.computeOffering.computeCost[0].instanceRunningCostMemory
														    + instance.computeOffering.computeCost[0].instanceRunningCostVcpu) | number:4 }}
													</span> <span class="text-danger" data-ng-if="instance.computeOffering.customized"> <app-currency></app-currency>
															{{((instance.computeOffering.computeCost[0].instanceRunningCostPerMB > 0 ? (instance.memory * instance.computeOffering.computeCost[0].instanceRunningCostPerMB) : 0)
														    + (instance.computeOffering.computeCost[0].instanceRunningCostPerVcpu > 0 ? (instance.cpuCore * instance.computeOffering.computeCost[0].instanceRunningCostPerVcpu) : 0)
														    + (instance.computeOffering.computeCost[0].instanceRunningCostPerMhz > 0 ? (instance.cpuSpeed * instance.computeOffering.computeCost[0].instanceRunningCostPerMhz) : 0)) | number:4 }}
													</span> /
                                            <fmt:message key="common.day" bundle="${msg}" />
                                            </td>
                                            </tr>
                                            <tr>
                                                <td class="col-md-6 col-sm-6">
                                                    <b>
                                                        <fmt:message key="common.package" bundle="${msg}" />
                                                    </b>
                                                </td>
                                                <td class="col-md-6 col-sm-6">{{instance.computeOffering.name}}</td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>

                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <table class="table table-condensed table-striped" cellspacing="1" cellpadding="1">
                                            <tbody>
                                                <tr>
                                            <h4 class="text-info"><fmt:message key="tech.specification" bundle="${msg}" /></h4>
                                            <td class="col-md-6 col-sm-6">
                                                <b>
                                                    <fmt:message key="common.hypervisor" bundle="${msg}" />
                                                </b>
                                            </td>
                                            <td class="col-md-6 col-sm-6">{{instance.hypervisor.name}}</td>
                                            </tr>
                                            <tr>
                                                <td class="col-md-6 col-sm-6">
                                                    <b>
                                                        <fmt:message key="common.templates" bundle="${msg}" />
                                                    </b>
                                                </td>
                                                <td>{{instance.templateName}}</td>
                                            </tr>
                                            <tr>
                                                <td class="col-md-6 col-sm-6">
                                                    <b>
                                                        <fmt:message key="offer" bundle="${msg}" />
                                                    </b>
                                                </td>
                                                <td class="col-md-6 col-sm-6">
                                                    {{ instance.computeOffering.name}}
                                                    <a has-permission="RESIZE" data-ng-click="selectab()">
                                                       <i class="fa fa-edit m-l-lg"></i> <fmt:message key="common.resize" bundle="${msg}" />
                                                    </a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="col-md-6 col-sm-6">
                                                    <b>
                                                        <fmt:message key="common.osType" bundle="${msg}" />
                                                    </b>
                                                </td>
                                                <td class="col-md-6 col-sm-6">{{instance.osType}}</td>
                                            </tr>
                                            <tr>
                                                <td class="col-md-6 col-sm-6">
                                                    <b>
                                                        <fmt:message key="cpu.cores" bundle="${msg}" />
                                                    </b>
                                                </td>
                                                 <td class="col-md-6 col-sm-6">{{ instance.cpuCore}}</td>
                                            </tr>
                                            <tr>
                                                <td class="col-md-6 col-sm-6">
                                                    <b>
                                                        <fmt:message key="ram" bundle="${msg}" />
                                                    </b>
                                                </td>
                                                <td class="col-md-6 col-sm-6">{{ instance.memory}}</td>
                                            </tr>
                                            <tr>
                                                <td class="col-md-6 col-sm-6">
                                                    <b>
                                                        <fmt:message key="common.storage" bundle="${msg}" />
                                                    </b>
                                                </td>
                                                <td class="col-md-6 col-sm-6"><span data-ng-if="instance.volumeSize > 0">{{ instance.volumeSize / global.Math.pow(2, 30)}} GB</span><span data-ng-if="!(instance.volumeSize > 0)">-No Disk-</span></td>
                                            </tr>
                                            <tr data-ng-if="instance.publicIpAddress">
                                                <td class="col-md-6 col-sm-6">
                                                    <b>
                                                        <fmt:message key="public.ip" bundle="${msg}" />
                                                    </b>
                                                </td>
                                                <td class="col-md-6 col-sm-6">{{ instance.publicIpAddress}} </td>
                                            </tr>
                                            <tr>
                                                <td class="col-md-6 col-sm-6">
                                                    <b>
                                                        <fmt:message key="common.ip" bundle="${msg}" />
                                                    </b>
                                                </td>
                                                <td class="col-md-6 col-sm-6">{{ instance.ipAddress}} | {{instance.network.networkType}} </td>
                                            </tr>
                                            <tr>
                                                <td class="col-md-6 col-sm-6">
                                                    <b>
                                                        <fmt:message key="high.availability" bundle="${msg}" />
                                                    </b>
                                                </td>
                                                <td class="col-md-6 col-sm-6">{{instance.computeOffering.isHighAvailabilityEnabled}} </td>
                                            </tr>
                                            <tr>
                                                <td class="col-md-6 col-sm-6">
                                                    <b>
                                                        <fmt:message key="dynamic.scalable" bundle="${msg}" />
                                                    </b>
                                                </td>
                                                <td class="col-md-6 col-sm-6">{{instance.template.dynamicallyScalable}}</td>
                                            </tr>
                                            <tr>
                                                <td class="col-md-6 col-sm-6">
                                                    <b>
                                                        <fmt:message key="ssh.key.pair" bundle="${msg}" />
                                                    </b>
                                                </td>
                                                <td class="col-md-6 col-sm-6">{{instance.keypair.name}}
                                                <a data-ng-click="selectab()" >
                                                       <i class="fa fa-exchange m-l-lg"></i> <fmt:message key="common.change" bundle="${msg}" />
                                                    </a>
                                                 </td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="col-md-6">
                                        <table class="table table-condensed table-striped" cellspacing="1" cellpadding="1">
                                            <tbody>
                                            <h4 class="text-info"><fmt:message key="common.statistics" bundle="${msg}" /></h4>
                                            <tr>
                                                <td class="col-md-6 col-sm-6">
                                                    <b>
                                                        <fmt:message key="total.cpu" bundle="${msg}" />
                                                    </b>
                                                </td>
                                                    <td class="col-md-6 col-sm-6" data-ng-if="instance.cpuSpeed >= 1000">{{instance.cpuCore}}x{{(instance.cpuSpeed)/1000 | number:2}} <fmt:message key="common.ghz" bundle="${msg}" /></td>
                                                    <td class="col-md-6 col-sm-6" data-ng-if="instance.cpuSpeed < 1000">{{instance.cpuCore}}x{{instance.cpuSpeed}} <fmt:message key="common.mhz" bundle="${msg}" /></td>
                                            </tr>
                                             <tr>
                                                <td class="col-md-6 col-sm-6">
                                                    <b>
                                                        <fmt:message key="network.read" bundle="${msg}" />
                                                    </b>
                                                </td>
                                                <td class="col-md-6 col-sm-6" data-ng-if="instance.networkKbsRead > 1024 * 1024">{{((instance.networkKbsRead) / 1024) / 1024 | number:2}} <fmt:message key="common.gb" bundle="${msg}" /></td>
                                                <td class="col-md-6 col-sm-6" data-ng-if="instance.networkKbsRead > 1024 && instance.networkKbsRead < 1024 * 1024">{{(instance.networkKbsRead)/1024 | number:2}} <fmt:message key="common.mb" bundle="${msg}" /></td>
                                                <td class="col-md-6 col-sm-6" data-ng-if="instance.networkKbsRead < 1024">{{instance.networkKbsRead| number:2}} <fmt:message key="common.kb" bundle="${msg}" /></td>
                                            </tr>
                                            <tr>
                                                <td class="col-md-6 col-sm-6">
                                                    <b>
                                                        <fmt:message key="network.write" bundle="${msg}" />
                                                    </b>
                                                </td>
                                                <td class="col-md-6 col-sm-6" data-ng-if="instance.networkKbsWrite > 1024 * 1024">{{((instance.networkKbsWrite) / 1024) / 1024 | number:2}} <fmt:message key="common.gb" bundle="${msg}" /></td>
                                                <td class="col-md-6 col-sm-6" data-ng-if="instance.networkKbsWrite > 1024 && instance.networkKbsWrite < 1024 * 1024">{{(instance.networkKbsWrite)/1024 | number:2}} <fmt:message key="common.mb" bundle="${msg}" /></td>
                                                <td class="col-md-6 col-sm-6" data-ng-if="instance.networkKbsWrite < 1024">{{instance.networkKbsWrite| number:2}} <fmt:message key="common.kb" bundle="${msg}" /></td>
                                            </tr>
                                            <tr>
                                                <td class="col-md-6 col-sm-6">
                                                    <b>
                                                        <fmt:message key="disk.read.bytes" bundle="${msg}" />
                                                    </b>
                                                </td>
                                                <td class="col-md-6 col-sm-6" data-ng-if="instance.diskKbsRead > 1024 * 1024">{{((instance.diskKbsRead) / 1024) / 1024 | number:2}} <fmt:message key="common.gb" bundle="${msg}" /></td>
                                                <td class="col-md-6 col-sm-6" data-ng-if="instance.diskKbsRead > 1024 && instance.diskKbsRead < 1024 * 1024">{{(instance.diskKbsRead)/1024 | number:2}} <fmt:message key="common.mb" bundle="${msg}" /></td>
                                                <td class="col-md-6 col-sm-6" data-ng-if="instance.diskKbsRead < 1024">{{instance.diskKbsRead| number:2}} <fmt:message key="common.kb" bundle="${msg}" /></td>
                                            </tr>
                                            <tr>
                                                <td class="col-md-6 col-sm-6">
                                                    <b>
                                                        <fmt:message key="disk.write.bytes" bundle="${msg}" />
                                                    </b>
                                                </td>
                                                <td class="col-md-6 col-sm-6" data-ng-if="instance.diskKbsWrite > 1024 * 1024">{{((instance.diskKbsWrite) / 1024) / 1024 | number:2}} <fmt:message key="common.gb" bundle="${msg}" /></td>
                                                <td class="col-md-6 col-sm-6" data-ng-if="instance.diskKbsWrite > 1024 && instance.diskKbsWrite < 1024 * 1024">{{(instance.diskKbsWrite)/1024 | number:2}} <fmt:message key="common.mb" bundle="${msg}" /></td>
                                                <td class="col-md-6 col-sm-6" data-ng-if="instance.diskKbsWrite < 1024">{{instance.diskKbsWrite| number:2}} <fmt:message key="common.kb" bundle="${msg}" /></td>
                                            </tr>
                                            <tr>
                                                <td class="col-md-6 col-sm-6">
                                                    <b>
                                                        <fmt:message key="disk.read.io" bundle="${msg}" />
                                                    </b>
                                                </td>
                                                <td class="col-md-6 col-sm-6">{{instance.diskIoRead}} </td>
                                            </tr>
                                             <tr>
                                                <td class="col-md-6 col-sm-6">
                                                    <b>
                                                        <fmt:message key="disk.write.io" bundle="${msg}" />
                                                    </b>
                                                </td>
                                                <td class="col-md-6 col-sm-6">{{instance.diskIoWrite}} </td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-4 col-sm-5">
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-bolt"></i>&nbsp;&nbsp;<fmt:message key="online.actions" bundle="${msg}" /></h3>
                            </div>
                            <div class="panel-body no-padding">
                                <ul class="list-group">
                                    <div data-ng-if="instance.status != 'ERROR' || instance.status != 'EXPUNGING' || instance.status != 'STARTING' || instance.status != 'STOPPING' || instance.status != 'DESTROYING'">

                                        <li has-permission="VIEW_CONSOLE" class="list-group-item" data-ng-if="instance.status == 'RUNNING'">
                                            <a href="javascript:void(0);" title="<fmt:message key="view.console" bundle="${msg}" />" data-ng-click="showConsole(instance)"><span class="fa-desktop fa font-bold m-xs"></span> <fmt:message key="view.console" bundle="${msg}" /></a>
                                        </li>
                                        <li has-permission="ATTACH_ISO" class="list-group-item">
                                            <button ng-class = "(instance.status == 'RUNNING' || instance.status == 'STOPPED') && !instance.isoName ? 'resizelink enable '  : 'resizelink disable icon-disable'" data-ng-disabled=" (instance.status == 'RUNNING' || instance.status == 'STOPPED') && instance.isoName " href="javascript:void(0);" title="<fmt:message key="attach.iso" bundle="${msg}" />" data-ng-click="attachISO(instance)"><span class="m-xs"><img src="images/attach.png" class="img-icon"  border="0"/></span> <fmt:message key="attach.iso" bundle="${msg}" /></button>
                                        </li>
                                        <li has-permission="ATTACH_ISO" class="list-group-item" >
                                            <button ng-class = "(instance.status == 'RUNNING' || instance.status == 'STOPPED') && instance.isoName ? 'resizelink enable ' : 'resizelink disable icon-disable'" data-ng-disabled = "(instance.status == 'RUNNING' || instance.status == 'STOPPED') && !instance.isoName" href="javascript:void(0);" title="<fmt:message key="detach.iso" bundle="${msg}" />" data-ng-click="detachISO(instance)"><span class="m-xs"><img src="images/detach.png"  class="img-icon" border="0"/></span> <fmt:message key="detach.iso" bundle="${msg}" /></button>
                                            <span class="iso-name m-l-lg m-t-xxs">{{instance.isoName}}</span>

                                        </li>
                                        <li has-permission="TAKE_VM_SNAPSHOT" data-ng-if="instance.status == 'RUNNING' || instance.status == 'STOPPED'" class="list-group-item">
                                            <a href="javascript:void(0);" title="<fmt:message key="vm.snapshot" bundle="${msg}" />" data-ng-click="takeSnapshot(instance)"><span class="fa-camera fa font-bold m-xs"></span> <fmt:message key="take.vm.snapshot" bundle="${msg}" /></a>
                                        </li>
                                        <li has-permission="MIGRATE_HOST" class="list-group-item">
                                            <button ng-class = "(instance.status == 'RUNNING' && global.sessionValues.type === 'ROOT_ADMIN') ? 'resizelink enable' : 'resizelink disable'" data-ng-disabled = "(instance.status !== 'RUNNING' || global.sessionValues.type !== 'ROOT_ADMIN')" href="javascript:void(0);" title="<fmt:message key="migrate.to.another.host" bundle="${msg}" />" data-ng-click="hostMigrate(instance)"><span class="fa-arrows fa font-bold m-xs pull-left"></span> <span class="pull-left m-l-xs"><fmt:message key="migrate.to.another.host" bundle="${msg}" /></span><div class="clearfix"></div></button>
                                        </li>
                                        <li class="list-group-item">
                                            <button ng-class = "(instance.status == 'STOPPED' && global.sessionValues.type !== 'USER') ? 'resizelink enable' : 'resizelink disable'" data-ng-disabled = "(instance.status !== 'STOPPED' || global.sessionValues.type === 'USER')" href="javascript:void(0);" title="<fmt:message key="vm.ownership.migration" bundle="${msg}" />" data-ng-click="vmMigrate(instance)"><span class="pe-7s-add-user pe-lg font-bold m-xs pull-left"></span> <span class="pull-left m-l-xs"><fmt:message key="vm.ownership.migration" bundle="${msg}" /></span><div class="clearfix"></div></button>
                                        </li>
                                        <li has-permission="HOST_INFORMATION" data-ng-if="instance.status == 'RUNNING'" class="list-group-item">
                                            <a href="javascript:void(0);" title="<fmt:message key="host.information" bundle="${msg}" />" data-ng-click="hostInformation(instance)" ><span class="fa-server fa m-xs"></span> <fmt:message key="host.information" bundle="${msg}" /></a>
                                        </li>
                                         <li data-ng-if="instance.status == 'RUNNING' || instance.status == 'STOPPED' " class="list-group-item">
                                            <button data-ng-class = "(instance.passwordEnabled == true  && instance.vncPassword !== null) ? 'resizelink enable' : 'resizelink disable'" data-ng-disabled="(instance.vncPassword == null || !instance.passwordEnabled) && (instance.status == 'RUNNING' || instance.status == 'STOPPED')" href="javascript:void(0);" title="<fmt:message key="show.password" bundle="${msg}" />" data-ng-click="showPassword(instance)"><span class="fa-key fa font-bold m-xs"></span> <fmt:message key="show.password" bundle="${msg}" /></button>
                                        </li>
                                    </div>
                                    <li class="list-group-item">
                                        <!--<a href="#" title="Edit Note">  <span class="fa-edit fa font-bold m-xs"></span> Edit Note</a>-->
                                        <a  title="<fmt:message key="edit.note" bundle="${msg}" />" data-ng-click="showDescription(instance)"><span class="fa-edit fa font-bold m-xs"></span><fmt:message key="edit.note" bundle="${msg}" /></a>
                                    </li>

                                </ul>
                            </div>
                        </div>

                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-bolt"></i>&nbsp;&nbsp;<fmt:message key="disruptive.actions" bundle="${msg}" /></h3>
                            </div>
                            <div class="panel-body no-padding">
                                <ul class="list-group" >
                                    <div data-ng-if="instance.status != 'ERROR' || instance.status != 'EXPUNGING' || instance.status != 'STARTING' || instance.status != 'STOPPING' || instance.status != 'DESTROYING'">
                                        <li  class="list-group-item">
                                            <a has-permission="STOP_VM" href="javascript:void(0);" title="<fmt:message key="stop" bundle="${msg}" />" data-ng-click="stopVm('sm',instance)" data-ng-if="instance.status == 'RUNNING'"><span class="fa-ban fa font-bold m-xs"></span> <fmt:message key="stop" bundle="${msg}" /></a>
                                            <a has-permission="START_VM" href="javascript:void(0);" title="<fmt:message key="start" bundle="${msg}" />" data-ng-click="startVm('sm',instance)" data-ng-if="instance.status == 'STOPPED'"><span class="fa-play fa font-bold m-xs"></span> <fmt:message key="start" bundle="${msg}" /></a>
                                        </li>
                                        <li has-permission="REBOOT_VM" data-ng-if="instance.status == 'RUNNING'" class="list-group-item">
                                            <a href="javascript:void(0);" data-ng-if="instance.status == 'RUNNING'" title="<fmt:message key="restart" bundle="${msg}" />" data-ng-click="rebootVm('sm',instance)"><span class="fa-rotate-left fa font-bold m-xs"></span> <fmt:message key="reboot" bundle="${msg}" /></a>
                                        </li>
                                        <li has-permission="REINSTALL_VM" class="list-group-item" data-ng-if="instance.status == 'RUNNING'">
                                            <a href="javascript:void(0);" title="<fmt:message key="reinstall.vm" bundle="${msg}" />" data-ng-click="reInstallVm('md',instance)"><span class="fa fa-history m-xs"></span> <fmt:message key="reinstall.vm" bundle="${msg}" /></a>
                                        </li>
                                        <li has-permission="DESTROY_VM" class="list-group-item" data-ng-if="instance.status == 'RUNNING' || instance.status == 'STOPPED' || instance.status == 'ERROR' || instance.status == 'DESTROYED'">
                                            <a href="javascript:void(0);" id="view_instance_destroy_vm" data-ng-click="reDestroyVm('sm', instance)" title="<fmt:message key="destroy.vm" bundle="${msg}" />"><span class="fa-times-circle fa font-bold m-xs"></span> <fmt:message key="destroy.vm" bundle="${msg}" /></a>
                                        </li>
                                        <li data-ng-if="instance.status == 'DESTROYED'" class="list-group-item ">
                                            <a href="javascript:void(0);" data-ng-if="instance.status == 'DESTROYED'" data-ng-click="recoverVm('sm', instance)" title="<fmt:message key="recover.vm" bundle="${msg}" />"><span class="fa-history fa font-bold m-xs"></span> <fmt:message key="recover.vm" bundle="${msg}" /></a>
                                        </li>
                                        <li has-permission = "RESIZE" class="list-group-item " >
                                            <button ng-class = "(instance.status == 'STOPPED') ? 'resizelink enable' : 'resizelink disable'" data-ng-disabled="instance.status !== 'STOPPED'" href="javascript:void(0);"   data-ng-click="selectab()" title="<fmt:message key="resize.vm" bundle="${msg}" />"><span class="fa fa-expand m-xs"></span> <fmt:message key="resize.vm" bundle="${msg}" /></button>
                                        </li>
                                        <li has-permission="RESET_PASSWORD" class="list-group-item">
                                            <button ng-class = "(instance.passwordEnabled == true && instance.status == 'STOPPED') ? 'resizelink enable' : 'resizelink disable'" data-ng-disabled="instance.passwordEnabled == false || instance.status !== 'STOPPED'" href="javascript:void(0);" title="<fmt:message key="reset.password" bundle="${msg}" />" data-ng-click="resetPassword('sm',instance)"><span class="fa-key fa font-bold m-xs"></span> <fmt:message key="reset.password" bundle="${msg}" /></button>
                                        </li>
                                    </div>
                                </ul>
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
            <div class="tab-pane"  data-ng-class="{'active' : templateCategory == 'network'}"  data-ng-if="templateCategory == 'network'" id="step1-network">
                <div data-ng-include src="'app/views/cloud/instance/network-config.jsp'"></div>
            </div>
            <div class="tab-pane"  data-ng-class="{'active' : templateCategory == 'monitor'}" id="step1-monitor">
                <div data-ng-include src="'app/views/cloud/instance/monitor.jsp'"></div>
            </div>
            <div class="tab-pane"  data-ng-class="{'active' : templateCategory == 'monitor-windows'}" id="step1-monitor-windows">
                <div data-ng-include src="'app/views/cloud/instance/monitor-windows.jsp'"></div>
            </div>
        </div>
    </div>
</div>
