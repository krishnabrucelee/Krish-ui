<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />
<div ui-view >
            <div class="hpanel" ng-controller="rolesListCtrl">
                <div class="panel-heading">
                    <div class="row" >
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="pull-left dashboard-btn-area">
                            	<div class="dashboard-box pull-left">
	     							<div class="instance-border-content-normal">
	                                <span class="pull-left m-t-xs m-l-xs m-r-xs"><fmt:message key="common.total" bundle="${msg}" /></span>
	                                <b class="pull-left">{{roleList.Count}}</b>
	                                <div class="clearfix"></div>
	                                </div>
	                            </div>
                                <a class="btn btn-info font-bold" id="roles_add_role_button" has-permission="CREATE_ROLE"  ui-sref="organization.roles.list-add"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span><fmt:message key="common.add" bundle="${msg}" /></a>
                                <a class="btn btn-info font-bold" id="roles_assign_user_role_button" has-permission="ASSIGN_ROLE" data-ng-click="assignRole('lg')"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span><fmt:message key="assign.user.role" bundle="${msg}" /></a>
                                <a class="btn btn-info" data-ng-click="list(1)" id="roles_refresh_button" title="<fmt:message key="common.refresh" bundle="${msg}" />"  ui-sref-opts="{reload: true}"><span class="fa fa-refresh fa-lg "></span></a>
                            </div>
                            <div class="pull-right dashboard-filters-area">
                             <form data-ng-submit="searchList(roleSearch)">
									<div class="quick-search pull-right">
									<div class="input-group">
										<input data-ng-model="roleSearch" id="role_list_search" type="text" valid-characters class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />" aria-describedby="quicksearch-go">
								   		<span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
									</div>
									</div>
                                <span class="pull-right m-r-sm" data-ng-show="global.sessionValues.type == 'ROOT_ADMIN'">
									<select
										class="form-control input-group col-xs-5" name="domainView"
										data-ng-model="domainView"
										data-ng-change="selectDomainView(domainView)"
										data-ng-options="domainView.name for domainView in formElements.domainList">
										<option value=""> <fmt:message key="common.domain.filter" bundle="${msg}" /></option>
									</select>
								</span>
							<span class="pull-right m-r-sm" data-ng-if="global.sessionValues.type == 'DOMAIN_ADMIN'">
								<select
									class="form-control input-group col-xs-5" name="departmentView"
									data-ng-model="departmentView"
									data-ng-change="selectDepartmentView(departmentView)"
									data-ng-options="departmentView.userName for departmentView in departmentList">
									<option value=""> <fmt:message key="common.department.filter" bundle="${msg}" /></option>
								</select>
							</span>
                                <div class="clearfix"></div>
                                <span class="pull-right m-l-sm m-t-sm m-b-sm"></span>
                                </form>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <div class="row" id="roles_pagination_container">
                            <div class="col-md-12 col-sm-12 col-xs-12 ">
                                <div data-ng-show = "showLoader" style="margin: 1%">
    				  		<get-loader-image data-ng-show="showLoader"></get-loader-image>
      						</div>
                                    <div data-ng-hide = "showLoader" class="table-responsive font-normal">
                                        <div class="white-content">
                                        <table cellspacing="1" cellpadding="1" id="roles_table" class="table dataTable table-bordered table-striped">
                                            <thead>
                                                <tr>
                                                <th   data-ng-click="changeSort('name',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='name'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.name" bundle="${msg}" />${messages.getString("locale.profile")}</th>
                                                <th   data-ng-click="changeSort('domain.name',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='domain.name'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.domain" bundle="${msg}" /></th>
                                                <th   data-ng-click="changeSort('department.userName',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='department.userName'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.department" bundle="${msg}" /></th>
                                                <th   data-ng-click="changeSort('description',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='description'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.description" bundle="${msg}" /></th>
                                                <th><fmt:message key="common.action" bundle="${msg}" /></th>
                                                </tr>
                                            </thead>
                                            <tbody data-ng-hide="roleList.length > 0">
			                                    <tr>
			                                        <td class="col-md-5 col-sm-5" colspan="5"><fmt:message key="common.no.records.found" bundle="${msg}" />!!</td>
			                                    </tr>
			                                </tbody>
                                            <tbody data-ng-show="roleList.length > 0">
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
                                                        <input type="hidden" id="role_unique_{{role.id}}"  data-unique-field="{{ role.domain.name}}-{{ role.department.userName }}-{{ role.name}}" class="test_role_unique">
                                                        <a has-permission="EDIT_ROLE" id="role_edit_button_{{role.id}}" data-unique-field="edit-{{ role.domain.name}}-{{ role.department.userName }}-{{ role.name}}" class="icon-button test_role_edit_button" title="<fmt:message key="common.edit" bundle="${msg}" />" ui-sref="organization.roles.list-edit({id: {{ role.id}}})" ><span class="fa fa-edit m-r"></span></a>
                                                        <a has-permission="DELETE_ROLE" id="role_delete_button_{{role.id}}" data-unique-field="delete-{{ role.domain.name}}-{{ role.department.userName }}-{{ role.name}}" class="icon-button test_role_delete_button" title="<fmt:message key="common.delete" bundle="${msg}" />"  data-ng-click="delete('sm',role)"  ><span class="fa fa-trash"></span></a>
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
