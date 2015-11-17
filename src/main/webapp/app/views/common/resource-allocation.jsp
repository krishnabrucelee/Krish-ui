<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<form name="configForm" data-ng-submit="validateLogin(configForm)" method="post" novalidate="" data-ng-controller="quotaAllocationCtrl">

    <div class="row">
        <div class="col-md-12 col-sm-12">
            <div class="hpanel">
                <div class="panel-heading">

                    <div class="clearfix"></div>
                </div>
                <div class="panel-body">
                    <div class="col-md-12 col-sm-12 m-b-md border-bottom">

                        <div class="col-md-4 col-sm-4" data-ng-if="type == 'department-quota'" >
                            <div class="form-group">
                                <div class="row">
                                    <label class="col-md-3 col-sm-4 control-label"><fmt:message key="common.department" bundle="${msg}" />:
                                    </label>
                                    <div class="col-md-5 col-sm-6">
                                        <select   class="form-control input-group" name="department" data-ng-disabled="true" data-ng-model="department" ng-options="department.userName for department in departmentList" >
                                            <option value="">Select</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                          <div class="col-md-4 col-sm-4" data-ng-if="type == 'project-quota'">
                            <div class="form-group">
                                <div class="row">
                                    <label class="col-md-2 col-sm-3 control-label"><fmt:message key="common.project" bundle="${msg}" />:
                                    </label>
                                    <div class="col-md-5 col-sm-6">

                                        <select  class="form-control input-group" name="project"   data-ng-model="config.project" ng-options="project.name for project in projectList" >
                                            <option value="">Select</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="col-md-7 col-sm-7">
                        <div class="form-group" ng-class="{
                                            'text-danger'
                                            : configForm.maxVolume.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-4 col-sm-5 control-label"><fmt:message key="max.volumes" bundle="${msg}" />:
                                    <span class="text-danger">*</span>
                                </label>

                                <div class="col-md-4 col-sm-5">
                                    <input required="true" type="text" name="maxVolume" data-ng-model="config.maxVolume"  class="form-control" data-ng-class="{'error': configForm.maxVolume.$invalid && formSubmitted}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.volumes.to.be.allocated" bundle="${msg}" />" ></i>
                                    <div class="error-area" data-ng-show="configForm.maxVolume.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="max.volumes.are.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" ng-class="{
                                            'text-danger'
                                            : configForm.maxUser.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-4 col-sm-5 control-label"><fmt:message key="max.user.vms" bundle="${msg}" />:
                                    <span class="text-danger">*</span>
                                </label>
                                <div class="col-md-4 col-sm-5">
                                    <input required="true" type="text" name="maxUser" data-ng-model="config.maxUser"  class="form-control" data-ng-class="{'error': configForm.maxUser.$invalid && formSubmitted}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.user.vms.to.be.allocated" bundle="${msg}" />"></i>
                                    <div class="error-area" data-ng-show="configForm.maxUser.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="max.user.vms.are.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" ng-class="{
                                            'text-danger'
                                            : configForm.maxTemplates.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-4 col-sm-5 control-label"><fmt:message key="max.templates" bundle="${msg}" />:
                                    <span class="text-danger">*</span>
                                </label>
                                <div class="col-md-4 col-sm-5">
                                    <input required="true" type="text" name="maxTemplates" data-ng-model="config.maxTemplates"  class="form-control" data-ng-class="{'error': configForm.maxTemplates.$invalid && formSubmitted}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.templates.to.be.allocated" bundle="${msg}" />" ></i>
                                    <div class="error-area" data-ng-show="configForm.maxTemplates.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="max.templates.are.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" ng-class="{
                                            'text-danger'
                                            : configForm.maxNetworks.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-4 col-sm-5 control-label"><fmt:message key="max.networks" bundle="${msg}" />:
                                    <span class="text-danger">*</span>
                                </label>
                                <div class="col-md-4 col-sm-5">
                                    <input required="true" type="text" name="maxNetworks" data-ng-model="config.maxNetworks"  class="form-control" data-ng-class="{'error': configForm.maxNetworks.$invalid && formSubmitted}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.networks.to.be.allocated" bundle="${msg}" />" ></i>
                                    <div class="error-area" data-ng-show="configForm.maxNetworks.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="max.networks.are.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" ng-class="{
                                            'text-danger'
                                            : configForm.maxSnapshots.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-4 col-sm-5 control-label"><fmt:message key="max.snapshots" bundle="${msg}" />:
                                    <span class="text-danger">*</span>
                                </label>
                                <div class="col-md-4 col-sm-5">
                                    <input required="true" type="text" name="maxSnapshots" data-ng-model="config.maxSnapshots"  class="form-control" data-ng-class="{'error': configForm.maxSnapshots.$invalid && formSubmitted}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.snapshots.to.be.allocated" bundle="${msg}" />" ></i>
                                    <div class="error-area" data-ng-show="configForm.maxSnapshots.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="max.snapshots.are.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" ng-class="{
                                            'text-danger'
                                            : configForm.maxPublicIPs.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-4 col-sm-5 control-label"><fmt:message key="max.public.ips" bundle="${msg}" />:
                                    <span class="text-danger">*</span>
                                </label>
                                <div class="col-md-4 col-sm-5">
                                    <input required="true" type="text" name="maxPublicIPs" data-ng-model="config.maxPublicIPs"  class="form-control" data-ng-class="{'error': configForm.maxPublicIPs.$invalid && formSubmitted}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.public.ips.to.be.allocated" bundle="${msg}" />" ></i>
                                    <div class="error-area" data-ng-show="configForm.maxPublicIPs.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="max.public.ips.are.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" ng-class="{
                                            'text-danger'
                                            : configForm.maxVpcs.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-4 col-sm-5 control-label"><fmt:message key="max.vpcs" bundle="${msg}" />:
                                    <span class="text-danger">*</span>
                                </label>
                                <div class="col-md-4 col-sm-5">
                                    <input required="true" type="text" name="maxVpcs" data-ng-model="config.maxVpcs"  class="form-control" data-ng-class="{'error': configForm.maxVpcs.$invalid && formSubmitted}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.vpcs.to.be.allocated" bundle="${msg}" />"></i>
                                    <div class="error-area" data-ng-show="configForm.maxVpcs.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="max.vpcs.are.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" ng-class="{
                                            'text-danger'
                                            : configForm.maxCPU.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-4 col-sm-5 control-label"><fmt:message key="max.cpu.cores" bundle="${msg}" />:
                                    <span class="text-danger">*</span>
                                </label>
                                <div class="col-md-4 col-sm-5">
                                    <input required="true" type="text" name="maxCPU" data-ng-model="config.maxCPU"  class="form-control" data-ng-class="{'error': configForm.maxCPU.$invalid && formSubmitted}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.cpu.cores.to.be.allocated" bundle="${msg}" />" ></i>
                                    <div class="error-area" data-ng-show="configForm.maxCPU.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="max.cpu.cores.are.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" ng-class="{
                                            'text-danger'
                                            : configForm.maxMemory.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-4 col-sm-5 control-label"><fmt:message key="max.memory" bundle="${msg}" /> (MiB):
                                    <span class="text-danger">*</span>
                                </label>
                                <div class="col-md-4 col-sm-5">
                                    <input required="true" type="text" name="maxMemory" data-ng-model="config.maxMemory"  class="form-control" data-ng-class="{'error': configForm.maxMemory.$invalid && formSubmitted}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.memory.to.be.allocated" bundle="${msg}" />" ></i>
                                    <div class="error-area" data-ng-show="configForm.maxMemory.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="max.memory.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" ng-class="{
                                            'text-danger'
                                            : configForm.maxPrimary.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-4 col-sm-5 control-label"><fmt:message key="max.primary" bundle="${msg}" /> (GiB):
                                    <span class="text-danger">*</span>
                                </label>
                                <div class="col-md-4 col-sm-5">
                                    <input required="true" type="text" name="maxPrimary" data-ng-model="config.maxPrimary"  class="form-control" data-ng-class="{'error': configForm.maxPrimary.$invalid && formSubmitted}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.primary.storage.to.be.allocated" bundle="${msg}" />" ></i>
                                    <div class="error-area" data-ng-show="configForm.maxPrimary.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="max.primary.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" ng-class="{
                                            'text-danger'
                                            : configForm.maxSecondary.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-4 col-sm-5 control-label"><fmt:message key="max.secondary" bundle="${msg}" /> (GiB):
                                    <span class="text-danger">*</span>
                                </label>
                                <div class="col-md-4 col-sm-5">
                                    <input required="true" type="text" name="maxSecondary" data-ng-model="config.maxSecondary"  class="form-control" data-ng-class="{'error': configForm.maxSecondary.$invalid && formSubmitted}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.secondary.storage.to.be.allocated" bundle="${msg}" />" ></i>
                                    <div class="error-area" data-ng-show="configForm.maxSecondary.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="max.secondary.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="col-md-4 col-sm-5 control-label">
                                </label>
                                <div class="col-md-4 col-sm-5">
                                    <a class="btn btn-default btn-outline"  href="#/configuration/chargeback"><fmt:message key="common.cancel" bundle="${msg}" /></a>
                                    <button class="btn btn-info" type="submit"><fmt:message key="common.update" bundle="${msg}" /></button>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>


        </div>
    </div>
    </form>