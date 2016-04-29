<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<form name="volumeForm" data-ng-submit="uploadVolume(volumeForm, volume)" method="POST" novalidate="">
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header page-icon="fa fa-database" page-title="<fmt:message key="common.upload" bundle="${msg}" />"></panda-modal-header>
        </div>
        <div class="modal-body">
            <div class="row"  >
                <div class="col-md-12">


					<div class="form-group" ng-class="{ 'text-danger' : volumeForm.name.$invalid && formSubmitted}">
                        <div class="row">
                            <label  class="col-md-3 col-xs-12 col-sm-2 control-label"><fmt:message key="common.name" bundle="${msg}" />
                                <span class="text-danger">*</span>
                            </label>
                            <div class="col-md-5 col-xs-12 col-sm-5">
                                <input required="true" type="text" name="name" data-ng-model="volume.name" class="form-control" data-ng-class="{'error': volumeForm.name.$invalid && formSubmitted}" >
                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="common.name" bundle="${msg}" />" ></i>
                                <div class="error-area" data-ng-show="volumeForm.name.$invalid && formSubmitted" >
                                <i ng-attr-tooltip="{{ volumeForm.name.errorMessage || '<fmt:message key="volume.required" bundle="${msg}" />' }}"
												class="fa fa-warning error-icon"></i>
							</div>
                            </div>
                        </div>
                    </div>

					<div class="form-group"ng-class="{'text-danger':volumeForm.zone.$invalid && formSubmitted}">
                        <div class="row">
                            <label class="col-md-3 col-xs-3 col-sm-3 control-label control-normal"><fmt:message key="common.zone" bundle="${msg}" /><span class="text-danger">*</span></label>
                            <div class="col-md-5  col-sm-5 col-xs-12">
                                <select required="true" class="form-control input-group" name="zone" data-ng-model="volume.zone" ng-options="zone.name for zone in zoneList" data-ng-class="{'error': volumeForm.zone.$invalid && formSubmitted}" >
                                    <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>

                                </select>
                                <i  tooltip="<fmt:message key="choose.zone" bundle="${msg}" /> " class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                <div class="error-area" data-ng-show="volumeForm.zone.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="zone.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                            </div>
                        </div>
                    </div>

                        <div class="form-group" ng-class="{'text-danger': volumeForm.url.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-3 col-sm-3 control-label"><fmt:message key="common.url" bundle="${msg}" /><span class="text-danger">*</span></label>
                                <div class="col-md-5  col-sm-5 col-xs-5">
                                    <input required="true" type="text" name="url" data-ng-model="volume.url" class="form-control" data-ng-class="{'error': volumeForm.url.$invalid && formSubmitted}" >
                                    <i  tooltip="<fmt:message key="volumeForm.url.tooltip" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                    <div class="error-area" data-ng-show="volumeForm.url.$invalid && formSubmitted" >
                                        <i  tooltip="<fmt:message key="volume.url.error" bundle="${msg}" />" class="fa fa-warning error-icon"></i>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <div class="form-group"  ng-class="{'text-danger':volumeForm.format.$invalid && formSubmitted}">
                            <div class="row" >
                                <label class="col-md-3 col-sm-3 col-xs-3 control-label" ><fmt:message key="volume.format" bundle="${msg}" /><span class="text-danger">*</span></label>
                                <div class="col-md-5  col-sm-5 col-xs-5">
                                    <select required="true" class="form-control input-group" name="format" data-ng-model="volume.format" ng-options="format for (id, format) in formElements.formatList" data-ng-class="{'error': volumeForm.format.$invalid && formSubmitted}" >
                                        <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                                    </select>
                                    <i tooltip="<fmt:message key="volume.format.tooltip" bundle="${msg}" />"  class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                    <div class="error-area" data-ng-show="volumeForm.format.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="volume.format.error" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div>

                        <div data-ng-if="global.sessionValues.type != 'ROOT_ADMIN'">
						<div class="form-group">
							<div class="row">
                            	<label class="col-md-3 col-xs-12 col-sm-2 control-label control-normal"><fmt:message key="common.domain" bundle="${msg}" /><span class="text-danger">*</span></label>
                            	<div class="col-md-5 col-xs-12 col-sm-5">
                                {{ global.sessionValues.domainName }}
                                <input type="hidden" name="domain"  data-ng-model="volume.domain" data-ng-init="volume.domainId=global.sessionValues.domainId" />
                            	</div>
                        	</div>
                        </div>
	                	</div>

	                	<div data-ng-if="global.sessionValues.type == 'ROOT_ADMIN'">
                        <div class="form-group" ng-class="{'text-danger':volumeForm.domain.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-3 col-xs-12 col-sm-2 control-label control-normal"><fmt:message key="common.company" bundle="${msg}" /><span class="text-danger">*</span>
                                </label>
                                <div class="col-md-5 col-xs-12 col-sm-5">
                                    <select  required="true" class="form-control form-group-lg" name="domain" data-ng-change="domainChange()"
                                             data-ng-model="volume.domain"
                                             data-ng-options="domain.name for domain in volumeElement.domainList" data-ng-class="{'error': volumeForm.domain.$invalid && formSubmitted}">
                                        <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                                    </select>
                                   	<i  tooltip="<fmt:message key="choose.domain" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                    <div class="error-area" data-ng-show="volumeForm.domain.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="company.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div>
                        </div>

                    <div class="form-group">
                        <div class="row" >
                            <label class="col-md-3 col-xs-3 col-sm-3 control-label"><fmt:message key="common.customOffering" bundle="${msg}" />
                            </label>
                            <div class="col-md-5 col-xs-5 col-sm-5">
                                <select class="form-control input-group" name="diskOfferings"
                                        data-ng-model="volume.storageOffering"
                                        data-ng-options="storageOffering.name for storageOffering in volumeElements.diskOfferingList | filter: {isCustomDisk:true}" >
                                    <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                                </select>
                            </div>
                        </div>
                    </div>


                        <div data-ng-if="global.sessionValues.type == 'ROOT_ADMIN'">
                        <div class="form-group"ng-class="{'text-danger': volumeForm.department.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-3 col-xs-12 col-sm-2 control-label control-normal"><fmt:message key="common.department" bundle="${msg}" /><span class="text-danger">*</span></label>
                                <div class="col-md-5 col-xs-12 col-sm-5">
                                    <select required="true" class="form-control input-group" ng-change="getProjectsByDepartment(volume.department)"
                                     name="department" data-ng-model="volume.department" ng-options="department.userName for department in volumeElement.departmentList" data-ng-class="{'error': volumeForm.department.$invalid && formSubmitted}" >
                                        <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                                    </select>
                                    <i  tooltip="<fmt:message key="common.department" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                    <div class="error-area" data-ng-show="volumeForm.department.$invalid && formSubmitted" >
                                    	<i ng-attr-tooltip="{{ volumeForm.department.errorMessage || '<fmt:message key="department.is.required" bundle="${msg}" />' }}"
												class="fa fa-warning error-icon"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        </div>

                       <div data-ng-if="global.sessionValues.type == 'DOMAIN_ADMIN'">
                        <div class="form-group"ng-class="{'text-danger': volumeForm.department.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-3 col-xs-12 col-sm-2 control-label control-normal"><fmt:message key="common.department" bundle="${msg}" /><span class="text-danger">*</span></label>
                                <div class="col-md-5 col-xs-12 col-sm-5">
                                    <select required="true" class="form-control input-group" ng-change="getProjectsByDepartment(volume.department)"
                                     name="department" data-ng-model="volume.department" ng-options="department.userName for department in departmentList" data-ng-class="{'error': volumeForm.department.$invalid && formSubmitted}" >
                                        <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>

                                    </select>
                                    <i  tooltip="<fmt:message key="common.department" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                    <div class="error-area" data-ng-show="volumeForm.department.$invalid && formSubmitted" >
                                    	<i ng-attr-tooltip="{{ volumeForm.department.errorMessage || '<fmt:message key="department.is.required" bundle="${msg}" />' }}"
												class="fa fa-warning error-icon"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        </div>

					<div data-ng-if="global.sessionValues.type == 'USER'">
                        <div class="form-group">
                            <div class="row">
                                <label class="col-md-3 col-xs-12 col-sm-2 control-label control-normal"><fmt:message key="common.department" bundle="${msg}" /><span class="text-danger">*</span></label>
                                <div class="col-md-5 col-xs-12 col-sm-5">
                                {{ userElement.department.userName }}
                                <input type="hidden" name="department"  data-ng-model="volume.department" data-ng-init="volume.departmentId=global.sessionValues.departmentId" />
                            	</div>
                            </div>
                        </div>
                        </div>

                      <div class="form-group" >
                        <div class="row">
                        <div data-ng-if="global.sessionValues.type != 'USER'">
                            <label class="col-md-3 col-xs-12 col-sm-2 control-label"><fmt:message key="common.project" bundle="${msg}" /> <span class="m-l-xs"></span></label>
                            <div class="col-md-5 col-xs-12 col-sm-5">
                                <select  class="form-control input-group" name="user"
                                        data-ng-model="volume.project"
                                        data-ng-options="options.name for options in options" >
                                    <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                                </select>

                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="Select the type" ></i>
                                <div class="error-area" data-ng-show="volumeForm.type.$invalid && formSubmitted" >
                                <i  tooltip="Type is Required" class="fa fa-warning error-icon"></i></div>

                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="common.project" bundle="${msg}" />" ></i>

                            </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-group" >
                        <div class="row">
                        <div data-ng-if="global.sessionValues.type == 'USER'">
                            <label class="col-md-3 col-xs-12 col-sm-2 control-label"><fmt:message key="common.project" bundle="${msg}" /> <span class="m-l-xs"></span></label>
                            <div class="col-md-5 col-xs-12 col-sm-5">
                                <select  class="form-control input-group" name="project"
                                        data-ng-model="volume.project"
                                        data-ng-options="options.name for options in options" >
                                    <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                                </select>
                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="Select the type" ></i>
                                <div class="error-area" data-ng-show="volumeForm.type.$invalid && formSubmitted" >
                                <i  tooltip="Type is Required" class="fa fa-warning error-icon"></i></div>

                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="common.project" bundle="${msg}" />" ></i>
                            </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <label class="col-md-3 col-sm-3 control-label"><fmt:message key="volume.md5checksum" bundle="${msg}" /></label>

                            <div class="col-md-5 col-sm-5">
                                <input type="text" name="md5checksum" data-ng-model="volume.md5checksum" class="form-control" >
                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="volume.MD5Checksum.tooltip" bundle="${msg}" />" ></i>

                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <span class="pull-left" data-ng-if="volume.storageOffering.name">
				<input type="hidden" readonly="readonly" data-ng-model= "storageOfferVolumeCostSum" data-ng-bind= "storageOfferVolumeCostSum =
				    (volume.storageOffering.storagePrice[0].costPerMonth
				    + (volume.storageOffering.storagePrice[0].costGbPerMonth > 0 ? volume.storageOffering.storagePrice[0].costGbPerMonth : 0))" />

				  <span data-ng-show="storageOfferVolumeCostSum > 0" class="text-danger price-text">
                       <app-currency></app-currency>{{storageOfferVolumeCostSum | number:4 }}
                       <span> /
                           <fmt:message key="common.day" bundle="${msg}" />
                       </span>

                  </span>
                  <span data-ng-hide="storageOfferVolumeCostSum > 0" class="font-bold text-success pricing-text">
                      <fmt:message key="free" bundle="${msg}" />
                  </span>
            </span>
            <get-loader-image data-ng-show="showLoader"></get-loader-image>
 			<a class="btn btn-default"  data-ng-hide="showLoader" data-ng-click="cancel()"><fmt:message key="common.cancel" bundle="${msg}" /></a>
            <button class="btn btn-info" data-ng-hide="showLoader" type="submit"><fmt:message key="upload.volume" bundle="${msg}" /></button>
        </div>
    </div>

</form>