<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

    <div class="inmodal" data-ng-controller="projectCtrl">
        <div class="modal-header">
            <panda-modal-header id="add_project_page_title" page-icon="fa fa-plus-circle" page-title="<fmt:message key="add.project" bundle="${msg}" />"></panda-modal-header>

        </div>
        <div class="modal-body">
            <div data-ng-show="projectElements.projectStep">
            <form name="projectForm" method="POST" data-ng-submit="save(projectForm)" novalidate   >
            <div class="row" >
                <div class="col-md-12">
                    <div class="form-group" ng-class="{ 'text-danger' : projectForm.name.$invalid && formSubmitted}">
                        <div class="row">
                            <label  class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="common.name" bundle="${msg}" />
                                <span class="text-danger">*</span>
                            </label>
                            <div class="col-md-5 col-xs-12 col-sm-5">
                                <input required="true" id="add_project_name" type="text" name="name" data-ng-model="newProject.name" class="form-control" data-ng-class="{'error': projectForm.name.$invalid && formSubmitted}">
                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="name.of.the.project" bundle="${msg}" />" ></i>
                                <div class="error-area" data-ng-show="projectForm.name.$invalid && formSubmitted" ><i  ng-attr-tooltip="{{ projectForm.name.errorMessage || '<fmt:message key="project.name.is.required" bundle="${msg}" />' }}"  class="fa fa-warning error-icon"></i></div>
                            </div>
                        </div>
                    </div>

                    <div class="form-group" >
                        <div class="row">
                            <label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="common.description" bundle="${msg}" /><span class="m-l-xs"></span></label>
                            <div class="col-md-5 col-xs-12 col-sm-5">
                                <textarea name="description" id="add_project_description" data-ng-model="newProject.description" class="form-control"></textarea>
                            </div>

                        </div>
                    </div>
					<div data-ng-if="global.sessionValues.type == 'ROOT_ADMIN'">
						<div class="form-group" ng-class="{'text-danger':projectForm.domain.$invalid && formSubmitted}">
	                        <div class="row">
	                            <label class="col-md-3 col-xs-12 col-sm-3 control-label control-normal"><fmt:message key="common.domain" bundle="${msg}" /><span class="text-danger">*</span></label>
	                            <div class="col-md-7  col-sm-7 col-xs-12">
	                                <select required="true" id="add_project_domain" class="form-control input-group" name="domain" data-ng-model="newProject.domain" data-ng-change="changedomain(newProject.domain)" ng-options="domain.name for domain in formElements.domainList" data-ng-class="{'error': projectForm.domain.$invalid && formSubmitted}" >
	                                    <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
	                                </select>
	                                <i  tooltip="<fmt:message key="choose.domain" bundle="${msg}" /> " class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
	                                <div class="error-area" data-ng-show="projectForm.domain.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="domain.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
	                            </div>
	                        </div>
	                    </div>
                    </div>
					<div data-ng-if="global.sessionValues.type !== 'USER'">
                    <div class="form-group"ng-class="{'text-danger': projectForm.department.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-3 col-sm-3 control-label control-normal"><fmt:message key="common.department" bundle="${msg}" /><span class="text-danger">*</span></label>
                                <div class="col-md-7  col-sm-7 col-xs-7">
                                    <select required="true" id="add_project_department" class="form-control input-group" name="department" data-ng-model="newProject.department" data-ng-class="{'error': projectForm.department.$invalid && formSubmitted}" data-ng-options="department.userName for department in formElements.departmenttypeList" data-ng-class="{'error':  projectForm.department.$invalid && formSubmitted}" >
                                        <option value="">Select</option>

                                    </select>
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="choose.the.department" bundle="${msg}" />" ></i>
                                    <div class="error-area" data-ng-show="projectForm.department.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="department.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                    </div>
                    </div>

                    <div data-ng-if="global.sessionValues.type == 'USER'">
						<div class="form-group" >
	                        <div class="row">
	                            <label class="col-md-3 col-xs-12 col-sm-3 control-label control-normal"><fmt:message key="common.department" bundle="${msg}" /></label>
	                            <div class="col-md-7  col-sm-7 col-xs-12">
	                            <label class="control-label">{{project.department.userName}}</label>
	                            </div>
	                        </div>
	                    </div>
                    </div>

                    <!--<div class="hr-line-dashed"></div>-->
                <div class="form-group" ng-class="{'text-danger': projectForm.projectOwner.$invalid && formSubmitted}">

                        <div class="row" >
                            <label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="project.owner" bundle="${msg}" />
                            <span class="text-danger">*</span></label>
                            <div class="col-md-7 col-xs-7 col-sm-5">
                                <select required="true" class="form-control input-group" name="projectOwner" id="add_project_project_owner"
                                        data-ng-model="newProject.projectOwner" data-ng-class="{'error': projectForm.projectOwner.$invalid && formSubmitted}" data-ng-class="{'error':  projectForm.projectOwner.$invalid && formSubmitted}" data-ng-options="projectOwner.userName group by projectOwner.group for projectOwner in projectElements.projectOwnerList" >
                                    <option value="">Select a user</option>
                                </select>
                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="select.the.project.owner" bundle="${msg}" />" ></i>
                              <div class="error-area" data-ng-show="projectForm.projectOwner.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="projectOwner.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>

                            </div>
                        </div>
                    </div>

                    <hr>
                    <div class="row">
                        <div class="col-md-12">
                            <span class="pull-right">
                                <a class="btn btn-default" id = "add_project_cancel_button" data-ng-if="!showLoader" data-ng-click="cancel()"><fmt:message key="common.cancel" bundle="${msg}" /></a>

 <get-loader-image></get-loader-image>
 <button class="btn btn-info"  id = "add_project_add_button" data-ng-if="!showLoader"  type="submit"><fmt:message key="common.add" bundle="${msg}" /></button>
                            </span>
                        </div>

                    </div>
                    <!--<div class="hr-line-dashed"></div>-->

