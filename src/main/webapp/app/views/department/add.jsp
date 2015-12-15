<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<form name="departmentForm" data-ng-submit="save(departmentForm, department)" method="post" novalidate=""  >
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header page-icon="fa fa-plus-circle" page-title="<fmt:message key="add.department" bundle="${msg}" />"></panda-modal-header>
        </div>

        <div class="modal-body">
            <div class="row"  >
                <div class="col-md-12">
					<div data-ng-if="global.sessionValues.type != 'ROOT_ADMIN'">
					<div class="form-group">
						<div class="row">
                            <label class="col-md-4 col-xs-12 col-sm-4 control-label control-normal"><fmt:message key="common.domain" bundle="${msg}" /><span class="text-danger">*</span></label>
                            <div class="col-md-6  col-sm-6 col-xs-12">
                                {{ global.sessionValues.domainName }}
                            </div>
                        </div>
                        </div>
	                </div>
                	<div data-ng-if="global.sessionValues.type == 'ROOT_ADMIN'">
						<div class="form-group" ng-class="{'text-danger':departmentForm.domain.$invalid && formSubmitted}">
	                        <div class="row">
	                            <label class="col-md-4 col-xs-12 col-sm-4 control-label control-normal"><fmt:message key="common.domain" bundle="${msg}" /><span class="text-danger">*</span></label>
	                            <div class="col-md-6  col-sm-6 col-xs-12">
	                                <select required="true" class="form-control input-group" name="domain" data-ng-model="department.domain" ng-options="domain.name for domain in formElements.domainList" data-ng-class="{'error': departmentForm.domain.$invalid && formSubmitted}" >
	                                    <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>

	                                </select>
	                                <i  tooltip="<fmt:message key="choose.domain" bundle="${msg}" /> " class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
	                                <div class="error-area" data-ng-show="departmentForm.domain.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="domain.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
	                            </div>
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
                        </div>
					</div>

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

                </div>
            </div>
        </div>

        <div class="modal-footer">
         <get-loader-image data-ng-show="showLoader"></get-loader-image>
        
            <button type="button" class="btn btn-default "  data-ng-hide="showLoader" ng-click="cancel()" data-dismiss="modal"><fmt:message key="common.cancel" bundle="${msg}" /></button>
            <button   data-ng-hide="showLoader"class="btn btn-info" type="submit"><fmt:message key="common.add" bundle="${msg}" /></button>

        </div></div>
</form>




