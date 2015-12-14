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
									<div class="pull-left h-100"></div>
								</div>
								<div class="pull-right">
									<panda-quick-search></panda-quick-search>
									<div class="clearfix"></div>
									<span class="pull-right m-l-sm m-t-sm"> <a
										class="btn btn-info" data-ng-click="createProject('md')"><span
											class="pe-7s-plus pe-lg font-bold m-r-xs"></span><fmt:message key="create.project" bundle="${msg}" /></a> <a class="btn btn-info"
										data-ng-click="editProject('md')"
										data-ng-disabled="!oneChecked"><span
											class="fa fa-edit fa-lg m-r-xs"></span><fmt:message key="edit.project" bundle="${msg}" /></a>


											 <a
										class="btn btn-danger"
										data-ng-click="projectDeleteConfirmation('sm', project.totalCheckedCount)"
										data-ng-disabled="!oneChecked"><span
											class="fa fa-times-circle-o fa-lg m-r-xs"></span><fmt:message key="common.delete" bundle="${msg}" /></a>
									<a class="btn btn-info" ui-sref="projects" title="<fmt:message key="common.refresh" bundle="${msg}" />" ui-sref-opts="{reload: true}"><span
											class="fa fa-refresh fa-lg "></span></a>
									</span>
								</div>

							</div>
						</div>
						<div class="clearfix"></div>
					</div>
					<div class="row" >
						<div class="col-md-12 col-sm-12 col-xs-12 ">
						<pagination-content></pagination-content>
							<div class="white-content">
								<div class="table-responsive">
					<div data-ng-show = "showLoader" style="margin: 10%">
    				  <get-loader-image data-ng-show="showLoader"></get-loader-image>
      				</div>
									<table data-ng-hide="showLoader" cellspacing="1" cellpadding="1"
										class="table table-bordered table-striped">
										<thead>
											<tr>
												<th class="w-5"></th>
												<th><fmt:message key="common.name" bundle="${msg}" /></th>
												<th><fmt:message key="common.status" bundle="${msg}" /></th>
												<th><fmt:message key="project.owner" bundle="${msg}" /></th>
												<th><fmt:message key="billing.owner" bundle="${msg}" /></th>
												<th><fmt:message key="common.department" bundle="${msg}" /></th>
												<th><fmt:message key="create.time" bundle="${msg}" /></th>
												<th><fmt:message key="operation" bundle="${msg}" /></th>
											</tr>
										</thead>
										<tbody >
											<tr
												data-ng-repeat="projectObj in projectList| filter: quickSearch"
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
											<td><a
													data-ng-class="isSingle == projectObj.id  ? 'text-white' : ''"
													class="badge badge-info p-xs" ui-sref="dashboard">Enter
														Project</a>
														   <a class="icon-button" ui-sref="projects.quotalimit({id: {{projectObj.id}}, quotaType: 'project-quota'})" title="<fmt:message key="common.edit.quota" bundle="${msg}" />">
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