<!--                     <div class="form-group" ng-class="{ 'has-error' : projectForm.billingOwner.$invalid && formSubmitted}">

                        <div class="row" >
                            <label class="col-md-3 col-xs-12 col-sm-3 control-label">Project Owner
                                <span class="text-danger">*</span>
                            </label>
                            <div class="col-md-5 col-xs-12 col-sm-5">
                                <select required="true" class="form-control input-group" name="billingOwner"
                                        data-ng-model="project.billingOwner"

                                        data-ng-options="billingOwner.name group by billingOwner.group for billingOwner in projectElements.projectOwnerList" >
                                    <option value="">Select a user</option>
                                </select>
                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="Select the Billing Owner" ></i>
                                <span class="help-block m-b-none" ng-show="projectForm.billingOwner.$invalid && formSubmitted" >Billing owner is required.</span>

                            </div>
                            <div class="col-md-2 col-xs-12 col-sm-2">
                                <button class="btn btn-info m-l-lg" data-ng-click="createUser()">Create User</button>
                            </div>

                        </div>
                    </div>-->


                </div>
            </div>
            </form>
            </div>
            <div data-ng-hide="projectElements.projectStep">
                <div class="row" >
                    <div class="col-md-12">
                        <ul class="nav nav-tabs" data-ng-init="currentContent = 'account'">
                            <li class="active"><a href="javascript:void(0)" data-ng-click="currentContent = 'account'" data-toggle="tab"><fmt:message key="account" bundle="${msg}" /></a></li>
                            <li class=""><a href="javascript:void(0)" data-ng-click="currentContent = 'resource'" data-toggle="tab"><fmt:message key="resource" bundle="${msg}" /></a></li>
                        </ul>

                        <div class="tab-content">
                            <div class="tab-pane" data-ng-class="{'active' : currentContent == 'account'}" id="step1-tempalte">
                                <div data-ng-include src="'app/views/project/account.jsp'"></div>
                            </div>
                            <div class="tab-pane"  data-ng-class="{'active' : currentContent == 'resource'}" id="step1-iso">
                                <div data-ng-include src="'app/views/project/resource-limit.jsp'"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <hr>
                <div class="row">
                    <div class="col-md-12">
                        <span class="pull-right">
                            <a class="btn btn-default" id = "add_project_cancel_button"  data-ng-click="cancel()"><fmt:message key="common.cancel" bundle="${msg}" /></a>
                            <a class="btn btn-info" id = "add_project_back_button"  data-ng-click="projectElements.projectStep =!projectElements.projectStep"><fmt:message key="common.back" bundle="${msg}" /></a>
                        </span>
                    </div>

                </div>
            </div>
        </div>

    </div>