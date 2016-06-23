<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div ui-view ng-controller="networksCtrl">
	<div data-ng-hide="viewContent" data-ng-init="list(1)">
	<div data-ng-if="global.webSocketLoaders.networkLoader" class="overlay-wrapper">
 <get-show-loader-image data-ng-show="global.webSocketLoaders.networkLoader"></get-show-loader-image>
 </div>
		<div class="hpanel">
			<div class="panel-heading no-padding">
				<div class="row">
					<div class="col-md-12 col-sm-12 col-xs-12 ">
						<div class="pull-left dashboard-btn-area">
							<div class="dashboard-box pull-left">
								<div class="instance-border-content-normal">
									<span class="pull-left"><img
										src="images/network-icon.png"></span> <span
										class="pull-left m-t-xs m-l-xs m-r-xs"><fmt:message
											key="total.network" bundle="${msg}" /></span> <b class="pull-left">{{networkList.Count}}</b>
									<div class="clearfix"></div>
								</div>
							</div>
							<div class="dashboard-box pull-left">
								<div class="instance-border-content-normal">
									<span class="pull-left"><img
										src="images/network-icon.png"></span> <span
										class="pull-left m-t-xs m-l-xs m-r-xs"><fmt:message
											key="isolated.network" bundle="${msg}" /></span> <b
										class="pull-left">{{networkList.Count}}</b>
									<div class="clearfix"></div>
								</div>
							</div>
							<div class="dashboard-box pull-left">
								<div class="instance-border-content-normal">
									<span class="pull-left"><img
										src="images/network-icon.png"></span> <span
										class="pull-left m-t-xs m-l-xs m-r-xs"><fmt:message
											key="shared.network" bundle="${msg}" /></span> <b class="pull-left">0</b>
									<div class="clearfix"></div>
								</div>
							</div>
							<a class="btn btn-info font-bold" has-permission="ADD_ISOLATED_NETWORK"
								id="network_add_isolated_network_button"
								data-ng-click="openAddIsolatedNetwork('md')"><span
								class="pe-7s-plus pe-lg font-bold m-r-xs"></span> <fmt:message
									key="add.isolated.network" bundle="${msg}" /></a>
							<a class="btn btn-info" data-ng-click="list(1)"
								title="<fmt:message key="common.refresh" bundle="${msg}" /> "
								ui-sref-opts="{reload: true}"><span
								class="fa fa-refresh fa-lg"></span>
							</a>
							</div>

							<%-- <div class="pull-right dashboard-filters-area">
							<panda-quick-search></panda-quick-search>
							<span class="m-l-sm pull-right"
								data-ng-show="global.sessionValues.type == 'ROOT_ADMIN'">
								<select class="form-control input-group col-xs-5"
								name="domainView" data-ng-model="domainView"
								id="network_domain_filter"
								data-ng-change="selectDomainView(1, domainView.id)"
								data-ng-options="domainView.name for domainView in domainList">
									<option value=""> <fmt:message key="common.domain.filter" bundle="${msg}" /></option>
							</select>
							</span>
							</div> --%>
							<div class="pull-right dashboard-filters-area" id="instances_quick_search">
						<form data-ng-submit="searchList(vmSearch)">
							<div class="quick-search pull-right">
								<div class="input-group">
									<input data-ng-model="vmSearch" id="network_list_search" type="text" valid-characters class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />" aria-describedby="quicksearch-go">
								   	<span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
								</div>
							</div>
							<span class="pull-right m-r-sm" data-ng-show="global.sessionValues.type == 'ROOT_ADMIN'" >
								<select
									class="form-control input-group col-xs-5" name="domainView"
									data-ng-model="domainView"
									data-ng-change="selectDomainView(domainView)"
									data-ng-options="domainView.name for domainView in domainList">
									<option value=""> <fmt:message key="common.domain.filter" bundle="${msg}" /></option>
								</select>
							</span>
							<span class="pull-right m-r-sm" data-ng-show="global.sessionValues.type == 'DOMAIN_ADMIN'" >
								<select
									class="form-control input-group col-xs-5" name="departmentView"
									data-ng-model="departmentView"
									data-ng-change="selectDepartmentView(departmentView)"
									data-ng-options="departmentView.userName for departmentView in departmentLists">
									<option value=""> <fmt:message key="common.department.filter" bundle="${msg}" /></option>
								</select>
							</span>
							<span class="pull-right m-r-sm" data-ng-show="global.sessionValues.type == 'USER'" >
								<select
									class="form-control input-group col-xs-5" name="userView"
									data-ng-model="userView"
									data-ng-change="selectProjectView(userView)"
									data-ng-options="userView.name for userView in projectList">
									<option value=""> <fmt:message key="common.project.filter" bundle="${msg}" /></option>
								</select>
							</span>
							<div class="clearfix"></div>
							<span class="pull-right m-l-sm m-t-sm">
							</span>
						</form>
						</div>

						<div class="clearfix"></div>
					</div>
				</div>
				<div class="clearfix"></div>
			</div>
			<div class="row" id="network_pagination_container">
				<div class="col-md-12 col-sm-12 col-xs-12 " >
					<div class="white-content">

								<div data-ng-show="showLoader" style="margin: 1%">
									<get-loader-image data-ng-show="showLoader"></get-loader-image>
								</div>
								<div data-ng-hide="showLoader"
									class="table-responsive ">
									<table cellspacing="1" cellpadding="1" id="network_table"
										class="table table-bordered dataTable table-striped">
										<thead>
											<tr>
												<th data-ng-click="changeSort('name',paginationObject.currentPage)"
													data-ng-class="sort.descending && sort.column == 'name' ? 'sorting_desc' : 'sorting_asc' "><fmt:message
														key="common.name" bundle="${msg}" /></th>
												<th data-ng-click="changeSort('domainName',paginationObject.currentPage)"
													data-ng-class="sort.descending && sort.column =='domainName'? 'sorting_desc' : 'sorting_asc' "><fmt:message
														key="common.company" bundle="${msg}" /></th>
												<th data-ng-click="changeSort('departmentUserName',paginationObject.currentPage)"
													data-ng-class="sort.descending && sort.column =='departmentUserName'? 'sorting_desc' : 'sorting_asc' "><fmt:message
														key="common.department" bundle="${msg}" /></th>
												<th data-ng-click="changeSort('projectName',paginationObject.currentPage)"
													data-ng-class="sort.descending && sort.column =='projectName'? 'sorting_desc' : 'sorting_asc' "><fmt:message key="common.project" bundle="${msg}" /></th>
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
										<tbody data-ng-hide="networkList.length > 0">
			                                <tr>
			                                    <td class="col-md-9 col-sm-9" colspan="9"><fmt:message key="common.no.records.found" bundle="${msg}" />!!</td>
			                                </tr>
			                            </tbody>
			                            <tbody data-ng-show="networkList.length > 0">
											<tr
												data-ng-repeat="network in filteredCount = networkList">
												<td><a class="text-info"
													ui-sref="cloud.list-network.view-network({id: {{ network.id }}, view: 'view'})"
													title="View Network">{{ network.name }}</a></td>
											    <td>{{ network.domainName }}</td>
												<td>{{ network.departmentUserName || '-'}}</td>
												<td>{{ network.projectName || '-'}}</td>
												<td>{{ network.networkType }}</td>
												<td>{{ network.cIDR }}</td>
												<td>{{ network.gateway}}</td>
												<td>
												<input type="hidden" id="network_unique_{{network.id}}" data-unique-field="{{network.domainName}}-{{network.departmentUserName}}-{{network.name}}" class="test_network_unique">
												<a class="icon-button test_network_edit_button" id="network_edit_button_{{network.id}}"
												    data-unique-field="{{network.domainName}}-{{network.departmentUserName}}-{{network.name}}"
													has-permission="EDIT_NETWORK"
													title="<fmt:message key="common.edit" bundle="${msg}" />"
													ui-sref="cloud.list-network.view-network({id: {{ network.id }}, view: 'edit'})">
														<span class="fa fa-edit m-r"> </span>
												</a> <a class="icon-button test_network_restart_button" id="network_restart_button_{{network.id}}"
												    data-unique-field="{{network.domainName}}-{{network.departmentUserName}}-{{network.name}}"
												    has-permission="RESTART_NETWORK"
													title="<fmt:message key="common.restart" bundle="${msg}" /> "
													data-ng-click="restart('sm', network.id)"><span
														class="fa fa-rotate-left m-r"></span></a> <a
													class="icon-button test_network_delete_button" id="network_delete_button_{{network.id}}"
													data-unique-field="{{network.domainName}}-{{network.departmentUserName}}-{{network.name}}"
													has-permission="DELETE_NETWORK"
													title="<fmt:message key="common.delete" bundle="${msg}" /> "
													data-ng-click="delete('sm', network.id)"><span
														class="fa fa-trash"></span></a></td>
											</tr>
										</tbody>
									</table>
							</div><!--
							<div data-ng-show="network.networkView.name == 'Security Groups'"
								data-ng-include
								src="'app/views/cloud/network/security-groups.jsp'"></div>

							<div data-ng-show="network.networkView.name == 'VPC'"
								data-ng-include src="'app/views/cloud/network/vpc.jsp'"></div>
							<div
								data-ng-show="network.networkView.name == 'VPN Customer Gateway'"
								data-ng-include src="'app/views/cloud/network/vpn.jsp'"></div> -->
						</div>
						<pagination-content></pagination-content>
					</div>

				</div>
			</div>
		</div>
	</div>
