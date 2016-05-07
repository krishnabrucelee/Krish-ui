<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<form name="vpcaddnetworkForm"
	data-ng-submit="saveNetwork(vpcaddnetworkForm, createNetwork)" method="post"
	novalidate="">
	<div class="inmodal">
		<div class="modal-header">
			<panda-modal-header page-icon="fa fa-soundcloud"
				page-title="Add new tier"></panda-modal-header>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-md-12">
					<div class="form-group" ng-class="{'text-danger':vpcaddnetworkForm.net.$invalid && formSubmitted}">
						<div class="row">
							<label class="col-md-4 col-sm-4 control-label">Name<span class="text-danger">*</span></label>
							<div class="col-md-6 col-sm-6">
								<input required="true" type="text" name="net"
									data-ng-model="createNetwork.networkName" class="form-control" data-ng-class="{'error': vpcaddnetworkForm.net.$invalid && formSubmitted}">
								<i tooltip="Network Name"
									class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
									<div class="error-area"
									data-ng-show="vpcaddnetworkForm.net.$invalid && formSubmitted">
									<i
										tooltip="Name is Required"
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
								<select required="true" class="form-control input-group"
									name="networkoffering" data-ng-model="createNetwork.networkOffering"
									ng-options="networkoffering.displayText for networkoffering in networkOfferList"
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
							<label class="col-md-4 col-sm-4 control-label">Gateway<span class="text-danger">*</span></label>
							<div class="col-md-6 col-sm-6">
								<input required="true" type="text" name="gateway"
									data-ng-model="createNetwork.gateway" class="form-control" data-ng-class="{'error': vpcaddnetworkForm.gateway.$invalid && formSubmitted}">
								<i tooltip="Gateway"
									class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
									<div class="error-area"
									data-ng-show="vpcaddnetworkForm.gateway.$invalid && formSubmitted">
									<i
										tooltip="Gateway is Required"
										class="fa fa-warning error-icon"></i>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group" ng-class="{'text-danger':vpcaddnetworkForm.netmask.$invalid && formSubmitted}">
						<div class="row">
							<label class="col-md-4 col-sm-4 control-label">Net Mask<span class="text-danger">*</span></label>
							<div class="col-md-6 col-sm-6">
								<input required="true" type='text' name="netmask"
									data-ng-model="createNetwork.netMask" class="form-control" data-ng-class="{'error': vpcaddnetworkForm.netmask.$invalid && formSubmitted}">
								<i tooltip="Net Mask"
									class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
									<div class="error-area"
									data-ng-show="vpcaddnetworkForm.netmask.$invalid && formSubmitted">
									<i
										tooltip="Net Mask is Required"
										class="fa fa-warning error-icon"></i>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="row">
							<label
								class="col-md-4 col-xs-12 col-sm-4 control-label control-normal">ACL</label>
							<div class="col-md-6  col-sm-6 col-xs-12">
								<select class="form-control input-group" name="acl"
									data-ng-model="createNetwork.acl"
									ng-options="project.name for project in projectList">
									<option value=""><fmt:message key="common.select"
											bundle="${msg}" /></option>
								</select> <i
									tooltip="Choose ACL "
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
