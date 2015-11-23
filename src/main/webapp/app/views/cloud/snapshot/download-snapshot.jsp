<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<form name="confirmsnapshot" data-ng-submit="validateConfirmSnapshot(confirmsnapshot)" method="post" novalidate=""   >
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header hide-zone="true" page-icon="fa fa-camera" page-title="Create Snapshot"></panda-modal-header>
        </div>

        <div class="modal-body">
            <div class=" row">
                <div class="col-md-12">
                    <div class="form-group" >
                        <div class="row" >
                            <label class="col-md-3 col-sm-3 control-label" >Disk Name:

                            </label>
                            <div class="col-md-9 col-sm-9 ">
                                <span class=" text-center">{{ volume.name }} </span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group" ng-class="{'text-danger': confirmsnapshot.name.$invalid && formSubmitted}">
                        <div class="row" >
                            <label class="col-md-3 col-sm-3 control-label" >Name
                                <span class="text-danger">*</span>
                            </label>
                            <div class="col-md-5 col-sm-5">
                                <input required="true" type="text" name="name" data-ng-model="snapshot.name" class="form-control" data-ng-class="{'error': confirmsnapshot.name.$invalid && formSubmitted}" >
                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="Name of the snapshot" ></i>
                                <div class="error-area" data-ng-show="confirmsnapshot.name.$invalid && formSubmitted" >
                                <i  tooltip="{{ confirmsnapshot.name.errorMessage || 'Snapshot Name is required' }}" class="fa fa-warning error-icon"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <span class="pull-left">
                <h4 class="text-danger price-text m-l-lg">
                    <app-currency></app-currency>0.10 <span>/ hour</span> <span>/GB</span>
                </h4>
            </span>
            <button type="button" class="btn btn-default " ng-click="cancel()" data-dismiss="modal2">Cancel</button>
            <button class="btn btn-info" type="submit">Create</button>
        </div>
    </div>
</form>