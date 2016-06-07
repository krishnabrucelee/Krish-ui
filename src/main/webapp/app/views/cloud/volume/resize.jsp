<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<form name="volumeForm" method="POST" data-ng-submit="update(volumeForm, volume)" novalidate >
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header page-icon="fa fa-expand" page-title="<fmt:message key="resize.volume" bundle="${msg}" />"></panda-modal-header>

        </div>
        <div class="modal-body">
            <div class="row">
                <div class="col-md-12">

<%--                     <div class="form-group" >

                        <div class="row">
                            <label class="col-md-2 col-xs-12 col-sm-2 control-label"><fmt:message key="common.type" bundle="${msg}" /> <span class="m-l-xs"></span></label>
                            <div class="col-md-5 col-xs-12 col-sm-5">
                                <select  class="form-control input-group" name="diskOfferings"
                                        data-ng-model="volume.storageTags"
                                        data-ng-options="storageTags for storageTags in volumeElements.diskOfferingTags" >
                                    <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                                </select>

                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="Select the type" ></i>
                                <div class="error-area" data-ng-show="volumeForm.type.$invalid && formSubmitted" >
                                <i  tooltip="Type is Required" class="fa fa-warning error-icon"></i></div>

                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="Select the plan" ></i>

                            </div>
                        </div>
                    </div> --%>
                    <div class="form-group" ng-class="{ 'text-danger' : volumeForm.diskOfferings.$invalid && formSubmitted}">
                        <div class="row" >
                            <label class="col-md-2 col-xs-12 col-sm-2 control-label"><fmt:message key="volume.new.offering" bundle="${msg}" />
                                <span class="text-danger">*</span>
                            </label>
                            <div class="col-md-5 col-xs-12 col-sm-5">
                                <select required="true" class="form-control input-group" name="diskOfferings"
                                        data-ng-model="volume.storageOffering"
                                        data-ng-class="{'error': volumeForm.diskOfferings.$invalid && formSubmitted}"
                                        data-ng-options="storageOffering.description group by storageOffering.group for storageOffering in volumeElements.OfferingList" >
                                    <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                                </select>
                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="select.the.plan" bundle="${msg}" />" ></i>
                                <div class="error-area" data-ng-show="volumeForm.diskOfferings.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="plan.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                            </div>
                        </div>
                    </div>

				<div data-ng-if="volume.storageOffering.isCustomDisk || volume.storageOffering.diskSize < (volume.diskSize  / global.Math.pow(2, 30))">
                    <div class="form-group" >

                        <div class="row">
                            <label class="col-md-2 col-xs-12 col-sm-2 control-label"><fmt:message key="volume.shrink.ok" bundle="${msg}" /> <span class="m-l-xs"></span></label>
                            <div class="col-md-5 col-xs-12 col-sm-5">
      								 <label class="font-normal"> <input icheck
												type="checkbox" ng-model="volume.isShrink">
												</label>


                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="Shrink Volume" ></i>

                            </div>
                        </div>
                    </div>
				</div>

                    <div data-ng-show="volume.storageOffering.isCustomDisk">
						<div class="form-group"
							ng-class="{ 'text-danger' : volumeForm.diskSize <= 0 && formSubmitted}">
							<div class="row">
								<label class="col-md-2 col-xs-12 col-sm-2 control-label"><fmt:message
										key="common.size" bundle="${msg}" /> (GB) <span
									class="text-danger">*</span> </label>
								<div class="col-md-6 col-xs-12 col-sm-6">
									<rzslider rz-slider-model="volume.storageOffering.diskSize"
										data-ng-init="volume.storageOffering.diskSize=1"
										rz-slider-floor="volumeElements.diskOffer.diskSize.floor"
										rz-slider-ceil="volumeElements.diskOffer.diskSize.ceil"
										rz-slider-always-show-bar="true"></rzslider>
								</div>
								<div class="col-md-2 col-xs-12 col-sm-3">
									<input type="text"
										data-ng-min="{{ volumeElements.diskOffer.diskSize.floor }}"
										data-ng-max="{{ volumeElements.diskOffer.diskSize.ceil}}"
										class="form-control input-mini" name="diskSize"
										data-ng-model="volume.storageOffering.diskSize"
										valid-number="">
								</div>
							</div>
						</div>
						<div class="form-group" ng-class="{ 'text-danger' : volumeForm.diskMinIops <= 0 && formSubmitted}" data-ng-show="volume.storageOffering.isCustomizedIops">
                            <div class="row" >
                                <div class="col-md-6 col-sm-6">
                                    <div class="form-group" ng-class="{ 'text-danger' : volumeForm.diskMinIops <= 0 && OfferingSubmitted}">
                                        <label class="col-md-3 col-sm-3 control-label"><fmt:message key="min.iops" bundle="${msg}" /> 	 <span class="text-danger">*</span>
                                        </label>
                                        <div class="col-md-5 col-sm-5">
                                            <input class="form-control ng-pristine ng-valid ng-touched"
                                                   type="text" data-ng-model="volume.diskMinIops"
                                                   valid-number="" name="diskMinIops">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 col-sm-6">
                                    <div class="form-group" ng-class="{ 'text-danger' : volumeForm.diskMaxIops <= 0 && OfferingSubmitted}">
                                        <label class="col-md-3 col-sm-3 control-label"><fmt:message key="max.iops" bundle="${msg}" /><span class="text-danger">*</span>
                                        </label>
                                        <div class="col-md-5 col-sm-5">
                                            <input class="form-control ng-pristine ng-valid ng-touched"
                                                   type="text" data-ng-model="volume.diskMaxIops"
                                                   valid-number="" name="diskMaxIops">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
<!--             <span class="pull-left" data-ng-show="volume.storageOffering.isCustomDisk">
                <h4 class="text-danger price-text m-l-lg">
                    <app-currency></app-currency> <span data-ng-if="rsize">{{ (volume.storageOffering.storagePrice[0].costGbPerMonth * rsize)}}</span>
                    <span data-ng-if="rsize">{{ (volume.storageOffering.storagePrice[0].costGbPerMonth * 0)}}</span><span data-ng-if="!rsize">0</span> <span>/ hour</span>
                     <small class="text-right text-muted m-l-sm">(<app-currency></app-currency><span data-ng-if="rsize">{{ volume.storageOffering.storagePrice[0].costGbPerMonth * rsize * 720}} / month)</span><span data-ng-if="!rsize">0 / month)</span></small>
                </h4>
            </span> -->
             <get-loader-image data-ng-show="showLoader"></get-loader-image>
            <a class="btn btn-default"  data-ng-hide="showLoader" data-ng-click="cancel()"><fmt:message key="common.cancel" bundle="${msg}" /></a>
            <button class="btn btn-info" data-ng-hide="showLoader" type="submit"><fmt:message key="common.add" bundle="${msg}" /></button>
        </div>
    </div>
</form>