<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<div ui-view ng-controller="networksCtrl">
	<div data-ng-hide="viewContent" data-ng-init="list(1)">
		<div class="hpanel">
			<div class="panel-heading no-padding">
				<div class="row">
					<div class="col-md-12 col-sm-12 col-xs-12 ">
						<div class="pull-left">
							<div class="dashboard-box pull-left">
								<div class="instance-border-content-normal">
									<span class="pull-left"><img
										src="images/network-icon.png"></span>
									<span class="pull-left m-t-xs m-l-xs m-r-xs"><fmt:message key="total.network"
											bundle="${msg}" /></span>
									 <b class="pull-left">{{networkList.Count}}</b>
									<div class="clearfix"></div>
								</div>
							</div>
							<div class="dashboard-box pull-left">
								<div class="instance-border-content-normal">
									<span class="pull-left"><img
										src="images/network-icon.png"></span>
									<span class="pull-left m-t-xs m-l-xs m-r-xs"><fmt:message
											key="isolated.network" bundle="${msg}" /></span>
									 <b class="pull-left">{{networkList.Count}}</b>
									<div class="clearfix"></div>
								</div>
							</div>
							<div class="dashboard-box pull-left">
								<div class="instance-border-content-normal">
									<span class="pull-left"><img
										src="images/network-icon.png"></span>
									<span class="pull-left m-t-xs m-l-xs m-r-xs"><fmt:message
											key="shared.network" bundle="${msg}" /></span>
									 <b class="pull-left">0</b>
									<div class="clearfix"></div>
								</div>
							</div>
							<a
								class="btn btn-info" has-permission="ADD_ISOLATED_NETWORK"
								data-ng-click="openAddIsolatedNetwork('md')"><span
									class="pe-7s-plus pe-lg font-bold m-r-xs"></span> <fmt:message
										key="add.isolated.network" bundle="${msg}" /></a> <a
								class="btn btn-info" ui-sref="cloud.list-network"
								title="<fmt:message key="common.refresh" bundle="${msg}" /> "
								ui-sref-opts="{reload: true}"><span
									class="fa fa-refresh fa-lg"></span></a>
						</div>
						<div class="pull-right">
							<panda-quick-search></panda-quick-search>
							<span class="pull-right m-r-sm">
									<select
										class="form-control input-group col-xs-5" name="networkView"
										data-ng-init="network.networkView = dropnetworkLists.views[0]"
										data-ng-model="network.networkView"
										data-ng-change="selectView(network.networkView.name)"
										data-ng-options="networkView.name for networkView in dropnetworkLists.views">
									</select>
							</span>
							<div class="clearfix"></div>
							<span class="pull-right m-l-sm m-t-sm">
							</span>
						</div>
					</div>
				</div>
				<div class="clearfix"></div>
			</div>
			<div class="row">
				<div class="col-md-12 col-sm-12 col-xs-12 ">
					<div class="white-content">
							<div
								data-ng-show="network.networkView.name == 'Guest Networks' || network.networkView.name == null">
								<div data-ng-show="showLoader" style="margin: 1%">
									<get-loader-image data-ng-show="showLoader"></get-loader-image>
								</div>
								<div data-ng-hide="showLoader"
									class="table-responsive col-12-table">
									<table cellspacing="1" cellpadding="1"
										class="table table-bordered dataTable table-striped">
										<thead>
											<tr>
												<th data-ng-click="changeSort('name',paginationObject.currentPage)"
													data-ng-class="sort.descending && sort.column =='name'? 'sorting_desc' : 'sorting_asc' "><fmt:message
														key="common.name" bundle="${msg}" /></th>
												<th data-ng-click="changeSort('department.userName',paginationObject.currentPage)"
													data-ng-class="sort.descending && sort.column =='Account'? 'sorting_desc' : 'sorting_asc' "><fmt:message
														key="common.account" bundle="${msg}" /></th>
												<th data-ng-click="changeSort('project.name',paginationObject.currentPage)"
													data-ng-class="sort.descending && sort.column =='project.name'? 'sorting_desc' : 'sorting_asc' "><fmt:message
														key="common.project" bundle="${msg}" /></th>
												<th data-ng-click="changeSort('networkType',paginationObject.currentPage)"
													data-ng-class="sort.descending && sort.column =='networkType'? 'sorting_desc' : 'sorting_asc' "><fmt:message
														key="common.type" bundle="${msg}" /></th>
												<th data-ng-click="changeSort('cIDR',paginationObject.currentPage)"
													data-ng-class="sort.descending && sort.column =='cIDR'? 'sorting_desc' : 'sorting_asc' "><fmt:message
														key="common.cidr" bundle="${msg}" /></th>
												<th data-ng-click="changeSort('gateway',paginationObject.currentPage)"
													data-ng-class="sort.descending && sort.column =='gateway'? 'sorting_desc' : 'sorting_asc' "><fmt:message
														key="gateway" bundle="${msg}" /></th>
												<th><fmt:message key="common.action" bundle="${msg}" /></th>
											</tr>
										</thead>
										<tbody>
											<tr
												data-ng-repeat="network in filteredCount = (networkList | filter: quickSearch | orderBy:sort.column:sort.descending)">
												<td><a class="text-info"
													ui-sref="cloud.list-network.view-network({id: {{ network.id }}, view: 'view'})"
													title="View Network">{{ network.name }}</a></td>
												<td>{{ network.department.userName || '-'}}</td>
												<td>{{ network.project.name || '-'}}</td>
												<td>{{ network.networkType }}</td>
												<td>{{ network.cIDR }}</td>
												<td>{{ network.gateway}}</td>
												<td><a class="icon-button"
													has-permission="EDIT_NETWORK"
													title="<fmt:message key="common.edit" bundle="${msg}" />"
													ui-sref="cloud.list-network.view-network({id: {{ network.id }}, view: 'edit'})">
														<span class="fa fa-edit m-r"> </span>
												</a> <a class="icon-button" has-permission="RESTART_NETWORK"
													title="<fmt:message key="common.restart" bundle="${msg}" /> "
													data-ng-click="restart('sm', network)"><span
														class="fa fa-rotate-left m-r"></span></a> <a
													class="icon-button" has-permission="DELETE_NETWORK"
													title="<fmt:message key="common.delete" bundle="${msg}" /> "
													data-ng-click="delete('sm', network)"><span
														class="fa fa-trash"></span></a></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<div data-ng-show="network.networkView.name == 'Security Groups'"
								data-ng-include
								src="'app/views/cloud/network/security-groups.jsp'"></div>

							<div data-ng-show="network.networkView.name == 'VPC'"
								data-ng-include src="'app/views/cloud/network/vpc.jsp'"></div>
							<div
								data-ng-show="network.networkView.name == 'VPN Customer Gateway'"
								data-ng-include src="'app/views/cloud/network/vpn.jsp'"></div>
						</div>
						<pagination-content></pagination-content>
					</div>

				</div>
			</div>
		</div>
	</div>
