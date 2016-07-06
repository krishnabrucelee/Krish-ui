<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<form name="createvpnconnectionForm"
	data-ng-submit="ok(createvpnconnectionForm,vpnconnection)" method="post"
	novalidate="">
<div class="inmodal" data-ng-contoller="vpcCtrl">
    <div class="modal-header">
        <panda-modal-header id="delete_vpc_page_title" hide-zone="false" page-icon="fa fa-check-square" page-title="<fmt:message key="common.create" bundle="${msg}" />"></panda-modal-header>
    </div>
    <div class="modal-body">
        <div class="form-group"
						ng-class="{'text-danger':createvpnconnectionForm.vpngateway.$invalid && formSubmitted}">
						<div class="row">
							<label
								class="col-md-6 col-xs-12 col-sm-4 control-label font-normal"><fmt:message
									key="common.vpn.customer.gateway" bundle="${msg}" /><span class="text-danger">*</span></label>
							<div class="col-md-6  col-sm-6 col-xs-12">
								<select required="true" class="form-control input-group"
									name="vpngateway" data-ng-model="vpnconnection.vpngateway"
									ng-options="vpngateway.name for vpngateway in vpncustomergatewayList"
									data-ng-class="{'error': createvpnconnectionForm.vpngateway.$invalid && formSubmitted}">
									<option value=""><fmt:message key="common.select"
											bundle="${msg}" /></option>
								</select>
								<div class="error-area"
									data-ng-show="createvpnconnectionForm.vpngateway.$invalid && formSubmitted">
									<i
										tooltip="<fmt:message key="vpn.customer.gateway.is.required" bundle="${msg}" />"
										class="fa fa-warning error-icon"></i>
								</div>
							</div>
						</div>
					</div>
					<div class=" row">
            			<div class="form-group  col-md-6 col-xs-12 col-sm-4">
                                 <fmt:message key="common.passive" bundle="${msg}" />
            			</div>
            			<div class="icheckbox_square-green form-group col-md-8 col-sm-8  col-xs-8 m-t-md">
						<input id="restart_vpc_make_redunt" icheck type="checkbox" data-ng-model="vpnconnection.passive">
             </div>
        </div>
    </div>
    <div class="modal-footer">
        <get-loader-image data-ng-show="showLoader"></get-loader-image>
        <button type="button" id="delete_vpc_cancel_button" data-ng-hide="showLoader" class="btn btn-default "  ng-click="cancel()" data-dismiss="modal"><fmt:message key="common.cancel" bundle="${msg}" /></button>
        <button type="submit" id="delete_vpc_ok_button" data-ng-hide="showLoader" class="btn btn-info"  data-dismiss="modal"><fmt:message key="common.ok" bundle="${msg}" /></button>
    </div>
</div>
</form>