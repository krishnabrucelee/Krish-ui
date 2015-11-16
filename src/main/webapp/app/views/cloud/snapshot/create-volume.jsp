<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<form name="createVolumeForm" data-ng-submit="validateCreateVolume(createVolumeForm)" method="post" novalidate="" data-ng-controller="addVMSnapshotCtrl" >

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
                                <input required="true" type="text" name="disk" data-ng-model="createVolume.disk" class="form-control" data-ng-class="{'error': createVolumeForm.disk.$invalid && formSubmitted}">
                               <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="Name of the volume" ></i>
                              <div class="error-area" data-ng-show="createVolumeForm.disk.$invalid && formSubmitted" ><i  tooltip="Disk is required." class="fa fa-warning error-icon"></i></div>

                            </div>

                        </div>
                    </div>

                </div>
            </div>
        </div>


        <div class="modal-footer">
            <button type="button" class="btn btn-default " ng-click="cancel()" data-dismiss="modal">Cancel</button>
            <button class="btn btn-info" type="submit">Create</button>

        </div></div>
</form>




