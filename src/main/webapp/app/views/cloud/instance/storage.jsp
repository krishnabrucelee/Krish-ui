<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div data-ng-controller="storageCtrl">
<div class="row" >

        <div class="col-md-12">
            <div class="row">
                    <div class="col-md-12 col-sm-12">
                        <h4>Instance Storage Manager
                         <span class="pull-right">
                            <a class="btn btn-info" data-ng-click="attachVolume('md')"><span class="pe-7s-paperclip pe-lg font-bold m-r-xs"></span>Attach Volume</a>
                            <a class="btn btn-info" data-ng-click="addVolume('md')"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span>Add Volume</a>
                        </span>
                        </h4>

                        <hr>
                    </div>
                </div>
            <div class="storage-manager-area">


                <div class="clearfix"></div>
                <div class="storage pull-left">
                    <div class="panel panel-info">
                        <div class="panel-body  text-info text-center">
                            <!--<i class="pe-7s-server pe-lg pe-5x"></i>-->
                            <img src="images/storage_icon.jpg" alt="Storage" />
                            <h5><b class="ng-binding">{{ instanceName }}</b></h5>
                        </div>
                    </div>
                </div>
                <div class="storage-manager pull-right">
                    <div class="hpanel">

                        <div class=" vertical-container" animate-panel child="vertical-timeline-block" delay="3">
                            <div class="v-timeline  vertical-timeline-block" data-ng-class="{'timeline-primary' : $index == 0}"  data-ng-repeat="volume in volumeList" >
                                <div class="h-timeline">
                                    <div class="vertical-timeline-content">

                                        <div class="timeline-title">
                                           {{ volume.name }} Created on {{ volume.createdDate }}
                                       </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="p-sm">
                                                    <div class="pull-left">
                                                        <i class="pe-7s-server pe-4x"></i> <h3 class="pull-right text-danger m-l-md">{{ volume.plan.size }}</h3>
                                                        <h5>{{ volume.name }}</h5>
                                                    </div>
                                                    <div class="pull-right">
                                                        <a data-toggle="dropdown" href="#" class="pull-right notification">
                                                            <i class="pe-7s-camera pe-2x"></i>
                                                            <span class="label label-success">04</span>
                                                        </a>
                                                        <div class="clearfix"></div>
                                                        <div class="btn-group" data-ng-controller="volumeListCtrl">

                                                            <span data-ng-if="$index != 0">
                                                                <button class="btn btn-sm m-t-md dropdown-toggle" data-ng-class="$index == 0 ? 'btn-info' : 'btn-default'" data-toggle="dropdown"><i class="fa fa-cog"></i> Configure </button>
                                                                <ul class="dropdown-menu pull-right">
                                                                    <li><a href="javascript:void(0);" title="Snapshot" data-ng-click="downloadSnapshot($event)"><span class="pe-7s-camera font-bold m-xs"></span> Snapshot</a></li>
                                                                    <li><a href="javascript:void(0);" data-ng-click="openReccuringSnapshot(volume)" title="Recurring Snapshot"><span class="pe-7s-repeat font-bold m-xs"></span> Recurring Snapshot</a></li>
                                                                    <li><a href="javascript:void(0);" title="Detach Volume" data-ng-click="detachVolume()"><span class="fa fa-unlink m-xs"></span> Detach</a></li>
                                                                    <li><a href="javascript:void(0);" title="Download Volume" data-ng-click="downloadVolume(volume)"><span class="pe-7s-cloud-download font-bold m-xs"></span> Download Volume</a></li>
                                                                    <li><a href="javascript:void(0);"  data-ng-click="resizeVolume(volume)" title="Resize"><span class="pe-7s-exapnd2 font-bold m-xs"></span> Resize Volume</a></li>
                                                                </ul>
                                                            </span>
                                                            <span data-ng-if="$index == 0">
                                                                <button class="btn btn-sm m-t-md dropdown-toggle" data-ng-class="$index == 0 ? 'btn-info' : 'btn-default'" data-toggle="dropdown"><i class="fa fa-cog"></i> Configure </button>
                                                                <ul class="dropdown-menu pull-right">
                                                                    <li><a href="javascript:void(0);"  title="Snapshot" data-ng-click="downloadSnapshot($event)"><span class="pe-7s-camera font-bold m-xs"></span> Snapshot</a></li>
                                                                    <li><a href="javascript:void(0);" data-ng-click="openReccuringSnapshot(volume)"  title="Recurring Snapshot"><span class="pe-7s-repeat font-bold m-xs"></span> Recurring Snapshot</a></li>
                                                                </ul>
                                                            </span>
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