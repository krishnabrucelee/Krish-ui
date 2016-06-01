<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div data-ng-controller="storageCtrl">
<div class="row" >

        <div class="col-md-12">
        <div data-ng-if="global.webSocketLoaders.vmstorageLoader" class="overlay-wrapper">
<!--                 <img data-ng-if="global.webSocketLoaders.vmstorageLoader" src="images/loading-bars.svg" class="inner-loading" />
 -->
<get-show-loader-image data-ng-show="global.webSocketLoaders.vmstorageLoader"></get-show-loader-image>
            </div>
            <div class="row">
                    <div class="col-md-12 col-sm-12">
                        <h4><fmt:message key="instance.storage.manager" bundle="${msg}" />
                         <span class="pull-right">
                            <a class="btn btn-info" has-permission="ATTACH_DISK" data-ng-click="attach(md, volume.instanceId)"><span class="pe-7s-paperclip pe-lg font-bold m-r-xs"></span><fmt:message key="attach.volume" bundle="${msg}" /></a>
                            <a class="btn btn-info" has-permission="ADD_VOLUME" data-ng-click="addVolume('md')"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span><fmt:message key="add.volume" bundle="${msg}" /></a>
                        </span>
                        </h4>

                        <hr>
                    </div>
                </div>
            <div class="row">
	            <div class="col-md-8 col-md-offset-2 col-sm-12 storage-diagram-area">
	                <div class="clearfix"></div>
	                <div class="col-md-4 col-sm-4 pull-left storage-diagram-icon">
	                    <div class="panel panel-info">
	                        <div class="panel-body  text-info text-center" >
	                            <!--<i class="pe-7s-server pe-lg pe-5x"></i>-->
	                            <img src="images/storage_icon.jpg" alt="Storage" />
	                            <h5><b class="ng-binding">{{ instanceName }}</b></h5>
	                        </div>
	                    </div>
	                </div>
	                <div class="col-md-8 col-sm-8 pull-right storage-diagram">
	                    <div class="hpanel">

	                        <div class=" vertical-container" animate-panel child="vertical-timeline-block" delay="3">
	                            <div class="v-timeline  vertical-timeline-block" data-ng-class="{'timeline-primary' : $index == 0}"  data-ng-repeat="volume in volumeList" >
	                                <div class="h-timeline">
	                                    <div class="vertical-timeline-content">

	                                        <div class="timeline-title">
	                                         {{ volume.name }} Created on {{ volume.createdDateTime*1000 | date:'yyyy-MM-dd HH:mm:ss'}}
	                                       </div>
	                                        <div class="row">
	                                            <div class="col-md-12">

	                                                <div class="p-sm">
	                                                        <div class="pull-left">
	                                                            <i class="pe-7s-server pe-3x"></i> <h3 class="pull-right text-danger m-l-md"><span data-ng-if="volume.volumeType == 'ROOT'"> {{ volume.diskSize / global.Math.pow(2, 30)}}</span>
	                                                             <span data-ng-if="volume.volumeType == 'DATADISK' && volume.storageOffering.isCustomDisk">{{ volume.diskSize / global.Math.pow(2, 30)}} </span>
	                                                             <span data-ng-if="volume.volumeType == 'DATADISK' && !volume.storageOffering.isCustomDisk ">{{ volume.storageOffering.diskSize}}</span>
	                                                             <span data-ng-if="volume.volumeType == 'DATADISK' && volume.storageOffering == null ">{{ volume.diskSize / global.Math.pow(2, 30)}}</span> GB</h3>
	                                                            <h5>{{ volume.name }}</h5>
	                                                        </div>
	                                                        <div class="pull-right">
	                                                            <a data-toggle="dropdown" href="#" class="pull-right notification">
	                                                                <i class="pe-7s-camera pe-2x"></i>
	                                                                <span class="label label-success">04</span>
	                                                            </a>
	                                                            <div class="clearfix"></div>
	                                                            <div class="btn-group">
	                                                                <span data-ng-if="volume.volumeType == 'DATADISK'">
	                                                                    <button class="btn btn-sm m-t-md dropdown-toggle" data-ng-class="$index == 0 ? 'btn-info' : 'btn-default'" data-toggle="dropdown"><i class="fa fa-cog"></i> <fmt:message key="configure" bundle="${msg}" /> </button>
	                                                                    <ul class="dropdown-menu pull-right">
	    <%--                                                                     <li><a href="javascript:void(0);" title="<fmt:message key="common.snapshot" bundle="${msg}" />" data-ng-click="downloadSnapshot($event)"><span class="pe-7s-camera font-bold m-xs"></span> <fmt:message key="common.snapshot" bundle="${msg}" /></a></li>
	                                                                        <li><a href="javascript:void(0);" data-ng-click="openReccuringSnapshot(volume)" title="<fmt:message key="recurring.snapshot" bundle="${msg}" />"><span class="pe-7s-repeat font-bold m-xs"></span> <fmt:message key="recurring.snapshot" bundle="${msg}" /></a></li>
	     --%>                                                                    <li has-permission="DETACH_DISK"><a href="javascript:void(0);" data-ng-show="volume.vmInstanceId > 0" title="<fmt:message key="detach.volume" bundle="${msg}" />" data-ng-click="detach(md, volume)"><span class="fa fa-unlink m-xs"></span> <fmt:message key="detach.volume" bundle="${msg}" /></a></li>
	                                                                        <%-- <li><a href="javascript:void(0);" title="<fmt:message key="download.volume" bundle="${msg}" />" data-ng-click="downloadVolume(volume)"><span class="pe-7s-cloud-download font-bold m-xs"></span> <fmt:message key="download.volume" bundle="${msg}" /></a></li>
	                                                                        <li><a href="javascript:void(0);" data-ng-show="volume.status == 'READY'" data-ng-click="resizeVolume(md, volume)" title="<fmt:message key="resize.volume" bundle="${msg}" />"><span class="pe-7s-exapnd2 font-bold m-xs"></span> <fmt:message key="resize.volume" bundle="${msg}" /></a></li>
	                                                                         --%><li has-permission="DELETE_VOLUME"><a href="javascript:void(0);" data-ng-hide="volume.vmInstanceId > 0" data-ng-click="delete('sm', volume)" title="Delete Volume"><span class="fa fa-trash m-xs"></span><fmt:message key="delete.volume" bundle="${msg}" /> </a></li>
	                                                                    </ul>
	                                                                </span>


	                                                                <%--                                                             <span data-ng-if="volume.volumeType == 'ROOT'">
	                                                                    <button class="btn btn-sm m-t-md dropdown-toggle" data-ng-class="$index == 0 ? 'btn-info' : 'btn-default'" data-toggle="dropdown"><i class="fa fa-cog"></i> <fmt:message key="configure" bundle="${msg}" /> </button>
	                                                                    <ul class="dropdown-menu pull-right">
	                                                                        <li><a href="javascript:void(0);"  title="<fmt:message key="common.snapshot" bundle="${msg}" />" data-ng-click="downloadSnapshot($event)"><span class="pe-7s-camera font-bold m-xs"></span> <fmt:message key="common.snapshot" bundle="${msg}" /></a></li>
	                                                                        <li><a href="javascript:void(0);" data-ng-click="openReccuringSnapshot(volume)"  title="<fmt:message key="recurring.snapshot" bundle="${msg}" />"><span class="pe-7s-repeat font-bold m-xs"></span> <fmt:message key="recurring.snapshot" bundle="${msg}" /></a></li>
	                                                                    </ul>
	                                                                </span> --%>
	                                                            </div>
	                                                        </div>
	                                                        <div class="clearfix"></div>
	                                                    <div class="m-t-sm" data-ng-init="getStoragePerformanceByFilters(volume.vmInstance.name, volume.storageOffering.diskSize)">

	                                                        <div class="progress full" style="height: 30px;">
	                                                            <div
	                                                            data-ng-class="rootUsage[$index] > 85 ? 'progress-bar-danger' : 'progress-bar-success'"
	                                                             class="progress-bar"
	                                                                role="progressbar" data-ng-style="memoryStyle[$index]">
	                                                                <span style="top: 4px; position: relative">
	                                                                {{ rootUsage[$index] }} % </span>
	                                                            </div>
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                            </div>
	                                        </div>

	                                    </div>
	                                </div>
	                            </div>

	                        </div>
	                    </div>
	                </div>
	            </div>
        	</div>
        </div>
</div>
    </div>