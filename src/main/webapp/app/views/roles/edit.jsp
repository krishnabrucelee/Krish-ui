<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<form name="RoleForm" data-ng-submit="update(RoleForm)" method="post" novalidate="" data-ng-controller="rolesListCtrl">

    <div class="row">
        <div class="col-md-12 col-sm-12">
            <div class="hpanel">
                <div class="panel-body">
                    <div class="col-md-6 col-sm-10 m-l-xl">
                        <div class="form-group" ng-class="{'text-danger': RoleForm.name.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-3 col-sm-3 control-label"><fmt:message key="common.name" bundle="${msg}" /><span class="text-danger">*</span></label>
                                <div class="col-md-7  col-sm-7 col-xs-7">
                                    <input required="true" type="text" name="name" data-ng-model="role.name" class="form-control" readonly data-ng-class="{'error': RoleForm.name.$invalid && formSubmitted}">
                                    <i  tooltip="<fmt:message key="role.name" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                    <div class="error-area" data-ng-show="RoleForm.name.$invalid && formSubmitted" ><i  tooltip="Role Name is required." class="fa fa-warning error-icon"></i></div>

                                </div>
                            </div>
                        </div>
                        <div class="form-group"ng-class="{'text-danger': RoleForm.department.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-3 col-sm-3 control-label control-normal"><fmt:message key="common.department" bundle="${msg}" /><span class="text-danger">*</span></label>
                                <div class="col-md-7  col-sm-7 col-xs-7">
                                    <select required="true" class="form-control input-group" name="department" data-ng-model="role.department" ng-options="department.name for department in formElements.roleList" data-ng-class="{'error': RoleForm.department.$invalid && formSubmitted}">
                                        <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>

                                    </select>
                                   <i  tooltip="<fmt:message key="role.department" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                    <div class="error-area" data-ng-show="RoleForm.department.$invalid && formSubmitted" ><i  tooltip="Department is required." class="fa fa-warning error-icon"></i></div>

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
        <div class="row">
        <div class="col-md-3 col-sm-6" ng-repeat="permission in permissions">
            <div class="form-group">
                <div class="white-content min-height-200">
                    <div class="panel-body">
                        <label class="text-info font-control m-b-sm "> <input type="checkbox" ng-model="permission.selected" data-ng-click="checkAll(permission, $index)" /><span class="m-l-sm">{{ permission.name }}</span></label>
                        <div class="row" ng-repeat="menu in permission.accessmenu">
                            <div class="col-md-12  col-sm-12 col-lg-12">
                                <label> <input icheck type="checkbox" ng-model="menu.selected">  <span class="m-l-sm">{{menu.name}}</span></label>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
    <div class="form-group">
        <div class="row">
            <span class="pull-right">
                <a class="btn btn-default btn-outline"  ui-sref="roles"><fmt:message key="common.cancel" bundle="${msg}" /></a>
                <button class="btn btn-info" type="submit" ng-disabled="form.RoleForm.$invalid" ><fmt:message key="common.update" bundle="${msg}" /></button>
            </span>
        </div>
    </div>


</form>
