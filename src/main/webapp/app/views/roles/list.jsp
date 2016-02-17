<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
        <div class="hpanel" tour-step order="1" content="Place your page title and breadcrumb. Select small or large header or give the user choice to change the size." placement="bottom">
            <div class="panel-body">
                <div id="hbreadcrumb" class="pull-right">
                    <ol class="hbreadcrumb breadcrumb">
                        <li><a ui-sref="dashboard"><fmt:message key="common.home" bundle="${msg}" /></a></li>
                        <li ng-repeat="state in $state.$current.path" ng-switch="$last || !!state.abstract" ng-class="{active: $last}">
                            <span data-ng-if="state.data.pageTitle === 'common.roles'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="common.roles" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="common.roles" bundle="${msg}" /></span>
                            </span>
                             <span data-ng-if="state.data.pageTitle === 'add.role'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="add.role" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="add.role" bundle="${msg}" /></span>
                            </span>
                            <span data-ng-if="state.data.pageTitle === 'edit.role'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="edit.role" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="edit.role" bundle="${msg}" /></span>
                            </span>
                        </li>
                    </ol>
                </div>
                <h2 class="font-light m-b-xs">
                    <span id="roles_page_title" data-ng-if="$state.current.data.pageTitle === 'common.roles'"><fmt:message key="common.roles" bundle="${msg}" /></span>
                </h2>
                 <h2 class="font-light m-b-xs">
                    <span id="edit_role_page_title" data-ng-if="$state.current.data.pageTitle === 'edit.role'"><fmt:message key="edit.role" bundle="${msg}" /></span>
                </h2>
                <h2 class="font-light m-b-xs">
                    <span id="add_role_page_title" data-ng-if="$state.current.data.pageTitle === 'add.role'"><fmt:message key="add.role" bundle="${msg}" /></span>
                </h2>
                <small>{{ $state.current.data.pageDesc}}</small>
            </div>
        </div>
    </div>
    <div class="content">
        <div ui-view >
            <div class="hpanel" ng-controller="rolesListCtrl">
                <div class="panel-heading">
                    <div class="row" >
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="pull-left">
                            <div class="pull-left"></div>
                            </div>
                            <div class="pull-right">
                                <panda-quick-search></panda-quick-search>
                                <div class="clearfix"></div>
                                <span class="pull-right m-l-sm m-t-sm m-b-sm">
                                	<a class="btn btn-info" id="roles_assign_user_role_button" has-permission="ASSIGN_ROLE" data-ng-click="assignRole('lg')"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span><fmt:message key="assign.user.role" bundle="${msg}" /></a>
                                    <a class="btn btn-info" id="roles_add_role_button" has-permission="CREATE_ROLE"  ui-sref="roles.list-add"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span><fmt:message key="add.role" bundle="${msg}" /></a>
                                    <a class="btn btn-info" id="roles_refresh_button" ui-sref="roles" title="<fmt:message key="common.refresh" bundle="${msg}" />"  ui-sref-opts="{reload: true}"><span class="fa fa-refresh fa-lg "></span></a>
                                </span>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <div class="row">
                            <div class="col-md-12 col-sm-12 col-xs-12 ">

                                <div data-ng-show = "showLoader" style="margin: 1%">
    				  		<get-loader-image data-ng-show="showLoader"></get-loader-image>
      						</div>
                                    <div data-ng-hide = "showLoader" class="table-responsive font-normal">
                                        <div class="white-content">
                                        <table cellspacing="1" cellpadding="1" class="table dataTable table-bordered table-striped">
                                            <thead>
                                                <tr>
                                                <th   data-ng-click="changeSorting('name')" data-ng-class="sort.descending && sort.column =='name'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.name" bundle="${msg}" />${messages.getString("locale.profile")}</th>
                                                <th   data-ng-click="changeSorting('domain.name')" data-ng-class="sort.descending && sort.column =='domain.name'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.domain" bundle="${msg}" /></th>
                                                <th   data-ng-click="changeSorting('department.userName')" data-ng-class="sort.descending && sort.column =='department.userName'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.department" bundle="${msg}" /></th>
                                                <th   data-ng-click="changeSorting('description')" data-ng-class="sort.descending && sort.column =='description'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.description" bundle="${msg}" /></th>
                                                <th><fmt:message key="common.action" bundle="${msg}" /></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr data-ng-repeat="role in filteredCount = (roleList| filter: quickSearch | orderBy:sort.column:sort.descending)">
                                                    <td>
                                                       {{ role.name}}

                                                    </td>
                                                    <td>
                                                       {{ role.domain.name}}

                                                    </td>
                                                    <td>
                                                        {{ role.department.userName }}
                                                    </td>
                                                    <td>
                                                        {{ role.description}}
                                                    </td>
                                                    <td>
                                                        <a has-permission="EDIT_ROLE" id="role_edit_button_{{role.id}}" data-unique-field="edit-{{ role.domain.name}}-{{ role.department.userName }}-{{ role.name}}" class="icon-button role_edit_button" title="<fmt:message key="common.edit" bundle="${msg}" />" ui-sref="roles.list-edit({id: {{ role.id}}})" ><span class="fa fa-edit m-r"></span></a>
                                                        <a has-permission="DELETE_ROLE" id="role_delete_button_{{role.id}}" data-unique-field="delete-{{ role.domain.name}}-{{ role.department.userName }}-{{ role.name}}" class="icon-button role_delete_button" title="<fmt:message key="common.delete" bundle="${msg}" />"  data-ng-click="delete('sm',role)"  ><span class="fa fa-trash"></span></a>
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