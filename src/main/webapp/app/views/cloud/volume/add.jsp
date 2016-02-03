<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<form name="volumeForm" method="POST" data-ng-submit="save(volumeForm, volume)" novalidate >
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header page-icon="fa fa-database" page-title="<fmt:message key="add.volume" bundle="${msg}" />"></panda-modal-header>
        </div>
        <div class="modal-body">
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group" data-ng-class="{ 'text-danger' : volumeForm.name.$invalid && formSubmitted}">
                        <div class="row">
                            <label  class="col-md-3 col-xs-12 col-sm-2 control-label"><fmt:message key="common.name" bundle="${msg}" />
                                <span class="text-danger">*</span>
                            </label>
                            <div class="col-md-5 col-xs-12 col-sm-5">
                                <input required="true" type="text" name="name" data-ng-model="volume.name" class="form-control" data-ng-class="{'error': volumeForm.name.$invalid && formSubmitted}" >
                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="common.name" bundle="${msg}" />" ></i>
                                <div class="error-area" data-ng-show="volumeForm.name.$invalid && formSubmitted" >
                                <i ng-attr-tooltip="{{ volumeForm.name.errorMessage || '<fmt:message key="volume.required" bundle="${msg}" />' }}"
									class="fa fa-warning error-icon">
								</i>
							</div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group" >
                        <div class="row">
                            <label class="col-md-3 col-xs-12 col-sm-2 control-label"><fmt:message key="common.type" bundle="${msg}" /> <span class="m-l-xs"></span></label>
                            <div class="col-md-5 col-xs-12 col-sm-5">
                                <select  class="form-control input-group" name="diskOfferingsTags"
                                        data-ng-model="volume.storageTags"
                                        data-ng-options="storageTags for storageTags in volumeElements.diskOfferingTags" >
                                    <option value="">
                                    	<fmt:message key="common.select" bundle="${msg}" />
                                    </option>
                                </select>
                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="Select the type" ></i>
                                <div class="error-area" data-ng-show="volumeForm.type.$invalid && formSubmitted" >
                                	<i  tooltip="Type is Required" class="fa fa-warning error-icon"></i>
                                </div>
                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="common.type" bundle="${msg}" />" ></i>
                            </div>
                        </div>
                    </div>
                    <div class="form-group" data-ng-class="{ 'text-danger' : volumeForm.diskOfferings.$invalid && formSubmitted}">
                        <div class="row" >
                            <label class="col-md-3 col-xs-12 col-sm-2 control-label"><fmt:message key="common.plan" bundle="${msg}" />
                                <span class="text-danger">*</span>
                            </label>
                            <div class="col-md-5 col-xs-12 col-sm-5">
                                <select required="true" class="form-control input-group" name="diskOfferings"
                                        data-ng-model="volume.storageOffering"
                                        data-ng-class="{'error': volumeForm.diskOfferings.$invalid && formSubmitted}"
                                        data-ng-options="storageOffering.name for storageOffering in volumeElements.diskOfferingList" >
                                    <option value="">
                                    	<fmt:message key="common.select" bundle="${msg}" />
                                    </option>
                                </select>
                                <i  tooltip="<fmt:message key="common.plan" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                    <div class="error-area" data-ng-show="volumeForm.diskOfferings.$invalid && formSubmitted" >
                                    	<i ng-attr-tooltip="{{ volumeForm.diskOfferings.errorMessage || '<fmt:message key="plan.is.required" bundle="${msg}" />' }}"
											class="fa fa-warning error-icon">
										</i>
                                    </div>
                            </div>
                        </div>
                    </div>
					<div data-ng-if="volume.storageOffering.isCustomDisk">
						<div class="form-group"
							data-ng-class="{ 'text-danger' : volumeForm.diskSize <= 0 && volumeForm.diskSize.$invalid && formSubmitted}">
							<div class="row">
								<label class="col-md-3 col-xs-12 col-sm-2 control-label"><fmt:message key="common.size" bundle="${msg}" />
									<fmt:message key="common.gb" bundle="${msg}" /> <span class="text-danger">*</span>
								</label>
								<div class="col-md-6 col-xs-12 col-sm-6">
									<rzslider rz-slider-model="volume.diskSize"
										data-ng-init="volume.diskSize=1"
										rz-slider-floor="volumeElements.diskOffer.diskSize.floor"
										rz-slider-ceil="volumeElements.diskOffer.diskSize.ceil"
										rz-slider-always-show-bar="true">
									</rzslider>
								</div>
								<div class="col-md-2 col-xs-12 col-sm-3">
									<input required="true" type="text"
										data-ng-min="{{ volumeElements.diskOffer.diskSize.floor }}"
										data-ng-max="{{ volumeElements.diskOffer.diskSize.ceil}}"
										class="form-control input-mini" name="diskSize"
										data-ng-model="volume.diskSize" valid-number="">
									<div class="error-area"
										data-ng-show="volumeForm.diskOfferings.$invalid && formSubmitted">
										<i ng-attr-tooltip="{{ volumeForm.diskOfferings.errorMessage || '<fmt:message key="plan.is.required" bundle="${msg}" />' }}"
											class="fa fa-warning error-icon">
										</i>
									</div>
								</div>
							</div>
						</div>
						<div class="form-group"
							data-ng-class="{ 'text-danger' :  volumeForm.diskMinIops.$invalid && formSubmitted}"
							data-ng-if="volume.storageOffering.isCustomizedIops">
							<div class="row">
								<div class="col-md-6 col-sm-6">
									<div class="form-group"
										data-ng-class="{ 'text-danger' : volumeForm.diskMinIops.$invalid && OfferingSubmitted}">
										<label class="col-md-4 col-sm-4 control-label"><fmt:message
												key="min.iops" bundle="${msg}" /> <span class="text-danger">*</span>
										</label>
										<div class="col-md-5 col-sm-5">
											<input required="true"
												class="form-control"
												type="text" data-ng-model="volume.diskMinIops"
												valid-number="" name="diskMinIops" data-ng-class="{'error': volumeForm.diskMinIops.$invalid && formSubmitted}">
											<div class="error-area"
												data-ng-show="volumeForm.diskMinIops.$invalid && formSubmitted">
												<i ng-attr-tooltip="{{ volumeForm.diskMinIops.errorMessage || '<fmt:message key="min.iops.required" bundle="${msg}" />' }}"
													class="fa fa-warning error-icon">
												</i>
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-6 col-sm-6">
									<div class="form-group"
										data-ng-class="{ 'text-danger' : volumeForm.diskMaxIops.$invalid && OfferingSubmitted}">
										<label class="col-md-4 col-sm-4 control-label">
											<fmt:message key="max.iops" bundle="${msg}" /><span class="text-danger">*</span>
										</label>
										<div class="col-md-5 col-sm-5">
											<input required="true"
												class="form-control"
												type="text" data-ng-model="volume.diskMaxIops"
												valid-number="" name="diskMaxIops" data-ng-class="{'error': volumeForm.diskMaxIops.$invalid && formSubmitted}">
											<div class="error-area" data-ng-show="volumeForm.diskMaxIops.$invalid && formSubmitted">
												<i ng-attr-tooltip="{{ volumeForm.diskMaxIops.errorMessage || '<fmt:message key="max.iops.required" bundle="${msg}" />' }}"
													class="fa fa-warning error-icon">
												</i>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group"
						data-ng-class="{ 'text-danger' : volumeForm.department.$invalid && formSubmitted}">
						<div class="row">
							<div data-ng-show="global.sessionValues.type != 'USER'">
								<label class="col-md-3 col-xs-12 col-sm-2 control-label control-normal">
									<fmt:message key="common.department" bundle="${msg}" /> <span class="text-danger">*</span>
								</label>
								<div class="col-md-5 col-xs-12 col-sm-5">
									<select required="true" class="form-control input-group"
										name="department" data-ng-model="volume.department"
										ng-change="getProjectsByDepartment(volume.department)"
										ng-options="department.userName for department in volumeElements.departmentList"
										data-ng-class="{'error': volumeForm.department.$invalid && formSubmitted}">
										<option value="">
											<fmt:message key="common.select" bundle="${msg}" />
										</option>
									</select>
									<i tooltip="<fmt:message key="common.department" bundle="${msg}" />"
										class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon">
									</i>
									<div class="error-area"
										data-ng-show="volumeForm.department.$invalid && formSubmitted">
										<i ng-attr-tooltip="{{ volumeForm.department.errorMessage || '<fmt:message key="department.is.required" bundle="${msg}" />' }}"
											class="fa fa-warning error-icon">
										</i>
									</div>
								</div>
							</div>
							<div data-ng-show="global.sessionValues.type == 'USER'">
								<label class="col-md-3 col-xs-12 col-sm-2 control-label control-normal">
									<fmt:message key="common.department" bundle="${msg}" />
								</label>
								<div class="col-md-5 col-xs-12 col-sm-5">
									<label>{{volume.department.userName}}</label>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="row">
							<div data-ng-if="global.sessionValues.type != 'USER'">
								<label class="col-md-3 col-xs-12 col-sm-2 control-label">
									<fmt:message key="common.project" bundle="${msg}" /> <span class="m-l-xs"></span>
								</label>
								<div class="col-md-5 col-xs-12 col-sm-5">
									<select class="form-control input-group" name="user"
										data-ng-model="volume.project"
										data-ng-options="options.name for options in options">
										<option value="">
											<fmt:message key="common.select" bundle="${msg}" />
										</option>
									</select>
									<i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"
										tooltip="Select the type">
									</i>
									<div class="error-area"
										data-ng-show="volumeForm.type.$invalid && formSubmitted">
										<i tooltip="Type is Required" class="fa fa-warning error-icon"></i>
									</div>

									<i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"
										tooltip="<fmt:message key="common.project" bundle="${msg}" />">
									</i>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="row">
							<div data-ng-if="global.sessionValues.type == 'USER'">
								<label class="col-md-3 col-xs-12 col-sm-2 control-label">
									<fmt:message key="common.project" bundle="${msg}" /> <span class="m-l-xs"></span>
								</label>
								<div class="col-md-5 col-xs-12 col-sm-5">
									<select class="form-control input-group" name="project"
										data-ng-model="volume.project"
										data-ng-options="options.name for options in options">
										<option value="">
											<fmt:message key="common.select" bundle="${msg}" />
										</option>
									</select>
									<i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"
										tooltip="Select the type">
									</i>
									<div class="error-area"
										data-ng-show="volumeForm.type.$invalid && formSubmitted">
										<i tooltip="Type is Required" class="fa fa-warning error-icon"></i>
									</div>
									<i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"
										tooltip="<fmt:message key="common.project" bundle="${msg}" />">
									</i>
								</div>
							</div>
						</div>
					</div>
				</div>
           	</div>
       	</div>
        <div class="modal-footer">
