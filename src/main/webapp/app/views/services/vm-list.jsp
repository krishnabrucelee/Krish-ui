<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<form name="addserviceForm" data-ng-controller="servicesCtrl"
	data-ng-submit="attachVMService(addserviceForm,service)" method="post"
	novalidate="">
	<div class="inmodal">
		<div class="modal-header">
			<panda-modal-header page-icon="fa fa-plus-circle"
				page-title="<fmt:message key="add.service" bundle="${msg}" />"></panda-modal-header>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-md-12">

					<div class="form-group">
						<div class="row">
							<label
								class="col-md-4 col-xs-12 col-sm-4 control-label control-normal"><fmt:message
									key="common.virtual.machines" bundle="${msg}" /></label>
							<div class="col-md-6  col-sm-6 col-xs-12">
								<select  class="form-control input-group"
									name="vm" data-ng-model="service"
									ng-options="vm.displayName for vm in instanceList" >
									<option value=""><fmt:message key="common.select"
											bundle="${msg}" /></option>
								</select> <i tooltip="<fmt:message key="common.virtual.machines" bundle="${msg}" /> "
									class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>

							</div>
						</div>
					</div>

				</div>
			</div>
		</div>
		<div class="modal-footer">
			<get-loader-image data-ng-show="showLoader"></get-loader-image>
			<button type="button" data-ng-hide="showLoader"
				class="btn btn-default " ng-click="cancel()" data-dismiss="modal">
				<fmt:message key="common.cancel" bundle="${msg}" />
			</button>
			<button class="btn btn-info" data-ng-hide="showLoader" type="submit">
				<fmt:message key="common.add" bundle="${msg}" />
			</button>
		</div>
	</div>
</form>
