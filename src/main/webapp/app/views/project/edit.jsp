<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="inmodal" >
    <div class="modal-header">
        <panda-modal-header page-icon="fa fa-plus-circle" page-title="<fmt:message key="edit.project" bundle="${msg}" />"></panda-modal-header>

    </div>
    <div class="modal-body">
        <div data-ng-show="projectElements.projectStep">
            <form name="projectForm" method="POST" data-ng-submit="update(projectForm)" novalidate   >
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group" >
                            <div class="row">
                                <label  class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="common.name" bundle="${msg}" />
                                    <span class="text-danger">*</span>
                                </label>
                                <div class="col-md-5 col-xs-12 col-sm-5">
                                    <input required="true" type="text" name="name" data-ng-model="project.name" readonly class="form-control" data-ng-class="{'error': projectForm.name.$invalid && formSubmitted}" >

                                </div>
                            </div>
                        </div>

                        <div class="form-group" >
                            <div class="row">
                                <label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="common.description" bundle="${msg}" /><span class="text-danger">*</span><span class="m-l-xs"></span></label>
                                <div class="col-md-5 col-xs-12 col-sm-5">
                                    <textarea name="description" data-ng-model="project.description" class="form-control"></textarea>
                                </div>

                            </div>
                        </div>

                        <!--<div class="hr-line-dashed"></div>-->
                        <div class="form-group" ng-class="{ 'text-danger' : projectForm.projectOwner.$invalid && formSubmitted}">

                            <div class="row" >
                                <label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="project.owner" bundle="${msg}" />
                                    <span class="text-danger">*</span>
                                </label>
                                <div class="col-md-5 col-xs-12 col-sm-5">

                                    <select required="true" class="form-control input-group" name="projectOwner" data-ng-model="project.projectOwner" data-ng-class="{'error': projectForm.projectOwner.$invalid && formSubmitted}"
                                        data-ng-options="projectOwner.userName for projectOwner in projectElements.projectOwnerList" >
                                    </select>
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="select.the.project.owner" bundle="${msg}" />"></i>
                                    <div class="error-area" data-ng-show="projectForm.projectOwner.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="project.owner.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>

                            </div>
                        </div>
                        <!--<div class="hr-line-dashed"></div>-->



                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12">
                        <span class="pull-right">
                            <a class="btn btn-default"  data-ng-click="cancel()"><fmt:message key="common.cancel" bundle="${msg}" /></a>
                            <img src="images/loading-bars.svg" data-ng-show="projectLoader" width="30" height="30" />
                            <button class="btn btn-info"  data-ng-hide="projectLoader"  type="submit"><fmt:message key="common.update" bundle="${msg}" /></button>
                        </span>
                    </div>
                </div>
            </form>
        </div>

        <div data-ng-hide="projectElements.projectStep">
            <div class="row" >
                <div class="col-md-12">
                    <ul class="nav nav-tabs" data-ng-init="currentContent = 'account'">
                        <li class="active"><a href="javascript:void(0)" data-ng-click="currentContent = 'account'" data-toggle="tab"> <fmt:message key="account" bundle="${msg}" /></a></li>
                        <li class=""><a href="javascript:void(0)" data-ng-click="currentContent = 'resource'" data-toggle="tab"> <fmt:message key="resource" bundle="${msg}" /></a></li>
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
                        <a class="btn btn-default"  data-ng-click="cancel()"><fmt:message key = "common.cancel" bundle = "${msg}" /></a>
                        <a class="btn btn-info"  data-ng-click="projectElements.projectStep = !projectElements.projectStep"><fmt:message key="common.back" bundle="${msg}" /></a>
                    </span>
                </div>

            </div>
        </div>
    </div>
