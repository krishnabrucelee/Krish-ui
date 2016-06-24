<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div ui-view >
    <div  data-ng-controller="volumeCtrl">
        <div class="hpanel">
            <div class="panel-heading no-padding">
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12 ">
                        <div class="pull-left dashboard-btn-area">
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
                            <a class="btn btn-info font-bold" has-permission="UPLOAD_VOLUME" data-ng-click="uploadVolumeCtrl('md')"><span class="pe-7s-cloud-upload pe-lg font-bold m-r-xs"></span> <fmt:message key="upload.volume" bundle="${msg}" /></a>
                                <a class="btn btn-info font-bold" has-permission="ADD_VOLUME" data-ng-click="addVolume('md')"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span>  <fmt:message key="common.add" bundle="${msg}" /></a>
                                <a class="btn btn-info" data-ng-click="list(1)" title="<fmt:message key="common.refresh" bundle="${msg}" />" ui-sref-opts="{reload: true}"><span class="fa fa-refresh fa-lg "></span></a>
                        </div>
                        <div class="pull-right dashboard-filters-area" id="volume_quick_search">
						<form data-ng-submit="searchList(quickSearchText)">
							<div class="quick-search pull-right">
								<div class="input-group">
									<input data-ng-model="quickSearchText" id="volume_list_search" type="text" valid-characters class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />" aria-describedby="quicksearch-go">
								   	<span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
								</div>
							</div>
							<span class="pull-right m-r-sm" data-ng-if="global.sessionValues.type == 'ROOT_ADMIN'">
								<select
									class="form-control input-group col-xs-5" name="domainView"
									data-ng-model="domainView"
									data-ng-change="selectDomainView(domainView)"
									data-ng-options="domainView.name for domainView in volumeElement.domainList">
									<option value=""> <fmt:message key="common.domain.filter" bundle="${msg}" /></option>
								</select>
							</span>
							<span class="pull-right m-r-sm" data-ng-if="global.sessionValues.type == 'DOMAIN_ADMIN'">
								<select
									class="form-control input-group col-xs-5" name="departmentView"
									data-ng-model="departmentView"
									data-ng-change="selectDepartmentView(departmentView)"
									data-ng-options="departmentView.userName for departmentView in departmentList">
									<option value=""> <fmt:message key="common.department.filter" bundle="${msg}" /></option>
								</select>
							</span>
							<span class="pull-right m-r-sm" data-ng-if="global.sessionValues.type == 'USER'">
								<select
									class="form-control input-group col-xs-5" name="userView"
									data-ng-model="userView"
									data-ng-change="selectProjectView(userView)"
									data-ng-options="userView.name for userView in options">
									<option value=""> <fmt:message key="common.project.filter" bundle="${msg}" /></option>
								</select>
							</span>
                            <div class="clearfix"></div>
                            <span class="pull-right m-l-sm m-t-sm">
                            </span>
						</form>
						</div>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12 ">
                    <div class="white-content">
                     <div data-ng-if="global.webSocketLoaders.volumeLoader" class="overlay-wrapper">
              		<get-show-loader-image data-ng-show="global.webSocketLoaders.volumeLoader"></get-show-loader-image>
            		</div>
                    <div style="margin: 1%">
    				  		<get-loader-image></get-loader-image>
      						</div>
      						<div  data-ng-hide="showLoader" class="table-responsive responsive-x">
                        <table cellspacing="1" cellpadding="1" class="table dataTable table-bordered table-striped">
                            <thead>
                               <tr>
                            	    <th  data-ng-click="changeSort('name',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='name'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.name" bundle="${msg}" /></th>
                            	    <th  data-ng-click="changeSort('departmentUserName',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='departmentUserName'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.department" bundle="${msg}" /></th>
                            		<th  data-ng-click="changeSort('projectName',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='projectName'? 'sorting_desc' : 'sorting_asc' "><fmt:message key="common.project" bundle="${msg}" /></th>
                            	    <th  data-ng-click="changeSort('volumeType',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='volumeType'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.type" bundle="${msg}" /></th>
                            	    <th  data-ng-click="changeSort('storageOfferingName',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='storageOfferingName'? 'sorting_desc' : 'sorting_asc' "><fmt:message key="common.plan" bundle="${msg}" /></th>
                            		<th  data-ng-click="changeSort('vmInstanceName',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='vmInstanceName'? 'sorting_desc' : 'sorting_asc' "><fmt:message key="common.attached.to" bundle="${msg}" /></th>
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
                                <tr data-ng-repeat="volume in filteredCount = volumeList">
                                    <td>
                                        <!-- <a class="text-info" href="javascript:void(0)"  title="View Volume" > -->{{ volume.name}}<!-- </a> -->
                                    </td>
                                    <td>{{ volume.departmentUserName || " - "}}</td>
                                    <td>{{ volume.projectName || " - "}}</td>
                                    <td>{{ volume.volumeType}}</td>
                                    <td>{{ volume.storageOfferingName || " - "}}</td>
                                    <td>{{ volume.vmInstanceName || " - " }}</td>
                                    <td><span data-ng-if="volume.volumeType == 'ROOT'"> {{ volume.diskSize / global.Math.pow(2, 30)}}</span>
                                    <span data-ng-if="volume.volumeType == 'DATADISK' && volume.isCustomDisk">{{ volume.diskSize / global.Math.pow(2, 30)}}</span>
                                     <span data-ng-if="volume.volumeType == 'DATADISK' && !volume.isCustomDisk">{{volume.storageDiskSize}}</span></td>
                                    <td>{{ volume.createdDateTime*1000 | date:'yyyy-MM-dd HH:mm:ss'}}</td>
                                    <td>
                                        <div class="btn-group action-menu">
                                            <span data-ng-if="volume.volumeType == 'DATADISK'">
                                                <a class="fa fa-cogs dropdown-toggle" data-toggle="dropdown" ></a>
                                                <ul class="dropdown-menu pull-right">
                                                    <img src="images/dropdown-arw2.png" border="0" class="vol-dropdown-arw">
                                                     <li has-permission = "DISK_SNAPSHOT"><a class="icon-button" href="javascript:void(0);" data-ng-click="createSnapshot(md, volume.id)" title="Snapshot"><span class="fa fa-camera m-xs"></span> <fmt:message key="common.snapshot" bundle="${msg}" /></a></li>
                                                    <li has-permission = "RECURRING_SNAPSHOT"><a href="javascript:void(0);" data-ng-click="openReccuringSnapshot(volume.id)" title="Recurring Snapshot"><span class="fa fa-repeat m-xs"></span> <fmt:message key="recurring.snapshot" bundle="${msg}" /></a></li>
                                                    <li  has-permission="DETACH_DISK" ><a href="javascript:void(0);"data-ng-show="volume.vmInstanceId > 0" title="<fmt:message key="common.detach.volume" bundle="${msg}" />" data-ng-click="detach(md, volume.id)"><span class="fa fa-unlink m-xs"></span> <fmt:message key="detach.volume" bundle="${msg}" /></a></li>
                                                    <li has-permission="ATTACH_DISK"><a href="javascript:void(0);"  data-ng-hide="volume.vmInstanceId > 0" title="<fmt:message key="common.attach.volume" bundle="${msg}" />" data-ng-click="attach(md, volume.id)"><span class="pe-7s-disk pe-1x font-bold m-xs"></span> <fmt:message key="attach.volume" bundle="${msg}" /></a></li>
