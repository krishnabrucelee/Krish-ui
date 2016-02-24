<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<div ui-view>
	<div data-ng-hide="viewContent" ng-controller="instanceListCtrl">
		<div class="hpanel">
			<div class="panel-heading">
				<div class="row">
					<div class="col-md-12 col-sm-12 col-xs-12 ">
						<div class="pull-left">
							<div class="dashboard-box pull-left" data-ng-click="list(1, 'Expunging')">
								<div class="instance-border-content-normal"
									data-ng-class="{'instance-border-content' : borderContent=='Expunging'}"
								>
									<span class="pull-right"><fmt:message key="total.instance" bundle="${msg}" /></span>
									<div class="clearfix"></div>
									<span class="pull-left m-t-xs"><img src="images/instance-icon.png"></span> <b class="pull-right">{{totalCount}}</b>
									<div class="clearfix"></div>
								</div>
							</div>
							<div class="dashboard-box pull-left" data-ng-click="list(1, 'Running')">
								<div class="instance-border-content-normal"
									data-ng-class="{'instance-border-content' : borderContent=='Running'}"
								>
									<span class="pull-right"><fmt:message key="running.instance" bundle="${msg}" /></span>
									<div class="clearfix"></div>
									<span class="pull-left m-t-xs"><img src="images/instance-icon.png"></span> <b class="pull-right">{{runningVmCount}}</b>
									<div class="clearfix"></div>
								</div>
							</div>
							<div class="dashboard-box pull-left" data-ng-click="list(1, 'Stopped')">
								<div class="instance-border-content-normal"
									data-ng-class="{'instance-border-content' : borderContent=='Stopped'}"
								>
									<span class="pull-right"><fmt:message key="stopped.instance" bundle="${msg}" /></span>
									<div class="clearfix"></div>
									<span class="pull-left m-t-xs"><img src="images/instance-icon.png"></span> <b class="pull-right">{{stoppedVmCount}}</b>
									<div class="clearfix"></div>
								</div>
							</div>
						</div>
						<div class="pull-right">
							<panda-quick-search></panda-quick-search>
							<div class="clearfix"></div>
							<span class="pull-right m-l-sm m-t-sm"> <a has-permission="CREATE_VM" class="btn btn-info"
								data-ng-click="openAddInstance('lg')"
							><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span>
								<fmt:message key="create.vm" bundle="${msg}" /></a> <a class="btn btn-info" data-ng-click="list(1, borderContent)"
								title="<fmt:message key="common.refresh" bundle="${msg}" />" ui-sref-opts="{reload: true}"
							><span class="fa fa-refresh fa-lg "></span></a>
							</span>
						</div>
					</div>
				</div>
				<div class="clearfix"></div>
			</div>
			<div class="row">
				<div class="col-md-12 col-sm-12 col-xs-12 ">
					<div class="white-content">
						<div data-ng-show="showLoader" style="margin: 1%">
							<get-loader-image data-ng-show="showLoader"></get-loader-image>
						</div>
						<div data-ng-hide="showLoader" class="table-responsive col-12-table">
							<table cellspacing="1" cellpadding="1" class="table dataTable table-bordered table-striped ">
								<thead>
									<tr>
										<th ng-click="changeSorting('name')" data-ng-class="sort.descending && sort.column =='name'? 'sorting_desc' : 'sorting_asc' ">
										<fmt:message key="instance.name" bundle="${msg}" /></th>
										<th ng-click="changeSorting('instanceOwner.userName')" data-ng-class="sort.descending && sort.column =='instanceOwner.userName'? 'sorting_desc' : 'sorting_asc' ">
										<fmt:message key="owner" bundle="${msg}" /></th>
										<th class="custom-width-sm" ng-click="changeSorting('application')"
											data-ng-class="sort.descending && sort.column =='application'? 'sorting_desc' : 'sorting_asc' ">
										<fmt:message key="common.application" bundle="${msg}" /></th>
										<th class="custom-width-sm" ng-click="changeSorting('ostype')"
											data-ng-class="sort.descending && sort.column =='ostype'? 'sorting_desc' : 'sorting_asc' ">
										<fmt:message key="common.osType" bundle="${msg}" /></th>
										<th class="custom-width-xs" ng-click="changeSorting('computeOffering.numberOfCores')"
											data-ng-class="sort.descending && sort.column =='computeOffering.numberOfCores'? 'sorting_desc' : 'sorting_asc' ">
										<fmt:message key="vcpu" bundle="${msg}" /></th>
										<th class="custom-width-md" ng-click="changeSorting('computeOffering.memory')"
											data-ng-class="sort.descending && sort.column =='computeOffering.memory'? 'sorting_desc' : 'sorting_asc' ">
										<fmt:message key="memory" bundle="${msg}" /></th>
										<th class="custom-width-xs" ng-click="changeSorting('volumeSize')"
											data-ng-class="sort.descending && sort.column =='volumeSize'? 'sorting_desc' : 'sorting_asc' ">
										<fmt:message key="disk" bundle="${msg}" /></th>
										<th ng-click="changeSorting('ipAddress')"
											data-ng-class="sort.descending && sort.column =='ipAddress'? 'sorting_desc' : 'sorting_asc' ">
										<fmt:message key="common.ip" bundle="${msg}" /></th>
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
										data-ng-repeat="instance in filteredCount = (instanceList | filter: quickSearch  |orderBy:sort.column:sort.descending) track by $index">

										<td><a class="text-info" ui-sref="cloud.list-instance.view-instance({id: {{ instance.id}}})"
											title="View Instance">
										{{ instance.name}}</a></td>
										<td>{{ instance.instanceOwner.userName}}</td>
										<td class="custom-width-sm">{{ instance.application}}</td>
										<td class="custom-width-xs"><img title="{{ instance.template.osType.description}}"
											data-ng-show="instance.template.displayText.toLowerCase().indexOf('cent') > -1"
											src="images/os/centos_logo.png" alt="" height="25" width="25" class="m-r-5"
										> <img title="{{ instance.template.osType.description}}"
											data-ng-show="instance.template.displayText.toLowerCase().indexOf('ubuntu') > -1"
											src="images/os/ubuntu_logo.png" alt="" height="25" width="25" class="m-r-5"
										> <img title="{{ instance.template.osType.description}}"
											data-ng-show="instance.template.displayText.toLowerCase().indexOf('debian') > -1"
											src="images/os/debian_logo.png" alt="" height="25" width="25" class="m-r-5"
										> <img title="{{ instance.template.osType.description}}"
											data-ng-show="instance.template.displayText.toLowerCase().indexOf('fedora') > -1"
											src="images/os/fedora_logo.png" alt="" height="25" width="25" class="m-r-5"
										> <img title="{{ instance.template.osType.description}}"
											data-ng-show="instance.template.displayText.toLowerCase().indexOf('redhat') > -1"
											src="images/os/redhat_logo.png" alt="" height="25" width="25" class="m-r-5"
										> <img title="{{ instance.template.osType.description}}"
											data-ng-show="instance.template.displayText.toLowerCase().indexOf('core') > -1" src="images/os/core_logo.png"
											alt="" height="25" width="25" class="m-r-5"
										> <img title="{{ instance.template.osType.description}}"
											data-ng-show="instance.template.displayText.toLowerCase().indexOf('windows') > -1"
											src="images/os/windows_logo.png" alt="" height="25" width="25" class="m-r-5"
										></td>
										<td class="custom-width-xs"><span data-ng-if="!instance.computeOffering.customized">{{ instance.computeOffering.numberOfCores}}</span><span data-ng-if="instance.computeOffering.customized">{{ instance.cpuCore}}</span></td>
										<td class="custom-width-md"><span data-ng-if="!instance.computeOffering.customized">{{ instance.computeOffering.memory}}</span><span data-ng-if="instance.computeOffering.customized">{{ instance.memory}}</span></td>
										<td class="custom-width-xs"><span data-ng-if="instance.volumeSize > 0">{{ instance.volumeSize / global.Math.pow(2, 30)}} GB</span><span data-ng-if="!(instance.volumeSize > 0)">-No Disk-</span></td>
										<!--                                         <td>{{volume[0].diskSize / global.Math.pow(2, 30)}}</td> -->
										<td>{{ instance.ipAddress}}</td>
										<td>
										<div class="pull-left ">
												<button class="btn btn-xs btn-success btn-circle" data-ng-if="instance.status == 'RUNNING'"
													title="{{ instance.status}}"
												></button>
												<button class="btn btn-xs btn-danger btn-circle" data-ng-if="instance.status == 'STOPPED'"
													title="{{ instance.status}}"
												></button>
												<button class="btn btn-xs btn-warning btn-circle" data-ng-if="instance.status == 'STARTING'"
													title="{{ instance.status}}"
												></button>
												<button class="btn btn-xs btn-danger btn-circle" data-ng-if="instance.status == 'ERROR'"
													title="{{ instance.status}}"
												></button>
												<button class="btn btn-xs btn-warning btn-circle" data-ng-if="instance.status == 'STOPPING'"
													title="{{ instance.status}}"
												>&nbsp</button>
												<button class="btn btn-xs btn-warning btn-circle" data-ng-if="instance.status == 'EXPUNGING'"
													title="{{ instance.status}}"
												></button>
												<button class="btn btn-xs btn-danger btn-circle" data-ng-if="instance.status == 'DESTROYED'"
													title="{{ instance.status}}"
												></button>
												<button class="btn btn-xs btn-warning btn-circle" data-ng-if="instance.status == 'MIGRATING'"
													title="{{ instance.status}}"
												></button>
		   							    </div>
										<div class="">
													<div has-permission="START_VM"
														data-ng-if="instance.status != 'ERROR' || instance.status != 'EXPUNGING' || instance.status != 'STARTING' || instance.status != 'STOPPING' || instance.status != 'DESTROYING'  ">
													<a class="icon-button text-center" title="<fmt:message key="start" bundle="${msg}" />"
														data-ng-click="startVm('sm',instance)" data-ng-if="instance.status == 'STOPPED'"
													> <span class="fa fa-play m-xs"></span>
													</a></div>
													<div has-permission="STOP_VM"
														data-ng-if="instance.status != 'ERROR' || instance.status != 'EXPUNGING' || instance.status != 'STARTING' || instance.status != 'STOPPING' || instance.status != 'DESTROYING'  "
													><a class="icon-button text-center" data-ng-click="stopVm('sm',instance)"
														title="<fmt:message key="stop" bundle="${msg}" />" data-ng-if="instance.status  == 'RUNNING'"
													> <span class="fa fa-ban m-xs"></span>
													</a></div>
													<div has-permission="REBOOT_VM"
														data-ng-if="instance.status != 'ERROR' || instance.status != 'EXPUNGING' || instance.status != 'STARTING' || instance.status != 'STOPPING' || instance.status != 'DESTROYING'  "
													><a class="icon-button text-center" data-ng-if="instance.status == 'RUNNING'"
														title="<fmt:message key="restart" bundle="${msg}" />" data-ng-click="rebootVm('sm',instance)"
													><span class="fa fa-rotate-left m-xs"></span>  </a></div>
													<div has-permission="VIEW_CONSOLE" data-ng-if="instance.status == 'RUNNING'"><a
														data-ng-click="showConsole(instance)" class="icon-button text-center"
														title="<fmt:message key="view.console" bundle="${msg}" />"
													><span class="fa-desktop fa m-xs"></span>  </a></div>
													<div><a class="icon-button text-center" title="<fmt:message key="display.note" bundle="${msg}" />"
														data-ng-click="showDescription(instance)"
													><span class="fa-file-text fa m-xs"></span>  </a></div>
													<div data-ng-if="instance.application == null"><a class="icon-button text-center"
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