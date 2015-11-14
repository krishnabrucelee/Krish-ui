<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<form name="affinityForm" method="POST" data-ng-submit="save(affinityForm)" novalidate class="form-horizontal" >
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header page-icon="fa fa-link" page-title="<fmt:message key="create.new.affinity.group" bundle="${msg}" />"></panda-modal-header>

        </div>
        <div class="modal-body">
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group" ng-class="{ 'text-danger' : affinityForm.name.$invalid && formSubmitted}">
                        <div class="row">
                            <label  class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="common.name" bundle="${msg}" />
                                <span class="text-danger">*</span>
                            </label>
                            <div class="col-md-5 col-xs-12 col-sm-5">
                                <input required="true" type="text" name="name" data-ng-model="affinity.name" class="form-control" data-ng-class="{'error': affinityForm.name.$invalid && formSubmitted}" >
                                <div class="error-area" data-ng-show="affinityForm.name.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="name.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                            </div>
                        </div>
                    </div>

                    <div class="form-group" ng-class="{ 'text-danger' : affinityForm.description.$invalid && formSubmitted}">
                        <div class="row">
                            <label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="common.description" bundle="${msg}" />
                            </label>
                            <div class="col-md-8 col-xs-12 col-sm-8">
                                <textarea class="form-control" cols="12" rows="3" id="comment" name="reason" data-ng-model="reasondetails" required></textarea>
                            </div>

                        </div>
                    </div>

                    <!--<div class="hr-line-dashed"></div>-->
                    <div class="form-group" ng-class="{ 'text-danger' : affinityForm.type.$invalid && formSubmitted}">

                        <div class="row" >
                            <label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="common.type" bundle="${msg}" />
                                <span class="text-danger">*</span>
                            </label>
                            <div class="col-md-5 col-xs-12 col-sm-5">
                                <select required="true" class="form-control input-group" name="type" data-ng-model="affinity.type = 'host-anti-affinity'" data-ng-class="{'error': affinityForm.type.$invalid && formSubmitted}" >
                                    <option value="host-anti-affinity"><fmt:message key="host.anti-affinity" bundle="${msg}" /></option>
                                </select>
                            <div class="error-area" data-ng-show="affinityForm.type.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="type.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                            </div>

                        </div>
                    </div>

                    <!--<div class="hr-line-dashed"></div>-->
                </div>

            </div>
        </div>
        <div class="modal-footer">
            <a class="btn btn-default"  data-ng-click="cancel()"><fmt:message key="common.cancel" bundle="${msg}" /></a>
            <button class="btn btn-info" type="submit"><fmt:message key="common.add" bundle="${msg}" /></button>


        </div>
    </div>
</form>