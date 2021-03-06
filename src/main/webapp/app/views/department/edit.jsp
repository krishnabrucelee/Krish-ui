<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<form name="departmentForm" data-ng-submit="update(departmentForm)" method="post" novalidate=""  >
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header id="edit_department_page_title" hide-zone="false" page-icon="fa fa-edit" page-title="<fmt:message key="edit.department" bundle="${msg}" />"></panda-modal-header>

        </div>
        <div class="modal-body">
            <div class="row"  >
                <div class="col-md-12">
					<div class="form-group"ng-class="{'text-danger': RoleForm.department.$invalid && formSubmitted}">
                        <div class="row">
                            <label class="col-md-4 col-xs-12 col-sm-4 control-label control-normal"><fmt:message key="common.domain" bundle="${msg}" /><span class="text-danger">*</span></label>
                            <div class="col-md-6  col-sm-6 col-xs-12">
                                {{ department.domain.name }}
                                <input type="hidden" id="edit_department_domain" name="domain"  data-ng-model="department.domain" data-ng-init="department.domainId=global.sessionValues.domainId" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group" ng-class="{'text-danger': departmentForm.userName.$invalid && formSubmitted}">
                        <div class="row" >
                            <label class="col-md-4 col-xs-12 col-sm-4 control-label" ><fmt:message key="department.name" bundle="${msg}" /> <span class="text-danger">*</span>
                            </label>
                            <div class="col-md-6 col-xs-12 col-sm-6">
                                <input required="true" type="text" id="edit_department_user_name" name="userName" data-ng-model="department.userName"  class="form-control" data-ng-class="{'error': departmentForm.userName.$invalid && formSubmitted}">
                                <i  tooltip="<fmt:message key="department.name" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                <div class="error-area" data-ng-show="departmentForm.userName.$invalid && formSubmitted" >
                                    <i ng-attr-tooltip="{{ departmentForm.userName.errorMessage || '<fmt:message key="department.userName.is.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                </div>
                            </div>
                        </div>
					</div>

                        <div class="form-group" ng-class="{'text-danger': departmentForm.description.$invalid && formSubmitted}">
	                        <div class="row" >
	                            <label class="col-md-4 col-xs-12 col-sm-4 control-label" ><fmt:message key="common.description" bundle="${msg}" /> <span class="text-danger">*</span>
	                            </label>
	                            <div class="col-md-6 col-xs-12 col-sm-6">
	                                <textarea rows="4" required="true" type="text" id="edit_department_description" name="description" data-ng-model="department.description"  class="form-control" data-ng-class="{'error': departmentForm.description.$invalid && formSubmitted}"></textarea>
	                                <i  tooltip="<fmt:message key="description.of.the.department" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
	                                <div class="error-area" data-ng-show="departmentForm.description.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="department.description.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>

	                            </div>

	                        </div>

                    </div>

                     </div>

            </div>
        </div>

        <div class="modal-footer">
            <get-loader-image data-ng-show="showLoader"></get-loader-image>

            <button type="button" id="edit_department_cancel_button" data-ng-hide="showLoader" class="btn btn-default " ng-click="cancel()" data-dismiss="modal"><fmt:message key="common.cancel" bundle="${msg}" /></button>
            <button class="btn btn-info" data-ng-hide="showLoader" id="edit_department_update_button" type="submit"><fmt:message key="common.update" bundle="${msg}" /></button>

        </div>
        </div>
</form>




