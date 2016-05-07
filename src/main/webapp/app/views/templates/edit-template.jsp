<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<form name="uploadTemplateForm" data-ng-submit="update(uploadTemplateForm, templates)" method="post" novalidate="" >
   <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header page-icon="pe-7s-upload" page-title="Edit Template"></panda-modal-header>
        </div>
                <div class="modal-body">
    <div class="row">
        <div class="col-md-12 col-sm-12">
            <div class="hpanel">
                <div class="panel-body">
                    <div class="col-md-6 col-sm-6 border-right">
                        <div class="form-group" ng-class="{'text-danger': uploadTemplateForm.name.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-3 col-sm-3 control-label"><fmt:message key="common.name" bundle="${msg}" /><span class="text-danger">*</span></label>
                                <div class="col-md-7  col-sm-7 col-xs-7">
                                    <input required="true" type="text" name="name" data-ng-model="templates.name" class="form-control" data-ng-class="{'error': uploadTemplateForm.name.$invalid && formSubmitted}">
                                    <i  tooltip="<fmt:message key="template.name.tooltip" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                    <div class="error-area" data-ng-show="uploadTemplateForm.name.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="template.name.error" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" ng-class="{'text-danger': uploadTemplateForm.description.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-3 col-sm-3 control-label"><fmt:message key="common.description" bundle="${msg}" /><span class="text-danger">*</span></label>
                                <div class="col-md-7  col-sm-7 col-xs-7">
                                    <div class="error-area" data-ng-show="uploadTemplateForm.description.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="template.description.error" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                    <input required="true" type="text" name="description" data-ng-model="templates.description" class="form-control" data-ng-class="{'error': uploadTemplateForm.description.$invalid && formSubmitted}" >
                                    <i  tooltip="<fmt:message key="template.description.tooltip" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" ng-class="{'text-danger': uploadTemplateForm.url.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-3 col-sm-3 control-label"><fmt:message key="common.url" bundle="${msg}" /><span class="text-danger">*</span></label>
                                <div class="col-md-7  col-sm-7 col-xs-7">
                                    <input required="true" type="text" name="url" data-ng-model="templates.url" class="form-control" data-ng-class="{'error': uploadTemplateForm.url.$invalid && formSubmitted}" readonly>
                                    <i  tooltip="<fmt:message key="template.url.tooltip" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                    <div class="error-area" data-ng-show="uploadTemplateForm.url.$invalid && formSubmitted" >
                                        <i  tooltip="<fmt:message key="template.url.error" bundle="${msg}" />" class="fa fa-warning error-icon"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" >
                            <div class="row">
                                <label class="col-md-3 col-sm-3 control-label"><fmt:message key="template.refurl" bundle="${msg}" /></label>
                                <div class="col-md-7  col-sm-7 col-xs-7">
                                    <input  type="text" name="refurl" data-ng-model="templates.referenceUrl" class="form-control" readonly>
                                    <i  tooltip="<fmt:message key="template.refurl.tooltip" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                </div>
                            </div>
                        </div>
                        <div class="form-group"ng-class="{'text-danger': uploadTemplateForm.zone.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-3 col-sm-3 control-label control-normal"><fmt:message key="template.zone" bundle="${msg}" /><span class="text-danger">*</span></label>
                                <div class="col-md-7  col-sm-7 col-xs-7">
                                    <input required="true" type="text" name="zone" data-ng-model="templates.zone.name" class="form-control" readonly data-ng-class="{'error': uploadTemplateForm.zone.$invalid && formSubmitted}">
                                    <div class="error-area" data-ng-show="uploadTemplateForm.zone.$invalid && formSubmitted" ><i  ng-attr-tooltip="<fmt:message key="template.zone.error" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" ng-class="{'text-danger': uploadTemplateForm.hypervisor.$invalid && formSubmitted}">                            <div class="row">
                                <label class="col-md-3 col-sm-3 control-label" ><fmt:message key="template.hypervisor" bundle="${msg}" /><span class="text-danger">*</span>
                                </label>
                               <div class="col-md-7  col-sm-7 col-xs-7">
                                    <input required="true" type="text" name="hypervisor" data-ng-model="templates.hypervisor.name" class="form-control" readonly data-ng-class="{'error': uploadTemplateForm.hypervisor.$invalid && formSubmitted}">
                                    <div class="error-area" data-ng-show="uploadTemplateForm.hypervisor.$invalid && formSubmitted" ><i  ng-attr-tooltip="<fmt:message key="template.hypervisor.error" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" data-ng-show="template.hypervisor.id == 4">
                                <div class="row">
                                <div class="col-md-6  col-sm-6 col-lg-6">
                                    <label> <input icheck type="checkbox" DISABLED ng-model="template.xsVersion"> <fmt:message key="template.originalxsversion" bundle="${msg}" /> </label>
                                </div>
                                <div class="col-md-6  col-sm-6 col-lg-6">
                                </div>
                            </div>
                        </div>
                        <div class="form-group" data-ng-show="template.hypervisor.id == 2">
                           <div class="row" >
                                <label class="col-md-3 col-sm-3 col-xs-3 control-label" ><fmt:message key="template.rootdiskcontroller" bundle="${msg}" /></label>
                                <div class="col-md-7  col-sm-7 col-xs-7">
                                    <select class="form-control input-group" name="rootDiskController" data-ng-model="templates.rootDiskController" ng-options="rootDiskController for (id, rootDiskController) in formElements.rootDiskControllerList" >
                                        <option value="">No Thanks</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" data-ng-show="template.hypervisor.id == 2">
                         <div class="row" >
                                <label class="col-md-3 col-sm-3 col-xs-3 control-label" ><fmt:message key="template.nicadapter" bundle="${msg}" /></label>
                                <div class="col-md-7  col-sm-7 col-xs-7">
                                    <select  class="form-control input-group" name="nicType" data-ng-model="templates.nicAdapter" ng-options="nicType for (id, nicType) in formElements.nicTypeList" >
                                        <option value="">No Thanks</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" data-ng-show="template.hypervisor.id == 2">
                         <div class="row" >
                                <label class="col-md-3 col-sm-3 col-xs-3 control-label" ><fmt:message key="template.keyboard" bundle="${msg}" /></label>
                                <div class="col-md-7  col-sm-7 col-xs-7">
                                    <select  class="form-control input-group" name="keyboardType" data-ng-model="templates.keyboardType" ng-options="keyboardType for (id, keyboardType) in formElements.keyboardTypeList" >
                                        <option value="">No Thanks</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="form-group"  ng-class="{'text-danger':uploadTemplateForm.format.$invalid && formSubmitted}">
                            <div class="row" >
                                <label class="col-md-3 col-sm-3 col-xs-3 control-label" ><fmt:message key="template.format" bundle="${msg}" /><span class="text-danger">*</span></label>
                                <div class="col-md-7  col-sm-7 col-xs-7">
                                    <input required="true" type="text" name="format" data-ng-model="templates.format" class="form-control" readonly data-ng-class="{'error': uploadTemplateForm.format.$invalid && formSubmitted}">
                                    <div class="error-area" data-ng-show="uploadTemplateForm.format.$invalid && formSubmitted" ><i  ng-attr-tooltip="<fmt:message key="template.format.error" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div>
                    <%--     <div class="form-group" ng-class="{'text-danger': uploadTemplateForm.cost.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-3 col-sm-3 control-label"><fmt:message key="template.cost" bundle="${msg}" /><span class="text-danger">*</span></label>
                                <div class="col-md-7  col-sm-7 col-xs-7">
                                    <input required="true" type="text" valid-price name="cost" data-ng-model="templates.templateCost[0].cost" class="form-control" data-ng-class="{'error': uploadTemplateForm.cost.$invalid && formSubmitted}" >
                                    <i  tooltip="<fmt:message key="template.cost.tooltip" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                    <div class="error-area" data-ng-show="uploadTemplateForm.cost.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="template.cost.error" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div> --%>
                        <div class="form-group" ng-class="{'text-danger': uploadTemplateForm.mincore.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-3 col-sm-3 control-label"><fmt:message key="template.minimumcore" bundle="${msg}" /><span class="text-danger">*</span></label>
                                <div class="col-md-7  col-sm-7 col-xs-7">
                                    <input required="true" valid-number type="text" name="mincore" data-ng-model="templates.minimumCore" class="form-control" data-ng-class="{'error': uploadTemplateForm.mincore.$invalid && formSubmitted}">
                                    <div class="error-area" data-ng-show="uploadTemplateForm.mincore.$invalid && formSubmitted" ><i  ng-attr-tooltip="<fmt:message key="template.minimumcore.error" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" ng-class="{'text-danger': uploadTemplateForm.minmemory.$invalid && formSubmitted}">
                                <div class="row">
                                <label class="col-md-3 col-sm-3 control-label"><fmt:message key="template.minimummemory" bundle="${msg}" /><span class="text-danger">*</span></label>
                                <div class="col-md-7  col-sm-7 col-xs-7">
                                    <input required="true" valid-number type="text" name="minmemory" data-ng-model="templates.minimumMemory" class="form-control" data-ng-class="{'error': uploadTemplateForm.minmemory.$invalid && formSubmitted}">
                                    <div class="error-area" data-ng-show="uploadTemplateForm.minmemory.$invalid && formSubmitted" ><i  ng-attr-tooltip="<fmt:message key="template.minimummemory.error" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-sm-6">
                        <div class="form-group" ng-class="{'text-danger': uploadTemplateForm.osCategory.$invalid && formSubmitted}">
                               <div class="row" >
                                <label class="col-md-3 col-sm-3 col-xs-3 control-label" ><fmt:message key="template.oscategory" bundle="${msg}" /><span class="text-danger">*</span></label>
                                <div class="col-md-7  col-sm-7 col-xs-7">
                                    <select required="true" class="form-control input-group" name="osCategory" data-ng-model="templates.osCategory"  value="{{templates.osCategory.name}}" ng-options="osCategory.name for osCategory in formElements.osCategoryList" data-ng-class="{'error': uploadTemplateForm.osCategory.$invalid && formSubmitted}" >
                                        <option value="">Select</option>
                                    </select>
                                    <div class="error-area" data-ng-show="uploadTemplateForm.osCategory.$invalid && formSubmitted" ><i  ng-attr-tooltip="<fmt:message key="template.oscategory.error" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" ng-class="{'text-danger': uploadTemplateForm.osType.$invalid && formSubmitted}">
                           <div class="row" >
                                <label class="col-md-3 col-sm-3 col-xs-3 control-label" ><fmt:message key="template.ostype" bundle="${msg}" /><span class="text-danger">*</span></label>
                                <div class="col-md-7  col-sm-7 col-xs-7">
                                    <input required="true" type="text" name="osType" data-ng-model="templates.osType.description" class="form-control" readonly data-ng-class="{'error': uploadTemplateForm.osType.$invalid && formSubmitted}">
                                    <div class="error-area" data-ng-show="uploadTemplateForm.osType.$invalid && formSubmitted" ><i  ng-attr-tooltip="<fmt:message key="template.ostype.error" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" ng-class="{'text-danger': uploadTemplateForm.osVersion.$invalid && formSubmitted}">
                             <div class="row" >
                                <label class="col-md-3 col-sm-3 col-xs-3 control-label" ><fmt:message key="template.osversion" bundle="${msg}" /><span class="text-danger">*</span></label>
                                <div class="col-md-7  col-sm-7 col-xs-7">
                                    <input required="true" type="text" name="osVersion" data-ng-model="templates.osVersion" class="form-control" data-ng-class="{'error': uploadTemplateForm.osVersion.$invalid && formSubmitted}">
                                    <div class="error-area" data-ng-show="uploadTemplateForm.osVersion.$invalid && formSubmitted" >
                                    	<i  ng-attr-tooltip="<fmt:message key="template.osversion.error" bundle="${msg}" />" class="fa fa-warning error-icon"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" ng-class="{'text-danger': uploadTemplateForm.architecture.$invalid && formSubmitted}">
                             <div class="row">
                                <label class="col-md-3 col-sm-3 col-xs-3 control-label" ><fmt:message key="template.architecture" bundle="${msg}" /><span class="text-danger">*</span></label>
                                <div class="col-md-6  col-sm-6 col-lg-6  col-sm-6 col-lg-6">
                                    <label> <input required="true" icheck type="radio" name= "architecture" ng-checked="templates.architecture=='64'" value="64" ng-model="templates.architecture"> 64 <fmt:message key="common.bit"  bundle="${msg}" /></label>
                                    <label  class="m-l-sm"> <input required="true" icheck type="radio" name= "architecture" ng-checked="templates.architecture=='32'" value="32" ng-model="templates.architecture"> 32 <fmt:message key="common.bit"  bundle="${msg}" /></label>
                                    <div class="error-area" data-ng-show="uploadTemplateForm.architecture.$invalid && formSubmitted" >
                                    	<i  ng-attr-tooltip="<fmt:message key="template.architecture.error" bundle="${msg}" />" class="fa error-icon"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-6  col-sm-6 col-lg-6  col-sm-6 col-lg-6">
                                    <label> <input icheck type="checkbox" ng-model="templates.extractable"> <span class="m-l-sm"><fmt:message key="template.extractable" bundle="${msg}" /></span> </label>
                                </div>
                                <div class="col-md-6  col-sm-6 col-lg-6  col-sm-6 col-lg-6">
                                    <label data-ng-if ="templates.passwordEnabled"> <input icheck type="checkbox" ng-model="templates.passwordEnabled"> <fmt:message key="template.password.enabled" bundle="${msg}" /></label>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
								 <div class="col-md-6  col-sm-6 col-lg-6">
                                    <label> <input icheck type="checkbox" ng-model="templates.share"> <span class="m-l-sm"><fmt:message key="template.share" bundle="${msg}" /></span> </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" data-ng-class="{'text-danger': uploadTemplateForm.summernoteTextTwo.$invalid && formSubmitted}">
                            <div class="row" >
                                <label class="col-md-3 col-sm-3 control-label "> <fmt:message key="template.detaileddescription" bundle="${msg}" /><span class="text-danger">*</span></label>
                                <div class="col-md-8 col-sm-8" data-ng-class="{'error': uploadTemplateForm.summernoteTextTwo.$invalid && formSubmitted}" >
                                    <summernote class=""  name="summernoteTextTwo" required="true" height="200"  data-ng-model="templates.detailedDescription"  config="summernoteOpt" data-ng-class="{'error': uploadTemplateForm.summernoteTextTwo.$invalid && formSubmitted}" ></summernote>
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon " tooltip="<fmt:message key="template.detaileddescription.tooltip" bundle="${msg}" />" ></i>
                                </div>
                                <div class="error-area" data-ng-show="uploadTemplateForm.summernoteTextTwo.$invalid && formSubmitted" ></div>
                            </div>
                        </div>
</div>

                    </div>
                </div>
            </div>
        </div>
    </div>
     <div class="modal-footer">
                        <div class="form-group">
                            <div class="col-md-12 col-sm-12">
                      	 <get-loader-image data-ng-show="showLoader"></get-loader-image>
                                <span  data-ng-hide="showLoader" class="pull-right">
                                    <a class="btn btn-default btn-outline"  data-ng-hide="showLoader" data-ng-click="cancel()"><fmt:message key="common.cancel" bundle="${msg}" /></a>
                                    <button class="btn btn-info" type="submit"  data-ng-hide="showLoader" ng-disabled="form.uploadTemplateForm.$invalid" ><fmt:message key="common.add" bundle="${msg}" /></button>
                                </span>
                            </div>
                        </div>
                        </div>
    </div>
</form>
