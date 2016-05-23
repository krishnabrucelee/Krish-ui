<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<form name="attachvolumeForm" method="POST" data-ng-submit="attachVolume(attachvolumeForm, volume)" novalidate >
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header page-icon="fa fa-ban"  page-title="<fmt:message key="attach.volume" bundle="${msg}" />"></panda-modal-header>
        </div>
        <div class="modal-body">
            <div class="row">
                <div class="col-md-12">
                    <h6 class="text-left m-l-md ">
                        <fmt:message key="attach.volume" bundle="${msg}" />
                    </h6>
                    <br/>
                    <div class="form-group" ng-class="{ 'text-danger' : attachvolumeForm.instancelist.$invalid && formSubmitted}">
                        <div class="row" >
                            <label class="col-md-offset-1 col-sm-offset-1  col-md-2 col-xs-3 col-sm-1 control-label "><fmt:message key="common.instance" bundle="${msg}" /><span class="text-danger">*</span>
                            </label>
                            <div class="col-md-5 col-xs-5 col-sm-5">
                                <select required="true" class="form-control input-group" name="instancelist"
                                        data-ng-model="vmInstance" data-ng-class="{'error': attachvolumeForm.instancelist.$invalid && formSubmitted}"
                                        data-ng-options="instance.name for instance in instanceList" >
                                    <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                                </select>
                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="volume.is.required.to.attach" bundle="${msg}" />" ></i>
                                <div class="error-area" data-ng-show="attachvolumeForm.instancelist.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="volume.is.required.to.attach" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
        <get-loader-image data-ng-show="showLoader"></get-loader-image>
            <a class="btn btn-default"  data-ng-hide="showLoader" data-ng-click="cancel()"><fmt:message key="common.cancel" bundle="${msg}" /></a>
            <button class="btn btn-info" data-ng-hide="showLoader" type="submit"><fmt:message key="common.add" bundle="${msg}" /></button>
        </div>
    </div>
</form>