<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<form name="archiveForm" method="POST" data-ng-submit="save(archiveForm)" novalidate  data-ng-controller="archiveCtrl">
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header page-icon="fa fa-file-archive-o"  page-title="{{ modalTitle}}"></panda-modal-header>

        </div>
        <div class="modal-body">
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group" ng-class="{'text-danger': archiveForm.type.$invalid && formSubmitted}">
                        <div class="row">
                            <label  class="col-md-3 col-xs-12 col-sm-2 control-label"><fmt:message key="by.type" bundle="${msg}" />
                            </label>
                            <div class="col-md-5 col-xs-12 col-sm-5">
                                <input required="true" type="text" name="type" data-ng-class="{'error': archiveForm.type.$invalid && formSubmitted}" data-ng-model="activity.type" class="form-control" >
                                <div class="error-area" data-ng-show="archiveForm.type.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="type.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group" ng-class="{'text-danger': archiveForm.startDate.$invalid && formSubmitted}">
                        <div class="row">
                            <label  class="col-md-3 col-xs-12 col-sm-2 control-label"><fmt:message key="by.date" bundle="${msg}" /> (<fmt:message key="start" bundle="${msg}" />)
                            </label>
                            <div class="col-md-5 col-xs-12 col-sm-5 ">

                                <div class="input-group">
                                    <input type="text" readonly name="startDate" data-ng-class="{'error': archiveForm.startDate.$invalid && formSubmitted}" class="form-control" datepicker-popup="{{global.date.format}}" data-ng-model="activity.startDate" is-open="activity.startDateOpened" datepicker-options="global.date.dateOptions" ng-required="true" close-text="Close" />
                                    <span class="input-group-btn">
                                        <button data-ng-class="{'error': archiveForm.startDate.$invalid && formSubmitted}"  type="button" class="btn btn-default" ng-click="open($event, 'startDateOpened')"><i class="glyphicon glyphicon-calendar"></i></button>
                                    </span>

                                </div>
                                <div class="error-area" data-ng-show="archiveForm.startDate.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="date.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>

                            </div>
                        </div>
                    </div>
                    <div class="form-group" ng-class="{'text-danger': archiveForm.endDate.$invalid && formSubmitted}">
                        <div class="row">
                            <label  class="col-md-3 col-xs-12 col-sm-2 control-label"><fmt:message key="by.date" bundle="${msg}" /> (<fmt:message key="end" bundle="${msg}" />)
                            </label>
                            <div class="col-md-5 col-xs-12 col-sm-5">
                                <div class="input-group">
                                    <input type="text" name="endDate" readonly class="form-control" data-ng-class="{'error': archiveForm.endDate.$invalid && formSubmitted}" datepicker-popup="{{global.date.format}}" data-ng-model="activity.endDate" is-open="activity.endDateOpened"  datepicker-options="global.date.dateOptions"  ng-required="true" close-text="Close" />
                                    <span class="input-group-btn">
                                        <button type="button" data-ng-class="{'error': archiveForm.endDate.$invalid && formSubmitted}" class="btn btn-default" ng-click="open($event, 'endDateOpened')"><i class="glyphicon glyphicon-calendar"></i></button>
                                    </span>
                                </div>
                                <div class="error-area" data-ng-show="archiveForm.endDate.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="date.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <a class="btn btn-default"  data-ng-click="cancel()"><fmt:message key="common.cancel" bundle="${msg}" /></a>
            <button class="btn btn-info"   type="submit"><fmt:message key="archive" bundle="${msg}" /></button>
        </div>
    </div>
</form>