<!--         <span class="pull-left" data-ng-show="volume.storageOffering.isCustomDisk">
                <h4 class="text-danger price-text m-l-lg">
                    <app-currency></app-currency> <span data-ng-if="volume.diskSize">{{ (volume.storageOffering.storagePrice[0].costGbPerMonth * volume.diskSize)}}</span>
                    <span data-ng-if="volume.diskSize">{{ (volume.storageOffering.storagePrice[0].costGbPerMonth * 0)}}</span><span data-ng-if="!volume.diskSize">0</span> <span>/ hour</span>
                     <small class="text-right text-muted m-l-sm">(<app-currency></app-currency><span data-ng-if="volume.diskSize">{{ volume.storageOffering.storagePrice[0].costGbPerMonth * volume.diskSize * 720}} / month)</span><span data-ng-if="!volume.diskSize">0 / month)</span></small>
                </h4>
            </span> -->
            <get-loader-image data-ng-show="showLoader"></get-loader-image>
            <a class="btn btn-default"  data-ng-hide="showLoader" data-ng-click="cancel()"><fmt:message key="common.cancel" bundle="${msg}" /></a>
            <button class="btn btn-info" data-ng-hide="showLoader" type="submit"><fmt:message key="common.add" bundle="${msg}" /></button>
        </div>
    </div>
</form>