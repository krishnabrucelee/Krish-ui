<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- This is content container for nested view in UI-Router-->
<!-- You can put here any constant element in app content for example: Page title or breadcrum -->

<!-- Header -->
<ng-include id="header" src="global.getViewPageUrl('common/header.jsp')"></ng-include>

<!-- Navigation -->
<ng-include id="menu" src="global.getViewPageUrl('common/navigation.jsp')"></ng-include>

<!-- Main Wrapper -->
<div id="wrapper">
	<div small-header class="normalheader transition ng-scope small-header">
        <div class="hpanel" tour-step order="1" title="Page header" content="Place your page title and breadcrumb. Select small or large header or give the user choice to change the size." placement="bottom">
            <div class="panel-body">
                <div id="hbreadcrumb" class="pull-right">
                    <ol class="hbreadcrumb breadcrumb">
                        <li><a ui-sref="dashboard"><fmt:message key="common.home" bundle="${msg}" /></a></li>
                        <li ng-repeat="state in $state.$current.path" ng-switch="$last || !!state.abstract" ng-class="{active: $last}">
                            <span data-ng-if="state.data.pageTitle === 'common.applications'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="common.applications" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="common.applications" bundle="${msg}" /></span>
                            </span>
                        </li>
                    </ol>
                </div>
                <h2 class="font-light m-b-xs">
                    <span data-ng-if="$state.current.data.pageTitle === 'common.applications'"><fmt:message key="common.applications" bundle="${msg}" /></span>
                </h2>
                <small>{{ $state.current.data.pageDesc}}</small>
            </div>
        </div>
    </div>
	<div class="content">
		<div ui-view>
			<div ng-controller="applicationListCtrl">
				<div class="hpanel">
					<div class="panel-heading">
						<div class="row">
							<div class="col-md-12 col-sm-12 col-xs-12 ">
								<div class="pull-left">
									<div class="pull-left"></div>
								</div>
								<div class="pull-right">
									<div class="quick-search">
										<div class="input-group">
											<input data-ng-model="applicationSearch" type="text" class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />" aria-describedby="quicksearch-go">
											 <span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
										</div>
									</div>
									<span class="pull-right m-l-sm m-t-sm">
									<a has-permission="CREATE_APPLICATION_TYPE" class="btn btn-info" ng-click="createApplication('md')"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span>
									<fmt:message key="common.add" bundle="${msg}" /></a> <a class="btn btn-info" ui-sref="applications" title="<fmt:message key="common.refresh" bundle="${msg}" />" ui-sref-opts="{reload: true}">
									<span class="fa fa-refresh fa-lg"></span></a>
									</span>
								</div>
							</div>
							<div class="clearfix"></div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12 col-sm-12 col-xs-12 ">
						<pagination-content></pagination-content>
							<div class="white-content">
							<div data-ng-show = "showLoader" style="margin: 1%">
    				  		<get-loader-image data-ng-show="showLoader"></get-loader-image>
      						</div>
								<div data-ng-hide="showLoader" class="table-responsive">
									<table cellspacing="1" cellpadding="1"
										class="table table-bordered table-striped">
										<thead>
											<tr>
											    <th class="col-md-2 col-sm-2"><fmt:message key="common.domain" bundle="${msg}" /> </th>
												<th class="col-md-2 col-sm-3"><fmt:message key="common.type" bundle="${msg}" /></th>
												<th class="col-md-4 col-sm-5"><fmt:message key="common.description" bundle="${msg}" /></th>
												<th class="col-md-1 col-sm-2"><fmt:message key="common.status" bundle="${msg}" /></th>
												<th class="col-md-1 col-sm-2"><fmt:message key="common.action" bundle="${msg}" /></th>
											</tr>
										</thead>
										<tbody>
											<tr data-ng-repeat=" application in applicationList| filter: applicationSearch">
												<td>{{ application.domain.name }}</td>
												<td>{{ application.type}}</td>
												<td>{{ application.description}}</td>
												<td>{{ application.status}}</td>
												<td><a has-permission="EDIT_APPLICATION_TYPE" class="icon-button" title="<fmt:message key="common.edit" bundle="${msg}" />" data-ng-click="edit('md', application)"> <span class="fa fa-edit"></span></a>
												<a has-permission="EDIT_APPLICATION_TYPE" class="icon-button" title="<fmt:message key="common.delete" bundle="${msg}" />" data-ng-click="delete('sm', application)"><span class="fa fa-trash"></span></a>
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
</div>