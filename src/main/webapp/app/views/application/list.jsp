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
        <div class="hpanel" tour-step order="1" content="Place your page title and breadcrumb. Select small or large header or give the user choice to change the size." placement="bottom">
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
                    <span id="applications_page_title" data-ng-if="$state.current.data.pageTitle === 'common.applications'"><fmt:message key="common.applications" bundle="${msg}" /></span>
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
								<div class="pull-left dashboard-btn-area">
									<div class="dashboard-box pull-left">
		     							<div class="instance-border-content-normal">
		                                <span class="pull-left m-t-xs m-l-xs m-r-xs"><fmt:message key="common.total" bundle="${msg}" /></span>
		                                <b class="pull-left">{{applicationList.Count}}</b>
		                                <div class="clearfix"></div>
		                                </div>
	                            	</div>
	                            	<a has-permission="CREATE_APPLICATION_TYPE" id="applications_add_button" class="btn btn-info" ng-click="createApplication('md')"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span>
									<fmt:message key="common.add" bundle="${msg}" /></a> <a class="btn btn-info" ui-sref="applications" title="<fmt:message key="common.refresh" bundle="${msg}" />" ui-sref-opts="{reload: true}">
									<span class="fa fa-refresh fa-lg"></span></a>
								</div>
								<div class="pull-right dashboard-filters-area">
									<panda-quick-search></panda-quick-search>
									<span class="pull-right m-r-sm" data-ng-show="global.sessionValues.type == 'ROOT_ADMIN'">
										<select
											class="form-control input-group col-xs-5" name="domainView"
											data-ng-model="domainView"
											data-ng-change="selectDomainView(1)"
											data-ng-options="domainView.name for domainView in formElements.domainList">
											<option value=""> <fmt:message key="common.domain.filter" bundle="${msg}" /></option>
										</select>
									</span>
									<div class="clearfix"></div>
									<span class="pull-right m-l-sm m-t-sm"></span>
								</div>
							</div>
							<div class="clearfix"></div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12 col-sm-12 col-xs-12 " id="applications_pagination_container">

							<div data-ng-show = "showLoader" style="margin: 1%">
    				  		<get-loader-image data-ng-show="showLoader"></get-loader-image>
      						</div>
								<div data-ng-hide="showLoader" class="table-responsive">
									<div class="white-content">
									<table cellspacing="1" cellpadding="1" id="applications_table"
										class="table table-bordered dataTable table-striped">
										<thead>
											<tr>
												<th class="col-md-2 col-sm-2"  data-ng-click="changeSort('type',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='type'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.type" bundle="${msg}" /></th>
												<th class="col-md-2 col-sm-2"  data-ng-click="changeSort('domain.name',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='domain.name'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.domain" bundle="${msg}" /></th>
												<th class="col-md-2 col-sm-2"  data-ng-click="changeSort('description',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='description'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.description" bundle="${msg}" /></th>
												<th class="col-md-2 col-sm-2"  data-ng-click="changeSort('status',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='status'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.status" bundle="${msg}" /></th>
												<th class="col-md-1 col-sm-2"><fmt:message key="common.action" bundle="${msg}" /></th>
											</tr>
										</thead>
										<tbody data-ng-hide="applicationList.length > 0">
		                                    <tr>
		                                        <td class="col-md-5 col-sm-5" colspan="5"><fmt:message key="common.no.records.found" bundle="${msg}" />!!</td>
		                                    </tr>
		                                </tbody>
										<tbody data-ng-show="applicationList.length > 0">
											<tr data-ng-repeat=" application in filteredCount = (applicationList| filter: quickSearch | orderBy:sort.column:sort.descending)">

												<td>{{ application.type}}</td>
                                                                                                <td>{{ application.domain.name }}</td>
												<td>{{ application.description}}</td>
												<td>
		                                        	                                  <label class="badge badge-success p-xs" data-ng-if="application.status == 'ENABLED'"> {{ application.status}} </label>
		                                                                                  <label class="badge badge-danger p-xs" data-ng-if="application.status == 'DISABLED'"> {{ application.status}} </label>
		                                                                                </td>
												<td>
												<input type="hidden" id="applications_unique_{{application.id}}"  data-unique-field="{{ application.domain.name }}-{{ application.type}}" class="test_applications_unique">
												<a has-permission="EDIT_APPLICATION_TYPE" id="applications_edit_button_{{application.id}}" class="icon-button test_applications_edit_button" title="<fmt:message key="common.edit" bundle="${msg}" />" data-ng-click="edit('md', application)"> <span class="fa fa-edit"></span></a>
												<a has-permission="DELETE_APPLICATION_TYPE" id="applications_delete_button_{{application.id}}" class="icon-button test_applications_delete_button" title="<fmt:message key="common.delete" bundle="${msg}" />" data-ng-click="delete('sm', application)"><span class="fa fa-trash"></span></a>
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