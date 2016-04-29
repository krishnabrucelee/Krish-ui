<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<div ui-view>
	<div data-ng-hide="viewContent" ng-controller="instanceListCtrl">
		<div class="hpanel">
			<div class="panel-heading no-padding">
				<div class="row">
					<div class="col-md-12 col-sm-12 col-xs-12 ">
						<div class="pull-left dashboard-btn-area">
							<div class="dashboard-box pull-left" data-ng-click="list(1, 'Expunging')">
								<div class="instance-border-content-normal"
									data-ng-class="{'instance-border-content' : borderContent=='Expunging'}"
								>
									 <span class="pull-left"><img src="images/instance-icon.png"></span>
									<span class="pull-left m-t-xs m-l-xs m-r-xs"><fmt:message key="total.instance" bundle="${msg}" /></span>
									 <b class="pull-left">{{totalCount}}</b>
									<div class="clearfix"></div>
								</div>
							</div>
							<div class="dashboard-box pull-left" data-ng-click="list(1, 'Running')">
								<div class="instance-border-content-normal"
									data-ng-class="{'instance-border-content' : borderContent=='Running'}"
								>
									<span class="pull-left"><img src="images/instance-icon.png"></span>
									<span class="pull-left m-t-xs m-l-xs m-r-xs"><fmt:message key="running.instance" bundle="${msg}" /></span>
									<b class="pull-left">{{runningVmCount}}</b>
									<div class="clearfix"></div>
								</div>
							</div>
							<div class="dashboard-box pull-left" data-ng-click="list(1, 'Stopped')">
								<div class="instance-border-content-normal"
									data-ng-class="{'instance-border-content' : borderContent=='Stopped'}"
								>
									<span class="pull-left"><img src="images/instance-icon.png"></span>
									<span class="pull-left m-t-xs m-l-xs m-r-xs"><fmt:message key="stopped.instance" bundle="${msg}" /></span>
									<b class="pull-left">{{stoppedVmCount}}</b>
									<div class="clearfix"></div>
								</div>
							</div>
							<a has-permission="CREATE_VM">
							<span class="pull-right m-l-sm m-t-sm"> <a has-permission="CREATE_VM" class="btn btn-info font-bold" id="instances_create_vm_button"
								data-ng-click="openAddInstance('lg')"
							></span><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span>
								<fmt:message key="create.vm" bundle="${msg}" /></a> <a class="btn btn-info" data-ng-click="list(1, borderContent)"
								id="instances_refresh_button" title="<fmt:message key="common.refresh" bundle="${msg}" />" ui-sref-opts="{reload: true}"
							><span class="fa fa-refresh fa-lg "></span></a>
						</div>
						<div class="pull-right dashboard-filters-area" id="instances_quick_search">
						<form data-ng-submit="searchList(vmSearch)">
							<div class="quick-search pull-right">
								<div class="input-group">
									<input data-ng-model="vmSearch" type="text" class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />" aria-describedby="quicksearch-go">
								   	<span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
								</div>
							</div>
							<span class="pull-right m-r-sm" data-ng-show="global.sessionValues.type == 'ROOT_ADMIN'">
								<select
									class="form-control input-group col-xs-5" name="domainView"
									data-ng-model="domainView"
									data-ng-change="selectDomainView(1)"
									data-ng-options="domainView.name for domainView in domainListView">
									<option value=""> <fmt:message key="common.domain.filter" bundle="${msg}" /></option>
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
			<div class="row" id="instances_pagination_container">
				<div class="col-md-12 col-sm-12 col-xs-12 ">
					<div class="white-content">
						<div data-ng-show="showLoader" style="margin: 1%">
							<get-loader-image data-ng-show="showLoader"></get-loader-image>
						</div>
						<div data-ng-hide="showLoader" class="table-responsive">
							<table cellspacing="1" cellpadding="1" id="instances_table" class="table dataTable table-bordered table-striped ">
								<thead>
									<tr>
										<th ng-click="changeSort('displayName',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='displayName'? 'sorting_desc' : 'sorting_asc' ">
										<fmt:message key="display.name" bundle="${msg}" /></th>
										<th ng-click="changeSort('instanceOwner.userName',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='instanceOwner.userName'? 'sorting_desc' : 'sorting_asc' ">
										<fmt:message key="owner" bundle="${msg}" /></th>
										<th class="custom-width-sm" ng-click="changeSort('application',paginationObject.currentPage)"
											data-ng-class="sort.descending && sort.column =='application'? 'sorting_desc' : 'sorting_asc' ">
										<fmt:message key="common.application" bundle="${msg}" /></th>
										<th class="custom-width-sm" ng-click="changeSort('osType',paginationObject.currentPage)"
											data-ng-class="sort.descending && sort.column =='osType'? 'sorting_desc' : 'sorting_asc' ">
										<fmt:message key="common.osType" bundle="${msg}" /></th>
										<th class="custom-width-xs" ng-click="changeSort('cpuCore',paginationObject.currentPage)"
											data-ng-class="sort.descending && sort.column =='cpuCore'? 'sorting_desc' : 'sorting_asc' ">
										<fmt:message key="vcpu" bundle="${msg}" /></th>
										<th class="custom-width-md" ng-click="changeSort('memory',paginationObject.currentPage)"
											data-ng-class="sort.descending && sort.column =='memory'? 'sorting_desc' : 'sorting_asc' ">
										<fmt:message key="ram" bundle="${msg}" /></th>
										<th class="custom-width-xs" ng-click="changeSort('volumeSize',paginationObject.currentPage)"
											data-ng-class="sort.descending && sort.column =='volumeSize'? 'sorting_desc' : 'sorting_asc' ">
										<fmt:message key="disk" bundle="${msg}" /></th>
										<th ng-click="changeSort('publicIpAddress',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='publicIpAddress'? 'sorting_desc' : 'sorting_asc' ">
										<fmt:message key="public.ip" bundle="${msg}" /></th>
										<th><fmt:message key="common.ip" bundle="${msg}" /></th>
										<th class="custom-width-xs" ng-click="changeSort('status',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='status'? 'sorting_desc' : 'sorting_asc' "><fmt:message key="common.state" bundle="${msg}" /></th>
										<th><fmt:message key="common.action" bundle="${msg}" /></th>
									</tr>
								</thead>
								<tbody data-ng-hide="instanceList.length > 0">
									<tr>
										<td class="col-md-11 col-sm-11" colspan="11"><fmt:message key="common.no.records.found" bundle="${msg}" />!!</td>
									</tr>
								</tbody>
								<tbody data-ng-show="instanceList.length > 0">
									<tr
										data-ng-repeat="instance in filteredCount = (instanceList | filter: quickSearch  |orderBy:sort.column:sort.descending) " data-ng-class = "(instance.status != 'STOPPED' && instance.status != 'RUNNING' && instance.status != 'DESTROYED' && instance.status != 'ERROR')? 'overlay-wrapper-tr' : ''">

										<td><a class="text-info" id="instances_display_name_button" ui-sref="cloud.list-instance.view-instance({id: {{ instance.id}}})"
											title="View Instance">
										{{instance.displayName}}</a></td>
										<td>{{ instance.instanceOwner}}</td>
										<td class="custom-width-sm">{{ instance.application}}</td>
										<td class="custom-width-xs text-center"><img title="{{ instance.template}}"
											data-ng-show="instance.template.toLowerCase().indexOf('cent') > -1"
											src="images/os/centos_logo.png" alt="" height="25" width="25" class="m-r-5"
										> <img title="{{ instance.template}}"
											data-ng-show="instance.template.toLowerCase().indexOf('ubuntu') > -1"
											src="images/os/ubuntu_logo.png" alt="" height="25" width="25" class="m-r-5"
										> <img title="{{ instance.template}}"
											data-ng-show="instance.template.toLowerCase().indexOf('debian') > -1"
											src="images/os/debian_logo.png" alt="" height="25" width="25" class="m-r-5"
										> <img title="{{ instance.template}}"
											data-ng-show="instance.template.toLowerCase().indexOf('fedora') > -1"
											src="images/os/fedora_logo.png" alt="" height="25" width="25" class="m-r-5"
										> <img title="{{ instance.template}}"
											data-ng-show="instance.template.toLowerCase().indexOf('redhat') > -1"
											src="images/os/redhat_logo.png" alt="" height="25" width="25" class="m-r-5"
										> <img title="{{ instance.template}}"
											data-ng-show="instance.template.toLowerCase().indexOf('core') > -1" src="images/os/core_logo.png"
											alt="" height="25" width="25" class="m-r-5"
										> <img title="{{ instance.template}}"
											data-ng-show="instance.template.toLowerCase().indexOf('windows') > -1"
											src="images/os/windows_logo.png" alt="" height="25" width="25" class="m-r-5"
										>
										<br><span>{{instance.template}}</span>
										</td>
										<td class="custom-width-xs"><span>{{instance.cpuCore}}</span></td>
										<td class="custom-width-md"><span>{{instance.memory}}</span></td>
										<td class="custom-width-xs"><span data-ng-if="instance.volumeSize > 0">{{ instance.volumeSize / global.Math.pow(2, 30)}} GB</span><span data-ng-if="!(instance.volumeSize > 0)">-No Disk-</span></td>
										<!--                                         <td>{{volume[0].diskSize / global.Math.pow(2, 30)}}</td> -->
										<td>{{ instance.publicIpAddress}}</td>
										<td>{{ instance.ipAddress}}</td>
										<td>
										<div class="text-center">
										<img src="images/status/running.png" data-ng-if="instance.status == 'RUNNING'" title="{{ instance.status}}">
												<!-- <button class="btn btn-xs btn-success btn-circle" data-ng-if="instance.status == 'RUNNING'"
													title="{{ instance.status}}"
												></button> -->
												<img src="images/status/stopped.png" data-ng-if="instance.status == 'STOPPED'"
													title="{{ instance.status}}"
												>
												<img src="images/status/warning.png" data-ng-if="instance.status == 'STARTING'"
													title="{{ instance.status}}"
												>
												<img src="images/status/stopped.png" data-ng-if="instance.status == 'ERROR'"
													title="{{ instance.status}}"
												>
												<img src="images/status/warning.png" data-ng-if="instance.status == 'STOPPING'"
													title="{{ instance.status}}"
												>
												<img src="images/status/warning.png" data-ng-if="instance.status == 'EXPUNGING'"
													title="{{ instance.status}}"
												>
												<img src="images/status/stopped.png" data-ng-if="instance.status == 'DESTROYED'"
													title="{{ instance.status}}"
												>
												<img src="images/status/warning.png" data-ng-if="instance.status == 'MIGRATING'"
													title="{{ instance.status}}"
												>
		   							    </div>
		   							    </td>
		   							    <td>
		   							    <div class="loading-bar-tr"><img src="images/loading-bars.svg" title="{{instance.status}}" data-ng-if="(instance.status != 'STOPPED' && instance.status != 'RUNNING' && instance.status != 'DESTROYED' && instance.status != 'ERROR')" width="30" height="30" /></div>

										<div class="pointer-not">
													<div has-permission="START_VM"
														data-ng-if="instance.status != 'ERROR' || instance.status != 'EXPUNGING' || instance.status != 'STARTING' || instance.status != 'STOPPING' || instance.status != 'DESTROYING'  ">
													<a class="icon-button text-center test_instances_start_vm_button" id="instances_start_vm_button_{{instance.id}}" title="<fmt:message key="start" bundle="${msg}" />"
														data-ng-click="startVm('sm',instance)" data-ng-if="instance.status == 'STOPPED'"
													> <span class="fa fa-play m-xs"></span>
													</a></div>
													<div has-permission="STOP_VM"
														data-ng-if="instance.status != 'ERROR' || instance.status != 'EXPUNGING' || instance.status != 'STARTING' || instance.status != 'STOPPING' || instance.status != 'DESTROYING'  "
													><a class="icon-button text-center test_instances_stop_vm_button" id="instances_stop_vm_button_{{instance.id}}" data-ng-click="stopVm('sm',instance)"
														title="<fmt:message key="stop" bundle="${msg}" />" data-ng-if="instance.status  == 'RUNNING'"
													> <span class="fa fa-ban m-xs"></span>
													</a></div>
													<div has-permission="REBOOT_VM"
														data-ng-if="instance.status != 'ERROR' || instance.status != 'EXPUNGING' || instance.status != 'STARTING' || instance.status != 'STOPPING' || instance.status != 'DESTROYING'  "
													><a class="icon-button text-center test_instances_reboot_vm_button" id="instances_reboot_vm_button_{{instance.id}}" data-ng-if="instance.status == 'RUNNING'"
														title="<fmt:message key="restart" bundle="${msg}" />" data-ng-click="rebootVm('sm',instance)"
													><span class="fa fa-rotate-left m-xs"></span>  </a></div>
													<div has-permission="VIEW_CONSOLE" data-ng-if="instance.status == 'RUNNING'"><a
														data-ng-click="showConsole(instance)" id="instances_view_console_button_{{instance.id}}" class="icon-button text-center test_instances_view_console_button"
														title="<fmt:message key="view.console" bundle="${msg}" />"
													><span class="fa-desktop fa m-xs"></span>  </a></div>
													<div><a class="icon-button text-center test_instances_display_note_button" id="instances_display_note_button_{{instance.id}}" title="<fmt:message key="display.note" bundle="${msg}" />"
														data-ng-click="showDescription(instance)"
													><span class="fa-file-text fa m-xs"></span>  </a></div>
													<div has-permission="ADD_APPLICATION_TO_VM" data-ng-if="instance.application == null"><a class="icon-button text-center test_instances_add_application_button" id="instances_add_application_button_{{instance.id}}"
														title="<fmt:message key="instance.application.assign" bundle="${msg}" />"
														data-ng-click="addApplication(instance)"
													><span class="fa-plus fa m-xs"></span>
													</a></div>
										</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<pagination-content></pagination-content>
				</div>

			</div>
		</div>
	</div>
</div>