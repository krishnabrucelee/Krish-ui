<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
                             <span data-ng-if="state.data.pageTitle === 'common.accounts'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="common.accounts" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="common.accounts" bundle="${msg}" /></span>
                            </span>
                        </li>
                    </ol>
                </div>
                <h2 class="font-light m-b-xs">
                    <span data-ng-if="$state.current.data.pageTitle === 'common.accounts'"><fmt:message key="common.accounts" bundle="${msg}" /></span>
                </h2>
                <small>{{ $state.current.data.pageDesc}}</small>
            </div>
        </div>
    </div>
    <div class="content">
        <div ui-view>
            <div ng-controller="accountListCtrl">
                <div class="hpanel">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-md-12 col-sm-12 col-xs-12 ">
                                <div class="pull-left">
		                            <a has-permission="CREATE_USER" class="btn btn-info" data-ng-click="addUser('lg')"><span class="pe-7s-add-user pe-lg font-bold m-r-xs"></span><fmt:message key="common.add" bundle="${msg}" /></a>
                                    <a class="btn btn-info " ui-sref="accounts" title="Refresh"  ui-sref-opts="{reload: true}"><span class="fa fa-refresh fa-lg "></span></a>
                                </div>
                                <div class="pull-right">
                                    <panda-quick-search></panda-quick-search>
                                    <span class="pull-right m-r-sm" data-ng-show="global.sessionValues.type == 'ROOT_ADMIN'">
										<select
											class="form-control input-group col-xs-5" name="domainView"
											data-ng-model="domainView"
											data-ng-change="selectDomainView(1)"
											data-ng-options="domainView.name for domainView in accountElements.domainList">
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
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12 ">
                            <div class="white-content">
                               <div data-ng-show = "showLoader" style="margin: 1%">
    				  		<get-loader-image data-ng-show="showLoader"></get-loader-image>
      						</div>
      						<div  data-ng-hide="showLoader" class="table-responsive col-12-table">

                                    <table cellspacing="1" cellpadding="1" class="table table-bordered dataTable table-striped ">
                                        <thead>
                                        <tr>
                                        <th  data-ng-click="changeSorting('userName')" data-ng-class="sort.descending && sort.column =='userName'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="user.name" bundle="${msg}" /></th>
                                     	<th  data-ng-click="changeSorting('department.userName')" data-ng-class="sort.descending && sort.column =='department.userName'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.department" bundle="${msg}" /></th>
                                     	<th  data-ng-click="changeSorting('domain.name')" data-ng-class="sort.descending && sort.column =='domain.name'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.domain" bundle="${msg}" /></th>
                                     	<th  data-ng-click="changeSorting('type')" data-ng-class="sort.descending && sort.column =='type'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="user.type" bundle="${msg}" /></th>
                                     	<th  data-ng-click="changeSorting('email')" data-ng-class="sort.descending && sort.column =='email'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.email" bundle="${msg}" /></th>
                                     	<th  data-ng-click="changeSorting('isActive')" data-ng-class="sort.descending && sort.column =='isActive'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.status" bundle="${msg}" /></th>
										<th><fmt:message key="common.action" bundle="${msg}" /></th>
                                        </tr>
                                        </thead>
                                        <tbody data-ng-hide="accountList.length > 0">
		                                    <tr>
		                                        <td class="col-md-7 col-sm-7" colspan="7"><fmt:message key="common.no.records.found" bundle="${msg}" />!!</td>
		                                    </tr>
		                                </tbody>
                                        <tbody data-ng-show="accountList.length > 0">
                                            <tr data-ng-repeat="account in filteredCount = (accountList| filter: quickSearch | orderBy:sort.column:sort.descending)">
                                                <td>
                                                    <a class="text-info" >{{ account.userName}}</a>
                                               </td>
                                                <td>{{account.department.userName}}</td>
                                                <td>{{account.domain.name}}</td>
                                                <td>{{account.type}}</td>
                                                <td>{{account.email}}</td>
                                                <td>
                                                    <label class="badge badge-success p-xs" data-ng-if="account.isActive == true"> Active </label>
                                                    <label class="badge badge-danger p-xs" data-ng-if="account.isActive == false"> Inactive </label>
                                                </td>
                                                <td><a class="icon-button"
													has-permission="EDIT_USER"
													title="<fmt:message key="edit.user" bundle="${msg}" />"
													data-ng-click="editUser('md',account)">
														<span class="fa fa-edit m-r"> </span>
												</a>
												 <a
													class="icon-button" has-permission="DELETE_USER"
													title="<fmt:message key="common.delete" bundle="${msg}" /> "
													data-ng-click="deleteUser('sm',account)"><span
														class="fa fa-trash"></span></a></td>
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