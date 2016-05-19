<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div data-ng-if="global.webSocketLoaders.networkLoader" class="overlay-wrapper">
                		            <img data-ng-if="global.webSocketLoaders.networkLoader" src="images/loading-bars.svg" class="inner-loading" />
            		            </div>
<form name="vpcaddnetworkForm"
	data-ng-submit="saveNetwork(vpcaddnetworkForm, vpcCreateNetwork)" method="post"
	novalidate="">
	<div class="inmodal">
		<div class="modal-header">
			<panda-modal-header id="vpc_create_network_page_title" page-icon="fa fa-soundcloud"
				page-title="<fmt:message key="add.new.tier" bundle="${msg}" />"></panda-modal-header>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-md-12">
					<div class="form-group" ng-class="{'text-danger':vpcaddnetworkForm.net.$invalid && formSubmitted}">
						<div class="row">
							<label class="col-md-4 col-sm-4 control-label"><fmt:message key="common.name" bundle="${msg}" /><span class="text-danger">*</span></label>
							<div class="col-md-6 col-sm-6">
								<input required="true" type="text" name="net" id="vpc_create_network_name"
									data-ng-model="vpcCreateNetwork.name" class="form-control" data-ng-class="{'error': vpcaddnetworkForm.net.$invalid && formSubmitted}">
								<i tooltip="<fmt:message key="network.name" bundle="${msg}" />"
									class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
									<div class="error-area"
									data-ng-show="vpcaddnetworkForm.net.$invalid && formSubmitted">
									<i
										tooltip="<fmt:message key="name.is.required" bundle="${msg}" />"
										class="fa fa-warning error-icon"></i>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group"
						ng-class="{'text-danger':vpcaddnetworkForm.networkoffering.$invalid && formSubmitted}">
						<div class="row">
							<label
								class="col-md-4 col-xs-12 col-sm-4 control-label control-normal"><fmt:message
									key="common.networkoffering" bundle="${msg}" /><span
								class="text-danger">*</span></label>
							<div class="col-md-6  col-sm-6 col-xs-12">
								<select required="true" class="form-control input-group" id="vpc_create_network_network_offering"
									name="networkoffering" data-ng-model="vpcCreateNetwork.networkOffering"
									ng-options="networkoffering.name for networkoffering in vpcNetworkOfferList"
									data-ng-class="{'error': vpcaddnetworkForm.networkoffering.$invalid && formSubmitted}">
									<option value=""><fmt:message key="common.select"
											bundle="${msg}" /></option>
								</select> <i
									tooltip="<fmt:message key="choose.networkoffering" bundle="${msg}" /> "
									class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
								<div class="error-area"
									data-ng-show="vpcaddnetworkForm.networkoffering.$invalid && formSubmitted">
									<i
										tooltip="<fmt:message key="networkoffering.is.required" bundle="${msg}" />"
										class="fa fa-warning error-icon"></i>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group" ng-class="{'text-danger':vpcaddnetworkForm.gateway.$invalid && formSubmitted}">
						<div class="row">
							<label class="col-md-4 col-sm-4 control-label"><fmt:message key="gateway" bundle="${msg}" /><span class="text-danger">*</span></label>
							<div class="col-md-6 col-sm-6">
								<input required="true" type="text" name="gateway" id="vpc_create_network_gateway"
									data-ng-model="vpcCreateNetwork.gateway" class="form-control" data-ng-class="{'error': vpcaddnetworkForm.gateway.$invalid && formSubmitted}">
								<i tooltip="<fmt:message key="gateway" bundle="${msg}" />"
									class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
									<div class="error-area"
									data-ng-show="vpcaddnetworkForm.gateway.$invalid && formSubmitted">
									<i
										tooltip="<fmt:message key="gateway.is.required" bundle="${msg}" />"
										class="fa fa-warning error-icon"></i>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group" ng-class="{'text-danger':vpcaddnetworkForm.netmask.$invalid && formSubmitted}">
						<div class="row">
							<label class="col-md-4 col-sm-4 control-label"><fmt:message key="netmask" bundle="${msg}" /><span class="text-danger">*</span></label>
							<div class="col-md-6 col-sm-6">
								<input required="true" type='text' name="netmask" id="vpc_create_network_netmask"
									data-ng-model="vpcCreateNetwork.netMask" class="form-control" data-ng-class="{'error': vpcaddnetworkForm.netmask.$invalid && formSubmitted}">
								<i tooltip="<fmt:message key="netmask" bundle="${msg}" />"
									class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
									<div class="error-area"
									data-ng-show="vpcaddnetworkForm.netmask.$invalid && formSubmitted">
									<i
										tooltip="<fmt:message key="netmask.is.required" bundle="${msg}" />"
										class="fa fa-warning error-icon"></i>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="row">
							<label
								class="col-md-4 col-xs-12 col-sm-4 control-label control-normal"><fmt:message key="acl" bundle="${msg}" /></label>
							<div class="col-md-6  col-sm-6 col-xs-12">
								<select class="form-control input-group" name="acl" id="vpc_create_network_acl"
									data-ng-model="vpcCreateNetwork.acl"
									ng-options="acl.name for acl in aclList">
									<option value=""><fmt:message key="common.select"
											bundle="${msg}" /></option>
								</select> <i
									tooltip="<fmt:message key="choose.acl" bundle="${msg}" />"
									class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>

							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="modal-footer">
			<get-loader-image data-ng-show="showLoader"></get-loader-image>
			<button type="button" data-ng-hide="showLoader" id="vpc_create_network_cancel_button"
				class="btn btn-default " ng-click="cancel()" data-dismiss="modal">
				<fmt:message key="common.cancel" bundle="${msg}" />
			</button>
			<button class="btn btn-info" id="vpc_create_network_add_button" data-ng-hide="showLoader" type="submit">
				<fmt:message key="common.add" bundle="${msg}" />
			</button>
		</div>
	</div>
</form>
