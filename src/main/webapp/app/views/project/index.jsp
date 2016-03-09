<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!-- This is content container for nested view in UI-Router-->
<!-- You can put here any constant element in app content for example: Page title or breadcrum -->

<!-- Header -->
<div id="header" ng-include="'app/views/common/header.jsp'"></div>

<!-- Navigation -->
<aside id="menu" ng-include="'app/views/common/navigation.jsp'"></aside>

<!-- Main Wrapper -->
<div id="wrapper">
	<div small-header class="normalheader transition ng-scope small-header">
        <div class="hpanel" tour-step order="1" title="Page header" content="Place your page title and breadcrumb. Select small or large header or give the user choice to change the size." placement="bottom">
            <div class="panel-body">
                <div id="hbreadcrumb" class="pull-right">
                    <ol class="hbreadcrumb breadcrumb">
                        <li><a ui-sref="dashboard"><fmt:message key="common.home" bundle="${msg}" /></a></li>
                        <li ng-repeat="state in $state.$current.path" ng-switch="$last || !!state.abstract" ng-class="{active: $last}">
                           <span data-ng-if="state.data.pageTitle === 'common.projects'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="common.projects" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="common.projects" bundle="${msg}" /></span>
                            </span>
                            <span data-ng-if="state.data.pageTitle === 'quota.limit'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="quota.limit" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="quota.limit" bundle="${msg}" /></span>
                            </span>
                            <span data-ng-if="state.data.pageTitle === 'view.projects'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="view.projects" bundle="${msg}" /></a>
	                            <span ng-switch-when="true">{{ state.data.pageName }}</span>
	                    	</span>
                        </li>
                    </ol>
                </div>
                <h2 class="font-light m-b-xs">
                    <span data-ng-if="$state.current.data.pageTitle === 'common.projects'"><fmt:message key="common.projects" bundle="${msg}" /></span>
                </h2>
                <h2 class="font-light m-b-xs">
                    <span data-ng-if="$state.current.data.pageTitle === 'quota.limit'"><fmt:message key="quota.limit" bundle="${msg}" /></span>
                </h2>
                <small>{{ $state.current.data.pageDesc}}</small>
            </div>
        </div>
    </div>
	<div class="content">
		<div ui-view>
			<div ng-controller="projectCtrl">
				<div class="hpanel">
					<div class="panel-heading">
						<div class="row">
							<div class="col-md-12 col-sm-12 col-xs-12 ">
								<div class="pull-left">
									<div class="dashboard-box pull-left">
		     							<div class="instance-border-content-normal">
		                                <span class="pull-left m-t-xs m-l-xs m-r-xs"><fmt:message key="common.total" bundle="${msg}" /></span>
		                                <b class="pull-left">{{projectList.Count}}</b>
		                                <div class="clearfix"></div>
		                                </div>
		                            </div>
		                            <a has-permission="CREATE_PROJECT"
										class="btn btn-info" data-ng-click="createProject('md')"><span
											class="pe-7s-plus pe-lg font-bold m-r-xs"></span><fmt:message key="common.create" bundle="${msg}" /></a> <a has-permission="EDIT_PROJECT" class="btn btn-info"
										data-ng-click="editProject('md')"
										data-ng-disabled="!oneChecked"><span
											class="fa fa-edit fa-lg m-r-xs"></span><fmt:message key="common.edit" bundle="${msg}" /></a>
											 <a has-permission="DELETE_PROJECT"
										class="btn btn-danger"
										data-ng-click="projectDeleteConfirmation('sm', project.totalCheckedCount)"
										data-ng-disabled="!oneChecked"><span
											class="fa fa-times-circle-o fa-lg m-r-xs"></span><fmt:message key="common.delete" bundle="${msg}" /></a>
									    <a class="btn btn-info" ui-sref="projects" title="<fmt:message key="common.refresh" bundle="${msg}" />" ui-sref-opts="{reload: true}"><span
											class="fa fa-refresh fa-lg "></span></a>
								</div>
								<div class="pull-right">
									<panda-quick-search></panda-quick-search>
									<span class="pull-right m-r-sm" data-ng-show="global.sessionValues.type == 'ROOT_ADMIN'">
										<select
											class="form-control input-group col-xs-5" name="domainView"
											data-ng-model="domainView"
											data-ng-change="selectDomainView(1)"
											data-ng-options="domainView.name for domainView in formElements.domainList">
											<option value="">Select Domain</option>
										</select>
									</span>
									<div class="clearfix"></div>
									<span class="pull-right m-l-sm m-t-sm"></span>
								</div>
							</div>
						</div>
						<div class="clearfix"></div>
					</div>
					<div class="row" >
						<div class="col-md-12 col-sm-12 col-xs-12 ">
							<div class="table-responsive">
							<div class="white-content">
					<div data-ng-show = "showLoader" style="margin: 10%">
    				  <get-loader-image data-ng-show="showLoader"></get-loader-image>
      				</div>
									<table data-ng-hide="showLoader" cellspacing="1" cellpadding="1"
										class="table dataTable table-bordered table-striped">
										<thead>
											<tr>
												<th class="w-5"></th>
												<th ng-click="changeSort('name',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='name'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.name" bundle="${msg}" /></th>
												<th ng-click="changeSort('status',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='status'? 'sorting_desc' : 'sorting_asc' "><fmt:message key="common.status" bundle="${msg}" /></th>
												<th ng-click="changeSort('projectOwner.userName',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='projectOwner.userName'? 'sorting_desc' : 'sorting_asc' "><fmt:message key="project.owner" bundle="${msg}" /></th>
												<th ng-click="changeSort('projectOwner.userName',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='projectOwner.userName'? 'sorting_desc' : 'sorting_asc' "><fmt:message key="billing.owner" bundle="${msg}" /></th>
												<th ng-click="changeSort('department.userName',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='department.userName'? 'sorting_desc' : 'sorting_asc' "><fmt:message key="common.department" bundle="${msg}" /></th>
												<th ng-click="changeSort('createdDateTime',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='createdDateTime'? 'sorting_desc' : 'sorting_asc' "><fmt:message key="create.time" bundle="${msg}" /></th>
												<th><fmt:message key="common.action" bundle="${msg}" /></th>
											</tr>
										</thead>
									<tbody data-ng-hide="projectList.length > 0">
                                        <tr>
                                            <td class="col-md-11 col-sm-11" colspan="11"><fmt:message key="common.no.records.found" bundle="${msg}" />!!</td>
                                        </tr>
                                    </tbody>
                                    <tbody data-ng-show="projectList.length > 0">
											<tr
												data-ng-repeat="projectObj in filteredCount = (projectList| filter: quickSearch |orderBy:sort.column:sort.descending)"
												data-ng-class="isSingle === projectObj.id ? 'bg-row text-white' : ''">
												<td class="">
													<div class="radio radio-single radio-info">
														<input type="radio" value="{{projectObj.id}}"
															data-ng-model="isSingle"
															name = "projects" data-ng-click="viewProjectd(projectObj)"> <label></label>
													</div>
												</td>
												<td><a class="text-info" ui-sref="projects.view({id: {{ projectObj.id}}})"  title="View Instance" >{{ projectObj.name}}</a></td>
												<td><label class="badge badge-success p-xs" data-ng-show="projectObj.isActive"
													data-ng-class="isSingle === projectObj.id  ? 'text-white' : ''"
													class="text-success">Active</label> <label class="badge badge-danger p-xs"
													data-ng-hide="projectObj.isActive"
													data-ng-class="isSingle == projectObj.id  ? 'text-white' : ''"
													class="text-danger">In Active</label></td>
												<td>{{ projectObj.projectOwner.userName }}</td>
												<td>{{ projectObj.projectOwner.userName }}</td>
												<td>{{ projectObj.department.userName }}</td>
												<td>{{ projectObj.createdDateTime*1000 | date:'yyyy-MM-dd HH:mm:ss'}}</td>
												<td><a has-permission="PROJECT_RESOURCE_QUOTA_MODIFICATION" class="icon-button" ui-sref="projects.quotalimit({id: {{projectObj.id}}, quotaType: 'project-quota'})" title="<fmt:message key="common.edit.quota" bundle="${msg}" />">
                                                    <span class="fa font-bold pe-7s-edit"> </span>
                                                </a>
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
	</div>
<div id="footer" ng-include="'app/views/common/footer.jsp'"></div>
</div>