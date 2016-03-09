<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div ui-view >
    <div  data-ng-controller="volumeCtrl">
        <div class="hpanel">
            <div class="panel-heading no-padding">
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12 ">
                        <div class="pull-left">
                            <div class="dashboard-box pull-left">
	                            <div class="instance-border-content-normal">
	                            	<span class="pull-left"><img src="images/volume-icon.png"></span>
	                                <span class="pull-left m-t-xs m-l-xs m-r-xs"><fmt:message key="total.volume" bundle="${msg}" /></span>

	                                <b class="pull-left">{{volumeList.Count}}</b>
	                                <div class="clearfix"></div>
                                </div>
                            </div>
                            <div class="dashboard-box pull-left">
                            	<div class="instance-border-content-normal">
                            		<span class="pull-left"><img src="images/volume-icon.png"></span>
	                                <span class="pull-left m-t-xs m-l-xs m-r-xs"><fmt:message key="attached.volume" bundle="${msg}" /></span>

	                                <b class="pull-left">{{attachedCount}}</b>
	                                <div class="clearfix"></div>
                                </div>
                            </div>
                            <div class="dashboard-box pull-left">
	                            <div class="instance-border-content-normal">
	                            	<span class="pull-left"><img src="images/volume-icon.png"></span>
	                                <span class="pull-left m-t-xs m-l-xs m-r-xs"><fmt:message key="detached.volume" bundle="${msg}" /></span>

	                                <b class="pull-left">{{detachedCount}}</b>
	                                <div class="clearfix"></div>
                                </div>
                            </div>
                            <a class="btn btn-info" has-permission="UPLOAD_VOLUME" data-ng-click="uploadVolumeCtrl('md')"><span class="pe-7s-cloud-upload pe-lg font-bold m-r-xs"></span> <fmt:message key="upload.volume" bundle="${msg}" /></a>
                                <a class="btn btn-info" has-permission="ADD_VOLUME" data-ng-click="addVolume('md')"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span>  <fmt:message key="common.add" bundle="${msg}" /></a>
                                <a class="btn btn-info" ui-sref="cloud.list-volume" title="<fmt:message key="common.refresh" bundle="${msg}" />" ui-sref-opts="{reload: true}"><span class="fa fa-refresh fa-lg "></span></a>
                        </div>
                        <div class="pull-right">
                            <panda-quick-search></panda-quick-search>
                            <span class="pull-right m-r-sm" data-ng-show="global.sessionValues.type == 'ROOT_ADMIN'">
								<select
									class="form-control input-group col-xs-5" name="domainView"
									data-ng-model="domainView"
									data-ng-change="selectDomainView(1)"
									data-ng-options="domainView.name for domainView in volumeElement.domainList">
									<option value="">Select Domain</option>
								</select>
							</span>
                            <div class="clearfix"></div>
                            <span class="pull-right m-l-sm m-t-sm">
