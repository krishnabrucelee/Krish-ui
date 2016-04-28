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
                    <span id="accounts_page_title" data-ng-if="$state.current.data.pageTitle === 'common.accounts'"><fmt:message key="common.accounts" bundle="${msg}" /></span>
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
                            <div class="pull-left dashboard-btn-area">
								<div class="dashboard-box pull-left">
	     							<div class="instance-border-content-normal">
	                                <span class="pull-left m-t-xs m-l-xs m-r-xs"><fmt:message key="common.total" bundle="${msg}" /></span>
	                                <b class="pull-left">{{accountList.Count}}</b>
	                                <div class="clearfix"></div>
	                                </div>
	                            </div>
	                            <div class="dashboard-box pull-left">
	                      			<div class="instance-border-content-normal">
	                                <span class="pull-left m-t-xs m-l-xs m-r-xs"><fmt:message key="common.active" bundle="${msg}" /></span>
	                                <b data-ng-show="global.sessionValues.type == 'ROOT_ADMIN'" class="pull-left">{{(activeUsers | filter:{status:'ENABLED', domainId:domainView.id}:true).length}}</b>
	                                <b data-ng-show="global.sessionValues.type != 'ROOT_ADMIN'" class="pull-left">{{(activeUsers | filter:{status:'ENABLED'}).length}}</b>
	                                <div class="clearfix"></div>
	                                </div>
	                            </div>
	                            <div class="dashboard-box pull-left">
	                                 <div class="instance-border-content-normal">
	                                <span class="pull-left m-t-xs m-l-xs m-r-xs"><fmt:message key="common.inactive" bundle="${msg}" /></span>
	                                <b data-ng-show="global.sessionValues.type == 'ROOT_ADMIN'" class="pull-left">{{(activeUsers | filter:{status:'DISABLED', domainId:domainView.id}:true).length}}</b>
	                                <b data-ng-show="global.sessionValues.type != 'ROOT_ADMIN'" class="pull-left">{{(activeUsers | filter:{status:'DISABLED'}).length}}</b>
	                                <div class="clearfix"></div>
	                                </div>
	                            </div>
	                            <a has-permission="CREATE_USER" id="accounts_add_button" class="btn btn-info font-bold" data-ng-click="addUser('lg')"><span class="pe-7s-add-user pe-lg font-bold m-r-xs"></span><fmt:message key="add.user" bundle="${msg}" /></a>
	                            <a class="btn btn-info " ui-sref="accounts" id="accounts_refresh_button" title="Refresh"  ui-sref-opts="{reload: true}"><span class="fa fa-refresh fa-lg "></span></a>
							</div>
                                <div class="pull-right dashboard-filters-area">
                                    <panda-quick-search></panda-quick-search>
                                    <span class="pull-right m-r-sm" data-ng-show="global.sessionValues.type == 'ROOT_ADMIN'">
										<select
											class="form-control input-group col-xs-5" name="domainView"
											data-ng-model="domainView" id = "accounts_domain_filter"
											data-ng-change="selectDomainView(1)"
											data-ng-options="domainView.name for domainView in accountElements.domainList">
											<option value=""> <fmt:message key="common.domain.filter" bundle="${msg}" /></option>
										</select>
		                    </span>

                                    <div class="clearfix"></div>
                                    <span class="pull-right m-l-sm m-t-sm"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" id="accounts_pagination_container">
                        <div class="col-md-12 col-sm-12 col-xs-12 ">
                            <div class="white-content">
                               <div data-ng-show = "showLoader" style="margin: 1%">
    				  		<get-loader-image data-ng-show="showLoader"></get-loader-image>
      						</div>
      						<div  data-ng-hide="showLoader" class="table-responsive">
                                    <table cellspacing="1" cellpadding="1" id="accounts_table" class="table table-bordered dataTable table-striped ">
                                        <thead>
                                        <tr>
                                        <th  data-ng-click="changeSort('userName',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='userName'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="user.name" bundle="${msg}" /></th>
                                     	<th  data-ng-click="changeSort('department.userName',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='department.userName'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.department" bundle="${msg}" /></th>
                                     	<th  data-ng-click="changeSort('domain.name',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='domain.name'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.domain" bundle="${msg}" /></th>
                                     	<th  data-ng-click="changeSort('type',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='type'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="user.type" bundle="${msg}" /></th>
                                       	<th><fmt:message key="common.roles" bundle="${msg}" /></th>
                                     	<th  data-ng-click="changeSort('email',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='email'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.email" bundle="${msg}" /></th>
                                     	<th  data-ng-click="changeSort('status',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='status'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.status" bundle="${msg}" /></th>
										<th><fmt:message key="common.action" bundle="${msg}" /></th>
                                        </tr>
                                        </thead>
                                        <tbody data-ng-hide="accountList.length > 0">
		                                    <tr>
		                                        <td class="col-md-7 col-sm-7" colspan="7"><fmt:message key="common.no.records.found" bundle="${msg}" />!!</td>
		                                    </tr>
		                                </tbody>
                                        <tbody data-ng-show="accountList.length > 0">
                                            <tr  data-ng-repeat="account in filteredCount = (accountList| filter: quickSearch | orderBy:sort.column:sort.descending)">
                                                <td>
                                                    <a class="text-info" >{{ account.userName}}</a>
                                               </td>
                                                <td>{{account.department.userName}}</td>
                                                <td>{{account.domain.name}}</td>
                                                <td>{{account.type}}</td>
                                                <td>{{account.role.name || '-'}}</td>
                                                <td>{{account.email || '-'}}</td>
                                                <td>
 												<label class="badge badge-success p-xs" data-ng-if="account.status == 'ENABLED'"> <fmt:message key="common.enabled" bundle="${msg}" /> </label>
                	                            <label class="badge badge-danger p-xs" data-ng-if="account.status == 'DISABLED'"> <fmt:message key="common.disabled" bundle="${msg}" /> </label>
                	                            <label class="badge badge-danger p-xs" data-ng-if="account.status == 'DELETED'"> <fmt:message key="common.deleted" bundle="${msg}" /> </label>

                                                </td>
                                                <td>
                                                <input type="hidden" id="accounts_unique_{{account.id}}" data-unique-field="{{account.domain.name}}-{{account.department.userName}}-{{ account.userName}}" class="test_accounts_unique">
                                                <a class="icon-button test_accounts_edit_user_button" id="accounts_edit_user_button_{{account.id}}" data-unique-field="{{account.domain.name}}-{{account.department.userName}}-{{ account.userName}}"
													has-permission="EDIT_USER"
													title="<fmt:message key="edit.user" bundle="${msg}" />"
													data-ng-click="editUser('md',account)">
														<span class="fa fa-edit m-r"> </span>
												</a>
												 <a class="icon-button test_accounts_reset_password_button" id="accounts_reset_password_button_{{account.id}}" data-unique-field="{{account.domain.name}}-{{account.department.userName}}-{{ account.userName}}" has-permission="RESET_USER_PASSWORD"
													title="<fmt:message key="reset.password" bundle="${msg}" /> "
													data-ng-click="resetPassword('md',account)"><span class="fa-key fa font-bold m-r"></span>
													</a>
												 <a data-ng-if="global.sessionValues.type =='DOMAIN_ADMIN'"
												 data-ng-hide = "global.sessionValues.type =='DOMAIN_ADMIN' && account.type == 'DOMAIN_ADMIN'"
													class="icon-button test_accounts_delete_user_button" id="accounts_delete_user_button_{{account.id}}" data-unique-field="{{account.domain.name}}-{{account.department.userName}}-{{ account.userName}}"
													has-permission="DELETE_USER"
													title="<fmt:message key="common.delete" bundle="${msg}" /> "
													data-ng-click="deleteUser('sm',account)"><span
														class="fa fa-trash"></span></a>

												 <a data-ng-if="global.sessionValues.type =='ROOT_ADMIN'"
												   data-ng-hide = "account.type == 'ROOT_ADMIN'"
												   id="accounts_delete_user_button_{{account.id}}" data-unique-field="{{account.domain.name}}-{{account.department.userName}}-{{ account.userName}}"
													class="icon-button test_accounts_delete_user_button" has-permission="DELETE_USER"
													title="<fmt:message key="common.delete" bundle="${msg}" /> "
													data-ng-click="deleteUser('sm',account)"><span
														class="fa fa-trash"></span></a>

												  <a data-ng-if="global.sessionValues.type =='USER' "
												   data-ng-hide = "account.type == 'DOMAIN_ADMIN' || global.sessionValues.userName == '{{account.userName}}'"
													class="icon-button test_accounts_delete_user_button"
													id="accounts_delete_user_button_{{account.id}}" data-unique-field="{{account.domain.name}}-{{account.department.userName}}-{{ account.userName}}"
													has-permission="DELETE_USER"
													title="<fmt:message key="common.delete" bundle="${msg}" /> "
													data-ng-click="deleteUser('sm',account)"><span
														class="fa fa-trash"></span>
												</a>
												 <a class = "test_accounts_enable_user_button"
												  id="accounts_enable_user_button_{{account.id}}" data-unique-field="{{account.domain.name}}-{{account.department.userName}}-{{ account.userName}}"
												  has-permission="ENABLE_USER" data-ng-show="account.status == 'DISABLED'" data-ng-click="activating(account)"><span class="pe-7s-user pe-lg font-bold m-r-xs" title="Enable User"></span></a>
                                        		 <a class = "test_accounts_disable_user_button"
                                        		  id="accounts_disable_user_button_{{account.id}}" data-unique-field="{{account.domain.name}}-{{account.department.userName}}-{{ account.userName}}"
                                        		  has-permission="DISABLE_USER" data-ng-show="account.status == 'ENABLED'" data-ng-click="revoking(account)" ><span class="pe-7s-delete-user pe-lg font-bold m-r-xs" title="Disable User"></span></a>
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