<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!-- This is content container for nested view in UI-Router-->

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
                           <span data-ng-if="state.data.pageTitle === 'common.departments'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="common.departments" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="common.departments" bundle="${msg}" /></span>
                            </span>
                            <span data-ng-if="state.data.pageTitle !== 'common.departments'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="common.departments" bundle="${msg}" /></a>
	                            <span ng-switch-when="true">{{ state.data.pageName }}</span>
	                    </span>
                        </li>
                    </ol>
                </div>
                    <span data-ng-if="$state.current.data.pageTitle === 'common.departments'"><fmt:message key="common.departments" bundle="${msg}" /></span>
                </h2>
                <small>{{ $state.current.data.pageDesc}}</small>
            </div>
        </div>
    </div>
    <div class="content">
        <div ui-view>
            <div class="row" data-ng-controller="departmentCtrl">

                <div class="col-md-12 col-sm-12">
                    <div class="hpanel">
                        <div class="panel-heading">

                            <div class="row">
                                <div class="col-md-12 col-sm-12 col-xs-12 ">
                                    <div class="pull-left">
                                        <div class="pull-left">

                                        </div>
                                    </div>
                                    <div class="pull-right">
                                        <panda-quick-search></panda-quick-search>
                                        <div class="clearfix"></div>

                                        <span class="pull-right m-l-sm m-t-sm">
                                            <a has-permission="ADD_DEPARTMENT" class="btn btn-info"  ng-click="createDepartment('md')"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span><fmt:message key="common.add" bundle="${msg}" /> </a>
                                            <a class="btn btn-info" ui-sref="department" title="<fmt:message key="common.refresh" bundle="${msg}" /> " ui-sref-opts="{reload: true}" ><span class="fa fa-refresh fa-lg"></span></a>
                                        </span>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>

                        </div>
                        <pagination-content></pagination-content>
                        <div class="white-content m-b-sm m-t-xs">

                         <div data-ng-show = "showLoader" style="margin: 1%">
    				  		<get-loader-image data-ng-show="showLoader"></get-loader-image>
      						</div>
                            <div data-ng-hide="showLoader" class="table-responsive">
                                <table cellspacing="1" cellpadding="1" class="table dataTable table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th class="col-md-2 col-sm-2"  data-ng-click="changeSorting('userName')" data-ng-class="sort.descending && sort.column =='userName'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.name" bundle="${msg}" /></th>
                                             <th class="col-md-2 col-sm-2"  data-ng-click="changeSorting('domain.name')" data-ng-class="sort.descending && sort.column =='domain.name'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.domain" bundle="${msg}" /></th> 
                                             <th class="col-md-2 col-sm-2"  data-ng-click="changeSorting('description')" data-ng-class="sort.descending && sort.column =='description'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.description" bundle="${msg}" /></th> 
                                            <th class="col-md-1 col-sm-1"><fmt:message key="common.action" bundle="${msg}" /> </th>
                                        </tr>
                                    </thead>
                                    <tbody data-ng-hide="departmentList.length > 0">
                                        <tr>
                                            <td class="col-md-6 col-sm-6" colspan="4"><fmt:message key="common.no.records.found" bundle="${msg}" />!!</td>
                                        </tr>
                                    </tbody>
                                    <tbody data-ng-show="departmentList.length > 0">
                                        <tr data-ng-repeat="department in filteredCount = (departmentList| filter:quickSearch | orderBy:sort.column:sort.descending)" >
											<td>
                                                {{ department.userName}}
                                            </td>
                                        	<td>
                                                {{ department.domain.name }}
                                            </td>
                                            <td>
                                                {{ department.description}}
                                            </td>
                                            <td>

                                                <a has-permission="EDIT_DEPARTMENT" class="icon-button" title="<fmt:message key="common.edit" bundle="${msg}" />" data-ng-click="edit('md', department)">
                                                    <span class="fa fa-edit"> </span>
                                                </a>
                                                 <a class="icon-button" ui-sref="department.quotalimit({id: {{department.id}}, quotaType: 'department-quota'})" title="<fmt:message key="common.edit.quota" bundle="${msg}" />">
                                                    <span class="fa font-bold pe-7s-edit"> </span>
                                                </a>
                                                <a has-permission="DELETE_DEPARTMENT" class="icon-button" title="<fmt:message key="common.delete" bundle="${msg}" />" data-ng-click="delete('sm', department)" ><span class="fa fa-trash"></span></a>

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
<div id="footer" ng-include="'app/views/common/footer.jsp'"></div>
</div>

