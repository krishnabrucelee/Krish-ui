<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<form name="vpcForm" data-ng-submit="save(vpcForm, vpc)" method="post" novalidate="">

	<div class="inmodal">
		<div class="modal-header">
		    <panda-modal-header page-icon="fa fa-plus-circle" page-title="<fmt:message key="add.new.gateway" bundle="${msg}" />"></panda-modal-header>
		</div>

		<div class="modal-body">
			<div class="row">
				<div class="col-md-12">
				<div class="form-group" ng-class="{'text-danger':vpcForm.physicalNetwork.$invalid && formSubmitted}">
                        <div class="row">
                            <label class="col-md-3 col-xs-12 col-sm-3 control-label control-normal"><fmt:message key="physical.network" bundle="${msg}" /><span class="text-danger">*</span></label>
                            <div class="col-md-6  col-sm-6 col-xs-12">
                                <select required="true" class="form-control input-group" name="physicalNetwork" id = "add_new_gateway_physical_network" data-ng-model="vpc.physicalNetwork" ng-options="domain.name for domain in domainListView" data-ng-class="{'error': vpcForm.physicalNetwork.$invalid && formSubmitted}" >
                                    <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                                </select>
                                <i  tooltip="<fmt:message key="physical.network.message" bundle="${msg}" /> " class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                <div class="error-area" data-ng-show="vpcForm.physicalNetwork.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="physical.network.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                            </div>
                        </div>
                    </div>
					<div class="form-group" ng-class="{'text-danger': vpcForm.vlan.$invalid && formSubmitted}">
						<div class="row">
							<label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="vlan.vni" bundle="${msg}" /> <span class="text-danger">*</span></label>
							<div class="col-md-6 col-xs-12 col-sm-6">
								<input required="true" type="text" name="vlan" id = "add_new_gateway_vlan_vni" data-ng-model="vpc.vlan" class="form-control" data-ng-class="{'error': vpcForm.vlan.$invalid && formSubmitted}">
								<i tooltip="<fmt:message key="vlan.message" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
								<div class="error-area" data-ng-show="vpcForm.vlan.$invalid && formSubmitted">
									<i tooltip="<fmt:message key="vlan.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group" ng-class="{'text-danger': vpcForm.ipAddress.$invalid && formSubmitted}">
						<div class="row">
							<label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="ip.address" bundle="${msg}" /> <span class="text-danger">*</span>
							</label>
							<div class="col-md-6 col-xs-12 col-sm-6">
								<input required="true" type="text" name="ipAddress" id = "add_new_gateway_ip_address" data-ng-model="vpc.ipAddress" class="form-control" data-ng-class="{'error': vpcForm.ipAddress.$invalid && formSubmitted}">
								<i tooltip="<fmt:message key="ipaddress.message" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
								<div class="error-area" data-ng-show="vpcForm.ipAddress.$invalid && formSubmitted">
									<i tooltip="<fmt:message key="ipaddress.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group" ng-class="{'text-danger': vpcForm.gateway.$invalid && formSubmitted}">
						<div class="row">
							<label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="gateway" bundle="${msg}" /> <span class="text-danger">*</span>
							</label>
							<div class="col-md-6 col-xs-12 col-sm-6">
								<input required="true" type="text" name="gateway" id = "add_new_gateway_gateway" data-ng-model="vpc.gateway" class="form-control" data-ng-class="{'error': vpcForm.gateway.$invalid && formSubmitted}">
								<i tooltip="<fmt:message key="gateway.message" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
								<div class="error-area" data-ng-show="vpcForm.gateway.$invalid && formSubmitted">
									<i tooltip="<fmt:message key="gateway.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group" ng-class="{'text-danger': vpcForm.netmask.$invalid && formSubmitted}">
						<div class="row">
							<label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="netmask" bundle="${msg}" /> <span class="text-danger">*</span>
							</label>
							<div class="col-md-6 col-xs-12 col-sm-6">
								<input required="true" type="text" name="netmask" id = "add_new_gateway_netmask" data-ng-model="vpc.netmask" class="form-control" data-ng-class="{'error': vpcForm.netmask.$invalid && formSubmitted}">
								<i tooltip="<fmt:message key="netmask.message" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
								<div class="error-area" data-ng-show="vpcForm.netmask.$invalid && formSubmitted">
									<i tooltip="<fmt:message key="netmask.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="row">
							<label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="source.nat" bundle="${msg}" />
							</label>
							<div class="col-md-6 col-xs-12 col-sm-6">
								<label> <input icheck data-ng-model="vpc.sourceNat" id="add_new_gateway_source_nat"	name="sourceNat" type="checkbox" /> </label>
								<i  tooltip="<fmt:message key="select.source.nat" bundle="${msg}" /> " class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
							</div>
						</div>
					</div>
					<div class="form-group">
                        <div class="row">
                            <label class="col-md-3 col-xs-12 col-sm-3 control-label control-normal"><fmt:message key="acl" bundle="${msg}" /></label>
                            <div class="col-md-6  col-sm-6 col-xs-12">
                                <select class="form-control input-group" name="acl" id = "add_new_gateway_acl" data-ng-model="vpc.acl" ng-options="domain.name for domain in domainListView" >
                                    <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                                </select>
                                <i  tooltip="<fmt:message key="choose.acl" bundle="${msg}" /> " class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                            </div>
                        </div>
                    </div>
				</div>
			</div>
		</div>

		<div class="modal-footer">
			<get-loader-image data-ng-if="showLoader"></get-loader-image>
			<button type="button" data-ng-if="!showLoader" class="btn btn-default " id = "add_new_gateway_cancel_button" ng-click="cancel()" data-dismiss="modal"><fmt:message key="common.cancel" bundle="${msg}" /></button>
			<button class="btn btn-info"  data-ng-if="!showLoader" id = "add_new_gateway_add_button" type="submit"><fmt:message key="common.add" bundle="${msg}" /></button>
		</div>
	</div>
</form>