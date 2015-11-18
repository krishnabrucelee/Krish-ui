<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div ui-view >
    <div  data-ng-controller="volumeCtrl">
        <div class="hpanel">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12 ">
                        <div class="pull-left">
                            <div class="dashboard-box pull-left">
                                <span class="pull-right"><fmt:message key="total.volume" bundle="${msg}" /></span>
                                <div class="clearfix"></div>
                                <span class="pull-left m-t-xs"><img src="images/volume-icon.png"></span>
                                <b class="pull-right">13</b>
                                <div class="clearfix"></div>
                            </div>
                            <div class="dashboard-box pull-left">
                                <span class="pull-right"><fmt:message key="running.volume" bundle="${msg}" /></span>
                                <div class="clearfix"></div>
                                <span class="pull-left m-t-xs"><img src="images/volume-icon.png"></span>
                                <b class="pull-right">04</b>
                                <div class="clearfix"></div>
                            </div>
                            <div class="dashboard-box pull-left">
                                <span class="pull-right"><fmt:message key="stopped.volume" bundle="${msg}" /></span>
                                <div class="clearfix"></div>
                                <span class="pull-left m-t-xs"><img src="images/volume-icon.png"></span>
                                <b class="pull-right">09</b>
                                <div class="clearfix"></div>
                            </div>

                        </div>

                        <div class="pull-right">
                            <panda-quick-search></panda-quick-search>
                            <div class="clearfix"></div>
                            <span class="pull-right m-l-sm m-t-sm">
                                <a class="btn btn-info" data-ng-click="openUploadVolumeContainer()"><span class="pe-7s-cloud-upload pe-lg font-bold m-r-xs"></span> <fmt:message key="common.name" bundle="${msg}" /></a>
                                <a class="btn btn-info" data-ng-click="addVolume('md')"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span>  <fmt:message key="add.volume" bundle="${msg}" /></a>
                                <a class="btn btn-info" ui-sref="cloud.list-volume" title="<fmt:message key="common.refresh" bundle="${msg}" />" ui-sref-opts="{reload: true}"><span class="fa fa-refresh fa-lg "></span></a>
                            </span>
                        </div>

                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
             <pagination-content></pagination-content>
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12 ">
                    <div class="white-content">
                        <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                    <th class="col-md-2 col-xs-2"><fmt:message key="common.name" bundle="${msg}" /></th>
                                    <th class="col-md-1 col-xs-1"><fmt:message key="common.type" bundle="${msg}" /></th>
                                    <th class="col-md-2 col-xs-3"><fmt:message key="common.plan" bundle="${msg}" /></th>
                                    <th class="col-md-3 col-xs-3"><fmt:message key="common.attached.to" bundle="${msg}" /></th>
                                    <th class="col-md-1 col-xs-1"><fmt:message key="common.size" bundle="${msg}" /></th>
                                    <th class="col-md-2 col-xs-1"><fmt:message key="common.created.date" bundle="${msg}" /></th>
                                    <th class="col-md-1 col-xs-1"><fmt:message key="common.action" bundle="${msg}" /></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr data-ng-repeat="volume in volumeList| filter:quickSearch">
                                    <td>
                                        <a class="text-info" href="javascript:void(0)"  title="View Volume" >{{ volume.name}}</a>

                                    </td>
                                    <td>{{ volume.volumeType}}</td>
                                    <td>{{ volume.storageOffering.name}}</td>
                                    <td>{{ volume.attachedTo.name || " - " }}</td>
                                    <td>{{ volume.diskSize}}</td>
                                    <td>{{ volume.createdDateTime}}</td>
                                    <td>
                                        <div class="btn-group action-menu">
                                        <!-- -->
                                            <span data-ng-if="volume.volumeType == 'DATADISK'">
                                                <a class="fa fa-cogs dropdown-toggle" data-toggle="dropdown" ></a>
                                                <ul class="dropdown-menu pull-right">
                                                    <img src="images/dropdown-arw2.png" border="0" class="vol-dropdown-arw">
                                                    <li><a class="icon-button" href="javascript:void(0);" data-ng-click="createSnapshot(md,volume)" title="Snapshot"><span class="fa fa-camera m-xs"></span> <fmt:message key="common.snapshot" bundle="${msg}" /></a></li>
                                                    <li><a href="javascript:void(0);" data-ng-click="openReccuringSnapshot(volume)" title="Recurring Snapshot"><span class="fa fa-repeat m-xs"></span> <fmt:message key="recurring.snapshot" bundle="${msg}" /></a></li>
                                                    <li><a href="javascript:void(0);" title="Detach Volume" data-ng-click="detachVolume('sm')"><span class="fa fa-unlink m-xs"></span> <fmt:message key="common.detach" bundle="${msg}" /></a></li>
                                                    <li><a href="javascript:void(0);" title="Download Volume" data-ng-click="downloadVolume('md')"><span class="fa fa-cloud-download m-xs"></span> <fmt:message key="download.volume" bundle="${msg}" /></a></li>
                                                    <li><a href="javascript:void(0);"  data-ng-click="resizeVolume(volume)" title="Resize"><span class="fa fa-expand m-xs"></span><fmt:message key="resize.volume" bundle="${msg}" /> </a></li>
                                                </ul>
                                            </span>
                                            <span data-ng-if="volume.volumeType == 'ROOT'">
                                                <a class="fa fa-cogs dropdown-toggle" data-toggle="dropdown" ></a>
                                                <ul class="dropdown-menu pull-right">
                                                    <img src="images/dropdown-arw2.png" border="0" class="vol-dropdown-arw">
                                                    <li><a href="javascript:void(0);" data-ng-click="createSnapshot(md,volume)" title="Snapshot"><span class="fa fa-camera m-xs"></span> <fmt:message key="common.snapshot" bundle="${msg}" /></a></li>
                                                    <li><a href="javascript:void(0);" data-ng-click="openReccuringSnapshot(volume)"  title="Recurring Snapshot"><span class="fa fa-repeat m-xs"></span> <fmt:message key="recurring.snapshot" bundle="${msg}" /></a></li>
                                                </ul>
                                            </span>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
         <pagination-content></pagination-content>
        </div>

    </div>
</div>