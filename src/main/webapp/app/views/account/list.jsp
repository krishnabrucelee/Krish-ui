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

                                </div>
                                <div class="pull-right">
                                    <panda-quick-search></panda-quick-search>
                                    <div class="clearfix"></div>
                                    <span class="pull-right m-l-sm m-t-sm">
                                        <a has-permission="CREATE_USER" class="btn btn-info" data-ng-click="addUser('lg')"><span class="pe-7s-add-user pe-lg font-bold m-r-xs"></span><fmt:message key="add.user" bundle="${msg}" /></a>
                                        <a has-permission="EDIT_USER" data-ng-class="oneChecked && edit ? 'btn btn-info' : 'btn btn-default disabled'" data-ng-disabled="!oneChecked"  data-ng-click="editUser('md')"><span class="fa fa-edit font-bold m-r-xs"></span><fmt:message key="edit.user" bundle="${msg}" /></a>
                                        <!-- <a data-ng-class="disabled && activate ? 'btn btn-info' : 'btn btn-default disabled'" data-ng-click="activating()"><span class="pe-7s-user pe-lg font-bold m-r-xs"></span>Activate User</a>
                                        <a data-ng-class="disabled && revoke ? 'btn btn-info' : 'btn btn-default disabled'" data-ng-click="revoking()" ><span class="pe-7s-delete-user pe-lg font-bold m-r-xs"></span>Revoke User</a> -->
                                        <a has-permission="DELETE_USER" data-ng-class="oneChecked && deletes ? 'btn btn-info' : 'btn btn-default disabled'" data-ng-disabled="!oneChecked" data-ng-click="deleteUser('sm')"><span class="pe-7s-trash pe-lg font-bold m-r-xs"></span><fmt:message key="delete.user" bundle="${msg}" /></a>
                                        <a class="btn btn-info " ui-sref="accounts" title="Refresh"  ui-sref-opts="{reload: true}"><span class="fa fa-refresh fa-lg "></span></a>
                                    </span>
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
                                                <th class="w-5"></th>

                                     	<th  data-ng-click="changeSort('userName',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='userName'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="user.name" bundle="${msg}" /></th>
                                     	<th  data-ng-click="changeSort('firstName',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='firstName'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="first.name" bundle="${msg}" /></th>
                                     	<th  data-ng-click="changeSort('type',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='type'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="user.type" bundle="${msg}" /></th>
                                     	<th  data-ng-click="changeSort('email',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='email'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.email" bundle="${msg}" /></th>
                                     	<th  data-ng-click="changeSort('userName',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='userName'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.status" bundle="${msg}" /></th>

                                        </tr>
                                        </thead>
                                        <tbody>
                                            <tr data-ng-repeat="account in filteredCount = (accountList| filter: quickSearch | orderBy:sort.column:sort.descending)">
                                                <td>
													<div class="radio radio-single radio-info">
														<input type="radio" value="{{account.id}}" data-ng-model="account.isSelected" id="acc_{{account.id}}" name = "accounts" data-ng-click="viewAccountd(account)"> <label></label>
													</div>
                                                </td>
                                                <td>
                                                    <a class="text-info"  data-ng-click="viewAccountd(account)">{{ account.userName}}</a>
                                               </td>
                                                <td>{{account.firstName}}</td>
                                                <td>{{account.type}}</td>
                                                <td>{{account.email}}</td>
                                                <td>
                                                    <label class="badge badge-success p-xs" data-ng-if="account.isActive == true"> Active </label>
                                                    <label class="badge badge-danger p-xs" data-ng-if="account.isActive == false"> Inactive </label>
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