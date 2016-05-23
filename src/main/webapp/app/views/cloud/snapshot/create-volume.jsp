<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<form name="createVolumeForm" data-ng-submit="save(createVolumeForm, deleteObject)" method="post" novalidate="" data-ng-controller="snapshotListCtrl" >

    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header page-icon="fa fa-database pe-lg" page-title="Create Volume"></panda-modal-header>

        </div>

        <div class="modal-body">
            <div class="row"  >
                <div class="col-md-12">
                    <div class="form-group" ng-class="{'text-danger': createVolumeForm.disk.$invalid && formSubmitted}">
                        <div class="row" >
                            <label class="col-md-3 col-sm-3 control-label" >Disk
                                <span class="text-danger">*</span>
                            </label>
                            <div class="col-md-5 col-sm-5">
                                <input required="true" type="text" name="disk" data-ng-model="deleteObject.transVolumeName" class="form-control" data-ng-class="{'error': createVolumeForm.disk.$invalid && formSubmitted}">
                               <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="Name of the volume" ></i>
                              <div class="error-area" data-ng-show="createVolumeForm.disk.$invalid && formSubmitted" ><i  tooltip="Disk is required." class="fa fa-warning error-icon"></i></div>

                            </div>

                        </div>
                    </div>

                </div>
            </div>
        </div>
                       									<get-loader-image data-ng-show="showLoader"></get-loader-image>


        <div class="modal-footer">
            <button type="button" data-ng-hide="showLoader" class="btn btn-default " ng-click="cancel()" data-dismiss="modal">Cancel</button>
            <button class="btn btn-info" data-ng-hide="showLoader" type="submit">Create</button>

        </div></div>
</form>




