<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<form name="applicationForm" data-ng-submit="save(applicationForm, application)" method="post" novalidate="">

	<div class="inmodal">
		<div class="modal-header">
			<panda-modal-header page-icon="fa fa-plus-circle"
				page-title="<fmt:message key="add.application" bundle="${msg}" />"></panda-modal-header>
		</div>

		<div class="modal-body">
			<div class="row">
				<div class="col-md-12">
				<div data-ng-if="global.sessionValues.type != 'ROOT_ADMIN'">
					<div class="form-group">
						<div class="row">
                            <label class="col-md-3 col-xs-12 col-sm-3 control-label control-normal"><fmt:message key="common.domain" bundle="${msg}" /><span class="text-danger">*</span></label>
                            <div class="col-md-6  col-sm-6 col-xs-12">
                                {{ global.sessionValues.domainName }}
                                <input type="hidden" name="domain"  data-ng-model="application.domain" data-ng-init="application.domainId=global.sessionValues.domainId" />
                            </div>
                        </div>
                        </div>
	                </div>
                <div data-ng-if="global.sessionValues.type == 'ROOT_ADMIN'">
				<div class="form-group" ng-class="{'text-danger':applicationForm.domain.$invalid && formSubmitted}">
                        <div class="row">
                            <label class="col-md-3 col-xs-12 col-sm-3 control-label control-normal"><fmt:message key="common.domain" bundle="${msg}" /><span class="text-danger">*</span></label>
                            <div class="col-md-6  col-sm-6 col-xs-12">
                                <select required="true" class="form-control input-group" name="domain" data-ng-model="application.domain" ng-options="domain.name for domain in formElements.domainList" data-ng-class="{'error': applicationForm.domain.$invalid && formSubmitted}" >
                                    <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>

                                </select>
                                <i  tooltip="<fmt:message key="choose.domain" bundle="${msg}" /> " class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                <div class="error-area" data-ng-show="applicationForm.domain.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="domain.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                            </div>
                        </div>
                    </div>
                    </div>
					<div class="form-group" ng-class="{'text-danger': applicationForm.type.$invalid && formSubmitted}">
						<div class="row">
							<label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="common.type" bundle="${msg}" /> <span class="text-danger">*</span></label>
							<div class="col-md-6 col-xs-12 col-sm-6">
								<input required="true" type="text" name="type" data-ng-model="application.type" class="form-control" data-ng-class="{'error': applicationForm.type.$invalid && formSubmitted}">
								<i tooltip="<fmt:message key="type.of.the.application" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
								<div class="error-area" data-ng-show="applicationForm.type.$invalid && formSubmitted">
									<i ng-attr-tooltip="{{ applicationForm.type.errorMessage || '<fmt:message key="application.type.is.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group" ng-class="{'text-danger': applicationForm.description.$invalid && formSubmitted}">
						<div class="row">
							<label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="common.description" bundle="${msg}" /> <span class="text-danger">*</span>
							</label>
							<div class="col-md-6 col-xs-12 col-sm-6">
								<textarea rows="4" required="true" type="text" name="description" data-ng-model="application.description" class="form-control" data-ng-class="{'error': applicationForm.description.$invalid && formSubmitted}"></textarea>
								<i tooltip="<fmt:message key="description.of.the.application" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
								<div class="error-area" data-ng-show="applicationForm.description.$invalid && formSubmitted">
									<i tooltip="<fmt:message key="application.description.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i>
								</div>
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

