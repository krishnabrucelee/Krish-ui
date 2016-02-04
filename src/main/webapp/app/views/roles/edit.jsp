<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<form name="RoleForm" data-ng-submit="update(RoleForm)" method="post" novalidate="" data-ng-controller="rolesListCtrl">

    <div class="row">
        <div class="col-md-12 col-sm-12">
            <div class="hpanel">
            <div data-ng-show = "showLoader" style="margin: 1%">
    					<get-loader-image data-ng-show="showLoader"></get-loader-image>
      					</div>
                <div class="panel-body" data-ng-hide = "showLoader">
                    <div class="col-md-6 col-sm-10 m-l-xl">
                        <div class="form-group" ng-class="{'text-danger': RoleForm.name.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-3 col-sm-3 control-label"><fmt:message key="common.name" bundle="${msg}" /><span class="text-danger">*</span></label>
                                <div class="col-md-7  col-sm-7 col-xs-7">
                                    <input required="true" type="text" name="name" data-ng-model="role.name" class="form-control" readonly data-ng-class="{'error': RoleForm.name.$invalid && formSubmitted}">
                                    <i  tooltip="<fmt:message key="role.name" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                    <div class="error-area" data-ng-show="RoleForm.name.$invalid && formSubmitted" ><i  tooltip="Role Name is required." class="fa fa-warning error-icon"></i>
                                    <i ng-attr-tooltip="{{ RoleForm.name.errorMessage || '<fmt:message key="role.already.exist" bundle="${msg}" />' }}"
												class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group" ng-class="{'text-danger':RoleForm.domain.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-3 col-sm-3 control-label"><fmt:message key="common.company" bundle="${msg}" /><span class="text-danger">*</span>
                                </label>
                                <div class="col-md-7  col-sm-7 col-xs-7">
                                <input required="true" type="text" name="name" data-ng-model="role.domain.name" class="form-control" readonly data-ng-class="{'error': RoleForm.domain.$invalid && formSubmitted}">
                                    <%-- <select  required="true" class="form-control input-group" name="domain" data-ng-change="domainChange()"
                                             data-ng-model="role.domain"
                                             ng-options="domain.name for domain in formElements.domainList" data-ng-class="{'error': RoleForm.domain.$invalid && formSubmitted}">
                                        <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                                    </select> --%>
                                    <i  tooltip="<fmt:message key="choose.domain" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                    <div class="error-area" data-ng-show="RoleForm.domain.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="company.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group"ng-class="{'text-danger': RoleForm.department.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-3 col-sm-3 control-label control-normal"><fmt:message key="common.department" bundle="${msg}" /><span class="text-danger">*</span></label>
                                <div class="col-md-7  col-sm-7 col-xs-7">
                                 <input required="true" type="text" name="name" data-ng-model="role.department.userName" class="form-control" readonly data-ng-class="{'error': RoleForm.department.$invalid && formSubmitted}">
                                    <%-- <select required="true" class="form-control input-group" name="department"
                                    data-ng-model="role.department"
                                    ng-options="department.userName for department in formElements.departmentList"
                                    data-ng-class="{'error': RoleForm.department.$invalid && formSubmitted}">
                                        <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                                    </select> --%>
                                   <i  tooltip="<fmt:message key="role.department" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                    <div class="error-area" data-ng-show="RoleForm.department.$invalid && formSubmitted" ><i  tooltip="role.department.is.required" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group" ng-class="{'text-danger': RoleForm.description.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-3 col-sm-3 control-label"><fmt:message key="common.description" bundle="${msg}" /><span class="text-danger">*</span></label>
                                <div class="col-md-7  col-sm-7 col-xs-7">
                                    <input required="true" type="text" name="description" data-ng-model="role.description" class="form-control" data-ng-class="{'error': RoleForm.description.$invalid && formSubmitted}">
                                    <i  tooltip="<fmt:message key="role.description" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                    <div class="error-area" data-ng-show="RoleForm.description.$invalid && formSubmitted" ><i  tooltip="Description is required." class="fa fa-warning error-icon"></i></div>
                               </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div data-ng-show = "showLoader" style="margin: 1%">
    	</div>

		<div class="row  p-sm" data-ng-hide = "showLoader">
         	<div class="col-md-12 m-b-sm">
         		<button type="button" class="btn btn-info pull-right" data-ng-click="checkAllPermissions(permissions)"> Check/UnCheck All</button>
         	</div>
        <div class="col-md-12 col-sm-12"  ng-repeat="(key, module) in permissions | groupBy: 'module'">

            <div class="form-group">
                <div class="white-content">
                	<div class="panel-heading bg-info no-padding">
                       	<label class="font-control p-xxs m-l-sm m-b-none"><input data-ng-checked="permissionGroupCount[key]==module.length" data-ng-model="permissionGroup[key]"  type="checkbox" data-ng-click="checkAll(module, key)" ><span class="m-l-sm">{{module[0].description}}</span></label>
					</div>
                    <div class="panel-body">
	                	<div class="col-md-4 col-sm-4 col-lg-4" ng-repeat="permission in module">
	                    	<div class="row">
	                        	<label> <input type="checkbox" ng-model="permissionList[permission.id]" data-ng-click="checkOne(permission, module)">  <span class="m-l-sm font-normal">{{permission.action}}</span></label>
	                        </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row p-sm">
            <span class="pull-right">
                <a class="btn btn-default btn-outline" data-ng-hide="showLoader" ui-sref="roles"><fmt:message key="common.cancel" bundle="${msg}" /></a>
                <button class="btn btn-info" has-permission="EDIT_ROLE" data-ng-hide="showLoader" type="submit" ng-disabled="form.RoleForm.$invalid" ><fmt:message key="common.update" bundle="${msg}" /></button>
            </span>
        </div>
    </div>
</form>