<%--                                                     <li><a href="javascript:void(0);" title="Download Volume" data-ng-click="downloadVolume('md')"><span class="fa fa-cloud-download m-xs"></span> <fmt:message key="download.volume" bundle="${msg}" /></a></li>
 --%>                                                    <li><a href="javascript:void(0);" data-ng-show="volume.status == 'READY'" data-ng-click="resizeVolume(md, volume.id)" title="Resize"><span class="fa fa-expand m-xs"></span><fmt:message key="resize.volume" bundle="${msg}" /> </a></li>
                                                    <li has-permission="DELETE_VOLUME"><a href="javascript:void(0);" data-ng-hide="volume.vmInstanceId > 0" data-ng-click="delete('sm', volume.id)" title="Delete Volume"><span class="fa fa-trash m-xs"></span><fmt:message key="delete.volume" bundle="${msg}" /> </a></li>
                                                </ul>
                                            </span>
                                             <span data-ng-if="volume.volumeType == 'ROOT'">
                                                <a class="fa fa-cogs dropdown-toggle" data-toggle="dropdown" ></a>
                                                <ul class="dropdown-menu pull-right">
                                                    <img src="images/dropdown-arw2.png" border="0" class="vol-dropdown-arw">
                                                    <li has-permission = "DISK_SNAPSHOT"><a href="javascript:void(0);" data-ng-click="createSnapshot(md, volume.id)" title="Snapshot"><span class="fa fa-camera m-xs"></span> <fmt:message key="common.snapshot" bundle="${msg}" /></a></li>
                                                    <li has-permission = "RECURRING_SNAPSHOT" ><a href="javascript:void(0);" data-ng-click="openReccuringSnapshot(volume.id)"  title="Recurring Snapshot"><span class="fa fa-repeat m-xs"></span> <fmt:message key="recurring.snapshot" bundle="${msg}" /></a></li>
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