<%--                             	<a class="btn btn-info" data-ng-click="uploadVolumeFromLocalCtrl('md')"><span class="pe-7s-cloud-upload pe-lg font-bold m-r-xs"></span> <fmt:message key="upload.volume.from.local" bundle="${msg}" /></a> --%>
<%-- 								<a class="btn btn-info" ><span class="pe-7s-cloud-upload pe-lg font-bold m-r-xs"></span> <fmt:message key="upload.volume.from.local" bundle="${msg}" /></a>
 --%>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12 ">
                    <div class="white-content">
                    <div data-ng-show = "showLoader" style="margin: 1%">
    				  		<get-loader-image data-ng-show="showLoader"></get-loader-image>
      						</div>
      						<div  data-ng-hide="showLoader" class="table-responsive col-12-table">
                        <table cellspacing="1" cellpadding="1" class="table dataTable table-bordered table-striped">
                            <thead>
                               <tr>
                            	    <th  data-ng-click="changeSort('name',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='name'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.name" bundle="${msg}" /></th>
                            	    <th  data-ng-click="changeSort('department.userName',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='department.userName'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.department" bundle="${msg}" /></th>
                            		<th  data-ng-click="changeSort('project.name',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='project.name'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.project" bundle="${msg}" /></th>
                            	    <th  data-ng-click="changeSort('volumeType',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='volumeType'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.type" bundle="${msg}" /></th>
                            	    <th  data-ng-click="changeSort('storageOffering.name',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='storageOffering.name'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.plan" bundle="${msg}" /></th>
                            		<th  data-ng-click="changeSort('vmInstance.name',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='vmInstance.name'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.attached.to" bundle="${msg}" /></th>
                            	    <th  data-ng-click="changeSort('diskSize',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='diskSize'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.size" bundle="${msg}" /> GB</th>
                            	    <th  data-ng-click="changeSort('createdDateTime',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='createdDateTime'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.created.date" bundle="${msg}" /></th>

                            		<th class="col-md-1 col-xs-1"><fmt:message key="common.action" bundle="${msg}" /></th>
                            	</tr>
                            </thead>
                            <tbody data-ng-hide="volumeList.length > 0">
                                <tr>
                                    <td class="col-md-9 col-sm-9" colspan="9"><fmt:message key="common.no.records.found" bundle="${msg}" />!!</td>
                                </tr>
                            </tbody>
                            <tbody data-ng-show="volumeList.length > 0">
                                <tr data-ng-repeat="volume in filteredCount = (volumeList| filter:quickSearch | orderBy:sort.column:sort.descending)">
                                    <td>
                                        <!-- <a class="text-info" href="javascript:void(0)"  title="View Volume" > -->{{ volume.name}}<!-- </a> -->
                                    </td>
                                    <td>{{ volume.department.userName || " - "}}</td>
                                    <td>{{ volume.project.name || " - "}}</td>
                                    <td>{{ volume.volumeType}}</td>
                                    <td>{{ volume.storageOffering.name || " - "}}</td>
                                    <td>{{ volume.vmInstance.name || " - " }}</td>
                                    <td><span data-ng-if="volume.volumeType == 'ROOT'"> {{ volume.diskSize / global.Math.pow(2, 30)}}</span>
                                    <span data-ng-if="volume.volumeType == 'DATADISK' && volume.storageOffering.isCustomDisk">{{ volume.diskSize / global.Math.pow(2, 30)}}</span>
                                     <span data-ng-if="volume.volumeType == 'DATADISK' && !volume.storageOffering.isCustomDisk ">{{ volume.storageOffering.diskSize}}</span></td>
                                    <td>{{ volume.createdDateTime*1000 | date:'yyyy-MM-dd HH:mm:ss'}}</td>
                                    <td>
                                        <div class="btn-group action-menu">
                                            <span data-ng-if="volume.volumeType == 'DATADISK'">
                                                <a class="fa fa-cogs dropdown-toggle" data-toggle="dropdown" ></a>
                                                <ul class="dropdown-menu pull-right">
                                                    <img src="images/dropdown-arw2.png" border="0" class="vol-dropdown-arw">
                                                     <li has-permission = "DISK_SNAPSHOT"><a class="icon-button" href="javascript:void(0);" data-ng-click="createSnapshot(md, volume)" title="Snapshot"><span class="fa fa-camera m-xs"></span> <fmt:message key="common.snapshot" bundle="${msg}" /></a></li>
                                                    <li has-permission = "RECURRING_SNAPSHOT"><a href="javascript:void(0);" data-ng-click="openReccuringSnapshot(volume)" title="Recurring Snapshot"><span class="fa fa-repeat m-xs"></span> <fmt:message key="recurring.snapshot" bundle="${msg}" /></a></li>
                                                    <li  has-permission="DETACH_DISK" ><a href="javascript:void(0);"data-ng-show="volume.vmInstanceId > 0" title="<fmt:message key="common.detach.volume" bundle="${msg}" />" data-ng-click="detach(md, volume)"><span class="fa fa-unlink m-xs"></span> <fmt:message key="detach.volume" bundle="${msg}" /></a></li>
                                                    <li has-permission="ATTACH_DISK"><a href="javascript:void(0);"  data-ng-hide="volume.vmInstanceId > 0" title="<fmt:message key="common.attach.volume" bundle="${msg}" />" data-ng-click="attach(md, volume)"><span class="pe-7s-disk pe-1x font-bold m-xs"></span> <fmt:message key="attach.volume" bundle="${msg}" /></a></li>
<%--                                                     <li><a href="javascript:void(0);" title="Download Volume" data-ng-click="downloadVolume('md')"><span class="fa fa-cloud-download m-xs"></span> <fmt:message key="download.volume" bundle="${msg}" /></a></li>
 --%><%--                                                     <li><a href="javascript:void(0);" data-ng-show="volume.status == 'READY'" data-ng-click="resizeVolume(md, volume)" title="Resize"><span class="fa fa-expand m-xs"></span><fmt:message key="resize.volume" bundle="${msg}" /> </a></li>
 --%>                                                    <li has-permission="DELETE_VOLUME"><a href="javascript:void(0);" data-ng-hide="volume.vmInstanceId > 0" data-ng-click="delete('sm', volume)" title="Delete Volume"><span class="fa fa-trash m-xs"></span><fmt:message key="delete.volume" bundle="${msg}" /> </a></li>
                                                </ul>
                                            </span>
                                             <span data-ng-if="volume.volumeType == 'ROOT'">
                                                <a class="fa fa-cogs dropdown-toggle" data-toggle="dropdown" ></a>
                                                <ul class="dropdown-menu pull-right">
                                                    <img src="images/dropdown-arw2.png" border="0" class="vol-dropdown-arw">
                                                    <li has-permission = "DISK_SNAPSHOT"><a href="javascript:void(0);" data-ng-click="createSnapshot(md, volume)" title="Snapshot"><span class="fa fa-camera m-xs"></span> <fmt:message key="common.snapshot" bundle="${msg}" /></a></li>
                                                    <li has-permission = "RECURRING_SNAPSHOT" ><a href="javascript:void(0);" data-ng-click="openReccuringSnapshot(volume)"  title="Recurring Snapshot"><span class="fa fa-repeat m-xs"></span> <fmt:message key="recurring.snapshot" bundle="${msg}" /></a></li>
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
            </div>
            <pagination-content></pagination-content>
        </div>
    </div>
</div>