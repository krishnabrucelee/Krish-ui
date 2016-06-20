<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<form name="userForm" data-ng-submit="save(userForm)" method="post" novalidate="">
<input type="hidden" name="passwordErrorMessage" id="passwordErrorMessage" data-ng-model="account.passwordErrorMessage" value='<fmt:message key="please.check.confirm.password" bundle="${msg}" />' />
	<div class="inmodal" >
	<div class="modal-header">
		<panda-modal-header id="add_user_page_title"  page-icon="fa fa-user-plus" hide-zone="false" page-title=<fmt:message key="add.user" bundle="${msg}" />></panda-modal-header>
	</div>
	<div class="modal-body">
	<div class="row"  >
	<div class="col-md-12">
		<div class="bg-info border p-sm m-b-md"><fmt:message key="user.confirmation.email.notification" bundle="${msg}" /></div>
			<div class="col-md-6 col-sm-6">
				<div class="form-group" ng-class="{'text-danger': userForm.username.$invalid && formSubmitted}">
					<div class="row">
						<label class="col-md-4 col-sm-4 control-label"><fmt:message key="user.name" bundle="${msg}" /><span class="text-danger">*</span></label>
							<div class="col-md-6 col-sm-6">
								<input required="true" id="add_user_user_name" type="text" name="username" data-ng-model="user.userName" class="form-control" data-ng-class="{'error': userForm.username.$invalid && formSubmitted}">
								<i tooltip="<fmt:message key="user.name.of.the.user" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
									<div class="error-area" data-ng-show="userForm.username.errorMessage && formSubmitted" >
										<i ng-attr-tooltip="{{ userForm.username.errorMessage || '<fmt:message key="user.name.is.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
								</div>
							</div>
					</div>
				</div>

                <div class="form-group" ng-class="{'text-danger': userForm.password.$invalid && formSubmitted}">
                	<div class="row">
                    	<label class="col-md-4 col-sm-4 control-label"><fmt:message key="common.password" bundle="${msg}" /><span class="text-danger">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6">
                                    <input required="true" id="add_user_password" type="password" name="password" data-ng-model="user.password" class="form-control" data-ng-class="{'error': userForm.password.$invalid && formSubmitted}">
                                    <i  tooltip="<fmt:message key="password.of.the.user" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                    <div class="error-area" data-ng-show="userForm.password.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="password.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div>

                         <div class="form-group" ng-class="{'text-danger': userForm.confirmpassword.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-4 col-sm-4 control-label"><fmt:message key="confirm.password" bundle="${msg}" /><span class="text-danger">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6">
                                    <input required="true" id="add_user_confirm_password" type="password" id="confirmpassword" name="confirmpassword" data-ng-model="account.confirmPassword" class="form-control" data-ng-class="{'error': userForm.confirmpassword.$invalid && formSubmitted}">
                                    <i  tooltip="<fmt:message key="confirm.password.of.the.user" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                     <div class="error-area" data-ng-show="userForm.confirmpassword.$invalid && formSubmitted" >
                                    <i ng-attr-tooltip="{{ userForm.confirmpassword.errorMessage || '<fmt:message key="confirm.password.is.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                    </div>
                                </div>
                            </div>
                        </div>

                           <div class="form-group" ng-class="{'text-danger': userForm.firstName.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-4 col-sm-4 control-label"><fmt:message key="first.name" bundle="${msg}" /><span class="text-danger">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6">
                                    <input required="true" id="add_user_first_name" type="text" name="firstName" data-ng-model="user.firstName" class="form-control" data-ng-class="{'error': userForm.firstName.$invalid && formSubmitted}">
                                    <i  tooltip="<fmt:message key="first.name.of.the.user" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                    <div class="error-area" data-ng-show="userForm.firstName.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="first.name.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group" ng-class="{'text-danger': userForm.lastName.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-4 col-sm-4 control-label"><fmt:message key="last.name" bundle="${msg}" /><span class="text-danger">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6">
                                    <input required="true" id="add_user_last_name" type="text" name="lastName" data-ng-model="user.lastName" class="form-control" data-ng-class="{'error': userForm.lastName.$invalid && formSubmitted}">
                                    <i  tooltip="<fmt:message key="last.name.of.the.user" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                    <div class="error-area" data-ng-show="userForm.lastName.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="last.name.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group" ng-class="{'text-danger': userForm.email.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-4 col-sm-4 control-label"><fmt:message key="common.email" bundle="${msg}" /> <span class="text-danger">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6">
                                    <input required="true" id="add_user_email" type='email'  valid-email name="email" data-ng-model="user.email" class="form-control" data-ng-class="{'error': userForm.email.$invalid && formSubmitted}" >
                                    <i  tooltip="<fmt:message key="email.of.the.user" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                    <div class="error-area" data-ng-show="userForm.email.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="email.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>

                                </div>

                            </div>
                        </div>

                    </div>
                    <div class="col-md-6 col-sm-6">

                    <div data-ng-if="global.sessionValues.type != 'ROOT_ADMIN'">
						<div class="form-group">
							<div class="row">
                            	<label class="col-md-3 col-sm-3 control-label control-normal"><fmt:message key="common.company" bundle="${msg}" /><span class="text-danger">*</span></label>
                            	<div class="col-md-5  col-sm-5">
                                {{ global.sessionValues.domainName }}
                                <input type="hidden" id="add_user_domain" name="domain"  data-ng-model="user.domain" value="{{global.sessionValues.domainId}}" />
                            	</div>
                        	</div>
                        </div>
	                </div>

                    <div data-ng-if="global.sessionValues.type == 'ROOT_ADMIN'">
                    <div class="form-group" ng-class="{'text-danger':userForm.domain.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-3 col-sm-3 control-label"><fmt:message key="common.company" bundle="${msg}" /><span class="text-danger">*</span>
                                </label>
                                <div class="col-md-5 col-sm-5">
                                    <select  required="true" id="add_user_domain" class="form-control form-group-lg" name="domain"
                                             data-ng-model="user.domain" data-ng-change="domainChange()"
                                             data-ng-options="domain.name for domain in accountElements.domainList" data-ng-class="{'error': userForm.domain.$invalid && formSubmitted}">
                                        <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                                    </select>
                                    <i  tooltip="<fmt:message key="company.of.the.user" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                    <div class="error-area" data-ng-show="userForm.domain.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="company.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div>
                        </div>

                        <div data-ng-if="global.sessionValues.type == 'ROOT_ADMIN'">
                        <div class="form-group" ng-class="{'text-danger':userForm.department.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-3 col-sm-3 control-label"><fmt:message key="common.department" bundle="${msg}" /><span class="text-danger">*</span>
                                </label>
                                <div class="col-md-5 col-sm-5">
                                    <select  required="true" id="add_user_department" class="form-control form-group-lg" name="department"
                                             data-ng-model="user.department" ng-change="getRolesAndProjectsByDepartment(user.department)"
                                             data-ng-options="department.userName for department in accountElements.departmentList" data-ng-class="{'error': userForm.department.$invalid && formSubmitted}">
                                        <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                                    </select>
                                    <i  tooltip="<fmt:message key="department.of.the.user" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                    <div class="error-area" data-ng-show="userForm.department.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="department.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div>
                        </div>

                        <div data-ng-if="global.sessionValues.type == 'DOMAIN_ADMIN'">
                        <div class="form-group" ng-class="{'text-danger':userForm.department.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-3 col-sm-3 control-label"><fmt:message key="common.department" bundle="${msg}" /><span class="text-danger">*</span>
                                </label>
                                <div class="col-md-5 col-sm-5">
                                    <select  required="true" id="add_user_department" class="form-control form-group-lg" name="department"
                                             data-ng-model="user.department" ng-change="getRolesAndProjectsByDepartment(user.department)"
                                             data-ng-options="department.userName for department in departmentList" data-ng-class="{'error': userForm.department.$invalid && formSubmitted}">
                                        <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                                    </select>
                                    <i  tooltip="<fmt:message key="department.of.the.user" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                    <div class="error-area" data-ng-show="userForm.department.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="department.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div>
                        </div>

                        <div class=" form-group row" data-ng-if="global.sessionValues.type == 'USER'">
							<label class="col-md-3 col-sm-3 control-label"><fmt:message
									key="common.department" bundle="${msg}" /> </label>
							<div class="col-md-5 col-sm-5">
								{{ userElement.department.userName }}
							</div>
						</div>
						<div class=" form-group row">
							<label class="col-md-3 col-sm-3 control-label"><fmt:message
									key="common.type" bundle="${msg}" /> </label>
							<div data-ng-if="user.department.type == null" class="col-md-5 col-sm-5">-</div>
							<div data-ng-if="user.department.type == 'USER'" class="col-md-5 col-sm-5">{{user.department.type}}</div>
							<div data-ng-if="user.department.type == 'DOMAIN_ADMIN'" class="col-md-5 col-sm-5">DOMAIN ADMIN</div>
							<div data-ng-if="user.department.type == 'ROOT_ADMIN'" class="col-md-5 col-sm-5">ROOT ADMIN</div>
						</div>
                        <div data-ng-if="user.department.type == null || user.department.type == 'USER'" class="form-group"  ng-class="{'text-danger':userForm.role.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-3 col-sm-3 control-label"><fmt:message key="common.role" bundle="${msg}" /><span class="text-danger">*</span>
                                </label>
                                <div class="col-md-5 col-sm-5">
                                    <select required="true" class="form-control form-group-lg" name="role" id="add_user_role"
                                             data-ng-model="user.role"
                                             data-ng-options="role.name for role in accountElements.roleList" data-ng-class="{'error': userForm.role.$invalid && formSubmitted}" >
                                        <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                                    </select>
                                    <i  tooltip="<fmt:message key="role.of.the.user" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                    <div class="error-area" data-ng-show="userForm.role.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="role.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div>
                        <div data-ng-if="user.department.type == 'DOMAIN_ADMIN' || user.department.type == 'ROOT_ADMIN'" class="form-group">
                            <div class="row">
                                <label class="col-md-3 col-sm-3 control-label"><fmt:message key="common.role" bundle="${msg}" />
                                </label>
                                <div class="col-md-5 col-sm-5">
                                    FULL_PERMISSION
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="col-md-3 col-sm-3 control-label"><fmt:message key="common.projects" bundle="${msg}" />
                                </label>
                                <div class="col-md-5 col-sm-5">
                                    <select class="form-control form-group-lg" id="add_user_project" multiple="multiple" data-ng-model="user.projectList"
    									ng-options="options.name for options in options"></select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <get-loader-image data-ng-show="showLoader"></get-loader-image>
            <a class="btn btn-default" data-ng-hide="showLoader" id="add_user_cancel_button" data-ng-click="cancel()"><fmt:message key="common.cancel" bundle="${msg}" /></a>
            <button class="btn btn-info"data-ng-hide="showLoader" id="add_user_add_button" type="submit"><fmt:message key="common.add" bundle="${msg}" /></button>
        </div>
    </div>
</form>