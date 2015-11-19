<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<form name="volumeForm" method="POST" data-ng-submit="update(volumeForm, volume)" novalidate >
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header page-icon="fa fa-expand" page-title="<fmt:message key="resize.volume" bundle="${msg}" />"></panda-modal-header>

        </div>
        <div class="modal-body">
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group">
                        <div class="row">
                            <label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="common.name" bundle="${msg}" /> </label>
                            <div class="col-md-5 col-xs-12 col-sm-5">
                                <input  readonly="readonly" type="text" name="name" data-ng-model="volume.name" class="form-control" data-ng-class="{'error': volumeForm.name.$invalid && formSubmitted}" >
                                <i class="pe-7s-help1 pe-lg m-l-n-md tooltip-icon" tooltip="Name of the disk" ></i>
                            </div>

                        </div>
                    </div>

                          <div class="form-group" >
                        <div class="row">
                            <label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="common.type" bundle="${msg}" /> <span class="m-l-xs"></span></label>


                             <div class="col-md-5 col-xs-12 col-sm-5">
                                <select  class="form-control input-group" name="type"
                                        data-ng-model="volume.storageTags"
                                        data-ng-options="storageTags for storageTags in volumeElements.diskOfferingTags" >
                                    <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                                </select>
                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="Select the type" ></i>
                            </div>
                        </div>
                    </div>

                    <!--<div class="hr-line-dashed"></div>-->
                    <div class="form-group" ng-class="{ 'text-danger' : volumeForm.diskOfferings.$invalid && formSubmitted}">

                        <div class="row" >
                            <label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="common.plan" bundle="${msg}" />
                                <span class="text-danger">*</span>
                            </label>
                            <div class="col-md-5 col-xs-12 col-sm-5">
                                <select required="true" class="form-control input-group" name="diskOfferings" data-ng-class="{'error': volumeForm.diskOfferings.$invalid && formSubmitted}" data-ng-model="volume.diskOfferings" ng-options="diskOffering.name for diskOffering in volumeElements.diskOfferingList" >
                                    <option value="">Select</option>
                                </select>
                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="Select the plan" ></i>
                                <div class="error-area" data-ng-show="volumeForm.diskOfferings.$invalid && formSubmitted" ><i  tooltip="Plan is Required" class="fa fa-warning error-icon"></i></div>
                            </div>

                        </div>
                    </div>
                    <!--<div class="hr-line-dashed"></div>-->

                    <div data-ng-show="volume.diskOfferings.custom">
                        <div class="form-group" ng-class="{ 'text-danger' : volumeForm.volumeForm.diskOffer.diskSize.value.$invalid && formSubmitted.dynamic}">

                            <div class="row" >
                                <label class="col-md-3 col-xs-12 col-sm-3 control-label">Size (GB) :</label>
                                <div class="col-md-6 col-xs-12 col-sm-6">
                                    <rzslider rz-slider-model="volumeElements.diskOffer.diskSize.value" rz-slider-floor="volumeElements.diskOffer.diskSize.floor" rz-slider-ceil="volumeElements.diskOffer.diskSize.ceil" rz-slider-always-show-bar="true"></rzslider>
                                </div>
                                <div class="col-md-2 col-xs-12 col-sm-3">
                                    <input type="text" valid-number  data-ng-min="{{ volumeElements.diskOffer.diskSize.floor}}" data-ng-max="{{ volumeElements.diskOffer.diskSize.ceil}}"
                                           class="form-control input-mini" name="volumeForm.diskOffer.diskSize.value" data-ng-model="volumeElements.diskOffer.diskSize.value">
                                </div>
                            </div>
                        </div>
                        <!--<div class="hr-line-dashed"></div>-->

                        <div class="form-group" ng-class="{ 'text-danger' : volumeForm.volumeElements.diskOffer.iops.value.$invalid && formSubmitted.dynamic}">

                            <div class="row" >
                                <label class="col-md-3 col-xs-12 col-sm-3 control-label">IOPS (Kbps) :</label>
                                <div class="col-md-6 col-xs-12 col-sm-6">
                                    <rzslider  rz-slider-model="volumeElements.diskOffer.iops.value" rz-slider-floor="volumeElements.diskOffer.iops.floor" rz-slider-ceil="volumeElements.diskOffer.iops.ceil" rz-slider-always-show-bar="true"></rzslider>
                                </div>
                                <div class="col-md-2 col-xs-12 col-sm-3">
                                    <input type="text" valid-number  data-ng-min="{{ volumeElements.diskOffer.iops.floor}}" data-ng-max="{{ volumeElements.diskOffer.iops.ceil}}"
                                           class="form-control input-small" name="volumeElements.diskOffer.iops.value" data-ng-model="volumeElements.diskOffer.iops.value" data-ng-change="volumeElements.diskOffer.iops.value = volumeElements.diskOffer.iops.value">
                                </div>
                            </div>
                        </div>
                        <!--<div class="hr-line-dashed"></div>-->
                    </div>
                </div>
            </div>
        </div>
       <div class="modal-footer">

            <span class="pull-left" data-ng-show="volume.storageOffering.isCustomDisk">
                <h4 class="text-danger price-text m-l-lg">
                <app-currency></app-currency>{{ (volume.storageOffering.storagePrice[0].costGbPerMonth * volume.diskSize) }}    <span>/ hour</span>   <small class="text-right text-muted m-l-sm">(<app-currency></app-currency>{{ volume.storageOffering.storagePrice[0].costGbPerMonth * volume.diskSize * 720}} / month)</small>
                </h4>
            </span>
            <a class="btn btn-default"  data-ng-click="cancel()"><fmt:message key="common.cancel" bundle="${msg}" /></a>
            <button class="btn btn-info" type="submit"><fmt:message key="common.update" bundle="${msg}" /></button>


        </div>
    </div>
</form>