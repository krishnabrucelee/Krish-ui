<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<form name="RoleForm" data-ng-submit="assignRoleSave(RoleForm)"
	method="post" novalidate="">
	<div class="inmodal">
		<div class="modal-header">
			<panda-modal-header id="assign_role_page_title" page-icon="fa fa-user-plus" hide-zone="false"
				page-title="Assign Role"></panda-modal-header>
		</div>
		<div class="modal-body">
			<div class="row">

				<div class="col-md-12">
					<div class="col-md-6">
					<div data-ng-if="global.sessionValues.type != 'ROOT_ADMIN'">
					<div class="form-group">
						<div class="row">
                            <label class="col-md-3 col-sm-3 control-label control-normal"><fmt:message key="common.domain" bundle="${msg}" /><span class="text-danger">*</span></label>
                            <div class="col-md-5 col-sm-5">
                                {{ global.sessionValues.domainName }}
                                <input type="hidden" id = "add_department_domain" name="domain"  data-ng-model="department.domain" data-ng-init="department.domainId=global.sessionValues.domainId" />
                            </div>
                        </div>
                        </div>
	                </div>
                	<div data-ng-if="global.sessionValues.type == 'ROOT_ADMIN'">
						<div class="form-group" ng-class="{'text-danger':departmentForm.domain.$invalid && formSubmitted}">
	                        <div class="row">
	                            <label class="col-md-3 col-sm-3 control-label"><fmt:message key="common.domain" bundle="${msg}" /><span class="text-danger">*</span></label>
	                            <div class="col-md-5 col-sm-5">
	                                <select required="true" class="form-control input-group" id = "add_department_domain" name="domain" data-ng-model="role.domain" ng-options="domain.name for domain in formElements.domainList" data-ng-change="getDepartmentsByDomain(role.domain)" data-ng-class="{'error': departmentForm.domain.$invalid && formSubmitted}" >
	                                    <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>

	                                </select>
	                                <i  tooltip="<fmt:message key="choose.domain" bundle="${msg}" /> " class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
	                                <div class="error-area" data-ng-show="departmentForm.domain.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="domain.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
	                            </div>
	                        </div>
	                    </div>
                    </div>
				</div>
				</div>


				<div class="col-md-12">
					<div class="col-md-6 col-sm-6">
						<div class="form-group"
							ng-class="{'text-danger':RoleForm.department.$invalid && formSubmitted}">
							<div class="row">
								<label class="col-md-3 col-sm-3 control-label"><fmt:message
										key="common.department" bundle="${msg}" /><span
									class="text-danger">*</span> </label>
								<div class="col-md-5 col-sm-5" data-ng-if="userType != 'USER'">
									<select class="form-control form-group-lg" id="assign_role_department" name="department"
										data-ng-model="role.department"
										ng-change="getUsersByDepartment(role.department)"
										data-ng-options="department.userName for department in formElements.departments"
										data-ng-class="{'error': RoleForm.department.$invalid && formSubmitted}">
										<option value=""><fmt:message key="common.select"
												bundle="${msg}" /></option>
									</select> <i
										tooltip="<fmt:message key="department.of.the.user" bundle="${msg}" />"
										class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
									<div class="error-area"
										data-ng-show="RoleForm.department.$invalid && formSubmitted">
										<i
											tooltip="<fmt:message key="department.is.required" bundle="${msg}" />"
											class="fa fa-warning error-icon"></i>
									</div>
								</div>
								<div class="col-md-5 col-sm-5" data-ng-if="userType == 'USER'">
									{{ department.userName }}
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div>
		<div class="row">
			<div class="col-md-12 col-sm-12 col-xs-12">
				<div class="col-md-12 col-sm-12 col-xs-12 ">
					<div class="table-responsive">
						<table cellspacing="1" cellpadding="1"
							class="table table-bordered table-striped ">
							<thead>
								<tr>
									<th><fmt:message key="user.name" bundle="${msg}" /></th>
									<th><fmt:message key="common.role" bundle="${msg}" /></th>
								</tr>
							</thead>
							<tbody>
								<tr data-ng-repeat="user in userList">
									<td>{{user.userName}}</td>
									<td><select class="form-control input-group test_assign_role_user" id="assign_role_user_{{user.id}}" name="role"
										data-ng-model="userRolePermissionList[user.id]"
										data-ng-class="{'error': RoleForm.role.$invalid && formSubmitted}">
											<option value=""><fmt:message key="common.select"
													bundle="${msg}" /></option>
											<option data-ng-repeat="role in roleList"
												data-ng-selected="userRolePermissionList[user.id] == role.id"
												data-ng-value="role.id">{{role.name}}</option>
									</select></td>
								</tr>

							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal-footer">
		<a class="btn btn-default" id="assign_role_cancel_button" data-ng-click="cancel()"><fmt:message
				key="common.cancel" bundle="${msg}" /></a>
		<button class="btn btn-info" id="assign_role_add_button" type="submit">
			<fmt:message key="common.add" bundle="${msg}" />
		</button>
	</div>
</form>

