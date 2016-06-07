<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<form name="confirmsnapshot" data-ng-submit="validateConfirmSnapshot(confirmsnapshot)" method="post" novalidate=""   >
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header hide-zone="true" page-icon="fa fa-camera" page-title="<fmt:message key="create.snapshot" bundle="${msg}" />"></panda-modal-header>
        </div>

        <div class="modal-body">
            <div class=" row">
                <div class="col-md-12">
                    <div class="form-group" >
                        <div class="row" >
                            <label class="col-md-3 col-sm-3 control-label" ><fmt:message key="disk.name" bundle="${msg}" />:

                            </label>
                            <div class="col-md-9 col-sm-9 ">
                                <span class=" text-center">{{ volume.name }} </span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group" ng-class="{'text-danger': confirmsnapshot.name.$invalid && formSubmitted}">
                        <div class="row" >
                            <label class="col-md-3 col-sm-3 control-label" ><fmt:message key="common.name" bundle="${msg}" />
                                <span class="text-danger">*</span>
                            </label>
                            <div class="col-md-5 col-sm-5">
                                <input required="true" type="text" name="name" data-ng-model="snapshot.name" class="form-control" data-ng-class="{'error': confirmsnapshot.name.$invalid && formSubmitted}" >
                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="name.of.the.snapshot" bundle="${msg}" />" ></i>
                                <div class="error-area" data-ng-show="confirmsnapshot.name.$invalid && formSubmitted" >
                                <i  tooltip="{{ confirmsnapshot.name.errorMessage || '<fmt:message key="snapshot.name.is.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <!-- <span class="pull-left">
                <h4 class="text-danger price-text m-l-lg">
                    <app-currency></app-currency>0.10 <span>/ hour</span> <span>/GB</span>
                </h4>
            </span> -->
                                   									<get-loader-image data-ng-show="showLoader"></get-loader-image>
            <button type="button" data-ng-hide="showLoader"  class="btn btn-default " ng-click="cancel()" data-dismiss="modal2"><fmt:message key="common.cancel" bundle="${msg}" /></button>
            <button class="btn btn-info" data-ng-hide="showLoader"  type="submit"><fmt:message key="common.create" bundle="${msg}" /></button>
        </div>
    </div>
</form>