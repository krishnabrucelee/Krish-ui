<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<form name="affinityGroupForm" data-ng-submit="save(affinityGroupForm, affinityGroup)" method="post" novalidate="">

	<div class="inmodal">
		<div class="modal-header">
			<panda-modal-header page-icon="fa fa-plus-circle"
				page-title="<fmt:message key="add.new.affinity.group" bundle="${msg}" />"></panda-modal-header>
		</div>

		<div class="modal-body">
			<div class="row m-t-lg">
			<div class="col-md-12">
				<div class="form-group" ng-class="{'text-danger': affinityGroupForm.name.$invalid && formSubmitted}">
                    <div class="row">
                        <label class="col-md-4 col-sm-3 control-label"><fmt:message key="common.name" bundle="${msg}" /><span class="text-danger">*</span></label>
                        <div class="col-md-6  col-sm-7 col-xs-7">
                            <input required="true" type="text" name="name" data-ng-model="affinityGroup.name" class="form-control" data-ng-class="{'error': affinityGroupForm.name.$invalid && formSubmitted}">
                            <i  tooltip="<fmt:message key="affinityGroup.name.tooltip" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                            <div class="error-area" data-ng-show="affinityGroupForm.name.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="affinityGroup.name.error" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                        </div>
                    </div>
                </div>
                <div class="form-group" >
                    <div class="row">
                        <label class="col-md-4 col-sm-3 control-label"><fmt:message key="common.description" bundle="${msg}" /></label>
                        <div class="col-md-6  col-sm-7 col-xs-7">
                            <textarea cols="12" rows="3" name="description" data-ng-model="affinityGroup.description" class="form-control"></textarea>
                            <i  tooltip="<fmt:message key="affinityGroup.description.tooltip" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                        </div>
                    </div>
                </div>
                <div class="form-group" ng-class="{'text-danger': affinityGroupForm.affinityGroupType.$invalid && formSubmitted}">
                    <div class="row" >
                        <label class="col-md-4 col-sm-3 col-xs-3 control-label" ><fmt:message key="affinityGroup.affinityGroupType" bundle="${msg}" /><span class="text-danger">*</span></label>
                        <div class="col-md-6  col-sm-7 col-xs-7">
                            <select required="true" class="form-control input-group" name="affinityGroupType" data-ng-model="affinityGroup.affinityGroupType" ng-options="affinityGroupType.type for affinityGroupType in formElements.affinityGroupTypeList" data-ng-class="{'error': affinityGroupForm.affinityGroupType.$invalid && formSubmitted}" >
                                <option value="">Select</option>
                            </select>
                            <i tooltip="<fmt:message key="affinityGroup.affinityGroupType.tooltip" bundle="${msg}" />"  class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                            <div class="error-area" data-ng-show="affinityGroupForm.affinityGroupType.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="affinityGroup.affinityGroupType.error" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                        </div>
                    </div>
                </div>
		    </div>
			</div>
		</div>

		<div class="modal-footer">
		    <get-loader-image data-ng-if="showLoader"></get-loader-image>
			<button type="button" data-ng-if="!showLoader" class="btn btn-default " ng-click="cancel()" data-dismiss="modal"><fmt:message key="common.cancel" bundle="${msg}" /></button>
			<button class="btn btn-info"  data-ng-if="!showLoader" type="submit"><fmt:message key="common.add" bundle="${msg}" /></button>
		</div>
	</div>
</form>
