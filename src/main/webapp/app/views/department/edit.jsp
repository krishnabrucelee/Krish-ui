<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<form name="departmentForm" data-ng-submit="update(departmentForm)" method="post" novalidate=""  >
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header hide-zone="false" page-icon="fa fa-edit" page-title="<fmt:message key="edit.department" bundle="${msg}" />"></panda-modal-header>

        </div>
        <div class="modal-body">
            <div class="row"  >
                <div class="col-md-6">
					<div class="form-group"ng-class="{'text-danger': RoleForm.department.$invalid && formSubmitted}">
                        <div class="row">
                            <label class="col-md-4 col-xs-12 col-sm-4 control-label control-normal"><fmt:message key="common.domain" bundle="${msg}" /><span class="text-danger">*</span></label>
                            <div class="col-md-6  col-sm-6 col-xs-12">
                                {{ department.domain.name }}
                            </div>
                        </div>
                    </div>
                    <div class="form-group" ng-class="{'text-danger': departmentForm.userName.$invalid && formSubmitted}">
                        <div class="row" >
                            <label class="col-md-4 col-xs-12 col-sm-4 control-label" ><fmt:message key="department.name" bundle="${msg}" /> <span class="text-danger">*</span>
                            </label>
                            <div class="col-md-6 col-xs-12 col-sm-6">
                                <input required="true" type="text"  name="userName" data-ng-model="department.userName"  class="form-control" data-ng-class="{'error': departmentForm.userName.$invalid && formSubmitted}">
                                <i  tooltip="<fmt:message key="department.name" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                <div class="error-area" data-ng-show="departmentForm.userName.$invalid && formSubmitted" >
                                    <i ng-attr-tooltip="{{ departmentForm.userName.errorMessage || '<fmt:message key="department.userName.is.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                </div>
                            </div>
                            <div class="col-md-12 "><fmt:message key="department.note.department.username" bundle="${msg}" /></div>
                        </div>
					</div>
					<%-- <div class="form-group" ng-class="{'text-danger': departmentForm.hod.$invalid && formSubmitted}">
                        <div class="row" >
                            <label class="col-md-4 col-xs-12 col-sm-4 control-label" ><fmt:message key="department.hod" bundle="${msg}" /> <span class="text-danger">*</span>
                            </label>
                            <div class="col-md-6 col-xs-12 col-sm-6">
                                <input required="true" type="text"  name="hod" data-ng-model="department.hod"  class="form-control" data-ng-class="{'error': departmentForm.hod.$invalid && formSubmitted}">
                                <i  tooltip="<fmt:message key="department.hod" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                <div class="error-area" data-ng-show="departmentForm.hod.$invalid && formSubmitted" >
                                    <i ng-attr-tooltip="{{ departmentForm.hod.errorMessage || '<fmt:message key="department.hod.is.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                </div>
                            </div>
                        </div>
					</div> --%>
                        <div class="form-group" ng-class="{'text-danger': departmentForm.description.$invalid && formSubmitted}">
	                        <div class="row" >
	                            <label class="col-md-4 col-xs-12 col-sm-4 control-label" ><fmt:message key="common.description" bundle="${msg}" /> <span class="text-danger">*</span>
	                            </label>
	                            <div class="col-md-6 col-xs-12 col-sm-6">
	                                <textarea rows="4" required="true" type="text"  name="description" data-ng-model="department.description"  class="form-control" data-ng-class="{'error': departmentForm.description.$invalid && formSubmitted}"></textarea>
	                                <i  tooltip="<fmt:message key="description.of.the.department" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
	                                <div class="error-area" data-ng-show="departmentForm.description.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="department.description.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>

	                            </div>

	                        </div>

                    </div>

                     </div>
					<div class="col-md-6">
                        <div class="form-group" ng-class="{'text-danger': departmentForm.firstName.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-4 col-sm-4 control-label"><fmt:message key="first.name" bundle="${msg}" /><span class="text-danger">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6">
                                    <input required="true" type="text" name="firstName" data-ng-model="department.firstName" class="form-control" data-ng-class="{'error': departmentForm.firstName.$invalid && formSubmitted}">
                                    <i  tooltip="<fmt:message key="first.name.of.the.department" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                    <div class="error-area" data-ng-show="departmentForm.firstName.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="first.name.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group" ng-class="{'text-danger': departmentForm.lastName.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-4 col-sm-4 control-label"><fmt:message key="last.name" bundle="${msg}" /><span class="text-danger">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6">
                                    <input required="true" type="text" name="lastName" data-ng-model="department.lastName" class="form-control" data-ng-class="{'error': departmentForm.lastName.$invalid && formSubmitted}">
                                    <i  tooltip="<fmt:message key="last.name.of.the.department" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                    <div class="error-area" data-ng-show="departmentForm.lastName.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="last.name.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div>


					<div class="form-group" ng-class="{'text-danger': departmentForm.email.$invalid && formSubmitted}">
                          <div class="row">
                              <label class="col-md-4 col-sm-4 control-label"><fmt:message key="common.email" bundle="${msg}" /> <span class="text-danger">*</span>
                              </label>
                              <div class="col-md-6 col-sm-6">
                                  <input required="true" type='email'  valid-email name="email" data-ng-model="department.email" class="form-control" data-ng-class="{'error': departmentForm.email.$invalid && formSubmitted}" >
                                  <i  tooltip="<fmt:message key="enter.the.desired.email" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                  <div class="error-area" data-ng-show="departmentForm.email.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="email.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>

                              </div>

                          </div>
                      </div>
                </div>
            </div>
        </div>

        <div class="modal-footer">
            <button type="button" class="btn btn-default " ng-click="cancel()" data-dismiss="modal"><fmt:message key="common.cancel" bundle="${msg}" /></button>
            <button class="btn btn-info" type="submit"><fmt:message key="common.update" bundle="${msg}" /></button>

        </div>
        </div>
</form>




