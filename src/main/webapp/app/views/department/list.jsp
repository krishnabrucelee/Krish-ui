<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />
<div ui-view>
            <div class="row" data-ng-controller="departmentCtrl" id="departments_pagination_container">
                <div class="col-md-12 col-sm-12">
                    <div class="hpanel">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-md-12 col-sm-12 col-xs-12 ">
                                    <div class="pull-left dashboard-btn-area">
                                        <div class="dashboard-box pull-left">
			     							<div class="instance-border-content-normal">
			                                <span class="pull-left m-t-xs m-l-xs m-r-xs"><fmt:message key="common.total" bundle="${msg}" /></span>
			                                <b class="pull-left">{{departmentList.Count}}</b>
			                                <div class="clearfix"></div>
			                                </div>
			                            </div>
			                            <a has-permission="ADD_DEPARTMENT" id="departments_add_button" class="btn btn-info font-bold"  ng-click="createDepartment('md')"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span><fmt:message key="common.add" bundle="${msg}" /> </a>
                                        <a class="btn btn-info" data-ng-click="list(1)" id="departments_refresh_button" title="<fmt:message key="common.refresh" bundle="${msg}" /> " ui-sref-opts="{reload: true}" ><span class="fa fa-refresh fa-lg"></span></a>
                                    </div>
                                    <div class="pull-right dashboard-filters-area" id="department_quick_search">
									<form data-ng-submit="searchList(departmentSearch)">
										<div class="quick-search pull-right">
										<div class="input-group">
										<input data-ng-model="departmentSearch" id="department_list_search" type="text" valid-characters class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />" aria-describedby="quicksearch-go">
								   		<span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
										</div>
										</div>
										<span class="pull-right m-r-sm" data-ng-show="global.sessionValues.type == 'ROOT_ADMIN'">
										<select	class="form-control input-group col-xs-5" name="domainView" data-ng-model="domainView" data-ng-change="selectDomainView(1)" data-ng-options="domainView.name for domainView in formElements.domainList">
										<option value=""> <fmt:message key="common.domain.filter" bundle="${msg}" /></option>
										</select>
										</span>
									<div class="clearfix"></div>
									<span class="pull-right m-l-sm m-t-sm">	</span>
									</form>
								    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                         <div data-ng-show = "showLoader" style="margin: 1%">
    				  		<get-loader-image data-ng-show="showLoader"></get-loader-image>
      						</div>
                            <div data-ng-hide="showLoader" class="table-responsive">
                                  <div class="white-content m-b-sm m-t-xs">
                                <table cellspacing="1" cellpadding="1" id="departments_table" class="table dataTable table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th class="col-md-2 col-sm-2"  data-ng-click="changeSort('userName',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='userName'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.name" bundle="${msg}" /></th>
                                             <th class="col-md-2 col-sm-2"  data-ng-click="changeSort('domain.name',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='domain.name'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.domain" bundle="${msg}" /></th>
                                             <th class="col-md-2 col-sm-2"  data-ng-click="changeSort('description',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='description'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.description" bundle="${msg}" /></th>
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
	                                           <input type="hidden" id="departments_unique_{{department.id}}"  data-unique-field="{{ department.domain.name }}-{{ department.userName}}" class="test_departments_unique">
                                                <a has-permission="EDIT_DEPARTMENT" id="departments_edit_button_{{department.id}}" class="icon-button test_departments_edit_button" title="<fmt:message key="common.edit" bundle="${msg}" />" data-ng-click="edit('md', department)">
                                                    <span class="fa fa-edit"> </span>
                                                </a>
                                                 <a data-ng-if="department.type != 'ROOT_ADMIN'" has-permission="DEPARTMENT_RESOURCE_QUOTA_MODIFICATION" id="departments_edit_quota_button_{{department.id}}" class="icon-button test_departments_edit_quota_button" ui-sref="organization.department.quotalimit({id: {{department.id}}, quotaType: 'department-quota'})" title="<fmt:message key="common.edit.quota" bundle="${msg}" />">
                                                    <span class="fa font-bold pe-7s-edit"> </span>
                                                </a>
                                                <a has-permission="DELETE_DEPARTMENT" id="departments_delete_button_{{department.id}}" class="icon-button test_departments_delete_button" title="<fmt:message key="common.delete" bundle="${msg}" />" data-ng-click="delete('sm', department)" ><span class="fa fa-trash"></span></a>
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
<div id="footer" ng-include="'app/views/common/footer.jsp'"></div>

