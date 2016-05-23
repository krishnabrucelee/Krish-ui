<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<form name="resetForm" data-ng-submit="resetKey(resetForm, resetSSH)" method="post" novalidate="">

	<div class="inmodal">
		<div class="modal-header">
			<panda-modal-header page-icon="fa fa-plus-circle"
				page-title="<fmt:message key="reset.ssh.key.pair.on.vm" bundle="${msg}" />"></panda-modal-header>
		</div>

		<div class="modal-body">
		<div class="row" >
                    <div class="col-md-12 col-sm-12 pull-left m-b-lg">
                    <label><fmt:message key="note" bundle="${msg}" />:</label>
                     <div><fmt:message key="note.reset.ssh.key" bundle="${msg}" /></div>
                    </div>
            </div>
			<div class="row">
				<div class="col-md-12">
				<div class="form-group" ng-class="{'text-danger':resetForm.keypairName.$invalid && formSubmitted}">
                        <div class="row">
                            <label class="col-md-3 col-xs-12 col-sm-3 control-label control-normal"><fmt:message key="ssh.key.pair" bundle="${msg}" /><span class="text-danger">*</span></label>
                            <div class="col-md-6  col-sm-6 col-xs-12">
                                <select required="true" class="form-control input-group" name="keypairName" data-ng-model="resetSSH.keypairName" ng-options="keypairName.name for keypairName in formElements.sshKeyList" data-ng-class="{'error': resetForm.keypairName.$invalid && formSubmitted}" >
                                    <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>

                                </select>
                                <i  tooltip="<fmt:message key="choose.ssh.key.pair" bundle="${msg}" /> " class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                <div class="error-area" data-ng-show="resetForm.keypairName.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="keypair.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                            </div>
                        </div>
                    </div>
				</div>
			</div>
		</div>

		<div class="modal-footer">
			<get-loader-image data-ng-if="showLoader"></get-loader-image>
			<button type="button" data-ng-if="!showLoader" class="btn btn-default " ng-click="cancel()" data-dismiss="modal"><fmt:message key="common.cancel" bundle="${msg}" /></button>
			<button class="btn btn-info"  data-ng-if="!showLoader" type="submit"><fmt:message key="common.ok" bundle="${msg}" /></button>
		</div>
	</div>
</form>

